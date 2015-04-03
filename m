Message-ID: <551E8647.6020405@tycho.nsa.gov>
Date: Fri, 03 Apr 2015 08:23:35 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Marek Milkovic <mmilkovi@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Print 'sclass' as string when unrecognized
 netlink message occurs
References: <1427990294-19573-1-git-send-email-mmilkovi@redhat.com>
In-Reply-To: <1427990294-19573-1-git-send-email-mmilkovi@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/02/2015 11:58 AM, Marek Milkovic wrote:
> This prints the 'sclass' field as string instead of index in unrecognized netlink message.
> The textual representation makes it easier to distinguish the right class.
> 
> Signed-off-by: Marek Milkovic <mmilkovi@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 87a9156..d75f525 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4712,8 +4712,8 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
>  		if (err == -EINVAL) {
>  			printk(KERN_WARNING
>  			       "SELinux: unrecognized netlink message:"
> -			       " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
> -			       sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
> +			       " protocol=%hu nlmsg_type=%hu sclass=%s\n",
> +			       sk->sk_protocol, nlh->nlmsg_type, secclass_map[sksec->sclass - 1].name);
>  			if (!selinux_enforcing || security_get_allow_unknown())
>  				err = 0;
>  		}
> 
