Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A82777F3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665173; cv=pass; b=Uwau8zRV2les0DKxirYeW0vn9NBX5rUZkSFSzA8DDcC5vZ4gJn4LG9OZmEVbkBqwA2XAokEO1J745HZfsEkz7eIDKKQZiIFR45PgkfJJduBEOh0wxoKo+MKldnD7IuTc7knM9pAX+jmzmNv1qKUAmgXPe/vXN2XYMYSzgnH71pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665173; c=relaxed/simple;
	bh=sDnyQ2liAWJcRZiawe8Y5OAn46Epl0YbnCd15KuT/+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv/jumKVAzANPTdLsWdQ4reQVRjxpLgkjhwV+4aDpGjHlgMHQf5Od3qzy63nmXFTzsp5M3ko+wVi5jJsIh9e5m9o38QJLgxtHmtuF9SD8pb3bxSRgnxk6h9omcLbpR7NlUUO7dKpkaPMgDBvI27IhD3qv06E01WDRoctT4ediyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt74NEN2; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt74NEN2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa5be9ab1aso1849625e87.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665171; cv=none;
        d=google.com; s=arc-20240605;
        b=exmoqqxwB9dvNZd5fR1P/sKs0tt2V3RbyOyp4jucoEVjueINgGL3VQUYPktjkn1Tgd
         ye8OXhof+2onZdfF2rMnM+7Oypi6SWjeXiFa37yUYiTuJWowxnniJJTIRGKRKnb4xXNp
         avXZAlZD70PhLiLi8bkKX5Kxp7bLL1VsXpNzn2+wKGGe9RB7AP1gzDh7l96UBUOpogBr
         3VD5LDcGHTTqb3kRAmXpvORL7Vq0UEOh6+SvdXb/sa1FByNPKZC8wgO4db7GX1TtC8wD
         qBuOqGb3ffKHBWQV3iurXm6toaq1fQsmX5GmnK6mza12ykdEGS9/YPX6yU7qwQDSJGFa
         DfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYreASAPxrBDgEDuRAGNk76HGqXBvnp5pqmMd7AGq00=;
        fh=joCR2V4dVPUbKLux/iuNHx+fVWZJKpIKi68CgNfj6nE=;
        b=fguomfvt5mqwexSDSkZ6jYZTZ9Nqrylz5lYXOheJT8E2EBQM/siPCesWtwx9FEsVw3
         mUiKfc1pQAC28HXRZRdt4Jk0+9nXUoDmtd03E+atCcR90Q9Z41fUSP8wAP7EEMbblrHA
         c7noMgss6P2U0z1StIQrkcAiZiSuj5KEWHNIeX8r5eZMB/0MoBT0erEw2QxGBIELWSVk
         ut3WYOxd0WSOnM84SG4Gao9+lIg5iqdKUXRhpOk2gef7VtkVlL1XbG8tMB3ggPnxhaQL
         hxCaxAbyUmW96+WoIUYmTml6psTH2L/8AucWUpwfsC4OuvgmN4Qgc0v19mtpghYy93GN
         rWcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665171; x=1781269971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYreASAPxrBDgEDuRAGNk76HGqXBvnp5pqmMd7AGq00=;
        b=Kt74NEN2of0+rb4CMbroo8Y8NKY8A4H90DAKrZKWxNLToxmNr+wRLWf5JgSxWhM3p+
         QNlTWQHIW523myE1OfdDxVtiumGj6H5lvYC0BNMjhWhwzSGJI8OskHZ1EReLjYrNxtKR
         8xQpkzN32ZxcLZqpCbkJe6HeyY9FHaVr++xC4IT5qS75cvrgqcvYJUt1ag0rYWourp72
         X0TBop0QvounE5YWVouFjf4zVO+8ZYKPJAV/H27mbV4wBAXWd4pamaR0fqJMc30jqtAe
         PX7HfMxuB8wIwLN8mS1SAaN23IhzJoPV0Z56hGFx2q/YsTlPdvbdBhDaXEDeUQIbGDcw
         JLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665171; x=1781269971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYreASAPxrBDgEDuRAGNk76HGqXBvnp5pqmMd7AGq00=;
        b=V6Y4SIy1T2lCjX8Cj9+OsV+NY0FS9jHKFSQL9RbR+XR1J9SD4/eqDsnQJet+G2WAvG
         397dHw91exuh6mPdgSbzb4gFppcqtE3Jx9Xji82lUDOv0xfmuA/hzZIEOypRTcILUWKh
         AbknUlgbubMLPhtS6hIEYVVWIaabt/9EUcDVdJ1NIFUyH0nevvNYFVrV6veVaftxpheO
         eC6G3J6EztX7gFC5vE2K1i7gU/JpjkrJlZtCOJ99P93IcJnzUpgN7c85W1cUdo7egoKu
         Gu8vgdzuqazYA1ifCHZeeSHx4GCz+NCIhiborfxdBg+iEq0SkC+Two03m+crOLnloC34
         2pGw==
X-Gm-Message-State: AOJu0Yyajla1joDipiqt+2Trjk3saNZXYEXAqxi1U1G63XawPieyDhPj
	EL3/7FS0yo20Vl2QCrFQweEPiMWj8IIkVqr+KfKxst2mlKs1bEopuuksxFltjzmgvqmkjZAPjEd
	8PfhdPKd+cus5zw7Y888a1/R3nI6ucC8=
X-Gm-Gg: Acq92OFaTXCFTn6rqHt6EaGfNIDnDm4kQ+A6ozPm/GZDTrEsUUOQYf4e6AdTFdeYwab
	m0xjPj7vgX2RUf77rnvEyk1nD5VzVR+LdI0tS1qLgIYGBXePdWpPFDB6IYZ4Hdu+hJqjr0nZ21/
	OfHRrXEE+sxIQQYuQwtp6agY62REggvBrYdSAwCcRnocLJ3q3VKCZiz/xIG15K4mjNcrqW6czEy
	J/KlZSHQRaqRzMs4QI7OSlMxIrLLa3dRxfcLbhjypXQOLyqv//eETroVC3kWXJfHChu4Gj0KVws
	yuOSnAE3Ld5YaJgC29YxOxR2cw==
X-Received: by 2002:a05:6512:3503:b0:5aa:6c7c:65e8 with SMTP id
 2adb3069b0e04-5aa87bdd028mr1031300e87.23.1780665170478; Fri, 05 Jun 2026
 06:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604155319.16844-1-jwcart2@gmail.com> <DJ0EJVG6WHK7.1LTNKAF5YA8BQ@posteo.uk>
In-Reply-To: <DJ0EJVG6WHK7.1LTNKAF5YA8BQ@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:12:39 -0400
X-Gm-Features: AVVi8CeefR6VwdUrr6M5ZgvU2aADk-mEP5Bf1fVVCDnM392xoFq-fCicnZgwMxo
Message-ID: <CAP+JOzSgaV7r1WP-a28L5WX+uF_eqxtDz+yDiYAKpo3LjquCLg@mail.gmail.com>
Subject: Re: [PATCH v3] Have clang-format ignore auto-generated files
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:23=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> wro=
te:
>
> On Thu Jun 4, 2026 at 4:53 PM BST, James Carter wrote:
> > Add .clang-format-ignore files listing the auto-generated files to
> > ignore taken from the .gitignore files.
> >
> > With the exception of libsemanage, place the .clang-format-ignore
> > files in the same directory as the .gitignore files. For libsemanage
> > which has a .gitignore in both its top level and src directories,
> > just place one in the src directory.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Rahul Sandhu <nvraxn@posteo.uk>
>
Merged.
Jim

> > ---
> > v3: Add missing newline to end of libsemanage/src/.clang-format-ignore
> > v2: Use multiple files instead of just one in the top level directory.
> >
> >  checkpolicy/.clang-format-ignore     | 3 +++
> >  libselinux/src/.clang-format-ignore  | 3 +++
> >  libsemanage/src/.clang-format-ignore | 6 ++++++
> >  libsepol/cil/.clang-format-ignore    | 1 +
> >  4 files changed, 13 insertions(+)
> >  create mode 100644 checkpolicy/.clang-format-ignore
> >  create mode 100644 libselinux/src/.clang-format-ignore
> >  create mode 100644 libsemanage/src/.clang-format-ignore
> >  create mode 100644 libsepol/cil/.clang-format-ignore
> >
> > diff --git a/checkpolicy/.clang-format-ignore b/checkpolicy/.clang-form=
at-ignore
> > new file mode 100644
> > index 00000000..f6b7b435
> > --- /dev/null
> > +++ b/checkpolicy/.clang-format-ignore
> > @@ -0,0 +1,3 @@
> > +lex.yy.c
> > +y.tab.c
> > +y.tab.h
> > diff --git a/libselinux/src/.clang-format-ignore b/libselinux/src/.clan=
g-format-ignore
> > new file mode 100644
> > index 00000000..001f20b0
> > --- /dev/null
> > +++ b/libselinux/src/.clang-format-ignore
> > @@ -0,0 +1,3 @@
> > +selinux.py
> > +selinuxswig_python_wrap.c
> > +selinuxswig_ruby_wrap.c
> > diff --git a/libsemanage/src/.clang-format-ignore b/libsemanage/src/.cl=
ang-format-ignore
> > new file mode 100644
> > index 00000000..2d2d8e8b
> > --- /dev/null
> > +++ b/libsemanage/src/.clang-format-ignore
> > @@ -0,0 +1,6 @@
> > +conf-parse.c
> > +conf-parse.h
> > +conf-scan.c
> > +semanageswig_wrap.c
> > +semanage.py
> > +semanageswig_ruby_wrap.c
> > diff --git a/libsepol/cil/.clang-format-ignore b/libsepol/cil/.clang-fo=
rmat-ignore
> > new file mode 100644
> > index 00000000..3eb2902f
> > --- /dev/null
> > +++ b/libsepol/cil/.clang-format-ignore
> > @@ -0,0 +1 @@
> > +src/cil_lexer.c
>
