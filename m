Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8F1DD0F6
	for <selinux@vger.kernel.org>; Mon,  6 Jan 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162254; cv=none; b=a8PeS4ud1sGty1v/mdD0nFzKJI1N3WgLo/FkvFHPTnlCszY2u7j2ZKZL/+6TgLJq4JbvFhucYrGxqKlU5Qmr22mTDVDVaiZnGCG9KJj6qM+wXJIcyceHvQRu0JLeM+l1eOWzTMQhHPArSF7EBwlpdS5D32S5PIuRau08iE2Hf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162254; c=relaxed/simple;
	bh=vbFJM5JPT4vIPscFSEcdmjn6jPbv0ePlAGtqF2sw9m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRihw+05fIP/qa7rTWWK7K1zXeAXJ1dVQzA+hTqPMaVH8pLrvjjA7BojtFfk75TSAqrArs5XHwAWYOpFKQ0LOySKC+oBXzxukpXyL8wM7ybMNJvZycZqpm5FqtZFpJ54SkecUKftDM02OvSDVEksU7ANbdowjYX9ueLs3OH3V3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfX9E6Jz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfX9E6Jz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736162251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfAnqIXQSt9iNt5fICKjZAzDrmXtLfOJN0G9zJ84BQ8=;
	b=NfX9E6JzUU/VW7Xyn/hPthEVcI6JFxyl+rEAFxtuU6759WfihdtxFKCp95M4QF4Bi125ms
	+AybUvAB9iRPokmgF4LrgYnGSQb4g3OJNMaPfciKwA9DwAGjeyWkXdynhcrTvOoEMZuymS
	jtSiFWwZ9i6ZpqTY1Zr19uBB1p6W0gE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-UFJMJmhjM9aV5GQ6Ps9ghA-1; Mon, 06 Jan 2025 06:17:29 -0500
X-MC-Unique: UFJMJmhjM9aV5GQ6Ps9ghA-1
X-Mimecast-MFC-AGG-ID: UFJMJmhjM9aV5GQ6Ps9ghA
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2163d9a730aso195153625ad.1
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2025 03:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736162248; x=1736767048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfAnqIXQSt9iNt5fICKjZAzDrmXtLfOJN0G9zJ84BQ8=;
        b=QT6mPMPwWJ5YIhc5/qxNvoxp42FJMuskDEEjgNCe9qhA7EKF06DBx97SLYPngY91Z1
         vFNpyaU+2cu3BfTeL91U1jcRCVCd+kSaVEQYspmWjKUUEWAdSuZm2zqF3emt8xel12zB
         s99H8bEQSM+QvppgPV4Bb76B8OQ9L/T2S1IbYTQ4fLYOjhATWgt75ITbSGiX2AWKggs8
         QkON1aCcUAH8+xVGsKEio+3AgLnM5joX25c24YUMRcpMx/4qc8RdVnCpevaqMeTGdcjP
         IROh3JXggVTOoJ8xnQvdq52lyrHRTs32dLM+Mk4XCFVWiPEi92bGZYq8112bH3+YrzaV
         ojvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFUbr9865EpTOPDhcg5lKvV16SiHuarOJMKvpi0Axe522mD6i2rUa+at9y8cOxFrmZ6i4W/rUG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyja4skQlDDt3m5QVaP+Cxpl05bkQOyS2z9NARg3Vs17qwLfTft
	mtw4Xth7+NcOPgTVNi+D1LlJNL2OzJn0ZgLQp6c+A52iJCWS/8z9hVY04hkgF9MS+Y4of/lkMWM
	w/+mPGCeWXQUIjuZzI/nMaT4oezTLkh+OEusVXjJ3ahGRIZWyZq9qIsmD/ViF8nrFIqGFrrQRJs
	tMcN6c/UckjmrvGHPh1vRstivBpPERiw==
X-Gm-Gg: ASbGnctOxlisregqufLWoVa3nX5saj/pA0J5RrB3AM/k9VEi4xWj+RTWETPtRZCLGIp
	5e29RUMpE5KWBr1PkO89gUhunSg0Aa1Ma/+59FsFeMmlpjPSyMw63p2j8Ul+6bg+m00bOHKo=
X-Received: by 2002:a17:902:d48f:b0:216:5cc8:44e7 with SMTP id d9443c01a7336-219da8002c1mr928924585ad.25.1736162248677;
        Mon, 06 Jan 2025 03:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvqbSPonms47bRHEhsajEQ68Sw/OBkJEppK7ExhOKk+NW2P+o0AP88/xQrW3KUI6kkdYJzNpIdFIDitokeC6E=
X-Received: by 2002:a17:902:d48f:b0:216:5cc8:44e7 with SMTP id
 d9443c01a7336-219da8002c1mr928924365ad.25.1736162248376; Mon, 06 Jan 2025
 03:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128152851.14704-1-cgoettsche@seltendoof.de> <CAEjxPJ44D7kW9T7yxDVTsjzqTXnSqELFo=2GEmPu+iWN1bUNRg@mail.gmail.com>
In-Reply-To: <CAEjxPJ44D7kW9T7yxDVTsjzqTXnSqELFo=2GEmPu+iWN1bUNRg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 6 Jan 2025 12:17:17 +0100
Message-ID: <CAFqZXNsRmj+pzLZ5J-vcYdmONqyrCuSsNjfxFb9Fqx4XkzhKhQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ioctl: add test for conditional xperms
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:16=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 29, 2024 at 5:56=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Add checks for extended permission av rules in conditional blocks.
> > Requires policy version 34.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> One minor note below but otherwise you can add:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, I applied this patch now, including the comment move:
https://github.com/SELinuxProject/selinux-testsuite/commit/e8ed44c4ca6cce67=
3529e206e6dfed15bff22af4

...along with a patch that allows for the new tests to be run in the
CI already now under the secnext kernel:
https://github.com/SELinuxProject/selinux-testsuite/commit/86d604261a29035b=
a324ef1ccec1b26a2ae56fcf

> > diff --git a/tests/ioctl/test b/tests/ioctl/test
> > index f313f06..6c33bf5 100755
> > --- a/tests/ioctl/test
> > +++ b/tests/ioctl/test
> > @@ -62,6 +68,78 @@ if ($test_xperms) {
> >      ok($result);
> >  }
> >
> > +if ($test_cond_xperms) {
> > +    #
> > +    # Attempt to perform the ioctls in the false configuration
> > +    #
> > +
> > +    #
> > +    # First round with boolean set to false
> > +    #
> > +    $result =3D system "setsebool test_ioctl_cond_xperm_switch off 2>&=
1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifnam=
e 2>&1";
> > +    ok( $result >> 8, 7 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifind=
ex 2>&1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifnam=
e 2>&1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifind=
ex 2>&1";
> > +    ok( $result >> 8, 7 );
> > +
> > +    #
> > +    # Second round with boolean set to true
> > +    #
> > +    $result =3D system "setsebool test_ioctl_cond_xperm_switch on 2>&1=
";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifnam=
e 2>&1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifind=
ex 2>&1";
> > +    ok( $result >> 8, 7 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifnam=
e 2>&1";
> > +    ok( $result >> 8, 7 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifind=
ex 2>&1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system "setsebool test_ioctl_cond_xperm_switch off 2>&=
1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifnam=
e 2>&1";
> > +    ok( $result >> 8, 7 );
> > +
> > +    #
> > +    # Third (control) round with boolean set to false
> > +    #
>
> Shouldn't this comment be moved up before the setsebool and test above?
>
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifind=
ex 2>&1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifnam=
e 2>&1";
> > +    ok( $result, 0 );
> > +
> > +    $result =3D system
> > +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifind=
ex 2>&1";
> > +    ok( $result >> 8, 7 );
> > +}
> > +
> >  system "rm -f $basedir/temp_file 2>&1";
> >
> >  exit;
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

