Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C33DD528
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281998; cv=pass; b=BA55tMzDvbeQYDbNGc93YfCfFV/hmivJwp0tDbrHz6BFNxMPhfc8s9fFBRFEp0XEh8BQfGmfaNQVYSBhK6HxWznVSKD46RnAQaNMH093c7dJF2FGNHuFy+QpAM2+sVJ+j8FGuY4jusGAE6PfvVT5ReFhnjOGhhYpRvjmFD8n8SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281998; c=relaxed/simple;
	bh=UGe3wiS4GQtsGjjQd+PhIss0v1r4D54ventw/MDSbeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvgTCrOzlg7IYpDkQHVcQDBz0RQqLCPfZVz05B1zQRmdg5rLZHjUy0lOecjBkY6+51XWro5x3zD21NgInrXtL2JTQnmheYGVZNMGZPpjLIpBLMl1uu2ikaXuPF5RZbhJnXtfeLmfRWtgRsBAyTGHmiDuuL2i6ZM3w7epyDAp4BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTnxQeIn; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTnxQeIn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9ea536877so28067585ad.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 05:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779281995; cv=none;
        d=google.com; s=arc-20240605;
        b=I8WsH4w526DQOS3CVKsOg8HzPcSI4Zb1rTnaducIQa97u8RZcqxj7oLeVTk8RW5KoI
         RCMmMdVzZqzLJqHUOX+7x4pR/g1WbfcNqFvc++MnA3FXkNDHd53x37jREg68p1S0CW1k
         hYmAZD/qF3H45wHyb1MVPbSBkmzmx++PyWTQtjs8BZOLfn5Sgsf8wvETtB+EtmepCnyF
         9rFBCKZK85Hb4iSsPamVAnHFzeJ8QQJYWB9cfZlbfmmOsTf/KUW3kFA7jhVxLgt6ueOP
         YqRnBmvBVpgwK+Em5neXAgFyy9at9rOPh6S/wRO/oJjrT6S3F+0m7eZaz0rSGoiu6NgH
         kTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQ74YDRjV52rRGFLy2gHoDHzJt2Ip8x55ThkrtozRmk=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=OA5afhaTVqc/BYJSUtl7dzGTBxNweDr79batXVdBMqNcrEF/5I0hO3pR5XE0t04nn2
         g5xfbfpyIJ9T718/3gkL7lWYXu1gjUKnpc2pAwb/398GEgJ1S8wochDmJHrbjRdmrno2
         RDNWleGHIFCqP0WpXVKZmXQ6ce0eiK4BNXTN+zY46G3XY69Oi9sskkTno9bw/g+aeSkd
         LSeOdQnBrkLIsRnqz20qPLGpRs0mm63iMKM1kny0xvVq5BefjY8SBBePDAYsVqG1H67X
         R45505j7wuZ3qrKOOM1w/gEfH1GzEyv1/tmkozlBKvaYfnLDEV//rJWHBe9KB48P5ewQ
         NN8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281995; x=1779886795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ74YDRjV52rRGFLy2gHoDHzJt2Ip8x55ThkrtozRmk=;
        b=TTnxQeInbzaqgXCfJprL3z7lh655bKszP46Ua1CsV/kgjQK7jMUr9ubk9fgHJ0OEyc
         hRqXuMqQ+bItpytrgYxChF1ZEg6XLFIXVKdV/Rr2/qdufARdoY3FUB66R/n3dazTYG9z
         FSWUwD1r7ByBpw8T17BUrGHNfZwjhsiRcHAujLt5J958znzvyrxEnWUHHurzBo0D2GyV
         6gMpDHwi/lyzwWtmtp7qVulvZaiZXWdhh1fyNE1cy0EUyEY5FPjT3htcMnssHwunyU+a
         qZW7AAJvY9JGv0ykfxa/3RqKLXH4R9OfYcmw96524Cz2tT6z6i9mEyc+wjxVZlzn7tcT
         B3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281995; x=1779886795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQ74YDRjV52rRGFLy2gHoDHzJt2Ip8x55ThkrtozRmk=;
        b=P1dlGTKkhpcviIbrHpcMVA9nvL1MJZfNNhKHi3T1SrBFiQYnrVQgOPwk01PuZrDBn2
         O9HkSR6r8MruyZg8QAdyz5Tt3z8Sdjv6xfPexXpgZcDuaDyoZ3me/rzV1rsUFbulu2iI
         e/dKMbLcDK68ELjLd/jlGFGIP7YGn2g7UKncQ8+506bHeuOFGXEC26z2OtuwlAVV4XNb
         QrVYQRk9pmjdi3xmT1bHR2WUGfNaKoiaIZ9j83kSqN9K8BcW/fK35eSW7m7KgFjV8PwF
         HJyVvnC1M+RZLfs4ROmfce0pKgzqaQI6aTC3V1WI/cHRv5LylTko2ycM903kf5q8ojA6
         GVZQ==
X-Gm-Message-State: AOJu0Yxn7GpiSedhTmLu41mbXeu55ycr9qlTPH/lGcbCLTW2HRZO88ao
	48011/Vu82ecU7gqxWVh1ib38jz1oMA7YY7xOLYc/izSjh+7JxRMwj4Uk5xpw1NUqApip7STSzU
	T7ZV7aWRTRFwO1RIM7xRSvwGiZArmYZ7ATA==
X-Gm-Gg: Acq92OEL8+Fz4itCumTvO0/zLimPG7GVTf7uzNsK3LhtBn/igD4TsEnytjkv0ZoS5LX
	xaCxfXAWDUsNVwUWQSEQ4W7o8A9RCev+ykvjf/uUB1gke/Ikl1H6vgP0GIxQik7gvMvFv3osSI4
	Cu9iyVzoLLngp5mZv6EXFN3/XzR/2NfP2z07mAh9rvfrEF3bKZ9vLyMa/J1ZCgkEk10+F0psygW
	ngWERb7BQRUzuX4a2psukMYmhfqCPyKjAXBjhxlYFIeOqhPaA7Sd2yPIWQuwmTU2L9foy2wOl0y
	wxjISho=
X-Received: by 2002:a17:902:fe04:b0:2bd:417:8b6 with SMTP id
 d9443c01a7336-2bd5283e188mr168539105ad.23.1779281995470; Wed, 20 May 2026
 05:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519141858.378997-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260519141858.378997-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 08:59:43 -0400
X-Gm-Features: AVHnY4IIyEJ9cSBnXo9rR4kDn51hA8GqFDhG6xHLSAn6vPOqrbg0ug3dDPqS2qs
Message-ID: <CAEjxPJ5k0XndWa-eZ+SL7EFEg5nHVtP=B0Jr1sCZzMB9mOkm1A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_restorecon() error handling
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Ensure that we handle and count errors during the tree walk consistent
> with the selinux_restorecon() flags.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  libselinux/src/selinux_restorecon.c | 60 +++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 11 deletions(-)

Merged.
