Subject: Re: Unionfs and Selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1105522661.6597.14.camel@jsingh>
References: <1105522661.6597.14.camel@jsingh>
Content-Type: text/plain
Message-Id: <1105543350.22495.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 10:22:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 04:37, Jaspreet Singh wrote:
> Unionfs redirects the listxattr /getxattr calls to underlying branches
> (of filesystems).

Only if you build it with the UNIONFS_XATTR option enabled, which
appears to be commented out by default in the Makefile.  Did you build
with it enabled?

> It said :- mount: Operation not supported ,and audit says -
> SELinux: (dev unionfs, type unionfs) has no xattr support

This means that the root inode had a NULL getxattr method at the time of
the security_sb_kern_mount() hook call just after the type->get_sb()
call in do_kern_mount().

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
