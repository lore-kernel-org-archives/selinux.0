Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02JxKIi013780
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 14:59:20 -0500 (EST)
Received: from babbler.bmc.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02JvSHg006066
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 19:57:29 GMT
Date: Sun, 2 Jan 2005 13:59:20 -0600 (CST)
From: Richard Troth <rtroth@bmc.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modules needed to be compiled in for selinux to work
In-Reply-To: <20050102190123.GG12268@lkcl.net>
Message-ID: <Pine.LNX.4.53.0501021358340.29430@rmt-desk.bmc.com>
References: <20050102190123.GG12268@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With 'mkinitrd' you should not have to re-build the kernel.
You just re-make the initial RAMDISK with your desired
selection-o-modules and reboot.

-- R;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
