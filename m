Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MFotNs023956
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 11:50:55 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MFlcK1028992
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 15:47:38 GMT
Subject: Re: run_init: Fork:: No such file or directory
From: Antoine Martin <antoine@nagafix.co.uk>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1129992947.26999.10.camel@gorn.pebenito.net>
References: <1129985971.31615.31.camel@localhost.localdomain>
	 <1129992947.26999.10.camel@gorn.pebenito.net>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 16:47:35 +0100
Message-Id: <1129996055.31615.59.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 10:55 -0400, Chris PeBenito wrote:
> On Sat, 2005-10-22 at 13:59 +0100, Antoine Martin wrote:
> > I've been running a system with SELinux enforcing mode for some time
> > (Gentoo x86), but since yesterday I can't seem to use run_init to start
> > daemons, it fails with:
> > Fork:: No such file or directory
> 
> This problem should be fixed.  As far as I know, the pty/idr_remove
> problem was only being caused in modules in selinux-base-policy, so make
> sure you're at least on selinux-base-policy-20050821.
Yes:
      Latest version installed: 20050821

(as mentioned in another mail, I fixed by rebooting and relabeling)

Thanks
Antoine

> 
> More details:
> 
> http://marc.theaimsgroup.com/?l=selinux&m=112419712132326&w=2
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
