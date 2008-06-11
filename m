Subject: Re: [PATCH] SELinux: use do_each_thread as a proper do/while block
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0806120201140.5379@us.intercode.com.au>
References: <Xine.LNX.4.64.0806120201140.5379@us.intercode.com.au>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 12:08:49 -0400
Message-Id: <1213200529.17842.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 02:01 +1000, James Morris wrote:
> Please review.
> 
> ----
> Use do_each_thread as a proper do/while block.  Sparse complained.
> 
> Signed-off-by: James Morris <jmorris@namei.org>

We may wish to consider removing this restriction altogether, and/or
making it subject to a permission check.  Per-thread context can be
useful for multi-threaded server effectively acting as a userspace
object manager but wanting to set kernel context to avoid race
conditions on file accesses, ala the samba file server case.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6e8d0e9..4130d64 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5196,12 +5196,12 @@ static int selinux_setprocattr(struct task_struct *p,
>  			struct task_struct *g, *t;
>  			struct mm_struct *mm = p->mm;
>  			read_lock(&tasklist_lock);
> -			do_each_thread(g, t)
> +			do_each_thread(g, t) {
>  				if (t->mm == mm && t != p) {
>  					read_unlock(&tasklist_lock);
>  					return -EPERM;
>  				}
> -			while_each_thread(g, t);
> +			} while_each_thread(g, t);
>  			read_unlock(&tasklist_lock);
>  		}
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
