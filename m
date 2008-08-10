Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7A3OnZ5030173
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 23:24:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7A3Ontc029986
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2008 03:24:49 GMT
Message-ID: <489E5F5E.6070405@manicmethod.com>
Date: Sat, 09 Aug 2008 23:24:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: conditional expression type validation was off-by-one
References: <200808061546.m76Fkwq1005199@ruuvi.it.helsinki.fi> <alpine.LRH.1.10.0808070945400.15561@tundra.namei.org> <Pine.LNX.4.64L.0808081307500.24884@ruuvi.it.helsinki.fi> <Pine.LNX.4.64L.0808100425170.9655@ruuvi.it.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64L.0808100425170.9655@ruuvi.it.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vesa-Matti J Kari wrote:
> This is the same off-by-one bug that was already fixed in the kernel.
> (According to my understanding neither of these bugs has security
> implications)
> 
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
> ---
> 
>  include/sepol/policydb/conditional.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> Index: libsepol/include/sepol/policydb/conditional.h
> ===================================================================
> --- libsepol/include/sepol/policydb/conditional.h	(revision 2950)
> +++ libsepol/include/sepol/policydb/conditional.h	(working copy)
> @@ -48,7 +48,7 @@
>  #define COND_XOR	5	/* bool ^ bool */
>  #define COND_EQ		6	/* bool == bool */
>  #define COND_NEQ	7	/* bool != bool */
> -#define COND_LAST	8
> +#define COND_LAST	COND_NEQ
>  	uint32_t expr_type;
>  	uint32_t bool;
>  	struct cond_expr *next;
> 

Acked-by: Joshua Brindle <method@manicmethod.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
