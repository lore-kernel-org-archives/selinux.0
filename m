Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5PCmlSC011323
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 08:48:47 -0400
Received: from e36.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5PCmW0s012041
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 12:48:33 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5PClIfC008573
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 06:47:18 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5PCmjP6217378
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 06:48:45 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5PCmZMb017730
	for <selinux@tycho.nsa.gov>; Thu, 25 Jun 2009 06:48:44 -0600
Date: Thu, 25 Jun 2009 07:48:39 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: Linux Containers <containers@lists.osdl.org>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH] c/r: tighten ptrace checking for checkpoint to
	PTRACE_MODE_ATTACH
Message-ID: <20090625124839.GA29757@us.ibm.com>
References: <1245922467-9444-1-git-send-email-orenl@cs.columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245922467-9444-1-git-send-email-orenl@cs.columbia.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Oren Laadan (orenl@cs.columbia.edu):
> Security modules distinguish reading of process state (via proc) from
> full ptrace access using the access mode: PTRACE_MODE_{READ,ATTACH}.
> 
> Read access to /proc/pid/mem requires a full ptrace attach (for more
> details, see: http://lwn.net/Articles/282930/).
> 
> Checkpoint needs access to full process state, including memory, so
> we require PTRACE_MODE_ATTACH.
> 
> Signed-off-by: Oren Laadan <orenl@cs.columbia.edu>

Acked-by: Serge Hallyn <serue@us.ibm.com>

thanks,
-serge

> ---
>  checkpoint/checkpoint.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/checkpoint/checkpoint.c b/checkpoint/checkpoint.c
> index 325dfa3..7b141e3 100644
> --- a/checkpoint/checkpoint.c
> +++ b/checkpoint/checkpoint.c
> @@ -296,7 +296,7 @@ static int may_checkpoint_task(struct ckpt_ctx *ctx, struct task_struct *t)
>  		return -EAGAIN;
>  	}
> 
> -	if (!ptrace_may_access(t, PTRACE_MODE_READ)) {
> +	if (!ptrace_may_access(t, PTRACE_MODE_ATTACH)) {
>  		__ckpt_write_err(ctx, "access to task %d (%s) denied",
>  				 task_pid_vnr(t), t->comm);
>  		return -EPERM;
> -- 
> 1.6.0.4

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
