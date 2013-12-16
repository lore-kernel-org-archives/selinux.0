Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBGLCWII017430
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2013 16:12:32 -0500
Received: by mail-qc0-f179.google.com with SMTP id i8so4204491qcq.10
        for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2013 13:12:31 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <james.l.morris@oracle.com>,
        Eric Paris <eparis@parisplace.org>, Evan McNabb <emcnabb@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH v2] selinux: selinux_setprocattr()->ptrace_parent() needs rcu_read_lock()
Date: Mon, 16 Dec 2013 16:12:28 -0500
Message-ID: <8620584.RBbmYcQIT9@sifl>
In-Reply-To: <20131214163317.GB21675@redhat.com>
References: <20131205165953.GA24844@redhat.com> <20131214163256.GA21675@redhat.com> <20131214163317.GB21675@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday, December 14, 2013 05:33:17 PM Oleg Nesterov wrote:
> selinux_setprocattr() does ptrace_parent(p) under task_lock(p),
> but task_struct->alloc_lock doesn't pin ->parent or ->ptrace,
> this looks confusing and triggers the "suspicious RCU usage"
> warning because ptrace_parent() does rcu_dereference_check().
> 
> And in theory this is wrong, spin_lock()->preempt_disable()
> doesn't necessarily imply rcu_read_lock() we need to access
> the ->parent.
> 
> Reported-by: Evan McNabb <emcnabb@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  security/selinux/hooks.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5503,11 +5503,11 @@ static int selinux_setprocattr(struct ta
>  		/* Check for ptracing, and update the task SID if ok.
>  		   Otherwise, leave SID unchanged and fail. */
>  		ptsid = 0;
> -		task_lock(p);
> +		rcu_read_lock();
>  		tracer = ptrace_parent(p);
>  		if (tracer)
>  			ptsid = task_sid(tracer);
> -		task_unlock(p);
> +		rcu_read_unlock();
> 
>  		if (tracer) {
>  			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
