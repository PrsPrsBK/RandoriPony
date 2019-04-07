const port = browser.runtime.connectNative('pony_side');

port.onMessage.addListener(response => {
  console.log(`from pony: ${response}`);
});

browser.browserAction.onClicked.addListener(() => {
  browser.tabs.query({ currentWindow: true, active: true }).then(tabs => {
    for(const tab of tabs) {
      port.postMessage(tab.url);
    }
  });
});
