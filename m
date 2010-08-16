Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7GHRwGI000839
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2010 13:27:58 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7GHRnTq026170
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2010 17:27:49 GMT
Received: by bwz18 with SMTP id 18so1742849bwz.12
        for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2010 10:27:55 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 16 Aug 2010 10:27:55 -0700
Message-ID: <AANLkTimXzCXhXRM=y91=5WrpgedkYzzCMTnf5f-cwPs-@mail.gmail.com>
Subject: SELinux xace crash with xfce4: Caught signal 11 (Segmentation fault).
 Server aborting
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, xorg@freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,
I'm in the process of building a new system from scratch, and am
noticing a crash when I have SELinux enabled(permissive)  with the
xserver_object_manager 1 boolean set to on(if I set this boolean to
off  I can login etc.. to my xfce4 session and all is good)

Backtrace:
[    21.374] 0: /usr/bin/X (xorg_backtrace+0x26) [0x49e416]
[    21.374] 1: /usr/bin/X (0x400000+0x60e99) [0x460e99]
[    21.374] 2: /lib/libpthread.so.0 (0x7f0394a30000+0xfa50) [0x7f0394a3fa50]
[    21.374] 3: /usr/lib/xorg/modules/extensions/libextmod.so
(0x7f039286c000+0x1d090) [0x7f0392889090]
[    21.374] 4: /usr/lib/xorg/modules/extensions/libextmod.so
(0x7f039286c000+0x1b971) [0x7f0392887971]
[    21.374] 5: /usr/bin/X (CallCallbacks+0x4c) [0x432e4c]
[    21.374] 6: /usr/bin/X (XaceHookPropertyAccess+0x31) [0x4b8831]
[    21.374] 7: /usr/bin/X (dixChangeWindowProperty+0x3a4) [0x49b5c4]
[    21.374] 8: /usr/lib/xorg/modules/extensions/libextmod.so
(0x7f039286c000+0x1b677) [0x7f0392887677]
[    21.374] 9: /usr/bin/X (CallCallbacks+0x4c) [0x432e4c]
[    21.374] 10: /usr/bin/X (AddResource+0xf8) [0x44ac98]
[    21.374] 11: /usr/bin/X (CreateRootWindow+0x3cb) [0x451b6b]
[    21.374] 12: /usr/bin/X (0x400000+0x227c4) [0x4227c4]
[    21.374] 13: /lib/libc.so.6 (__libc_start_main+0xed) [0x7f0392ee065d]
[    21.374] 14: /usr/bin/X (0x400000+0x224a1) [0x4224a1]
[    21.374] Segmentation fault at address (nil)
[    21.374]
Fatal server error:
[    21.374] Caught signal 11 (Segmentation fault). Server aborting
[    21.374]
[    21.374]
Please consult the The X.Org Foundation support
	 at http://wiki.x.org
 for help.
[    21.374] Please also check the log file at "/var/log/Xorg.0.log"
for additional information.
[    21.374]

keep in mind I'm still in the process of building xfce4(thunar
gio/gvfs) so there might be things here and there that I might of
forgotten todo that might be causing this.

any ideas?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
