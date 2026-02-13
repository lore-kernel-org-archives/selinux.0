Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F017ADE0
	for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996328; cv=pass; b=K9oC3RR3Clzza16q1wGRfOYNb0GnlJA3GtsIawKGeHybyiYoiCnCWUiSQcEScGs0iBueTLC/+IGSPFUXb/ZCxEiKhSSi6ma9dtLo2ZImDpIpRmZUwWBQUUrMG0VhoPn7sSd9t3uc3kDubLoQP57EiAD7Af3Rl36ClsFqHmT3uBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996328; c=relaxed/simple;
	bh=3PtLdDDFiF9mK43GbgdvqQrMkkKBv1AEr/tsxlgWLJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg6hJj9Utc2lm614WOrTVfzcXy0szNEQO5HxvM6aHJFAGOjD0UyTxhnZv7n7c4KiXoSHXfSZiuPH8DFecbDL7tM1Hssr3zIyaORUVTllotAmz44ahZFMajuxpbtJxFS18/hEDd024idMIwBLG/rfmR32lsC+AAV5VNlcG++wNCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx9Z1jwK; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx9Z1jwK"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3871017fea2so18383431fa.0
        for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 07:25:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770996325; cv=none;
        d=google.com; s=arc-20240605;
        b=GwTSTNBikVzv+swdYDs6i4bp939NBCA1NgPZ6/tRcDGk0OUWHwLx9qdB9Xa7iDJ9g1
         K6iYPwSQGeOIChZKmODkB88x3Okr43pG9fazfieodYzkgZb2VY+UWTgOtn5BLBCVSo65
         yDW6gZsK84hXVzAFrb4B1T2Y5a42WHahZuYfGlZVg9Sg8s67VrlG0xNX6Q4MRRliD1AZ
         TlOOhu/UaZuCK7XLCU0AOupRN6obvbV4lXTAn/eyjTHF+XCvRwZn5eh0LhwegvxBb8eq
         SPFm0bp0INmRNBgjhMJ1GWQNPM7gM7hETzrOZGIkqYmvypdeF0D2TbAS3TOrgBqdKmpd
         d5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQNh1aLHxxd97Dq+kPC5hIpDEbVzTi1acjl8McSk9bo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=R7K/0RiztGjFyLwrBExW6NXOqEjE5eRiOqyfVgyHv4ADS7JHKzZ6Oc3/tvJ6SitKQk
         ItOhpJzY0GU8yp2FW8eNhb+1Nm4DDjhyPydzpvbFVFBsO6ro+PprDzydEd3lLtJHrwyT
         E1wU0YiOup6+3xpflBEPlKY0/e5E3eaTEatW8g78hr9ZapQ5vJs+YctWt3by07I2vhvT
         4xPItGqKxWMfQ6y0AurEdIOdfD/gDkoTOqwaRVNWJCMIyFh7bEuWmhKOEKL7fnFdmMWv
         YnkvWDVXmZQOnYKu6OxW82LMO/nvxt1tRgemUGRGQbZxBRZ1cpPb9ZAsDyqRU3BDfvdT
         O3RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996325; x=1771601125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQNh1aLHxxd97Dq+kPC5hIpDEbVzTi1acjl8McSk9bo=;
        b=Wx9Z1jwKOk/AkCQMWYIL114f9CZ4++A4kYr/0IOl4WDv1Kcu4I38/+ZQMw1aW20yE6
         k1voXwJhm/ekbqFOR3iHaXEzwmlK6Bc0dbrDFyQFlNhL1QHL7ZaD4BIs3r39hvouUGbk
         OkXvOyiVhnkrwLdMGyWowgnZbfNe7Xkb5oKEGB59BgVvAn6meJkWhb5I6j2s0LjcHzGn
         FURwJcYN9NBrSX1YObojr83sbI/yeyiOapiDekm4uC4096HT/1knLM/iH6EvwJzxBS0K
         RNwltqCjhCH79ViRTm8yED+76jFcJwGsPyEk01yTC/ku0zkoE4dEzqMkgYkc3PhAPKl0
         vOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996325; x=1771601125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQNh1aLHxxd97Dq+kPC5hIpDEbVzTi1acjl8McSk9bo=;
        b=up0IZnyhqfYSylKLZUUTWUzmyGlZhgAyskWIuttw3d2OAFtgrLpGk3WQzLMB6iAmFX
         wMq36V3+USK5Vsz8jPtz7VCkebviCVwcJakqZybx3xEDO7d3VHy9UjL5BQsQ+NkcLHdg
         GSoBcu2JL5Qe2Ih5UnTWRU0jsqLVZxduiVDRNBHlAJ97qFmqLX7ffNidBgbYaT6kKS3v
         5t+TrhEMmEEMppCN6YKq/pDmhl8sRQ41l5XrOn9tgRwUn5bwwtdX9rLIG1VOEo2ynAcl
         7MJV63zdJzh/n/Zjq2wjYFG7sfFXSLAREFIk8KHWEvlUHfJ8QXhlc40Rlcz9kA6GMgDw
         +8Dg==
X-Gm-Message-State: AOJu0Yzt/2r8ju4ZMA5DzpEqnK3yJvk2yNr30okHevH5acNSaD+YZw/k
	7FFXh2t4Z2aRa4WEpE+M+iRK6W5n1ZGqRCi4S2y5TWzQlhPEaNUe/L7rK5rFUnOa4XPKov18FF8
	/lcExwGIs3KDUku/YBV0BSPLGIKHqvcU=
X-Gm-Gg: AZuq6aIzRgHDKtWB7rBPMOBXiq0OOCYaj4LdHjF8Ous+uvbI5xcZtRupGA8vtdPXrFw
	hcpCjCyLmjxbMumFoRiZC9foISX6ZzrSilcGX1BXCEp+o007OQd+LdERqiR/Au77DtrtpkwCRH9
	EbnjZ7gqLpQZ+2jG6dHrbHbjOvdrGmR5NhiRcdFHTem9jD2wxzNjP7FDXEF0IROcoxq67Pzus0c
	gGlNsYRK9CNoYAraWNtmNyVgkTdrLFNTXb9mdlVubB9YCgAuFw/2iK/eytN5fVe+A7sHK/sr6zi
	7wv9
X-Received: by 2002:ac2:5b4b:0:b0:59e:5589:26c6 with SMTP id
 2adb3069b0e04-59f6cfa4851mr123447e87.9.1770996324915; Fri, 13 Feb 2026
 07:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202143554.97209-1-cgoettsche@seltendoof.de> <20260202143554.97209-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Feb 2026 10:25:13 -0500
X-Gm-Features: AZwV_QjiOchh3OVBcRvdLIDLF9BNbQkv2_kaDyYKvwBF3_9ktNQTGaMJXiJTpWU
Message-ID: <CAP+JOzR4nhWSie-jfVe81810aQNoUsnQPnKDeEc3_8Q1qE6JFw@mail.gmail.com>
Subject: Re: [PATCH 3/4] libselinux: use C11 atomics
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 3:59=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use standard C11 atomics for compatibility.
> Also explicitly use atomic types to ensure well-defined behavior even on
> obscure platforms.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label.c          | 12 ++++++------
>  libselinux/src/label_file.c     | 31 +++++++------------------------
>  libselinux/src/label_file.h     | 32 ++++++--------------------------
>  libselinux/src/label_internal.h |  5 +++--
>  4 files changed, 22 insertions(+), 58 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 2c510290..40ba9f0b 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -127,14 +127,14 @@ int selabel_validate(struct selabel_lookup_rec *con=
texts)
>         bool validated;
>         int rc;
>
> -       validated =3D __atomic_load_n(&contexts->validated, __ATOMIC_ACQU=
IRE);
> +       validated =3D atomic_load_explicit(&contexts->validated, memory_o=
rder_acquire);
>         if (validated)
>                 return 0;
>
>         __pthread_mutex_lock(&contexts->lock);
>
>         /* Check if another thread validated the context while we waited =
on the mutex */
> -       validated =3D __atomic_load_n(&contexts->validated, __ATOMIC_ACQU=
IRE);
> +       validated =3D atomic_load_explicit(&contexts->validated, memory_o=
rder_acquire);
>         if (validated) {
>                 __pthread_mutex_unlock(&contexts->lock);
>                 return 0;
> @@ -142,7 +142,7 @@ int selabel_validate(struct selabel_lookup_rec *conte=
xts)
>
>         rc =3D selinux_validate(&contexts->ctx_raw);
>         if (rc =3D=3D 0)
> -               __atomic_store_n(&contexts->validated, true, __ATOMIC_REL=
EASE);
> +               atomic_store_explicit(&contexts->validated, true, memory_=
order_release);
>
>         __pthread_mutex_unlock(&contexts->lock);
>
> @@ -166,14 +166,14 @@ static int selabel_fini(const struct selabel_handle=
 *rec,
>         if (!translating)
>                 return 0;
>
> -       ctx_trans =3D __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
> +       ctx_trans =3D atomic_load_explicit(&lr->ctx_trans, memory_order_a=
cquire);
>         if (ctx_trans)
>                 return 0;
>
>         __pthread_mutex_lock(&lr->lock);
>
>         /* Check if another thread translated the context while we waited=
 on the mutex */
> -       ctx_trans =3D __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
> +       ctx_trans =3D atomic_load_explicit(&lr->ctx_trans, memory_order_a=
cquire);
>         if (ctx_trans) {
>                 __pthread_mutex_unlock(&lr->lock);
>                 return 0;
> @@ -181,7 +181,7 @@ static int selabel_fini(const struct selabel_handle *=
rec,
>
>         rc =3D selinux_raw_to_trans_context(lr->ctx_raw, &ctx_trans);
>         if (rc =3D=3D 0)
> -               __atomic_store_n(&lr->ctx_trans, ctx_trans, __ATOMIC_RELE=
ASE);
> +               atomic_store_explicit(&lr->ctx_trans, ctx_trans, memory_o=
rder_release);
>
>         __pthread_mutex_unlock(&lr->lock);
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b785eab6..de6937f5 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -578,6 +578,7 @@ static int load_mmap_regex_spec(struct mmap_area *mma=
p_area, bool validating, bo
>         uint32_t data_u32, ctx_id, lineno;
>         uint16_t data_u16, regex_len;
>         uint8_t data_u8;
> +       bool compiled;
>         int rc;
>
>         rspec->from_mmap =3D true;
> @@ -663,8 +664,8 @@ static int load_mmap_regex_spec(struct mmap_area *mma=
p_area, bool validating, bo
>         /*
>          * Read pcre regex related data
>          */
> -       rc =3D regex_load_mmap(mmap_area, &rspec->regex, do_load_precompr=
egex,
> -                            &rspec->regex_compiled);
> +       rc =3D regex_load_mmap(mmap_area, &rspec->regex, do_load_precompr=
egex, &compiled);
> +       rspec->regex_compiled =3D compiled;
>         if (rc < 0)
>                 return -1;
>
> @@ -1637,11 +1638,7 @@ static struct lookup_result *lookup_check_node(str=
uct spec_node *node, const cha
>                                         if (file_kind =3D=3D LABEL_FILE_K=
IND_ALL || lspec->file_kind =3D=3D LABEL_FILE_KIND_ALL || lspec->file_kind =
=3D=3D file_kind) {
>                                                 struct lookup_result *r;
>
> -#ifdef __ATOMIC_RELAXED
> -                                               __atomic_store_n(&lspec->=
any_matches, true, __ATOMIC_RELAXED);
> -#else
> -#error "Please use a compiler that supports __atomic builtins"
> -#endif
> +                                               atomic_store_explicit(&ls=
pec->any_matches, true, memory_order_relaxed);
>
>                                                 if (strcmp(lspec->lr.ctx_=
raw, "<<none>>") =3D=3D 0) {
>                                                         errno =3D ENOENT;
> @@ -1704,11 +1701,7 @@ static struct lookup_result *lookup_check_node(str=
uct spec_node *node, const cha
>                                 struct lookup_result *r;
>
>                                 if (rc =3D=3D REGEX_MATCH) {
> -#ifdef __ATOMIC_RELAXED
> -                                       __atomic_store_n(&rspec->any_matc=
hes, true, __ATOMIC_RELAXED);
> -#else
> -#error "Please use a compiler that supports __atomic builtins"
> -#endif
> +                                       atomic_store_explicit(&rspec->any=
_matches, true, memory_order_relaxed);
>                                 }
>
>                                 if (strcmp(rspec->lr.ctx_raw, "<<none>>")=
 =3D=3D 0) {
> @@ -2123,12 +2116,7 @@ static void spec_node_stats(const struct spec_node=
 *node)
>         for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
>                 const struct literal_spec *lspec =3D &node->literal_specs=
[i];
>
> -#ifdef __ATOMIC_RELAXED
> -               any_matches =3D __atomic_load_n(&node->literal_specs[i].a=
ny_matches, __ATOMIC_RELAXED);
> -#else
> -#error "Please use a compiler that supports __atomic builtins"
> -#endif
> -
> +               any_matches =3D atomic_load_explicit(&node->literal_specs=
[i].any_matches, memory_order_relaxed);
>                 if (!any_matches) {
>                         COMPAT_LOG(SELINUX_WARNING,
>                                 "Warning!  No matches for (%s, %s, %s)\n"=
,
> @@ -2141,12 +2129,7 @@ static void spec_node_stats(const struct spec_node=
 *node)
>         for (uint32_t i =3D 0; i < node->regex_specs_num; i++) {
>                 const struct regex_spec *rspec =3D &node->regex_specs[i];
>
> -#ifdef __ATOMIC_RELAXED
> -               any_matches =3D __atomic_load_n(&rspec->any_matches, __AT=
OMIC_RELAXED);
> -#else
> -#error "Please use a compiler that supports __atomic builtins"
> -#endif
> -
> +               any_matches =3D atomic_load_explicit(&rspec->any_matches,=
 memory_order_relaxed);
>                 if (!any_matches) {
>                         COMPAT_LOG(SELINUX_WARNING,
>                                 "Warning!  No matches for (%s, %s, %s)\n"=
,
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 8fcf74e3..5c17fe41 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -85,8 +85,8 @@ struct regex_spec {
>         uint16_t prefix_len;                    /* length of fixed path p=
refix */
>         uint8_t inputno;                        /* Input number of source=
 file */
>         uint8_t file_kind;                      /* file type */
> -       bool regex_compiled;                    /* whether the regex is c=
ompiled */
> -       bool any_matches;                       /* whether any pathname m=
atch */
> +       atomic_bool regex_compiled;             /* whether the regex is c=
ompiled */
> +       atomic_bool any_matches;                /* whether any pathname m=
atch */
>         bool from_mmap;                         /* whether this spec is f=
rom an mmap of the data */
>  };
>
> @@ -98,7 +98,7 @@ struct literal_spec {
>         uint16_t prefix_len;                    /* length of fixed path p=
refix, i.e. length of the literal match */
>         uint8_t inputno;                        /* Input number of source=
 file */
>         uint8_t file_kind;                      /* file type */
> -       bool any_matches;                       /* whether any pathname m=
atch */
> +       atomic_bool any_matches;                /* whether any pathname m=
atch */
>         bool from_mmap;                         /* whether this spec is f=
rom an mmap of the data */
>  };
>
> @@ -410,14 +410,7 @@ static int compile_regex(struct regex_spec *spec, ch=
ar *errbuf, size_t errbuf_si
>          * init_routine does not take a parameter, it's not possible
>          * to use, so we generate the same effect with atomics and a
>          * mutex */
> -#ifdef __ATOMIC_RELAXED
> -       regex_compiled =3D
> -               __atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
> -#else
> -       /* GCC <4.7 */
> -       __sync_synchronize();
> -       regex_compiled =3D spec->regex_compiled;
> -#endif
> +       regex_compiled =3D atomic_load_explicit(&spec->regex_compiled, me=
mory_order_acquire);
>         if (regex_compiled) {
>                 return 0; /* already done */
>         }
> @@ -425,14 +418,7 @@ static int compile_regex(struct regex_spec *spec, ch=
ar *errbuf, size_t errbuf_si
>         __pthread_mutex_lock(&spec->regex_lock);
>         /* Check if another thread compiled the regex while we waited
>          * on the mutex */
> -#ifdef __ATOMIC_RELAXED
> -       regex_compiled =3D
> -               __atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
> -#else
> -       /* GCC <4.7 */
> -       __sync_synchronize();
> -       regex_compiled =3D spec->regex_compiled;
> -#endif
> +       regex_compiled =3D atomic_load_explicit(&spec->regex_compiled, me=
mory_order_acquire);
>         if (regex_compiled) {
>                 __pthread_mutex_unlock(&spec->regex_lock);
>                 return 0;
> @@ -474,13 +460,7 @@ static int compile_regex(struct regex_spec *spec, ch=
ar *errbuf, size_t errbuf_si
>         }
>
>         /* Done. */
> -#ifdef __ATOMIC_RELAXED
> -       __atomic_store_n(&spec->regex_compiled, true, __ATOMIC_RELEASE);
> -#else
> -       /* GCC <4.7 */
> -       spec->regex_compiled =3D true;
> -       __sync_synchronize();
> -#endif
> +       atomic_store_explicit(&spec->regex_compiled, true, memory_order_r=
elease);
>         __pthread_mutex_unlock(&spec->regex_lock);
>         return 0;
>  }
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 743dbf94..dd233533 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -10,6 +10,7 @@
>
>  #include <stdlib.h>
>  #include <stdarg.h>
> +#include <stdatomic.h>

My understanding is that musl does not support C11 atomics. Its
compatibility pages lists everything under stdatomic.h as "missing".
Since we have people compiling the SELinux userspace on systems using
musl, we can't switch to C11 atomics until musl supports them.
The patch looks fine to me otherwise.

Thanks,
Jim

>  #include <stdio.h>
>  #include <selinux/selinux.h>
>  #include <selinux/label.h>
> @@ -70,10 +71,10 @@ extern void digest_gen_hash(struct selabel_digest *di=
gest);
>
>  struct selabel_lookup_rec {
>         char * ctx_raw;
> -       char * ctx_trans;
> +       char * _Atomic ctx_trans;
>         pthread_mutex_t lock;   /* lock for validation and translation */
>         unsigned int lineno;
> -       bool validated;
> +       atomic_bool validated;
>  };
>
>  struct selabel_handle {
> --
> 2.51.0
>
>
