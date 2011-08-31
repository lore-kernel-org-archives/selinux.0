Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7VLIrDn015961
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 17:18:53 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7VLIqHE018366
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 21:18:52 GMT
Received: by wwf10 with SMTP id 10so1028582wwf.30
        for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 14:18:52 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: rongqing.li@windriver.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] Add a netlink attribute INET_DIAG_SECCTX
Date: Wed, 31 Aug 2011 17:18:47 -0400
Message-ID: <2593215.lUI7et83Qv@sifl>
In-Reply-To: <1314779777-12669-3-git-send-email-rongqing.li@windriver.com>
References: <1314779777-12669-1-git-send-email-rongqing.li@windriver.com> <1314779777-12669-3-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, August 31, 2011 04:36:17 PM rongqing.li@windriver.com wrote:
> From: Roy.Li <rongqing.li@windriver.com>
> 
> Add a new netlink attribute INET_DIAG_SECCTX to dump the security
> context of TCP sockets.

You'll have to forgive me, I'm not familiar with the netlink code used by 
netstat and friends, but is there anyway to report back the security context 
of UDP sockets?  Or does the code below handle that already?

In general, AF_INET and AF_INET6 sockets, regardless of any upper level 
protocols, have security contexts associated with them and it would be nice to 
see them in netstat.

> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 389a2e6..1faf752 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -34,6 +34,8 @@
> 
>  #include <linux/inet_diag.h>
> 
> +#define MAX_SECCTX_LEN 128

I'll echo Stephen's concerns that this is too small.  A MCS/MLS system with a 
moderate number of categories could bump into this limit without too much 
difficulty.

>  struct inet_diag_entry {
> @@ -108,6 +110,25 @@ static int inet_csk_diag_fill(struct sock *sk,
>  		       icsk->icsk_ca_ops->name);
>  	}
> 
> +	if (ext & (1 << (INET_DIAG_SECCTX - 1))) {
> +		u32 ctxlen = 0;
> +		void *secctx;
> +		int error;
> +
> +		error = security_sk_getsecctx(sk, &secctx, &ctxlen);
> +
> +		if (!error && ctxlen) {
> +			if (ctxlen < MAX_SECCTX_LEN) {
> +				strcpy(INET_DIAG_PUT(skb, INET_DIAG_SECCTX,
> +					ctxlen + 1), secctx);
> +			} else {
> +				strcpy(INET_DIAG_PUT(skb, INET_DIAG_SECCTX,
> +					2), "-");

Is the "-" string a special value already interpreted by the userspace tools?  
If not, you might consider using a string that would indicate an out-of-space 
condition occurred; at first glance I thought the "-" string indicated no 
context.

> +			}
> +			security_release_secctx(secctx, ctxlen);
> +		}
> +	}
> +
>  	r->idiag_family = sk->sk_family;
>  	r->idiag_state = sk->sk_state;
>  	r->idiag_timer = 0;
> @@ -246,7 +267,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff
> *skb, static int inet_diag_get_exact(struct sk_buff *in_skb,
>  			       const struct nlmsghdr *nlh)
>  {
> -	int err;
> +	int err, len;
>  	struct sock *sk;
>  	struct inet_diag_req *req = NLMSG_DATA(nlh);
>  	struct sk_buff *rep;
> @@ -293,10 +314,17 @@ static int inet_diag_get_exact(struct sk_buff *in_skb,
> goto out;
> 
>  	err = -ENOMEM;
> -	rep = alloc_skb(NLMSG_SPACE((sizeof(struct inet_diag_msg) +
> -				     sizeof(struct inet_diag_meminfo) +
> -				     handler->idiag_info_size + 64)),
> -			GFP_KERNEL);
> +	len = sizeof(struct inet_diag_msg) + 64;
> +
> +	len += (req->idiag_ext & (1 << (INET_DIAG_MEMINFO - 1))) ?
> +		sizeof(struct inet_diag_meminfo) : 0;
> +	len += (req->idiag_ext & (1 << (INET_DIAG_INFO - 1))) ?
> +		handler->idiag_info_size : 0;
> +	len += (req->idiag_ext & (1 << (INET_DIAG_SECCTX - 1))) ?
> +		MAX_SECCTX_LEN : 0;
> +
> +	rep = alloc_skb(NLMSG_SPACE(len), GFP_KERNEL);

How much of a problem would it be if you just allocated an entire page (or 4k 
in the case of huge pages) and used that?  Is memory usage a concern here?

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
