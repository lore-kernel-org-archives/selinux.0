Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA19404
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 07:57:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA16534
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 12:55:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id MAA16530
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 12:55:13 GMT
Message-Id: <200211201304.IAA16966@moss-shockers.ncsc.mil>
Date: Wed, 20 Nov 2002 08:04:26 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: conflicting header files
To: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> In lsm-2.4/security/selinux/include/linux/flask/security.h, it has:

These are the internal kernel interfaces to the security server.
Application code shouldn't be including this file.

> In selinux-small-2002102211/libsecure/include/ss.h, it has:

These are the application interfaces to the security server.

> I am guessing for now that one function is a internal function in the
> kernel, and the other function is one defined in libsecure.a for
> external use. Am I correct?

Yes.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
