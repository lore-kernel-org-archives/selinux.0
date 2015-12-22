Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBMDoUmZ017803
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 08:50:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id B4DB220D2B
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 08:50:22 -0500 (EST)
Subject: Re: [RFC PATCH 16/17] calipso: Add validation of CALIPSO option.
To: Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <1450784813-18304-17-git-send-email-huw@codeweavers.com>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <5679551C.4000105@stressinduktion.org>
Date: Tue, 22 Dec 2015 14:50:20 +0100
MIME-Version: 1.0
In-Reply-To: <1450784813-18304-17-git-send-email-huw@codeweavers.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 22.12.2015 12:46, Huw Davies wrote:
>  
> +/* CALIPSO RFC 5570 */
> +
> +static bool ipv6_hop_calipso(struct sk_buff *skb, int optoff)
> +{
> +	const unsigned char *nh = skb_network_header(skb);
> +
> +	if (nh[optoff + 1] < 8)
> +		goto drop;
> +
> +	if (nh[optoff + 6] * 4 + 8 > nh[optoff + 1])
> +		goto drop;
> +
> +	if (!calipso_validate(skb, nh + optoff))
> +		goto drop;
> +
> +	return true;
> +
> +drop:
> +	kfree_skb(skb);
> +	return false;
> +}
> +

Formally, if an extension header could not be processed, the packet
should be discarded and an icmp error parameter extension should be
send. I think we shouldn't let those packets pass here.

Thanks,
Hannes
