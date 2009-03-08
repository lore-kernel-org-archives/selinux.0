Date: Mon, 9 Mar 2009 08:48:52 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: make inode_doinit_with_dentry printk debug
In-Reply-To: <1236367392.3541.10.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0903090848050.14559@tundra.namei.org>
References: <1236367392.3541.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Mar 2009, Eric Paris wrote:

> Drop the printk level to debug when an inode is found without an associated
> dentry.  This should only happen when userspace can't be accessing the
> inode and the label will get set correctly on the next inode_doinit before it
> can be used, so there is little reason to send this message.

I'd prefer to have the message removed (but leave a comment in the code).

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
