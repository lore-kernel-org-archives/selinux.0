Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02L24Ii013982
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 16:02:05 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02L27eb013960
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 21:02:07 GMT
Date: Sun, 2 Jan 2005 21:12:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Richard Troth <rtroth@bmc.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modules needed to be compiled in for selinux to work
Message-ID: <20050102211239.GB16131@lkcl.net>
References: <20050102190123.GG12268@lkcl.net> <Pine.LNX.4.53.0501021358340.29430@rmt-desk.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.53.0501021358340.29430@rmt-desk.bmc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

fortunately, debian kernel maintainers will be looking to do
CONFIG_CAPABILITY=yes apparently because of root plug exploit
possibility otherwise.

l.

On Sun, Jan 02, 2005 at 01:59:20PM -0600, Richard Troth wrote:
> With 'mkinitrd' you should not have to re-build the kernel.
> You just re-make the initial RAMDISK with your desired
> selection-o-modules and reboot.
> 
> -- R;
> 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
