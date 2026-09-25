Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE34E4328
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363831; cv=pass; b=rm4MT07OQ/g960Z8r0WidhCcPJ9qk4bn+EY7b/md8zda9mUoHoQSzScJEJYhzyIc+uWxXfKgFPeiuP8LB9splYxXO1dMXK6oSEcSJEf7IhNYpIGEat+YoDAU/oSQveCBRdK2UxODVTu9AVqRtEbEvTCER0e5MSIcFxBZTGxKZKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363831; c=relaxed/simple;
	bh=pwvTYK3g49jDcErulgvKu8jCqq0xMdPDyEfqzMAoXU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zlz8BYbJ516fQ9D7Vh+WU347GKV5Mp11iaVNx/fqlcZuw3hkfnDS8z+nvJ9Hg3QLIK5QHDWmpUlGCceGYb1ovczLoW/SfhQdwOuUfs/hBipt/oyxKsskhXePlZBswVGONm4165n9KQg1uQlXSAQ6XR4373xR+6cEbpJVzMQZJYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1SxW+Tg; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1SxW+Tg"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67453dc240fso96098d50.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363828; cv=none;
        d=google.com; s=arc-20260327;
        b=apmJNFwp1Zj70XsUGELnaqOvteVSCkLr1ShMMW9HVVQ1iCvlw8rf+KAiV64r6VBym5
         NQaGGHVkCCDW3Gukb1Xvs8qbsNY2VUe/ipAq6b0KZyKWPnRW6Gjfo4IXSPu+ksqGnuve
         s/pbpKRwUJzVWLjjlPj/zyNFxEclr4wy7ireWJEiofC3GeEra8a/uvfdoFhH/egEekRX
         Lmh5JjFCpyw3Qu16MixIzhQiaKRgl9971nAOR0BlJplcS3GSjjK6vlWFiBomfmWLdl2Q
         quH/lCwHkNQBZURbocEdgtMRBdUriRCmlCMFzGxEOr04BC1f4HgN+HgyJ9lnCntrNLuD
         J89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VIhUnBhtEOO2NqpbWqUr4jLveSnVZ2rVmXT5L2FJa8=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=L1BXEakVCbZO4fb91VXQpnTklAX7uwuGEAu6Mena+iHCmPj3qsp1BvvNiedRsMP/W0
         EbeMnFWaiivERvYLDmDBFUxE8feB01WQTnPrRulWVE61sHEGqODi5I15Arv4CBZCbEaH
         PlVowjqDoT7agtV0gRHz+Flry9drpYcSAy5F1651BaVM76LCyCqay9wP1x6znCuCOa1s
         HISG71FxK63vvPdaz7ENyJBJbtaQJfs2ee8nmsi7JybqWx+SpVt8fjW0hK+etkXl5mmc
         UKAmfkwsGKjM7JMzd3QlBxsjUw8B4Si7nIAonxMzQlsb310v5lvC1565dYotnHkJ1+k9
         P0iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363828; x=1790968628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0VIhUnBhtEOO2NqpbWqUr4jLveSnVZ2rVmXT5L2FJa8=;
        b=d1SxW+Tg+31EkwowTBxQc/js3CijqjRuvQTkFWySvnLUqllNGLWbIWaJbb1BYY4pHC
         moaFNzqXSaG+x2cp3SYpXPUn4p09G6MXsR8M3OVS9xTtO4fb7CgQLoU9lCNJ8+aSLrdW
         IZKFNA11XodpDLMpyFV5xkl2Z2PW32T5if5Dm0Vyy4GYVYJqfbmYWHin9pKuCjZEb9v0
         qQJweUtlph7e8kX4RDYo1CVbDDTuXzWY4vX4ahhuNJ7F6S0dftnwtLLNqMnNCTtRNK1x
         c2DuPl0uinxVXcivpJXxgjfJEBA5uuEyRJnpeB3fzITJXEuCFDcci9QSgiDInGeN2JzX
         8MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363828; x=1790968628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VIhUnBhtEOO2NqpbWqUr4jLveSnVZ2rVmXT5L2FJa8=;
        b=xXxwjIOE/BQrQvS468GLPgYjuirPvuZwo5zvxaAZICUpBQZv56LTqvrYosDWdzdwnB
         9Xma4VXDrTsxphSxpWT9rXQU52BtfARq9A+Mz4H3qfmcVHef4sM+9ps+dYgMfeDVxbaJ
         e/P0ZTprQdYpL3Sj9h6OTLXw+DzZKJZNk21wdbV8C34YL/2tOg+zYnk4IQxZXbsOI6IT
         AYHyzLg2NVtDV8NWVs9wcUdAx398tZUjV3l8koMgwxh4C4dAD92mtBm6lqPAYXjd5UYX
         nAnXh/drlBahR1pQPcT4T0eAEIfrvHHEn6ZDKogz8crqVjQJ32ptoBNzzJ2W1v9SEOMr
         3SIQ==
X-Gm-Message-State: AFuF++lseRNCSzmFB9EYS+EFoG/mNJPGJPn1q1LTOMC9bjjqh7h0I+UH
	aJ4dN65iHGdg/keCP3BA5sK1Hgp0B7jYWxe3npz56v5dEMAX0PcAciguH9WxrFqjnebE6eVh3Ux
	keMYIaZbq2WJnojHjKJa2vqhLl+uD8NI=
X-Gm-Gg: AYBFou22+Iqo1AjjluCnQCBLaZZ0nNyjBHLYHJXHrqdsY/XJHxjRy7IMAKtYYAZvT+a
	NKjlHRXbWzNPNLPK5RsoqrIUpKXieGo/qm2XKXBxGAnpZPprtkKrtyBeLBU9bQUPNOYAWtureAg
	vxK8+D04ed7onQup1Bc2tQ7kUMh1d5L+YGFEgngiDwc4taObQPnpkd1fkJCZWQ6tT6vYbkYueq3
	XqQXW3A4T4lLZcmpkAK59Qcpo+7Asv6zd3v/0v+lPzsTl5V18O7z4eyQ8ruqBTqHApFnXbgAs/D
	QnPAAQBy8j+uI059VVWGAFJTHJJR2w0B4jA7VCyzXXQvhntlpihPegU=
X-Received: by 2002:a05:690e:12ca:b0:671:3eae:6dbd with SMTP id
 956f58d0204a3-672ed027300mr4285738d50.5.1790363828468; Fri, 25 Sep 2026
 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-18-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-18-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:16:57 -0400
X-Gm-Features: AclHuK-3jBLAIZflUEIhiIxanraiOYlRA3pgbSVJLpuf-LZcjO5_S9au1lVD3sE
Message-ID: <CAEjxPJ6L6WK7Z8F+4L7kAxuhPw6Sk2tiQ5moNUMhDXuMX0+OFw@mail.gmail.com>
Subject: Re: [PATCH 19/21] tests: test code tweaks
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Be more cautious on unexpected failures and input:
>
>   binder
>     Avoid returning garbage value from binder_parse() in case of an
>     unexpected (impossible?) empty buffer.
>     Store create_bpf_*() results temporarily in an int to actually
>     perform the error checks (they are currently no-ops on unsigned).
>
>   bpf
>     Initialize variable in case the program gets called without the
>     associated option.
>
>   cap_userns
>     Use appropriate types and casts to avoid implicit conversions.
>
>   execshare
>     Avoid use of void pointer arithmetic.
>
>   fdreceive
>     Do not call non async-safe exit(3) in signal handler.
>     Drop dead assignment.
>
>   filesystem
>     Initialize variables in case the programs get called without the
>     associated options.
>
>   inet_socket/unix_socket
>     Declare usage() as noreturn to help compilers avoid issuing
>     inaccurate warnings.
>
>   inherit
>     Use a large enough buffer for a potential huge PID.
>
>   key_socket
>     Avoid comparison of signed with unsigned integer.
>
>   module_load
>     Correctly check for an open(2) failure.
>
>   nnp_nosuid
>     Check if wait(2) succeeded before checking the child status.
>
>   notify
>     Check if opening file was successful.
>     Use appropriate type for read(2) return value.
>
>   prlimit
>     Set all members of the new limit structure.
>
>   sctp
>     Use appropriate iterator type.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
