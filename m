Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312820FAB4
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285650; cv=none; b=jh6CZCzCrRwBSAJsFOXJkNYN58YoaxFSPlMbM4Nj3kHVyS+qpqwlCk+jx1C7QMGvQCV2znAIYkBGcGd9Kz5XnwUuo2WvmdtT6DbbN4Mmx+bARC0qdja4xJT8iHVz9KDT7eqf3zxaJnlA51Z1sj+uExQEjlbG4TNTJBUlo2q4ovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285650; c=relaxed/simple;
	bh=zuNBukGMxIbwHgZSwtqzWOID/fmK7klV6q0CuL6gkCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YembGWTMj1IJMzuWfQM3WRu6U9V9AFrzBstyo67Qk4wHdtF3Q6UpTT4ZXj5qduE1lJ9ZCA2xNaN6M3Bosw2wFh2EZQ4QDix2im+1OOs8gtEcolYsUZC/raltXFGDNdqEgseTETSpp6kfnC4GnhD0X6642lyLqBsVDm/IDVXmEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huUj0Cvf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huUj0Cvf"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1340887a12.0
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 05:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758285648; x=1758890448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyZzz0YHkQdt4nLdjRC3tRn4Q7QBLi8forrLeEj70W4=;
        b=huUj0CvfTNqCYonaS7XRQITCVd4v36OO8rtojZbTg+VZ4kjcmqhtdkcrgjsa6JN3fc
         h60zwxNc/hnyIGeVnHraryfICDPc7ywAdvvJfqhcPn0of0oi6D5C8iJXusNm9KBXrJte
         3IK8A8iy/5LXBVWLls6hPEDNo8TEMEUgsymZQ014Hy48huMfquZ09J8lC/atq5TySPEQ
         Hbdh3yaSeMTZwgc/c8Ip+e/F2E2xv5U9EIHMJKLdiMm9p9R7fqRJCeJy/OoY9iNJGFDS
         cNOVCbOgG8XZ254QnwVezVkGzLnKgJ9EZsiwnDO7weRvnyVNEgGBHKQzIK/JvTMRY4pa
         5xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285648; x=1758890448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyZzz0YHkQdt4nLdjRC3tRn4Q7QBLi8forrLeEj70W4=;
        b=G77p5vEXzFLHC+dgshOor0EgmfNRJExFzoYW4/wejA83IlPjLqHeRrexvYKVjkpaQ5
         X71b0OSbFv3t6Vje6Yc2w/ht81OoxpTHgdnN3I21NgUsmYZPjziA+e0PyYa2w0aMD2zC
         MaL5yL7bXlRgze02M9gy2iSVkxD+r6Dnqb1nsImdK8TNTvud4XdLDSMW6qlm7FG2bI66
         SA4zKqF2t1oz2j9eXvool0/KLCEFhAlOJ+HQsWhcr24SwrMNpJAv64oZZqn/I1hmjqLO
         6Hv4J+VWSAQKbKJJIXA//S6u8gbMeFHFmA3u14BjTxDBw0McOjzpfYyWT9+sjhAMquKR
         8tSw==
X-Gm-Message-State: AOJu0YxBAYSJykcz8elBx7y6YB9Vs7ly+amre39b/6nI8i7CvlQsxm3C
	/gmus+75uDN7cer+F3MxV2syDgJdhvxWc2KXpzMZ9XKNhqL8bBhGntxl2JB5xe52wrMcMwEkOn3
	DS9HMTBNk4FX0Pt90iF8PddSv8J8O0hL69Q==
X-Gm-Gg: ASbGncssCw8D1WJI5Hy4hBR0wLKgJG5s56O9fU8qvvYvEnf05ujizasYHwEszxSoa1d
	KyzuK4z6GOYCJQhy6XmPHDrl2BAcn1ZLsw0Bn5fMD/tBDdiinGHlBENCaBQRDgYSZxY1N5iuyR5
	7AZG/hikAzeQxJ+cdXva9+0vD3Ucwy/cs0PehWuLe/IrS8Ad2uxtHQk7XzfvMZqvCi3sXHeRy2T
	puYHvA=
X-Google-Smtp-Source: AGHT+IHJritqo6m6aNigDboBPwOlFCineXddQaYnN99qYLxrAJxOLVHEJlGcpsvYEnoqXP/PEGm1+rTTtaInA2tqa/w=
X-Received: by 2002:a17:902:ce03:b0:249:2caa:d5b6 with SMTP id
 d9443c01a7336-269ba550e64mr41230035ad.48.1758285648265; Fri, 19 Sep 2025
 05:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919122100.181107-2-stephen.smalley.work@gmail.com>
 <20250919122100.181107-4-stephen.smalley.work@gmail.com> <4f3cafc8-54da-4092-a383-49c168b4990b@googlemail.com>
In-Reply-To: <4f3cafc8-54da-4092-a383-49c168b4990b@googlemail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Sep 2025 08:40:36 -0400
X-Gm-Features: AS18NWCkBqOjkqOCna6Huj2mLFdEXhFRiJeR2F9D7Kqo8eUmWk8whl8rf2jKC4E
Message-ID: <CAEjxPJ7woaqmpucFfT-wd6ZbdC8EaAm5acefWaR-unR+TunmBg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] systemd: perform SELinux initialization again in
 a SELinux namespace
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Sep 19, 2025 14:24:42 Stephen Smalley <stephen.smalley.work@gmail.com>:
>
> > RFC only, this demonstrates the changes required to systemd to
> > perform SELinux setup and initialization when run in its own
> > SELinux namespace. Otherwise, by default, systemd currently skips
> > SELinux processing when run within a container to avoid conflicting
> > with the host.
> >
> > Modify systemd to perform SELinux setup and initialization when
> > run in its own SELinux namespace.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > src/core/main.c | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> >
> > diff --git a/src/core/main.c b/src/core/main.c
> > index 3e7894ee5e..fb903b7646 100644
> > --- a/src/core/main.c
> > +++ b/src/core/main.c
> > @@ -3164,6 +3164,21 @@ int main(int argc, char *argv[]) {
> >                          log_set_target(LOG_TARGET_JOURNAL_OR_KMSG);
> >
> >                  } else {
> > +                        const char *selinuxns =3D getenv("SELINUXNS");
> > +
> > +                        if (selinuxns) {
> > +                                r =3D mac_selinux_setup(&loaded_policy=
);
> > +                                if (r < 0) {
> > +                                        error_message =3D "Failed to s=
etup SELinux namespace support";
> > +                                        goto finish;
> > +                                }
> > +
> > +                                if (mac_selinux_init() < 0) {
>
> Should the return value here saved to the error variable r before jumping=
 to the finish label?

Good point - thanks!

>
> > +                                        error_message =3D "Failed to i=
nitialize SELinux namespace support";
> > +                                        goto finish;
> > +                                }
> > +                        }
> > +
> >                          /* Running inside a container, as PID 1 */
> >                          log_set_target_and_open(LOG_TARGET_CONSOLE);
> >
> > --
> > 2.51.0
>
