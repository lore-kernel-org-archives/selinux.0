Subject: Re: System hang during boot on Debian Sid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dave Patterson <sdpatt2@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20051009083426.GA10995@localhost.localdomain>
References: <20051009083426.GA10995@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:27:38 -0400
Message-Id: <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-10-09 at 15:34 +0700, Dave Patterson wrote:
> With kernel 2.6.13.3 with NSA patch applied the options
> CONFIG_DEVPTS_FS_XATTR and CONFIG_DEVPTS_FS_SECURITY disappear.  Or
> have gone somewhere...
> 
> Compiling while ignoring these two options and booting selinux=1 in
> grub I get ...
> 
> SELinux initialized (dev sysfs type sysfs) uses genfs contexts
> 
> and the system hangs.  Any suggestions?

Those options were obsoleted by the generic VFS fallback for security
xattrs (attempts to get/set security xattrs now fall back automatically
to the security module if the filesystem doesn't support xattrs
natively, so devpts and tmpfs no longer require their own handlers).
That change was included in the 2.6.13-selinux1.patch and is going to be
part of 2.6.14 upstream (already in 2.6.14-rcX, and has been in Fedora
rawhide kernels for a while).

I don't know about the state of SELinux in Debian sid, but Russell's
message indicated that udev doesn't work well with SELinux in Debian
yet.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
