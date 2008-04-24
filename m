Subject: Re: labelling with genfscon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: run zhang <zhang4run@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <358705.20897.qm@web63005.mail.re1.yahoo.com>
References: <358705.20897.qm@web63005.mail.re1.yahoo.com>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 08:30:07 -0400
Message-Id: <1209040207.15796.386.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-23 at 12:07 -0700, run zhang wrote:
> In the NSA example policy package, the genfs_contexts explains that
> except /proc, all other filesystems without xattr support are limited
> to a single entry /. Can I specify the subdirs of a filesystem with
> different lables with genfscon just like /proc? 
> More specifically, I am using NFS and cramfs, where I specify 
> genfscon nfs /   root_t
> genfscon nfs /bin bin_t
>  
> However, after boot and load the result policy, still every dir in
> rootfs is labelled with root_t. It seems the same result for cramfs.
> According this thread:
> http://marc.info/?l=selinux&m=102587231814793&w=2, it seems that this
> should be doable. 
> Please give hand, thanks very much!

At the time of that thread, SELinux did support use of genfs_contexts
for other filesystem types.  However, that support was dropped because
a) we couldn't provide strong guarantees about such labeling for other
filesystem types (in the case of proc, we can generate an unambiguous
and immutable pathname from the internal kernel data structures to use
as a key; most other filesystem types would suffer from aliasing and
userspace-manipulation issues), and b) it was frowned upon by the vfs
folks as unacceptable for merging selinux into mainline.  It was
nonetheless a relatively simple patch to SELinux to support it if you
are willing to patch your kernel.

For NFS, you are currently limited to per-mount granularity (using the
mount context= option) or the default genfscon label.  There is ongoing
work on labeled NFSv4 support to provide native support for per-file
labeling.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
