Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4ODk2gA017207
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 09:46:03 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4ODfJMp009065
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 13:41:20 GMT
Date: Tue, 24 May 2005 14:50:30 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Moving target -- kernel version.
Message-ID: <20050524135030.GG8404@lkcl.net>
References: <20050524123502.74451.qmail@web60424.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050524123502.74451.qmail@web60424.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

roger, hi,

you will find, if you download the latest
2.6.11 debian kernel, and headers (apt-get install
kernel-image-2.6.11-1-686 kernel-headers-2.6.11-1-6-6) and
examine /usr/src/kernel-headers-2.6.11-1-686/.config,
that CONFIG_SECURITY_SELINUX is set to "y".

also you will find that CONFIG_TMPFS_SECURITY, CONFIG_EXT2_FS_SECURITY,
CONFIG_EXT3_FS_SECURITY are all also set to "y".

so you will not _need_ to build a new debian 2.6.11 kernel.

at least, i don't recall seeing any significant messages go
by that have said "you must upgrade to 2.6.12 because of x to
use the latest sf.net cvs policy files".

l.


On Tue, May 24, 2005 at 05:35:01AM -0700, Roger Brunell wrote:
> I am starting to feel a rising wave of frustration with producing a
> reproducible script for installing selinux.
> 
> To do the install the kernel must be patched and rebuild.
> To patch and build the source must be present
> But which source???
>   ? apt-get kernel-source-2.6.11     (version = 2.6.11-3)
>   ? Distro version is not documented
>      ? Kernel.org patches applied not documented
>      ? Distro patches applied -- not documented
>   ? /nsa/linux-2.6/    is what? Virgin kernel.org sourec ??
>          nope, it changed since last CVS download a week ago (changes = 2168)
>   
> Right now I am diffing the /nsa/linux-2.6 and the apt-get kernel source.
> 
> Not sure what to do next for the best result.....
> 
> 
> 
>   
> 
> Roger Brunell
> 
> Infosec Engineer (retired)
> "Born 20 years too early"
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
