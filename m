Subject: Re: BUG in security_context_to_sid() ?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <20050107082301.94911.qmail@web51502.mail.yahoo.com>
References: <20050107082301.94911.qmail@web51502.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1105101368.28680.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 07 Jan 2005 07:36:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-07 at 03:23, Park Lee wrote:
>     But, every time, when security_context_to_sid() is
> called in the hook, the kernel yield a oops as the
> following:
> 
> 
> Debug: sleeping function called from invalid context
> at mm/slab.c:1980

security_context_to_sid() is presently only called when it is safe to
sleep; thus, it calls kmalloc with GFP_KERNEL rather than GFP_ATOMIC
when it makes a copy of the context for processing.  If you truly need
to use it from non-blocking context, then it would need to be changed to
use GFP_ATOMIC.  But it would be better if you were to convert the
context to a SID earlier while in a process context and then just use
the SID later.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
