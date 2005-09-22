Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8MMRkNs024492
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 18:27:46 -0400 (EDT)
Received: from ayukawa.diyab.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8MMNBNV007662
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 22:23:12 GMT
From: "Timothy" <timothy@diyab.net>
To: Lyle Sigurdson <lyle_s@myrealbox.com>, selinux@tycho.nsa.gov
Subject: Re: Getting started with SELinux and Slackware
Date: Thu, 22 Sep 2005 18:23:19 -0400
Message-Id: <20050922215544.M3732@diyab.net>
In-Reply-To: <200509221622.46111.lyle_s@myrealbox.com>
References: <43325C75.3060405@sbcglobal.net> <200509221935.06357.russell@coker.com.au> <4332D995.1060200@sbcglobal.net> <200509221622.46111.lyle_s@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I've been working on getting SELinux to work on Slackware 
> without PAM and with just one patch per package (that is, not 
> relying on all the patches that are applied before the SELinux 
> patch.)  I've got a bunch of packages made but not a working 
> system yet.

I had considered this but I did not see anything but advantages to using PAM.
 The one main hurdle would be recompiling things in slackware to include PAM
support but most of the base things you would need to recompile get recompiled
to include selinux support anyhow.

> 
> I'm still in the early learning phases with regards to SELinux, 
> but here a few thoughts:
> 
> - SELinux is one of the most important things to ever hit Linux
>   (in my opinion.)  It would be unfortunate if Slackware never
>   gets in on it.
> 
> - I doubt SELinux will be merged into the distribution if PAM is
>   part of it, because the Slackware folks are pretty anti-PAM.

Pat himself is anti-PAM from what I've heard, although I do not know why, so I
doubt it will make it in to slackware.

> 
> - I doubt SELinux will be merged into the distribution if it 
>   requires a lot of patches, because Slackware's packages are
>   built mostly straight from the tarballs without patching (a
>   whole bunch of ./configure --with-selinux would be fine.)
> 
>    Lyle Sigurdson.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
