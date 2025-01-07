Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A031F7077
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280076; cv=none; b=RFF7HsOQP4+LgFZs6EBJpgA5MQQHLEju45SE32pCyFifiScUCtt6J4+uFRiio6Qmd532qNtwwuaA2xjXORjVScN/IMCcZNmoa+dHaJMI/Nl1f3zOdvO6Mq7O6zGDE67wSJTGqF+ij1z2rz6ZpSUqZOshdzMikc2lUZjN79gsuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280076; c=relaxed/simple;
	bh=KdAGBTGelXzkEbKJPXJBFDqWD8atheeiUyT2W+MfcVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSVG6KpC+ooViFkiMeISDJLDZyt2kLrhIH5h03TFaLdqL234x4mOgXtf8iuoDnq3GcwZAv0x2kEL6J8jBJ7V6apLRtiAvko9yJzyZnUzuKJU4ZDRnS0ptRh6Frzq9nbDvzyW8oyEdn2u2ch0VgG1Oi38i2mbzW2pefJXz4C/A6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgRj+fPv; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgRj+fPv"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-518c46cc6e4so5081531e0c.3
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736280072; x=1736884872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0D3azDmIkovKSPOxucICIkBiH6yQsc1qqx3iwXE7B4=;
        b=ZgRj+fPvVYZruNwUrg+Jspfbvn1WwxzIUlq6mbiwTD5vp9z4NOgg7DYzudNQ6xXNyn
         fvfsVYGl6gtAQ4XJr6vr6LRpbjfC59Sg8Dcpa+S/25MMpw9Oqz6Wy3q5wbUcyqzoxws9
         Mkm3TavCX5TbhEUb1gXfqSSvYqG0SpHXiE9HOyHn/PD/Gzdm2A6B2fk1g3dNVeLxiAmy
         WwRA+0O1ErDgpPZ1aWq5f/jvZ6MoAolNHUja0k6A7eXfsbHj67mDxtGg1p7nVOnM+JJm
         T6wdjMUK9zLprIu+U3pI3qgtPO3ony23IQYqOeH/dbW4M5//HreUHbYsXTfJ994pAR89
         ZbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280072; x=1736884872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0D3azDmIkovKSPOxucICIkBiH6yQsc1qqx3iwXE7B4=;
        b=M+al9ngQ7tW7pIBBsl1Gx73oieBXbntoA7XPGL9rRKeCq3dEGTHeehkMlaz8NzpRt8
         B9DatVjpKUokGrl20Q/tLrquiuJWKrpiHaTlIxH3eHfaeyZRBSgxrl0tBTTZeOeZhlFb
         3Jw7m1U7y2KMWMfOf+8TGcvCu8Fo0dpQrnQ9ULJC5lNiEhcqzl8Ezns9Fw6VppFzQC4s
         +Q547uZAHWN7aM0d+sm3SNw4wVYTmf1sMXe0rQzYFjbXPC1ZjmAjheqPFJwBGyEOnQA9
         wkkPpBi03IVy3N7H3R/Lrwi1HkEseHU/AiSbyaHRKoYjqgcTpIASGBd/WvILfb5PZuB6
         4zng==
X-Gm-Message-State: AOJu0YzxpJjqsG70IqVvZftZOH46/AK1EPEY08j4KIrfefSGi7wrxYrA
	pmp96HWzwt2BA05itTj24bUOtmLGIwfTd30gWc8m/3iI090OMV9Qj8627enatliw9JmiM0tuZZF
	o0Z2Zl4lrmLGkifgjuZIeppeaGRw=
X-Gm-Gg: ASbGnctO+NrJGiEMGDNypvzyJqBYi9sD9K5eBvyYThNuHx0jEJ+cfqUrN0nFgZHx+wY
	81XLAFXiOacHShe88A7JlxBdnpxg+PpdGAI3CHw==
X-Google-Smtp-Source: AGHT+IFzzXQ4URL8CfhwgA3dpTae8HI/DyFX+FyPIBGFD0paoj1JTQKwrlxqeeaVIIuzNHOD0L/29Wl2+J+VpYzexQI=
X-Received: by 2002:a05:6122:1d15:b0:517:83d1:d438 with SMTP id
 71dfb90a1353d-51c6c437bd7mr433981e0c.3.1736280072188; Tue, 07 Jan 2025
 12:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217212752.23866-1-cgoettsche@seltendoof.de> <CAP+JOzRTuWzAO2SBmHD8EbDXTn3Qjwmk0kkTmoiavUdL_my3DQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRTuWzAO2SBmHD8EbDXTn3Qjwmk0kkTmoiavUdL_my3DQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 7 Jan 2025 15:01:01 -0500
X-Gm-Features: AbW1kvYav2gkB-4RkqhXZmqQdthO48Egoxy01aW-In5qJe8LgZq3LkjEWVu-txg
Message-ID: <CAP+JOzQxvC1rqRcoQp=aVpgfoaR6FV7xAN_JCOT-TkOGheFA=Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux/fuzz: readjust load_mmap() update
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 10:07=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Dec 19, 2024 at 12:04=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Update the fuzzers for the input number parameter addition.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/fuzz/selabel_file_compiled-fuzzer.c | 6 +++---
> >  libselinux/fuzz/selabel_file_text-fuzzer.c     | 2 +-
> >  libselinux/src/label_file.h                    | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinu=
x/fuzz/selabel_file_compiled-fuzzer.c
> > index d1249a76..09fbddd1 100644
> > --- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> > +++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> > @@ -195,7 +195,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >                 goto cleanup;
> >
> >         errno =3D 0;
> > -       rc =3D load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME)=
;
> > +       rc =3D load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME,=
 0);
> >         if (rc) {
> >                 assert(errno !=3D 0);
> >                 goto cleanup;
> > @@ -208,7 +208,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >                 goto cleanup;
> >
> >         errno =3D 0;
> > -       rc =3D load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME)=
;
> > +       rc =3D load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME,=
 1);
> >         if (rc) {
> >                 assert(errno !=3D 0);
> >                 goto cleanup;
> > @@ -221,7 +221,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >                 goto cleanup;
> >
> >         errno =3D 0;
> > -       rc =3D load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME)=
;
> > +       rc =3D load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME,=
 2);
> >         if (rc) {
> >                 assert(errno !=3D 0);
> >                 goto cleanup;
> > diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fu=
zz/selabel_file_text-fuzzer.c
> > index ed67ea25..1f8942dd 100644
> > --- a/libselinux/fuzz/selabel_file_text-fuzzer.c
> > +++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
> > @@ -167,7 +167,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >                 goto cleanup;
> >
> >         errno =3D 0;
> > -       rc =3D process_text_file(fp, /*prefix=3D*/ NULL, &rec, MEMFD_FI=
LE_NAME);
> > +       rc =3D process_text_file(fp, /*prefix=3D*/ NULL, &rec, MEMFD_FI=
LE_NAME, 0);
> >         if (rc) {
> >                 assert(errno !=3D 0);
> >                 goto cleanup;
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 597b756e..60ebbb47 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -60,7 +60,7 @@ struct lookup_result {
> >         struct lookup_result *next;
> >  };
> >  #ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> > -extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle=
 *rec, const char *path);
> > +extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle=
 *rec, const char *path, uint8_t inputno);
> >  extern int process_text_file(FILE *fp, const char *prefix, struct sela=
bel_handle *rec, const char *path, uint8_t inputno);
> >  extern void free_lookup_result(struct lookup_result *result);
> >  extern struct lookup_result *lookup_all(struct selabel_handle *rec, co=
nst char *key, int type, bool partial, bool find_all, struct lookup_result =
*buf);
> > --
> > 2.45.2
> >
> >
