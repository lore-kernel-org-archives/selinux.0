Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C624CF468
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177876; cv=pass; b=ZhEbWZnKfvA0NPRWPE5y1LLVORt1hq4yP5+O0V0Lpa8mz25Uybb1UAGRaKb6woTTvT9z1mtkdEywFSC87oDcYwVeHWIfCO2X4NNPviKqw6ICOPu4FnBSGH8/ABFMw/YzurfBXkHKKMTYuPzbEUeANhdbwY19Hp6miGwN8kXBP/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177876; c=relaxed/simple;
	bh=qppVgsYFvGGhHcWK5q8fwgXEoXbm8x8Kajt5Kyll45Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxgCexgAt0/E4orv77ao9c4+JOFLV3kxfPC+OklC99NgLC/HkEnxFAtjwbxvw+KiAU7nrcltc4SS69E2k8JCbZGnO3URczc7uUtMIfGUtpfpBNVrkEjpyLAWK2KJO3bRMAjOfSjN2srVJ4hmKgdS1196iiTxpb2WFpZh0hw+OzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNYHVnir; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNYHVnir"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-679a2297c55so318597d50.1
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 12:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792177874; cv=none;
        d=google.com; s=arc-20260327;
        b=Z4WJZx5zpI8eYWMPbcyQJ0lwntsofilX3NQ/PB5j3R7eG2MyzNZ4L+NYTjyI4J3Edg
         OAN9Xk+SJDwEMcLcWOG8xM6sOOFgDapATYZpDTSNEwXiPbby9khrzKhImLnoLlpLzPtc
         ys6WHFrBDTTtaMPwZzw/inkXU9TK5qM5xYj1uIJGC+hgqU0Br6OS2TmuG9JNyNW7KkvJ
         3UwBO7VM166JgS6KEUI2p2lF3yIpFUJtZVdB9EKds/i59D5+Ovll95VpIZq5WlnHqK+l
         VwhCEuVoQm8UhUeSQsfuDb4J+lb9g3sMm36XboChl5psLo15XsP6Sm4pdvE88gzuJ3KZ
         ZzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        fh=dt5mjYvea+JGGF7ASAwgqMTV7ERVW7J7tt/yqEZ+xJA=;
        b=Mnfq18iJsvsCxpVBY35cHDPAGiZtxAuj+1i7PAMsirAnxzYJxSCnrFXAVgtUIcjdz7
         pTWoOaMlfe69mts4tNAYmivTd/HiI9LMH5tzAexvoZnaGDEAGfm0WERmQOTfIZ8Sj5H8
         unKVdIeEYc2jdvoxrBsMbjSVWb9PrMCNSrH4oKVNxNLfmVcALLK6n7eo2cfkDDK/Aa1z
         HwVKXUzjonFsmJkoBTf9SRS1Hxn46ZvSieh2Zcp2detNAu/ODD5kTGtY/djKx6UZWuY1
         ocWN8oC+8rlUf8d7vm6EYn053mDlGIHIaxG2CUHlM70Sw9p2aIMoy1EDtCyTLAO/jVJH
         t8mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177874; x=1792782674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        b=lNYHVnirjmv/XVzkDQrJJrtTF9KNDAbXxawbFWCxJHjZruMMjPqAmhqeKnvX8Dhuvl
         FqHZWxxeA1e6BytDa6B6qWm88wVrLzwDEykURFCxQx3GhLCfSWQ8hX24aL5jkY+DOSeW
         a5LUkceNq6eXRyJXYk91Xsrolvl4ZLVSW09ID+JiLAiBJwZlMk/9roGrfDRIobieGdYA
         zRTfkxGvy0mJEEGWG7b8rFrA2HM049eB2dHGCNYgNMRsupgebUZYB35BuuWYyM+WZMB3
         UzicVHJkTFg9yRS0FeittYF0id7wNbKhs14p7mRXpKok2DzsraiYLJVstHVmYBs5nriU
         CoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177874; x=1792782674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcM0e5h6kl2DJj3y8GjJ9yn5THeHomwVF5DySO9cYxc=;
        b=kUZszXKiP1brSFgkkohTuLNlJRw/NwhL2DQw00+FyXI7zt3AIGkjuzcEMwly7vMWzE
         CA6pD86hwJvZdByz7LFeXn+IReCeGBSqu3WmeBhTe7PuphqOTJB7s43ABJDSMmVrYpxW
         WB9GGVBSSdNgYB2AnHciFSfem3d3pQ1S0su5Zypt1Ts2JTbWBD0Me0cLvqd6aHEBpRwD
         0WBRT837eP6HkM7mPHKEYWz+CcNOsTVYGL4ppd4IuStMxGADfof1iaZljY21Rn/ospNh
         wSMrn1HFCFzdKjaQeWBWd31VJO/qCajGNw4dCvAnmzX/0n4Zk4k6tlO/oU0xNomJH0gg
         dmfg==
X-Forwarded-Encrypted: i=1; AKwUvBztevhW01seBWXH4xiw9MkGB2g1lAk6htOt/9IQJgLrFJWF4+kHOAL9feNPiT1F+mHesu9pc4CO@vger.kernel.org
X-Gm-Message-State: AFq9FYL/RAe/AsDPWpUEshuJzMhEsViG9bs0BOWHOygaER5dGZtCBsu+
	ag+8tkNB+pUJJbr8SGKqLX9pJVJjzv75y7SyUx86dKtmIgvKQGZYC/neZBLfyAGfykrdz5N3SIU
	IZH0COk9YeH3tx9pyBvK6Wp/sosWwxbk=
X-Gm-Gg: AYBFou3raiY0FzZJN5IqwJf54OgO9uPLdDmNiPJ/8b4KHu8hwTzReRcmdOdUsFn1mWA
	HOl9PqLEP7leQuAW07YINPgYT8e/F2FUBr2/Bes8Uiblwm6mF/BntWWx5qLmQGMyTRlYz/GbOIa
	ITd2SUZPmZQCdqUYgcwOf7YfGc0YCTSaRbrhn5X1kljj2sVciOVyzNH7n7K42xuFLD3dnEhnpUf
	KIxjwpYvOx6REPhgSeCTlQ5V490V8XDMKdDHgjJH1X8x3UoWH2tYzikVvkrD9TJVm+xRfQCzKO8
	81CbMSqrTThP4fKlIuAM8Ac0hjHp3fWRVmZy6bfonVgW37e0MtLuxfU4fsMLnDqSWg==
X-Received: by 2002:a05:690e:138a:b0:679:c9af:6d51 with SMTP id
 956f58d0204a3-679ca86652fmr108710d50.69.1792177873691; Fri, 16 Oct 2026
 12:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179216146138.25460.7866279004288174372@gmail.com>
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 15:11:02 -0400
X-Gm-Features: AclHuK82Reo9t1Q_XYkamM6mGKm-uUZWL-8Kv3QM6WU-oPDk-hAS-2iAswxeKCA
Message-ID: <CAEjxPJ7fLbBANfjcgN7Xa+axbQFE5ZALWzXxRz_kQ8zGvmw4Rw@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't label bridged packets in selinux_ip_forward()
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnacek@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:37=E2=80=AFAM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
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
> nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=3Dn.
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
> Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security att=
ributes of a packet")
> Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_=
6EhAuu4qfUFe_mw@mail.gmail.com/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
