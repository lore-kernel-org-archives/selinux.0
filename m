Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCA266B41
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049676; cv=none; b=BV9dz4MoVYZfkATdQgaIrxYb+5eGoscLE53apbCu2ZY83lArecIqY++5SWDOvW3YbyF+Hu9F4M7rri7TPCGspGPPGSMsFMJgCuKzQP7eHOMJQDhKk1bzGAwBQQo1Ciifj1ZeICXjKsaAvqhe9VP+4xS9eJyg/17hj1RGU9vBQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049676; c=relaxed/simple;
	bh=u78nVWH00dVnCyo2iMIkDFBvaqTgN3SgGNHxfyCKJLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb/pXQCWhvYHTperBIC9Pc6yctTcFdHjRDbyXxfB4gU8+kXPwLw8Vgki5k8JeMT9CJ6tq5bNOV2j0gbpcucSj4PIqxWm9GJx2J+LEk+zNE+NRhJ0YuB8aeXg6hA4ZCjrb3Jew3foA4ATE1iFGFXsGEIsv6/JvuPBbmoj62TdthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxdKSak9; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxdKSak9"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d42f08135so1999636241.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049673; x=1744654473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BhC5QNTucHbHbjXM2ru+GMD/7U3eUOtg7pU2VNhezI=;
        b=GxdKSak9lWHKsYYYqu+ANfi0AvzHa3vsE8obdUh8h5GRz7TDM6DKZLmotc0DKngVPO
         8iXn7hY8n/gpSRNhQN8NDcYR+jvkNpijxp/8WTXp2P+EWGYJMpQAd6UD+fPtx/pRGjen
         /02qwe384e5Z+eyYmKLd+HZS5JBUe+Xq6LKDgMIpt5ivLyPggJMO6LvrCOvGVAlLt8Pk
         VFFZvWwobItDrkQjCeDB/ntWENVQfrWFjJlJvbQx9lSjHrhIpeJsrAmzVUe1R/Q6Ktf2
         cIS6+b744omKeS7ZPgaaBoXrdEqWcG1d+A0bsOoWTIVkw6BsupNOGtjySqZLyUl1acn+
         3KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049673; x=1744654473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BhC5QNTucHbHbjXM2ru+GMD/7U3eUOtg7pU2VNhezI=;
        b=uXHKqZJVAKf8wH0eKptN4FRi21NHXvgeLSAOLD2tlNLPZLxdAgZRRQa4aF1qZlCANI
         2HixKyo1nzRTpqxGkXov41PY9WBTspAYvlWEpsNPDspi5W5VYmsC0hHb8jzbsrII35xQ
         2OS/PWse6HUUASEotnyzGx2sS+AIC2q9VtTtXYnFyan5vfgzx49oyNmpObQC0j6dbU35
         75q4nlWX/o2BbD5SdEa+oNowtIhZ2XCX5M4xsGQ71RYVeN5C6H8UdufqU8fzlp9kWabV
         hxWXdBfh/beT+7LrmkqTEBRw8e+gHBOaxhgkjDPM2nEYbj6vgszw+UBt51crE/CAU3K9
         UhRQ==
X-Gm-Message-State: AOJu0YyFm3BJEyldge0/IcgvTDsYeWG6Edn9ywV90yRa5PWUPpbQRCmi
	TZOi6ghyDjo0FgpgJm/frZuU+SmuNXPGQAVuro/trz2hhuPojxa75A9WGatmYF5hyNDqfluDlsf
	QPM2de/d6OyJSP/THLNEAlgR9UsU=
X-Gm-Gg: ASbGncutBC9bslnwo5aUVgKaDUQ96IrYRzHH2y0hTieyoQFLTScLhYEa1GX9yPvEKtD
	QDsmGwKUU5rj24jd0IPm7RoI3o0uPJqetMsswz6Vqmuag3VCQTRbSXxauFT4fnFMTMDNMzdoQR3
	3K5QNzLA5DNwEI52dykSiKmFE=
X-Google-Smtp-Source: AGHT+IFrVb51Q0dSZSvC46f2ri6pH0VITuCmBE/eArmtaJw6H8O2YbPAJGq5BFWaAL3N2KwteGmVhcJhxT8u1In3CWg=
X-Received: by 2002:a05:6102:158c:b0:4bb:9b46:3f87 with SMTP id
 ada2fe7eead31-4c86365f46fmr6867842137.6.1744049673192; Mon, 07 Apr 2025
 11:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314171355.27185-1-cgoettsche@seltendoof.de> <CAP+JOzRRbx6v4Rri717_QZfcPV_EpkVk7Z=riX+aiJ3vtd-8HA@mail.gmail.com>
In-Reply-To: <CAP+JOzRRbx6v4Rri717_QZfcPV_EpkVk7Z=riX+aiJ3vtd-8HA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:14:22 -0400
X-Gm-Features: ATxdqUEtA5vuAAUeAYgn8XFDdIY3qeteMGCnSRm3GTanSCy0eqpXd35AXoL43W8
Message-ID: <CAP+JOzQNzZt78JXu6GQsNnrk5cD5Yfz=09MPWyuqvn-OPwWRsg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: free ebitmap on error in define_compute_type_helper()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 3:08=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Mar 14, 2025 at 1:14=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Free the local ebitmap for classes in define_compute_type_helper() on
> > error.
> >
> > Reported-by: oss-fuzz (issue 403364352)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index f19e9f6d..cdd98cdb 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1699,6 +1699,8 @@ static int define_compute_type_helper(int which, =
avrule_t ** rule)
> >                 return -1;
> >         }
> >
> > +       ebitmap_init(&tclasses);
> > +
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (set_types(&avrule->stypes, id, &add, 0))
> >                         goto bad;
> > @@ -1718,7 +1720,6 @@ static int define_compute_type_helper(int which, =
avrule_t ** rule)
> >                         goto bad;
> >         }
> >
> > -       ebitmap_init(&tclasses);
> >         if (read_classes(&tclasses))
> >                 goto bad;
> >
> > @@ -1759,6 +1760,7 @@ static int define_compute_type_helper(int which, =
avrule_t ** rule)
> >         return 0;
> >
> >        bad:
> > +       ebitmap_destroy(&tclasses);
> >         avrule_destroy(avrule);
> >         free(avrule);
> >         return -1;
> > --
> > 2.47.2
> >
> >
