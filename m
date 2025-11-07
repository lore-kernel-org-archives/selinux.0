Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA927BF6C
	for <selinux@vger.kernel.org>; Fri,  7 Nov 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531488; cv=none; b=aljDN2iaCsO5JUYvNbyEG6G2532OdHYRWHEyEzur2mzZrnH7+0EdY/kReX64gqeUDVFgJp7f/EwS7qjLAOfTZSAZiBFhgvS5gHgySbQFcInKtDf8U0Z6HVtK7jCWdx5G+BICe+dTu/3pctC7+yMaebDP1wXzb5DfFKmkr2xmlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531488; c=relaxed/simple;
	bh=mWSWeTxsNPtt87sfhhqiGcOugBU5Hq49nrEWxTTlOoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoqsoM4+gG2wddlcifY4cNCPXpQLndY2p9OdJfP2bB59qM3WNLw3uh4uO1R/NDuETlr3FRVWmzSD6fTbR/30adnOHaxAT6rg46Y1Ep6Q3q45nR98PVAup8Ls0z+nwvHJqVO+qCmP7hDFl8sOyTE+EdBn9//xozp0B2C7ijQL8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfxMMBWm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfxMMBWm"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b994baabfcfso590813a12.3
        for <selinux@vger.kernel.org>; Fri, 07 Nov 2025 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531486; x=1763136286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWSWeTxsNPtt87sfhhqiGcOugBU5Hq49nrEWxTTlOoc=;
        b=QfxMMBWmM04oUyTSRK8qeh18CKJmoPlTo7hqExNvB/m1vXugacen5xL2O1oFtXP0AZ
         F/DQq4hr3GdBLUDaczi1lBpF6BTUlr/bNI2VCcP0hmTVfSAZGkY01WDr72lopA3kLL9Y
         paRya4N4oteGiJKwlW/a8GQPKoRCI3LHSEOznBKs0CXbihmnuFQXFIRmK+3yUtjB2SJ3
         LytmBEjY0ubgSOAQNYIp5dFo3NOw+xwZwQXl1eJyql/wCy+NUCnmKvashX3K61wJNAy0
         7GRccmOqVO+SDj+I4Qio7Jgz4ssqCFsoxX0pYQFTnohMrmdtyNCi9NrvS6iteeK62gVn
         xkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531486; x=1763136286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWSWeTxsNPtt87sfhhqiGcOugBU5Hq49nrEWxTTlOoc=;
        b=IzpacZgM92dgdLTI1F382MFnOy773foEDStgBs7Kj05O4mdYf0j1SEZy1yRa/Vbg54
         h21BuBGDegNkVOdwp5CRQQgg+0PFCxaxjKpWzuqLgA7cCYvJ7ntlKhojpuA8tAlpZQPa
         3FF0kz77G9rryOLCZbovIe9vH60LnrkUHNpVuVkjWjQ4aEsXdxV2BfwLivzzI2gmhnZj
         YO7EMmo/vkzIAJrYY2eymd2bjlR232tofQGfo7zBNUAtWl45Y3clmMa3sKMVufGMk8o7
         zZtvj/c76S5L0aOf/g+VaYF/nWw2nWwEmCsKVUbHINYcHgkljwCskY+QP6CbWI46GiL0
         VXVw==
X-Gm-Message-State: AOJu0YzjqAv6V0lfh8q/v/M6zl1ljZ5/Or48HqaNPypBgXc+Yk5sAAE1
	53QlDXj5q8fjgWYkV5GvAQXogLYJftMSAfJbar+o1TZgVjr5V7bQMcQaGtZFCdDl648ef6xZ2V5
	0MwuNSOEH7X2TqoiHFhnjuM+vgePEgu4=
X-Gm-Gg: ASbGncsSMoXfTYxluYdg1HQ9GW7WMCwQRiLypVBwd8oB5Ci+2tFuk5WtwsVzf/FuFHw
	AFspOOi5UGeVT3BpP/KGt2qCF5D8Nxt92T3jkWk9EpNAgPCrpdoL3/AD3DsI+tKkDYSJrkotwW1
	LwVTGIqOAb71sQFSGQ8Z6128EhJqI4Q0StHbKnx3vbYfKrNc2p+jZzdJiLd7F8oOOa8pSvLejy4
	A/dFsyg5sG+dONZp0tW7GcYObVK/WxC7StTVXmWjDSLWJNooWKmCWdBR4KPS6tt/0f/DhA=
X-Google-Smtp-Source: AGHT+IHg9a8XJ07ch6HSMoeb29qmmcl2+04EJZBy9yE4WBvz8lSMF1oel5zt0CrbOBwsVEH0WAulcj+Sj63I/jhuzbo=
X-Received: by 2002:a17:903:3b86:b0:293:623:3260 with SMTP id
 d9443c01a7336-297c0470aaemr46222695ad.57.1762531486292; Fri, 07 Nov 2025
 08:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104205236.60931-1-jwcart2@gmail.com> <20251104205236.60931-2-jwcart2@gmail.com>
 <CAEjxPJ5F7CQL26n_LzhfVeaHu4JX3_NmSzTLJObDP=yvTvZjAg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5F7CQL26n_LzhfVeaHu4JX3_NmSzTLJObDP=yvTvZjAg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Nov 2025 11:04:35 -0500
X-Gm-Features: AWmQ_bkbzb56zqm8VJzCMlL-kt4C-4i7XOFIcDmUUPNFXOuwEk44CKWoqJ_B0RI
Message-ID: <CAEjxPJ5qFr8iGs=sjoYfb92dFuxjffcsvArASr3f6syc-PcMeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy/tests: Modify tests to check handling of
 initial sids
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, russell@coker.com.au, 
	Chris PeBenito <pebenito@ieee.org>, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > For policy_allonce.conf and policy_allonce_xen.conf declare the
> > first three initial sids, but only assign a context to the first
> > and third. This will cause the second initial sid to be dropped
> > from the binary policy and cause the handling of a gap in the
> > initial sids to be tested.
> >
> > Update the expected and expected_opt policies to reflect the new
> > expected resulting policies.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, both patches now applied.
