Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h33Linx6002847
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 16:44:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h33LfBOv019511
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:41:11 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h33LfBY1019508
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:41:11 GMT
Message-Id: <200304032152.QAA06093@moss-shockers.ncsc.mil>
Date: Thu, 3 Apr 2003 16:52:29 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: usermod/group* patch
To: selinux@tycho.nsa.gov, dac@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Attached is a patch which adds the usermod utility and the corresponding set
> of group utilities to the spasswd wrapper utility set.  The patch changes
> the Makefile for .../selinux/utils/spasswd and adds a set of policy files
> (groupadd.te,fc) for the group utilities.
> 
> The .../selinux/utils/spasswd/Makefile patch creates s-wrappers for usermod,
> groupadd, groupdel, groupmod, and gpasswd.  These are all similar to
> suseradd, suserdel, etc.
> 
> The groupadd.te,fc policy used the useradd.te policy as a base. Some rules
> and permissions were trimmed out and some dontaudit rules were added.
> 
> I generated the patch against the latest cvs version of selinux.

Thanks, I've merged this into our internal tree, and it will be included
in the next release.

--
Stephen Smalley, NSA



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
