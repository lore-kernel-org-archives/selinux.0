Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9D3AA510
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269744; cv=pass; b=GRbHBeqNuKEe6GcySK3Y6ziMh/ggyweQhXkWuHYKL337ibkBSelWrWYI6gYIL1xElM5iSgMa6qO3tNtSzXVtiXNltiozR1ti7Gg98zB5tZnp4R+DPTalL+ltc0pgbcp7/yZcgbxHbeOofTH1e7sBMB4CAVd4qlvzmuAvjPJAttQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269744; c=relaxed/simple;
	bh=IayndIsN7A+Fe8jJG4sbK0dysUuwebg74uiy2zWcppw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMMollcbiPQmM6+vn3qaxmwLo83Comy55uDXYqbwe6pToI7h2ej5hn6emLNwz8aG1vQjn/Ybm+wfMq7ds2DoGwe4YYbVCgTzQ9rH1MKWJFnXkgBkdYs9a7648YeUXFaW4gyjFKAPlPsNriesxfjDkY+wUHYx9kjhvWxK+GooNl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAt/SSQc; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAt/SSQc"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aaea785032so185170eaf.2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 13:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785269740; cv=none;
        d=google.com; s=arc-20260327;
        b=U10JeixyLWY2+rZ2nUlhpbvCgg0p4G3MOs2Np8Km4M11m36BrfbCU7xT0xgmnIDboK
         6olCqVAreiRg/arfHf7mqB+5zyUy5q9bG8psYj/eVm2P53UE/1gx3PhMn5hfAcIurxEu
         6Ng8FwQxXuF9cL4MhUmrKVeugIA+q6WxuxlOf+4zYmVanyZl31nf+KIsREnFyZJQoPf4
         /WUAcEI6eWbtTUVQlVxpPJNeWfOKh7lXxlIAPuZfc9h6pLwwCbxdPJL9LggTf2pJv6GA
         xO7Ma/7cHyASfhZ9v+5fVkQtAMlmODSmvUmzVxluWGZL4z8VLKBcGl0z60o0TrDUrjrP
         S2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IayndIsN7A+Fe8jJG4sbK0dysUuwebg74uiy2zWcppw=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=a6gMn9/At95axcZ5B9m7C/CcRcXIEq+6WyPcZJitFyL/APDkpIQWFwgeVGellXt2a/
         ZicCFaP2uS6sRlcPgdcDrM5hNkH38KAgFeKIatFVUM1sEg9RUGjR4nc7gXBD0vpV27IT
         oM06u303EEHTf24LHisRGc2f0Pl2jVQ9m4HgqwF/8TqWtF00Ve9MTSHAYkttQNtyAzgI
         ErujPOQyqoJ5NARINYC3m3pwb8hrQ7V+9AXWEknQXNsNsf9snE2LCEHJ9x/ePBabrSmQ
         mp3US6SMl7HhafwRydd9B2K5dry8vt82kKPwaLTLgJ/PU2kw9WypuCUsyprxW7l5qsSA
         MxJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785269740; x=1785874540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IayndIsN7A+Fe8jJG4sbK0dysUuwebg74uiy2zWcppw=;
        b=QAt/SSQc81XCCSf9/3zREFC2fJQCdmiV3LwBQzll5rRb/UaKHVORxaoLXvhC3+ehp6
         P/7rAxXZ4GIBbKZ2hYwIBiRcKXxbD+KN23/O/f8R8HLbcL2hl1/6/BtNA6N+zW62AoU8
         2Beqae3D3azKPlveDaUz8YsByyEkIYLaLsIqtCXV9y/Hd2kqLYnJDpe+D/533zkar582
         YTC8iPGIgLvVTsvkNMRyOHyI4nablCplsm/1UK++5FKhwwqs70ZWBPWp6clH0IAkSIHC
         SsUto7aZRU2xQWOx1V0WCKuc6CZNgsW50MyoCo5luqb7fxGCPOmSLQeJrxGh7rL9Awua
         Rc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785269740; x=1785874540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IayndIsN7A+Fe8jJG4sbK0dysUuwebg74uiy2zWcppw=;
        b=O003sAMTIMH57hkIXveWb361uNvrmu8F8kmHLy7nn0UAQaKJK/EYiQOI7Frd/f7l+q
         8uNywB3Hyn7IgzuW92s9HMhE6Ava9KWilhw9Awl8YpHCT7dBx4V7W2Kk13OKgbu2Iq9+
         I2WEskw6Nd1DUDRPywIRlJkC3rspxqid0Q4K94daLb8F2KwHxcGP0fOzDBUysEP2eKmj
         kOrN2Z7xtk+S9iYmRxax/L3grRfEO85FjePp1QtyL7ftQALzuHSMZq2V9JFAab6HmVww
         w12stbAK8ht+0gPodCGchiXlLmtBlwyfwHk9JggJW0DqMowYFYkBgBSRbUb3ZdInA9+5
         CyzQ==
X-Gm-Message-State: AOJu0YwIaJUoNmTAp4yhA6lxF4H4RaK3Az27lG7kHrtiDKhQR+bRYs54
	TjL1OKn27agccWcgjFfk52TAMD6HbukiaRL9cK7m72BjKtdmakxgmkddS1gkEA9+gAwGMaShMXZ
	SGe9PHUr9FN9rSLPeVW/kSfiBNAa8tvx73g==
X-Gm-Gg: AR+sD121JX1c0Aqyg90Th0eFqbyegYNr9SV+ugbuctXkPuOoq6z/my5eHEo34OoXoYx
	i6m0v0OMyru1+41ktMiZmBE3QmjEIgSuKyOJFfheOMtO1dJA69bel/TrVf0hQsK5VaSDFP0yAQu
	67ynjQxzig1OVM+7e6TiQBY1VkehAuVUuVte5gA/eCLYYWfvXb1UAbb6VCpQbpRJD3zHEzCnuAQ
	wunWy052jNfraaQeR0RdUJLbDfq1EYtQfnZgFzJEqj7HtjeMjK3/ls2C65+7A==
X-Received: by 2002:a05:6820:3089:b0:6a3:1e40:6332 with SMTP id
 006d021491bc7-6ac96c89a9dmr1777383eaf.59.1785269740126; Tue, 28 Jul 2026
 13:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728065917.1343947-1-jsegitz@suse.de> <20260728065917.1343947-2-jsegitz@suse.de>
 <CAEjxPJ529Be7_1Pw1LRFsUtABDa3yVo_-wD=mT0QxiuA0sKfsA@mail.gmail.com>
In-Reply-To: <CAEjxPJ529Be7_1Pw1LRFsUtABDa3yVo_-wD=mT0QxiuA0sKfsA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 16:15:29 -0400
X-Gm-Features: AUfX_mxWvOTlyI8Ut0_QUXpbtPiom1ISpGu4uAE8erczoK9t4nHm0FxlgeRbOpw
Message-ID: <CAEjxPJ77Vt0vGDy5PZXtFjYwjQNsx8KTtk5d10L=sWS4vWY8kg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] man: Document directory cycle handling of selinux_restorecon
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 28, 2026 at 3:09=E2=80=AFAM Johannes Segitz <jsegitz@suse.de>=
 wrote:
> >
> > Skipping directory cycles instead of aborting the file tree walk is a
> > user visible behavior change: restorecon -R over a tree containing e.g.
> > a bind mount of an ancestor directory now logs a warning, skips the
> > cycle and completes successfully, instead of failing with ELOOP.
> >
> > Document the new behavior for the flag SELINUX_RESTORECON_RECURSE,
> > including that a cycle is not an error and therefore is neither
> > affected by SELINUX_RESTORECON_ABORT_ON_ERROR nor counted by
> > SELINUX_RESTORECON_COUNT_ERRORS, and note the previous behavior in the
> > selinux_restorecon(3), restorecon(8) and setfiles(8) man pages.
> >
> > Signed-off-by: Johannes Segitz <jsegitz@suse.de>
>
> Thank you for doing this!
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series is merged.
