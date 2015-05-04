Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t44JhbgR003814
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 15:43:37 -0400
Received: by qgeb100 with SMTP id b100so70921598qge.3
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 12:43:30 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/1] signals: don't abuse __flush_signals() in
 selinux_bprm_committed_creds()
Date: Mon, 04 May 2015 15:43:28 -0400
Message-ID: <10375684.YIDl5mrJKW@sifl>
In-Reply-To: <20150504164558.GB10118@redhat.com>
References: <1430502057.4472.255.camel@redhat.com>
 <20150504164535.GA10118@redhat.com> <20150504164558.GB10118@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: kvm <kvm@vger.kernel.org>, Neil Brown <neilb@suse.de>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, selinux@tycho.nsa.gov,
 Evgeniy Polyakov <zbr@ioremap.net>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, May 04, 2015 06:45:58 PM Oleg Nesterov wrote:
> selinux_bprm_committed_creds()->__flush_signals() is not right, we
> shouldn't clear TIF_SIGPENDING unconditionally. There can be other
> reasons for signal_pending(): freezing(), JOBCTL_PENDING_MASK, and
> potentially more.
> 
> Also change this code to check fatal_signal_pending() rather than
> SIGNAL_GROUP_EXIT, it looks a bit better.
> 
> Now we can kill __flush_signals() before it finds another buggy user.

[NOTE: Added the SELinux list to the CC line]

This looks reasonable to me, I'm going to apply it to selinux#next today.

> Note: this code looks racy, we can flush a signal which was sent after
> the task SID has been updated.

The whole signal flush thread has started some discussions about how we are 
currently handling this, and if it still makes sense.  Like many things, it 
seemed like a good idea at the time, but after several years we're debating if 
that is still the case.  I expect we'll be changing this code soon.

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/sched.h    |    1 -
>  kernel/signal.c          |   13 ++++---------
>  security/selinux/hooks.c |    6 ++++--
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8db31ef..eb1ac84 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2345,7 +2345,6 @@ extern void sched_dead(struct task_struct *p);
> 
>  extern void proc_caches_init(void);
>  extern void flush_signals(struct task_struct *);
> -extern void __flush_signals(struct task_struct *);
>  extern void ignore_signals(struct task_struct *);
>  extern void flush_signal_handlers(struct task_struct *, int force_default);
> extern int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
> siginfo_t *info); diff --git a/kernel/signal.c b/kernel/signal.c
> index 16a3052..837ca7d 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -414,21 +414,16 @@ void flush_sigqueue(struct sigpending *queue)
>  }
> 
>  /*
> - * Flush all pending signals for a task.
> + * Flush all pending signals for this kthread.
>   */
> -void __flush_signals(struct task_struct *t)
> -{
> -	clear_tsk_thread_flag(t, TIF_SIGPENDING);
> -	flush_sigqueue(&t->pending);
> -	flush_sigqueue(&t->signal->shared_pending);
> -}
> -
>  void flush_signals(struct task_struct *t)
>  {
>  	unsigned long flags;
> 
>  	spin_lock_irqsave(&t->sighand->siglock, flags);
> -	__flush_signals(t);
> +	clear_tsk_thread_flag(t, TIF_SIGPENDING);
> +	flush_sigqueue(&t->pending);
> +	flush_sigqueue(&t->signal->shared_pending);
>  	spin_unlock_irqrestore(&t->sighand->siglock, flags);
>  }
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6da7532..6907d11 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2397,10 +2397,12 @@ static void selinux_bprm_committed_creds(struct
> linux_binprm *bprm) for (i = 0; i < 3; i++)
>  			do_setitimer(i, &itimer, NULL);
>  		spin_lock_irq(&current->sighand->siglock);
> -		if (!(current->signal->flags & SIGNAL_GROUP_EXIT)) {
> -			__flush_signals(current);
> +		if (!fatal_signal_pending(current)) {
> +			flush_sigqueue(&current->pending);
> +			flush_sigqueue(&current->signal->shared_pending);
>  			flush_signal_handlers(current, 1);
>  			sigemptyset(&current->blocked);
> +			recalc_sigpending();
>  		}
>  		spin_unlock_irq(&current->sighand->siglock);
>  	}

-- 
paul moore
www.paul-moore.com
