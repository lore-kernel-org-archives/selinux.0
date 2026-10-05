Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A04C0420
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213564; cv=pass; b=lMj3ayZP2wFgFjDRmZsmew+U/UxkdyVco7HK2J1JKGzpU2MzS1lmm4VzGJ++HWI/1q7Eb6XdC777i75ZZtBWUCEQWIqD90eOQiXHTE4bSxFB5+pWZIdpS1AhDwxYs9R/yS2XzRgDAJ6Q3NQ7VAL8KU8hycAfXX8g4bbfhThWaKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213564; c=relaxed/simple;
	bh=CWYgTTudbQ+hBLtqkKk7Bj785EyGMeLkhMReUajtXkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqtlI5KiyN466VFhBUl6h8PCPSSH/ZkUdP7cEjs/sjbYqmfoBnP93KMND9qAtUPqtQBPSkpRwBF0ZFNjhp969x96Mi4cbgHSEozwyl8hJN1k5Nx3UVUONnO4WWZCTBhsHQpb3D78xp77EgRWO2Z50bv0zrsrzXZKEL1zfWKA0dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTCXoY68; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTCXoY68"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-67408b109e3so727229d50.1
        for <selinux@vger.kernel.org>; Mon, 05 Oct 2026 08:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791213562; cv=none;
        d=google.com; s=arc-20260327;
        b=mUF4J1TpoUDVf94eLfysXIigkP5t9h1/GF0dCEvih/RnCuF4GyEq1gE3AlAZmadAMi
         Fl+QJsj+8x6rGIuGbUPePTWbM0pOBZsB+44+2bf2zXFkBg5OrMfs5wwA4/Q9Gpo5O5bF
         /1CsV37awTge94bq1nTfmoUox0IEHpU41m1PjfGA4BiDe1obHt+5Xi8T0Uswwz8iHgrx
         b0mKKDumtQ7qB4+io8P5VmOaA089esnR66hsIZ+li+t8W7z0zcOsbAHRaoBNlcgOle31
         KFUps3ATw6mnK89SjChl+wnTaWmZPsQiHQdgyOC11dd7H/BDH88LhmBvFTijVqswAOWA
         blEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vSNqMlgbvGdIu8ePp3sUILEQAXLg0R4+dyPtI3RChz0=;
        fh=0nv0AHvy4hYhIMAOcVSR9tgcJ92aQGJ2PAcXX74XjlI=;
        b=ZwQW7pC+lmibLRizVHADj1X/ql49731jJx4Viu0MLHPpdTGaMtqJtEmSG2ThXaR3gK
         FwRRgKDgbisiLQNvQqPMwOPwfT1pjWXqXvVmaqx9+k7quGSmAzqaE8nousXr+vmirM1a
         qCZNOLlS5Q2QwyMxM/W9AuB529sLujm4x2v4RlmZG74stEuJSr14lXQc2IhPTXDhQ0W4
         MVoKSgaEWMXO7ElXS5uUJzMK0kv98IAnHowZ9ZcY1at/epD41Fljnr7yqpjfMmFhHqfg
         RkIMkYaLwpEyN2TFXv7aKw7OOYYsxratZA7W675fs65lTCPVEL6+S7R266FAINUAPgu5
         SZLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791213562; x=1791818362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vSNqMlgbvGdIu8ePp3sUILEQAXLg0R4+dyPtI3RChz0=;
        b=oTCXoY688XNSOGzyG/wVC8/x2X8MEmQHySkRKfxTUfITvX5agO3kMJZ+lzPc0U8f98
         k95pvHvVITqIzIuNILuWGbQ4wQzFJz7q3Xc42wm8eVL3gTQGa3H54X6LuI/raGTG1SA5
         Rp2L2gyHymgyqJGlwGCUM6Xxgel2qDFoBTISrnmsRfLKGR28FIhSvd2+g9wtMnuJOrzx
         CQ/q7Wruhe+WyZC2gy3r/TsWwnny0tREeTa1UjHpBBS+/wcHEL/s8BTemSAaYxPYXr/b
         5OGWrfwVjfY4LSq3AM5/gxdUn8N+/m5qKV9ZMhJiufLZBEFlDuANIJYTjzKl6eumvrsT
         yRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213562; x=1791818362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSNqMlgbvGdIu8ePp3sUILEQAXLg0R4+dyPtI3RChz0=;
        b=Pc5oX6QTtWnn0oga/XiC994bf/vBiJHigZGBjqnkL2zph0Fx+qBEv159V2cqEOVb2l
         OLLBkGTeuIGoYJt8nWSivBZJPQDl3g1U+7BVZlsJTFFpJC1dE0+i7rcmuYXf0p+MtDGX
         I8BCFSp65oCDVLPgnGrThDpi+3Cbqkjx3hDLlE/QfehSz/ErGMMRKnaLHNWZYWsC9WvU
         p9QXqodQVj93uZ+sMhd80ZkVVASFsNlubTHrgycNc8Vrz571H/o5mDCqpcxpMBeq2xQ1
         GBgz0o430mZZZg8VLi+SADvklscfjhdwq4td09MtzZQeyiOynO7s2yAWQ2tIsTQwhdbE
         RVLQ==
X-Gm-Message-State: AFq9FYLIBazasSJFjHA1dksU0C/ax6YQiVJc6Edsl/rSDpU0cquQj+TP
	z5Hy9pWyX3HfzPXJI7pSOhD7u5RkhXEpVd/7L6V+N3MW2WkdB65AcMjOh+kpSBelmAZ0vKMZl3d
	B6Qe2tszJhKucxDpqsawJAFAjt2JnLnU=
X-Gm-Gg: AYBFou1sG7/2wRdcRyCcYDeXyOx6RRox2r49Pd66Plv4SiQw43/qsfCpQvIbVEioN9y
	axYs0+6lP+2lOGmtKdXolRJbI9Qw4QlthwbBQr3OUVuH1cw0ZQ8c7JhSyWwj1hL75i1ToGwtz9/
	vtjw4Gx/90mIscsmz+QzNUpWu5pTagRoZeod/ErpRS75lZjwGC9N/y1baLXADVIz8AI1HqHP5nC
	hQUR3bEQ6uIZsrgCb9Ex3/ECfptSqL76pLer8H0qAx3W/lxTu4aBSYS4f9EAzjh0etiy3e/Awmo
	C+GeWDI0Hnp3BEG3fofQ1AC5KB9LfFW4yI1XJqOPRUTV/oIXhAQl1zQ=
X-Received: by 2002:a05:690e:b83:b0:677:df02:fce with SMTP id
 956f58d0204a3-677df0212cemr855515d50.5.1791213561542; Mon, 05 Oct 2026
 08:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005133143.91648-1-lautrbach@redhat.com> <20261005133143.91648-2-lautrbach@redhat.com>
In-Reply-To: <20261005133143.91648-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 5 Oct 2026 11:19:10 -0400
X-Gm-Features: AclHuK8s7xkJ12IXRlX_QFBeGQqrkcBk9MUpJ4Gc6tg0UX6iIZMmN1tYNmpZCP4
Message-ID: <CAEjxPJ54A95Rsjg=7jvqqrxoOM82FP7of3SSSsJMmO2N3m7Z0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: Use SHA256 for label digests
To: Petr Lautrbach <lautrbach@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:41=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> SHA-1 is considered obsolete
>
> Use hashing code from libsemanage/src/sha256.*
>
> Provide versioned selabel_hash_all_partial_matches() symbol
> - selabel_hash_all_partial_matches@LIBSELINUX_1.0 generates original SHA1=
 digest
>   and uses 20 bytes (SHA1_HASH_SIZE)
> - selabel_hash_all_partial_matches@@LIBSELINUX_3.12 generates SHA256 dige=
st and
>   uses 32 bytes (SHA256_HASH_SIZE)
>
> All external selabel_hash_all_partial_matches() users has to make sure th=
at they
> provide "uint8_t *digest" with size at least 32 bytes.

To be clear, you mean all external users of LIBSELINUX_3.12 and later
versions have to do this.

I don't think the symbol versioning helps Android because its user is
within libselinux itself and will always be built against the latest
version, but the in-libselinux caller is still expecting SHA1 digests.
That's why we need #ifdef ANDROID within hash_all_partial_matches() to
fall back to using SHA1 for Android builds IIUC.

Otherwise, a couple of nits below.

> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 5112c59cdd5c..a229373af09c 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -214,28 +214,27 @@ int read_spec_entries(char *line_buf, size_t nread,=
 const char **errbuf,
>  /* Once all the specfiles are in the hash_buf, generate the hash. */
>  void digest_gen_hash(struct selabel_digest *digest)
>  {
> -       Sha1Context context;
> +       Sha256Context context;
>         size_t remaining_size;
>         const unsigned char *ptr;
> -       const uint32_t chunkSize =3D UINT32_MAX >> 3;
>
>         /* If SELABEL_OPT_DIGEST not set then just return */
>         if (!digest)
>                 return;
>
> -       Sha1Initialise(&context);
> +       Sha256Initialise(&context);
>
>         /* Process in blocks of chunkSize bytes */

This comment is no longer correct and can be dropped.

>         remaining_size =3D digest->hashbuf_size;
>         ptr =3D digest->hashbuf;
> -       while (remaining_size > chunkSize) {
> -               Sha1Update(&context, ptr, chunkSize);
> -               remaining_size -=3D chunkSize;
> -               ptr +=3D chunkSize;
> +       while (remaining_size > UINT32_MAX) {
> +               Sha256Update(&context, ptr, UINT32_MAX);

Sha256Update() takes size_t and tracks length as uint64_t so the
>UINT32_MAX split that existed for Sha1 is no longer necessary. You
could collapse the entire loop and the subsequent Sha256Update() below
to a single Sha256Update(,,,,, digest->hashbuf_size) call.

> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index 9b439d8e7f22..b39e41d40aff 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -237,8 +237,8 @@ LIBSELINUX_1.0 {
>      sidput;
>      string_to_av_perm;
>      string_to_security_class;
> -  local:
> -    *;
> +    local:
> +      *;

This seems like a spurious whitespace change.
