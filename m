Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4ESAXZ023201
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 09:28:12 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4EQmCH019940
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 14:26:48 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: dgami@uncc.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
Content-Type: text/plain
Message-Id: <1099578261.3174.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 09:24:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 14:21, Dhruv Gami wrote:
> He might not be 
> aware of everything, but if he wants to try out something like SELinux 
> that could make his system more secure, and if a single tarball is 
> available to him, he can simply download that, compile it and be up and 
> running with a SELinux system. 
> 
> I agree with Stephen that having the tarballs would be redundant as most 
> of us prefer to get individual patches and patch our kernels, but I'm just 
> thinking of the whole situation from a newbie's point of view. Old users 
> sometimes don't realise it, but it can get intriguing for someone just 
> starting out. Having something simple to use can be very helpful.

I would agree with this rationale (and indeed, it is why we originally
provided these tarballs) if it wasn't for the fact that any end user of
SELinux can now get both binary and source SELinux kernel and userland
packages for their distribution (at least Debian, Gentoo, Fedora, and
SuSE) from elsewhere (and in the cases of Fedora and Hardened Gentoo,
the SELinux code is already integrated into the distro for them), and
that will always be easier for end users than building from our source
tarballs.  At this point, I think that only people packaging SELinux for
the distros and reasonably skilled users will be directly using our
downloads, and I don't see any value in the complete tarballs to them.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
