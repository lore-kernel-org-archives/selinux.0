Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADA2853FD
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432478; cv=pass; b=n83bG0pfnMBbH9bMy4fLMuxnknOJj5lR+z7OQSF3Ru/9Inawd8U2r6kWAYsqlO6XSBQJF/51B4G+teqPjAQnRhnhO0u0vjxzazcVoXSFGl43Hw0MPnptg20OAnlyRH1waegZSz+y4Y3fmZzT8PdGiX6Q/A4DP9WZ3l/rxxHXuKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432478; c=relaxed/simple;
	bh=kr4JDZqQ6GkpflIHYnpSalDR03LZsPTwiWhVeONDdpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiHNYNxO3OnGxnPdS33NAeyPRSUQQsmb9Y8ooulolypJ2HStDftVvug2qcMXIaM6GUNbvyQB3l8R/IXm8Fnc3uilpw3Wwfr+uVMbNA2A6Zm7zA45GRmGYEq0hfFiL9QTeZm5LDxLlsJucwqKOZoFZIfUPWCGDH9Wq2rMsgFyHnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTdM+XVh; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTdM+XVh"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-446f87b6de1so68076fac.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785432476; cv=none;
        d=google.com; s=arc-20260327;
        b=fLF1kED0NmElkAcS6OLIVSiB5MQoNif+/0igb6h8a49mlxakedPZlc0g8J5/hQLwXI
         fGuC+KLau69nR6t3ZYag8LfxBe11ziz0sgxhiCD51RRfJOoAlXXOJqYHModi2k1xdp2O
         UrRJqHiQvi3lfjFqPdNWosATCxBIXIga5rgxFgjW5K1+R/wfCn8jguHSSdU36rnQBkMx
         70ka83NszJPyjaJ7E/81BaVIw5m1fC0CI/Cd+MfPJ8UzVnaC1TTOTClIchV9XVcPNoPp
         eZ4ggZgzdW3biEjYKXG0B9KPRwAaQJc+qNEFt2WM+lpQjQtDbWm/R4eP79LiYG9E9Dhr
         QnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mPMRAjw0LBuKYAG6CY4rM+ELm+0iUSzGEN09yaisc80=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=eJP/EGrlxS0SjBR64rbBvO8+b+h+fRqyYxGrl07II4sIhQL61KZ7taoikZe+SJLhuM
         h2oqqZIif/uPPt3hquTCIIcCi1LKwVcryFCZx6lkY3stcor5ZFXYf3L6T1tuy/WPjBjc
         /nLm9CEUb7E+K4lHbl5o/HclRyrN8f7URoCdriv2PDHcw9uAbNfiPYp5TQ283DKS2Bzn
         V1PLKjbg3kjPUApGBSRVyv9gsExxxzPmTcgn5rRjxem7RoELcOOZWlvMQkIfe7WApEOv
         hVEVJ+GpnphtbdzLJO+NvlDpC0peRagl+pa8BtFhxaM/OysAT/C//IWsMQv/Ql21ncVP
         GBOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432476; x=1786037276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mPMRAjw0LBuKYAG6CY4rM+ELm+0iUSzGEN09yaisc80=;
        b=eTdM+XVh/klNINtGw0TrSnwjxEd7kTpEx8pNHFob3Dphcis2ncjEVfJTT+iAOZtc/s
         0awaBWIY6kXks7sSYzsgf2Etu2i78hC19nvCD8Gn0ayXGc1FBzqcDquDQxVO6QUozK0L
         1i68QhGLEopKHeGPAdluEsv6ij//n0zdcmjlbeh2G4y2BkfY95+RD5gKuIiP6aYS2Eq1
         M98VYzeAiySUISisiHzlf1MvofU7U+5byIawAV9uni0+8H3tF+E1cFCwkFlgzbX1vVz3
         gOd+Mj2ChjkYhWeBkHUvmQkSMIq9QDeY/EW+mvcVMOdTin0zaOTnArh1afdX05cH5k+c
         a4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432476; x=1786037276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPMRAjw0LBuKYAG6CY4rM+ELm+0iUSzGEN09yaisc80=;
        b=spumrdk+Auwxws+A6pPHHG8KIhgKAxrpb5uIS9KKjcKJ8d9yuovZRd2969zP96QRxc
         KbvVelYmW8vSXYcdZXtFeL6ruTeKt7bo3PIjLv5xGffRKMU/1B+CRy5jsAktM3deJCjk
         z57k7e5kpCHx8eNpnScJ+WcBiywFV6UwZuz+0IzOtbOLlZpYHh1cU3FaadAztIGfl1NY
         FVQBXLelSkyjfujgn8BfJ4xYSFQp3GpERRfETK3NnhoYvv+2CzmVBDWVWARUCWz+NNKU
         ypFnl45SkSwgAgsI8CHlebAEJZYemUtXu9oxwa5RJHB+wwJy1biy3/Pa3RgVfkSgAQuN
         F7bg==
X-Gm-Message-State: AOJu0YyiY8lXPXCmm784RMfBrJ9K/e+B0Bq4c8cmJyDSkc5fxEB4asI8
	yF4RjauDoqsYhzDpIurIM2fcaiDee0A0gu96GLJbOysYc4bHUcWagNr8oQFyg5RvEqstvxGf8iG
	DKtTTPGNFTddIvEbxL2de/fkFQ6/RsCkayP3v
X-Gm-Gg: AR+sD134a+Iom7cRenMEYYUigH1nVJq43NZZ0sESthRO7kI2tNTW02DroOlv4BMNKHl
	3MjPGt1+SlEiE2kspga6TlzCQ7MMX50LMWGpOosUpXrx781WWS9Bbqbzg1WDQCblydNOj7jiOTW
	srk9yJ+i7FyvLV1xA6ss2MLPTy6EwbPinl50XMnAoEkt1OORSLPDyw1BafWO60Ce1M9xQsrHDg1
	W4avKowWhLr7zieEwXMt+l7vJeRk2sWE3E3E2zNqAIMZ/u9X4VZvZymXfpTkT7TdIvLyOJGm5Wh
	au0fjyEf62IQpuILKccz8OwB8vmrncZ66VE98Sahy2KG
X-Received: by 2002:a05:6870:d40b:b0:456:8bb7:ad71 with SMTP id
 586e51a60fabf-458c1b4cdbcmr2378544fac.32.1785432475957; Thu, 30 Jul 2026
 10:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730143911.34320-1-jwcart2@gmail.com>
In-Reply-To: <20260730143911.34320-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:27:45 -0400
X-Gm-Features: AUfX_mweLAV3FwOzxnyR3MA7jlQCt9mh5ImekQzT1PFLgg3gS-THO9HKCxIPRIM
Message-ID: <CAEjxPJ4cpacxz+bsnx_1VRnOHFx8WpmRTx6AR6Fog5WCYGVokQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/fuzz: Exercise module to CIL code when fuzzing
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:39=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> When fuzzing a kernel policy both sepol_kernel_policydb_to_conf()
> and sepol_kernel_policydb_to_cil() are called to test those parts
> of the code base. Call sepol_module_policydb_to_cil() for base and
> module policies to test that part of the code base.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/fuzz/binpolicy-fuzzer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-f=
uzzer.c
> index c0d96d8f..fd9dec91 100644
> --- a/libsepol/fuzz/binpolicy-fuzzer.c
> +++ b/libsepol/fuzz/binpolicy-fuzzer.c
> @@ -72,8 +72,12 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t=
 size)
>
>                 if (sepol_kernel_policydb_to_cil(devnull, &policydb))
>                         abort();
> +       } else {
> +               if (sepol_module_policydb_to_cil(devnull, &policydb, 0))
> +                       abort();
> +       }

Missing #include <sepol/module_to_cil.h> which breaks ./scripts/oss-fuzz.sh=
:
libsepol/fuzz/binpolicy-fuzzer.c:76:7: error: call to undeclared function
      'sepol_module_policydb_to_cil'; ISO C99 and later do not support impl=
icit
      function declarations [-Wimplicit-function-declaration]
   76 |                 if (sepol_module_policydb_to_cil(devnull, &policydb=
, 0))
      |                     ^
libsepol/fuzz/binpolicy-fuzzer.c:76:7: note: did you mean
      'sepol_kernel_policydb_to_cil'?
/DESTDIR/usr/include/sepol/kernel_to_cil.h:5:5: note:
      'sepol_kernel_policydb_to_cil' declared here
    5 | int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb);
      |     ^
