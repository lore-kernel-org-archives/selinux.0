Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA8322B88
	for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840862; cv=pass; b=VunNBszqlX25QZzlkcvlaBNXrvAd746z3UckQ2FfBhfFV3FfprcT3p1f8A0lWcOj9yswHC1iKaJVcj5qEAqTYc+LPMynb9j71oLNAt+54d2Q3kdOJMYPQhl5KOh0L7tajrUC7pHwB4pWLLHO4/moTyviTvRNSYCk46a6rgldyNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840862; c=relaxed/simple;
	bh=e7H2ZIcRWVJ72qR026CL6hxw0ryC+gDGLopbXqipdd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZQzT6FWlf4uumgJh3qq4WVzj9jO8WCkMaYs55bgUu4kbLhJUMDg6xyOZovfdFfkc4/nIKjzZ3wC5oHqONk7eqaz3g6Db6OcR9WzehSM4u2hp5i2aKQ4JECxD+yo6OQF9R1jObxHx/bruMqDaGF/+zNW3HZd7KkP2EwO3SQb4eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1onY0Zp; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1onY0Zp"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso2222126a91.1
        for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 06:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773840860; cv=none;
        d=google.com; s=arc-20240605;
        b=hmQdekLENaDOUdI70eCadMJ0cC2UhrvKyIaFkYLK0KWO/sqlfkeqiw0+SDTF0xMPDf
         ydFx9li5981BmIEEyPs9OlGxBYD62G77O22qwPa4cakSJO9OP1R+OPZ0aG90PQgz6NMD
         /2CVAbY+zWJoqc0EN/KugV0EleOFQxGKHTpHlM1ydkkIRTlOplh0cwxxWkQ8tP+WyvKd
         nC36ag5S6gmHpxbDsFJmcGTvrtXt/VUZJg0sdPlLDVIS3KdWP/UA5goe/M7Eb8xoiiAK
         vmMzaCvtmMjQbURBSsfjZ5xDMOxtOuVfa3GdHc+a6x1AKKBXrMhTSjRLOMVtPXdbgzCf
         ljHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nbawSEZ7e+WZAtjkmZOj6zd2ypvtdTSjQvlR3NQLEU=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=OBLaoPLfdHfbLEoJYAV73K4l0C1R7Jo4aHlVMRlLAWqs8YvcMk1Z08O9OekWZtgkZ9
         KJg8awfd+q9uASrB/ZeihjsEL3wig1ek6EDyZrxD0ysAvOo8hpJ/g9N84NNQtD22238G
         YMrj6ld7Zi6/LLCPVyL0ofR7mwRnAnYtPLvSyfOcMgl+cuSH0PYu3rCt2f5LUk00lNyC
         nwlQwWM3JTeBS6J49cBQ7d9I7v9q0scj0c/T317amG2NYlWlFIkEigQvzPr9H702TkFE
         xgbYkP5Lxi6gaj8xwAEzyW9kgTUX+nsLlK/VEvk72Jah9K2FPfPnkPk2zFcdgQwX4nGM
         6egA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773840860; x=1774445660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nbawSEZ7e+WZAtjkmZOj6zd2ypvtdTSjQvlR3NQLEU=;
        b=Y1onY0ZpO4czLbK8x22ppolIAo/lR46WhlcemwzYilCPvHxItHgtBal+iuBdlCIkf/
         9/bd8mkFEjn51i2IpkjH1UDHuBw1IeHGF1SbCV+cZySKMYPEyRCX7hRyqidUHW/I1OCe
         ahLoACRiGT7MK2a5uyAU2MV7Rkx7iQoVOr0JpTtkc1c6CatY5+0AArb0884Wwz7BvoCZ
         7ZilXnEVOEpoM3ejQiRPiTcMpeyJNUzFakJoxHUQuVDCRZG0jCKyZQlu763IJGffguBc
         S81G6BwzXqPkEZm+QvxOOssHrrRzLSG/sqoUFSLFjRcTRpbfXmARp22RFoELHZMxPZpj
         L6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773840860; x=1774445660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nbawSEZ7e+WZAtjkmZOj6zd2ypvtdTSjQvlR3NQLEU=;
        b=ZRLbIH7cqJacZCrvuY+smjDhIROBBlfKUnOtv1ZmMad79HKdwqJ9ZcW1V4lE6B7/bO
         H+lz7Ulkgy3VSO3R4ZmrZtSlvf2+qBNO/dLkwsL2edqS53X3XQykJ/yL0yQmILzcuOgc
         Ghlnst/kCDns3eECrPJLRANY9wALqSVVvwknhUTBKpbToDcKdpk7jImP4XQHIzr1Bt5e
         mIWaVS/FW/NrLEJqyooQNpwXZa83PQcoh4ZJDImSPpv07mrFcwAWdX2HXABqm3RVLLA/
         hFV8O1xuNS2a+jjdc8/D35090ysmSa/SAMB3HS968ea/jK2CgFYGkyLfjDgzx+7B98xi
         xr3Q==
X-Gm-Message-State: AOJu0YxvGva28g2Y/z1sSJzc9hgtiFl0ZMlQvOqYmWeU+526jtntXVF7
	6EwIZ6bOTL7ZU2GqxYObr56c87GzHIcKC98LN4Pcos3EONlxFGyv0T7JVBUdgzDgE3ylI6HtFl9
	PKepGpfjXB5kl+GeaOIVauQeCWn7X9ggMVvy0
X-Gm-Gg: ATEYQzwV2E6Ms9o8UbyondXqRxCilwSVmANCZ5G80/7PtR3gDC2d7xUg1dLaWS8tcyO
	xSj1aON1SBTjjTxXC/8rl3esp7roW9OaGdjvqwjIqIVmW91osJ7cZVxRY4KOvvrT2g2mmW57Afn
	Ql2HPG/EzMFU/Xes/HOhIsrw1OW7BAjF1oDcNsxyMR7mgklxHAkFfeOUV72UYIMXPSxKT5W6s33
	mQmB1bl28yD5wXHKnRHTP84TQ4JTd7VWQ+ymo5Jv/zziGftrqCeCNSKB2B0mRn3s3zsvQ/+G3fS
	Exbgopc=
X-Received: by 2002:a17:90b:1d52:b0:35b:982a:28c7 with SMTP id
 98e67ed59e1d1-35bb9e3cf19mr3086302a91.5.1773840860244; Wed, 18 Mar 2026
 06:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130153229.2422340-1-vmojzis@redhat.com>
In-Reply-To: <20260130153229.2422340-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Mar 2026 09:34:08 -0400
X-Gm-Features: AaiRm52fS8tuPX8Imr3UiwJkyst3phVnArBdrvCq7vRIAGLcV8Kb4GLdlAG60w4
Message-ID: <CAEjxPJ48XM7pe+W2Am14uAqz7t8a-yfCZ5Zwq33YGJdm6oYNLQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Ignore directories removed during relabeling
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 10:33=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> Extend 54c79a74f5b9154762abaadf8194665598b24115 to directories, since
> users will expect them to be ignored as well.

For future reference, please include the one-line summary of the
commit along with the hash, and feel free to shorten the hash, ala:
commit 54c79a74f5b91547 ("libselinux: Ignore files removed during relabelin=
g")

>
> In case ignore_noent is specified, ignore directories removed during
> relabeling (race condition between directory read and removal after
> parent directory read).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 681c69db..2e605b5a 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -932,9 +932,10 @@ loop_body:
>                 case FTS_DNR:
>                         error =3D errno;
>                         errno =3D ftsent->fts_errno;
> -                       selinux_log(SELINUX_ERROR,
> -                                   "Could not read %s: %m.\n",
> -                                   ftsent->fts_path);
> +                       if (!state->flags.ignore_noent || errno !=3D ENOE=
NT)
> +                               selinux_log(SELINUX_ERROR,
> +                                           "Could not read %s: %m.\n",
> +                                           ftsent->fts_path);
>                         errno =3D error;
>                         fts_set(fts, ftsent, FTS_SKIP);
>                         continue;
> --
> 2.52.0
>
>
