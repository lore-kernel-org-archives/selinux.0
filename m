Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02IomIi013637
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 13:50:48 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02Iooeb012545
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 18:50:51 GMT
Date: Sun, 2 Jan 2005 19:01:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Richard Troth <rtroth@bmc.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modules needed to be compiled in for selinux to work
Message-ID: <20050102190123.GG12268@lkcl.net>
References: <20050102104530.GG6142@lkcl.net> <Pine.LNX.4.53.0501021201350.29068@rmt-desk.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.53.0501021201350.29068@rmt-desk.bmc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jan 02, 2005 at 12:07:51PM -0600, Richard Troth wrote:
> On Sun, 2 Jan 2005, Luke Kenneth Casson Leighton wrote:
> > debian's 2.6.9 kernel has selinux - and capabilities - as modules.
> 
> Good!
> 
> > i was wondering: which gets run first, /sbin/init or modprobe
> > capability from /etc/modules?
> 
> Well ... 'init',  sort of.   Read on.
> 
> > i think the question is fairly obviously /sbin/init but i want to be
> > absolutely sure.
> 
> If "initrd" is not used,  then yes,  'init' runs first,
> and I supposed that can foul-up SELinux.   Of course,  one could
> replace 'init' with another program,  even a shell script,
> which would properly load the security modules and policies
> and then exec the real 'init'.
> 
> Most often,  for SuSE and RedHat anyway,
> there's an "initrd" hack happening so that the distributor
> needs to ship only one or two pre-compiled kernels and then load
> modules in that mysterious early light just before dawn and
> real root and real /sbin/init.   After working its magic,
> the "initrd" initializer does a 'pivot_root'.

 oh.

 yes.

 i remember now - /etc/mkinitrd/modules.

 ah ha!  okay.  so if i add "capability" to that list (and
 selinuxfs?)  and rebuild the kernel, such that mkinitrd adds
 it, everything is hunky-dory again, yes?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
