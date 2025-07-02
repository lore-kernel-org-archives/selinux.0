Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38D21D3EC
	for <selinux@vger.kernel.org>; Wed,  2 Jul 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477638; cv=none; b=iBcvMngafsXXmPi/UDGZ6WfbOUHbXmO3DPLZ+oRuPSoLQU7FUaR3D5Ayqvlw49l08rnHWWim8CgJtcT+N9/aMVlFlcXD6cqdyrEgnhumOg4iTn5usTiYjeEOkhCQb/X9X8aiTgPSWkBIBsTFFQYIpEEd/tDXZmQaQrmu19NnfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477638; c=relaxed/simple;
	bh=Q7gzidql0CCWHDurQnYS+fdObl1ecxJOxr9/ZwsD6fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2+lxZjetaH3RjDWJQI3tz4cgMK4f+siJsoy4ibsMB+OOAt5mvZOfXwfGqZcwG3Dj4PqNkTXZEE9DoWwZUoUopg6MAGqIUp0ITPgq9HaubeRLt1wBWdpoGGOGDb0mXhZBJ0V3fpIM9OfYXePnAtkNF8+kUR1O/9nbRKhfBLcQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuiI8HhC; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuiI8HhC"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so1725207137.2
        for <selinux@vger.kernel.org>; Wed, 02 Jul 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477633; x=1752082433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evDrdmlxeV5kfYJK5Fdv79rMwD9uWA92b7RLIiGI9N0=;
        b=DuiI8HhCNgO5b/UrV5qtLeLIKOh/EXYjlLSgBZbrfaEOew69srOZncrSgH33lSDg3b
         xkwMghJYLsXtXFA2hQZUijf+YS8rj+cKk9QabypRp1+M7QgoHpVx8MO9VqeBdmuA0B/V
         VBXJFpMJWUnqpTGIYa6BryP3FdTOAvhfvs750O9hgEwt0EHZ6jE3tvqbDUnkvBNKeme8
         Axskr0pTJq17pYtsn258de6VpjiQklGvR0DmCuV1ZKNNWGY/Y9jM7arPEsfB/WuuaNby
         g2eXBV+Chu/7kAwuChsT6MQOTUp26Bh0kUwNNzDnXLbDzbZBKp6t4eEE6xvS0YxGSX8b
         Rzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477633; x=1752082433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evDrdmlxeV5kfYJK5Fdv79rMwD9uWA92b7RLIiGI9N0=;
        b=MYKrPpUa0AAV6BT0nAXJqrjifI7fhHl4c7Udw2Em3thLkHCxtoiH9OwsnTa2EGRm7u
         I/b2vMjNo1FLoMPwcHbS+IDCRzlJGxmRBUUBCd+MybdRjqPbn0m+jSrJ3elkxqcGlkoZ
         V451IeU63L3zoOF5M+/eaI6fP0I9EHQVgpfGz/9uNQehdoR8LJq/N8Xqqfh5MwhD7Ysg
         D6Yh0nT9S1t9p+U8/mvhfGZmMcVys5tUEWvWmPh6A/052NpchQSM9UQun5vtLnQ/Ow7O
         wigYkc1uxj0hfIBtc5NLMmCPvKgbSLvWqgRr6mPsMVUkf+E2hvG+3KTe8Bn+ou7EEt6D
         1KZw==
X-Forwarded-Encrypted: i=1; AJvYcCVyId/ySdWQNsRU6plHKiwyI8EY8RNYNDukRPtF7JiGPtfadrFOZ4v6L12UrVa2m4yjOG8wbsKM@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUHMO+/mxBOI7yUTfrC1cZfSqlWnzN/CR0oNy+JSUEd50Mnnn
	rfSPFZYl/QcLYrRQZMun95aMIsc+SWm5lJxLp40Y10RlMDpjOrhDpIgRrJ5lHFsTJd5JR62sIZO
	EYMb+632SrPix/GF45E6DORAADTaD1Ac=
X-Gm-Gg: ASbGncuG70zF0qCM1X/w9Goux7kapZciwE6sHnzm5aZGv1hEfp5rcd2U/laxcmkNiiB
	+Vrz1Xnet+nfAWAnBjXbIWYleZxQUcBGb+o/pczIAga+AIjC7ri8bEtzKMmQypkv6g/1fvIKLRn
	nqlFwWUUVVptDybX2SGlKdccSYogeqt1uDVfU6+4vG
X-Google-Smtp-Source: AGHT+IFGpTj4RZMTMyjHz1A3dIhMzhyn1wL4amZCTewjgAl+7UXhzYypUOQz0KatFO84hAp89xacL4qalffSKXi9oXA=
X-Received: by 2002:a05:6102:3051:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-4f1612add72mr2369437137.16.1751477633322; Wed, 02 Jul 2025
 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611070248.2669186-1-tweek@google.com> <CAP+JOzQbrL94Cow5L+SaUhCJNAA_eUu_pkO=VkP1vUfuUQs+ew@mail.gmail.com>
In-Reply-To: <CAP+JOzQbrL94Cow5L+SaUhCJNAA_eUu_pkO=VkP1vUfuUQs+ew@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 2 Jul 2025 13:33:42 -0400
X-Gm-Features: Ac12FXxch0L42f2ovpc0lVb31f1zDhvfO2FV5lfF9_VHcOf1Iy_dFxLWCO8fJuI
Message-ID: <CAP+JOzSUL0J-BtPnLGU5ZSYwBdYj9AZmsOKEQw+LeDmtB3fZBA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Document thread caveat for security_compute_av.3
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Seth Moore <sethmo@google.com>, selinux@vger.kernel.org, 
	Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:10=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Jun 11, 2025 at 3:04=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > Move a similar paragraph for selinux_status_open.3 to a CAVEATS section=
.
> >
> > See discussion at https://github.com/SELinuxProject/selinux/issues/287
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  libselinux/man/man3/security_compute_av.3 | 5 +++++
> >  libselinux/man/man3/selinux_status_open.3 | 9 +++++----
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man=
/man3/security_compute_av.3
> > index 6c82eca5..af8797b5 100644
> > --- a/libselinux/man/man3/security_compute_av.3
> > +++ b/libselinux/man/man3/security_compute_av.3
> > @@ -181,6 +181,11 @@ function.
> >  .SH "RETURN VALUE"
> >  Returns zero on success or \-1 on error.
> >  .
> > +.SH "CAVEATS"
> > +.sp
> > +These functions are not thread-safe, you have to protect them from
> > +concurrent calls using exclusive locks when multiple threads are execu=
ting.
> > +.
> >  .SH "SEE ALSO"
> >  .BR string_to_security_class (3),
> >  .BR string_to_av_perm (3),
> > diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man=
/man3/selinux_status_open.3
> > index 5c9da2f6..5592487f 100644
> > --- a/libselinux/man/man3/selinux_status_open.3
> > +++ b/libselinux/man/man3/selinux_status_open.3
> > @@ -82,10 +82,6 @@ Thus, don't use this value to know actual times of p=
olicy reloaded.
> >  .BR selinux_status_deny_unknown ()
> >  returns 0 if SELinux treats policy queries on undefined object classes=
 or
> >  permissions as being allowed, 1 if such queries are denied, or \-1 on =
error.
> > -.sp
> > -Also note that these interfaces are not thread-safe, so you have to pr=
otect
> > -them from concurrent calls using exclusive locks when multiple threads=
 are
> > -performing.
> >  .
> >  .SH "RETURN VALUE"
> >  .BR selinux_status_open ()
> > @@ -96,6 +92,11 @@ On error, \-1 shall be returned.
> >  Any other functions with a return value shall return its characteristi=
c
> >  value as described above, or \-1 on errors.
> >  .
> > +.SH "CAVEATS"
> > +.sp
> > +These functions are not thread-safe, you have to protect them from
> > +concurrent calls using exclusive locks when multiple threads are execu=
ting.
> > +.
> >  .SH "SEE ALSO"
> >  .ad l
> >  .nh
> > --
> > 2.50.0.rc0.642.g800a2b2222-goog
> >
> >
