Message-ID: <20050107144100.53289.qmail@web51507.mail.yahoo.com>
Date: Fri, 7 Jan 2005 06:41:00 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: BUG in security_context_to_sid() ?
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: jmorris@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <1105101368.28680.20.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 07 Jan 2005 at 07:36, Stephen Smalley wrote:
> security_context_to_sid() is presently only called 
> when it is safe to sleep; thus, it calls kmalloc 
> with GFP_KERNEL rather than GFP_ATOMIC when it 
> makes a copy of the context for processing.  If you 
> truly need to use it from non-blocking context, 
> then it would need to be changed to use 
> GFP_ATOMIC.  

Thanks.

Because there are also other hook functions (such as
selinux_inode_setxattr(),
selinux_inode_post_setxattr(),
selinux_inode_setsecurity(), selinux_setprocattr(),
etc.) who will call security_context_to_sid(). If I
now change security_context_to_sid(), let it call
kmalloc with GFP_ATOMIC rather than its original
GFP_KERNEL, will this change cause problem when other
hook functions call the modified
security_context_to_sid() function? 

Thanks again.



=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
