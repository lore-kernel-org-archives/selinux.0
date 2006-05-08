Subject: Re: [RFC][SECMARK 08/08] Add selinux_relabel_packet_permission()
	check to xt_SECMARK
From: Karl MacMillan <kmacmillan@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.samba.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0605071139330.8588@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
	 <Pine.LNX.4.64.0605071139330.8588@d.namei>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:54:35 -0400
Message-Id: <1147110876.32719.71.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-05-07 at 11:40 -0400, James Morris wrote:
> This patch adds the selinux_relabel_packet_permission() check to the 
> SECMARK target, so that SELinux policy is consulted to ensure that the 
> labeling operation is permitted by the current task.
> 
> 
> Signed-off-by: James Morris <jmorris@namei.org>
> 
> ---
> 
>  net/netfilter/xt_SECMARK.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff -purN -X dontdiff linux-2.6.17-rc3-git7.p/net/netfilter/xt_SECMARK.c linux-2.6.17-rc3-git7.w/net/netfilter/xt_SECMARK.c
> --- linux-2.6.17-rc3-git7.p/net/netfilter/xt_SECMARK.c	2006-05-03 11:34:12.000000000 -0400
> +++ linux-2.6.17-rc3-git7.w/net/netfilter/xt_SECMARK.c	2006-05-07 00:35:44.000000000 -0400
> @@ -72,6 +72,12 @@ static int checkentry_selinux(struct xt_
>  		return 0;
>  	}
>  
> +	err = selinux_relabel_packet_permission(sel->selsid);
> +	if (err) {
> +		printk(KERN_INFO PFX "unable to obtain relabeling permission\n");
> +		return 0;
> +	}
> +
>  	return 1;
>  }
>  
> 

Glad that you added this. This only checks on the addition of rules,
correct? Obviously changes that don't include an addition (e.g.,
removal) could change the labeling behavior. Is it possible / needed to
try to provide anything like the relabelto/relabelfrom pairing that is
present for files?

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
