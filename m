Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IIbjtN017285
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 14:37:45 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IIanex002645
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 18:36:50 GMT
Date: Mon, 18 Sep 2006 14:37:42 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 7/7] secid reconciliation-v02: Enforcement for SELinux
In-Reply-To: <45019F72.2050708@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609181436180.5976@d.namei>
References: <45019F72.2050708@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Sep 2006, Venkat Yekkirala wrote:

> +	if (selinux_compat_net) {
> +		err = selinux_xfrm_decode_session(skb, &peersid, 0);
> +		BUG_ON(err);

I'm pretty sure this should not be a BUG_ON.  IIUC, you want to panic the 
kernel because one of the nested SAs has a different security context.

> +	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
> +	BUG_ON(err);

Same.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
