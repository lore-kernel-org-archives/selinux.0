Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD7770F3
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488792; cv=none; b=eLgf4fQjtAg90GNNJlVf5LKvKFWiQyX6Pi/ezMQd+07B3NrzdiXSt1OuTSxZvECNIMZFDD8dzgMod5WtOuk8DeQqH8JPJ27nvYhU8Lb9Rzlb+TlA2LABwU9Ji23PFFstljIOFKznXng/WxjFRzC4OzYmhzTVYoKvG/JuFbcXsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488792; c=relaxed/simple;
	bh=rOj/ZsngU+4tkrgVPmeMwNXhLRFu+2igTmpEP1F6q8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEyyzTnmkwxqx7oj/MkXrc817mW75d9XQ+sAo74MBHGTYQUgXDgz99fBZdfXotqVOgH08ym5v0fQOnusj4NF9bc83B5MyDjDgVncMp5/BKYBjDJWAhBWuufWwQxrHOfi+0H1ye1Qp+GHQLHm4+HtTpNrkR3DyxSyhRP8hr4LbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZL7nQld; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZL7nQld"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2df83058d48so45398451fa.1
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488788; x=1715093588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54dqPvbwT8028Dw9TRygCGwZe1M50J+Bz2yhm2amJuU=;
        b=cZL7nQld7tUcAO3KFpHrGTsmtBbOpEqkQlv4U3GMTAYWBdZ5s2Mt1NguzULkeLixgp
         eFzHneIUGxuxyJN51KMelydpRjEVJgaQrpdvFpMroogurEsr0RuCACj9nkrjuds8H2Vq
         DKpcYZsMBQZKDKXjDB6U2GOSZL6EabrGxunE++AvY1HZKUNAOgelpWsCeB4tn/gFQ721
         /LK9v1bSweKniZj3sMeq46fQ5b+gSBTkHIu7k6pK+ucbsiy7zdzlGrPbO7Zy+3MTa0Uw
         jo1epjKYUtn6ZjvL5GBYjI6qenRPsNIU/ny1CbsOIW5ESUcKfUEKGHCuRTJJA9xek6Fp
         ZTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488788; x=1715093588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54dqPvbwT8028Dw9TRygCGwZe1M50J+Bz2yhm2amJuU=;
        b=sJvD9+UzvFvZqzEBeQZIwld0dHalxR2c2y6b5cCelVoQ6091UnxeG919+MZb81WjA8
         1lZAGpbNIY0CclEa4KNO/4RftaSwC7QaIuoBvdk4+2CCLt8dUpPn9Pfe6TxDlsokBeDJ
         yL3K3EA2TzJaDYGeEJe53zeeD37ZDA8clfsM5N4+2FcQk8NrDI8yUxv/JXZARDp0Ij2u
         tjZuK0CRjtsWF9xIbQSngIitsx60EOs0+eKc6sgUfpUDjOky/VGk+LpqPkiGXbaFQ1qB
         hJNMZjLdNXCtDVHOiFXly0R5nMCoImkZiU4Fxy53c5dD/XxzbN5d3WGIeEwSPaEN1zsv
         reJQ==
X-Gm-Message-State: AOJu0YxzQexuyvOaNj2e5XyxqVW7m8nm2HMK8vUEiZQVjtlXLIWBo090
	lVC0+kKo69s7DGOJnkqONA94O88gqwGyt+bMUoFd1JL0PMsxx8yhs0Y5AsExrcEI9hTRc5hlAqG
	kxpcXICsOV5o9q72V8+Ci8QSaldEqTw==
X-Google-Smtp-Source: AGHT+IGB+H5ZSOrZ8VT9rlBln7/6jmO543pdvhXuMg7bgTDfMRYERu7Fz/vcQ+UaMyFz6bls+okDlAlXNEiiqmGHuFg=
X-Received: by 2002:a2e:88cb:0:b0:2df:b2d5:590d with SMTP id
 a11-20020a2e88cb000000b002dfb2d5590dmr2151451ljk.10.1714488788273; Tue, 30
 Apr 2024 07:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de>
 <CAFftDdqRZcQm4kW8+pAOYQDQ46Ze9Q0zzpqsKYi9KNz-1wduTw@mail.gmail.com> <CAJ2a_Dcy-WHrV5FY3FHLTFBuJErKhwfyFc2R4CjZsO2PHYJ77Q@mail.gmail.com>
In-Reply-To: <CAJ2a_Dcy-WHrV5FY3FHLTFBuJErKhwfyFc2R4CjZsO2PHYJ77Q@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 30 Apr 2024 09:52:56 -0500
Message-ID: <CAFftDdreHzHTjpFgR5Tf_XF627Zrr5TabYC7ZLr4r07gQ69iaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: free empty scandir(3) result
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 9:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 29 Apr 2024 at 22:35, William Roberts <bill.c.roberts@gmail.com> =
wrote:
> >
> > On Mon, Apr 29, 2024 at 11:39=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > In case scandir(3) finds no entries still free the returned result to
> > > avoid leaking it.
> > >
> > > Also do not override errno in case of a failure.
> > >
> > > Reported.by: Cppcheck
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/src/booleans.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > > index c557df65..1ede8e2d 100644
> > > --- a/libselinux/src/booleans.c
> > > +++ b/libselinux/src/booleans.c
> > > @@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, int =
*len)
> > >
> > >         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL=
_DIR);
> > >         *len =3D scandir(path, &namelist, &filename_select, alphasort=
);
> > > -       if (*len <=3D 0) {
> > > +       if (*len < 0) {
> > > +               return -1;
> > > +       }
> > > +       if (*len =3D=3D 0) {
> >
> > Changing this will allow scandir to fail and it continue, what's the po=
int?
>
> What do you mean by "continue"?
> The function will still return -1 with errno set if scandir(3) returns
> <=3D 0, like it does currently.
> But currently if scandir() returns 0, we currently leak the pointer to
> the empty array.

I completely misread that, my apologies. I just mocked scandir for all
those paths
with the leak sanitizer enabled, lgtm.

>
> >
> > > +               free(namelist);
> > >                 errno =3D ENOENT;
> > >                 return -1;
> > >         }
> > > --
> > > 2.43.0
> > >
> > >
