Subject: Re: BUG in security_context_to_sid() ?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <20050107144100.53289.qmail@web51507.mail.yahoo.com>
References: <20050107144100.53289.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1105109274.28680.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 07 Jan 2005 09:47:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-07 at 09:41, Park Lee wrote:
> Because there are also other hook functions (such as
> selinux_inode_setxattr(),
> selinux_inode_post_setxattr(),
> selinux_inode_setsecurity(), selinux_setprocattr(),
> etc.) who will call security_context_to_sid(). If I
> now change security_context_to_sid(), let it call
> kmalloc with GFP_ATOMIC rather than its original
> GFP_KERNEL, will this change cause problem when other
> hook functions call the modified
> security_context_to_sid() function? 

It could cause them to fail under memory pressure rather than blocking
and waiting for memory to become available.  It would be preferable to
change your code to convert the context to a SID while in process
context, then use the saved SID when in non-blocking context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
