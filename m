Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6E53cSJ023123
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 01:03:38 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6E53aTB026142
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 05:03:37 GMT
Date: Fri, 14 Jul 2006 01:03:34 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix memory leak
In-Reply-To: <44B667C6.20905@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0607140103210.11747@d.namei>
References: <44B667C6.20905@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jul 2006, Darrel Goeddel wrote:

> This patch fixes a possible memory leak when a policydb structure
> is destroyed.
> 
> Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>

Acked-by: James Morris <jmorris@namei.org>

> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 0111990..f03960e 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -644,10 +644,18 @@ void policydb_destroy(struct policydb *p
> 	kfree(lra);
> 
> 	for (rt = p->range_tr; rt; rt = rt -> next) {
> -		kfree(lrt);
> +		if (lrt) {
> +			ebitmap_destroy(&lrt->range.level[0].cat);
> +			ebitmap_destroy(&lrt->range.level[1].cat);
> +			kfree(lrt);
> +		}
> 		lrt = rt;
> 	}
> -	kfree(lrt);
> +	if (lrt) {
> +		ebitmap_destroy(&lrt->range.level[0].cat);
> +		ebitmap_destroy(&lrt->range.level[1].cat);
> +		kfree(lrt);
> +	}
> 
> 	if (p->type_attr_map) {
> 		for (i = 0; i < p->p_types.nprim; i++)
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
