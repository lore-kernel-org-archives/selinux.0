Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9E274FC1
	for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258270; cv=none; b=jLWOv/0S4oHf+SOjjTZAzyWjiiOi0vMr1RKsFG416NqWR6Cc7a7djvpWhTSMKEUb1EXoxgJu5fqVNAfOBHXuOJvsQAHuDy5QEzUmOKHp1RiCPdAIjQCBkZeZshhnnRBkEQkdxNaU6fqXwJNBgipHinlseyJaDVeZKhnbWagG4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258270; c=relaxed/simple;
	bh=tQUHVxMwXzLpv0w082mzRfb3N1f6TYLa9SBugRmql/k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=uZee/6e0P40VvOQPDXyIKc4WlRtiw8nP8CCoRuf3co8/WZlBxtPhOoSFkSoEEH8NzlekEQi3R9cv7cN2m7HRWop5/XYnxaOWSzb7gFE6coB+780LQ9f9c7NhbC2qbqCTuEacu61nfWas3ZMO5ttNSHnGqhtkizmPi/EpfAx86j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M6Pzk/1a; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M6Pzk/1a"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89e689ec7so8661381cf.2
        for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761258267; x=1761863067; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtxaoQ9Z3EpBGRZ2g5cKDxZnBVsB91/aTgSB/xLsQVQ=;
        b=M6Pzk/1a3HBQYYG4ABm8oGfuNzMcRcBziaJymp3XtGeQ/3siFdxDr30GG4ac5BNEPa
         bKNatwLYlQhNkJ6OAMfka8qlHPlPds+SKiySkAoWNQVL/uIR71cl0bi+e9pdPmTcrp8q
         PnkcZDYUV3RhZNRBnp6g4AfJIQxE6KPAMVNXS72VC15Tj45ybAMQaIZJZEipHK7hsLH2
         YmGZrTFPputoL+6TUqrFvhHntnRmWOjwmtA5BiJBIVuvA79BWEOlmX/z2jQ5gFzi/FRL
         DtJ8UuXk7fq+IEggpgJFPM5E29JZT41Wy1j/xjtMrNYZLFdNDaucYG2YQ+LUmLXT097u
         ySIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258267; x=1761863067;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtxaoQ9Z3EpBGRZ2g5cKDxZnBVsB91/aTgSB/xLsQVQ=;
        b=QIL3Ws2d1iDmgYguMjccycnGeu77X8KQNF8Y4AIBeas76rT8UPBJ8GoNwrqIpy9kzP
         7tsYe1T+kNJyfWyinRApoOQr7Y5z+YamggHyVdffdwG/7gxXOot/nJvB9Gas1eFZwU67
         F+KqYk/DLE+5Gs55SR1BsM0Qrof9QMSiai5Izc24Ei0zoq4dSr8smlSIRnoqrFFVCFqT
         c9lAi+1oCImqw3QjMRUgvxsWsoGvtnmK65kstm/jEvWFGbCNl9vgLZFSovY+Qytsq6nI
         ntRgzPeA6VSQgdyBBzG+jPtTEwpixWc1foK3suvdGA5o8LDKf8sNyYk7P/dVpgsYzqmY
         26og==
X-Forwarded-Encrypted: i=1; AJvYcCXE/twz0c7+CxcmldTPX37Z7H5GdB65BCdojeNP0v5IKAlifNOGFSlf4+DbUznTFt/2tiT9lJD9@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGQfkfn4mBTgFvONdlgNeB+EpGWMUdKjuFtDomNKUnTq1RXaf
	3sx7FQyuMYaoj6D+0I+7PCZUqNkAeDGUYE6mlyLbAhTbF1davvZl/qrIear1Lr14Aw==
X-Gm-Gg: ASbGncv5k1iJ24yOG+aNn380gnoqpYxirEDelM94q3tElcwEO3mQfRIDDQ8vQHYyMCF
	P3U0VlK5vpEe3XVq2v41LM85Cx3/EWEz9xnyRPAGyKZjpdDXQy+6Xt5Q+jvMlbKDcpatnpa6dO+
	JSMABNkmOdm+x+uR1sToTUiS5ZMJjJcApGHqcG5uqPJmAQ2GJrKOvEPByGJqrbrN1GrfvIRjJEs
	fLiaICD1TPqsIMMyiHFP05g1j2TobBL5Z3ymkUIU/GsRQs/XGBi4DtYGDshCq6lK0mmgT4cDDac
	FcCThup9F+uDbm7L3ZwEO/6vwwYief8JRc+gRET1LzrBfh+wWMSa2Ums7wePZpJnO9Lzch3Ryzl
	jhBLZPSs8JrGrgojHomHbrqNCHEUgMQzmMtBhEhM+z2WLdTt+YFHC4W6AW8lgcloTiefUfvgATe
	Id9W0voOqqy++4WIGP2JmbzrWLBYjJjmp8U2aEby9n+vbJxg==
X-Google-Smtp-Source: AGHT+IF8p9h39szTOQkqhtXLji1wf/d6knDKyufDRGAAT1jl+xN4lNrSho8hIqCX+Yo8MxHz2my0fQ==
X-Received: by 2002:ac8:598b:0:b0:4e8:96ed:2e65 with SMTP id d75a77b69052e-4e89d28eecamr308215931cf.22.1761258267424;
        Thu, 23 Oct 2025 15:24:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0e48fc92sm251416485a.16.2025.10.23.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:24:26 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:24:25 -0400
Message-ID: <20c1a5de781c4013cec218b4d74aee9a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251023_1801/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v4 2/3] selinux: Move avtab_hash() to a shared location for  future reuse
References: <a878f27f8148bb4cc662755f6e69400632183477.1761217900.git.zhanghongru@xiaomi.com>
In-Reply-To: <a878f27f8148bb4cc662755f6e69400632183477.1761217900.git.zhanghongru@xiaomi.com>

On Oct 23, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> This is a preparation patch, no functional change.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> ---
>  security/selinux/include/hash.h | 46 +++++++++++++++++++++++++++++++++
>  security/selinux/ss/avtab.c     | 41 +----------------------------
>  2 files changed, 47 insertions(+), 40 deletions(-)
>  create mode 100644 security/selinux/include/hash.h

Merged into selinux/dev, thanks.

--
paul-moore.com
