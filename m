Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h38EBmI4021112
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 10:11:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h38EBlxH027817
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 14:11:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h38EBlDl027814 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 14:11:47 GMT
Subject: Re: Updated Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <1049748415.23420.6.camel@moss-sooners.epoch.ncsc.mil>
References: <1049748415.23420.6.camel@moss-sooners.epoch.ncsc.mil>
Content-Type: text/plain
Date: 08 Apr 2003 10:11:57 -0400
Message-Id: <1049811118.1085.3.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-04-07 at 16:46, Howard Holm wrote:
> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The example policy has been updated with
> enhancements and cleanups.  A number of bugs have been fixed in the
> SELinux module.  The updated module is available for the ia32 2.4.20
> Linux kernel.   The updated module is also available for both the
> mainline 2.5.66 Linux kernel and an LSM patched 2.5.66 Linux kernel. 
> The new mainline module also includes work in preparation for a new
> SELinux API.  Finally, a port of SELinux to the arm 2.4.19 kernel is
> also now available.

The updated release (2003040709) has been imported and merged into
the sourceforge selinux CVS tree under the 'nsa' module.  As usual,
you can check out a copy via:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

I have not imported the new 2.5 mainline-based SELinux or the ARM port
into the sourceforge CVS tree at present, although I can do so if there
is a demand for it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
