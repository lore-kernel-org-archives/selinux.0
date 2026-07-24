Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585B30C629
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900619; cv=pass; b=Wx50OdNt0Ca8YsIJ5YSD7gnNm2eK3NHTbhtRCcpiGMIOqLA4JTjCBujeWsANi+vZmpgE574HiE4xyYXlewNtndYeoZ3tMlOIRcUpGBQMifsbggksYEu9Edr79Nmrjfr8Aac4QTK8/+n2v3jS32Rm+rBtXrDT5WsDsp0dDUW3IlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900619; c=relaxed/simple;
	bh=qbPzi02xy5bUnQEz2twXiOo1V7cqEtIpbpDNucZYdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSDa/3SeL/at8z3/lCc40z7wCNRELHlJXv8SRUkVqm9aIawkh7l+Yl50t4Sb8mu1karN04HtP1ZWc9RzvlT+sTpV9d/6V8Mh8mIyGSFADPWNixTkgb0RCU42UGh4qBxYyy9CemD7eBO+vwai8oQtkn3p2G/oAdZENArOok0P+9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuGfrX1M; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuGfrX1M"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448b0ff4a57so197481fac.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 06:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900617; cv=none;
        d=google.com; s=arc-20260327;
        b=E/q4yiT5atBRKGCt15xyfETz5dMxa7d2wmmkdguKyLHk0l0pY6yc7mriyf7aIUgy81
         tnC6r9D9MM1L4XnEPxKr7jKOYmkDc7mM9mYbN0zw2SveWchfF5nng2IQTV8uzMplDFo0
         +qmDtlZ2Y38hR3vMP6nXRIfd1lm/+2X2a5xp+qrTcFPi1g0ATKUTonPg81XaI7+X03tO
         9C11sOAU0QZ4M0SsVaKXvEi7c9qMBE9jxrbClAhTcUx3kcFea6rTIYsaE8trNybGIKgb
         n1FTKPz6TsV5bG688TRLnqzO0y7w2gswah7xwD/QEvUUqXAH/T4/vLDk8XHssUqrcE15
         uCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZ0pS9mRUbBfpimf7S58tGhh9sR1KSQKgtuj79LFhic=;
        fh=JsrRvKH9zDWSQo/ocMDcDF7TXemqKX2q7s6wLCPWz4s=;
        b=EwkxAR4bZZvYTnE5qXvymjSZFBOBKDjSzXuTqCCK07JIE1rDLFCZiPfint08UkyKT2
         fXvSXbY3JkgASRkBfgJKuo0Dn2Cw3l1cZ+cF6Sh2eVqA/M35NYbzPD9fSLRTDh0N/Ewv
         6NU7fzZaLXrO80+c6tsWYluPxdr0UcysSzY705BD0NTdoaRtSlxRVgOMj6nsxXTj2LVR
         LzGYnz7K3TQE1ELD7a1mzD4d5vjQceddZCi7b31Kvb9N9sFLYCUJFCzHfYf9FJb8TI1U
         4aUOmOMsPEUYV2WovAUF6pmF1FDlnDdgQgWV2wbzVaBKhCt41jgUjq5/7mfyq3FqPwJl
         rsmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784900617; x=1785505417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZ0pS9mRUbBfpimf7S58tGhh9sR1KSQKgtuj79LFhic=;
        b=MuGfrX1MnQ4GDgzdyyqgccFn4ajYAJYY6BJP85dPABalyruhqVWxxAk0je785khaNb
         j4inpjNC3RpqRKlChQ7M6Wk3MwO1Q5R/nNie4ttvj03BiV6loEsJssWabv4g3eu29z7T
         bOYiv25BxEHk0U0PVXCqi/xIlLeELvUkRCtxDbqN+A7E2Hiav7EPEyqq/jcGISQCuVgj
         vLX1ggnI9TEZyL5ni9MFgYd5LXGigCilotQeGvrddMZOVRIvMTaREc73RtLeNW4dxK/W
         PvbTRPVLyvfPFS35EtOuMnGLcZK2Te1LTqQdR9lXRO9ted/M+t7XOVhNAo+EbbrBMdtK
         oEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900617; x=1785505417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZ0pS9mRUbBfpimf7S58tGhh9sR1KSQKgtuj79LFhic=;
        b=KXRGGZeYzmSUjUCjGOpZm65Y1et84Z9rANIeHOYofQUfomJHhIjt9T2glG+3e4CcCR
         QMP4N73wSwdJzOqc0k4nhuk7J7JEJ+lYTvDttpa0E07uV74ZSRIt3qSpHn3agu4O5G47
         k9KzsFL/Hzoy4rUme/MHn5u9CYpBHlsT6bp9qqXpnbi9IrOQM79LcCZJKuWiB+GqFkkp
         j83ky9U3pawLVRGdiImO/6xHaPHTC1zNvlomBvLfEQX+MdfvOpnscrG8DPHg/FvXXnJV
         V9dJqt+I5aA4aR6gI1HaAM459ShoSrLK2A2gJmFr2Edo+GYBP0l1g9CTK6OIXpVNBo00
         P0Fg==
X-Gm-Message-State: AOJu0YxzqldcsyCLkqJhKhF+f1eyfKLm6nsecR0/r7enoXSDixoNQE6D
	l7qbOHIyPV5Vze1VdzhZeewwW/QRn0ezh7nKPDbf5dfEp1Tap0TT0JLGcVBoUhIee0Q+YQkFgj2
	hWD7uRkAyB1tSClAXIYn7yJkCpcUd94k=
X-Gm-Gg: AR+sD1292CyOaj00PKLgt+xwZzh/+HHvCevuoxs5JIea9cqHzU6rulxS0CmOcpbWU88
	MNSgPDgHdpc/jC9eSy7XXssyYy8IFwtszr9CydfTc+QTL6DaGPn6FOZD5qKNJl/hbRIz6mRvufJ
	NvEnZQj8eIYRIrRoRUSXsPDh0acZ5G6zPL+O8gMwXEUL4DUUs7EzHuE1uI0lC19pNE0fDWTaizR
	HM0LNsCMxbCjRBfbSx/VIRzdB1terxDkyStPgH7jo2d3Aewjv5YLNZuRgDgeg==
X-Received: by 2002:a05:6871:c961:b0:447:559a:29a0 with SMTP id
 586e51a60fabf-457a04861f6mr4415191fac.0.1784900616883; Fri, 24 Jul 2026
 06:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724005416.805098-1-inseob@google.com>
In-Reply-To: <20260724005416.805098-1-inseob@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 09:43:26 -0400
X-Gm-Features: AUfX_mx7MgxouXQQd0z15fgI9jelUWV9EUJC3LxVVuz5RAE1kk0Mq4_9L3_w1CM
Message-ID: <CAEjxPJ5=CmnH_fZVnCtpFPzCCgz6GxYdfD4zhVaViRAbX1EyEg@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: improve performance with pcre matches
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, 
	Eric Biggers <ebiggers@kernel.org>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:54=E2=80=AFPM Inseob Kim <inseob@google.com> wrot=
e:
>
> From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
> 2023-01-12), performance of PCRE2 matches has been affected due to
> excessive recreation of the match_data in an attempt to reduce memory
> utilization; instead of a workaround, it would be better to address
> the problem and maybe even improve performance in the process.
>
> The issue is that currently the structure that holds PCRE state has
> both a pcre2_code (which is per pattern) and a pcre2_match_data (which
> is per match), forcing us to add a mutex to prevent multiple matches to
> step on each other.
>
> Lets remove the match_data and the mutex and instead allocate one once
> in a thread independent way that could be used and reused, by extending
> our pthread interface to not only store TLS variables but also retrieve
> them, and then use one of those.
>
> Since we are not interested on the capture groups (if any) lets only
> allocate 1 pair which is all that will be needed and change the logic
> so that a return of 0 (which means the pattern matched but there were
> not enough capture spots) is also considered a match.
>
> This will ensure that the memory use would be bound to the number of
> concurrent matches instead of the number of patterns and therefore
> reduce the impact that recent changes on the way that the frames used
> for matching are allocated have brought since PCRE2 10.41 was released.
>
> For cases where threads are not available, just keep it working in slow
> mode as done before the workaround was reverted.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> Signed-off-by: Inseob Kim <inseob@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2:
>  - Fix the dual destructor antipattern by separating the thread-exit
>    destructor (match_data_thread_free) from the library-unload key cleanu=
p
>    (match_data_key_destroy, annotated with __attribute__((destructor))).
>  - Eliminate the data race on match_data_key_initialized by using pthread=
_once
>    (via __selinux_once) for safe, race-free initialization of match_data_=
key.
>  - Remove redundant match_data_initialized thread-local variable, making
>    lookups purely based on __selinux_getspecific().
> v3:
>  - Fix typos in the commit message, along with "PCRE2 10.41"
>    clarification
> ---
>  libselinux/src/regex.c            | 105 +++++++++++++++---------------
>  libselinux/src/selinux_internal.h |   4 ++
>  2 files changed, 56 insertions(+), 53 deletions(-)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 80b01692..b132b558 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -36,6 +36,10 @@
>  static struct regex_data *regex_data_create(void);
>
>  #ifdef USE_PCRE2
> +static pthread_key_t match_data_key;
> +static pthread_once_t match_data_key_once =3D PTHREAD_ONCE_INIT;
> +static int match_data_key_alloc_failed =3D 0;
> +static int match_data_key_created =3D 0;
>  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
>  static char arch_string_buffer[32];
>
> @@ -71,14 +75,6 @@ const char *regex_arch_string(void)
>
>  struct regex_data {
>         pcre2_code *regex; /* compiled regular expression */
> -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> -       /*
> -        * match data block required for the compiled
> -        * pattern in pcre2
> -        */
> -       pcre2_match_data *match_data;
> -#endif
> -       pthread_mutex_t match_mutex;
>  };
>
>  int regex_prepare_data(struct regex_data **regex, char const *pattern_st=
ring,
> @@ -98,13 +94,6 @@ int regex_prepare_data(struct regex_data **regex, char=
 const *pattern_string,
>                 goto err;
>         }
>
> -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> -       (*regex)->match_data =3D
> -               pcre2_match_data_create_from_pattern((*regex)->regex, NUL=
L);
> -       if (!(*regex)->match_data) {
> -               goto err;
> -       }
> -#endif
>         return 0;
>
>  err:
> @@ -159,13 +148,6 @@ int regex_load_mmap(struct mmap_area *mmap_area, str=
uct regex_data **regex,
>                 if (rc !=3D 1)
>                         goto err;
>
> -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> -               (*regex)->match_data =3D pcre2_match_data_create_from_pat=
tern(
> -                       (*regex)->regex, NULL);
> -               if (!(*regex)->match_data)
> -                       goto err;
> -#endif
> -
>                 *regex_compiled =3D true;
>         }
>
> @@ -223,18 +205,32 @@ out:
>         return rc;
>  }
>
> +static void match_data_thread_free(void *ptr)
> +{
> +       pcre2_match_data_free(ptr);
> +}
> +
> +static void match_data_key_init(void)
> +{
> +       if (__selinux_key_create(&match_data_key, match_data_thread_free)=
 =3D=3D 0)
> +               match_data_key_created =3D 1;
> +       else
> +               match_data_key_alloc_failed =3D 1;
> +}
> +
> +static void __attribute__((destructor)) match_data_key_destroy(void)
> +{
> +       if (match_data_key_created) {
> +               __selinux_key_delete(match_data_key);
> +               match_data_key_created =3D 0;
> +       }
> +}
> +
>  void regex_data_free(struct regex_data *regex)
>  {
>         if (regex) {
>                 if (regex->regex)
>                         pcre2_code_free(regex->regex);
> -
> -#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> -               if (regex->match_data)
> -                       pcre2_match_data_free(regex->match_data);
> -#endif
> -
> -               __pthread_mutex_destroy(&regex->match_mutex);
>                 free(regex);
>         }
>  }
> @@ -242,31 +238,38 @@ void regex_data_free(struct regex_data *regex)
>  int regex_match(struct regex_data *regex, char const *subject, int parti=
al)
>  {
>         int rc;
> -       pcre2_match_data *match_data;
> -       __pthread_mutex_lock(&regex->match_mutex);
> +       bool slow;
> +       pcre2_match_data *match_data =3D NULL;
> +
> +       __selinux_once(match_data_key_once, match_data_key_init);
> +
> +       if (!match_data_key_alloc_failed) {
> +               match_data =3D __selinux_getspecific(match_data_key);
> +               if (!match_data) {
> +                       match_data =3D pcre2_match_data_create(1, NULL);
> +                       if (match_data) {
> +                               __selinux_setspecific(match_data_key,
> +                                                       match_data);
> +                       }
> +               }
> +       }
>
> -#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> -       match_data =3D pcre2_match_data_create_from_pattern(regex->regex,=
 NULL);
> -       if (match_data =3D=3D NULL) {
> -               __pthread_mutex_unlock(&regex->match_mutex);
> -               return REGEX_ERROR;
> +       slow =3D (match_data_key_alloc_failed || match_data =3D=3D NULL);
> +       if (slow) {
> +               match_data =3D pcre2_match_data_create_from_pattern(regex=
->regex,
> +                                                                       N=
ULL);
> +               if (!match_data)
> +                       return REGEX_ERROR;
>         }
> -#else
> -       match_data =3D regex->match_data;
> -#endif
>
> -       rc =3D pcre2_match(regex->regex, (PCRE2_SPTR)subject,
> -                        PCRE2_ZERO_TERMINATED, 0,
> -                        partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NU=
LL);
> +       rc =3D pcre2_match(
> +           regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
> +           partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
>
> -#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> -       // pcre2_match allocates heap and it won't be freed until
> -       // pcre2_match_data_free, resulting in heap overhead.
> -       pcre2_match_data_free(match_data);
> -#endif
> +       if (slow)
> +               pcre2_match_data_free(match_data);
>
> -       __pthread_mutex_unlock(&regex->match_mutex);
> -       if (rc > 0)
> +       if (rc >=3D 0)
>                 return REGEX_MATCH;
>         switch (rc) {
>         case PCRE2_ERROR_PARTIAL:
> @@ -305,10 +308,6 @@ static struct regex_data *regex_data_create(void)
>  {
>         struct regex_data *regex_data =3D
>                 (struct regex_data *)calloc(1, sizeof(struct regex_data))=
;
> -       if (!regex_data)
> -               return NULL;
> -
> -       __pthread_mutex_init(&regex_data->match_mutex, NULL);
>         return regex_data;
>  }
>
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index b0ef5a75..5feb5d97 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -14,6 +14,7 @@ extern size_t selinux_page_size;
>  #pragma weak pthread_key_create
>  #pragma weak pthread_key_delete
>  #pragma weak pthread_setspecific
> +#pragma weak pthread_getspecific
>
>  /* Call handler iff the first call.  */
>  #define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)                     =
\
> @@ -42,6 +43,9 @@ extern size_t selinux_page_size;
>                         pthread_setspecific(KEY, VALUE); \
>         } while (0)
>
> +#define __selinux_getspecific(KEY) \
> +       (pthread_getspecific !=3D NULL ? pthread_getspecific(KEY) : NULL)
> +
>  /* selabel_lookup() is only thread safe if we're compiled with pthreads =
*/
>
>  #pragma weak pthread_mutex_init
> --
> 2.55.0.229.g6434b31f56-goog
>
