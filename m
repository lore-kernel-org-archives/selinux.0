Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8MJt7um030302
 for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2014 15:55:07 -0400
From: Paul Moore <pmoore@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] selinux: hooks: cleanup orphan keywords in audit log text
Date: Mon, 22 Sep 2014 15:55:08 -0400
Message-ID: <1456449.0ADpScPp6d@sifl>
In-Reply-To: <8bedc57ef45bf628ac344bc3d8513b9a93e274ca.1411087339.git.rgb@redhat.com>
References: <8bedc57ef45bf628ac344bc3d8513b9a93e274ca.1411087339.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, eparis@redhat.com,
 linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, sgrubb@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, September 18, 2014 08:50:17 PM Richard Guy Briggs wrote:
> Convert audit_log() call to WARN_ONCE().
>
> Rename "type=" to nlmsg_type=" to avoid confusion with the audit record
> type.
> 
> Added "protocol=" to help track down which protocol (NETLINK_AUDIT?) was
> used within the netlink protocol family.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/hooks.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

I rewrote the patch subject line as it doesn't really make much sense given 
the changes made by the patch, but other than that it looks fine to me.

Applied.
 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 83d06db..28ec61c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4681,10 +4681,9 @@ static int selinux_nlmsg_perm(struct sock *sk, struct
> sk_buff *skb) err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type,
> &perm); if (err) {
>  		if (err == -EINVAL) {
> -			audit_log(current->audit_context, GFP_KERNEL, 
AUDIT_SELINUX_ERR,
> -				  "SELinux:  unrecognized netlink message"
> -				  " type=%hu for sclass=%hu\n",
> -				  nlh->nlmsg_type, sksec->sclass);
> +			WARN_ONCE(1, "selinux_nlmsg_perm: unrecognized netlink 
message:"
> +				  " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
> +				  sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
>  			if (!selinux_enforcing || security_get_allow_unknown())
>  				err = 0;
>  		}

-- 
paul moore
security and virtualization @ redhat
