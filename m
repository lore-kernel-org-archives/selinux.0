Subject: Re: System console hangs on boot in enforced unless some
 permissions added (with 2.6.32-3).
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@udmvt.ru, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, refpolicy@oss1.tresys.com
In-Reply-To: <1272546136.28649.48.camel@moss-pluto.epoch.ncsc.mil>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
	 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
	 <20100301165602.GH3990@myhost.felk.cvut.cz>
	 <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20100428160413.GN25652@ruber.office.udmvt.ru>
	 <1272483157.6013.300.camel@moss-pluto.epoch.ncsc.mil>
	 <20100429061442.GO25652@ruber.office.udmvt.ru>
	 <1272546136.28649.48.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 29 Apr 2010 09:57:12 -0400
Message-ID: <1272549432.32279.337.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-04-29 at 09:02 -0400, Stephen Smalley wrote:
> On Thu, 2010-04-29 at 10:14 +0400, selinux@udmvt.ru wrote:
> > Yes, ofcourse, it is labelled. Plus, my little "fix" by allowing kernel_t
> > access to tmpfs_t allowed the system to properly boot and function in
> > enforced mode and transition to system services and to getty_t, etc, etc.
> > Can that happen with labelling problems?
> > And ofcourse, getty should never be in kernel_t.
> 
> Ok, I understand your problem now.
> devtmpfs internally switches to the initial task's credentials when
> performing internal operations like creating new device nodes when they
> are requested by the driver.  Otherwise we'd have to allow whatever
> happened to be the currently running process (e.g. getty_t) to perform
> those operations, whereas they aren't originating from that process at
> all and we don't want to permit the process to perform that action on
> its own.  That's why it shows up as kernel_t.  In the Fedora default
> targeted policy, kernel_t is unconfined and everything just works.  If
> we don't already have explicit allow rules permitting kernel_t to create
> these nodes in whatever default type we assign to devtmpfs, then that's
> a policy bug.

To make sure I understand correctly since I'm not versed in devtmpfs
yet, kernel_t should be able to create device nodes, directories and
symlinks in /dev?  Does it create them with the right context, or does
it rely on udev to come by and relabel them?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
