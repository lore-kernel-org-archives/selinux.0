Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02I85Ii013535
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 13:08:05 -0500 (EST)
Received: from babbler.bmc.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02I6DHg004750
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 18:06:14 GMT
Date: Sun, 2 Jan 2005 12:07:51 -0600 (CST)
From: Richard Troth <rtroth@bmc.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modules needed to be compiled in for selinux to work
In-Reply-To: <20050102104530.GG6142@lkcl.net>
Message-ID: <Pine.LNX.4.53.0501021201350.29068@rmt-desk.bmc.com>
References: <20050102104530.GG6142@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2 Jan 2005, Luke Kenneth Casson Leighton wrote:
> debian's 2.6.9 kernel has selinux - and capabilities - as modules.

Good!

> i was wondering: which gets run first, /sbin/init or modprobe
> capability from /etc/modules?

Well ... 'init',  sort of.   Read on.

> i think the question is fairly obviously /sbin/init but i want to be
> absolutely sure.

If "initrd" is not used,  then yes,  'init' runs first,
and I supposed that can foul-up SELinux.   Of course,  one could
replace 'init' with another program,  even a shell script,
which would properly load the security modules and policies
and then exec the real 'init'.

Most often,  for SuSE and RedHat anyway,
there's an "initrd" hack happening so that the distributor
needs to ship only one or two pre-compiled kernels and then load
modules in that mysterious early light just before dawn and
real root and real /sbin/init.   After working its magic,
the "initrd" initializer does a 'pivot_root'.

> in other words, is CONFIG_CAPABILITY=m stopping selinux from
> working in debian's 2.6.9 kernel?

I really REALLY hope not,
because having SELinux shipped as modules is a Good Thing.
Several reasons for this position,  I will not enumerate now.

-- R;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
