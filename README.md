# Medium Editor

An Elm package providing rich-text editing in web browsers. It is an Elm wrapper
around [yabwe/medium-editor v5.22.1](github.com/yabwe/medium-editor) which is
itself a Javascript clone of Medium.com's editor.

The editor widget uses `contenteditable` `div` elements, and produces relatively
same HTML output.

## Example Usage
```elm
import MediumEditor

editor = MediumEditor.editor
  { toolbar: Nothing }
  [ MediumEditor.placeholder "Editable!" ]
  "<p>Initial content</p>"
```
