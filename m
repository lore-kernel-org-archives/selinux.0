Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6DAhxrT008385
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 06:43:59 -0400 (EDT)
Received: from snowstorm.hosts.ndo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6DAhvSK009318
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 10:43:58 GMT
Date: Tue, 13 Jul 2004 11:19:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Babcock <cbabcock@luthresearch.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: Re: [SE/Linux] warning about debian hotplug package 20040329-9!
Message-ID: <20040713101908.GB3732@lkcl.net>
References: <20040709201413.GB3168@lkcl.net> <200407112050.08313.russell@coker.com.au> <20040711112237.GI3390@lkcl.net> <40F16D8B.4010601@bellsouth.net> <20040711205047.GQ4677@lkcl.net> <2500.68.6.187.64.1089667018.squirrel@mxlx1.surveysavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2500.68.6.187.64.1089667018.squirrel@mxlx1.surveysavvy.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 12, 2004 at 02:16:58PM -0700, Chris Babcock wrote:
> So then what if (horror of horrors) somebody puts "/var" on a usb disk
> device. (or some other type of device initialized by hotplug?)
 
 or an nfs-mounted partition.

 the suggestion in that case that i received by one of the hotplug
 developers / people-monitoring-debian-bugs-for-hotplug was that you
 should modify the /etc/hotplug scripts to use /devfs/shm/tmp instead,
 assuming that you have a debian initrd.

 now, on SE/Linux that isn't possible, and the reason isn't entirely
 clear, but i believe that the access permissions to the tmpfs
 created by the debian initrd are such that when the umount tmpfs
 occurs, it actually _does_ unmount it.

 on a standard debian/linux system (no selinux kernel) the initrd
 scripts attempt, amongst other things, to mount various filesystems
 and these are successful, but they are not _un_mounted properly later
 on.

 anyway, i digress: the idea i came up with was that the debian
 package be modified such that it's possible to specify the
 state directory, even if that's one of a list of possible
 locations e.g.  choose one: /etc/hotplug, /etc/hotplug/run,
 /var/run/hotplug, /devfs/shm/tmp, other.

 consequently, if this were to be implemented, at least people mad
 enough to use usb disks or nfs mounted stuff, they'd be able to
 at least get going without having to hack the source of hotplug.

 
> > dear selinux and linux kernel,
> >
> > i am after some assistance in clarifying how hotplug works, with
> > a view to solving an issue with SE/Linux where the default
> > SE/Linux policy is to deny write permission to /etc/hotplug
> > (with good reason) but the hotplug package is presently demanding
> > write permission.
> >
> > a simple request for a change to writing to /var/state/hotplug
> > instead has thrown up a number of issues with kernel (2.6.6)
> > hotplugging and i would greatly appreciate some confirmation
> > and some assistance.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
