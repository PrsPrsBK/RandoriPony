const port = browser.runtime.connectNative('pony_side');

port.onMessage.addListener(response => {
  console.log(`from pony: ${response.length} ${response}`);
});

browser.browserAction.onClicked.addListener(() => {
  browser.tabs.query({ currentWindow: true, active: true }).then(tabs => {
    for(const tab of tabs) {
      const date = new Date();
      const message = `${date.toLocaleDateString()}-${date.toLocaleTimeString()} ${tab.url}`;
      console.log(`lets send ${message}`);
      port.postMessage(`${message}`);
    }
  });
});
