Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tADNJVEX011476
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 18:19:31 -0500
Received: by vkas68 with SMTP id s68so1197025vka.2
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 15:19:21 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Vladis Dronov <vdronov@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH v3] selinux: rate-limit unrecognized netlink message
 warnings in selinux_nlmsg_perm()
Date: Fri, 13 Nov 2015 18:19:19 -0500
Message-ID: <2348546.OvGczhv81B@sifl>
In-Reply-To: <1447424059-11174-1-git-send-email-vdronov@redhat.com>
References: <1447424059-11174-1-git-send-email-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 13, 2015 03:14:19 PM Vladis Dronov wrote:
> Any process is able to send netlink messages with invalid types.
> Make the warning rate-limited to prevent too much log spam.
> 
> The warning is supposed to help to find misbehaving programs, so
> print the triggering command name and pid.
> 
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  security/selinux/hooks.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to my selinux@next queue, with the merge window expected to close this 
weekend, this patch should appear in linux-next sometime next week.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d0cfaa9..791fc46 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4785,11 +4785,12 @@ static int selinux_nlmsg_perm(struct sock *sk,
> struct sk_buff *skb) err = selinux_nlmsg_lookup(sksec->sclass,
> nlh->nlmsg_type, &perm); if (err) {
>  		if (err == -EINVAL) {
> -			printk(KERN_WARNING
> -			       "SELinux: unrecognized netlink message:"
> -			       " protocol=%hu nlmsg_type=%hu sclass=%s\n",
> +			pr_warn_ratelimited("SELinux: unrecognized netlink"
> +			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
> +			       " pig=%d comm=%s\n",
>  			       sk->sk_protocol, nlh->nlmsg_type,
> -			       secclass_map[sksec->sclass - 1].name);
> +			       secclass_map[sksec->sclass - 1].name,
> +			       task_pid_nr(current), current->comm);
>  			if (!selinux_enforcing || security_get_allow_unknown())
>  				err = 0;
>  		}

-- 
paul moore
www.paul-moore.com
