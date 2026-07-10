Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D7313E00
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705861; cv=pass; b=OQskuJd2aTLyhi/tIT319yC/t9MuBVt/Li8rKbD19W89kfv5HkI9g/ZzjBcqofjTHznRMMYwov3Bz5HWXGKDzb+8jyyooONV05o9fQwUveEl8PXdKBLMlIexYryzzF4zmneDz9X10DYohEZad1Ud94ORquG9w+T54BIpvw1bLqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705861; c=relaxed/simple;
	bh=ikPj2Ll1ZhHu6z0+SiP9kMhIclO3EVw3T+B9q1Gr96s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mz6eVUl9ObfPqMBmT7f9iYctRU4VZsGams/WENcJkrArvhyHa5egtA0V9+2+QeumlZ29eUfOV5gb20m0FH4Dj7/rytLiJFWcpi0tMZz2SVBfMdycguzdWKcPINjBUywuIfUjTo5NaCdI34M1UAuds2pGX3+qw95eeKQRYWEuIn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuciKZzK; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuciKZzK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37df72c9984so2104393a91.3
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 10:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783705860; cv=none;
        d=google.com; s=arc-20260327;
        b=eoOUbvKC6H6ZFO1wlkPCFakzf9s9WblxMztmNMNGRzqDPlb8YnwxYsG5qObUwBa/K7
         IWzZvhc7mbxZ4PRMdoOWI0V8f/LW2S/SnbVZLMc2iX1YcJQPPC/4qWMjTC4nNhW6gLrY
         NK3FOHn9QJmfbknKgK8/z4qSP0lVgiECFrZICx4vZtLiYGlbwe5CWTbAI2PpawH+MAKX
         57HTzqBk7bRhsp2Gs9mXRcv+w1+wtt6YoK+6eUba/YPQpTF54lvh+Rhp72XB280MrfAk
         Ii/Dc6jCZZh3beG58gaaQR3ArMBhKEU58uzbV6JWx2wV0SKOaBXPwkwm9JbEoOxXPIEj
         atmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eta4YmsTuVuEUd5SJ9wWs+FywmN5jEHpA06P3JddKH0=;
        fh=ndR9uipYWrQ+r1q19Nd8tVDoGZAQQciHAFAVcoXowQ8=;
        b=W1lwgXk7BAt0U58WK5cuD2rzkqNcmHdHEzbfU+9gAZMF6R95VQng+6UmMCTF73YP29
         vGMjIOsUGPJDxDvPkpkUXP+kdD6uP3iJmakUA/QB9hjuWM79ZXmjcl5kxVSVpD3pQuvn
         Gk/ksoShC/rQGHyH69CwKqvcY4pks4OWH0bIH4d2H4XBk+ujK9J7rvRI7AyzjUiwZDLK
         A3SLUw4SzCaSHSnPjwMbhUAsQ9FWnLbYMhdKwW2SDt3PNOWI1fwziXoU/umcxgNPZS0F
         tFJcfGzEyZnt+lKh7Mwfgu5iAJjfy+nOsLkzx0ZxlTyNcwXKf75Rc/PXKRdZM8sUEqtZ
         S9sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783705860; x=1784310660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eta4YmsTuVuEUd5SJ9wWs+FywmN5jEHpA06P3JddKH0=;
        b=JuciKZzK77tuvg/VMpoCBtg4ilp30OEwfBbljSO3/UHo68B8dkMj7iW6JWENMz14kb
         +lVUx4Uzh2JQ28kdRkm54hy8RcQN+XaWABt1SZi2IqaK0Qa1G/GMIyU5UxuUI6I85A6R
         e0sk6UUVE8wNPZw/bouerlPdaYFiut/YVt7h1oAE3uRh8lwh4yo1gJQbzfBbirRS9GAs
         hdqgrRoJOWRTSW+1eeRdH+LYdRpjojy8unekJBXxPjBRNJqBDPgyIOfsIRKYCqTA0HeO
         FV+M+sm2lbLGwMLAvmLsBmGe6N5llAd05SrBRJ+WGNaDdkfC/EN4jwyHFbuCXSqQO8kS
         MnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783705860; x=1784310660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eta4YmsTuVuEUd5SJ9wWs+FywmN5jEHpA06P3JddKH0=;
        b=tIN9A9kZnBcJZcDJJK+7i+/t8mCqRgHuU5RIH1f1BoYwQjSIuKPtoKXtRatlqkoN6u
         UKliQkNCoIoN7FvpuF3HhnC8GR3rr6aAv4T9JNGmJg+4QmI+MfxmeC9MFATHEsIoq8aC
         aJEUaBoXJbhFTGsQSG32OElNNyk+4Lp3IpzXvny9KojW7Dj1IvNXEzXISGIb/fAixZ4G
         NGcfE/44lEU8HWsjUp+G9sJmMI2lo/ZvS1sv3Q9GyhLmZ4tKDFSO6MQQeiAkzUZBFz4y
         Ccs49od5HIDLdcTk3DZxXFzLLzeiK1sevjN8CJZpqx03hVJrgyVdjBk+p5saeBY9bBTd
         ZliA==
X-Forwarded-Encrypted: i=1; AHgh+RohAGVOHJ3iLkDOwuWoLM6sVZH7pd7GH77XZ6a+IlBGDOh5tlE9353VhoC4pzrCQxIyFh6Q3loH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyxi0S7mheGeMaShQB47V2C1N9N3HKsJKcmJcpa5m9FjBZiJTF
	oIEPeNLrF5kP9m58zTiaJeIlPd3d9+bsjTT/OJtm20Zsnkv/YHgH+K2ykofWSGJlV1pEoIE7YdJ
	XCbDgm88CJmyERvi+wsBoV45j6cmxMq8=
X-Gm-Gg: AfdE7cn3J9Xw0qwIxUSaehh2KQE6ZmBwvBg+pIbkuaKFYeouLCFZnYLTFc9+yx/Z/9a
	y6AL2MGSSsu/2lIbwxdwkiinlwOgxvYuLY91knr026tpMbvI3aKYNDnp0SF4xquxHzUbc5vs7Gf
	1ECuUhAAHQ++7VO699PAQ/N2NigdsJzWYPmDfiqXtt8uC8ESYSba19Zp5qd59JdKfSjJYqSx7ZY
	nVKa0hA3NM5fcP1piNWhOsIefCh3IUqsgqsPMJ4QM1SMPa5sIf7UCMt7xGmwFT6EevxOGF9
X-Received: by 2002:a17:90b:50c6:b0:380:9504:9780 with SMTP id
 98e67ed59e1d1-38942498aebmr12280691a91.29.1783705859811; Fri, 10 Jul 2026
 10:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707121931.1175225-4-cahu@suse.de> <CAP+JOzTW=-B++YZ9EgXQW7aCDWvE2e51dDsr89NkYinh2mThgw@mail.gmail.com>
In-Reply-To: <CAP+JOzTW=-B++YZ9EgXQW7aCDWvE2e51dDsr89NkYinh2mThgw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Jul 2026 13:50:48 -0400
X-Gm-Features: AVVi8CdO33TUbshfkkLRlSZEWG91n4V29JweOe7m-LnMboxB6E_m_00KH5xW8cc
Message-ID: <CAEjxPJ4kQ3ZLatTo8tSBCEREj5cJU-jJjKdERGBx3yw8B1ay5Q@mail.gmail.com>
Subject: Re: [PATCH] Fix double-free in secilcheck
To: James Carter <jwcart2@gmail.com>
Cc: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 10:15=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Jul 7, 2026 at 8:21=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > If the file size of the cil file is zero, fclose was called twice.
> >
> > Fixes:
> > ```
> > localhost:~ # touch ~/.empty.cil
> > localhost:~ # secilcheck  /etc/selinux/targeted/policy/policy.35 ./empt=
y.cil
> > free(): double free detected in tcache 2
> > Aborted                    (core dumped) secilcheck /etc/selinux/target=
ed/policy/policy.35 ./empty.cil
> > ```
> >
> > Signed-off-by: Cathy Hu <cahu@suse.de>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.

>
> > ---
> >  secilc/secilcheck.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> > index ee141bc0..b7c32bc6 100644
> > --- a/secilc/secilcheck.c
> > +++ b/secilc/secilcheck.c
> > @@ -155,7 +155,6 @@ static int add_cil_file(const char *filename, struc=
t cil_db *cdb)
> >         file_size =3D filedata.st_size;
> >
> >         if (!file_size) {
> > -               fclose(file);
> >                 rc =3D 0;
> >                 goto exit;
> >         }
> > --
> > 2.54.0
> >
> >
>
