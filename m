Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA08414
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 11:38:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA21848
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 16:36:35 GMT
Received: from pandora.snu.edu ([204.126.2.1])
	by jazzswing.ncsc.mil  with SMTP id QAA21844
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 16:36:33 GMT
Message-Id: <sdec8990.046@atlas.snu.edu>
Date: Tue, 03 Dec 2002 10:37:48 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Subject: Re: automake
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well, my distro will need the selinux-small archive _with_ the configure
system to compile correctly (obviously the ad hoc makefiles on the nsa
version won't do the job) so where will i get these from? or should i
just generate a patch and use it in conjunction with the nsa
distribution? IMO this really needs to be merged upstream, but if not
something needs to be done to make them available.

Joshua Brindle
UNIX Administrator
Southern Nazarene University

>>> "Stephen D. Smalley" <sds@epoch.ncsc.mil> 12/02/02 10:01AM >>>

> Are the patches to use automake with selinux going to be merged into
the
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
This message was distributed to subscribers of the selinux mailing
list.
If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
