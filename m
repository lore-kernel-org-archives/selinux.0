Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559B382F28
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854213; cv=pass; b=mB5NBi6plWU4Hk0PVp5AV0U8/6xlSXUG6XpmBMbg7GrSFvjqCV6rv/yN/KIcpjkenYq4ckrtecbdK39a/Y3/OykXl3Xz+a1UhBhqf2Rx5p1P47mfk7+NAiTWwpq8HzZj+30z2Fx4dHBjGc8F83+lHQXbekVrCOlKIxtiMAHCtDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854213; c=relaxed/simple;
	bh=I4cmDaw5+bouoM8D7KsZ28IApOoZM1PKkT9i2A4eMys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMGOaIMbMh9bmab8TrVr8miO7W84zy5fWUQlIDGojgjVkAYS6/rxPtNDMa1BVVhtbFybB/kiIwNv8/Zx7FxExI4yIQes2OdagxjJh9aQKi2kCreRYxgDxyXlco2ZZfLJiaCtf+an0J5dpcHajg8heBvrxCzFp+NVoksg2UcNV8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCLFsrzo; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCLFsrzo"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso24071001fa.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 07:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854210; cv=none;
        d=google.com; s=arc-20260327;
        b=eDDY6D43rXUJTK5+nK7AOX4qaqySsd4FkYq4iCx/iPwoOJdwcY7Piy4ac5o6M3c+ZI
         fLRJqLqKhCQRar7jgOZckCLflN9hA6OyzBMVCtPYZf8cshlFO+jVnaZQJAbK3QT2q/Ay
         uiC/k/MloJ/Nh5l/FvdS5DSXhysN/PkFPnyVDXwa01l5SUVgQxaIdY5ClL4MFMe84QzI
         5EAcnjc/tZ/70zAm521jse3Hn6WQLd7XVr9d2pimhMrC96//7rs6HyxGDodYkK1sTcke
         Joxn8mGdR0K+rKoN063m3uE/hC1hTb+qBeKtWFe6S09pKnmhUUjOg/cURDxpaj2r3cBD
         mbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0f8YYSCultU+7LOMRqHVxE/PSEyd9E98eKgb7qjPJso=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=Qt9dXSglmLQ6GJt78/unj8aUVSI5WQQyYP0fX2+JcUgqUqw1Euw3cIYnlRfTG3WRpy
         k3IecS1yx7j7VddCcFDxx123USCBLmz6iFBBYMyIMh4zw/hT23TN3201VZ8WEbCg6dd6
         /yftMBtm59UjfL0hb8Ba6wmUa3Ih4x2LhTw0uwhxmn+5wgzlIQgz/ldutlXdvHCRLuRd
         VnuHT5gUq/urJ71DTAt3D167pxej1cUPZ0nQMYYNHAUy/JbnWVNdvcDaf8eeteMzmrrw
         vVgflLMOgfgMeo9zs7JcMPwwVd4Ppu1Jk06SyoB8fYCDuqKqZ9oIaPkC6hiUg3I9OyDp
         Kz/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785854210; x=1786459010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0f8YYSCultU+7LOMRqHVxE/PSEyd9E98eKgb7qjPJso=;
        b=eCLFsrzoA2fDj1mzXoy2EiA9PkYwMItQ2B66bd5W2B9tHmS/LZI4NV+oJGnLRq8DId
         kdA3vghiYLDipXN+TAH3KJzh2lm59LPMBMG5qJrDMwhiavQia/reQIEtfaDxhTYIY4Ha
         5P2rbAMiEr6A4VvCLd1t/n1lVQVMBPwqTMwhBL6BhLa4NrZWhm9z1aOjnSdD1zqfuSWy
         eI/Rj6n07gS6YyimCDC1P4FNGlP4qljlnwunk+Nj2dTGyh8L9sGgV372Wdr671PsRMDU
         JRe/13xDjqoN19HEqYhBqBkvETgytY7nA0UyaNNQdY3K01DfKZQRtLrNOvfxEQPuu+ZD
         PXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854210; x=1786459010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0f8YYSCultU+7LOMRqHVxE/PSEyd9E98eKgb7qjPJso=;
        b=RYiGF2r7KH2SicavR7h41mvyIjTIHAhQuw0/djPLbelDkKRNU86oMVRcef2jzqdUdh
         FfI91EImDitQR9yKBF3+iXbOa7mLiI5EU3QFGMQsoTQ2ho8Lxk13212oQ4XtRZnwDRjh
         Tf0eu8dW6d87r6TZw0/5Y0efSA01URE/XjMcGCIZ9+Jc4vGvFFXspmEergrxxwFDAPH/
         OEK9gGKxnN1E8/oxW38GVk5njloNLhsJ/qwNrZSo4TwnEdG8HSszB3Q56J4rZE4ZQ3Xn
         fDc4/1hT+ZndGgRpKe8Ij/veqLvAyvt9OaBCtSeB6UTUe2dSDjuxYJhaUIHihyhrUIcR
         iUUQ==
X-Gm-Message-State: AOJu0Yz6hkSNzOvJETEcxsrvCWc88PxeVjP8VlQXIbWBocZfvcP/aRL2
	5LRJdb6d7xxn8qyerJBy0teFXK29TrA9BBG2UP4v0GsjqhpIYdLg9eXPo9c7F2hnPB6TqD6YZwr
	1OC7Doakd/5cAgZg713Ej9j//0GmM5vM=
X-Gm-Gg: AR+sD10yUH3IIpxfUr/cg+IOlhZKtIY8KKSdg3TgWDL9GXfAy5xo8MNrx2xU+RJYVU8
	UZb4wUtaUQvyou9TPn6j2LUox4j+R5kT/dlnhdk9VGB2lzk/KfnOODYgeQkhMH9wfAFjtr9aCIV
	cnrW+SEy9RZ6+BPAStF2oLtLVqCl8BWxFVrMtPHRgKzmBB2k+mxuWBNnxItqYeLpK1o0YnI1QLy
	FvQvqZXU1NuFAr/cqznS1Oho0kThorvyFohBSW0Tb8tKmByO6mCZDUFRyID6IvpeMn19wt4G4kM
	IqS3iIoEj8DH8sYhYjnbZqRt2EnrqpPKEM2IEy7zug==
X-Received: by 2002:a2e:9a0b:0:b0:39c:650c:4540 with SMTP id
 38308e7fff4ca-39f86189936mr33741151fa.15.1785854209380; Tue, 04 Aug 2026
 07:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803200935.49341-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260803200935.49341-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 4 Aug 2026 10:36:38 -0400
X-Gm-Features: AUfX_mzPUueux-7UMydr1x3LPR3RGR4O5KvOfUcqlDwCY3QZcC-ER7_dcdFPTzk
Message-ID: <CAP+JOzRDSvAdSO_i5nCUjqkOAPe=uyP0iYp0--qCV8PRwZGSrQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: log an error if we hit the max depth for __evaluate_classperms_list()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 4:10=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add a cil_log() statement so that we do not fail silently if we hit
> the max depth. While we are here, introduce a #define for the max
> depth and use it, and fix the comparison so that we fail immediately
> when the depth has already reached the limit.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 adds the missing newline to cil_log(); was confused by the
> fact that cil_tree_log() doesn't want one but cil_log() does.
>
>  libsepol/cil/src/cil_post.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 183b0d49..b9d5696f 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -49,6 +49,8 @@
>  #include "cil_symtab.h"
>  #include "cil_deny.h"
>
> +#define MAX_CLASSPERMS_DEPTH (32)
> +
>  #define GEN_REQUIRE_ATTR \
>         "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
>  #define TYPEATTR_INFIX "_typeattr_" /* Also in libsepol/src/module_to_ci=
l.c */
> @@ -2296,8 +2298,11 @@ static int __evaluate_classperms_list(struct cil_l=
ist *classperms,
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
>
> -       if (depth > 32)
> +       if (depth >=3D MAX_CLASSPERMS_DEPTH) {
> +               cil_log(CIL_ERR, "Exceeded max classperms depth (%u)\n",
> +                       MAX_CLASSPERMS_DEPTH);
>                 return SEPOL_ERR;
> +       }
>
>         cil_list_for_each(curr, classperms) {
>                 if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> --
> 2.55.0
>
