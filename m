Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA16437
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 13:02:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA12192
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 17:59:44 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-156.nas-smoothtransition.com [66.95.157.156] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id RAA12188
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 17:59:44 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: SELinux question?
Date: Tue, 4 Feb 2003 11:51:57 -0500
Message-ID: <000401c2cc6d$be4aa620$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E3F72AE.1070503@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Why are certain applications (ls, cp, cd) ported to use SELinux 
> with the standard names, while others
> (spasswd, schfn) have a prefix added?

Look in selinux/utils/spasswd/README in the source distribution for an
explanation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
