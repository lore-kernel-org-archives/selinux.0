Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95KsfWQ003071
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:54:41 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95Ks5Zv023398
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 20:54:06 GMT
Date: Thu, 5 Oct 2006 16:54:38 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        johnpol@2ka.mipt.ru, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/3] Fix for IPsec leakage with SELinux enabled - V.03
In-Reply-To: <45256E33.8080205@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0610051651580.25705@d.namei>
References: <45256E33.8080205@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Oct 2006, Venkat Yekkirala wrote:

> -		if (xfrm_policy_match(pol, fl, type, family, dir)) {
> +		err = xfrm_policy_match(pol, fl, type, family, dir);
> +		if (err) {
> +			if (err == -ESRCH)
> +				continue;
> +			else {
> +				ret = ERR_PTR(err);
> +				goto fail;
> +			}
> +		} else {

Semantics issue: if the exact policy match fails with -EACCESS, should we 
then try an inexact match before failing?

>  #ifdef CONFIG_XFRM_SUB_POLICY
>  	pol = xfrm_policy_lookup_bytype(XFRM_POLICY_TYPE_SUB, fl, family, dir);
> -	if (pol)
> +	if (IS_ERR(pol)) {
> +		err = PTR_ERR(pol);
> +		pol = NULL;
> +	}
> +	if (pol || err)
>  		goto end;

Similarly, if the sub-policy lookup returns -EACCESS, should we then try a 
main policy lookup before failing?

I would think yes to both.

Opinions?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
