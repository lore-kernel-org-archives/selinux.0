Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joy0elW8"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFC4F3
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 13:51:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf4f97752so6407622e87.1
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702331470; x=1702936270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a7XwdWk85uNdNb+peAQ2TS071Ru3dbohMukfEC3wfg=;
        b=joy0elW8n+7KSWEqE2LWVkFAEQSyrDT//rWHiWYQe8oO0N1bFsvmzcliPQLbrDd3v9
         c3WlF7erG3Gl/A4k262JGcWBDXy+/jAacO0G8Ic6ULTPkdl2PzNMhuYXS9tOXfqapjW7
         3yXBxiOmhRogqjX/Q5TGXHhRhKgWLUPJP/ryvq22/zNAdLUyZiOVXf+aSK3yk1eyUY9U
         awG4ohf9nBlADPDMNKnLNsFscippG55CIsN/NDvGYPDqq3PXokjendZ0VCyetKQiHNwV
         QaUqf2R0RyEfjZCpCKax+R3nGBpt/QJtRG2MEp7tpnUomkEmdynr52Ywt19ZcmGBynUi
         IpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702331470; x=1702936270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a7XwdWk85uNdNb+peAQ2TS071Ru3dbohMukfEC3wfg=;
        b=o/pGAUojcUVhzjp5HSEYRB6A72A/2lIc6rA/Xg7y1om3BcHESHxMKfHvNUg75lbjm7
         kAY86kKW/RkmxGnI5pAqmjQX2ar49cRsgb94MSO7hQ9fNyIfjD30h8NZ69PTflKGcXiO
         U23pR/AYtL3QG86E1CAr97VbZsE/NhREK3w87B6RPJRiG4BJyUCp8/EtYXnjrGso5z8I
         eJqUFh2rRQf1bk3LokCUO9g55eNletkdLrASnmhyxfNc0dwQNK7eTp13f9vRlvViAMRV
         ZB+Z7tWyybnI5KRTCVZbgwiUIFW2y97d4LVfonnhgME1ydSlf5dR8f0OrtazBMDib8wS
         UNJw==
X-Gm-Message-State: AOJu0Ywq3BYAyupoY4w/MjY9+bTAc5VbPYEgu2Q3Gk4+5ecci4kCCnp7
	28DmXirQPDVb0/g7zJb6Y07sx1c1zZoyQtCH+6g=
X-Google-Smtp-Source: AGHT+IHbsu5jdvz8XOiPSAP92ua/21igYWN7/q7JRxv9afXgFL0IRLwF104F0sViQU7I3d9BjxvF71Zd3hC89V6LYn8=
X-Received: by 2002:a19:910f:0:b0:50b:bd7a:abbc with SMTP id
 t15-20020a19910f000000b0050bbd7aabbcmr2175814lfd.66.1702331469826; Mon, 11
 Dec 2023 13:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211145408.124757-1-cgzones@googlemail.com>
 <CAP+JOzS+CAydQ=bhw5L8TUb2TXzp-EX20b3C6EDKQOv++MYVnQ@mail.gmail.com> <CAEjxPJ4y7XFk5o08BoVw8hxrLv-go-fgNh1Bqhz4Eh7sVwnm6Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4y7XFk5o08BoVw8hxrLv-go-fgNh1Bqhz4Eh7sVwnm6Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 11 Dec 2023 16:50:58 -0500
Message-ID: <CAP+JOzSYaN-j80UDwfGy_v+Bhgk=jdnEqSRzyP5jarnB41dhzg@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: handle long permission names in sepol_av_to_string()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Dec 11, 2023 at 12:07=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > On Mon, Dec 11, 2023 at 9:54=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Use a growing dynamically allocated buffer to format permission names=
 of
> > > an access vector instead of a fixed static buffer to support very lon=
g
> > > permission names.
> > >
> > > This changes the behavior of the since libsepol 3.4 exported function
> > > sepol_av_perm_to_string(): previously it returned a pointer to a stat=
ic
> > > buffer which must not be free'd by the caller, now an allocated strin=
g
> > > which should be free'd by the caller (to avoid memory leaks).
> > >
> > > Reported-by: oss-fuzz (issue 64832, 64933)
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > I like this patch and would like to merge it, but it does change an
> > exported function (by removing const on the return type).
> > As far as I know, the only thing that uses the function externally is
> > sepol_compute_av in libsepol/utils and the function has only been
> > exported since 2022, so I doubt there would be any harm in making the
> > change. But I am still hesitant to make the change.
> >
> > What is the best way to handle this?
>
> Hmm...there is a reason why this and other libsepol functions were not
> exported in the first place, not sure why that changed.
>
> There is no real good way. Options are:
> 1. Change it without touching .so version and hope nothing breaks.
> Don't see any usage in Debian code search but one never knows.
> 2. Change it and bump the LIBVERSION to reflect an incompatible
> change. Seems like that should be batched with other longstanding
> desired incompatible changes if done that way.
> 3. Use per-symbol versioning to auto-magically redirect the caller to
> the old or new implementation based on the version against which they
> were compiled. Seems like that has caused us grief in the past.
> 4. Don't change it.

I am going for option 4 and sent a patch. The good news was that the
exported function just wrapped the internal one.
Jim
