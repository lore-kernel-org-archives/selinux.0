Subject: Re: file context questions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1077134006.6667.10.camel@kusturica>
References: <1077134006.6667.10.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077135396.17849.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 15:16:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-18 at 14:53, Magosányi Árpád wrote:
> 1. What is the difference between getfilecon and lgetfilecon?

Analogous to stat(2) vs. lstat(2) or getxattr(2) vs. lgetxattr(2). 
Identical when applied to a non-symlink.  When applied to a symlink,
getfilecon will return the context of the referenced file, while
lgetfilecon will return the context of the symlink itself.

> 2. I cannot [l]getfilecon /selinux/context even in permissive mode.
> What's happening? Is there a way to get file contexts of a
> genfscontexted file, or I have to guess?

selinuxfs doesn't presently provide an xattr handler, so its contexts
aren't exported to userspace.  You could easily implement a fake xattr
handler for it, as we have already done for devpts (to support
relabeling of ptys by sshd) and are likely to do for tmpfs, but we
haven't had a need for one for selinuxfs yet.

> 3. If I use genfscontext and fs_use for the same file, which will be
>  in effect? (or genfscontext is just fs_use_genfs?)

Should be an error, as they are exclusive.  I think that the current
code will simply end up using the fs_use rule and ignore the
genfs_contexts entries, as it checks the fs_use list first when
determining the labeling behavior for the filesystem type.

> 4. When I boot, several filesystems are not configured for labeling.
>    Which is the recommended way to label each of them, and why?
>    (And anyway, what the heck are they?)
> 	eventpollfs
> 	tmpfs
> 	futexfs
> 	bdev
> 	rootfs
> 	sysfs
> 	usbfs
> 	usbdevfs 

Look at the policy in the sourceforge CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
