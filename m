Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9P4kIWt018501
	for <selinux@tycho.nsa.gov>; Sat, 25 Oct 2003 00:46:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9P4k5IS023570
	for <selinux@tycho.nsa.gov>; Sat, 25 Oct 2003 04:46:05 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
	by jazzswing.ncsc.mil  with ESMTP id h9P4k3Dc023567
	for <selinux@tycho.nsa.gov>; Sat, 25 Oct 2003 04:46:04 GMT
Date: Sat, 25 Oct 2003 13:44:59 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: dwalsh@redhat.com, selinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp
Subject: question about pam_selinux multiple option
Message-Id: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


When I saw the man page of pam_selinux, 
there is a option "multiple". I think it is convenient.
However, in pam-selinux.patch, the code about "multiple" is commented out,like this.
+    /*    if (strcmp(argv[i], "multiple") == 0) {
+      multiple = 1;
+      }*/
When I enabled it, the "multiple" option seemed to work.
Why is it commented out ? 
Will "multiple" option be enabled in the future?

Thank you.

---------
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
