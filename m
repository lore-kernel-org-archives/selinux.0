Message-ID: <20050107150031.86228.qmail@web51506.mail.yahoo.com>
Date: Fri, 7 Jan 2005 07:00:31 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: BUG in security_context_to_sid() ?
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: jmorris@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <1105108684.28680.75.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fri, 07 Jan 2005 at 09:38, Stephen Smalley wrote:
> On Fri, 2005-01-07 at 09:39, Park Lee wrote:
> > Because there are also other hook functions (such 
> > as selinux_inode_setxattr(),
> > selinux_inode_post_setxattr(),
> > selinux_inode_setsecurity(),selinux_setprocattr(),
> > etc.) who will call security_context_to_sid(). If 
> > I now change security_context_to_sid(), let it 
> > call kmalloc with GFP_ATOMIC rather than its 
> > original GFP_KERNEL, will this change cause 
> > problem when other hook functions call the 
> > modified security_context_to_sid() function? 
>
> It could cause them to fail under memory pressure 
> rather than blocking and waiting for more memory to 
> become available.  
> As I said, it would be better if you would change 
> your code instead to convert the context to a SID 
> while in process context, then just use the SID 
> when in irq.

Thanks.

Would you please tell me what the "process context"
refers to? Where is the "process context"? Does the
"convert the context to a SID while in process
context" means calling security_context_to_sid()
function in process context?
( As I am a newbie in Linux kernel area, forgive my
ignorance please.)


=====
Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
