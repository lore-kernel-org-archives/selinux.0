Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24966
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 17:52:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA19637
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 22:50:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id WAA19633
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 22:50:47 GMT
Message-Id: <200211202300.SAA17633@moss-shockers.ncsc.mil>
Date: Wed, 20 Nov 2002 18:00:15 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: conflicting header files
To: bam@snoopy.apana.org.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> However, when compiling checkpolicy,
> lsm-2.4/security/selinux/include/linux/flask/ss/global.h is included
> (command line parameter), which also includes linux/flask/security.h,
> 
> Is checkpolicy considered a special case?

Yes.  Notice that checkpolicy is compiled from the same core sources
as the in-kernel security server with the addition of the parser
and scanner for the policy compiler.  It doesn't use libsecure in
any way.  In addition to compiling the policy, checkpolicy allows
you to exercise a userspace copy of the security server functions
with a particular policy.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
