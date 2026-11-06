Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994393;
	b=gdEQL886Ejr0g24t6qYKFk/fHx7MvVuNYdCBZoUC2TlDWk6J8YCDBGLAGP7bf0KT8loP
	 J6wGJMFVX8f+lkbC8Wg7zgtFSzdTXn4iFoGclWFmiM0Rxu8p9umEsP/o3VBnxlC3IJP3r
	 1xkpVRZTZuPB+l4uZOCMaLsAJc1/pMKKa4bn3SiV8PJcNB9gS5HCmxcDCLyq0K+kcwShI
	 pLzJQ5S7FkoKj05Vq6zNmLa0Svgh07uR6AYRheNPF4HvRJ55aMft5RsNAGDEXHZubH57U
	 a3QcyTBZ4DgOtCz8g6VVNKthUlKAOW1Za6JdalOxFRuqoY8/faMxvinTMYN3BeIjuPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=KEl6vTh6GmmRE81vAySY8wP0qhCF7pLObkihStAGDfQ=;
	b=eDCpE3NuNDMbDsmT6o63nmm8jiK+pXZryVQ2avosax25KFqV72b5ISbYB3Z5xOxjnGz9
	 Tk1MyYErcr/V6QbiwNqVhkrZvFYLmKk1dMgwgyVH2IxGYdzbpf3HdEARe0rLU1Fg1+IRM
	 VTUPiKbNAE31DVLHEmnKXXhTbk2q1egEnpdC9Z/RIXtZXaF2dvqhbPYyn1KOrx/A2AV8m
	 H/N3nm0gcYHg5XLhTOsSyHf85BmBiGgGhv9/EIz7bsbG244ooahGn/730hppt7Rv9hhyX
	 vUyA3ykwyoLscs+mb3gqnZvuRI35Wgxqfo/Nu+aAiLbNp28kqi5fSDU1bkqcKRMN60Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xpYQryDu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D5606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D16D5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xpYQryDu
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67bf3c6654fso1089864d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:46:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994392; cv=none;
        d=google.com; s=arc-20260327;
        b=nIxrP/QvUbqjsot282+Gj5X4srTB55ZBjDaeLnjKYt6EcICx6+3i/BxO1DSwZYNfpF
         joB4pva5usWjWVdL85ezIFpMik6STek5WcL2I94tQaxrlAnwBzMBsJxvLP8d2sz65NWH
         gpP/xHAL3HEp+jURvoc2PUzBhBSihcKIj5rQdiqGQ/fRaVz6qHY07GRIlvZRs1vh+QRT
         u4mp94I6d3SyFX92WnHlO/Of2+H1GAfJd5W/PppEhZWgliLcso4fRebbTRtNMBew8bzE
         rre7CAQQcM3+asTPATmmrOZmuCsAhK+43NcEa8lccRWab1x4Z3CfB9RczwKZ8vEBSnsM
         DYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KEl6vTh6GmmRE81vAySY8wP0qhCF7pLObkihStAGDfQ=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=PuD3QiqMM4xfmmdxweb+eypYb09HuTKMQh5zD24OEiAQ/YRoLt23DjOzyUfIV6UdY8
         nt/M/tHevVDlMCZDveTa9pCSS6dGxVuU3+joxlVoDfsexvrudh42Up9b9ObwHQR/+ppx
         vPMJdTqT0I9r9N+FW2VoKtV7A8rn90w0LqcGDB8B26phFWIbgrbFC/rukDJNAWqo+lFA
         vCtPDuP8S2q6Z4xTPbGCv6BpNtd14NG9Q7/zxrrW66N4TbsoDp6ea6WTjtiG6olrhMoI
         KRgaehOSdtkBxn4StAqTYdrpN2Oo5OnG25NsPer7J04UpRkAlwk+Oa7+bUKYuff+43PX
         bwhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994392; x=1794599192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KEl6vTh6GmmRE81vAySY8wP0qhCF7pLObkihStAGDfQ=;
        b=xpYQryDuxe6/PDtNuwIm7LM2CnW74HWlwYSiIpH/7er/JpP0dHSmU9N93/pC/gI4od
         6Rnk85iBlyrAUNMeU/eKEK7FUM8eSePRSDBIJ2KKbB4DsBsnVJRSydx4FYcmwOAf9s+4
         yNPgJrO9RWCPp6Dr0jRVyyKtH3n3R5d/bkIDQknwRC7HzezUTO5hu3FueCGUcBIcIMF/
         xXhhmN+/8yYFjU3YzXHXPuUmX/dDvKVFNcOxsZDnFhBsnUyRUhlWhpQysp/sLpSwB9Cf
         /hzHwxXDrTMwCjtl8F2REHExiGYbfVxfnivLBF97+pKk1NpIlu1zLeciX9XN6nTsWCf9
         zgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994392; x=1794599192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KEl6vTh6GmmRE81vAySY8wP0qhCF7pLObkihStAGDfQ=;
        b=0M9adyP3/yINe+ImOmUU1sz6zKLLyhCfLthwFEfk3LyGrAYJXfoF8Dk8g+mfq+WSDD
         mrmYP1lXYQIYI6+ibKTKe25wZjVuVCxQLHSO1PO4BMqG95zvOfZBkH+hJHxRD+yKuL/S
         T3xcPLmiLdVF9Rez54QWwRA2xp7NuxqU91xpAp6IUQ8SERGn5tMBPP52QhmNHPNSUjc7
         uGRBZKtglsBwx6QTgU6nTuomo9ARsP3usd7P0vCfOWM5ruuj4ts6jIlIGO1nHLS2qxhD
         oLuGJZm0PvZ2N58ObAagx8SsiRsmF2T/PsGNur0mS515JgB8oYt+BMCPC0valMeKu5iX
         /K3w==
X-Gm-Message-State: APuU4Z8SHDUGHreA/uRF77M1dBocDtJCsJFOLPLDfJ85JGTNo0gWZeRv
	rHNFRck9qJZyV+rim2oxWt7EIMSt12hvlmGDmSC3Fet00w73EXnvObZR+16/+qsnReNO5bnqIah
	4JP7p6LKZnZ1mpSr+p2S3jJvphUfXZRLcxIbQ
X-Gm-Gg: AYBFou0FZuB48f6/V4qgdz/z4pFp4Xu1mhTHud5ML7FLBjIg4m+h8PpRzLZNNUFzxS+
	h1kAFoX3PcCeYkPxI1rmhl1NkvuS8LYHGDJbAodi2uMYMbnjC7cC5uA5P5yDoABkeHfCHHCgKHe
	StN3riws0wb9CudxgQh2bFKBWVJKbybsPTVTSdH0iEgUPrhJLoRyq27QnYlIRZA5pzqUh9pwOHF
	Tk2ShK05f2mgF+QSy98wNZA82EqGXaHzQ5pw0xKRck2uQbe8RkLfL1qNjyqNTAsw9agxygWy3tr
	edMRQtVgh3+oLWE9cTVh+B3tSBOroxPbHmHv3x063hpYBTsEnywMXKHWw4nONINo2/Nf+DO2C0o
	YJNaOQXb+ah/BBSIX8VvCEBc/TAHTppqn/52xMGl5EOEjTIKeUP0eFIanOWjzB7ozUxsYw2g9Rs
	M7PSWcBWvvKNV0Ve7VgiXAau+jBzjsFIJjBSCyaXn8+84C66cBCwVz8AdDp9g=
X-Received: by 2002:a05:690e:5cc:b0:67b:dd37:e3b8 with SMTP id
 956f58d0204a3-67c145b2899mr1116447d50.107.1793994391804; Fri, 06 Nov 2026
 11:46:31 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:46:20 -0500
X-Gm-Features: AclHuK8ZGaAr38VizGcXI84WnexM_geFAoDxddEGdGs7l8axqRWSv5evxkZFTNc
Message-ID: <CAEjxPJ5U1A6+P+JFSMqAJi5hmYuJ4iQ8t0dOk_enDp2NxULukA@mail.gmail.com>
Subject: Re: [PATCH 05/16] checkpolicy: order IPv4 node contexts by
 network-order mask
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> insert_ipv4_node() keeps node contexts sorted from the most to the least
> specific mask, but compares u.node.mask, which holds the mask in network
> byte order, as a host integer. On little-endian hosts a non-contiguous
> mask therefore sorts by its byte-swapped value: of
>
>     nodecon 10.0.0.0 255.0.255.0 ...
>     nodecon 10.0.0.0 255.255.0.0 ...
>
> the 255.0.255.0 entry is stored first, so the kernel matches 10.0.0.1
> against it, while big-endian hosts, secilc, and libsepol's own policy
> writers (node_data_cmp()) order 255.255.0.0 first. Contiguous masks
> order alike either way.
>
> Convert the masks to host byte order before comparing them, matching the
> network-order comparison the IPv6 variant performs with memcmp(), and
> add a regression test for the example above.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
