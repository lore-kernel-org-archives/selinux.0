Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08364AEBF7
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441585; cv=pass; b=YIZKDJHaHlzuoiseYpOlzoftA7kG61xxqGETsk16uREIxuEbsb0roKvHgwnAetOD6nklNpxrxaZauND3Rd/NmTrtw40QzETLXhJFzl8Y6uibXNtxDDvmXn/D6ogOZccVcnAIutrmmavcum0Lc7scnKpj8/qwSluW1F289OKfyZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441585; c=relaxed/simple;
	bh=gUMvtSG3k7irnnS3U2hCImi5y4fGBRBuekaUTzYLTHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta64rK/zK4aIXSepgyIaeBIqPfePF3Nxr2Q/+bLsa3A3xO3wOaSTko6nhepLx6xOhswa1IEOwToJxQpWiPB9Vsu8cDo/LOsFJWMwcPT+x9NvCpb8BQxC/geFtgjb64/6TMWyHobgQ7pNfEd6Q46gukdR/3igYMuWqZsyspz7e5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP4NMqKr; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP4NMqKr"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-451a49abd8aso1936540fac.3
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 06:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788441577; cv=none;
        d=google.com; s=arc-20260327;
        b=pV4F/2xHsLDsLyU3WPblVp2C+43jLRheGyWL/TAIgh3EAbmYuQJmt4j7LogvSmx+qV
         TlLIxE3NOcwxfplM4QZFGYwk+hmvGub3vpqy7PpZXYj+BtuVk/vld3F8pryj41EMoueF
         hCHob+3p6CnS0009UUlGxl1wGh34MqrEne85iSUodl+XKskGfPoOO5tnX8+RlYlEgMT6
         ZScTR4h/yKGrpehnIXSSBh5MZZVYgtaAmIsm7B+5TJcsNGd2+m6VkIKcsvlG/njmsJrm
         OippSCHvILoXGuQcWdELZOajoZO0dLIvc0diwP8GoR5mH8h48FLB/gG1ZLmcWFaeIcRq
         opjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmhzfsHw01BbcDeQb0jKxjqrUCpLCEpjUNBD7uL+nkk=;
        fh=aUbqRQkq61ZAI0AgKTda9vTeDxp/LdA3hosIEHHauP8=;
        b=nVL4n3TqNzXR0SNPqVT3fQ51TZ1bfrjgEgdSuOj/JeQQe41sL6dIuI89Sg1B4vpYUI
         turhW//p493LRKx4SodFFr8k4jhBnAMVulei/OUs4GP/Lg3gc60aPu8mhr2qu/j+rJsR
         DRIM5T1jY34Ig11EbP55N9yxSAGinJdFFw0tP76ZxbJaw/a5YbAwTuE0chVL2HkuY04x
         0GMojHEPEuCC+q2uJx60quvwG8nPsW771jITUnAa8ak2rqsGqwm0Hjfrr+IyEmZboyYJ
         OWi3CyOkM7H9N/g0L1reXWmY6KycNrU3NktID3IOcjezSZB9wg5nth20HdlH5t8382Dy
         V4ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441577; x=1789046377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmhzfsHw01BbcDeQb0jKxjqrUCpLCEpjUNBD7uL+nkk=;
        b=MP4NMqKr4wQBdo7DU/ePbUp8r0y06G/HB+ElYeLzp04gmCo27/QtHwQa1XGyADFm82
         +d5UHliDighmwSbVLx+yj8pKKsIDoUW3h6mulvUr6w+ufzdPjfXx3UFNygwUp3/OMd4E
         0VZrcCwNPvcIR6lyo3DDIHQGvnaeOSEtZLDsuHA90FakP8DFR8g+C27Un0RZSco0mK6b
         0SZZgEHCg79Yu3FkasSYjzYKV5LVAo4X5eJfohXg2NyOr6yWRqVOWL/V7382uwz6jBxe
         TVRKzDAhLyPDg0xchJLjjRZ//Vi1tja18FoINNR1qQ7T4zZv+YwleiiyGC7Jh+Z8qAAC
         kQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441577; x=1789046377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmhzfsHw01BbcDeQb0jKxjqrUCpLCEpjUNBD7uL+nkk=;
        b=hSAzAQpNJ8xa39a74qDxF+m6uIrDg4ry4ZVKIfGm1yasMrlTDrmbHPqkRXE7sjWOYh
         0yGYLC9OwLJxKAZ0vCMhGkKdG+lk2tyq+bW7tF5adhefdS95DlGNGDyQ9gWJ+DauoNAJ
         h8uD3DGvuAZEZ4mvfxjsQ3kyWOgqX5o/IRTTItFP4oymYGtVjE8P30G4AoFwJR4KQ53w
         YNmSdawRB8b3jyDF0F2m24zFlqfQ/m0ZT46C61/CDVBG3ctfpfUmD0AwnMiumIGtkchD
         4ONoBljCFjqjYPoexQ8KC61Lb5oTangNXrEeTCHyd5CsFyx9Y5Ha6FVZ6vxZLj0L1yG8
         qGNA==
X-Gm-Message-State: AFuF++kZc4kVSseX0Glvy7wn+vimzaGsG3N/TsfaNZiWuVEwTRbQKJSu
	leOuA+R8QY+L7rhCFwpd1V8uNX+BGL1TmtyGcuKU1rExzuGhMufw14Hl+XlhcWotCbf44uxTZO5
	rQNZlHZNyB5iorqAp6nYSNgp8uSb5+Cc=
X-Gm-Gg: AYBFou2gnNAd2naqmJ8fM0Pc07qaVJabIOvhO+9jxzjofzqPV4u0p1d/MD95BZvYIFp
	A70sGfX17MVBWrfz2oCeQnMfpKcP10wShkl6bKNb8B4OKSj5Aa5W2Mw+I5uaKxoEb0iSdWubavw
	cKExgO71TRP3w51tj1I5+HbFdwTRDJp/rkbfaHScWpf7gy3kR4107w62fxhRCOkkmvbh+rnrxTY
	XzkYooJI8weDPpqYJ5EsduS+PNGpuNOspCow2NZCY+WCINLkSufrzj7U6C/EyUuIyvAoWc2FIh1
	L2eqoYuTp59pH6OcQaqa9RX7JeoBTIFbM6j2GCe4XomHa7CLc1sGBf8=
X-Received: by 2002:a05:6871:660a:b0:46a:ce42:d731 with SMTP id
 586e51a60fabf-46f86cd5919mr12785800fac.9.1788441577063; Thu, 03 Sep 2026
 06:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903114338.77055-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260903114338.77055-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 09:19:25 -0400
X-Gm-Features: AcwNN1XNWwG0Kdy8HLXTAPl_GjnL5o1X-HvnnUB8aCyC2WCBFLOcmqeVAyuE2cM
Message-ID: <CAEjxPJ4_dwijvxRyrGsMKHr_iLnGL7NG12sAeVrBo_HSOPeMFQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: always fill AVC decision in avc_has_perm_noaudit()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> avc_has_perm_noaudit() is documented to return a copy of the access
> decision in @avd, but its early return for an empty requested permission
> set leaves the buffer untouched.  All callers pass an uninitialized
> stack variable and afterwards feed it to avc_audit(), and the inode hook
> even stores it in the per-task decision cache.
>
> Fill in a deny-all, audit-all decision, similar to avd_init(), so every
> caller receives a defined value at no cost on the hot path.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Fixes: e6f2f381e4015386 ("selinux: replace BUG_ONs with WARN_ONs in avc.c")
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
