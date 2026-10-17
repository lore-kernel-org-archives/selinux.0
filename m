Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33A37DAC2;
	Sat, 17 Oct 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247879; cv=none; b=F6kFINst8FdoxuU5udmCJ5zO7xU9ozDFWOAnIH/ilynU8Jm4SmC6PLhSvE0jSBk8A7X4zIUNjR9XRPDMI7tG84XfCWpQwaQiBJvYq9YyxyqeFmg7T3HuRmHOOOk5Itw/5EDPfGxbbsBxDYR7kFnHlaLqRESG5eJ3R0HRvZ5HoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247879; c=relaxed/simple;
	bh=x/aOhlxGADt+uUWRmu0GwWfYW6nUAyrbkaeIAa3hlB0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SJuRfzVAjdA4QVThzRx5mREL/rZwP0b2de6PKu39puvIMuYN3rXlgo0iCInAMO+ZgHaIaijOv+1WZtThblA6dN8bvRIh0HwEzNPu21GFtCHOWkezbzbu0bjSl17OPVXuBZLJ6iqdOE9He/+C9I3tVAfhoiTSvnFt/tBWDrfMON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUjuSRmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUjuSRmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A761F000C4;
	Sat, 17 Oct 2026 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247878;
	bh=Y8Q4FeE0kHfspVpRiojxBFrzT3w8ffKEJfPLx5saYhA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AUjuSRmXJuFSZA5JNXxyGjqxHRQmV8U/GwaSG/iNb6JfJ8ungbTYz1I3gknFWcl9M
	 SfaXw7WGitVbEvVfE4bkHUGvmopqUa7jEGt+7RBfvc1AK/97r+QNJ9JwA6eVb4CFUo
	 GC5FIoGlba6zqXf37lNJueC3q5Y/1G2u+5NizLjKnefaRVfn7Il5M/Q9GYDnVHlgWN
	 vjjb2FQtdcg3IAMkQKBV6U7WBK/lAKnux1Fq2tFQIOs+vUkBKZ/hLiSbp8OcRttAK0
	 AmPQLJtsFYNoa4SC6fafnK9O/EUS6l7oBJG0c68JsHZGRYyrm9ftVZGUSVGbPJGnlO
	 yMvDhHUhaYYJQ==
Message-ID: <sashiko-outbox-175561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: don't label bridged packets in
 selinux_ip_forward()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>
References: <179216146138.25460.7866279004288174372@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:37:57 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] selinux: NetLabel bypass for routed bridge packets in selinux_ip_f=
orward()
--

commit aa9d29a0c0e705f6d7d92b6c1e12ec004af2b214
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

selinux: don't label bridged packets in selinux_ip_forward()

This commit avoids labeling bridged IP packets in selinux_ip_forward() to
prevent MAC and EtherType corruption when adding or removing CIPSO or
CALIPSO options. It adds nf_bridge_info_exists() to skip bridged packets
since labeling based on IP addresses is unwanted there.

Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6E=
hAuu4qfUFe_mw@mail.gmail.com/

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13d..735e4889bd5b7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
[ ... ]
> @@ -6021,11 +6022,13 @@ static unsigned int selinux_ip_forward(void *priv=
, struct sk_buff *skb,
>  				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
>  			return NF_DROP;
> =20
> -	if (netlbl_enabled())
> -		/* we do this in the FORWARD path and not the POST_ROUTING
> -		 * path because we want to make sure we apply the necessary
> -		 * labeling before IPsec is applied so we can leverage AH
> -		 * protection */
> +	/* we do this in the FORWARD path and not the POST_ROUTING path
> +	 * because we want to make sure we apply the necessary labeling
> +	 * before IPsec is applied so we can leverage AH protection; bridged
> +	 * packets are skipped as changing their IP options would leave the
> +	 * Ethernet header behind
> +	 */
> +	if (netlbl_enabled() && !nf_bridge_info_exists(skb))
>  		if (selinux_netlbl_skbuff_setsid(skb, family, peer_sid) !=3D 0)
>  			return NF_DROP;

[Severity: High]
Does this logic inadvertently skip NetLabel tagging for packets that are
legitimately routed rather than just bridged?

If a packet arrives on a bridge port, receives the SKB_EXT_BRIDGE_NF extens=
ion
in br_nf_pre_routing(), and is destined for the host's MAC address, it is
passed up to the local IP stack via br_pass_frame_up().

Since the bridge extension is not freed on the local input path, the packet
retains it.

When the packet is subsequently L3 forwarded via ip_forward(), the
NF_INET_FORWARD hook calls selinux_ip_forward().

Because nf_bridge_info_exists(skb) evaluates to true for these routed packe=
ts,
it appears SELinux will erroneously skip the NetLabel tagging, potentially
allowing a remote or local unprivileged attacker to bypass network security
policies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179216146138.25460.=
7866279004288174372@gmail.com?part=3D1
