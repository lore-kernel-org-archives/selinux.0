Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBMDSJCO015936
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 08:28:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 4B62820D3C
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 08:28:05 -0500 (EST)
Subject: Re: [RFC PATCH 08/17] ipv6: Add ipv6_renew_options_kern() that
 accepts a kernel mem pointer.
To: Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <1450784813-18304-9-git-send-email-huw@codeweavers.com>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <56794FE3.7050507@stressinduktion.org>
Date: Tue, 22 Dec 2015 14:28:03 +0100
MIME-Version: 1.0
In-Reply-To: <1450784813-18304-9-git-send-email-huw@codeweavers.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 22.12.2015 12:46, Huw Davies wrote:
> The functionality is equivalent to ipv6_renew_options() except
> that the newopt pointer is in kernel, not user, memory
> 
> The kernel memory implementation will be used by the CALIPSO network
> labelling engine, which needs to be able to set IPv6 hop-by-hop
> options.
> 
> Signed-off-by: Huw Davies <huw@codeweavers.com>
> ---
>  include/net/ipv6.h |   6 +++
>  net/ipv6/exthdrs.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 125 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 9a5c9f0..5a72ffd 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -304,6 +304,12 @@ struct ipv6_txoptions *ipv6_renew_options(struct sock *sk,
>  					  int newtype,
>  					  struct ipv6_opt_hdr __user *newopt,
>  					  int newoptlen);
> +struct ipv6_txoptions *
> +ipv6_renew_options_kern(struct sock *sk,
> +			struct ipv6_txoptions *opt,
> +			int newtype,
> +			struct ipv6_opt_hdr *newopt,
> +			int newoptlen);
>  struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
>  					  struct ipv6_txoptions *opt);
>  
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index ea7c4d6..9426b26 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -734,11 +734,16 @@ ipv6_dup_options(struct sock *sk, struct ipv6_txoptions *opt)
>  EXPORT_SYMBOL_GPL(ipv6_dup_options);
>  
>  static int ipv6_renew_option(void *ohdr,
> -			     struct ipv6_opt_hdr __user *newopt, int newoptlen,
> +			     struct ipv6_opt_hdr __user *newopt_user,
> +			     struct ipv6_opt_hdr *newopt,
> +			     int newoptlen,
>  			     int inherit,
>  			     struct ipv6_opt_hdr **hdr,
>  			     char **p)


This looks quite ugly to me.

Wouldn't it be possible to do something like this:


ipv6_renew_option_kern(...)
{
	int ret;
	const mm_segment_t old_fs = get_fs();
	set_fs(KERNEL_DS);
	ret = ipv6_renew_option(...); // maybe you need to forcefully cast the
user away here
	set_fs(old_fs);
	return ret;
}

Bye,
Hannes
