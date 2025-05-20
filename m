Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792427AC30
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742821; cv=none; b=PscCpMmc59gDZ2zwMAgTi3GntbfgZ5VbfCoOMp9JH8hz4pSoWfooQOb7HMpNQ4DPux1QnMtfzpyfhEjIw3pi7UZn1XUaGHU8+7mUIphcEPV7OEc+8hPuK7pF++LLwJdbHzRbPtowvLH7g6kYCVLFHAUraoYFUuNF1QZtg4Mn96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742821; c=relaxed/simple;
	bh=AT2ZFiER8BJmSiEZfougwe+T2JjcyE+5l4oXCYwqW18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEXgPEAMCNGiba/22lEHesRE3rKe7aSenXkhiUEwp7PmtbY+KqXAOrhLccu9bHNaifbEIflA+7xg/0aU5Zuu9Jtj96NnBdcGtFY7W5vWtNG0VFnIu49xOCKadIGmZ7W9Vo4zyks+NOhyJK4RtttdtlVT5nxFWjxd50Wtzkmm6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCRTahew; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCRTahew"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30f0d85a092so1765888a91.0
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742819; x=1748347619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH4WwGgaQpG6ywJLXNI+WNm9J/xA/6907bRfPidVKgU=;
        b=VCRTahewMWDYICx3SupC+ROKmLjJRpyZuBKIZoZueYKJkE6Bmw5XGf+ulHyBJ748m4
         zdC7pgM9hbm6cFfZaz2VdulM86BfheMiY5jubQl5Mw6tYYSTtj+nkr3aAIcNc+2LeCdq
         UdxStfOzCm1ihgVNF3mNY1fKNSJr73M5hwg6WYDjT7bY/QnO9nS3hbJX6jkHG1JekDUG
         zaw0sK74Xlh11nJ89dZv0VarGwUsdw0bXe5tYbxuzDWz3wWELSFdABQFFisKvX+KwBVp
         8ZLXFz+ssBoQ8JwY+BNy0th8pPVPdkAluNlBwndVej19Ypxvl8SVuKYNG3bfbwjA4npC
         agxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742819; x=1748347619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zH4WwGgaQpG6ywJLXNI+WNm9J/xA/6907bRfPidVKgU=;
        b=Zb8gf1CE9FIBtdT+7WTIpa9l7/MnvIJeV7T4b4rHgMBnu4UZQNShSie7M6dNetnEBd
         Y8yk22SRUpSk9xWi77vv3XlWLW2q897f6m8+RMpaYT2GbhDUBFikLh6sp8Da9QSUusNS
         SXAuIosJD3doRoPJtDZHdMwhbdqDCtKFhEpqfkt5g//ttK822HJgh++SOd2WgOib5YUH
         Rf828NAs05CU2oQ08BynU8KdZvvopzPITxiPzp9J5FxAZZyoHV7aUrP8A301BFioiwRX
         31a4TCPK1dHY6nT/9WnQpHlBtXZb0OsT+PC0/8n+AtqITuFZ0DZbdYqRIsc2+jkdbyp0
         PfWw==
X-Gm-Message-State: AOJu0YzE37NF7p3e11g40LWw18/u9aieiwJPfJQqmssFGo0k8R8icrP5
	Kg3AXxDwtkV3+MJ8r2uHPHTYSfhmJBV+zbjjjnv2BbTrIgg/z0yWhnpaYLjpR2N9LBBlf30wfVW
	Ai5TYFuFvj+0imvBwBxWGBQR1eYAZ62jg5g==
X-Gm-Gg: ASbGncsr7veXRB6JJa6qd0FLGtb74gTYL0+2akg6UH0w7hqEJSjsfTm5K+xlsUGkvf0
	PD1EQPejvnhsrznXGUjYQ7mLWVMheXH9cRJz0QVxzP4gapwY6ip25nZ0QC4o9lVLBF6AjBDYt3R
	PvlZxO+NEV2rX4h6Zn2cHzaf4aDC0a8A6t
X-Google-Smtp-Source: AGHT+IFuU/Ph59etuhEkwbjgTMcdLaMmLR+IwYLmZKrmQwkQhUmhGTM6yE1OxJHgobB28FJqoMwXqj71v5GS1tZlYdA=
X-Received: by 2002:a17:90b:56cc:b0:2fe:8282:cb9d with SMTP id
 98e67ed59e1d1-30e7d5a8ab9mr25630262a91.28.1747742818896; Tue, 20 May 2025
 05:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ5Tt_xPiFQ5ftfMjRwCLZ9T-MiAaPfE8hsd3YyD5OTLZA@mail.gmail.com> <CAEjxPJ4K2=4AXU7dQJepgaNiOp5sm8nNxhYS3gvsAgrd3u1W_Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4K2=4AXU7dQJepgaNiOp5sm8nNxhYS3gvsAgrd3u1W_Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 20 May 2025 08:06:47 -0400
X-Gm-Features: AX0GCFtcBKSgNlIuxvCEwL_iDCkQi0cks04F4rIa9VXuZ-fJWXVWRxXIB32lTKo
Message-ID: <CAEjxPJ5ywrZhdKRO5U2orcud30Sk8Qxp7Uh-QAcz=+MSd4mFwA@mail.gmail.com>
Subject: Re: [PATCH v2 00/49] SELinux namespace support
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 15, 2025 at 9:35=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, May 15, 2025 at 9:10=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > This series introduces support for a SELinux namespace, i.e.
> > > the ability to namespace the SELinux policy, AVC, and
> > > enforcing mode. This support can be leveraged by Linux
> > > container runtimes to establish a private SELinux namespace
> > > for each container, enabling the container to load and
> > > enforce its own policy while still remaining bound by the
> > > host OS policy (if any). More information about SELinux
> > > namespaces can be found at the following URL:
> > >         https://github.com/stephensmalley/selinuxns
> >
> > NB Some of the later patches could potentially be moved up and
> > squashed into earlier ones before merge if desired.
> > I've identified a few candidates below. I've left some separate for
> > ease of review or because they are
> > somewhat sticky to untangle from intermediate commits and because I
> > don't have a sense as to which
> > parts might be deemed mergeable at this time. That said, given the
> > performance data which I've shared
> > privately (happy to post on list), I don't see any performance-related
> > concerns with any of the patches
> > especially when CONFIG_SECURITY_SELINUX_NS=3Dn which would be the defau=
lt.
>
> Here is the performance data, which I could put into one of the patch
> descriptions if desired (not sure which one though since it was based
> on all of the patches being applied):

Just posted a v3 which moves a number of the subsequent patches
earlier in the series and when appropriate, squashes them as fixups.
Also included the perf data in the cover letter and added netdev to
the cc for the net_namespace change.
