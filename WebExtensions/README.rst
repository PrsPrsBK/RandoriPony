============================================================
Native massaging with Firefox WebExtensions.
============================================================

* `Native messaging - Mozilla | MDN <https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_messaging>`__

------------------------------------------------------------
Some Notes
------------------------------------------------------------

* receive via stdin, send via stdout.
* Maximum size sended from WebExtensions: 4GiB
* Maximum size sended from native app: 1MiB

* (sended/received) Message's initial 4B is the length of message,
  and on Windows, it is little endian.

* On Windows, Native app's process spawned as Job.
  `Job Objects - Windows applications | Microsoft Docs <https://docs.microsoft.com/ja-jp/windows/desktop/ProcThread/job-objects>`__

* `Output buffering with pipes on Windows · Issue #3095 · ponylang/ponyc <https://github.com/ponylang/ponyc/issues/3095>`__
  Maybe this issue requires 4KiB payload (and extra ``write``) for output flush.

Native app side
============================================================


* `Native manifests - Mozilla | MDN <https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_manifests>`__
  app's manifest needs to specify followings.

  * "name": "the app's name registered in Windows Registry",
  * "path": "path/to/app",
  * "type": "stdio",
  * "allowed_extensions": [ "WebExtensions' id" ]

* Windows Registry
  For global, set ``HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\NativeMessagingHosts\<name>`` to ``path\to\manifest``.
  For current user, set ``HKEY_CURRENT_USER\SOFTWARE\Mozilla\NativeMessagingHosts\<name>``.


WebExtensions side
============================================================

* ``browser.runtime.connectNative()``
  argment is ``name`` property specified within native app's json.
* If native app has not yet been run, this connection will lead app to run.
  and connectNative() returns ``Port`` object.
* ``Port.disconnect()`` close app.
* For connectionless (one-shot) messaging, you can use ``runtime.sendNativeMessage()``.

