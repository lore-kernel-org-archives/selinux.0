Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1187439F89
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973720; cv=pass; b=fwSLIUxQUO/AtEmR1gkQfCcIcwEoSor7eQCqXxbUvhSM7Bz5VxjIN5SuAhLcbnBVgfiqjMbuNKfSSDGjq+VDFcc01zztDyvXJHoPpSibJH0MNkgOh25fr/ygySEmyE/SfXTobw4BdhyJtgrLFkQSKwGFll1jn2B/LAyYCGHvm1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973720; c=relaxed/simple;
	bh=6Fu4pzU+LyAMXtm+IQBod7zrM8CElmHoexv/9YIROpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fa/6nsLu9ZgzhYR/KJ8PAz657pFZNpsnjrh8cngEW2pU7574dnjkbapWdZySWtyCbWc4FermhN6nCamhABfkP2xeIt9ubuzJacBxbEn/oz92mkegeomSPD6YAfDtd5v2/yiKVYdcBShbfPjrPlgFi0jstFRZCuoZiyx/Vh2I60A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjsTCY78; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjsTCY78"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43b7e186a0cso1078930fac.0
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 06:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786973715; cv=none;
        d=google.com; s=arc-20260327;
        b=mJ85BiwQumlO2Coq5xypHex4xKg3Ki2PEx44QT70dT9XQpBk+5UG1B6tAwjJUemfHJ
         QgfqYAsqhdvraWr8a3ImB1QflvgC1rruOiQyYULyfNTShw/LYvS63lDa9qBg7T3Jxge1
         zhGDEf3aS3XrxMjY68aT+lgbH/3XvFEKmwJd6qKtEp3QWJUaGSBF09vOYgRqSRbM1MI6
         p+iRz1ycMy+OAEuVWDErbWV+60HB5GLf0wIGlZ9yAbWeVlO5/EBgRXG/HFAlZdRt7Pjy
         JcYrq5LwpOr3v2xJlxpDndYV1W7LqDzTHQo8rCnGF2kkiiUm+7Wo7sBxzgxn992xrpUl
         bH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Fu4pzU+LyAMXtm+IQBod7zrM8CElmHoexv/9YIROpo=;
        fh=jKypAQsinffTBS4PaCHk3Yr1oHjcu9N+jEMdzGkSCq0=;
        b=dQLbEZwMQSYgwegfm06vqAg7H4VUgZx0QRDKx9VByd+vFodif9nPOzqSzepXe38vPK
         0ARyAAZQ/zrfTA6zSVgSLONlXTJNIu/DoBFlwyDWnrxwoQr8kMaIlcYpwU/fF0nZq7Te
         usyVe8C14cWtJxuunPeuXgIXAAh2vAl3VkbA9BKlp1i4Q+TOJ2KnMdzTp/3ISAJ+nQyQ
         Ip3gx/j2XmMTOs3pOXjUiWtTaZuUdswkQxxB6ee3Aejwex1Wo/PdgHXLK2oKIE8xYSL1
         /itvOmkilAib9vjSUiZPDFe+gCUPiRnM+qzKBYD2v0+/pfkYBOQD0hz9x16xWLs7KJB9
         47hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786973715; x=1787578515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Fu4pzU+LyAMXtm+IQBod7zrM8CElmHoexv/9YIROpo=;
        b=XjsTCY784+cmWOrZy9gmNaac5i8oT+RcnCin4HipK29GdaYfVI7jSzDkZwGHvObbEW
         v3UAMYoygrpFzAq580h6tG9SHUSsqFDV+Y2xAQcqxGldkr0IDp1sinF/YUOBRr2Axk3a
         rtIi5+KsOuEQOJrYmhN4r4GqrAik/aU6rtkWkmrNWWtVwCeFyuZmNS10ZwTqHSi0oF2b
         R+53TW3sLYu2zsW8+vBwWfNEq7PxUq9abu01LTbz4nNGXxDAPp3nGxqEQFl2CdYyBa+4
         cd6KtwKkErA488aJz2h32M5U59lsNFBPHq30wUCBoJepR8HQocP0P3kx2X75KDuKuG3E
         n6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973715; x=1787578515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Fu4pzU+LyAMXtm+IQBod7zrM8CElmHoexv/9YIROpo=;
        b=rQeU2KsZmH8pfVUN1br5yqlTEbhkq71ZS+dQOcJZifzza6EDnkhLAgBAZCWHfQznOz
         YhN/7ENKeRQPmMEDNEkQhdNNWgC0yNb/0wO/+Qt10OkAL48bUSumRexsKlgfzudz7cDh
         z5uo4r5Y1E3Y3YjuUSJdi3PNikx2fCRDDR/ZLI6GgP6TYnZ9qUFw5QafXaXrpuqFODiw
         T3J5znRGBVrl8uRfae/g0JjxJhYa+cSZBhfg04JZ+83UP3EGcrpkXdQM7qMJ/smyerho
         fFcNrnAKilmMoHcshJIyH5gFcGXCwhTWvO59iQt8raTk40Q+ypBt9B556lHFkf2+dr/p
         K1jw==
X-Gm-Message-State: AOJu0Yyh52ML59SIPIMBbZygIhrm/4hn0T0otGX2urYCbsOewV01Apc5
	l3nbpct8P4xGTnRPggXlpG5sfwGfNb8aUqk5vLCD83YShq2rf8q6BjOZMSIlPRvaq4lsYumipT+
	foPeA3+UG5DRNoo/KLdEQ+n5frX4GqL8=
X-Gm-Gg: AR+sD13bdCzol027OlLVUmhUdpCw7c3di7lxNNZYLl6+AA00Cne8ZhIScrizGEfNPv1
	78BVugcpZRaE4pFZyWgL4le9pK/jMl+nBSAmK6sAkjf7lJnFaF/CFMixMigmjbyCJ0GIBpyjCQs
	zmhESVjNPpk5JD+Pciv+CgTLVeFvZlN2mF0oSC6Bo3QnUqaR6cDDc5rPGNslp4dWWOqrGulVa3H
	gFDZBBV/gOcInO4VGAEdPokt6g/wovu3dmK4drOPzRiT59nSswFwt/fiy0gseUpMVfynZ7QVGOM
	1km3pXyJn3pShtRrkeSOUwhNx+CinnfWfNg4cso6lP4/
X-Received: by 2002:a05:6870:2492:b0:455:e6ea:bd8f with SMTP id
 586e51a60fabf-45e923eb3d3mr21213160fac.16.1786973715678; Mon, 17 Aug 2026
 06:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814230432.53831-1-kalevi@kolttonen.fi> <CAEjxPJ7diECpC9H+ceKZwZzDVXQ9bbn5R37P+uD8JnpBe3jVyQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7diECpC9H+ceKZwZzDVXQ9bbn5R37P+uD8JnpBe3jVyQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 09:35:04 -0400
X-Gm-Features: AcwNN1XBOQBUWZd7mc4xyRJd-MCO2ygglGWHqf0xg-oAebjf9Ub0nb9UD4st43k
Message-ID: <CAEjxPJ6AH+PyS5v80_Q6v3Gx3AOmb3r1X=hnGf5pan=wGHbygQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use bool instead of int in validation functions
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, James Carter <jwcart2@gmail.com>, 
	Petr Lautrbach <lautrbach@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 8:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 14, 2026 at 7:32=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttone=
n.fi> wrote:
> >
> > This is an effort to use boolean return values instead of
> > int in as many libsepol validation functions as possible.
> > The functions passed to hashtab_map() have been kept as is
> > to avoid excessive reworking of the codebase.
> >
> > The change from int to bool requires adjusting the callers
> > to invert their return value checking logic. The caller
> > conversion has been performed to keep the existing logic
> > intact.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> I am hesitant to apply this patch for the following reasons:
> 1. It changes the semantics of the return type of a function that is
> exposed to multiple source files,
> 2. It does not rename the functions to make the change in return type
> explicit and ensure all
> callers are updated.
> 3. It doesn't provide any runtime or memory benefit.
>
> Other SELinux userspace maintainers are free to disagree with me and
> merge it if they desire.

Also, your patch breaks building the fuzzers due to missing #include
<stdbool.h>;
to reproduce, run ./scripts/oss-fuzz.sh to build the fuzzers.
