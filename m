Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F8352019
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687961; cv=pass; b=b5pibTGoxX38HyV5XBBfuhZ72pjvkjgDyt7BHYlh1+Sl6teLzoMqshyAxjh6hZOrqDYLaURH2FtDvtEqpB7BsqJByvjaPay+tPWm+P6J1gqFNyGGPLPNyvyHjzx3ZkwYVLgpJn5LjIjx+6ilXwzmDD4Mm3t2+1SXZ5el4HhzMqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687961; c=relaxed/simple;
	bh=NgnVMSTMsnYbpl9ORS2zD6ifNgJNQeV1BFnQo5ozla4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9U2aq3Ia61xlXi5pUdHhRonglV3lTJ0z8H7E/P924bGUVDGugb6G5GEV7q3mtlt7tfkcbZw3e0TRpfxsA5qtlIHOWQEv3J9m/+f98YQxZJfg5keAtrOJExYSZE6CCwTQWNs7/xwfZLsAocqR4gIbeFMSOhUCnHl63a6JfP02Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtoUx22t; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtoUx22t"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c74c469e8so838461fa.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787687957; cv=none;
        d=google.com; s=arc-20260327;
        b=XW53BtmxO2BqiKMWtzrDx/63LBPz0xSaot5wIydRHhaSr9eC9TNcnYZ3zVjPUrdF1X
         9oTCy5DRuPjkK9vAzHekUgWbyN+fcDQ8L3wVyr4P1QRNBwdw4e7EaC5uQKg5yXPHIgIR
         vrb1wODTL1wxjYyFhi+UUmQTJwmb1xj03TD5kF/Fb6VS0wyxYhr2s1SDLbeswNbGDe1q
         QBCCdUqAx2n5F5D7FP7gqAfOFMC3oB5S7vbf6dqM0cr9oA7ofUVmPTU2N2GeHu2JJWr8
         fiH45hESJr69Ha6xff9NXsZ8qVqMgi4hF1IWEF3KSuAWocp5l5erl1aTL0V4zwCkiWW+
         XRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XFiWDhAH0MdbQtq0QRoMC4WMDsmPmgq0oTf4gV8YMT8=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=Nu3N0ra4qDpgV06bQl2cLff4rAB4vQUMVedzUYbmhATX6TZmgFTEfK1WEON1TD+EEh
         3jXYAN02TY/YL+NjMoqEOOpqIQQPCuS+ZPuJ9DEhcVemOxJqrhUvDKHMBxdVU/eWLoyk
         10B2+Eun+6f+NK9VkIBomRkCnb1et8sJCVgVpWikCkKf7JNjPiZl849jRg4NFuBFz3Vi
         uxkZONIAJAp/dHCItkjkI/7zGWglomymPKgqPf6jIq9zA8hvmYqMXpNzoSinpAJ8T+8z
         wbS4GNcLo63uOofiwGUiaE19bwLbeP/DXZDXAIERggi22ay3VI+tgjaOeir0WStpf1Y6
         B+RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787687957; x=1788292757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFiWDhAH0MdbQtq0QRoMC4WMDsmPmgq0oTf4gV8YMT8=;
        b=QtoUx22tICWp/H4ttq8wNCfNybQAyUHkk+BEBFGCTmEzd8zLCRZ/12W+cUbcj1OFdA
         tdmbvoS5iCL8Xzs9MMPwjI1Oqa8N6dFEDuAfd08AvNXtA9gHzmBjYzC+MnQuViW1KQRG
         HBlSmfGPRFEMfjFx4zKNNDbV6AkWYgxV+So/Ym2MvPAX9mGP9Ls0SCTs3IriFjap98jH
         kCCuV/+6wjaA9wxkyC5HV2MNrTNEyhcI1zfrZ1AV8xfWHWSA1MDbRg/LT7H2/SnPjngp
         xrdnsX4ozhicuVqt424HeilhTl8t1d5/msY13o+5UGjysrmis7VyltDBad5MqYPsu2ll
         VmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787687957; x=1788292757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFiWDhAH0MdbQtq0QRoMC4WMDsmPmgq0oTf4gV8YMT8=;
        b=WRHnaNFSRnFUzAY2oDWyIRIr0qJsDrM+pvsQ8xeNseyNKO4mSe7E7H+yxJz2ierFkm
         ZbMwwlPaH4phscMTiPjHxBxECfMm4OpSAQLd+VRb1x4sOL7oWCi0Akf5TYP+CdQQAslj
         oNSaM32/VkgjSevtlwJ0NYdP0qw8j6Q+NKYJpIZSeXnn1PU15nmEcHfpcp20lck81KGt
         Vv7FD3FGnG77+RnzVpIp0bGE9MJ9dR0TwHEwN2HUaEGLF/JGf7qqcj2A9+A9CAxBkwk1
         4RHhxKqZ7f2VfBr+bQ5XYoPxdOogc32Gp7RToAcFyZf8ggcs6iXlu4Ma5wwCgui65MO2
         LGQw==
X-Gm-Message-State: AFuF++kmYUUIE8bsEs8iS50ffrMug9HXV8JqA+nDreV09aemWSbyqZua
	FkXulmLrHo1L4gMXgVxWnIKq7ScaIJGHsraSOYVk0Hpb4rZljZOZuFdSJlJEvhhyKN0sS9rvA1S
	oZ2MV9lqpHY4PhlZ03iM/9SNYlafucYc=
X-Gm-Gg: AR+sD12WNF6ew8CSqR4lEy0tpHZMpWAYKqGE028L6gIGpdpIypQQnlIEthahKm5AI4a
	Ob2nAcuYT7RIm8ucCWg/W1lsEFzsg761Wtd9vFer1HM5hS+aMVGFoh7lyUZGWFLpb/iYy29kQPs
	2IFXvKxv48c8dqXkMdFlAPPCTh8COkbUJfUKm6oukjgB0an+gbcVHhkCVIbxRm/nWBXK+uV3JNZ
	5IwLIOL//KW8T/yOCDyJrEGmeVXfuB3SIKYVf/HgSBEIWGtkV7mngY2y8xRS15vKpDeb1BkpgEd
	X6AyjLKMS6VxKsZIaTK1hibhsloRzYaEo7inxmQH4w==
X-Received: by 2002:a05:651c:154e:b0:3a1:4509:937e with SMTP id
 38308e7fff4ca-3a1fd473b5emr2685761fa.4.1787687957083; Tue, 25 Aug 2026
 12:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825130640.85223-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260825130640.85223-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 25 Aug 2026 15:59:05 -0400
X-Gm-Features: AcwNN1Wcvs76qFsUoTB5mw_VI6Owj5cTzMsgmM6l83fYS3T3kWfkcG3yyslWjjw
Message-ID: <CAP+JOzRTBsXcHb2PU43c7Ar+3=RDwkHpmyGxc-GQpQO+XKx+zQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: fix operator precedence in flavor check
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:06=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> get_local_type() and get_local_role() intend to reject an existing
> symbol whose flavor disagrees with the caller's isattr, but:
>      if (dest->flavor !=3D isattr ? TYPE_ATTRIB : TYPE_TYPE)
> parses as:
>      if ((dest->flavor !=3D isattr) ? TYPE_ATTRIB : TYPE_TYPE)
> since !=3D takes precedence over ?:. This happens to be equivalent to
> the intended check today becase TYPE_TYPE is 0 and TYPE_ATTRIB is 1,
> matching the isattr values, and TYPE_ALIAS is rejected either way. Add
> the parentheses so that the code reads as intended and stays correct
> if the constants ever change.
>
> No functional change.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/module_compiler.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index d59e493e..07f2b3bd 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -636,7 +636,8 @@ type_datum_t *get_local_type(char *id, uint32_t value=
, unsigned char isattr)
>
>         } else {
>                 free(id);
> -               if (dest_typdatum->flavor !=3D isattr ? TYPE_ATTRIB : TYP=
E_TYPE) {
> +               if (dest_typdatum->flavor !=3D
> +                   (isattr ? TYPE_ATTRIB : TYPE_TYPE)) {
>                         return NULL;
>                 }
>         }
> @@ -685,7 +686,8 @@ role_datum_t *get_local_role(char *id, uint32_t value=
, unsigned char isattr)
>                 }
>         } else {
>                 free(id);
> -               if (dest_roledatum->flavor !=3D isattr ? ROLE_ATTRIB : RO=
LE_ROLE)
> +               if (dest_roledatum->flavor !=3D
> +                   (isattr ? ROLE_ATTRIB : ROLE_ROLE))
>                         return NULL;
>         }
>
> --
> 2.55.0
>
