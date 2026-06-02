Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E039184A
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412533; cv=pass; b=dt+yED65nxDrhz0ChZDGlq/qNGAaZiCYhUn61uuDC6VbjP2Fz5Y9jdfPIRC14VA49RH4/zg8/T14sj/1mF3/4wGZOpZ5eyhLHxS3WJnbJLKvlq/hJROn88GnsCVK7R03M2aRWldCLypwej3FBOMKLJA86pxXlU8bufoOaUC8mhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412533; c=relaxed/simple;
	bh=UrBsigNF4K2fW6WOsaXUfXIGLAFOsVelgcEHZUMfWbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOMZ8i82xiNGqu1+l3xbGJsul7atVIcNJAlozlcj6y5xpAkimIP6uhoV+MxNAngshp29xMXj1L7k6PVDO4h+dFMDZfOax61PwZkU/AecOQgry+Nc+CiB+sg2sTqb3SZh5eDFlFiyW+wurV798n8V9H9NuiazPvsGI2ddLTa+tmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au3cc1f2; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au3cc1f2"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39666f49929so31415131fa.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412530; cv=none;
        d=google.com; s=arc-20240605;
        b=DD34hDTB6yP690vmYWIEIyk3/8lcRqtVEwB0I3qIPrkyu/VwWQGZYdlgP7Gc1YXTXn
         al7c6HTw/92K6Rs85L+URMn9uKbFF+6u3SwedSqo6GP4WQYkwFWiILy30CE8FdLVDQRf
         bvq+rVrXV8LDHG/ml8ZIFV1hT89w0tNjfP7QzbP0jI//cYTjG2ZqGDH1JDd6h+8fKbtY
         zwwORMiEPuPFmh/+OV6ypCfM6cQpY6s+0oB2KCNenjOzu+vxzyRoPHKKxzLsYoFOx6Zo
         /e8dFmeVK0L1kyXCLhnASqZ2XnlBRE7jcRpJZOLJmLnsJwMIoNnoTlWQYgQ1HHqWolQO
         6z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wh8eai+F1de30FLn8tLXbCB02TH3T8bHHpoxWJgSWNY=;
        fh=XEQX1ukuS0VaRaMvKWRjQd63ZnK2MAYxTX2RXlDrqj4=;
        b=bxgZqv/IQkgtuwSC6aLeCJ7m0I5z4lM4YC8mTdoKIRHmasd4kBgwbCKLR/E4lI7sRP
         QRFnH4f+z+13Z6D33uRvtZpLrtPEb4GOvTwlq1cXLmgRMWXaALq10cZXYjm4dEFT24NB
         0YMRTQO/CEtyKrjgAR/vnFBuTh/vbfn+5/e5uV3Wc3XpEE0RXhmOvy0eXtpy/uAnVJjr
         0XcNNOCW1/dGR42p7P15ePpyR0/l+BZ7dfOshx0OEGkx8p4hyYc3i2Ut42OLEqg4S1yn
         /XEsFrHdELV4G15XkJ+5gB5dWcpTAfial3qsvvATv8KwH+ZkobbfT3BUpjpeo/vbeVNG
         oO4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412530; x=1781017330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh8eai+F1de30FLn8tLXbCB02TH3T8bHHpoxWJgSWNY=;
        b=au3cc1f2teBcZarQr1vaRh2ImTlIGDh3R7oiACn0IlAkWI6vS/KkCEqiZ1/dwr4D/Z
         McvpcsL88QtSr+TNiRqlNXa+ocvEcc2PyRlRt7fMa1kUwMaS5eCykgHVFjvPu7AvA19L
         KVRN6QLLm3UdcDbAsV5xc3SqhGEoc8JfD5Z2GgtbphZ5AWn3xiymD9ccqFvruOiYHVen
         CrEr42iMwGmOOwareECwDIVVzHBrNYT0HH0lRzAA68fFsHqkHajy86lH68kHYz7j+vPC
         g8wRkulzagc/zVceKqbUeiWuLGKd9GzB4a60GVF3vWvw+9i/kH7l6bNiJ+L6qJ6N6Dqu
         KgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412530; x=1781017330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wh8eai+F1de30FLn8tLXbCB02TH3T8bHHpoxWJgSWNY=;
        b=VR8zbDwbOy/Ty/CrEknEkupqFc51D4QeYyn9XxYjpjh27Q6LEJ1l+YTMaZHJP5wZls
         UVL6CFQKKnR9KjJwsPZ/lbjhYnCyhUGayDNheAnJQgdLUzlagVOwE+1iY53K72cZPMlH
         qc0k3yPLm63NmsLuBD5l6238HCMMEmS+6ieVPoOSfQ73csHOcAQP+XIAPL4msqHWuA4x
         YiZh4+dEdrkYjGYFamjBGVcgldJN5k4EDF6KGOaFeYnkL80JPeqWeRjnvpR3byzt9oCp
         Z3Q6vRgLBQ2/mbmkBlP6zz21LnejJSj7E5KfLHT1vMp2jR3xrgCMrkW+cs7zCztaEEah
         yjqA==
X-Forwarded-Encrypted: i=1; AFNElJ8wp7WhTrQYS0nUeEEagoOiySjYCSLSc5OaVJqoig3w7pT9qb7nrIaYEO066HOiVAx1jD/JeWre@vger.kernel.org
X-Gm-Message-State: AOJu0YzGX6+NnuDTsX03SlIE2/o2cLJ9vWG7agm4NFpQUQRacMczDrbk
	khFsHG3sPctBrI3DsP9JKf5YyF7/ROOdA/9sDSnIGYxFKykmvjMYv7il+SCxqowXvaiWa8FO3EB
	gt3wbXbREk4JJmm42vo1n0sUhNmsWaZ4=
X-Gm-Gg: Acq92OFVr740cEvMtKjvYlOgxfpKZdwQTSYEZo3bQGTW1UP1izljOL5hrae6stLXg1R
	nxmbU87O8NdGovAox6uEFz6miBOPw7IpZXij/5jZNAiY3DQCYNd/mJ6xc4nCnmHfkdYe9RlPOxZ
	ppnyP1ZrX4/g4d1FlJYpI9Ouqifm9Sa9/HjAy3wTEJ8YE9bKjRecBVcZ7iqJruOKWzaXb0IaZrW
	0e7TRLqiBYB1aSnVHR4EmHbq3RZIj/K5m43gzKfFeI0pIDUUlQtKVpGHb6Y+abwGqxqceQAgMti
	x9RNWLlkOI1eAlyCIqIKAPsHTg==
X-Received: by 2002:a2e:9a14:0:b0:396:a4ef:440e with SMTP id
 38308e7fff4ca-396ac2d9d6amr365591fa.16.1780412530006; Tue, 02 Jun 2026
 08:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602095844.115761-3-cahu@suse.de> <CAEjxPJ79SKgcRt5rqpkP0_KYvVoWKyNiJ2V7rUDEnvV6S=GDaA@mail.gmail.com>
In-Reply-To: <CAEjxPJ79SKgcRt5rqpkP0_KYvVoWKyNiJ2V7rUDEnvV6S=GDaA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 2 Jun 2026 11:01:58 -0400
X-Gm-Features: AVHnY4IDviXBQHd5SGW6Vi8DhGeNbW58P5Aol59WovzHPnwRWRks_Ufzs8EZX9E
Message-ID: <CAP+JOzRiEUoBxukyTk1V6G4QJ-jDzrRcHdc77qBcQyX5mxQa9Q@mail.gmail.com>
Subject: Re: [PATCH v4] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org, lautrbach@redhat.com, 
	fvogt@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 2, 2026 at 6:00=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > We encountered race conditions where the built order was:
> > 1. libsemanage.a
> > 2. python-3.13_semanage.so
> > 3. libsemanage.so.*
> >
> > That happened when make was called with `-j2`.
> >
> > In this case, python-3.13_semanage.so tries to use libsemanage.a and
> > - on s390x: succeeds and builds an incorrect python-3.13_semanage.so
> >   (that one was found during product testing)
> > - on x86: fails (manually reproduced, never encountered IRL)
> >   Reproducer:
> >   ```
> >   cd selinux/libsemanage/src
> >   make clean
> >   make pywrap
> >   find . -wholename "*libsemanage.so*" -delete
> >   find . -wholename "*python*.so" -delete
> >   make python-3.13_semanage.so
> >   -> fails
> >   ```
> >
> > Therefor hard-require "all" when DISABLE_SHARED=3Dn
> > so that LIBSO is present before SWIGSO and
> > probably also SWIGRUBYSO.
> >
> > For SWIGRUBYSO switch to using the first requisite only
> > ($< instead of $^), as it should not include "all" and
> > $(SWIGRUBYLOBJ) evaluates to one item only.
> >
> > Signed-off-by: Cathy Hu <cahu@suse.de>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index f870dc68..9199bd39 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -82,11 +82,11 @@ $(SWIGLOBJ): $(SWIGCOUT)
> >  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DS=
HARED -c -o $@ $<
> >
> > -$(SWIGSO): $(SWIGLOBJ)
> > +$(SWIGSO): $(SWIGLOBJ) all
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ =
$< -lsemanage $(PYLIBS)
> >
> > -$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> > -       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ =
$^ -lsemanage $(RUBYLIBS)
> > +$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ =
$< -lsemanage $(RUBYLIBS)
> >
> >  $(LIBA): $(OBJS)
> >         $(AR) rcs $@ $^
> > --
> > 2.54.0
> >
>
