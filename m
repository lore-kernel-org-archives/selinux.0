Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA7GVvMA024659
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 11:31:57 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA7GPteE008216
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 16:25:57 GMT
Message-Id: <200511071625.jA7GPqYs014058@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: "James Carter" <jwcart2@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Cc: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: seuser policy
Date: Mon, 7 Nov 2005 11:25:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Given that seuser is no longer being supported as part of the setools
package, it might be a good idea to remove the relevant files in the
upstream NSA policy.

Domains/program/unused/seuser.te
File_contexts/program/seuser.fc

Kevin Carr
Tresys Technology
410.290.1411 x137




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
