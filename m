Subject: Re: How to handle USB devices....
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom London <selinux@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4c4ba1530804241154j29be39adnb71e8dc11d4f4f25@mail.gmail.com>
References: <4c4ba1530804241154j29be39adnb71e8dc11d4f4f25@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 15:10:41 -0400
Message-Id: <1209064241.26761.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-24 at 11:54 -0700, Tom London wrote:
> Attempting to get '-usbdevice host:001.004' (and similar) working with
> qemu-kvm on my Fedora rawhide system, it occurred to me that there is
> the opportunity to apply policy to the files associated with USB
> devices.  Currently, most seem to have a 'flat' label (usbfs_t),
> making it hard to confine qemu like programs that should only have
> access to, say, a single device.
> 
> Does it make sense to support more 'fine grained' labeling, and to
> label the associated device file (e.g., /proc/bus/usb/...., /dev/usb,
> etc.) when the files are 'created'?
> 
> Would udev be the place to do this?  PolicyKIt?
> 
> Thoughts?

Depends on the usbfs implementation in the kernel.

If the inodes are pinned in memory and can't be evicted, then we could
label from userspace, although I don't know specifically what userspace
agent (udev or otherwise) is appropriate there.

If the inodes can be evicted and later repopulated from internal
structures, we need a way to preserve context, similar to the sysfs
problem.  Speaking of which, any progress on sysfs (bug 228902), Eric?
We had two experimental patches for sysfs labeling a while ago, one
based on genfs_contexts (kernel-managed labeling based on pathname) and
one based on properly supporting setxattr and preserving contexts
(userspace-managed labeling).  And the necessary LSM hooks for the
latter would seem to be comparable to what Dave Quigley has proposed in
support of labeled NFS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
