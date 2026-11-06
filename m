Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994154;
	b=URVka4DbpKrqGRLWXXrDx5ky8Gpc2sU6JVUppL2we+NhE+za5sl7HA9TW8Zg2aufihY7
	 xHchbkmhKZM86zQBqUCvh8iaXJyrZKfHvArFFbj6gkoys+XJa/MXuToBAj02UJs2VdRgr
	 PAg2JCUrIjFFbLx4kAzjJDrB8p8n/zsZiO3W79Tjp1Oe1kUit0/8N2K/MegiqWn2piO5w
	 1l64EgoKqUH98rDkXpd1lnLZDH6lbdNCyocBNprFWGrEYlghmFeAcvuV8F8w7XLm//npB
	 bxj7qsZxY1R3/SjcjgrD+tfkTJkbxVYQwEg/o9flJ+8ll9kIHbLGQ9XGagLDGEIycog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6zEIlsV3E828OMxUuLtqtcnz37SJS8sKuTVYO+g9NIY=;
	b=x4ulLiCs+pqBHZEh2Xt7AwIgTP5nIpCdWVRmNWxZAMQZnvVik2kyGx/Ia6qUEXF3r5D5
	 EY0rRRbANB7sG5WdxJDxG7DsQk9bKcoTinjyAUxhCel4lUl8+dx4iddf0E0uxK3zzq2s0
	 iFTQ5XOxyatlMy0ei0zjQC7Ykfn9v1ZuXfnTBUAJX9r3TSPmMZiJxebwL/YpKPKUn9g72
	 iwtS7WPkQ1z2SJ8C7nxyL4obhMY6mi+APYPDOR6ybk+/hcl5ZYqTB3UDW6A0doExcKAQt
	 ym0dPUzvUjsj0U8NF3iLIKwPbh1njzkEAw7urEkcyyjmgNYHHxf3SWRGtEEDVuEid1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AV0u5qe/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81C606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B81C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AV0u5qe/
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0dba37a7fso9184157b3.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994153; cv=none;
        d=google.com; s=arc-20260327;
        b=MybU533jx8UNPNe+ixHK4eNXHzUE4RCHcqVQT68VY03iaykglrLQjdxlmihpcOZ591
         sGjeFIaTpfxwANsfsAekgqq/BMQG7jA3zMk2c+E3WWjFPxgaB9yaCXfirjxZGurmB/E2
         xl+cRScX+k4nEF/IF4AuDrMDmv3wAEpb698ij4E31VxA61Mbr2DroDKtsPIcvGirvDri
         hoprfKn0r663rYfUCZ8LKZObWhtnDUr6xhAyRNM4tgDCq58eqoZA1wASkPs3YpcXmjHx
         iqLaKixSyypSwFClX2sqGSLcutiv8PwvVKVUuSeTjkGMSr7vhBgb7sKKcruwbYSlnmX7
         luKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6zEIlsV3E828OMxUuLtqtcnz37SJS8sKuTVYO+g9NIY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=pAEcD6WZfhcGUaoKyaCmqEBsWe7ezKumRSodAJlBCmGXJdxTv/SvUZsbo5JxTuJ+Q8
         XGBgLmYLGnSbqdVRVishJOludpPHwMaOoP3L4atj04gejwzKCrkE1JAmS0msZXcKjcKk
         Hp09r6vxB0ajcoUw5zbWCUDfZjWYCLsseX4wqPbXR/gnVSbEk3jYESthYW8a2Fjri0DA
         LQoUTMWHXurcV/+dCj3a67nku/7NNC67x0FLl89WzYNLWZ2mQfRriuqCGWPZVVX0d0ei
         YAeQaZ2pCrc9PBR/tFLgHQ58JU+c5a0LNHuJ897jgvH68qmhifrr725Dror2VJsNIEE2
         4ZvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994153; x=1794598953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6zEIlsV3E828OMxUuLtqtcnz37SJS8sKuTVYO+g9NIY=;
        b=AV0u5qe/flv82+lL52x8Zr9uxGjmmtWsx50hZ0KjMqqA270JWKznmTuTsftxfR4kmi
         G3ImhJpxW9v7gttWuyXtJpEEDdA34+5MppskDI7VkeZZyf7pniZUcBJlAPm+/iY5tft8
         6OyVw6b7FKkGycx8c2xnGLbSUtsnbS4xailnFqPDpRnjmXhZnTagCJt3HQSjl2Scf9ch
         caZooEukmPZneLbmj/wAx3nwPLZyYPKj5d7bP6ZK1kV7Eavfvj9WPpwnZcQG5+b0KrUF
         5gmq9Ms7/Ty895OfQlx0bVp7flp/Fj73Io7VBKeXzsbZO76PeJPmFzKuNCM3umdSMTbm
         V4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994153; x=1794598953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zEIlsV3E828OMxUuLtqtcnz37SJS8sKuTVYO+g9NIY=;
        b=bpUi2txYlIgQw24rG/mBqqGfEiU4unG7U1x9tPO4ffJjAR2RuX9ez+EMcHoTW4+0oc
         R3bm64fzdq4ALh/aiIp1BhBpQlo7qfsLTwKKGhQ7VAPy8GerfSgEkXf9P5MUdJWeButd
         A2K81F171pZ4uiVMCPulcGTRnjLryumFGNNBukXDkZDWTiPb+ZF1NVEiSKG8ttj5IokU
         +/TsonONqTS9IdQDDS8ng8pnrOWO9RqUgb9iZRVeGacmfrmZM6AaQU4/7KiFheuwGNlm
         gECWyPV+sjYdv8M7pAbklVII5KjnOMBWDinMXVWd60wqx1lBWWe6j+dKodxNQvyqWbSL
         4yug==
X-Gm-Message-State: APuU4Z+cEvKPDB16EG8pvfiN30+uhOaqDrS3urg6qV3KzW4l9ol7nC9x
	f8l+oOyD1aB48aqxPMUpkmi1E/AgW4/2z4lz9Zj7AkP/eE2ks9wdHC9G2ShwUFZebb17D9i6ZqB
	B4Bh04Iq1wXpsMP4vQEI445MaU8IUFwnLs7YRPrQ=
X-Gm-Gg: AYBFou0T9z5gl/GKJvNgdGjCajufLMcNd70I2kQ/bsv6Qw071ZS4nsi4ZpdhmorsV34
	2lyz0dcp+ia4jv163l9KUt3/hmTMmWyxwsVf31n8Du1wl6SvIomlM0E007iT/5lz+sdo0/8+ZjQ
	yIfWqPdjm0P9m3kjO/SC10PvKTQ1BtL3BY7OFoXD3IhtDg540YC4tIJo1OZjbBFriEerpXu/bvT
	xkNxzamlWmMiZICf2Qpq52fPL8HhC6qu7cbwNwBwuOnZN9j9s5RMDv9urco0fdZj8SbVf5F1yh2
	rnZgTy9Py/rNb2fH7MfRNL3aBXss2KzEEAVRecQMB/aDltESFjskIlEbExwTIzZdNnc5UiQ4ucX
	FH2Sfjg4lwl4E9DQL+/KlYWPgs2lTsA89vG8eAji/l3avBZw7Mzbp7O/csVMcHCKB5wojgcsDAp
	WZMyqnHDNuuA5RWAVeQrJqiXgnvD7i+OwlMeesE3t8msaNUNY8oEmNTW8B/A==
X-Received: by 2002:a05:690e:13c8:b0:67c:f33:de76 with SMTP id
 956f58d0204a3-67c14423bf2mr1482057d50.76.1793994152996; Fri, 06 Nov 2026
 11:42:32 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:42:22 -0500
X-Gm-Features: AclHuK-LToqDPTnD3qjvX6WKqyXYX8nynjn6BsjfpOEt-VuAMyuTmejDz8j4w5o
Message-ID: <CAEjxPJ6gpW8piddo2pODFLjSdHs9VBVXrm+2DG2vEaniqOiUvQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] libsepol: skip MLS alias slots when writing kernel
 policies as CIL
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> checkpolicy gives every sensitivity and category alias its own value
> slot, so p_levels.nprim and p_cats.nprim count the aliases, while the
> value-to-name tables only hold the primaries and leave the alias slots
> NULL. The CIL writer walks both tables up to nprim without skipping
> those slots and emits declarations like
>
>     (sensitivity (null))
>     (sensitivityorder (s0 s1 s2 ))
>
> which secilc refuses. "checkpolicy -M -b policy -C" therefore produces
> unusable CIL for any checkpolicy-built MLS policy with a sensitivity or
> category alias, such as one built from
> checkpolicy/tests/policy_allonce_mls.conf.
> The conf writer already skips unnamed slots.
>
> Skip slots without a name in the sensitivity and category declaration
> and order loops, and add a regression test converting an expanded
> policy with one sensitivity and one category alias.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

make check-format fails on this one.

libsepol/tests/test-kernel-to-cil.c:60:26: error: code should be
clang-formatted [-Wclang-format-violations]
                CU_ASSERT_PTR_NOT_NULL(strstr(buf, "(categoryorder (c0
c1))\n"));
                                       ^
libsepol/tests/test-kernel-to-cil.c:61:26: error: code should be
clang-formatted [-Wclang-format-violations]
                CU_ASSERT_PTR_NOT_NULL(
                                       ^
libsepol/tests/test-kernel-to-cil.c:62:11: error: code should be
clang-formatted [-Wclang-format-violations]
                        strstr(buf, "(sensitivityaliasactual
sens_alias s1)\n"));
                               ^
make: *** [Makefile:69: check-format] Error 1
