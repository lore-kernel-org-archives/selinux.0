Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6HDqOrT004589
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 09:52:24 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6HDq0IR020132
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 13:52:01 GMT
Received: from eibe.cip.ifi.lmu.de (eibe.cip.informatik.uni-muenchen.de [141.84.220.60])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 7482143591
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 15:52:20 +0200 (CEST)
Date: Sat, 17 Jul 2004 15:52:18 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: file_contexts patch
Message-ID: <20040717135218.GA21084@eibe.cip.ifi.lmu.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <20040717101533.GB8887@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20040717101533.GB8887@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Note: I do not know hotplug very much; neither do I speak for SuSE]

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-07-17 13:35]:
> thomas,
> 
> i note the addition of /var/run/usb here.
> 
> is that because SuSE has modified the hotplug package
> to place state information in that directory?

It does indeed store scripts there to be run on device removal - see
/etc/hotplug/usb.agent. (SuSE 9.1 also has /var/run/hotplug, as I just
discovered)

However, it does not seem like SuSE has modified the package at all,
they seem to use the vanilla package from
http://linux-hotplug.sourceforge.net/
Both upstream and suse use /var/run/usb for variable data.
And while Debian has modified /etc/hotplug/usb.agent a bit, it still
stores its scripts under /var/run/usb.

> please advise, because i have raised a bug-request with
> the debian hotplug maintainers, and i believe that the
> upstream maintainers favour the use of /etc/hotplug/run
> rather than /var/run/something.

The script you are probably talking about (/etc/hotplug/net.rc) is
specific to Debian. I do not know of other hotplug scripts which write
to /etc, but then I do not know hotplug all that much.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
