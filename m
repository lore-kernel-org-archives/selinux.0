Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67G5orT006800
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 12:05:50 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67G5naX028609
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 16:05:49 GMT
Subject: Re: SELinux on Debian (Sid), second try
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Magnus Therning <magnus-work@therning.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <20040630082935.GK1688@philips.com>
References: <20040624163900.GB3290@philips.com>
	 <200406282347.41232.russell@coker.com.au>
	 <20040628150448.GF1688@philips.com>
	 <200406291533.10068.russell@coker.com.au>
	 <20040629085928.GH1688@philips.com>  <20040630082935.GK1688@philips.com>
Content-Type: text/plain
Message-Id: <1089216339.1774.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 12:05:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-06-30 at 04:29, Magnus Therning wrote:
> Some more information (that might be interesting).
> 
> /etc/fstab has an entry like this:
> 
>  none /selinux selinuxfs noauto 0 0
> 
> 'mount' doesn't report it mounted though. Should it?
> 
> Calling 'mount /selinux' results in
> 
>  mount: none already mounted or /selinux busy

selinuxfs is mounted by /sbin/init for the initial policy load these
days, so it is no longer necessary (or useful) to add it to fstab and it
won't show up in mtab.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
