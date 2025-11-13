Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103631771E
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062816; cv=none; b=tis1r6r/9orqQx5Kq4EGafkRVSzcFiitwPJ/hesFemWE7uQliSbM2Wvaunvpg23XXq24K/AmzZ7R71y83m66UioaZVjIEcVoO69ZKYwXlWOjypCILo+vmpY3YYwLl8YeS0D62eIlypOOddRbq516p49N1u9Wm4HQxFEjS92PZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062816; c=relaxed/simple;
	bh=dib6qmCrr4ta+5RYWSKHJmFxWxebQdLDdc6m6NzsTe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzSpsQ8iJUMbqO/INFOnO9aEgH0mQ6k/DJAXYOK+CzSjXPIdsp4WVJz9TC7JbXFla8VW4krLr4KhLkwoivr0uQRWsqmNs/tgksV1C4r/jJI/Z/dAhalQ8CGCQaNfOdULm9qI4aZwarJBoJkkRAD0DQwQ9Hol60WVDwM3R3vcd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUL+EFoI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUL+EFoI"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5958232f806so845661e87.0
        for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763062807; x=1763667607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NVfqFQftVfghyMinM8jxjgYuEu0ml4Lbryr1zIVMug=;
        b=nUL+EFoI7vlgX2un9oVpWhZ5/mmfvyOLpnUNTyUkuaII8LEVHishR7fpjQF1MLPeGr
         OA7Ye0d1lI7IRFCGoVCgf6S05hlq+nkY+PtbeTY46POdzhukeJCkjqJWAZxVaZpg6p8B
         v61cGO/y9xoeUlpkEJm2J/oncQrqmSRQahAvxX88eBpVhXKp22M0J2XRk7P3kwJQFXRc
         vc+WyMFVQNPi4BGh7gcaqz4T6LCfw0q45RcoWMY698rw7n3nMa9AR77eq5v3+NmefvKI
         YXpcAJ5HcogBMggCYyk74+dxETLELB96R13lGqPRfEwgbbKPCa6plBBOjRrYHN3ebIqI
         kqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763062807; x=1763667607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NVfqFQftVfghyMinM8jxjgYuEu0ml4Lbryr1zIVMug=;
        b=V/hSRG7Mp8wEaYvNnah+LWyLwIrTaKdqdpP4Y0yv/i1qT5WjEe5SH/GCNTr6pr/X3z
         o3Dkk35mfAR0kcL9uEsach4A8sni4ydR8LDnE8WrIAkC8tYBBF0ytbigevMgmKaIaH9c
         0B8AxdRwltBdEnbhPigfgD6tNwT92p7+OY5GFVUbC+r4tu6A5wluICfkxVfkWGw690U2
         AsaYWx+ugi3MKRiPIAKzss8eHGHP+NP4WLQsYNOy3sGEkG/BlJmJ31DpPWF3WVxPDuD9
         VNFn3t78B9RV9VUnci6WwgxcE2AOYS5WrmZkOnFgwhTX1JFXbYFlsnuRTTjRS7JPdV/H
         mCbg==
X-Gm-Message-State: AOJu0YyxkS4PQzkvaXqFWx0Or2Pgu4Vh/LsDRCmxmou45mRjcmZJaTX2
	8lYILv1kEzUv+2idR77KBXJvJKNq0yzxGfWskEsexjLl2bKim//ifUK7e5VqLnEISQf6z+8A1rL
	zj5gSc21z+TiTZZmGZw9uBIVWYQvgC+u6bA==
X-Gm-Gg: ASbGncuBoXI3Da56pFhNxH9hMlevBXdF+zvEpsF1xyIm9ctSBHh6aHg3jiX6sPoElfi
	3vo+E2ouU148Em057X7wPDVBvxm5PMdHnTMoMzRZhnjE9x8h0XDJ7BX/P4IcXTmvmDg84HAlBbY
	pYZ5GLuOC8KrR6UEaRNEOoY/QuTBlX0KxFOhGBcJc871818NRfWyzm+E2StHwnU+2It6ZEppsLF
	TUme34gLG6a2ffnDwvJGziBnom5uNOiINyPA4R7X1uUCoBHGSF9iDPtLn6QKw==
X-Google-Smtp-Source: AGHT+IGnnnWSCJ95U5zoFI+YIiWHm3+u3y5nzqakSceGsjqVxSDfdLFoLqPTPRuqCsr3zS90o75h1wsvTGLT8BRUDaU=
X-Received: by 2002:a05:6512:39d1:b0:594:2870:9774 with SMTP id
 2adb3069b0e04-59584213a4dmr190976e87.38.1763062807172; Thu, 13 Nov 2025
 11:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180935.202229-1-vmojzis@redhat.com> <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
 <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
 <0d41ceb7-5173-4360-a746-c258e86089e8@linux.microsoft.com>
 <CAFftDdoTR5ae1qORSjPuOj5ea1O15qtgrRiadhTp2HMh926swg@mail.gmail.com>
 <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
 <394ce63e-2ea0-4b0f-9196-bb47c6721f85@linux.microsoft.com>
 <CAFftDdrJ=Grx6_eHZXs5L0bN88WS7bG7XRBMHtgtYLBdYCXSuQ@mail.gmail.com> <cef4f1aa-c289-4f50-9738-4922f1330e95@linux.microsoft.com>
In-Reply-To: <cef4f1aa-c289-4f50-9738-4922f1330e95@linux.microsoft.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 13 Nov 2025 13:39:55 -0600
X-Gm-Features: AWmQ_bnef0nhxR2hLtpe3z4nL5qNPlDoiqJJU0HcQAdgltJIVulHnf7NlHFEc-c
Message-ID: <CAFftDdqtHss92hCFPrcWyb7kT=-gvH2_b9uFb0hv1XSwZ7To6A@mail.gmail.com>
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

<snip>

> >>
> >> My two cents FWIW is that being able to see whether you actually
> >> relabeled via exit status is way more useful than having to parse output
> >> to get at that info.  There's no need for the complexity of the wrapper,
> >> no opportunities for parser bugs, and you can just directly succeed/fail
> >> a systemd unit or bash script based on the return code.
> >
> > How would someone distinguish between error and one file labeled? It's
> > also clipped to a very small
> > number, so will it really be useful on larger file systems?
>
> No, I agree with your concern about returning the number of files
> relabeled.  My suggestion was:
>
>  > One thing that might make the patch more usable and address these
>  > comments would be to instead pass the expected number of relabels as an
>  > argument to restorecon and then return success if the relabel count ==
>  > the expected count.  That avoids all the problems around exit code
>  > handling while still verifying the count.
>

Oh I read right over that, sorry. I like that more, but I could see this
feature creeping to users wanting conditional expressions other than equals,
i.e. count < N, etc.

Whereas, if we just dump the number at the tail on stdout, folks can code their
own logic without embedding it into the tool and adding one more thing to
maintain.
