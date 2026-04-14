Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B11FF7C8
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188125; cv=pass; b=TmKMRUQh0JA/v3enjZf/cgBUoVPHR/kf/MhNpWifFw6T7qioTrcQuoqlJwxavwufMt3uvYjULiQIcUe3SDu3lPDqMVCkYbu9vkiP4/NXymjwyqfs4FxQhfnf8yVVFgzo9Z8SRQgpfRk4bDUQ9zDdhr9XP3WpgrUp/ld9zElS0x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188125; c=relaxed/simple;
	bh=8EpPQqIztsreVVkbe80/c8WwXfSvIR5Trq4SKDkIeRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8QUIhpMsg66QfbIVhJG+rmQL7vYl+BQqLTmvjseVfuD9f3sopUSQ0ONVetvNFzK8huk3g1qQnSOHaM0GIbuSmeNqtJ6TX+jL0NVBayXw7qKYFF8C9fP9VK7DorjwXxM3l2tB2EegPbF4x9+/a+vEAolYpCYiOQ0K4d6ZzvZ/nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foKYVcNB; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foKYVcNB"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38c620f1699so62758141fa.0
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 10:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188122; cv=none;
        d=google.com; s=arc-20240605;
        b=WdfoiEqLTLDMaIdwxCeU+FY7ItsP54t8cdOS+hZ2Ui2fS+NZ1MaEmU6mjC2CuW/ae+
         6tWHj037r8uOIElfA3npyHr5SXhzh77bYIc38mXdr57sy4T5Ao5/eAmWckuJtsFyQ+3e
         tNdbCe3c98E7lPih9P3fhWFrBqOlhAt0lQuwuNrpnZOgv2btJ5APxIZYlA3SBmmqA6Rs
         7f0py3RFIEEJ8GBBdhKbEtQVcuxmmnXk7RxyGZxf96bd5XjXVKlSrwaz4tErcMoxOeAQ
         vjfXv2EmofBG7O0cKZ24VAaCFpjStTb0MAjiFlO11WIFCB23w0VepYt4yeyexYrXVzfc
         FSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QsSriZCDjvJDySkvDOqBvw2L/NH+AsMo/KZt4iUtpVg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=hC28o7++xnXH6UUmj72konveRrMj9X2kfw3qNLaCSPArqQDWYK11EcZN4IpAwEYANv
         qdXz1v1uD1Pg+5SlMQTRbWeMlVw8hceo7WzDAZhuTqgaKbIySgQoMa3Q4lBge5NP/Ru2
         7eFw420/W//8mnwN6/v3DhdF/dwUEzfkxLZQ/IlEQz81h2M72Zgnc4iRjw1qf+LpQYOJ
         SOMY3gk+RqJF90hZ+nMO0kn9Y4yqBukQCz+qXj8Lm/J6CCW5ACazyhw7fZ1JBp+kCiM/
         7pjbn6ju3IYl4lihAYh8L1vLAs9z1hP4jJpUpvGg9ydD7NMfUbxSSEQk3MorZqP5v9//
         GoIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188122; x=1776792922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsSriZCDjvJDySkvDOqBvw2L/NH+AsMo/KZt4iUtpVg=;
        b=foKYVcNBksPBVwAvZeKU4YBXh1VstWHjoXLu8Fd+uN+RI8jGYxoDDw4Ose1q01t+W5
         mayCFbrZTjgYeXChvYrfHipxB7ozE4b2ki2Hy2A/7j6qdWgb4FuYUZFeXhK15Sbtk93Q
         9i0f6et7ed0BiZziRKhkRhL7MlBfYclyLCsIhPeUseBQHsWgbNKgHdqHSS4V9EslCfh0
         x8xSxFt+UrKLjaMr8FvZ4DhtDpy7FW+IqscB14wS3KFRTNQMJXRvyGt3CTVdectgZhQX
         CZ4CLlH8QIFET4iHZLoaai4Ya8M+Z/oXJwdv8Nbr5p/Qv35CvGRndPLYivbU1iPY9RPI
         t2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188122; x=1776792922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QsSriZCDjvJDySkvDOqBvw2L/NH+AsMo/KZt4iUtpVg=;
        b=Ge8vnjXtrPxufN8Q2Es4QGVL1Zv+lPe6gS17kcU0X6Zn98kDlKCgRdhpOV/+bJLLz3
         iwrxExDVWpr3XNOD1lwN8QOSOTnJi7glJmllF8BS71y9nI5MbeG2AeaxftWRvFJK4QXR
         6vBES0H5mfV86SJ7yLJPMJOlGufA9ZSt3GdYTNM4kqKAl8q1Wm0wG7DNOr8YpC8F2SKi
         QyGAzf5KQrh99WDdd9m5b3zrCXxVTMiAkIyhBBcS3WWwIzucvgzpt3GdoqkSbp/iFVRM
         4pnFeIEgFAOJGzKqw8LqgKtBf51DJXjTdGOD/PIhTsB89HBQfbU6iY46HOjJWUyt4C/p
         ocNg==
X-Gm-Message-State: AOJu0YwAn+5ELnV1AvLQIwrcWY2sOCLHqui1wqLOq8Kovn4xovDjdHbv
	EFAtGuShDFuXxqL5X75Ksm5o0p9PmhL/iLSMaAjDPVO/3ULxmn3W4tm/wtOijgySJoPlh64kThb
	aetcD0VsGAGzN79k3lAj62XI6XVCHJt4=
X-Gm-Gg: AeBDieuPuDUAqak8pw54WKbLkWNrSuYpNqnSFP33v9q9vnPuit5zHvafY81oYmLzLH6
	fIKCbTDXymylmBneoYcqfm2aCGcXl60mVeHMKIwVViVvw0aP2x6GCn0tm1wYILRafibhrUYmOVD
	bxwQTJ3MRi2SvvqZkkvRAhniasTGwEbjTNRHD1RxHdsgrkyooXU/iZMCmdc0CSi87tK4SqrYx5K
	1vecwAcTrGnORsft4l+nHIPqj+z8doc6x7AsyMn2BKD3UlPLG4SMXTsTFcqWiW2Iu5SaCNpEOYk
	YuO6
X-Received: by 2002:a2e:8615:0:b0:38a:5b91:ec34 with SMTP id
 38308e7fff4ca-38e4bff24f3mr44995641fa.33.1776188121524; Tue, 14 Apr 2026
 10:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202143554.97209-1-cgoettsche@seltendoof.de>
 <20260202143554.97209-4-cgoettsche@seltendoof.de> <CAP+JOzR72A9+vHZS8jDN=PFStQOZTLaeX3_2SJa0xMN8NJRjpQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR72A9+vHZS8jDN=PFStQOZTLaeX3_2SJa0xMN8NJRjpQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Apr 2026 13:35:09 -0400
X-Gm-Features: AQROBzDrzap1H659WfV_FWJdlbImt_ShKjxB--fI4BSILWc3M8zxxl-vuLD2DMU
Message-ID: <CAP+JOzSfDo3bxLZTe5M7KrfdZHZnr4i6N70r9qLsR+YrWchS_Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: drop unnecessary strdup(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:18=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Feb 2, 2026 at 3:59=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Instead of copying the digest and throwing away the original, just move
> > the original one.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  libselinux/src/selinux_restorecon.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 8fadf4d2..34927126 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -375,13 +375,7 @@ static int add_xattr_entry(const char *directory, =
bool delete_nonmatch,
> >                 goto oom;
> >         }
> >
> > -       new_entry->digest =3D strdup(sha1_buf);
> > -       if (!new_entry->digest) {
> > -               free(new_entry->directory);
> > -               free(new_entry);
> > -               free(sha1_buf);
> > -               goto oom;
> > -       }
> > +       new_entry->digest =3D sha1_buf;
> >
> >         new_entry->result =3D digest_result;
> >
> > @@ -393,7 +387,6 @@ static int add_xattr_entry(const char *directory, b=
ool delete_nonmatch,
> >                 dir_xattr_last =3D new_entry;
> >         }
> >
> > -       free(sha1_buf);
> >         return 0;
> >
> >  oom:
> > --
> > 2.51.0
> >
> >
