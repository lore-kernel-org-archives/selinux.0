Subject: Re: Confirmation about task_has_security in selinuxfs.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <613217.17683.qm@web86902.mail.ukl.yahoo.com>
References: <613217.17683.qm@web86902.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 20 Mar 2007 13:01:46 -0400
Message-Id: <1174410107.22565.247.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-20 at 16:57 +0000, JanuGerman wrote:
> Hi Stephen,
> > Perhaps an example would make things clearer. 
> > During open(2)
> > processing, the fs/namei.c:permission() function is
> > called to check
> > permissions.  That function first applies the usual
> > Linux checks,
> > including DAC checks, and, if they pass, the
> > function then calls the LSM
> > security_inode_permission() hook, which is defined
> > by
> > include/linux/security.h.  
> 
> Within the fs/namei.c, there are two functions defined
> for calling fs/namei.c:permission(), one is int
> vfs_permission(struct nameidata *nd, int mask) and the
> other is int file_permission(struct file *file, int
> mask).
> 
> My question is that, which of the above two functions
> is used to call fs/namei.c:permission() function in
> the Linux 2.6 kernel, and which way is followed by
> SELinux.

Read the code (including the comments), and all should be clear.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
