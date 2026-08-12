Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3E345EDD
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562320; cv=pass; b=ACx39GFhGmBC54SKK8G0kQFT+jSDeOe3m55gMhP06Y/Gq6S7UG7TVNzw+HQgDuuABlbIZb2c0fn9yRvY0/3dXCPja7yRD0mRWSyzHxe3DwXFqR8Lzdp3xnQSEGzoeTUp3rXvlaZoCkvvHLB8CHRoeyYBChGNFEybblzW7C91Nco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562320; c=relaxed/simple;
	bh=rE5UWIbBc5TQMTF+8cA57HhPD/bCGopbfsZ1t3qeMtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5FPGXeSPYlN6E3r4xcKSjwfuaGt6anFYzr5FVM5e4rfUESIpYnC/oZ4s8FnwDLK/J6DnF4+I8xl9Y+uEsPtKqxzzpIaRVS+UhykcskgKb1nw1YmzjHCBdMbAX95koaA/1NgrdmzHnuilsSRd0N8t9CU1GOoCajWaEhgbi6XFNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkbHYWYu; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkbHYWYu"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aea94f96c4so808629eaf.2
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 12:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786562317; cv=none;
        d=google.com; s=arc-20260327;
        b=mOPKp2ZkVLZUQKzAwgZ+AcS0mPSaXoN0/ylEeIPah6haO9tdR7gNFjlnuodV7qlWv4
         rN24jxYwAXuYE5sEIerngHLIf228wyXhnxNeJaviwQMbS8UAwec23CPWDnkHo2wFFWLM
         5otlTLGxHeXu7bUa+AUd8P7XAh0Rmn4e2MjGblpB1YL5kbMSD6j34FqTl2KR/ZKo/B1R
         xrRv1qXuY7poltEKtXgb6kGmPAEzBu57QnqF6PljNpiYWNInykheweKbGIhzwDfJBToI
         +7TV3EkVt0D8jcB+Fr505ywHyyLoamy9FftH3sQLocuMcTWz1veR2+o/Tz5GdOkf2z9l
         h+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rE5UWIbBc5TQMTF+8cA57HhPD/bCGopbfsZ1t3qeMtA=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=rOsmZwyNPCD1A4uHpDFIpgH+1H0h6jNyDL0QuSZv3lggEb2ceJDKsuRqsYJro+c6px
         1I2A79N7RvAjesldcQkz92na2Bq+YeB8p7htuS9UrrrQ+el6qzVAY//pS/iUnUmmtl7Q
         AAoiLou3VRmkwsGl8Hxpz/F/xvyyLHNQjualJFbKpYXqsxDtGrTuRJbB6CBfMiqCNdcg
         Q2f/H3r/7gm528v7MT98SrOPDI2nJgi+jO89ThsvhfgkosxM7mdtRYOnFLFuzx/zI2rv
         IdYV3Z0mwyom1fa39NLGUn6PyKIZAj9o1cbwgpdxV04cHi7Uts7FjqwRmLbgDkB0v3p9
         FC1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786562317; x=1787167117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rE5UWIbBc5TQMTF+8cA57HhPD/bCGopbfsZ1t3qeMtA=;
        b=XkbHYWYuxykId+nEqhs+dYtlsblugk04gh7ed2U+NnUGEsSZ/A9JfEmm5TT0Dv9SGU
         4xO9DNGb4YeUwNObDLuaQ7UYjkYI2hbzQ+L6MEgupdqaCBO+qV0NGb9+xmAwM/C2OPEQ
         1bJVOL61XRMmuXQEbmkhs0CGLrIBjDtx+KkcbUdIaRjFuSh2pWX/PcuGlmm0UA7pyUVQ
         XB1XBMWx01emSufvBgN2Hfyk4mT4TJ07DSpLbnXXApXX3486sa69FNAOi9Mbt9H43iS2
         UiDpR96+GAkWMmV+if/yvwtCBRu3j18uXxaW03ODo1xfACzFr5+cTFDkkI7btx/MpVN/
         Y4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786562317; x=1787167117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rE5UWIbBc5TQMTF+8cA57HhPD/bCGopbfsZ1t3qeMtA=;
        b=LAewiwlyRDc/OeBJz9n2d31NnWkeJITWs6SyLU883NbdXXaX2wRllv4GChdIcFHWM8
         9p5xm/gW6ISKVAZc0b95krzFreCa2g5bZb6/zSCBA+jGr7Uzv14kJhVJC35WWSXL8kEJ
         v+dhPk9qVFOAkkdQEclaq6Z4jHoYp+wyP82Q8gzNh0glCuPEnxb+8b1Mo9QI8hVrocfD
         McFBZgb6MfqiAxE6PD0wyI2SfOyWTnYbvA22SdwLgD770Ji191lf0FMJcS9kBRNQHKAq
         ucVmHPEhmZDiEyfUaBlIiO7U7a3+jVbZ8maMKTDUyF7NpY4waQx1KBPSEESLwYpBfTk1
         Np6A==
X-Gm-Message-State: AOJu0Yz5C1dw5/uCXuCQgP0koX1e2wUEmyZHFwiZqm/+m+SEyCObZxqX
	M/NpCKY/o6wpVIjCFCFs3AQEOmTBFGmgJ6KJrePxJyyeqnlf1MBnv3WngSjuphYY0IPzUnAU4Be
	xya5BPriyQHrsiOl/2KLC/2rfgtxU2BVYhA==
X-Gm-Gg: AR+sD11bAkcUgA1DC0Aji6zwPbUwLS1lWVJk42vVENWC3J7+Cart3zC6cDERVsjSsmO
	ZDi8htMWT9M4J3Davcx/SRDsFrYOMnDbzUmWdq/yBCJloTyDm69GVLrDA7v7TAyJe/s7D9V0cCh
	mayREYtD5MqoiTNjJcFKk2ur0gIyyzNlDSt2U8A3pF3rQg0P7FOECCA7pPSG41+GQWV/tQ2nA93
	60fSeR4/lVsFeox34e1aAiBftRFVjIz7PJeUCuPMeZT++x9QtUZoX21wBWv+lK8nvqmdtWNiMpD
	72dgVMDD3RUMcUNrlerZZFbrRcahHS3SUUewVd8jirGvpZf364mP9PBD
X-Received: by 2002:a05:6820:8118:b0:6aa:2fbf:bf60 with SMTP id
 006d021491bc7-6b0c4723265mr670963eaf.34.1786562317587; Wed, 12 Aug 2026
 12:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812182807.7311-1-jwcart2@gmail.com>
In-Reply-To: <20260812182807.7311-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 15:18:26 -0400
X-Gm-Features: AUfX_mxmwc5nTwL_yAqrWE5UTcurQ337keuq12ycELJMmNYbQ-tAFdTjz5NC0YQ
Message-ID: <CAEjxPJ7GQqCkz-OVHRgmRn0C5xyYqv6gzqavKh0PrRuR6KVSUg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use spaceship comparison operator when
 comparing ibpkeys
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:28=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The comparsion function for ibpkeys in kernel_to_common subtracts
> the subnet_prefixes of the two ibpkeys which are unsigned 64-bit
> values and stores the result in an int which might not be able
> to contain the result.
>
> Use the spaceship comparison operator to compare the subnet_prefxes
> to avoid any issues.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
