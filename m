Message-ID: <451C9897.6030306@gentoo.org>
Date: Thu, 28 Sep 2006 23:52:55 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
References: <451C85F4.7000406@trustedcs.com>
In-Reply-To: <451C85F4.7000406@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> <snip>
> +
> +	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
> +					PACKET__FLOW_IN, NULL);
> +	if (err)
> +		goto out;
> +
> +	if (xfrm_sid) {
> +		err = security_transition_sid(xfrm_sid, skb->secmark,
> +						SECCLASS_PACKET, &trans_sid);
> +		if (err)
> +			goto out;
> +
>   
I thought we weren't doing transitions to label packets anymore per the 
conference call?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
