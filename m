Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3T6EmVt026347
	for <selinux@tycho.nsa.gov>; Thu, 29 Apr 2010 02:14:48 -0400
Received: from atoll.udmvt.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3T6EBag002089
	for <selinux@tycho.nsa.gov>; Thu, 29 Apr 2010 06:14:12 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id o3T6Ehxw031847
	for <selinux@tycho.nsa.gov>; Thu, 29 Apr 2010 10:14:45 +0400 (GMT-4)
	(envelope-from spg@udmvt.ru)
Date: Thu, 29 Apr 2010 10:14:42 +0400
From: selinux@udmvt.ru
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: System console hangs on boot in enforced unless some
	permissions added (with 2.6.32-3).
Message-ID: <20100429061442.GO25652@ruber.office.udmvt.ru>
References: <20100228223834.GE3990@myhost.felk.cvut.cz> <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil> <20100301165602.GH3990@myhost.felk.cvut.cz> <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil> <20100428160413.GN25652@ruber.office.udmvt.ru> <1272483157.6013.300.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272483157.6013.300.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 28, 2010 at 03:32:37PM -0400, Stephen Smalley wrote:
> On Wed, 2010-04-28 at 20:04 +0400, selinux@udmvt.ru wrote:
> > Is it only me unable to run Debian's 2.6.32-3 kernel with SELinux in enforced mode,
> > or is anyone else's system blocked by the devtmpfs compiled into the kernel? :)
> > 
> > Look, I have these strange messages in permissive mode:
> > 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { search } for  pid=1668 comm="getty" name="/" dev=devtmpfs ino=4 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> > 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { write } for  pid=1668 comm="getty" name="/" dev=devtmpfs ino=4 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> > 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { add_name } for  pid=1668 comm="getty" name="vcs2" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> > 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { create } for  pid=1668 comm="getty" name="vcs2" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=chr_file
> 
> Two problems:
> - getty shouldn't be in kernel_t.  This means that you never
> transitioned out of kernel_t to init_t upon executing /sbin/init.
> Is /sbin/init labeled correctly?
Yes, ofcourse, it is labelled. Plus, my little "fix" by allowing kernel_t
access to tmpfs_t allowed the system to properly boot and function in
enforced mode and transition to system services and to getty_t, etc, etc.
Can that happen with labelling problems?
And ofcourse, getty should never be in kernel_t.

> 
> - Your devtmpfs instance apparently wasn't labeled.  
Yes, ofcourse!
> In Fedora, there is
> a restorecon -R /dev that happens from rc.sysinit to fix up labels once
> policy has loaded.
Debian/testing uses sysfs+udev with tmpfs for storing /dev, not devtmpfs.
Not I nor bootscripts do mount devtmpfs ANYWHERE in the system, so relabelling
is not possible until devtmpfs is mounted, but I do not need it mounted. But it
generates avc denials while unmounted too, this is a rather ghosty behavior.
And that is not only avc messages, that denials break the system.

Hehe. I knew that somebody will respond in this manner. It was my first reaction too.
But here is what I have figured out:
  - my devtmpfs is NOT MOUNTED anywhere (and was not even in initramfs), so getty should
    not and cannot get access to it
  - there is no code in getty to create chr_file files, really
  - my getty is really running under getty_t
  - if I run in single user mode (before gettys), and try to access unused virtual console
    (by opening /dev/tty2 for example) I get the same AVCs, but with another command in comm="",
    so if I do echo > /dev/tty2, I get comm="bash", if I do 'openvt -c 3', I get comm="openvt",
    and, ofcourse, id -Z does not show any kernel_t, really, there is sysadm_t.
  - if I load modules (that register device special files) after SELinux is initialized, I get
    kernel BUG messages and that drivers unusable and unloadable, so now, all modules, that
    I may need in future, is loaded in initramfs.
  - this all does not happen with selinux=0 kernel boot parameter.

> 
> You might have fewer errors too if you use device_t rather than tmpfs_t
> as the default in your fs_use_trans statement.
  - I do not use any at all. I do not need devtmpfs either. Is it defined in policy?
So, is it a policy bug?
Anyway, is kernel_t allowed to create files in device_t directories ? No difference with tmpfs_t.

> 
> > So, after all, now with my "fix" just everyone with mount privilege can do
> >  # mount -t devtmpfs blablabla-no-device-is-needed /mountpoint
> > to get directory full of device nodes with NO proper labelling?
> 
> Once it has been initially mounted and labeled, all subsequent mounts
> should get the same instance - they don't create a new one each time.

But new devices are created there dynamically, and they are not labelled!
Should I start a cron job every minute, that will mount devtmpfs, relabel it, and then unmount?
Ofcourse not! What is the option then?

And I have googled on the subject and have found strong opposition of some kernel
maintainers to the appearance of devtmpfs in the mainline existed in the past.
And you had your own point on that, here is the citation from Alan Cox and Greg KH writing each other:
Alan Cox:
 Also can you confirm the SELinux issues raised by Stephen Smalley and
 David Quigley were fixed and resolved.

Greg KH (proposing new new patch):
 From what I recall, yes, they were.  I'm guessing the Red Hat boot tests
 performed by Harald confirms this.
END CITATION (from http://lkml.org/lkml/2009/8/5/357)

I do not personally know who is Harald and whether I can trust he is really performed
boot tests on Red Hat with SELinux enforced, but I think, that my boot test found the opposite.
Perhaps, you, Stephen Smalley, have raised some other issues then and now I have met my own. :(
But I am still interested to figure out, is it only me having these issues, or
devtmpfs patch activated really brings down SELinux enabled systems (without the policy patched)?

> 
> -- 
> Stephen Smalley
> National Security Agency
And thank you for you discussing this.

-- 
Alexey S.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
