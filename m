Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268567;
	b=PF5RE1pi8+ivnTzGoWjpK3CTcmsyRMaKP6Z5dTTbLhql9dKubxPA/lnTPIeAIqVsJMvt
	 9ZLhWw4vITBj98c3GNbhLFXui1j8RonoxN65Iu96f+nhATnFNHGD0QldQscSnNAEZgb6h
	 S9nQYZEuCmdTHKJnZACFvqHvZ0MXntE8kcBZ15/oKXN9nLSxobuj1kK71igUrclVgfPqx
	 QERr6AFQ8DVMHPq7i21VQig+SyFuVgdlLx4UqMJnj65mzkuFSe1c10xBj7Xk79cel5JA1
	 K1YVflO8EYdQieW8rV6pgbLM5iRHF8vP0imxCjiarbGxZbZwI3NKjuEYULj9dMvIurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
	b=2cSoGMGY37X43YWB6GzYv+eQXTPRecrOPOMReful8WVA6ZFj+u1jPBFCvYYnda/eP+Xu
	 vzWRgruNsw4HWbgLRa4LMPb6yxWMmmHhN8MUN2fSPhX2yds2Lox7dtcl0KDk7M9Wlz2fR
	 p9W5jwaVWqI0M0SifF0YjfAvJGEbPpMhdrcD4787PadDbEPznjobSPRIGzytUn86flXDl
	 PY4vco7oUExWa5ahaOwhDMzX4hG49Jnnw70gjpiDucUhsQG6KEbNmEnrqAx0JQ7GuJ2bY
	 eFnqb+OXGEGR0ThYW84T7F91Eyhc26g9zzhamqslUt6lXzqTogQ+5U+hbivd2VRq4jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Qz1X22J3;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9207606A325
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 23:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9207606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Qz1X22J3
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91eb53957cbso19921876d6.3
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 15:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794268565; x=1794873365; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
        b=Qz1X22J308Z0pwN4ph/SpbaqCDLhrYfm2/s985T7MYAxMwFI6+WtTal8ogRpJXmDZc
         YizbP4AaoI7JqwqSum0kIuNYtmrj9bYTw2Z4ZqOUJEMWH8IxZPx8V600M1H4wTQzMG0n
         dBeqV+zBkY9z6aFUUiYf4j/EHTQUhnR4vW9XpyU5tFEPwjOYWSVYr5d9zhk8GaHU04IN
         kagJuSxM6qk+XMD87K/Pfrwb+4tZHOEClPvbMnUi+Tx1OoA3pYl5nNvkBfepcZArxHiz
         yYOoFFVg1IqBYd+IJerZXSrI8KZgtwv9AVnQbWhlmi/VwLbWbKLyLAtQSSaws5TqG/zS
         p2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268565; x=1794873365;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
        b=s9zogEOg+UE0oB7mbltimmA+oeE+PHZR9h8cIIIYzCXejXkLMZ1c7ZJvQOxae07KOF
         ptYAUaA/jEYuRF+A0wg7nLK/mx6MFiuWleGCjQ6JPmOKxKnwStVjsdBJsQ4+c7kVRtkv
         Bd7/LoFqbTQV4pNCou3qVr9fhRdxPdeReDYGBXzSE/Z2Pmu0prEdwtCoMO/GPYKkdhPo
         whagqnqr+LKXchipdRtXdTU65G9PpPJPp+2ok50T2+kIajqgQ4KpYVXqHTna+Z/nnVIR
         HyvPZqmoW/YGISfms0sBfmUiwNxxL9YgiGGUsVUHcarozwQvXpiR6vT91kfVAiWId9Wj
         gH2Q==
X-Forwarded-Encrypted: i=1; AL+hErEMfMhxep9oH4mV+yDbK8EWOocyWjriqxtbn/v1pUugZFH8FGFBFLqZVcNhdCTHnZC9JRdvlRbu@vger.kernel.org
X-Gm-Message-State: APuU4Z9b/63uWLNDUVaakk8bS78UhHh1/e0/4uAqBdLbqTsDjW1qAf6P
	r0+4Oaopna9xvCXHGNA3PjN909OTY0A3NuDY+0BppVIL91ZlgNmVTjspdoLlPl7lP1luugu+wZz
	9Xbg=
X-Gm-Gg: AYBFou3igl49/+CQlZwcdNqWzMtTbH5Y210AkGC8jkAsTZby0D96Zb3W8dmguVd1/hN
	GNsrir5FbFarHnEh2gHg4WbcfQmkdxJoMzM2UnhY6W9gpWCixuLH2WB8uOvHMnCDkZ9iC1KxH4i
	fVCJRt/4jl5Vlvnbt5BkxRA0fJGkimbhWmBw2I1kwDs17mHdrN5ipfR4umTMv3qFdLvlTCP70oP
	huvpWqtwrhJIpvlJD1k4h61PKX6C6VkAB2/p2ZToDOJuVuJBoPdvLSu6rAuNK2zaAFRoih+d+8h
	+UoZzWiT3Ww9hGnSq/76YqPJemQECmHz//vJNKEgXZaa3cF6MD7Lh9YmUMtz7oGhZNnInzFCDM7
	hvRh1RcHK2Gjo4qQ+ja0vWhF2qvyPKyrPTEwAxY7z3APwaVHD5kQU++r2isG0dqMwqK29LBKY9Z
	YgtJA0HYyHVzNGrtkhlf35JvkJEaHQ5NFCHGfcSKyMNGuaF1pLb7X+9JTLQBym1E/P9U/k6USjO
	3zW8QAq7kjFgYxa0CMGktuOdnL6RJboSTA7B5aAdx++a4wo1F3gkyoheSxT7121IC1/jZ4n9PgB
	x5o5XdN54qsZDnZj10ZzE9i7Aax21VgNc+RnxS3tigV82pf4gYaNRE0T3A9da5tKmJ376402E/O
	YLd49ncV4ubFmK92Bm0SJk0/hyhyLDiw=
X-Received: by 2002:a05:6214:54c8:b0:91b:5d39:e13c with SMTP id 6a1803df08f44-91eef8650e9mr21004816d6.49.1794268565495;
        Mon, 09 Nov 2026 15:56:05 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04ae351sm7869386d6.12.2026.11.09.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:56:04 -0800 (PST)
Date: Mon, 09 Nov 2026 18:56:04 -0500
Message-ID: <a8542108f56e8cac5c6e65977ee01ffd@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261109_1829/pstg-lib:20261109_1442/pstg-pwork:20261109_1829
From: Paul Moore <paul@paul-moore.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: don't label bridged packets in  selinux_ip_forward()
References: <179216146138.25460.7866279004288174372@gmail.com>
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>

On Oct 16, 2026 Joas Antonio dos Santos <joasantonio108@gmail.com> wrote:
> 
> With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
> packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
> calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
> CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
> calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
> header and reset the network header, but the Ethernet header stays
> where it was; when the bridge pushes it back in front of the packet it
> picks up stale bytes and the frame goes out with a garbage destination
> MAC and EtherType.
> 
> Labeling a bridged packet based on its IP addresses is not what we want
> here anyway, so leave bridged packets alone.  Add a stub of
> nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=n.
> 
> Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
> the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
> per case:
> 
>   case                                        before        after
>   CALIPSO packet, unlabeled destination       MAC garbage   5/5
>   unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
>   unlabeled IPv4, CIPSO destination           MAC garbage   5/5
> 
> Routed packets are still labeled (an unlabeled packet forwarded towards
> a CALIPSO destination gets the option, 5/5).
> 
> Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security attributes of a packet")
> Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  include/linux/netfilter_bridge.h |  5 +++++
>  security/selinux/hooks.c         | 13 ++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)

This looks good to me, thanks for all the work you put into this!  It's
been several weeks with no objections from the netdev folks about the
nf_bridge_info_exists() dummy function so I'm going to assume they are
okay with that; if that's not the case, please speak up soon :)

Merged into selinux/dev.

--
paul-moore.com
