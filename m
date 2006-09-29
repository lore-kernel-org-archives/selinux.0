Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8T7h0Vk010364
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 03:43:00 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8T7gQaq009602
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 07:42:26 GMT
Date: Fri, 29 Sep 2006 03:42:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        paul.moore@hp.com
Subject: Re: [PATCH 4/7] secid reconciliation-v03: Invoke LSM hook for outbound
 traffic
In-Reply-To: <451C85E2.2030201@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609290338050.1650@d.namei>
References: <451C85E2.2030201@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Sep 2006, Venkat Yekkirala wrote:

> +		}
> +		else	/* inbound */
> +			/* loopback traffic should already be labeled
> +			   and any filtering on outbound should suffice */
> +			if (in == &loopback_dev)
> +				goto out;

Minor nit that akpm will point out, the else belongs on the same line as 
the brace.  Also, the comment style is:

	/*
	 * Comment...
	 * etc.
	 */




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
