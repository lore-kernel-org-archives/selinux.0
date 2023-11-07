Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA6BC4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjKGQTo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 11:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344492AbjKGQTD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 11:19:03 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504A58FA5
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 08:12:06 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so6309151e87.0
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 08:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699373524; x=1699978324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCA+3pMVfrPOTyxVjEZzvQ8q8Ssff/31TVwayT9wPnE=;
        b=HSm+SFa/qfz2MUNApT6tttzu3Yre2kAI+7mtFPR0x+IDozzbmkJl3n5W+mE4pl68Wn
         kuRPPtl7mX6Ha2TG0eJZD9LxeJMjeZ47BDSxCbIBf5c3XUsklD8fajlSamODbFynyedW
         nX/xBkigVcaZiVBJILZQiwd09v4MDQmafNiGh17v4FD6uLAOGdE6KWHIHyIY/Hbuys/S
         S7kCu4pAvdKhmJiYWpeG/SBLmKlTAGm6XuAqiRgEYk0DmuCOYe1jG0Xfv1QcakyToXrT
         g8a2/kVcbmhcOar4kOrnBHm89PP0Dm1KxZHIpdAhEhvE8XMmZHmMWO52i7W00hOSRrGA
         /9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373524; x=1699978324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCA+3pMVfrPOTyxVjEZzvQ8q8Ssff/31TVwayT9wPnE=;
        b=QmRFoaQzPu97wgvKlb0yqGkbflLp4PxcAClPeexQIDHqOSG5x64OA4d5ml9P4Z2RKA
         YqJnPX9xT+Kk7TVOHoiajgiPEP0++87rZfatY/X8lneHLzpBG9nN2YMv4zfqJK8UhM9r
         lIIWgrFUmwBZZ1Aeigx9b2qhGwSX1ZtAY7ywk6w6uGhhSft6HtOXOiIWYy+VkX9ydFBK
         Qnam8AYjXTkOUTzvZsseoaJRJPHvK4AlY9gAvwuchD3SKaycfkvUd4ve85giZGHn1Wqs
         3Ql6QPnqNdpAyKJgEYn1WuJgYIezs1LTUgKcbImelOw+VOyBvwoMGOIqs6FARQ2YKYeD
         +tNA==
X-Gm-Message-State: AOJu0YzMhCzg6HTEunTWzVA4iGMmn2UupIBbbdi/lqepRFQA1SJCOget
        g9WsUxHYZaKNzfoyOljzLj/UneoxydaTgQG8bH9vW75TKiI=
X-Google-Smtp-Source: AGHT+IHPpjaxYkd5yShcemxgw2/5koCiVACGIV82S+38x5MhsYnlBBc9UHP1F/n4GkbeEoa2C9fVAW94ymiAapeUdpw=
X-Received: by 2002:a05:6512:1382:b0:500:7aba:4d07 with SMTP id
 fc2-20020a056512138200b005007aba4d07mr1251595lfb.22.1699373524077; Tue, 07
 Nov 2023 08:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20231101163911.178218-1-cgzones@googlemail.com> <20231101163911.178218-2-cgzones@googlemail.com>
In-Reply-To: <20231101163911.178218-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 11:11:52 -0500
Message-ID: <CAP+JOzT_i9nkghx-9NWhfmz0NOYh=c+9VDS1U4=q0F--sgn=eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: rework saturation check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:39=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Several values while parsing kernel policies, like symtab sizes or
> string lengths, are checked for saturation.  They may not be set to the
> maximum value, to avoid overflows or occupying a reserved value, and
> many of those sizes must not be 0.  This is currently handled via the
> two macros is_saturated() and zero_or_saturated().
>
> Both macros are tweaked for the fuzzer, because the fuzzer can create
> input with huge sizes.  While there is no subsequent data to provide
> the announced sizes, which will be caught later, memory of the requested
> size is allocated, which would lead to OOM reports.  Thus the sizes for
> the fuzzer are limited to 2^16.  This has the drawback of the fuzzer
> not checking the complete input space.
>
> Rework the saturation checks to actually check if there is enough data
> available for the announced size before allocating actual memory.
> This only works for input via mapped memory, since the remaining size
> for streams is not easily available.
>
> Application like setools do currently not benefit from this change,
> since they load the policy via a stream.  There are currently multiple
> interfaces to load a policy, so reworking them to use mapped memory by
> default might be subject for future work.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/avtab.c         |  2 +-
>  libsepol/src/context.c       |  2 +-
>  libsepol/src/module_to_cil.c |  2 +-
>  libsepol/src/policydb.c      | 16 ++++++++--------
>  libsepol/src/private.h       | 22 ++++++++++++++++------
>  libsepol/src/services.c      |  2 +-
>  6 files changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 6ab49c5e..f379d8d8 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -601,7 +601,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, u=
int32_t vers)
>                 goto bad;
>         }
>         nel =3D le32_to_cpu(buf[0]);
> -       if (!nel) {
> +       if (zero_or_saturated(nel, fp, sizeof(uint32_t) * 3)) {

I think that I would prefer zero_or_staturated() and is_saturated() to
be left alone and just add the additional check where it can be used.

Like:
if (zero_or_saturated(nel) || exceeds_available_bytes(nel, fp,
sizeof(unit32_t)*3))) {


>                 ERR(fp->handle, "table is empty");
>                 goto bad;
>         }
> diff --git a/libsepol/src/context.c b/libsepol/src/context.c
> index 5cc90afb..5ee21724 100644
> --- a/libsepol/src/context.c
> +++ b/libsepol/src/context.c
> @@ -297,7 +297,7 @@ int context_from_string(sepol_handle_t * handle,
>         char *con_cpy =3D NULL;
>         sepol_context_t *ctx_record =3D NULL;
>
> -       if (zero_or_saturated(con_str_len)) {
> +       if (con_str_len =3D=3D 0 || con_str_len =3D=3D SIZE_MAX) {

This doesn't need to change if my suggestion above is followed.

>                 ERR(handle, "Invalid context length");
>                 goto err;
>         }
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index d2868019..1d0a507c 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -122,7 +122,7 @@ static int get_line(char **start, char *end, char **l=
ine)
>
>         for (len =3D 0; p < end && *p !=3D '\n' && *p !=3D '\0'; p++, len=
++);
>
> -       if (zero_or_saturated(len)) {
> +       if (len =3D=3D 0 || len =3D=3D SIZE_MAX) {

This wouldn't have to change either.

>                 rc =3D 0;
>                 goto exit;
>         }
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f608aba4..00a986e8 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2854,7 +2854,7 @@ static int ocontext_read_xen(const struct policydb_=
compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 c->sid[0] =3D le32_to_cpu(buf[0]);
> -                               if (is_saturated(c->sid[0]))
> +                               if (c->sid[0] > 127)

Where does the 127 come from? Practically, 127 is way more than we
would probably ever have, but I don't think there is a limit.

There might be a case to be made that we should set some reasonable
limits for things like initial sids.

>                                         return -1;
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
> @@ -2960,7 +2960,7 @@ static int ocontext_read_selinux(const struct polic=
ydb_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 c->sid[0] =3D le32_to_cpu(buf[0]);
> -                               if (is_saturated(c->sid[0]))
> +                               if (c->sid[0] > 127)

Same comment here.

>                                         return -1;
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
> @@ -3857,7 +3857,7 @@ static int scope_index_read(scope_index_t * scope_i=
ndex,
>         if (rc < 0)
>                 return -1;
>         scope_index->class_perms_len =3D le32_to_cpu(buf[0]);
> -       if (is_saturated(scope_index->class_perms_len))
> +       if (is_saturated(scope_index->class_perms_len, fp, sizeof(uint32_=
t) * 3))

So:
if (is_saturated(scope_index->class_perms_len) ||
exceeds_available_bytes(scope_index->class_perms_len, fp,
sizeof(uint32_t) * 3)) {

>                 return -1;
>         if (scope_index->class_perms_len =3D=3D 0) {
>                 scope_index->class_perms_map =3D NULL;
> @@ -3913,7 +3913,7 @@ static int avrule_decl_read(policydb_t * p, avrule_=
decl_t * decl,
>                 if (rc < 0)
>                         return -1;
>                 nprim =3D le32_to_cpu(buf[0]);
> -               if (is_saturated(nprim))
> +               if (nprim =3D=3D UINT32_MAX)

This can then be unchanged.

>                         return -1;
>                 nel =3D le32_to_cpu(buf[1]);
>                 for (j =3D 0; j < nel; j++) {
> @@ -4036,7 +4036,7 @@ static int scope_read(policydb_t * p, int symnum, s=
truct policy_file *fp)
>                 goto cleanup;
>         scope->scope =3D le32_to_cpu(buf[0]);
>         scope->decl_ids_len =3D le32_to_cpu(buf[1]);
> -       if (zero_or_saturated(scope->decl_ids_len)) {
> +       if (zero_or_saturated(scope->decl_ids_len, fp, sizeof(uint32_t)))=
 {

Again:
if (zero_or_staturated(...) || exceeds_available_bytes()) {

And so on below.

Thanks,
Jim


>                 ERR(fp->handle, "invalid scope with no declaration");
>                 goto cleanup;
>         }
> @@ -4120,8 +4120,8 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>  {
>
>         unsigned int i, j, r_policyvers;
> -       uint32_t buf[5];
> -       size_t len, nprim, nel;
> +       uint32_t buf[5], nprim;
> +       size_t len, nel;
>         char *policydb_str;
>         const struct policydb_compat_info *info;
>         unsigned int policy_type, bufindex;
> @@ -4315,7 +4315,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>                 if (rc < 0)
>                         goto bad;
>                 nprim =3D le32_to_cpu(buf[0]);
> -               if (is_saturated(nprim))
> +               if (is_saturated(nprim, fp, sizeof(uint32_t) * 3))
>                         goto bad;
>                 nel =3D le32_to_cpu(buf[1]);
>                 if (nel && !nprim) {
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index 1833b497..d1fe66b6 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -44,13 +44,23 @@
>
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
>
> -#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> -# define is_saturated(x) (x =3D=3D (typeof(x))-1 || (x) > (1U << 16))
> -#else
> -# define is_saturated(x) (x =3D=3D (typeof(x))-1)
> -#endif
> +static inline int exceeds_available_bytes(size_t x, const struct policy_=
file *fp, size_t req_elem_size)
> +{
> +       size_t req_size;
> +
> +       /* Remaining input size is only available for mmap'ed memory */
> +       if (fp->type !=3D PF_USE_MEMORY)
> +               return 0;
> +
> +       if (__builtin_mul_overflow(x, req_elem_size, &req_size))
> +               return 1;
> +
> +       return req_size > fp->len;
> +}
> +
> +#define is_saturated(x, fp, req_elem_size) ((x) =3D=3D (typeof(x))-1 || =
exceeds_available_bytes(x, fp, req_elem_size))
>
> -#define zero_or_saturated(x) ((x =3D=3D 0) || is_saturated(x))
> +#define zero_or_saturated(x, fp, req_elem_size) ((x) =3D=3D 0 || is_satu=
rated(x, fp, req_elem_size))
>
>  #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 51bd56a0..f9280d89 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1748,7 +1748,7 @@ int str_read(char **strp, struct policy_file *fp, s=
ize_t len)
>         int rc;
>         char *str;
>
> -       if (zero_or_saturated(len)) {
> +       if (zero_or_saturated(len, fp, sizeof(char))) {
>                 errno =3D EINVAL;
>                 return -1;
>         }
> --
> 2.42.0
>
