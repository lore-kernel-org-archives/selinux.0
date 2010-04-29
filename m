Subject: Re: System console hangs on boot in enforced unless some
 permissions added (with 2.6.32-3).
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@udmvt.ru
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, refpolicy@oss1.tresys.com
In-Reply-To: <20100429061442.GO25652@ruber.office.udmvt.ru>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
	 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
	 <20100301165602.GH3990@myhost.felk.cvut.cz>
	 <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20100428160413.GN25652@ruber.office.udmvt.ru>
	 <1272483157.6013.300.camel@moss-pluto.epoch.ncsc.mil>
	 <20100429061442.GO25652@ruber.office.udmvt.ru>
Content-Type: text/plain
Date: Thu, 29 Apr 2010 09:02:16 -0400
Message-Id: <1272546136.28649.48.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-04-29 at 10:14 +0400, selinux@udmvt.ru wrote:
> Yes, ofcourse, it is labelled. Plus, my little "fix" by allowing kernel_t
> access to tmpfs_t allowed the system to properly boot and function in
> enforced mode and transition to system services and to getty_t, etc, etc.
> Can that happen with labelling problems?
> And ofcourse, getty should never be in kernel_t.

Ok, I understand your problem now.
devtmpfs internally switches to the initial task's credentials when
performing internal operations like creating new device nodes when they
are requested by the driver.  Otherwise we'd have to allow whatever
happened to be the currently running process (e.g. getty_t) to perform
those operations, whereas they aren't originating from that process at
all and we don't want to permit the process to perform that action on
its own.  That's why it shows up as kernel_t.  In the Fedora default
targeted policy, kernel_t is unconfined and everything just works.  If
we don't already have explicit allow rules permitting kernel_t to create
these nodes in whatever default type we assign to devtmpfs, then that's
a policy bug.

> Debian/testing uses sysfs+udev with tmpfs for storing /dev, not devtmpfs.
> Not I nor bootscripts do mount devtmpfs ANYWHERE in the system, so relabelling
> is not possible until devtmpfs is mounted, but I do not need it mounted. But it
> generates avc denials while unmounted too, this is a rather ghosty behavior.
> And that is not only avc messages, that denials break the system.

On Fedora, I see:
$ grep devtmpfs /proc/mounts
/proc/mounts:udev /dev devtmpfs rw,seclabel,relatime,size=1016584k,nr_inodes=254146,mode=755 0 0

Depending on your kernel config, the devtmpfs kernel code will
automatically mount the devtmpfs instance on /dev, without any action on
your part.  You can explicit control this action by specifying
devtmpfs.mount=1 or devtmpfs.mount=0 on the kernel command line.  In
Fedora, the mounting defaults to enabled.  It sounds like the reverse is
true in Debian.

> Hehe. I knew that somebody will respond in this manner. It was my first reaction too.
> But here is what I have figured out:
>   - my devtmpfs is NOT MOUNTED anywhere (and was not even in initramfs), so getty should
>     not and cannot get access to it

So I guess CONFIG_DEVTMPFS_MOUNT=n in your config.

>   - there is no code in getty to create chr_file files, really
>   - my getty is really running under getty_t

Right, this is an internal operation within the kernel; whenever a
driver requests a device node, devtmpfs automatically creates the node.
devtmpfs switches credentials around this internal operation so that we
do not need to authorize getty or other userspace processes for this
operation.

> > You might have fewer errors too if you use device_t rather than tmpfs_t
> > as the default in your fs_use_trans statement.
>   - I do not use any at all. I do not need devtmpfs either. Is it defined in policy?
> So, is it a policy bug?
> Anyway, is kernel_t allowed to create files in device_t directories ? No difference with tmpfs_t.

Looking at refpolicy list archives I see that they tried switching from
tmpfs_t to device_t as the default type for devtmpfs but ran into some
other issues and backed off from it for now.  So it is presently still
defined as tmpfs_t there.

> > 
> > > So, after all, now with my "fix" just everyone with mount privilege can do
> > >  # mount -t devtmpfs blablabla-no-device-is-needed /mountpoint
> > > to get directory full of device nodes with NO proper labelling?
> > 
> > Once it has been initially mounted and labeled, all subsequent mounts
> > should get the same instance - they don't create a new one each time.
> 
> But new devices are created there dynamically, and they are not labelled!
> Should I start a cron job every minute, that will mount devtmpfs, relabel it, and then unmount?
> Ofcourse not! What is the option then?

If it is mounted on /dev as expected, then the initial restorecon
-R /dev will fix it up on boot and udev should handle labeling any
subsequently created nodes just as before devtmpfs.

> And I have googled on the subject and have found strong opposition of some kernel
> maintainers to the appearance of devtmpfs in the mainline existed in the past.
> And you had your own point on that, here is the citation from Alan Cox and Greg KH writing each other:
> Alan Cox:
>  Also can you confirm the SELinux issues raised by Stephen Smalley and
>  David Quigley were fixed and resolved.
> 
> Greg KH (proposing new new patch):
>  From what I recall, yes, they were.  I'm guessing the Red Hat boot tests
>  performed by Harald confirms this.
> END CITATION (from http://lkml.org/lkml/2009/8/5/357)
> 
> I do not personally know who is Harald and whether I can trust he is really performed
> boot tests on Red Hat with SELinux enforced, but I think, that my boot test found the opposite.
> Perhaps, you, Stephen Smalley, have raised some other issues then and now I have met my own. :(
> But I am still interested to figure out, is it only me having these issues, or
> devtmpfs patch activated really brings down SELinux enabled systems (without the policy patched)?

It seems that there are a couple of problems:
- your kernel has CONFIG_DEVTMPFS=y but CONFIG_DEVTMPFS_MOUNT=n, so you
get to incur the 
- your policy doesn't allow kernel_t unfettered access to the default
type associated with devtmpfs.  That's a policy issue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
