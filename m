Message-ID: <1397856660.3305.444.camel@metroid.usersys.redhat.com>
Subject: Re: selinux_init_load_policy() and systemd switch-root
From: Will Woods <wwoods@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 18 Apr 2014 17:31:00 -0400
In-Reply-To: <5351203D.7060303@tycho.nsa.gov>
References: <1397770748.3305.386.camel@metroid.usersys.redhat.com>
 <5351203D.7060303@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2014-04-18 at 08:53 -0400, Stephen Smalley wrote:
> On 04/17/2014 05:39 PM, Will Woods wrote:
> > * What should happen if we switch-root from a system with SELinux
> >   enabled/permissive to one that has SELINUX=disabled? 
> 
> That's not a scenario we've ever considered/supported.  It is not
> possible to disable SELinux at runtime (via /sys/fs/selinux/disable)
> after policy has been loaded; that's a security feature.

Indeed. I feel like "We can't disable SELinux, so just log a warning and
security_setenforce(0)" is a sensible way to handle that error, but I
wanted to see if the Collected Wisdom Of The List would agree with that.

> > The problem: Currently, we try to load policy during initramfs. This
> > turns out to be a bad idea: nothing in initramfs is labeled, every
> > process ends up with kernel_t, and so files created in /run or /dev may
> > have the wrong labels.
> 
> Yes, this can only truly work if you put the policy in the initramfs (as
> in Android).

Tangential, but: I assume you would have to relabel your initramfs after
policy is loaded? Or use an initrd[1], and a filesystem that supports
labels?

> > Except: if we were enforcing in the previous root, and the new root
> > requests SELINUX=disabled.. then policy *is* loaded, and we *do* need
> > security_setenforce(0).
> > 
> > So: is that just a bug, or is selinux_init_load_policy() really not
> > intended to be called more than once? And if that's the case, how should
> > I re-load config/policy/etc. after a switch-root?
> 
> I guess it is a bug, but note that you cannot truly disable SELinux at
> this point.  

Right, that's what the (quite thorough!) docs told me as well.

> So while we could trivially add a security_setenforce(0)
> call here, and that seems harmless, SELinux won't be disabled at that
> point, just permissive and operating under the real root policy?

As above, this seems like a reasonable course of action in this case.

> In which case newly created files will be labeled in accordance with
> that policy, and non-permission-related SELinux failures can still
> occur.

True, but I'm guessing this should amount mostly to noise; hopefully
anything that's checking to see if SELinux is *permanently* disabled is
using selinux_getenforcemode() or checking for the presence of policy or
something.

(And, in my inexpert opinion, people who disable SELinux deserve a
little noise now and then anyway. Heh.)

> > [1] initramfs and upgrade.img are actually the same image in the current
> > implementation, but that's not really important here.
> 
> Oh, in that case, why do we need to switch to the real root before
> switching to upgrade.img?  Why can't we just switch to upgrade.img directly?

Because we want the existing system to mount its disks for us. It turns
out to be very hard to examine a system from the outside and *correctly
and reliably* determine how it would mount its disks[2].

But obviously the system already knows how to mount its disks. So why
not let the system do that for us?

And indeed, in practice it's been much simpler[3] and more reliable to
just let the system do its initial setup as normal (i.e. sysinit.target
or /etc/rc.d/rc.sysinit) and then switch out to the upgrade.img.

Anyway - I may have a patch for selinux_init_load_policy() shortly, to
make sure it tries to do security_setenforce(0) if security_disable()
fails.

Thanks for the info,

-w

[1] reminder that initrd and initramfs are different things:
initramfs: cpio archive loaded into tmpfs (dynamic size, swappable)
initrd: filesystem image loaded into a ramdisk (fixed size, no swap)

[2] it's true that you could get it *mostly* right *some* of the time by
just parsing /etc/fstab. But what about systemd .mount units? What about
fancy RAID setups (e.g. for /var) that require mdadm.conf? What about
fancy LVM setups that require lvm.conf? What about multipath? What about
cryptsetup? &c. &c. Trust me, it's kind of a nightmare.

[3] Aside from the weird intricacies of the double-switch-root, which
are admittedly weird and tricky but far less complicated than dealing
with All The Storage Mechanisms That Ever Were Or Shall Be.

If someone wanted to design and enforce the use of some kind of
statically-analyzable storage configuration I'd be *delighted* to drop
the double switch-root. Until then, though...
