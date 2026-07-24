Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37A43FD27
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903815; cv=pass; b=mHp7J6xEXXz6hUyDASvsoNlpD7QgcagE2r24wcePnT9HT6oKCbnbuLzbEqeQ0hIGEHB6xxKGsAuaK7UlzsGh8mBP9h6h8mXVZsz1BRUtqfqRKuW5eLXTfOTF52QJdgv8QCzS/qb3ku8eBZub4GWShmRdU6UomOtdp2p5pAGehyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903815; c=relaxed/simple;
	bh=6QeqcLK8KzuSQql6boxKiRekqcTs7H6RVXswf4ZAm58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flmeVdx9DY20qxAiKMuIPTAU9W01QQ7N6u6XyTxhIvnldRZXH4O7RtNocTUjV5wy0xzfMz+7dSRmQVXIxfvvW7Lj5i8yzAxle0dtT/sck5h/qjwAesjOUgmvITfQmwGvTF9GTt3Ml0VfJ5ynxdFDCNUcDE8v+uemVIjlf7bzq5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9JhUMzM; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9JhUMzM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-526f963372aso4182571cf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903804; cv=none;
        d=google.com; s=arc-20260327;
        b=YCpDgdUKlW5vu0oNgaIHa31dbL2Cf71mCwDDDMHBmH+s0IDl+BH3Bn+RhLkKQCFHIP
         3/U638sgKhzjgDA+sLmOY5pXnFEPcXK32lift7p/X33t27gu6VefckweYdhaaT2T/Sdr
         xq9/uNt0Xmxg7cM/UvZ3MCjpvjHs+qQmWGzwQo2fP7LQYYZ2X6RULJ8wxC0DHTACeRq2
         DBGzLc8ixroDT11g8XYe8WGStQxiBXDGDCQUHIKQMtRXblIoAcuuCSOwIBDm+ZBFiQAz
         fVcWzZHxNwKQgaohWnhosLm8D1FVbsUlpxChnixgVuHo6dw3nNrfl4CWJt43aEfJLEqY
         PpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GUx+Cf7oZmafoTLbF09D4nGVm5LDdRpdnSFNG7IcXhA=;
        fh=JsrRvKH9zDWSQo/ocMDcDF7TXemqKX2q7s6wLCPWz4s=;
        b=jK7OG+PZjsd5ZTOK9IuR+m8gzRBnL0ywwvlLA0zjCbbL/tkbTIXsPPIY0D8lb0pfNb
         7szgT35nWfMQK9DMogBbneY10BSwavq7dtioTicKVc0lO11iyyOstBAPLQheRvW5r+Mu
         r68/rXObX5Utj/Zows9hGp32oqVDGLhyu34GsynLICpZ/M0tc+WxBEgP6RR4aI/9sLhk
         x6NG3YcN3qGIACVzqZ2N8gHxaj5jx8FtOvjHWf+xmquMu7DXwmBVINXloiuUAciyQ5qN
         9eL56AwXCXRdpFDwO6fYTBh+JGV3X2dTly7K9CPLUhwxWHC2rnQXanSG6y1UkyHDmO2y
         IhjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903804; x=1785508604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GUx+Cf7oZmafoTLbF09D4nGVm5LDdRpdnSFNG7IcXhA=;
        b=D9JhUMzM3nQ5Ef9xMAFrfFgFsBUefOjj6Fgvxd6qPQ7wvxp7SG/wnwACeRWyH9fPWS
         CxwUOR1hWNqJesG8cMtZYM85DZ/3r3N0J+IZz61B+p24r0Sx+bJhGZyaRIL1mwiIJyX/
         6cY/F2fYl1malPD2QSb8bWmq4OnefmXe9y5hxJPVVA4yLLfEVoczmkWe5cWl88ESj2tR
         uIa50b/P6I1QIBtbvuiaLSET0uME1b4b09CAsGt4EmCRbA95V24AjcaU5cwY0cbGT5hM
         jE6CaDt42z7+u23jVrg0qSi6GqqK7EInAql68gPuMI5AW50ULjRRntDBRhHU7iBY6Sv0
         1tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903804; x=1785508604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUx+Cf7oZmafoTLbF09D4nGVm5LDdRpdnSFNG7IcXhA=;
        b=OgHZ24w1krkpvk+pk28Ah/PzgimdyTUIyvOYMglwaNK4EKIgJ6VybdCIdUXlAhJ1hO
         13Dh0tyfDl64YPSRlOWkm4TWtzsFKXrxcCBUVYIoEhocaMN1yjGzky49sEFErZ3vb5ed
         fzyK7BFrb9Io/3Nh3jOZAFF4E+mv31rMfdj6Y+ylisbKZBuRr0srBWNBfluVS+6T0RnN
         4sYazwDrB35Ik5XjyyM2GGz+drpzib2J/x8XTwIAGeXF91oqt+Vwvj2NIYkqvPZAnc5R
         mJiSb8WpLk4fRyILCYziBpDy1FkxiCXveAt/2d5eDn9cpdtGZYTDL1oUGvPaBHLFIjoy
         xr7A==
X-Gm-Message-State: AOJu0YzI5E43uPbXcJ3t4sfC+diNcIob6fTfFeqzlZoDEFAziHy2xIcl
	kSm7dO75HlBfgRleGcgkYCoNY2V4Vy8B3hsrlZDn43cAyf5XVpYRvC4H+X5hZR3nlS7OV75OyLr
	v89ifIooTyviHbdeVU5QQq3mdb4bVmJY=
X-Gm-Gg: AR+sD12nH32BWY8QIQWKhgwvit9F03KXCPKAF9LyXtp8F2vnGtrYM5qx+NLTgQJZil0
	N1i+zYQeu7Pb5vRknm+U0BK0R9Oayr7JQ4B+YPVuaoiEXhxm4HDFTtpWHAz0w/hc4RFR88zCn2g
	APx7Pd2axecPNFeN5orxTeNZw5lt79KXo7EsklvFvmpDEfLd4phCuIqJ/AYKFwVqgqhW68Z0qnK
	6AoQRDFdeRjrvW53eHkIRw0uXn/Jl/xyVI3ApBnPMLpmTScqyW4O+lnX51RnA==
X-Received: by 2002:a05:622a:1c13:b0:51c:1ff:2515 with SMTP id
 d75a77b69052e-5283df65e1cmr67870451cf.65.1784903804543; Fri, 24 Jul 2026
 07:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724005416.805098-1-inseob@google.com> <CAEjxPJ5=CmnH_fZVnCtpFPzCCgz6GxYdfD4zhVaViRAbX1EyEg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5=CmnH_fZVnCtpFPzCCgz6GxYdfD4zhVaViRAbX1EyEg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:36:32 -0400
X-Gm-Features: AUfX_mwuQ7yVR_Ly_oOZ_44iQgxwX_YwBu_21ILK59L6ySopHNmk9ULnCIjRw_I
Message-ID: <CAEjxPJ4C6J7gXFpCbgtCKYWnLo8e7yMnJDM6T6wE+M54SWxdhA@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: improve performance with pcre matches
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, 
	Eric Biggers <ebiggers@kernel.org>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 9:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 8:54=E2=80=AFPM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> >
> > Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
> > 2023-01-12), performance of PCRE2 matches has been affected due to
> > excessive recreation of the match_data in an attempt to reduce memory
> > utilization; instead of a workaround, it would be better to address
> > the problem and maybe even improve performance in the process.
> >
> > The issue is that currently the structure that holds PCRE state has
> > both a pcre2_code (which is per pattern) and a pcre2_match_data (which
> > is per match), forcing us to add a mutex to prevent multiple matches to
> > step on each other.
> >
> > Lets remove the match_data and the mutex and instead allocate one once
> > in a thread independent way that could be used and reused, by extending
> > our pthread interface to not only store TLS variables but also retrieve
> > them, and then use one of those.
> >
> > Since we are not interested on the capture groups (if any) lets only
> > allocate 1 pair which is all that will be needed and change the logic
> > so that a return of 0 (which means the pattern matched but there were
> > not enough capture spots) is also considered a match.
> >
> > This will ensure that the memory use would be bound to the number of
> > concurrent matches instead of the number of patterns and therefore
> > reduce the impact that recent changes on the way that the frames used
> > for matching are allocated have brought since PCRE2 10.41 was released.
> >
> > For cases where threads are not available, just keep it working in slow
> > mode as done before the workaround was reverted.
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > Signed-off-by: Inseob Kim <inseob@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged with code formatting fixed.

>
> > ---
> > v2:
> >  - Fix the dual destructor antipattern by separating the thread-exit
> >    destructor (match_data_thread_free) from the library-unload key clea=
nup
> >    (match_data_key_destroy, annotated with __attribute__((destructor)))=
.
> >  - Eliminate the data race on match_data_key_initialized by using pthre=
ad_once
> >    (via __selinux_once) for safe, race-free initialization of match_dat=
a_key.
> >  - Remove redundant match_data_initialized thread-local variable, makin=
g
> >    lookups purely based on __selinux_getspecific().
> > v3:
> >  - Fix typos in the commit message, along with "PCRE2 10.41"
> >    clarification
> > ---
> >  libselinux/src/regex.c            | 105 +++++++++++++++---------------
> >  libselinux/src/selinux_internal.h |   4 ++
> >  2 files changed, 56 insertions(+), 53 deletions(-)
> >
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index 80b01692..b132b558 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -36,6 +36,10 @@
> >  static struct regex_data *regex_data_create(void);
> >
> >  #ifdef USE_PCRE2
> > +static pthread_key_t match_data_key;
> > +static pthread_once_t match_data_key_once =3D PTHREAD_ONCE_INIT;
> > +static int match_data_key_alloc_failed =3D 0;
> > +static int match_data_key_created =3D 0;
> >  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
> >  static char arch_string_buffer[32];
> >
> > @@ -71,14 +75,6 @@ const char *regex_arch_string(void)
> >
> >  struct regex_data {
> >         pcre2_code *regex; /* compiled regular expression */
> > -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> > -       /*
> > -        * match data block required for the compiled
> > -        * pattern in pcre2
> > -        */
> > -       pcre2_match_data *match_data;
> > -#endif
> > -       pthread_mutex_t match_mutex;
> >  };
> >
> >  int regex_prepare_data(struct regex_data **regex, char const *pattern_=
string,
> > @@ -98,13 +94,6 @@ int regex_prepare_data(struct regex_data **regex, ch=
ar const *pattern_string,
> >                 goto err;
> >         }
> >
> > -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> > -       (*regex)->match_data =3D
> > -               pcre2_match_data_create_from_pattern((*regex)->regex, N=
ULL);
> > -       if (!(*regex)->match_data) {
> > -               goto err;
> > -       }
> > -#endif
> >         return 0;
> >
> >  err:
> > @@ -159,13 +148,6 @@ int regex_load_mmap(struct mmap_area *mmap_area, s=
truct regex_data **regex,
> >                 if (rc !=3D 1)
> >                         goto err;
> >
> > -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> > -               (*regex)->match_data =3D pcre2_match_data_create_from_p=
attern(
> > -                       (*regex)->regex, NULL);
> > -               if (!(*regex)->match_data)
> > -                       goto err;
> > -#endif
> > -
> >                 *regex_compiled =3D true;
> >         }
> >
> > @@ -223,18 +205,32 @@ out:
> >         return rc;
> >  }
> >
> > +static void match_data_thread_free(void *ptr)
> > +{
> > +       pcre2_match_data_free(ptr);
> > +}
> > +
> > +static void match_data_key_init(void)
> > +{
> > +       if (__selinux_key_create(&match_data_key, match_data_thread_fre=
e) =3D=3D 0)
> > +               match_data_key_created =3D 1;
> > +       else
> > +               match_data_key_alloc_failed =3D 1;
> > +}
> > +
> > +static void __attribute__((destructor)) match_data_key_destroy(void)
> > +{
> > +       if (match_data_key_created) {
> > +               __selinux_key_delete(match_data_key);
> > +               match_data_key_created =3D 0;
> > +       }
> > +}
> > +
> >  void regex_data_free(struct regex_data *regex)
> >  {
> >         if (regex) {
> >                 if (regex->regex)
> >                         pcre2_code_free(regex->regex);
> > -
> > -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> > -               if (regex->match_data)
> > -                       pcre2_match_data_free(regex->match_data);
> > -#endif
> > -
> > -               __pthread_mutex_destroy(&regex->match_mutex);
> >                 free(regex);
> >         }
> >  }
> > @@ -242,31 +238,38 @@ void regex_data_free(struct regex_data *regex)
> >  int regex_match(struct regex_data *regex, char const *subject, int par=
tial)
> >  {
> >         int rc;
> > -       pcre2_match_data *match_data;
> > -       __pthread_mutex_lock(&regex->match_mutex);
> > +       bool slow;
> > +       pcre2_match_data *match_data =3D NULL;
> > +
> > +       __selinux_once(match_data_key_once, match_data_key_init);
> > +
> > +       if (!match_data_key_alloc_failed) {
> > +               match_data =3D __selinux_getspecific(match_data_key);
> > +               if (!match_data) {
> > +                       match_data =3D pcre2_match_data_create(1, NULL)=
;
> > +                       if (match_data) {
> > +                               __selinux_setspecific(match_data_key,
> > +                                                       match_data);
> > +                       }
> > +               }
> > +       }
> >
> > -#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> > -       match_data =3D pcre2_match_data_create_from_pattern(regex->rege=
x, NULL);
> > -       if (match_data =3D=3D NULL) {
> > -               __pthread_mutex_unlock(&regex->match_mutex);
> > -               return REGEX_ERROR;
> > +       slow =3D (match_data_key_alloc_failed || match_data =3D=3D NULL=
);
> > +       if (slow) {
> > +               match_data =3D pcre2_match_data_create_from_pattern(reg=
ex->regex,
> > +                                                                      =
 NULL);
> > +               if (!match_data)
> > +                       return REGEX_ERROR;
> >         }
> > -#else
> > -       match_data =3D regex->match_data;
> > -#endif
> >
> > -       rc =3D pcre2_match(regex->regex, (PCRE2_SPTR)subject,
> > -                        PCRE2_ZERO_TERMINATED, 0,
> > -                        partial ? PCRE2_PARTIAL_SOFT : 0, match_data, =
NULL);
> > +       rc =3D pcre2_match(
> > +           regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0=
,
> > +           partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
> >
> > -#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> > -       // pcre2_match allocates heap and it won't be freed until
> > -       // pcre2_match_data_free, resulting in heap overhead.
> > -       pcre2_match_data_free(match_data);
> > -#endif
> > +       if (slow)
> > +               pcre2_match_data_free(match_data);
> >
> > -       __pthread_mutex_unlock(&regex->match_mutex);
> > -       if (rc > 0)
> > +       if (rc >=3D 0)
> >                 return REGEX_MATCH;
> >         switch (rc) {
> >         case PCRE2_ERROR_PARTIAL:
> > @@ -305,10 +308,6 @@ static struct regex_data *regex_data_create(void)
> >  {
> >         struct regex_data *regex_data =3D
> >                 (struct regex_data *)calloc(1, sizeof(struct regex_data=
));
> > -       if (!regex_data)
> > -               return NULL;
> > -
> > -       __pthread_mutex_init(&regex_data->match_mutex, NULL);
> >         return regex_data;
> >  }
> >
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index b0ef5a75..5feb5d97 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -14,6 +14,7 @@ extern size_t selinux_page_size;
> >  #pragma weak pthread_key_create
> >  #pragma weak pthread_key_delete
> >  #pragma weak pthread_setspecific
> > +#pragma weak pthread_getspecific
> >
> >  /* Call handler iff the first call.  */
> >  #define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)                   =
  \
> > @@ -42,6 +43,9 @@ extern size_t selinux_page_size;
> >                         pthread_setspecific(KEY, VALUE); \
> >         } while (0)
> >
> > +#define __selinux_getspecific(KEY) \
> > +       (pthread_getspecific !=3D NULL ? pthread_getspecific(KEY) : NUL=
L)
> > +
> >  /* selabel_lookup() is only thread safe if we're compiled with pthread=
s */
> >
> >  #pragma weak pthread_mutex_init
> > --
> > 2.55.0.229.g6434b31f56-goog
> >
