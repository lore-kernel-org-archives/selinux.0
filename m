Message-ID: <452A7D62.4030006@hp.com>
Date: Mon, 09 Oct 2006 12:48:34 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com, jbrindle@tresys.com, redhat-lspp@redhat.com
Subject: Re: [PATCH 1/1] selinux: secid reconciliation fixes V02
References: <452A6A2F.3040202@trustedcs.com>
In-Reply-To: <452A6A2F.3040202@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI: some changes need to be made to avoid compilation warnings (see below, and
selinux_ip_postroute_last() to see what I mean), I'm taking the liberty of
changing the patch myself.

Venkat Yekkirala wrote:
> -static int selinux_skb_flow_out(struct sk_buff *skb, u32 nf_secid)
> +static int selinux_skb_flow_out(struct sk_buff *skb, u32 nf_secid,
> +			const struct net_device *out, unsigned short family)
>  {
>  	int err;
> +	char *addrp;
> +	int len;
> +	struct avc_audit_data ad;

Add the following:

        struct net_device *dev = (struct net_device *)out;


>  	if (selinux_compat_net)
>  		return 1;
> @@ -3738,9 +3749,17 @@ static int selinux_skb_flow_out(struct s
>  		}
>  	}
>  
> +	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	ad.u.net.netif = out->name;

Replace the above line with:

        ad.u.net.netif = dev->name;

> +	ad.u.net.family = family;
> +	err = selinux_parse_skb(skb, &ad, &addrp, &len, 0);
> +	if (err)
> +		goto out;
> +
>  	err = avc_has_perm(skb->secmark, nf_secid, SECCLASS_PACKET,
> -				PACKET__FLOW_OUT, NULL);
> +				PACKET__FLOW_OUT, &ad);
>  
> +out:
>  	return err ? 0 : 1;
>  }

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
