{
  lib,
  ...
}:
let
  utils = import ./utils.nix { inherit lib; };

  rules =
    [
      {
        description = "Hyper Key (⌃⌥⇧⌘)";
        manipulators = [
          {
            description = "Caps Lock -> Hyper Key";
            from = {
              key_code = "caps_lock";
            };
            to = [
              {
                set_variable = {
                  name = "hyper";
                  value = 1;
                };
              }
            ];
            to_after_key_up = [
              {
                set_variable = {
                  name = "hyper";
                  value = 0;
                };
              }
            ];
            to_if_alone = [ { key_code = "escape"; } ];
            type = "basic";
          }
        ];
      }
    ]
    ++ utils.createHyperSubLayers {
      spacebar = utils.open [ "raycast://extensions/stellate/mxstbr-commands/create-notion-todo" ];
      b = {
        t = utils.open [ "https://twitter.com" ];
        p = utils.open [ "https://mxstbr.com/cal" ];
        y = utils.open [ "https://news.ycombinator.com" ];
        f = utils.open [ "https://facebook.com" ];
        r = utils.open [ "https://reddit.com" ];
        h = utils.open [ "https://hashnode.com/draft" ];
      };
      o = {
        "1" = utils.app "1Password";
        g = utils.app "Google Chrome";
        c = utils.app "Notion Calendar";
        v = utils.app "Zed";
        d = utils.app "Discord";
        s = utils.app "Slack";
        e = utils.app "Superhuman";
        n = utils.app "Notion";
        t = utils.app "Terminal";
        h = utils.open [ "notion://www.notion.so/stellatehq/7b33b924746647499d906c55f89d5026" ];
        z = utils.app "zoom.us";
        m = utils.app "Reflect";
        r = utils.app "Reflect";
        f = utils.app "Finder";
        i = utils.app "Texts";
        p = utils.app "Spotify";
        a = utils.app "iA Presenter";
        w = utils.open [ "Texts" ];
        l = utils.open [ "raycast://extensions/stellate/mxstbr-commands/open-mxs-is-shortlink" ];
      };
      w = {
        semicolon = {
          description = "Window: Hide";
          to = [
            {
              key_code = "h";
              modifiers = [ "right_command" ];
            }
          ];
        };
        y = utils.rectangle "previous-display";
        o = utils.rectangle "next-display";
        k = utils.rectangle "top-half";
        j = utils.rectangle "bottom-half";
        h = utils.rectangle "left-half";
        l = utils.rectangle "right-half";
        f = utils.rectangle "maximize";
        u = {
          description = "Window: Previous Tab";
          to = [
            {
              key_code = "tab";
              modifiers = [
                "right_control"
                "right_shift"
              ];
            }
          ];
        };
        i = {
          description = "Window: Next Tab";
          to = [
            {
              key_code = "tab";
              modifiers = [ "right_control" ];
            }
          ];
        };
        n = {
          description = "Window: Next Window";
          to = [
            {
              key_code = "grave_accent_and_tilde";
              modifiers = [ "right_command" ];
            }
          ];
        };
        b = {
          description = "Window: Back";
          to = [
            {
              key_code = "open_bracket";
              modifiers = [ "right_command" ];
            }
          ];
        };
        m = {
          description = "Window: Forward";
          to = [
            {
              key_code = "close_bracket";
              modifiers = [ "right_command" ];
            }
          ];
        };
      };
      s = {
        u = {
          to = [ { key_code = "volume_increment"; } ];
        };
        j = {
          to = [ { key_code = "volume_decrement"; } ];
        };
        i = {
          to = [ { key_code = "display_brightness_increment"; } ];
        };
        k = {
          to = [ { key_code = "display_brightness_decrement"; } ];
        };
        l = {
          to = [
            {
              key_code = "q";
              modifiers = [
                "right_control"
                "right_command"
              ];
            }
          ];
        };
        p = {
          to = [ { key_code = "play_or_pause"; } ];
        };
        semicolon = {
          to = [ { key_code = "fastforward"; } ];
        };
        e = utils.open [ "raycast://extensions/thomas/elgato-key-light/toggle?launchType=background" ];
        d = utils.open [ "raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background" ];
        t = utils.open [ "raycast://extensions/raycast/system/toggle-system-appearance" ];
        c = utils.open [ "raycast://extensions/raycast/system/open-camera" ];
        v = {
          to = [
            {
              key_code = "spacebar";
              modifiers = [ "left_option" ];
            }
          ];
        };
      };
      v = {
        h = {
          to = [ { key_code = "left_arrow"; } ];
        };
        j = {
          to = [ { key_code = "down_arrow"; } ];
        };
        k = {
          to = [ { key_code = "up_arrow"; } ];
        };
        l = {
          to = [ { key_code = "right_arrow"; } ];
        };
        m = {
          to = [
            {
              key_code = "f";
              modifiers = [ "right_control" ];
            }
          ];
        };
        s = {
          to = [
            {
              key_code = "j";
              modifiers = [ "right_control" ];
            }
          ];
        };
        d = {
          to = [
            {
              key_code = "d";
              modifiers = [
                "right_shift"
                "right_command"
              ];
            }
          ];
        };
        u = {
          to = [ { key_code = "page_down"; } ];
        };
        i = {
          to = [ { key_code = "page_up"; } ];
        };
      };
      c = {
        p = {
          to = [ { key_code = "play_or_pause"; } ];
        };
        n = {
          to = [ { key_code = "fastforward"; } ];
        };
        b = {
          to = [ { key_code = "rewind"; } ];
        };
      };
      r = {
        c = utils.open [ "raycast://extensions/thomas/color-picker/pick-color" ];
        n = utils.open [ "raycast://script-commands/dismiss-notifications" ];
        l = utils.open [ "raycast://extensions/stellate/mxstbr-commands/create-mxs-is-shortlink" ];
        e = utils.open [ "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols" ];
        p = utils.open [ "raycast://extensions/raycast/raycast/confetti" ];
        a = utils.open [ "raycast://extensions/raycast/raycast-ai/ai-chat" ];
        s = utils.open [ "raycast://extensions/peduarte/silent-mention/index" ];
        h = utils.open [ "raycast://extensions/raycast/clipboard-history/clipboard-history" ];
        "1" = utils.open [ "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1" ];
        "2" = utils.open [ "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2" ];
      };
    }
    ++ [
      {
        description = "Change Backspace to Spacebar when Minecraft is focused";
        manipulators = [
          {
            type = "basic";
            from = {
              key_code = "delete_or_backspace";
            };
            to = [ { key_code = "spacebar"; } ];
            conditions = [
              {
                type = "frontmost_application_if";
                file_paths = [
                  "^/Users/mxstbr/Library/Application Support/minecraft/runtime/java-runtime-gamma/mac-os-arm64/java-runtime-gamma/jre.bundle/Contents/Home/bin/java$"
                ];
              }
            ];
          }
        ];
      }
    ];

in
rules
