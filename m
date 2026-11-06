Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995183;
	b=qHq+A4v2VAl5D7oxTI1f0Ya98DDQCvIXTlG24MJ8oUPYuuY2POBMS/s8RpdWypaBih1B
	 in4R8QLN+pyMTEd4jp6v89YN1Wg2me7DvGvzpLgdjjsB7csjVqSs6aKKnO+2Yn66Jy9P6
	 TVaqPg5lP8DdaMttc4QOycTH5imruoygnlZLDsQIHGJIdViNy9+DKCWTTOfqM5kSZCER+
	 zj09dTDvG95jlQDMKrMcnTZVWl8LcOIco5ECsNlbGkvTiGlZbyfEbKDoifxF23fyeCRNy
	 PqlqS2B0Pmed4OcDZiVdIPlV6IaUmdYSci/dJ1itSJlg3nvWQahX9CDFNVqfWn3hfIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8Z60cvHOCJIoTBijEaLQlDCSwXeEtdkb4mbKq4P56no=;
	b=05qRQwu046vWldgMOm4na3l3SLP1lnsxSHB7bz4g28QhG1PNzyGcGsUR6kZEr7zLZkAp
	 Hbc1rkuUhkGuNP7IK3PA215omO0a5YGklEiM63DgnftIWM/YQS1KdZByuQV3rqmkU4Gc9
	 NwJGwMWopo/wTbDSXCPKdJ3sIAUrD8NMS0RMlQDDJ27oKXNjm2pDCxYcJLLWmfSeiTLR7
	 xjP34p8rNLjfiTJDX7wv/PVMfT9FrXO74P83xYrzM1vwi3FYS0rli4ZP20igIolqAA++V
	 RZhZ8hawQZxX0dk/7QW9sCrR1WZoWv+WMF2yT4z1YT/C8BoGZfyKn0Qsid8rOaRSyfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tK7YLWQs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BC606A32E
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 848BC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tK7YLWQs
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso12808d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995182; cv=none;
        d=google.com; s=arc-20260327;
        b=SlqffPsy8TZJVjHz4FbXtvXJ/Croed+8hB+4WhuQi7Vmgr95NPYpaBq7SrHpOxguGW
         RZw8QUhHDzrSJjhXkpUtIS26IfxzgEcVmvjE3u0cBCdpHieerbYHTILG853tOC5IrckH
         DgUrDNh9kNrzkJng/mBm4rT2/khAU7hSiyLvhaA2bol7j4xHaQMi4c874fVqHRLx0247
         0d8cL46M0s0v7Za8WKoNno1KY1Nxa3ofctBUv38zc+jY9O9o7NS50RjNb8dLYYGAnmeH
         1bEUk+YkxnWFld4j1o/T3ANkOorx3eV53We/KaEzDxMg6MeIKA0yeCWYIvn2lAZ38NB+
         2Ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Z60cvHOCJIoTBijEaLQlDCSwXeEtdkb4mbKq4P56no=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=ep3Nb6qwDQAFQlnf23r0MIKp+s0ISTaroKG+xKtWwJXtsQsuTSTbY0REL3mZcF4Yz/
         xCLinr9MFXSpMniVRsUY3LbZqzbiq1Acc3o7u4IvF/hxte8sD1HiaBxYEKXrrMP3lCIy
         OznmTGxqnf8S+LsU74Shq7KkwCb8xv8fq/ofugLK0sffNvdezJXlr8DOQgFUZBrLy4hs
         JiWIdn8+Pfb6Qp/VdSD1BVtqYMw7i+ziub8DHWyWYt+BZCec2mz+quqVmn8kNvv6no0V
         vKaILhg/vlP/e6XcHRqhe/6p4EUGZkJPu1dNoE4svPRxOpz53qM1uXqvFtW+oLDryQ5X
         6t/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995182; x=1794599982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Z60cvHOCJIoTBijEaLQlDCSwXeEtdkb4mbKq4P56no=;
        b=tK7YLWQsQo70BZCnJMJfhb/CgKO+i4MajextU68slgfrZnFeITnKCXOK8uhwL7KQ43
         CGp1tpNEDbevZ4qTlRrZe2uj2PjCi/N2P+HV1XIwSUN8WKTHdafmbUNBLbIxn72aWTDl
         PZqCc/XkC9qoNKXO6Ki/ArrxSxIDyXaVeyJNeqSxeR1EKIxQC5mKtJXJ7111VEyxY6yf
         cEgs4EqpkiukFaTDTkfQmsc/wZk2P/UeZ6Kjm2YHn31v+p33+UewMRblqJiBTKARdvBU
         L4DHL+V3qCPFoR/MbNk0xjT4mxjoOOP5AMc5vCS0YKnUPUN2tShQL6ZgUWchlKIKQSNg
         IoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995182; x=1794599982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Z60cvHOCJIoTBijEaLQlDCSwXeEtdkb4mbKq4P56no=;
        b=XqY1fb2bESK/8eCjSQ3JZfutr5cx2/dUJJV5Mspjf4NwvSojQgWvoKGQTuDvxz+VsU
         beyx+mOGLa2tLSD+QW1WS1myRZ7Ewz/DOHJXSFYrByYata+pS7HJ+k0Vn6SctnBLVKiH
         1poAwZQkZhQwaNwbdqaVRQzG8XG5qkiqmIhCaZVwwur82JGZVfuIlfb8TYSKLXpksCIq
         OISlE3k2pcLZ1hYr3OcWq10Hi0CW17H33B965AMQYKcdv61mUnerNnvVPo4JpJqHRnVQ
         Hfx9zztJuVYP1ibayg3QoM/6mhIhOqaUts9i5vWggyWdWQfa8V/d6U/bYxUwhg2A26Am
         F5Eg==
X-Gm-Message-State: APuU4Z92rPhINJof5/U5fVwoROD29QYQhGxB0sEQacBvQLlWpUpVyvGR
	cAsFzwXhnoW7ZGEBiMaoW3w0w8YuLIZe9sd2KqQ/XOhXHghKOlUgO6Saqmx/PkUlldB4bzzSAkC
	EeScBCfbIx+bha88dKt5M1ZvZHGatJ9Y=
X-Gm-Gg: AYBFou2nhdxa+Eu7QN1MqOCDklDYBcnxnejJdG2TWV++7VFjIAIoBGPIoughjUfL2pW
	n2T7xGtwOPiQBKeRwPUI2qgjnvPhzVURCPQlezUWAXKQ6Fo0UDsuMIha9W2FX++/ZoVU1qYQ0tO
	YWWoz9SxrhpWig/u7pyjulWdeZVm479PFFeata7g6Hej/+lduiTQutJtR/aXln03Tw24AxDvs6L
	szJHX3UfJk2ZiexcODsiKoHSeNQNYyzmp6QzWEldJNzgGaZWO+GVneE3ZDs3plWvv52KwfN8ycV
	QDRz/8TBzE6h3RWQXs24GyBP+7eQDX5cNaBep3OWaL23Yq7fC83z+nBp+gQWWNtD2ZdZvwmAwni
	DpsTEddRppEEJlf7sSITsu8dCnHncwV1VzMbmESALpvn0JPjff2oNW/iWb3C7ZThlrWrRMCGdy3
	AzSpY8oQUt7dPif2udKlQRVjwP0VvrmkaJ6H7hOkAPgj55G7Iq83PGM2htyg==
X-Received: by 2002:a05:690e:1686:b0:677:bbf8:7c62 with SMTP id
 956f58d0204a3-67c29851179mr35307d50.4.1793995182711; Fri, 06 Nov 2026
 11:59:42 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-10-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:59:31 -0500
X-Gm-Features: AclHuK_WinEeroU__4TGYoY88hvL29kVWS0_1nWd5_IwO9bGzhJ1mipDLtxOqng
Message-ID: <CAEjxPJ4uUdL4fLBwoQbdeedArk5CdOUSajiqbLN82QK-x03miQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] libsepol/cil: name anonymous ranges in context
 verification errors
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> __cil_verify_context() reports a range outside the user's range as
> "Range %s is invalid for user %s" with ctx->range_str, which is NULL
> for an anonymous range such as (USER ROLE TYPE ((s0) (s1))). Passing
> NULL for %s is undefined behavior; glibc happens to print "(null)".
>
> Print "<anonymous>" for ranges without a name.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

make check-format fails on this one too:
libsepol/cil/src/cil_verify.c:1099:26: error: code should be
clang-formatted [-Wclang-format-violations]
        const char *range_name =3D
                                ^
libsepol/cil/src/cil_verify.c:1100:36: error: code should be
clang-formatted [-Wclang-format-violations]
                ctx->range_str ? ctx->range_str : "<anonymous>";
                                                 ^
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
