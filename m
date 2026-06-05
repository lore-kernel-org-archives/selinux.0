Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5293D47D9
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685741; cv=pass; b=d6sCZzyHf5XRHNtG14hhRS+bj+xphs2ofSpWV8aBoBXEqV81BgJD1YbSJ01H4MCmAm+rSy+60YOXudUNxcc4o7CO217fozgBlj9lS7aw0o1F/HOcuuISq02Vryv3qw/4eDEniFCMjoIBz3RVPsuXbOogocKrIDLztQhsC48w5Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685741; c=relaxed/simple;
	bh=/zD+vJWIEjCZpOBRhMT//Y6CT4ebyjQ12cSWM0j/FUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuzhU+0KtWZUx3sFZbt5Vd2i7B7cXkQ7ozAE/3xZdGMtaAOq+RW2AZVPQvSNEe42FjmwHq7EDtLBFgpg6dG6bESLIYEOybUOrY4CHbCEvgsRsadUUXDk9sSOvRs/AWpK/fcygf3Xf6jLt1YGcVZp6Iyq1XuyteJXDc+i2e8fmsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvec/4GH; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvec/4GH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423efad617so1295432b3a.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 11:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780685740; cv=none;
        d=google.com; s=arc-20240605;
        b=OVJlrN9UYF/lEP7Ox26ugE3N1RBhw8/0cAFR8V2brnn/TL4L3pOZtt69Bn+lL6nGg1
         co0rxHkFSxwAgRZYvETUu9t1ZWKbPgftfEaZtwObgqNoRKPl0bq97iEFgVCG+/50v9Lw
         ZmKyoQUJtVjDaSVwdBabFg5Fq4twt3Hr10MvSMbRPxYWkDwSqVtqocvxK9LGNEoYzyKE
         fIBYAV4SgoIgzlL5psDhOCxaeVOiEd2vbY19wb1B8gGxIdP1ez/qZRsvzg6xSPIlSjSL
         7+Pyk7DQU0TzVBM1n/Ct+4EVoilwgeqlH8nykSSSVDTNp9AbiSJRNbZkUN+uYQ1KWjCD
         nA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CKc0AC8C6qgAlIMgATS9JxubvU2wMOfGnmfmETyhq/g=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=MgD857VDTGRSGOk6Nzj9RnOtKcuzk+jPPjGXlTsRvc37LKvIMYkuZ841Zu/R04JTM5
         MZQq5F2DLo5g/Q6Et02QWTAZlExmaba8DURg4/hUwOLCz9kfXg0S/qp3ox+KLtN65pmx
         8KSL3bQsF4G9vqvsOhs9vp0OHtllJFfsZayAYkErzZUkYgLc0NOnC2q/4pOFqaDLfCPO
         CwDugppDCK9B6DZfXtOJtbFs4H5v0mztHUSN6ICJyWUHK74f1r16jYp12XUky/YmQcRX
         erO92ZcvMcQAV9YJg2oElHqP8MfJVLrPnhNMdS1w/Jh2F/Mw3Vo3u4pycdUxn7Foss8A
         BG/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685740; x=1781290540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKc0AC8C6qgAlIMgATS9JxubvU2wMOfGnmfmETyhq/g=;
        b=hvec/4GHJ1K4LZE4fef9YupJIdMKPgyFZCflKFmAsHcSa+bYycqMt43WA6VaWmc2/U
         Yjw52fegqidtDjIt8T4ETm51fgOWPWWOs9S/Uzt+udx1xiI2wpPtpiDvEGKXc/0X871Q
         tS6I7LwGpti2BA/ONXLhr8Nl8hcAn6oQ777LV2jrafTpLBaniA9DoVAGXoiuwPPU9eVg
         Xf9D0q7rxw2XYXq7ugI7EdM15R4UwT98NYGMHjWJCtA8HUM/lRAzUpwl+2RtayziHaPp
         +PxO5XwYavK7YI0rSnA3xCjnEpJ6mQ/5s/N50qPKegiqo9SzW0I+YCyH+sfsrMk7fspZ
         COjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685740; x=1781290540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKc0AC8C6qgAlIMgATS9JxubvU2wMOfGnmfmETyhq/g=;
        b=lpORLJLUfHbu4q333jbaXU7CyYqSOgI5WZkfzKvJoioxjU+5habn00bC03kKRR3+Qc
         Eyuz2pxou/aaYsU4eZIDPpPMm72IK5/JWkVR0xIQgMVYObTYhkDuBno6FDDzYbTyv45s
         Od04wQxagoRjUqTv0Ir/nyl7vnjHgKLFer2pnTPRA3ASF7CeAna7MQXe4bz7QyxU7nh/
         GrHHg+Fna6y/DSkBL114jwEkpZlHK0NAAOO0uMD9ogAMjdS7e7xWZihBSuRaxzpuJScE
         rQs2xhuWRmSJ+PC+YTDU62VCbJdBt0MxFpenF/pti0Pzsw63WFz+y5jjwH77Q9ICq56j
         iIgQ==
X-Gm-Message-State: AOJu0YxTWRWFowJpdGnC4cHYkiMm/ryZOSu5BIo+4IgWF1PCsMqmSrNt
	DuauLy3n9+fDTmj9PI57ckp0PEZZx4WpxSPP4K3PnB8TAOfj99GmYZQimjI7tC5wqM5y7j0g4pA
	T7uG9bc/E2ej+YS+UvDgSf46DlQyVwcFNLw==
X-Gm-Gg: Acq92OFAbLX3AITiRJWHBdD4HY7tLJPT0ax1M91APrgTgVv6VE/7UDFms/VBK3/iZ8S
	80K4JaeqUKvXZ7ynxY6MdcfIat5Wozr5yiMGPDlwHoJdVRWscBPY9A2udy3tms7IO5/EKhODOsM
	daekKAiBul9pgNRxYrQfq36wPT7Sy82QApIx/MYyAy3PdaPLouri2MtSLByhKN+J2rUV4vwY96B
	MuspG55u3zN8xcJoZiHSFgRl+OreoOVTvbLpUSnKsdB9vMGmBKWP0CJLPT15EPcMmHqY+d3CO0u
	E1vEIZ4NyBoZ/nKQZHB1QtCMH8MF
X-Received: by 2002:a05:6a00:bb0f:b0:842:79f5:8325 with SMTP id
 d2e1a72fcca58-842b0ffc873mr4825603b3a.44.1780685740084; Fri, 05 Jun 2026
 11:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
 <20260605172207.222382-11-cgoettsche@seltendoof.de> <CAEjxPJ4AfpaRTcDBtLOxdYBsWdooKeT7_8oqq9WY4SwRdn5RdA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4AfpaRTcDBtLOxdYBsWdooKeT7_8oqq9WY4SwRdn5RdA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 14:55:28 -0400
X-Gm-Features: AVHnY4J1dK__BZQ8wTBI2DR3Wef-oRrTpgAbfBANCUZIVLsJDhCy5L3ckV6ot_M
Message-ID: <CAEjxPJ6juWuhwCb4XBfgs6WfeeUc=bM3E+b80-L=WXpdjgArtA@mail.gmail.com>
Subject: Re: [PATCH 01/11] libselinux: use size_t for index
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 1:34=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The variable is used as array index and the only caller passes already
> > size_t.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged all except 10 and 11.

>
> > ---
> >  libselinux/src/booleans.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > index 4e752424..9ec46ed1 100644
> > --- a/libselinux/src/booleans.c
> > +++ b/libselinux/src/booleans.c
> > @@ -329,9 +329,9 @@ int security_commit_booleans(void)
> >                 return -1;
> >  }
> >
> > -static void rollback(SELboolean *boollist, int end)
> > +static void rollback(SELboolean *boollist, size_t end)
> >  {
> > -       int i;
> > +       size_t i;
> >
> >         for (i =3D 0; i < end; i++)
> >                 security_set_boolean(
> > --
> > 2.53.0
> >
> >
