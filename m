Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CD3644C7
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909082; cv=pass; b=XH6tG9wrpY9gnYjQPd+jlm0MlzwfN/so5Nv/nTifAR5DJdlpAThfqnhojDBhfgVUcg8p4pOr9OJqt2FsLcgBLIvK8OcXmoUz74SMTNdoIFTFvUQEC2vzbJQlrepv4PATDwsGoSXFBPl0/2E07fq5f5J5ylkZOCVMoH0jSRuqSZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909082; c=relaxed/simple;
	bh=gD2V7CSWWzuqLGE1PMhgJpmAmoM0Aj1Ayl9JPxlD8w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0R8mUl0GpBQHRUfpFv0JT4+FwsKdRtpCx6SXHWxp89ol8yImZ6SX1XMeLrqS3q4bBXRo7+uODZcBLepch8+DHzGmym9dtemwgJYNGGCjIdie7dW8VO/OPnUp0u0XtsxTs/7nYGvGr7yrzNW5DvnQxQNIE4HJV6za0hx0KyXj3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGYhOIb8; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGYhOIb8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc85eda6b6so61502685ad.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909080; cv=none;
        d=google.com; s=arc-20240605;
        b=SkcBJxsF10rTB47oOwbuWeTZRyPI8i2++XwIknhaDyC+zd2bchqI5NK04f3qcHOCR5
         S5d32ay7pXMYzrIdKnmHGBhClpBx56pJ+GDbKMh2N0K/xPd7k/EwhEpMpRVEUQUiU0QM
         EvMNVttZgJt8TdfgsxiXIehSftBWXN8ZmbiMvrEd/MN8kny3nkvbi6kWiO5s26UshXci
         3iVs0WUeYuhbbRoeEY88s2vZotZAy19+6OQRiMLzswe2akm682VwJEhnY4S8zsKFVcIn
         gp3/LfvAMpPgLtKGLUWyr3/SXtn1pzMzxTuosrhS5tH4GxqGfQm1ovknPByihuGzMQiQ
         ynmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwgKsFtkeARm620JmDygggwrzoLPKtlxyn6bgQbx2jY=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=itey1dWubEx7JBaDMH3rfsw7xArnA09IdLnbsvUaxqPzOAFrVqf9mVjisa77KWDpzw
         cWq3kKlsrOuij8sY5j1OzONUOOxANWfakfHYbjm+4A0KTwxT1ziANjanXhI0nxY6vZV2
         ZZoU5cJM/plXYQkC7ZmG1PqTACXpRX6tv/X7y8CfdbgarHUF+gwYGyrCVph6NWgxaUO4
         7w0JbjRwtUfkJpRF1X++pJ8WIbicoodbGWEKCqGGSo5wJbl59r7WBDfeN1ZSzhFxLW3x
         7OSNjjf9sj0Ng/SZM0m01jZV+TsvmwqTrbuvtOomXYla4xlEynxW/m+xQHTTs0Rle9UW
         xE/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909080; x=1780513880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwgKsFtkeARm620JmDygggwrzoLPKtlxyn6bgQbx2jY=;
        b=sGYhOIb8K0coUTRkr0sBTgJZ8IyrZWOUQH2LRdfEpOy74rnhyzFWfkmlmyiqktl/K9
         PWJ6gI/xrc5ZMjnfvwNi2hjf/zxnkFPHtZYKupU9ROm/P1D9Zeq1uXRKPCt22pWa4NEx
         I6p7kZtXWS6QUmutB7seDvuMv67NHXzKjk+iyg9lz13dAi5GJycxVjTjhJZc2eofqivP
         cmlSsn0Al3R06bptYhE1/GRmkG0OxQXef37znxhsS3AnGIJtywDgqIFG2VUzakvERoYi
         apRHtr3izr/ZUgLHiETghcYMBxINdI8RMrUgA4t19dKeyTqwnYYMNLpGW/zScKCT8Qi1
         InOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909080; x=1780513880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwgKsFtkeARm620JmDygggwrzoLPKtlxyn6bgQbx2jY=;
        b=PNwBvK9SGIgWB5waGi9nouhoTSQ88CoqBQOMYR5SBLk1AALvgpzkaUQXVlFZHvSKD1
         ouqj2Zt4oD1pbpT/21KsLtq2Ps9OcV1tqcsA/8CDBdjXSqO+/C6yMRrYF0LYHvonlb0g
         V0O0ZAJP1q5idHn4hUq9rRpsJ28gzkR7dXeTmXwvBqoOihPu17xl5FP+gHQGTpd6jf+x
         d7vHAj5b3pYBSbuRhkgcsSB9Wwm+NCfYQ1aCzdCi927qgFZuaXfKg5HZQE4maOv4K1xG
         MTIhWVFh4pUUBC38XohvP0sAz+FJ07l/okuE+n0C4M2WxB0BN9CXEn6u9xKhfsnha3ef
         BCwA==
X-Gm-Message-State: AOJu0Yx0Q0RM4auk/41MpH03TQVxxTmeU0imj1alu4DGkocyM9BmF4x6
	lYjCz6+yCfYFnXC9xyeBjSDjebVpcIiNwMXQlcJHrUdhjJfl5Zjacv2IRVFuChrl9aECCTSbyVB
	9M0IInsqdQHThzRmLT3GhcJYVl0YOt7lgEGmX
X-Gm-Gg: Acq92OGfnBUjp5UKFsnlUda2uAQd6gV9KIEhhdkMgDms8qqsif5Ljz2PO5ITcXmn3DM
	bRZBLOlFumBY103nkOlv1j1MtY3ER+Q62/pT6nh4EeM4fQHNQk8kV9wI55+lfzQTsTkmLF0TlSJ
	no/b2Ofyd1oVYJIMK9GGCgU7TsZKkBFo8RBTlJgAMF1LZrDvBzAJwiH4zO4qbUTidb10Bofxjag
	BPO1xx8+Icfi5Mo/BrOEKkH7Qr0oWZbIuUoM9gZGgd6wYZ+/3PsO2/8ymWNaL7D2QI5gv1GByB1
	VRGh6m5oiIXQ5ICNrg==
X-Received: by 2002:a17:903:11ce:b0:2be:3434:4e28 with SMTP id
 d9443c01a7336-2beb062c567mr249690855ad.19.1779909080153; Wed, 27 May 2026
 12:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527171438.29181-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260527171438.29181-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:11:08 -0400
X-Gm-Features: AVHnY4LYSOtDLZ0lO859ALnUXj4uKa-8w31HeP3usBw3Y4q7eBWH-RqKrw_rPgE
Message-ID: <CAEjxPJ45qOPbYKPUn8fb+4+Xyb-qctK517h-PF6xFP7DHaFiAg@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: only update maxbit for categories read from config
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 1:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> maxbit was intended to float to the highest category used by
> the setrans.conf configuration. It should never be modified
> as a result of a client-provided raw context.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  mcstrans/src/mcstrans.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Merged.

>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 5056f86e..ee99a19e 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -17,6 +17,7 @@
>  #include <values.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> +#include <stdbool.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdio.h>
> @@ -178,7 +179,8 @@ numdigits(unsigned int n)
>  }
>
>  static int
> -parse_category(ebitmap_t *e, const char *raw, int allowinverse)
> +parse_category(ebitmap_t *e, const char *raw, bool allowinverse,
> +              bool fromconfig)
>  {
>         int inverse =3D 0;
>         unsigned int low, high;
> @@ -192,6 +194,8 @@ parse_category(ebitmap_t *e, const char *raw, int all=
owinverse)
>                         return -1;
>                 if (low > MAX_CATS)
>                         return -1;
> +               if (!fromconfig && low > maxbit)
> +                       return -1;
>                 raw +=3D numdigits(low) + 1;
>                 if (*raw =3D=3D '.') {
>                         raw++;
> @@ -199,6 +203,8 @@ parse_category(ebitmap_t *e, const char *raw, int all=
owinverse)
>                                 return -1;
>                         if (high > MAX_CATS)
>                                 return -1;
> +                       if (!fromconfig && high > maxbit)
> +                               return -1;
>                         raw +=3D numdigits(high) + 1;
>                 } else {
>                         high =3D low;
> @@ -206,7 +212,7 @@ parse_category(ebitmap_t *e, const char *raw, int all=
owinverse)
>                 while (low <=3D high) {
>                         if (ebitmap_set_bit(e, low, inverse ? 0 : 1) < 0)
>                                 return -1;
> -                       if (low >=3D maxbit)
> +                       if (fromconfig && low >=3D maxbit)
>                                 maxbit =3D low + 1;
>                         low++;
>                 }
> @@ -225,14 +231,14 @@ parse_ebitmap(ebitmap_t *e, ebitmap_t *def, const c=
har *raw) {
>         int rc =3D ebitmap_cpy(e, def);
>         if (rc < 0)
>                 return rc;
> -       rc =3D parse_category(e, raw, 1);
> +       rc =3D parse_category(e, raw, true, true);
>         if (rc < 0)
>                 return rc;
>         return 0;
>  }
>
>  static mls_level_t *
> -parse_raw(const char *raw) {
> +parse_raw(const char *raw, bool fromconfig) {
>         mls_level_t *mls =3D calloc(1, sizeof(mls_level_t));
>         if (!mls)
>                 return NULL;
> @@ -241,7 +247,7 @@ parse_raw(const char *raw) {
>         raw +=3D numdigits(mls->sens) + 1;
>         if (*raw =3D=3D ':') {
>                 raw++;
> -               if (parse_category(&mls->cat, raw, 0) < 0)
> +               if (parse_category(&mls->cat, raw, false, fromconfig) < 0=
)
>                         goto err;
>         } else if (*raw !=3D '\0') {
>                 goto err;
> @@ -615,7 +621,7 @@ destroy_cat_constraint(cat_constraint_t **list, cat_c=
onstraint_t *constraint) {
>
>  static int
>  add_base_classification(domain_t *domain, char *raw, char *trans) {
> -       mls_level_t *level =3D parse_raw(raw);
> +       mls_level_t *level =3D parse_raw(raw, true);
>         if (level) {
>                 base_classification_t **i;
>                 base_classification_t *base_classification =3D calloc(1, =
sizeof(base_classification_t));
> @@ -1434,7 +1440,7 @@ compute_trans_from_raw(const char *level, domain_t =
*domain) {
>         if (!level)
>                 goto err;
>
> -       l =3D parse_raw(level);
> +       l =3D parse_raw(level, false);
>         if (!l)
>                 goto err;
>         log_debug(" compute_trans_from_raw raw =3D %s\n", level);
> --
> 2.54.0
>
