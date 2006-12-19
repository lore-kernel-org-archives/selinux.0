Subject: Re: superblock_doinit emits a message for every mount
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1166550751.20187.63.camel@localhost.localdomain>
References: <1166550751.20187.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 13:23:26 -0500
Message-Id: <1166552606.30579.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-19 at 12:52 -0500, Eric Paris wrote:
> So I recently heard a complaint that we emit a message every time a FS
> is mounted.  In this case they have lots of autofs mounts happening in
> turn gets lots of messages like:
> 
> Dec 18 16:32:06 buildrm55 kernel: SELinux: initialized (dev 0:39, type
> nfs), uses genfs_contexts
> 
> They all come from superblock_doinit in hooks.c.
> 
> printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
>        sb->s_id, sb->s_type->name,
>        labeling_behaviors[sbsec->behavior-1]);
> 
> which fill their logs.  They wanted to know if we were willing to give a
> way to turn such informational messages off.  I can discuss with
> them /proc/sys/kernel/printk and configuring syslog to ignore
> kernel.info but I wondered if anyone else had any comments or thought
> about these particular messages.  Do we need them?  Are they really
> anything other than debugging?

They could likely be demoted to KERN_DEBUG.  Along with most of the
other printk KERN_INFO messages in hooks.c.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
