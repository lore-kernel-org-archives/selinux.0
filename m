Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00638
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 10:54:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA15284
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 15:51:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA15278
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 15:51:57 GMT
Message-Id: <200212021601.LAA25250@moss-shockers.ncsc.mil>
Date: Mon, 2 Dec 2002 11:01:33 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: automake
To: selinux@tycho.nsa.gov, JBrindle@snu.edu
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Are the patches to use automake with selinux going to be merged into the
> selinux distribution on sourceforge? 

If you are referring to the CVS repository at sourceforge, it mirrors
the public releases of SELinux from the NSA site.  I wouldn't expect
the automake changes to be merged upstream in their current form,
since as far as I know, they only address selinux-small (not the full
set of SELinux-patched utilities and daemons) and are dependent on
the installation locations used by the Debian selinux package.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
