Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAE03AMP005639
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 19:03:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3ybRWW6Nd9zrKdC
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 23:22:47 +0000 (UTC)
Received: from UPDC3CPA06.eemsg.mil (unknown [192.168.18.13])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3ybRWW5WlFzrKdY
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 23:22:47 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id s16so19841609lfs.1
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 14:13:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113205422.2918-1-richard_c_haines@btinternet.com>
References: <20171113205422.2918-1-richard_c_haines@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Nov 2017 17:13:34 -0500
Message-ID: <CAHC9VhT-mALY2UB2nR2fOu5Bc-RRTQw0oXed1OJZNFv2KAcK3w@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] netlabel: If PF_INET6,
 check sk_buff ip header version
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 13, 2017 at 3:54 PM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> When resolving a fallback label, check the sk_buff version as it
> is possible (e.g. SCTP) to have family = PF_INET6 while
> receiving ip_hdr(skb)->version = 4.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  net/netlabel/netlabel_unlabeled.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Thanks Richard.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 22dc1b9..c070dfc 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1472,6 +1472,16 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
>                 iface = rcu_dereference(netlbl_unlhsh_def);
>         if (iface == NULL || !iface->valid)
>                 goto unlabel_getattr_nolabel;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +       /* When resolving a fallback label, check the sk_buff version as
> +        * it is possible (e.g. SCTP) to have family = PF_INET6 while
> +        * receiving ip_hdr(skb)->version = 4.
> +        */
> +       if (family == PF_INET6 && ip_hdr(skb)->version == 4)
> +               family = PF_INET;
> +#endif /* IPv6 */
> +
>         switch (family) {
>         case PF_INET: {
>                 struct iphdr *hdr4;
> --
> 2.13.6

-- 
paul moore
www.paul-moore.com
