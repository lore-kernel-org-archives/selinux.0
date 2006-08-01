Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71N9tjJ008824
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 19:09:55 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k71N9jXQ025010
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 23:09:45 GMT
Date: Tue, 1 Aug 2006 19:09:50 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [RFC 2/3] secid reconciliation on inbound: add LSM hooks
In-Reply-To: <44CFD0E2.9070709@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0608011908430.14724@d.namei>
References: <44CFD0E2.9070709@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Aug 2006, Venkat Yekkirala wrote:

> -	if (err)
> -		goto out;
> +	/* if (err) */
> +	/*	goto out; */
> 
> -	err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
> -out:	+	/* err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad); */
> +out:	 	return err;
> }


Did you mean to leave the call to selinux_xfrm_sock_rcv_skb() commented 
out?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
