Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83DcvrT007355
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 09:38:57 -0400 (EDT)
Received: from mbox-o00.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83DcsUQ019439
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 13:38:56 GMT
Message-Id: <200409031338.i83DccKp019984@mms-r01.iijmio.jp>
Date: Fri, 03 Sep 2004 09:38:32 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: reiferfs in SUSE9.1
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Some people in Japan(including me) say that they can not use reiserfs in SUSE9.1(selinux enabled).

In fs_use, we added the following.
fs_use_xattr reiserfs system_u:object_r:fs_t.

System boot succeeds but hangs up in init scripts.
# I forget correct place,sorry because I do not have the environment now...

We can use SELinux in SUSE9.1 with ext3 filesystem.

Does anyone use reiserfs in SUSE9.1?

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
http://www.selinux.gr.jp/
The George Washington University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
