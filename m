Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3NN5XZ019546
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 18:23:05 -0500 (EST)
Received: from d10systems.homelinux.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3NLh4w024895
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 23:21:43 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by d10systems.homelinux.com (Postfix) with ESMTP id C216D36EC6
	for <selinux@tycho.nsa.gov>; Wed,  3 Nov 2004 19:21:27 +0000 (UTC)
Date: Wed, 3 Nov 2004 19:21:27 +0000 (UTC)
From: Dhruv Gami <dgami@uncc.edu>
Reply-To: dgami@uncc.edu
To: selinux@tycho.nsa.gov
Subject: Re: Updated SELinux Release
In-Reply-To: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Nov 2004, Stephen Smalley wrote:

> 2) I'd like to do away with the complete prepatched kernel tarball and
> full userland tarball, and only distribute a kernel patch and the
> individual component tarballs for checkpolicy, libsepol, libselinux,
> policycoreutils, etc.  The prepatched kernel tarball doesn't seem very
> useful to me, as most people likely want to combine the SELinux kernel
> patch with other patches and prebuilt kernel packages with SELinux
> support are available for the various distros now.  The full userland
> tarball seems redundant to me, and packagers of SELinux are using the
> individual component tarballs anyway.  Any objections to dropping these
> two tarballs?

Personally, i would prefer to have those two tarballs available. I know 
most people using SELinux are familiar with patching the kernel, and are 
generally familiar with how Linux works and know their way around on a 
Linux system. 

I have met a number of people who have wanted to try out SELinux, or even 
Linux in general, but don't have either the expertise, or the time to 
learn how to get those tasks of patching and recompiling done. For a 
newbie, sometimes the sheer massiveness of the power available to him on a 
linux system is overwhelming enough. My point is that a number of newbies 
might get discouraged to even try out SELinux if they're unable to figure 
out how to download and patch their system. Most distributions don't 
install the kernel source code by default, and if its a newbie, im 
assuming he/she installed linux with the default options. He might not be 
aware of everything, but if he wants to try out something like SELinux 
that could make his system more secure, and if a single tarball is 
available to him, he can simply download that, compile it and be up and 
running with a SELinux system. 

I agree with Stephen that having the tarballs would be redundant as most 
of us prefer to get individual patches and patch our kernels, but I'm just 
thinking of the whole situation from a newbie's point of view. Old users 
sometimes don't realise it, but it can get intriguing for someone just 
starting out. Having something simple to use can be very helpful.

just my 2 cents.

regards,
Gami
-- 
Dhruv Gami
http://d10systems.com/gami


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
