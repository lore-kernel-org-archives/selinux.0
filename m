Date: Tue, 10 Mar 2009 08:43:14 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: inode_doinit_with_dentry drop no dentry
 printk
In-Reply-To: <20090309183558.7254.906.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0903100842550.21035@tundra.namei.org>
References: <20090309183558.7254.906.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Mar 2009, Eric Paris wrote:

> Drop the printk message when an inode is found without an associated
> dentry.  This should only happen when userspace can't be accessing those
> inodes and those labels will get set correctly on the next d_instantiate.
> Thus there is no reason to send this message.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
