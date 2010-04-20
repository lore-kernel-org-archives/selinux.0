Subject: Re: Setting labels on a disabled SELinux box.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <4BCDB877.10908@redhat.com>
References: <4BCDB877.10908@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Apr 2010 10:45:32 -0400
Message-Id: <1271774732.30027.73.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-20 at 10:21 -0400, Daniel J Walsh wrote:
> Currently the kernel is blocking the setting of labels on a disabled
> SELinux box.
> 
> We have made changes to livecd to be able to build a livecd image on a
> disabled SELinux box, but the kernel is preventing the placing of labels.
> 
> We want this functionality so that Fedora Build machines can be allowed
> to create different kinds of images and do not want to require all
> machines to enable SELinux.
> 
> Currently these images are being built with SELinux disabled because of
> this.
> 
> strace shows
> 
> lsetxattr("/root/whatever/", "security.selinux",
> "system_u:object_r:root_t:s0", 28, 0) = -1 EOPNOTSUPP (Operation not
> supported)
> 
> 
> eparis says this code is causing the problem.
> 
>  static int cap_inode_setsecurity(struct inode *inode, const char *name,
>                                   const void *value, size_t size, int flags)
>  {
>          return -EOPNOTSUPP;
>  }
> 
> I think we should allow this if you have a capability like sys_admin or
> dac_override.

Perhaps I don't understand, but inode_setsecurity() is only called if
the filesystem does not support xattrs; otherwise it gets handled via
the filesytem's ->setxattr handler, and that should work regardless of
SELinux-disabled (and always has in the past).

I think we need more details, like kernel version, filesystem type, etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
