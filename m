Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A8411693
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102715; cv=pass; b=RfVx27elueDcXob1ym6GXiTELzFeS1U2RDjKA+lrIhvr8XV/aQxsTp8X67KhTKRS0MgU37PFMVZlYzulmCRX2z78adRUWP1GLRDPEvdeOohoDNmoWlpTxeH8ulQS5flJSPY1bghu4iptrdLVb+lyZAtqizXV1DZjXSrM8GR6mEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102715; c=relaxed/simple;
	bh=AYWFUIzzupZuBfgGZQWGIYBUhZRMrWyn0rR153UEiDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/VJQybNM1bX7ZAiatkbWLp9dPoc2urReD8cJDDK/30A2wEiyxL6JpB64XafwBuaivnnmrl834dxK29oASymTaC44XFhZYtOVwgDeges604YQjxjQHIvVpyOoiS6vnMa3hSb8U673QtuVik693vshW9wlGq0GKhe4HJyIScIyEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aA/G6yDp; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aA/G6yDp"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c86484d35d1so387029a12.3
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102713; cv=none;
        d=google.com; s=arc-20240605;
        b=a5mGEPS7AAzFEndT3ipK6wd7+QsbuMhXF2fDEt2nOuAWz6IAYjgjgBFulqHR0aWPxw
         wfoeOztOl1kjES1dZRdXGT+95QTja0ULj1fQhKHh35sr6lFElVJ07hqdNV+qJg1hiWvT
         UJJ5sh1imDco+nyrz7WiLxLM4jaLJcYe3g/SVcWfOOBjGx5FhpC8w8kw+yx4h3C7wtqn
         RNNz393pd/zl+S9CE/xqylS56N76Qto5uGUhPMnoCnzwrPED1glkJzYzXi8pYACGk2w3
         eKfE669kR1vVo33HnybRdP/DiP1x/NaTvN/ZYgxG2ZwIbsTK3Bege/9gXg92YpJhiw7q
         AE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1+MpIeaKjh3DbMdo1XU3pKfpy3utgnOtBc/A2/7TcRg=;
        fh=szNbHvrZ9tgD7IbBK4eiQiwR6NVxN0is2sKK6qohdqk=;
        b=e3eRbhXRSeYpFiBaJsF8Jum0wMtlRTWqD74So5iscZIffy+k0hLLmI2e3JQniUM64f
         d7OtAGuowdE2MbHmXW18DkDOScpzRZqeeP9QQZWvsD+rpdQnDR5a1NPIVuAKrVNv2GyT
         aiONuu51s/3eDyh8FCMj9fZbzn4hivDAqH/9JFjoUSDWrPpUHxrwkI1at1H8fGSJsaTE
         bxsPbOdAwoaY2lNwtpGxytNzFfFbpzsc/BD8V4BP4q/GidHyrR67QOn6GUE6GBR5/jh5
         ba+Woxw8Vn/to4C4nEs6LiNzOFk9T8vEpRMecFtVTPwJ4YP6lSZ8BFbf/x9PgxETOMAb
         6xfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781102713; x=1781707513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+MpIeaKjh3DbMdo1XU3pKfpy3utgnOtBc/A2/7TcRg=;
        b=aA/G6yDpe+7VQ+j3gwbDqEe7rd2BA491NXX6b3nqhg9PDJxlPeBM/B0IVjcppC3+LS
         QfxZJq1v7Sa4x9YhbucTHPlrlt67+mkAYQidL+IC9HgS1R5+0YtyUaA6UQa1xRb4JXNI
         d9liaaGwWUTQ2rjU6uCvxSH3VjomZgiQrPKW+lGaTDMJbbMPQZRoxN25V9mm9AdkIgoc
         xjFGQ83/2SN5ZQdwu81maQ3k7dQ6SPMiwDWwsqK4rXdWVdoLoz1PQqrjR9FYAvNjIdKN
         mFa25FjmtsNMdLIiVkKRjTDIFeSx2VkFQzfEOxHWnGWafzt4aPTekvq8wGWgaJB3Yx7k
         2rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102713; x=1781707513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+MpIeaKjh3DbMdo1XU3pKfpy3utgnOtBc/A2/7TcRg=;
        b=HxkxmoOgIR1KZloql3B+DyVhBYQEN0icIlyCpcK/KrTIISlFPP2g1Fs9GU4IVOssUD
         7lnH0KWglK7TSqf4EsMYygNbFCtkC5w1GIFA3v8lHKEFeb83Kyy/bL86xFew8IlwFXDX
         Q2Jo3jgJMcc5UXdGYztldQaAjVGGSMgb1kMPKw02yOnSSleW4VUygbDNsbn/yta0h5tu
         flWiNbJ44H1WSOzNsQBJDaKFrhFJn7rU0pKY4b57zgS4mfUwjClumcr39t12POjWFB/S
         LMnizYIH4ro1Mxs2naYkat4jh+A/R85i+2mGNFjUJFTghMIpkf3dY7lptBA7LYzQofNb
         S+uA==
X-Gm-Message-State: AOJu0YzJ5ikMpqfmPi4KZSKt15/e5CV6Z5vuEByQcQRPMC2KCJe0Lufd
	tdVJowJV+rxBepSbfefb0fZeArMGIkFjQYBe2IrEVCB9Eia5YXk2jqL3qbXd/cKL1zmCAUfJvmI
	RuQSKRSjvfhgQogXXeDTWD2kM1qT0ZaBibu5E+De3
X-Gm-Gg: Acq92OGJrwAWc4+CrRTuTvaCjz5UKVewQJeJdeM+zA2urqh6Zr05jzGRmxK5rhp60yd
	SPnixBEq2n2k/FPNtVeiYzQJWHs0jDU4Xpt7z7VxudUDvgMpFpvJUjBQgPE4QWdJN6pboEUw03O
	E0Vapehy3nw/qFBvImrKUXOQ8+UeTca/43z9GZRyYt6qPUMIE5lQ8EasemSh4XWixNrOM7i2RlG
	n3rrAbpzie1XEzBeqbzELD2XhKNM6k0aio69I3ksFuca+4q78KQkD/gHqtOhba6g+c2Z9UzRhiT
	Dn49bckiRCAyWwsarg==
X-Received: by 2002:a05:6a00:4407:b0:837:e9cc:d470 with SMTP id
 d2e1a72fcca58-842b0e84bbamr27573952b3a.20.1781102712650; Wed, 10 Jun 2026
 07:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
 <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
 <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com>
 <CAHC9VhQbfSV6gt5QncQKmgjbyNCWb5TP1WsheER+JLaV3oqoMw@mail.gmail.com> <CAAhcyzmHqJwcWqSZ+Crv=+z1fHvT3n-XJomO=iqB07wRO33SfA@mail.gmail.com>
In-Reply-To: <CAAhcyzmHqJwcWqSZ+Crv=+z1fHvT3n-XJomO=iqB07wRO33SfA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jun 2026 10:45:00 -0400
X-Gm-Features: AVVi8Cf0TFIc2v3ZgOrhAJmqNzv34bkD6FPEmHsgahcN5pN3iLMa22ZoiI3E0J8
Message-ID: <CAHC9VhQHe2AvKOSqFC9FzAR45CjExPVNM7+F8j69mzALB10kSA@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: muneendra kumar <muneendra737@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:23=E2=80=AFAM muneendra kumar <muneendra737@gmail=
.com> wrote:
>
> Hi Paul,
> >>There have been many changes between Linux v6.6 and v6.18, not to
> >>mention any patches Intel may have included in their LTS trees.
> >>Unfortunately it doesn't appear that Intel releases an LTS tree for
> >>each upstream Linux kernel.
>
> I agree that the broad version gap makes it difficult to pinpoint.
> Following your suggestion, we have tested additional releases and
> observed the following:
>
> 1. v6.6.78: No performance impact.
> 2. v6.12.76: Performance impact observed.
> 3. v6.18.33: Performance impact observed.
>
> Since the regression is present in v6.12, we continue to suspect that
> the latency amplification is
> an unintended side effect of commit 417c5643cd67 ("lsm: replace
> indirect LSM hook calls with static calls"), as noted in my initial
> analysis.
> Please let me know if my initial analysis seems incorrect or if there
> are other areas I should investigate.

My original comments still stand, you need to narrow the gap between
v6.6 and v6.12.  If you are comfortable building a Linux kernel you
can follow the steps at the link below to bisect the regression down
to the offending commit:

https://docs.kernel.org/admin-guide/bug-bisect.html

... if you are unable or uncomfortable building a Linux kernel for
testing you may want to follow up with whoever provides your kernel
package to see if they can offer support.  To be honest, the static
call conversion should have improved performance and as far as I have
seen thus far that appears to be the case.  While it is always
possible that commit is the root cause in your case, I remain
skeptical.

Good luck.

--=20
paul-moore.com
