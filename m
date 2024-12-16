Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C71A270
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309306; cv=none; b=s3xuydAw1QMRwz+I04jSnRVumhhafIw/ishXJipL81bj3bmD/Ev397cO64cKU+yg6SWx9azhiU4Y12sU+6GZT9OyPEFcsNHDhJSqaUORK3YCPD0PgPIW0v1ySZCneLagcEPzWsCSV91pWOLspdQrSE0iWaHCBmmvTencMRd+9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309306; c=relaxed/simple;
	bh=hKxg223M3rnSxjbZVfj/D/Y62E8hQYFszvp6uZFM2Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQGL6gmncnNfTW6SusiOY9W060NBQz1tVtssgJWrX0/GAWEvs8k9fJGPeev7TviiAq88q45wZOoIpam0Cpb+eHYlZpl2vY9D/pVktkI1yB2r9LxXDh5JuGSGnx55kFtUYj1VNTXHX3TRhm5X0w5j+4fNlLbw/JnzTVm7PKF/vuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XYubFchT; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XYubFchT"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e396c98af22so2362323276.1
        for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 16:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734309304; x=1734914104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSFUCmBT18DCAcpEusbaUW83yJOUtzlizXtyO0yeTWI=;
        b=XYubFchTc3zTnlpowR37LyBR8sDINVbOdBmz5EHtIZKVihO7KobFKJl4XkTqJhejfk
         pVmNKGFO59HZG4hvB1eIH8TxlY9/ioNr7dzfVDnv7K0shICYS2IxC3EpERH7lq6IYEnz
         VzuJaxMxks0d6T1e6h5HtUh3JGjveehZYEWhEbHOscrFCbMaQbvct3PBstdQVaDXJe5r
         YoFtpXOGw62UymJaX1w2wH2Q+5aYeSvfSdw0Dbxs5C7jHX+YUJuc5Q6da+rQSrArtyLl
         F9lEjsXp1x2VG7q82xHrkJojExoqhIhD+oh6i6huAyTR776ZaffSzNNPx/SCBUqqxhrg
         A9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734309304; x=1734914104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSFUCmBT18DCAcpEusbaUW83yJOUtzlizXtyO0yeTWI=;
        b=iRbm1oaCF3xN/s/ECs+qCdaOhQyz72FNnIyAGPw1JI1ENcc18pl4e1sdPcY6cILogm
         2wCcEnBKd76OO3RQKbfAojtdgVThQwwSicFYEalY9ONnoZwvzE0YIQcXYSlycBSHsPcJ
         JXHmxFiJn4LVk3hKcG95bEob9taso9hiu5hsltgwdfAoSKHBpOJaT+8aa6HOVaOS+xmn
         ayOSaZmgN5M12jjJYKm79cu1gweeIf1Q3ZCnCzSaTdhmB65gzbGqNtgR3V17RwUTyrKT
         eKizAn662rYdDDjzFgzxX1uz9e5Xm5rAnn87Bo8TBvhOSbQnD7h1IcdOgMoGfhFr5r2Z
         3sXw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zoVV7asw17OiVDXvBj2zX4i+oLFWlA7R3attYwveLy0OdVaJ4TlKulRjWuXF1yUboRkiy8Zy@vger.kernel.org
X-Gm-Message-State: AOJu0YzVy89XJPhxSXT+rb/3QXYJ/KHYvOD4T1UkuXg/YU7yXeh8JrjI
	3ZEBawBUKjnGfnwaW5rcGbMZPxjcfuIXF6vv4XZad6HcSkq4nt5ALIVwJVP1v9vjlImGInvcXzr
	85cPIksCtVn+eqHo5EZ2wW6oNLZEDKzgTzcJ+
X-Gm-Gg: ASbGncvIQwawekqJeKAosciMneDMlDQf/rkAtLPcx7xP/9jW04kjILGnSkwDvKqO1TT
	jq29xOdISadwy/iW3oEhg9A1/thboko0zaVt7
X-Google-Smtp-Source: AGHT+IGaA5YdhVMR13mgkyHROL/LEXH/1L9NjvoERC9WRoltCqNzsD5kGvlkkNbKASjd4SFIxtc8Pur7EAgl0fLQ/qs=
X-Received: by 2002:a05:6902:2084:b0:e4d:18cf:481 with SMTP id
 3f1490d57ef6-e4d18cf06abmr1656488276.28.1734309303875; Sun, 15 Dec 2024
 16:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205012100.1444702-1-tweek@google.com> <CAHC9VhS=_ZExOUQAiYEwkTEnpT9xNJsj7g7L6HMH2odWX5GxUw@mail.gmail.com>
 <CA+zpnLd-HSmfihtNUii_NQjrW5HhpVi4s4OL39ARBF_827E8AQ@mail.gmail.com>
In-Reply-To: <CA+zpnLd-HSmfihtNUii_NQjrW5HhpVi4s4OL39ARBF_827E8AQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 15 Dec 2024 19:34:53 -0500
Message-ID: <CAHC9VhSs4hhEXMMUZ4gVigcP4CZ4HPT_tM=kx_TAFa27bZHtmg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add netlink nlmsg_type audit message
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 6:20=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
> On Sat, Dec 14, 2024 at 8:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Dec 4, 2024 at 8:21=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:

...

> > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > index 9a8352972086..70444230e56f 100644
> > > --- a/security/lsm_audit.c
> > > +++ b/security/lsm_audit.c
> > > @@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_b=
uffer *ab,
> > >         case LSM_AUDIT_DATA_ANONINODE:
> > >                 audit_log_format(ab, " anonclass=3D%s", a->u.anonclas=
s);
> > >                 break;
> > > +       case LSM_AUDIT_DATA_NLMSGTYPE:
> > > +               audit_log_format(ab, " nlnk-msgtype=3D%hu", a->u.nlms=
g_type);
> > > +               break;
> >
> > See my follow-up reply to your v1 patch.  Assuming no objections, I
> > can change this to "nl-msgtype" when I merge the patch; is that okay
> > with you?
>
> Yes, please do. Thanks Paul.

Merged into selinux/dev, thanks!

--=20
paul-moore.com
