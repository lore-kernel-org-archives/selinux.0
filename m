Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0TDruRb011615
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 08:53:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0TDrt1I013145
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 13:53:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0TDrtbs013142 for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 13:53:55 GMT
Subject: Re: Compiling a 2.6 UML kernel
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ignacio Tripodi <ignaciot@unt.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D578F80A-5212-11D8-9EEB-000393013D1A@unt.edu>
References: <D578F80A-5212-11D8-9EEB-000393013D1A@unt.edu>
Content-Type: text/plain
Message-Id: <1075384433.21044.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 08:53:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 23:23, Ignacio Tripodi wrote:
> I'm trying to compile a 2.6 kernel with User Mode Linux support, using 
> the latest 2.6 available on the website (linux-2.6-2003120509.tgz). 
> After selecting the modules I need ("make menuconfig ARCH=um"), this is 
> the error I get when I do a "make ARCH=um":

I'd recommend using 2.6.2-rc2 from kernel.org, or the rawhide kernel. 
It contains the latest SELinux code, and may have resolved the UML build
issue (but I don't know, as I don't use UML myself).
You will then need a more up-to-date policy, either from the sourceforge
CVS tree or from Dan Walsh's packages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
