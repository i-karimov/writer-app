// Entry point for the build script in your package.json
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";

import "bootstrap/js/dist/dropdown";
import "trix";
import "@rails/actiontext";

Rails.start();
Turbolinks.start();

const replaceLastChar = (str, newChar) => {
  if (str.length === 0) return newChar; // Handle empty string case
  return str.slice(0, -1) + newChar;
};

document.addEventListener("trix-change", function (event) {
  const content = event.target.trixInput.value;
  const reversedContent = content.split("").reverse().join("");

  const lastChar = content.charAt(content.length - 1);
  console.log(event);
  console.log("last char: ");
  console.log(lastChar);
  
  if (lastChar === '"') {
    console.log('last char is "')
    const foundOpeningBracket = reversedContent.find((el) => el == "«");

    const replacementChar = foundOpeningBracket ? "»" : "«";
    const updatedContent = replaceLastChar(content, replacementChar);
    event.target.innerText = updatedContent;
  }
});
