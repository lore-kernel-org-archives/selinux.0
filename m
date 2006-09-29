Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8T7YlGl010211
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 03:34:47 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8T7YDaq008723
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 07:34:13 GMT
Date: Fri, 29 Sep 2006 03:34:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        paul.moore@hp.com
Subject: Re: [PATCH 6/7] secid reconciliation-v03: Label locally generated
 IPv4 traffic
In-Reply-To: <451C85EE.4030307@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609290333470.1650@d.namei>
References: <451C85EE.4030307@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Sep 2006, Venkat Yekkirala wrote:

> +static inline void security_skb_classify_ipcm(struct sk_buff *skb,
> +					struct ipcm_cookie *ipc)
> +{
> +	ipc->secid = 0;
> +	ipc->secid = skb->secmark;
> +}

You don't need the assignment to 0.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
