Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F647010A
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623098; cv=pass; b=Zeto9oVoKI14WSMCJkwPEDn5tN11uPpo28sWsIzEt207ai7qfRddZuytZI/7KeRYjeNWl8CGgwrtBIF9Rt6noqTJzqN0KPVi38HsCYUthZbMrtfV1S4ZFEeoDiCZPCS3C2decjo/WQJAMWmF72YDFDRgb5s/oU3hZR4oJB27AyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623098; c=relaxed/simple;
	bh=06j8JD8OzbcMBraWovSVc+9Hd1vUxzy6TrriC8HsawY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md2KcBdIWrSaBTu/67FUu6Ivr5iwH3MFc827+YkbPSDhO5PjZXH2rGRdSpcvs/hnZigXFDXKETOa4sgoGHU3rWtvb/ak/NW+PgyCBsvcEh5dsBNXRpx06R04A7z9z6OE518qaAQpiQApRiNBS0veV9fyHeQOp483o00s/YqOGr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbidz2OA; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbidz2OA"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ac83a09781so622563eaf.1
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 05:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786623096; cv=none;
        d=google.com; s=arc-20260327;
        b=HZtVGxwf1Mk3LTHENcyrHQdIZAQg3zoMPu3IThD5ULANYrxqv9CdZ/OOATAOXhrjDE
         tvy3zHUWzc38c65i0C0q4Ery7UdvekX0HZ7BhX4ljCJ0Qjj5N3NZ+nm5FO4jN5AjnNgV
         GHifB8AbmqXP4z1TWaYk7R1lNosvuM2FqViyPSGt/BuMSl3u2kabXl59wnauE0q+RNrz
         h+2m5VyqS2L6Dxp/EReqFmF5pEykjwrnNwVlDM3biSQpRsnvLrYSHWjQX7twQWg6EQq8
         l1aPdtRlOxDbPytKTlO9TSdH+cPqaeqdVtMocL1SpyyyThr7nb9gITUs9D+gwrCe0F3M
         WTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=06j8JD8OzbcMBraWovSVc+9Hd1vUxzy6TrriC8HsawY=;
        fh=ND607pUUmCXftgnv8a+QmlKnolWxUkc2n609EKlxkKk=;
        b=J9E3uSjWBhel4ZxBr3b5lpxPAXjvjApLocdirWivA8AG0oFXwEIH1oC9f/6ka8IPG4
         4vtGxAAe7+HItJmFd4hP0folIIvFDTF1FNuYLcXVXLjxpQpoviVKvDfMULfaRWpXxZTF
         1WbWArIGoFXWPEc277E+DDPd5tFjmGtImG23zNjx38T861n/jMjIXPv1lwnHiI9YF4Ry
         sm9jdsNoKw40RKbUgBTO6pGUDpR/+te2J1OiFcd7FazOa1+eyqg4tA/utkN8HaTjmJMU
         um+vlC+nfKw3iBR/DHUUCnTxcuF0CrPUZ1pCYxTru6qZBNi+G68ctjrjwPmolFORm09q
         UNRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786623096; x=1787227896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=06j8JD8OzbcMBraWovSVc+9Hd1vUxzy6TrriC8HsawY=;
        b=Hbidz2OABJ8kFcMV3hpRd9/VCW6CZ0TjOZ18NqCttG+ms7bkT7RDJeswHPaNY0A4su
         BoQSYLkDXJ2j0dTisY1UgbNH4XehKKuHi/CPQ7d79PAbDQLa8cjClrhp9L1sXeSp/Cpu
         BlJwuAK7wpC9ZkYDFph2nwhlDGr+CZcuCbN0q5KlwYBbLb5xs+OZUIWhiPAGtyHqIJcR
         5ij5KN/eLDLqjDAmGWrQ7nl0smUvdKeKRsZ7dbPtGdy9GtocT4UrqDKT4yZU3Pft0IQ6
         nOVZSJks/l+v3i+qenZpKwewwEhJ1NIgepbUtyeol3FqLV1rCGajnysj0G5dGdEw/fYc
         5lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623096; x=1787227896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06j8JD8OzbcMBraWovSVc+9Hd1vUxzy6TrriC8HsawY=;
        b=K0B6K8mEpKigOr8s9DdbliFznqTyguYRFpkve/Ei+0e9eH++sQS4AQ8wmeYD0WczRM
         y60jxoU5MtAKlQx4yCmJZQEkb7axLoK1k+O/ZJ8bqmyMKKSD0L6lrl0eEz+W8AYcPvE8
         wvQZ+97mvEhddLPrsnYH6WA84OM4n9hychVJ19XKcNbFNFD6kB8+Idj3vqAUD9KrWbJX
         P1LPAHvfcNHHP8PFxGMFFaimeFsGGxJ7Jbs/0kLmkw5+zwtRMOb+xLpo20BJCVBqas/T
         ApBb7Hg1UbN59KHMK1QuzcZbHPClq8ATc5p7s/BXe0OtjJjzKgHppbxPQ+R1RuryXP5p
         PYDw==
X-Gm-Message-State: AOJu0Yyhmsp9dN05hwnDkoEBJZDhBfHhqDw2qEtSYawkBJuNKNc1zkDh
	JGB6aTTlxFWCXQSiATGZzu6/4K+aB8zWmbZvvytHNBYDJsHQQu6G6V0V5FW4GTh+pJXLnMjGHbk
	DDw5gUYW8k/l/WL+z7zNnskQ17+oh/wc=
X-Gm-Gg: AR+sD12ItW+I1A4GCCDJ4nU0PAPel/f9tX4ep0JAbjQwCaTO0zgjxhzKoeRV+WcY4IR
	UfcbHG2+lUE8vA2pMsEbJxeq6yRkJjfy2VrBNiuD3YAgD9NjrCdYWGRH3pu+NuPz7P6CCpg293u
	HRRq5PLpS9TTUMeeQDw3VPnKANFeelMv7KumHnWFPafl7gYw6Aqc6sH4n9wJPCJvFklhVnyAk6s
	iCoXbumn65Nm7OC1QAdM0EJ5vSWlPNX9FZC6kWJQSChiO8HY5vBO07rY5L1dNxhrm+aOcjLDYFs
	t9hrWALsGNMOkahQ/ihlrv0o9RB+XioeoXEZ8yFEwbRz
X-Received: by 2002:a05:6820:2d03:b0:6a9:fa7f:faaf with SMTP id
 006d021491bc7-6b0c5a8f072mr3582105eaf.5.1786623096003; Thu, 13 Aug 2026
 05:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812184539.134978-1-stephen.smalley.work@gmail.com> <87jypucp7u.fsf@redhat.com>
In-Reply-To: <87jypucp7u.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 13 Aug 2026 08:11:25 -0400
X-Gm-Features: AUfX_mwn96wLef834t48hVaBp9Qud_onBwJ3Ba82HIc2znVe_wEl2ljYsj9PsOA
Message-ID: <CAEjxPJ4byZ2SWscvaJTqkfC055PPKr6p1yPtYYa=GAKSRfFKSg@mail.gmail.com>
Subject: Re: [PATCH] README.md: clarify minimum supported kernel and policy versions
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 6:03=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > Clarify the minimum supported kernel and policy versions.
> >
> > The Linux v3.0 kernel requirement is only for libselinux and anything
> > that uses libselinux to access selinuxfs. The policy build toolchain
> > does not link with libselinux or have any other runtime dependencies
> > on a particular Linux kernel version or even on Linux at all.
> >
> > Note the libsepol version in which kernel policy version 24 was first
> > introduced, and also note the first userspace release tag that
> > included the relevant libsepol versions. At that time, the release
> > tags were date-based rather than version-based and the versions were
> > updated more frequently than just once per release, so userspace
> > release 20090403 was the first to include both libsepol version
> > updates.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks, merged.
