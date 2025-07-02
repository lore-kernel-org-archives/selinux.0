Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3602F50B2
	for <selinux@vger.kernel.org>; Wed,  2 Jul 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477670; cv=none; b=Oly7JlT7riQAqBV0ZS/aqksqVvJ/uQGNLQkzOuykXce5j578AewEAhC7jh7OxGuUrMsbnjsYbjKL6vF7WlEQq7a9XIkrlgjk34+F14sjRdnKP0qhxzYtP2HqycdxMvH45X5Ci2MOjbqTD2xicqNPHRwsmkCk/yfYy/68msC2Cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477670; c=relaxed/simple;
	bh=6WQseCeuU8zZitsRp0ptMAYaqODme5j0DPh4DFMZov0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSpudvDCnvoWK3dxqlM5lW6T4XOGishH81xXRh/+OUEW/4WDa+S6CZSzJeLsH7m15zS50NRTx3pym6UFD3ENERce9Jj8pbAcIzsHlWLe01riTfeZy+a7Y+BDcne/0QuM6NnzNtYj2cbILZ6U05ZsPX3pse3vHBLBM57uh4XLM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO2Vt2su; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO2Vt2su"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5290be1aedcso73951e0c.1
        for <selinux@vger.kernel.org>; Wed, 02 Jul 2025 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477668; x=1752082468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYzUSbHeWM3StHYhLSgmUVgp81mZQkJ4YHtsfLfpovk=;
        b=MO2Vt2suU5Zfjf4m2NcR7Hk7HOAModVtbTpXYqEOLlxtCchWNpC1MkMxUHQFNf4ZhF
         3BPtPRN8KsiOhmT05CLBLNLRP9Qhh4P5R/iTakEf4lEXilo83u1zK9EWhSecHmD9jO+W
         0c9RP2ENctO8TDcSd2KE9XNlhBbaM4gFQdb6HAhpM5Qe0vbDhhTVDG5n3spbDWCITxUe
         E1x1+6KGfWLjQlI335pVCSSDvfaq9eERd9mkCwSQlPbUGC6fIe0XgnotzRQ1oHLY3ubg
         AbPKQBbAJLg75tWLS5ZNZx9n8vD4eoCUH9u1tyExnhS3UHtL9NG9CtZRC6pBjaqAFb02
         Q69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477668; x=1752082468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYzUSbHeWM3StHYhLSgmUVgp81mZQkJ4YHtsfLfpovk=;
        b=QcZNgQ80WbCYlz8CWmll9EvOY0KPtpHl4XYB+UcejA3ddrNmmt+y3hGg2NrZd4tOX2
         Xz58QqGgsjQ2iD0NdBQVGUtY+ert2w+Yiv3pCZ5U1dQAvAftwmi/eKJOvOtcFT9x2yI/
         SA41opoat3Mxg1DIHVUj3VnsRpZyAL3RQr+MNpsAGOKskgcu3m2FKDkWS5qFJsky3hvS
         5Tns7ci0Dzs3UzVnTZQ8ekSzTzqOD2fuQitAMABIXr3yOHywC720dGZEbmuchTL71HH1
         ene4LChSdOOLnfzaeOjNnfZ5edn69ue26ELegjwx+wUcsittThtwH+0tppevZ1YgS4Bg
         GqXw==
X-Gm-Message-State: AOJu0YxzbMTUdmWLpWLuHizfOthxa1gqnZEqnxz2g5OIAlmNZ9IHRvhA
	04px2muQv/qlNtGIxzRPHcvnjmSqAuxTEtTIEDorshv1apNye94Qaf/ccsXz0K7FR640rZUjpCF
	QlXj9lsPLsezElp44SbFo7KlBkloVJrUKZg==
X-Gm-Gg: ASbGncuzTPf/TwuME18u9H8Fzkp79nN49Vux0KBTKh/jOx3A8N0SliYWQBAR25wYOWz
	TwQqBQMebaDmoP6qmIyaX7V5LzXAkCKCxdsoXLsZ3mdd2Ns0Knpu85Q7i62GaMleRjfleq8TqoX
	v95QTW2rPm0n8Mq2m3AF0yWEtSxdh1bRh4Q7MVAyqn
X-Google-Smtp-Source: AGHT+IH0fUJda6A+esQhb6T/0v7dNASID99WUqEXbLf9f+kUOoD7NtmomXs5teyZlm6sZ5eSmfIu5aoByu1HZlwTS1M=
X-Received: by 2002:a05:6122:3289:b0:531:873b:dbb5 with SMTP id
 71dfb90a1353d-53465fd253emr530826e0c.3.1751477667978; Wed, 02 Jul 2025
 10:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjqebpre.fsf@redhat.com> <20250625104103.140498-1-hi@alyssa.is> <CAP+JOzSRTvywkO4jXHy6U1xhSC6wtbXSZWqWQoB379vKA4M79g@mail.gmail.com>
In-Reply-To: <CAP+JOzSRTvywkO4jXHy6U1xhSC6wtbXSZWqWQoB379vKA4M79g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 2 Jul 2025 13:34:16 -0400
X-Gm-Features: Ac12FXzBFrZMW18M7KIgeyxSDB2t8VuXBxWxnXOL__MVdwsQ_zHgJn9iNIQ7Jag
Message-ID: <CAP+JOzQKQgQSe5z-FLyqs66+VLxMrW1Yir6JiyvJJsqf70ZRXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add missing libaudit private library
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, 
	Nicolas Iooss <nicolas.iooss@m4x.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Dan Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:12=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
> >
> > libsemanage always uses libaudit functions, so we need to make sure
> > that consumers of libsemanage.a know to link against libaudit too.
> >
> > Fixes: 56d9d20a ("Pull auditing into libsemanage.")
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Acked-by: James Carter <jwcart2@gmail.com>

These two patches have been merged.
Thanks,
Jim

>
> > ---
> >  libsemanage/src/libsemanage.pc.in | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsem=
anage.pc.in
> > index 303f8069..8b7c55a9 100644
> > --- a/libsemanage/src/libsemanage.pc.in
> > +++ b/libsemanage/src/libsemanage.pc.in
> > @@ -9,5 +9,5 @@ Version: @VERSION@
> >  URL: https://github.com/selinuxproject/selinux/wiki/Releases
> >  Requires.private: libselinux libsepol
> >  Libs: -L${libdir} -lsemanage
> > -Libs.private: -lbz2
> > +Libs.private: -laudit -lbz2
> >  Cflags: -I${includedir}
> >
> > base-commit: 2304becd8154eeab084a7ef31b29048c0a780e84
> > --
> > 2.49.0
> >
