Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F445A284
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437427; cv=pass; b=Tz8eMfWoc0KBIlf4v8N05CXbCBKlM3FDtQ+E7ZyGSJtAUCiFfY3iblEymkXQx/Wi6w+X3C6eMMYz8utVOdcv7eP5igzlYCF0ttVoe8yximA1CdlIG84Drlj6IzIerinwTr/s/l85dYNgV5lnm0JV7U8p6GxXXJDbyc520u5j4lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437427; c=relaxed/simple;
	bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMKkjmn74GX1CcHPuTiFx74ayd9Ccw2mixkqT/Z/O0uXoU63au5BbdN5j/c2XVCT3OH5mxWnpoDT+P7alR1COHEEiSA/PEIH+4D/TYrVwYoWvh0+SPKwrJzyKZGDvRvFHkT7Loo1SZfPEZguMEvCUJN4UokhdeEQ4MGCzRHpLoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Ej7zYc; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Ej7zYc"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso169229fac.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 11:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785437425; cv=none;
        d=google.com; s=arc-20260327;
        b=exwFAIkpkeL70YpCtQSLyjxAS97/u5m9bLPeZVUQE711wPkyvi8bRb3Mqc1fpSv7bk
         6feq50Q36yJmJQNJbT/JdPlNuGsmU+qYtD16oR9ktsmDiJJO29QgPPR73PQfCkYTvHNW
         Dvm633VSUuXG5p7eoalPWYLvJsS/cy0XGSrE9NhFiFqdELAKozfss1J/d/Yabz9sS9Fc
         Qog3S33YmOzljYQOaVRKpa1o6u9Wq95QrnuRNzJXJv+8RoVdscQcCNKNSB1ol1et/Zmx
         +wfmx+wXvZ8711l+lrkOPw/taAYDNFTVsvuosl73C15+6cqnKjUoJS1ASJEEzdf3tAOm
         9w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        fh=I1bFbH4pFuRqwVx5okkTaSYJnvLx5jo+UMmtHGXDnGU=;
        b=ALzjcRAThJEcB5c0+thtIUP2vXJeclxapmomtNdB6tKVaHMQBp1QZ6UR7a2exNu3oA
         KTspa2daFzGlaDOcWIOu6B1iZNYBfzNDLlsYcLmmBjRSc3FGtxjMo4lZMqLB4Td3WT33
         yh3GgGqS3b1Aou4ZWdCLM5ymcikHRcB/8ypg4b2BlChnNbVYY8weCZefQrP4eWgBQwpC
         IkFmvffOm/BXj2kEW4ycHM8zuRahiAYakM2q2oWC97VRUoqwMkim+YdcAKwZA/8LtJFQ
         mPaV9Ckv1b8Jdfy2LZ8oLfOfPvgi7ibsY8ZFryyVtgOWA1RkKggrYo1M1pGt81B9DaH3
         cs0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437425; x=1786042225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=f8Ej7zYcREBo1Ix7zZLzyYMQJtQKmTw4vQxRTwvgZZ4l45bRzkXbQePryCxlA6Gpym
         usN/hO1GLpIZSxskRSKwpaR8otVXoEkHEd3JjzWhJL3aLkcfslWeD48SDFTXsi0PqLKN
         dhnwpfW4BT+GatS98gLfA+20Qdb3t0C5y0NDuNNK8ecekSSTGBi7r+BZol9czngbZhNW
         1ASfRJ8CxI4ptIlM4fLxkEwKq3qaEaT3qx1+FkZrY4QBhxQr06m33FACAdtcWh2LVMcO
         KAsDdfDivuX3+EnVudaXUvGbdN6y1GS41aw+5dGCImrGPpIx0wz3azmyE2bpaxUfXkie
         M4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437425; x=1786042225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=aB0rzBHjCS3MpS5dJlmYY7yH/T4atQELb7C2tPrRa9jgqAttwzmAsglbmWV53fb6Cf
         7QkEt4bOT9AeJfQwe8En/RguSp6eDapU0L9PEeK61OBOYKtm3Uc9oIO7ippQl0fI9HWh
         Bz8tU8jTwrFfdRFwQL/c8NpLex75t7EXpj40jP8Tk5ms6No0Nsv2fjew+dhCSYMGWbtK
         xsndyc2Amhr439L6PpSaYhk3J8bd1eOCiXmLQR7guwAqnylm833H6If4pFaymASSsuxy
         WEGlS7SjylnA5HIxF3jt9rXzUDZil85/gCeyt77N70nQc22LfMzmauUR7aLlraO83zIZ
         Q4Vw==
X-Forwarded-Encrypted: i=1; AHgh+RqpSBUG1UENvidg3MIAn+QUzMfWH/X4ZbbqKGkKISFh/Nbrs5SLCmwHlD2rgo6ClPNRuDwx24Ff@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0A4f4noNUnd6bYCUTf4Rs8QJNO+gHCR2r9pt8rDr/z3ZyhH+
	rd4mHi8MHtujCKrsaQJFcrFaTV8vookB1+HHfsrEvRKiISfeNE47cYWfw7rGEREv/Vz69jo0Ion
	G4zjVWHvSS3evQ96DqkBoSPZ//V7jBLuyDg==
X-Gm-Gg: AR+sD13MHECtmGvMyIVtP/R1iyHSw86St3Mwz7xypZzByulCBOrZXhhjio+Ld1R/sdw
	0lwY+nIdeKdBOujLBbyzTKUAt5NexGzVTDTzn70UMZHFdTom5oZLbPcQWuLg2p7XwW43aiva0T4
	+DqlfR/qZRf0aggpxmytsDuHjgpfPcm+/Oc0Ps2nTZtldttNDa3t0QJW6+RU5iGWhzTkT81E3qD
	HjZjFo7AmJS5iNH/FYLCosgqnDTSy/xbXTzOmEAvKX8LKgXkt6OPRexLr/YCryi1Yyltq3DGIDf
	s2NHbjX9r0dkdHOGPkdcZSCWKlqqaQwhKu1rAUrA/fVz
X-Received: by 2002:a05:6870:8a29:b0:456:b249:700c with SMTP id
 586e51a60fabf-458c0e1c200mr2600508fac.19.1785437424719; Thu, 30 Jul 2026
 11:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net> <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 14:50:13 -0400
X-Gm-Features: AUfX_mw-sWflnKZtGKmCqYRU0sb3jjE3qrtGy_CKaW2nfsOdhimFd1pr1NGG468
Message-ID: <CAEjxPJ47CTKXxx_DvSbuO5F28T-eNPnQQ+Gm_-qaAeb6R3wPfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:10=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
