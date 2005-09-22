Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8MLRNNs024009
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 17:27:24 -0400 (EDT)
Received: from smtp-send.myrealbox.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8MLMu4o024787
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 21:22:57 GMT
From: Lyle Sigurdson <lyle_s@myrealbox.com>
To: selinux@tycho.nsa.gov
Subject: Re: Getting started with SELinux and Slackware
Date: Thu, 22 Sep 2005 16:22:45 -0500
References: <43325C75.3060405@sbcglobal.net> <200509221935.06357.russell@coker.com.au> <4332D995.1060200@sbcglobal.net>
In-Reply-To: <4332D995.1060200@sbcglobal.net>
MIME-Version: 1.0
Message-Id: <200509221622.46111.lyle_s@myrealbox.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been working on getting SELinux to work on Slackware 
without PAM and with just one patch per package (that is, not 
relying on all the patches that are applied before the SELinux 
patch.)  I've got a bunch of packages made but not a working 
system yet.

I'm still in the early learning phases with regards to SELinux, 
but here a few thoughts:

- SELinux is one of the most important things to ever hit Linux
  (in my opinion.)  It would be unfortunate if Slackware never
  gets in on it.

- I doubt SELinux will be merged into the distribution if PAM is
  part of it, because the Slackware folks are pretty anti-PAM.

- I doubt SELinux will be merged into the distribution if it 
  requires a lot of patches, because Slackware's packages are
  built mostly straight from the tarballs without patching (a
  whole bunch of ./configure --with-selinux would be fine.)

   Lyle Sigurdson.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
