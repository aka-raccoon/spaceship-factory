{ lib, ... }:

{
  generateSubLayerVariableName = key: "hyper_sublayer_${key}";

  open = what: {
    to = lib.mapAttrsToList (w: { shell_command = "open ${w}"; }) what;
    description = "Open ${lib.concatStringsSep " & " what}";
  };

  shell = strings: values: {
    to = lib.mapAttrsToList (command: { shell_command = command; }) (
      lib.filter (line: line != "") (
        lib.splitString "\n" (
          lib.concatStringsSep "" (lib.zipWith (a: b: "${a}${b}") strings (values ++ [ "" ]))
        )
      )
    );
    description = lib.concatStringsSep " && " (
      lib.filter (line: line != "") (
        lib.splitString "\n" (
          lib.concatStringsSep "" (lib.zipWith (a: b: "${a}${b}") strings (values ++ [ "" ]))
        )
      )
    );
  };

  rectangle = name: {
    to = [ { shell_command = "open -g rectangle://execute-action?name=${name}"; } ];
    description = "Window: ${name}";
  };

  app = name: {
    to = [ { shell_command = "open -a '${name}.app'"; } ];
    description = "Open ${name}";
  };

  createHyperSubLayer =
    sublayer_key: commands: allSubLayerVariables:
    let
      subLayerVariableName = "hyper_sublayer_${sublayer_key}";
    in
    [
      {
        description = "Toggle Hyper sublayer ${sublayer_key}";
        type = "basic";
        from = {
          key_code = sublayer_key;
          modifiers = {
            optional = [ "any" ];
          };
        };
        to_after_key_up = [
          {
            set_variable = {
              name = subLayerVariableName;
              value = 0;
            };
          }
        ];
        to = [
          {
            set_variable = {
              name = subLayerVariableName;
              value = 1;
            };
          }
        ];
        conditions =
          lib.concatMap (subLayerVariable: [
            {
              type = "variable_if";
              name = subLayerVariable;
              value = 0;
            }
          ]) (lib.filter (subLayerVariable: subLayerVariable != subLayerVariableName) allSubLayerVariables)
          ++ [
            {
              type = "variable_if";
              name = "hyper";
              value = 1;
            }
          ];
      }
    ]
    ++ lib.mapAttrsToList (command_key: {
      inherit (commands.${command_key}) to description;
      type = "basic";
      from = {
        key_code = command_key;
        modifiers = {
          optional = [ "any" ];
        };
      };
      conditions = [
        {
          type = "variable_if";
          name = subLayerVariableName;
          value = 1;
        }
      ];
    }) commands;

  createHyperSubLayers =
    subLayers:
    let
      allSubLayerVariables = lib.mapAttrsToList (
        sublayer_key: "hyper_sublayer_${sublayer_key}"
      ) subLayers;
    in
    lib.mapAttrsToList (
      key: value:
      if value ? to then
        {
          description = "Hyper Key + ${key}";
          manipulators = [
            {
              inherit (value) to description;
              type = "basic";
              from = {
                key_code = key;
                modifiers = {
                  optional = [ "any" ];
                };
              };
              conditions =
                [
                  {
                    type = "variable_if";
                    name = "hyper";
                    value = 1;
                  }
                ]
                ++ lib.mapAttrsToList (subLayerVariable: {
                  type = "variable_if";
                  name = subLayerVariable;
                  value = 0;
                }) allSubLayerVariables;
            }
          ];
        }
      else
        {
          description = "Hyper Key sublayer \"${key}\"";
          manipulators = createHyperSubLayer key value allSubLayerVariables;
        }
    ) subLayers;
}
