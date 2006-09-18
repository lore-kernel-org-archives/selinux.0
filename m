Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IICdJF016511
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 14:12:39 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IIC9uA027169
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 18:12:10 GMT
Date: Mon, 18 Sep 2006 14:12:36 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 6/7] secid reconciliation-v02: Label locally generated
 IPv4 traffic
In-Reply-To: <45019F6F.9090500@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609181412150.5976@d.namei>
References: <45019F6F.9090500@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Sep 2006, Venkat Yekkirala wrote:

> diff --git a/include/net/ip.h b/include/net/ip.h
> index 98f9084..4646c13 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -48,6 +48,9 @@ struct ipcm_cookie
> 	u32			addr;
> 	int			oif;
> 	struct ip_options	*opt;
> +#ifdef CONFIG_SECURITY_NETWORK
> +	__u32			secid;
> +#endif /* CONFIG_SECURITY_NETWORK */
> };

This field should be 'u32'.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
