Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7817D2
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744426133; cv=none; b=ZWpQyXYgD2KLEN83fKimUXPWwc0R8j8cePSYEcTmmkBTcKjY2ZN79pk+ohEOeTDB9z12xV8EprdA2e6GK+VbhdCpqrdSu96XJ0mYPDugBvToEfwmlYvzB5G0KYJLCQScuj1AZF/pnMcYxpppdT+KqxN6Cf7C2JLYNk0eMK+neLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744426133; c=relaxed/simple;
	bh=EME98mvv1XkLeb9BI4cW5wwrZsUSZzsmfQmPb/Vywj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBgtclkx5xLCGn7YucbznIUz9lbApJdPQSsqbk4NQXtP0bZGU/ws5nzwQ1ZzadmTsBHBBGBDXITSY2noZSBl5S6R9guTyAhsv4lo1t5pVk0A6Fw/iC8iZCI2Ct5B6e9uAAFAJYhddKEpTr/8SUGWgv4iepz4eHtGOGFITc0s/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qfuoi5WW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qfuoi5WW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b061a06f127so449124a12.2
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744426131; x=1745030931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EME98mvv1XkLeb9BI4cW5wwrZsUSZzsmfQmPb/Vywj4=;
        b=Qfuoi5WWMAnTE0IQMVqwiIlO/fzgCg900O5oMlwN1vLXZfqSdi727XlbbkyAYx4twf
         32aUiVY6lBS4AvUhZAeJAv6g2dO82/9pRACRKnKaVw3HzTbT7YwRTOO7KVQIfglaH7og
         PFlFLeYgxPlC/wsRbEkMz/28DwD20Qssp12kZ4boZtqPHHY/hcDM6GIlBd6/foLOSPBW
         BuN93cs+7qBwlqS2wD5gvRhW5LMS0f+H730NI3uY5J0s4GdPOS5bGd5s2IMcfCkpECly
         1rhBJ5MpJsHj1+94+kDCzHQ1TuaeIcWDWPIsA+VlhWB9Iq2kqXVPGm+fmTU2z9DaBtfS
         W7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744426131; x=1745030931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EME98mvv1XkLeb9BI4cW5wwrZsUSZzsmfQmPb/Vywj4=;
        b=V73L7b6gZO/xP4O7TG/kFyuQLWxuz25mJVTS0B0SFEs85ZKeC1YYL91yi0XpcGsqX5
         FSNNxOztrSHrhzp6vMwWzsSXVY+OfxUDLQZ3GzcXpwujc3ZSxwFvMpNiLmbIFPmTgqPZ
         Iwo0t83H/yPd0UXLQac9aWfBlgkrHgTWXAcFbJZ/OgyuPlvNvW44IYZCYl0EVRTEKKKx
         1AjB8kgjeUuRQ3KKmTQCiSbfFoz2fIhjw9M0lDV741TqH8dJf1MvypPxjv7T18dP3do1
         +O/VYycx7GeHq8rJUJeB3DD9ralUyyEdfiiSZmwsV7Bt9gQkzgbNhMYU3Fc8S+Bwv9V7
         /DFg==
X-Forwarded-Encrypted: i=1; AJvYcCVtXnI9nfiVssPTi/7ikvz6HtD4eiCusuo9B/7ou2dw+EktwSOMIc9mwLGb1VfBiiK3SdXBTt0/@vger.kernel.org
X-Gm-Message-State: AOJu0YyWw58m4DkxWwpPMQyN4O8h8EGJo6JQ3TKn5ZzoECzNPZ8Gb6zh
	qoRMLRZMHHU3GpxBgmxymzkwzRUBzBDBlNZDVESD8snq7kcE4WbrYtzgTKwnkH0HjcgtFACzHi5
	4DX0qU4yh+IJ44/rHbEynJFsSQm0=
X-Gm-Gg: ASbGncsqTstycaEMpyd3Z91eKqb0/bDjP7hsj57CZ8MOP8wZw9e7W+yyWd78dxOttlD
	jJvJQ6hKk5tSKTk7p85uYkZR3oHbvWjoVS4mfeef0nFuQcQkqsYBeU2QDBWcRvUgeyzeaIC3tvZ
	xeNEI63eUXikn99vtl/U3K
X-Google-Smtp-Source: AGHT+IGmMLAofWwge7PDCTffDYomDQQ9XWPcWlFc5bcr1fLei/dHaK0dtrfsnOVwBmheExQaY5Y+QtptdvaXMjZdHLo=
X-Received: by 2002:a17:902:daca:b0:224:5b4:b3b9 with SMTP id
 d9443c01a7336-22bea50140cmr57389805ad.33.1744426130882; Fri, 11 Apr 2025
 19:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
 <CAEjxPJ4u6MRZq-3BKbWeGBBjHVom-p_XwvwPpXMu=m5AbsJ8Ag@mail.gmail.com>
 <CAGraAqsjrR15z2mQqeTB_jhhrjcYUr3PpJs6pyaK3Sj1Z_cfNQ@mail.gmail.com> <CAEjxPJ7u9pGv+tyG1jH=vsyMT7qYCfTsYgz=yk7=ncakNYAvHA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7u9pGv+tyG1jH=vsyMT7qYCfTsYgz=yk7=ncakNYAvHA@mail.gmail.com>
From: geng sun <sun.gengeration.sun@gmail.com>
Date: Sat, 12 Apr 2025 10:48:40 +0800
X-Gm-Features: ATxdqUG836UpmUV7z1v_6S8qQcPlLK8MQAdBDTnsdJUqJPW1Qcez_eyOO_tgh4I
Message-ID: <CAGraAqvAoWBweBrnNAygaFxhU2LGtM802x+cZ+pj9FM5J_y1Ng@mail.gmail.com>
Subject: Re: context label has been changed problem
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

YES, but it sets the same path and SELinux context.
This action is strange for me.
Meanwhile, this problem occurs after I updated the kernel.
The SELinux label was not set; it always was sysfs before updating the
GKI kernel.
So I ask about the problem here.

On Sat, Apr 12, 2025 at 12:20=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Apr 11, 2025 at 11:51=E2=80=AFAM geng sun <sun.gengeration.sun@gm=
ail.com> wrote:
> >
> > YES, but it sets the same path and SELinux context.
> > This action is strange for me.
> > Meanwhile, this problem occurs after I updated the kernel.
> > The SELinux label was not set; it always was sysfs before updating the
> > GKI kernel.
> > So I ask about the problem here."
>
> You only replied to me. I added Jeff from the Android team since this
> may be specific to the Android kernel and/or policy.
> Does your policy have genfs_seclabel_symlinks set?
>
> >
> > On Fri, Apr 11, 2025 at 9:22=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Apr 9, 2025 at 9:01=E2=80=AFAM geng sun <sun.gengeration.sun@=
gmail.com> wrote:
> > > >
> > > > Dear SELinux developers,
> > > >
> > > > There is a problem in Android. When the system boots into the kerne=
l,
> > > > the symlink file device_info was initially labeled as:
> > > > "u:object_r:sysfs_deviceinfo:s0 0 1970-04-09 06:12 device_info ->
> > > > ../../devices/virtual/deviceinfo/device_info"
> > > >
> > > > by the following rule:
> > > > /sys/class/deviceinfo(/*)? u:object_r:sysfs_deviceinfo:s0
> > > >
> > > > However, after 10=E2=80=9320 minutes, we observed that the SELinux =
context changed to:
> > > > "u:object_r:sysfs:s0 0 1970-01-17 09:43 device_info ->
> > > > ../../devices/virtual/deviceinfo/device_info"
> > > >
> > > > Additionally, the parent directory was not changed:
> > > > "u:object_r:sysfs_deviceinfo:s0 0 2025-03-24 08:26 /sys/class/devic=
einfo"
> > > > The GKI kernel tag we are using is android14-6.1-2024-12_r1.
> > > > Do you have any ideas about this problem?
> > > >
> > > > Thanks.
> > >
> > > Do you have a genfscon rule in the policy for this file?
