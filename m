Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28315
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 09:38:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26158
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 14:36:06 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-159.nas-smoothtransition.com [66.95.157.159] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA26154
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 14:36:06 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Subject: RE: login (new default_contexts, run-time detection)
Date: Thu, 21 Nov 2002 09:37:44 -0500
Message-ID: <000b01c2916b$9086b270$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200211211425.JAA18087@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Of course, if 
> you upgrade an older version to the current version, you'll 
> have both files in /etc/security but only the new one will be used.

Exactly.  I fully expect that upgrades will leave both around (exactly
the problem I had on my system).  Also, I gathered from your description

that /etc/security/default_contexts is optional and might not even
be there.  

I'd like a more reliable method, e.g., making some sys call, that would
be a definitive hint. Any other ideas?  Thanks  Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
