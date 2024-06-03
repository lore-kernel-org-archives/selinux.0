Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F9F9E9
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440724; cv=none; b=XxqWxFTU60ywojB+2INXHZfVOKDxEFGXWX+tFBAWO2WSKs9jOELGps/Ra84PBrn8kOidCqEGHvsgTmtYW7dCmTxhm/cRXLsS93NDoINfXqVBsn5C+xiTYHOKdWIlfQk0weXGcrkIx4dAE6yweXk6d1q1PIinC2eez8PZmyIdyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440724; c=relaxed/simple;
	bh=IHG17KVnZfK+VmAV5pLbW7T9M59h09dKmPcxHIHGato=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/+mYaD1EXKq+765abs3FkBbBicnoA4+0qEiWNajWH3s6l+u8APC8IjJwxLEKBCWp0DveICgP9K+6MFNIFbfgOgQlYFPudc8XCxXglmrd0FL6TQgoyGy/L/0Zj3SDO/0tMsDS6Gbjomm1+356nqMu3KppXzPCwUh/Z9x+sLtEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feVGbWGS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feVGbWGS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b90038cf7so3109876e87.0
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717440721; x=1718045521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABmB9yzxEmjE+T1F1c6I0GOGohFjI8O09HojmM8pbjQ=;
        b=feVGbWGSSUcpKizlKF3kt+Ij/JEtwjz3w9tEs/MD1Mk3ttIdpfjdJo58PWNA2qIFP5
         6JaXj7+8uR+0OVzUj264VeNNJj5+T0i7UDBT4fIFeiY6Y83ba4ZK8LFmtSbw7gK4yZFK
         mGmU8G5Ns3mmPYyZLvERSr+L3ipW1lZ2P/A9iv4IPbLMntLsHH70wlgpZjeCKxrJNQLE
         0Gv28QVwiEiOemBjxIYsAiFcCcPAsyJA+GrzRjo19Cm3JHDdALxwhgThitlMYpeje03h
         7ShAfGomkB/ZfvTOZ9MzEw6KMBPS0/X31v5eNpsq8WK8nBcgYsbHvHareCAVcM7V4KDL
         AKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440721; x=1718045521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABmB9yzxEmjE+T1F1c6I0GOGohFjI8O09HojmM8pbjQ=;
        b=hmeFnIB6TJBBJHMpylmcRUFWWr0Rg947Xb0azMnl2KJKaOGLdv+eqkerccs0dhf5vf
         gmUL1/KnQ04O0NokJ0jD9q/YpaxNcIUfZbCEeUyFa3SQz2qNiBl/rwz1Eizb7nYD2YX+
         cWHupPY5LOPweyNC3D7pd7cfd31AT6H6gbLETHOAwx0ThOKYK55CDKp0Jd9YePlwwT4r
         Eg5rP21JtZJA81AI/WxzZvf8CUJi9iXI0bLZ961FDJRouDlSBOkDupgADoC1o3Czi85p
         wfU7d4pcnotK7o3rFaHrwGy3LJZ2/AC0AGW1jQTgnb3A0acUwYuIP7rEB3S7XB9+mJIF
         UgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7hThEN9mJeZVh1YQ45eHCbdy84Gi50tz1gs7DE/dkrT3qM4Rj9DWlv4blc1WjjMtavDvZv2twTnGzjEbVSTf1ib/EWVNJMQ==
X-Gm-Message-State: AOJu0Yyo1TkPl83aqsYTXCd5xvOqx0+IjUm4iUc5fm1xsssw3836N3ar
	QZBC2nBe+mSCPoILsupCUCn0hW9VU0NQidTtVc7KSdzCtlR9o1ak4mXHcZFB4Tf+v7mYToi+nF0
	+ChRXSqw1T1yataCgkHVe7iTKFdk=
X-Google-Smtp-Source: AGHT+IF3uv0DfmGdIEzAMIrNlm8HqBcghj7c9vfApQRFt1bVR3ALB/jHkkyu6yHw4qupmd7jzLPgEmlXKemsoLWhHGU=
X-Received: by 2002:a19:a40a:0:b0:529:a55d:8d7 with SMTP id
 2adb3069b0e04-52b895583e6mr6087955e87.14.1717440720591; Mon, 03 Jun 2024
 11:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de>
 <CAFftDdqRZcQm4kW8+pAOYQDQ46Ze9Q0zzpqsKYi9KNz-1wduTw@mail.gmail.com>
 <CAJ2a_Dcy-WHrV5FY3FHLTFBuJErKhwfyFc2R4CjZsO2PHYJ77Q@mail.gmail.com> <CAFftDdreHzHTjpFgR5Tf_XF627Zrr5TabYC7ZLr4r07gQ69iaA@mail.gmail.com>
In-Reply-To: <CAFftDdreHzHTjpFgR5Tf_XF627Zrr5TabYC7ZLr4r07gQ69iaA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 3 Jun 2024 14:51:48 -0400
Message-ID: <CAP+JOzSScrkud6dBAhqXosWBq7KCTHDr-C2_s1=TqJrpeOwWkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: free empty scandir(3) result
To: William Roberts <bill.c.roberts@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:57=E2=80=AFAM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Tue, Apr 30, 2024 at 9:35=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Mon, 29 Apr 2024 at 22:35, William Roberts <bill.c.roberts@gmail.com=
> wrote:
> > >
> > > On Mon, Apr 29, 2024 at 11:39=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgoettsche@seltendoof.de> wrote:
> > > >
> > > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > >
> > > > In case scandir(3) finds no entries still free the returned result =
to
> > > > avoid leaking it.
> > > >
> > > > Also do not override errno in case of a failure.
> > > >
> > > > Reported.by: Cppcheck
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  libselinux/src/booleans.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > > > index c557df65..1ede8e2d 100644
> > > > --- a/libselinux/src/booleans.c
> > > > +++ b/libselinux/src/booleans.c
> > > > @@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, in=
t *len)
> > > >
> > > >         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BO=
OL_DIR);
> > > >         *len =3D scandir(path, &namelist, &filename_select, alphaso=
rt);
> > > > -       if (*len <=3D 0) {
> > > > +       if (*len < 0) {
> > > > +               return -1;
> > > > +       }
> > > > +       if (*len =3D=3D 0) {
> > >
> > > Changing this will allow scandir to fail and it continue, what's the =
point?
> >
> > What do you mean by "continue"?
> > The function will still return -1 with errno set if scandir(3) returns
> > <=3D 0, like it does currently.
> > But currently if scandir() returns 0, we currently leak the pointer to
> > the empty array.
>
> I completely misread that, my apologies. I just mocked scandir for all
> those paths
> with the leak sanitizer enabled, lgtm.
>

I assume that is an ack for this patch as well as the other two?

Thanks,
Jim


> >
> > >
> > > > +               free(namelist);
> > > >                 errno =3D ENOENT;
> > > >                 return -1;
> > > >         }
> > > > --
> > > > 2.43.0
> > > >
> > > >
>
