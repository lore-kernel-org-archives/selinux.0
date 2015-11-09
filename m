Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA9A2gHq010143
 for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2015 05:02:42 -0500
Date: Mon, 9 Nov 2015 05:02:19 -0500 (EST)
From: Vladis Dronov <vdronov@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Message-ID: <378524479.8390541.1447063339365.JavaMail.zimbra@redhat.com>
In-Reply-To: <6523918.byncHZAcJK@sifl>
References: <1446649357-8334-1-git-send-email-vdronov@redhat.com>
 <6523918.byncHZAcJK@sifl>
Subject: Re: [PATCH v2] selinux: rate-limit unrecognized netlink message
 warnings in selinux_nlmsg_perm()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello, Paul.

>> Did you want the "Reported-by" tag included?  I'm also adding the SELinux list 
>> back to the CC line.

Yes, could you please, indeed include lost line "Reported-by: Florian Weimer <fweimer@redhat.com>".
It was my fault of omitting it while re-composing commit message.

Vladis Dronov | Red Hat, Inc.
| Product Security Engineer |

----- Original Message -----
From: "Paul Moore" <paul@paul-moore.com>
To: "Vladis Dronov" <vdronov@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Sent: Friday, November 6, 2015 6:33:39 PM
Subject: Re: [PATCH v2] selinux: rate-limit unrecognized netlink message warnings in selinux_nlmsg_perm()

On Wednesday, November 04, 2015 04:02:36 PM Vladis Dronov wrote:
> Any process is able to send netlink messages with invalid types.
> Make the warning rate-limited to prevent too much log spam.
> 
> The warning is supposed to help to find misbehaving programs, so
> print the triggering command name and pid.
> 
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  security/selinux/hooks.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Did you want the "Reported-by" tag included?  I'm also adding the SELinux list 
back to the CC line.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4369d8..3d8087d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4787,11 +4787,12 @@ static int selinux_nlmsg_perm(struct sock *sk,
> struct sk_buff *skb) err = selinux_nlmsg_lookup(sksec->sclass,
> nlh->nlmsg_type, &perm); if (err) {
>  		if (err == -EINVAL) {
> -			printk(KERN_WARNING
> -			       "SELinux: unrecognized netlink message:"
> -			       " protocol=%hu nlmsg_type=%hu sclass=%s\n",
> +			pr_warn_ratelimited("SELinux: unrecognized netlink"
> +			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
> +			       " from %s[%d]\n",
>  			       sk->sk_protocol, nlh->nlmsg_type,
> -			       secclass_map[sksec->sclass - 1].name);
> +			       secclass_map[sksec->sclass - 1].name,
> +			       current->comm, current->pid);
>  			if (!selinux_enforcing || security_get_allow_unknown())
>  				err = 0;
>  		}

-- 
paul moore
www.paul-moore.com
