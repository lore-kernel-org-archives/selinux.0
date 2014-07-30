Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6UF1Dv2024085
 for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2014 11:01:13 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so1585738qgd.9
 for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2014 08:01:17 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Milan Broz <gmazyland@gmail.com>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: properly label AF_ALG socket
Date: Wed, 30 Jul 2014 11:01:14 -0400
Message-ID: <10347850.4JK0gCtsfF@sifl>
In-Reply-To: <1406659269-8346-1-git-send-email-gmazyland@gmail.com>
References: <20140728150958.23156.75132.stgit@localhost>
 <1406659269-8346-1-git-send-email-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, July 29, 2014 08:41:09 PM Milan Broz wrote:
> Th AF_ALG socket was missing a security label (e.g. SELinux)
> which means that socket was in "unlabeled" state.
> 
> This was recently demonstrated in the cryptsetup package
> (cryptsetup v1.6.5 and later.)
> See https://bugzilla.redhat.com/show_bug.cgi?id=1115120
> 
> This patch clones the sock's label from the parent sock
> and resolves the issue (similar to AF_BLUETOOTH protocol family).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> ---
>  crypto/af_alg.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks Milan, this patch looks good to me.  Crypto folks, assuming no 
objections, could you try to push this patch this week so it hits 3.16 proper 
(assuming no more -rc releases)?  Without this patch the latest versions of 
cryptsetup could fail on a SELinux system leaving the system unable to boot 
with SELinux in enforcing mode.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 966f893..6a3ad80 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <linux/rwsem.h>
> +#include <linux/security.h>
> 
>  struct alg_type_list {
>  	const struct af_alg_type *type;
> @@ -243,6 +244,7 @@ int af_alg_accept(struct sock *sk, struct socket
> *newsock)
> 
>  	sock_init_data(newsock, sk2);
>  	sock_graft(sk2, newsock);
> +	security_sk_clone(sk, sk2);
> 
>  	err = type->accept(ask->private, sk2);
>  	if (err) {

-- 
paul moore
www.paul-moore.com
