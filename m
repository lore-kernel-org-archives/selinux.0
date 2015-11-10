Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAAN7Yar004777
 for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2015 18:07:35 -0500
Received: by igbhv6 with SMTP id hv6so11225522igb.0
 for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2015 15:07:25 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Vladis Dronov <vdronov@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] selinux: rate-limit unrecognized netlink message
 warnings in selinux_nlmsg_perm()
Date: Tue, 10 Nov 2015 18:07:23 -0500
Message-ID: <3886271.4xVUv1O130@sifl>
In-Reply-To: <1446633352-5070-1-git-send-email-vdronov@redhat.com>
References: <1446633352-5070-1-git-send-email-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, November 04, 2015 11:35:51 AM Vladis Dronov wrote:
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
> 
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

I should have looked at more closely at the actual changes earlier, but the 
other issues with your posting distracted me ... while this isn't an audit 
message, it tends to follow the audit-ish name=value format so let's stick 
with that in this message, I would also suggest using task_pid_nr() so the 
line should look something like this:

  pr_warn_ratelimited("SELinux: unrecognized netlink"
                      " message: protocol=%hu nlmsg_type=%hu sclass=%s"
                      " pig=%d comm=%s\n",
                      sk->sk_protocol, nlh->nlmsg_type,
                      secclass_map[sksec->sclass - 1].name,
                      task_pid_nr(current), current->comm);

-- 
paul moore
www.paul-moore.com
