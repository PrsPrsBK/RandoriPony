const port = browser.runtime.connectNative('pony_side');

port.onMessage.addListener(response => {
  console.log(`from pony: ${response}`);
});

browser.browserAction.onClicked.addListener(() => {
  browser.tabs.query({ currentWindow: true, active: true }).then(tabs => {
    for(const tab of tabs) {
      let date = new Date();
      console.log(`lets send ${date.toLocaleDateString()}-${date.toLocaleTimeString()} ${tab.url}`);
      port.postMessage(`${date.toLocaleDateString()}-${date.toLocaleTimeString()} ${tab.url}`);
    }
  });
});
