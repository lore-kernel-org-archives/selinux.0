Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LEYjas023763
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 10:34:45 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LEYisi004712
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 14:34:44 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5LEY5eq028149
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 10:34:05 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5LEY5fu028148
	for selinux@tycho.nsa.gov; Wed, 21 Jun 2006 10:34:05 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5L0fa9I012026
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 20:41:36 -0400
Received: from arnor.apana.org.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5L0fTOh028062
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 00:41:30 GMT
Date: Wed, 21 Jun 2006 10:41:14 +1000
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 03/06] MLSXFRM: Add security sid to sock
Message-ID: <20060621004114.GA31992@gondor.apana.org.au>
References: <44983D36.8070609@trustedcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44983D36.8070609@trustedcs.com>
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 20, 2006 at 06:23:50PM +0000, Venkat Yekkirala wrote:
>
> --- linux-2.6.16.vanilla/include/net/sock.h	2006-06-19 
> 17:02:23.000000000 -0500
> +++ linux-2.6.16/include/net/sock.h	2006-06-19 19:48:24.000000000 -0500
> @@ -964,6 +964,15 @@ static inline void sock_graft(struct soc
> 	write_unlock_bh(&sk->sk_callback_lock);
> }
> 
> +static inline void sock_copy(struct sock *nsk, const struct sock *osk)
> +{
> +	void *sptr = nsk->sk_security;
> +
> +	memcpy(nsk, osk, osk->sk_prot->obj_size);
> +	nsk->sk_security = sptr;

I don't get it.  Why do you put sk_security away and then set it back.
Doesn't memcpy already do this for you?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
