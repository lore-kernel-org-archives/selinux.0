Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DC44210C
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754485; cv=pass; b=hVSPl5LTjDJPpcolcs5gDwxe/araNjF38vAvUQtMRe6al0ZIVPwlspHSN+t8KEzZZ5lMxTVIr9Sn4l7R/kAapDmfUqGP7WxJ8BuofwV1jyw5Fp4xAZHkocVEaHTKhG489Npxsl3ieAWwwrpfgc4QDCOhzn2psL4mMFw7Nnl/lSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754485; c=relaxed/simple;
	bh=rfFhIsQ2bbJs9nJuRx7018Dbj2tAXBJwBCtPu+sPYic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImEH3e2Jhc3OTrlcIRMcuezLuugG+IKvT6hkK2pwfyM05qcsfbem6i68dlh596dqCOfwr8UVR+U+dS+ItnWEXD+BLI12oZDiGdP3Fumw5xnUgBhWzkVanhcYh/fes6NT01LPUIt1Q5FZzm6hgTyRNa8aG8eQgmVCav58CTEBcho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtvxVXa9; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtvxVXa9"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so1817510a12.1
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 07:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787754480; cv=none;
        d=google.com; s=arc-20260327;
        b=L8Pl1OTNrnFrs8h9PrDq6xEu1U2sSlPzaOlm+4jQ+2xzunQH/ft6OkX6bOtAnRxBir
         8/jGWklQFSVoCRHp7r0JlODZ0EyPII7nZS9Dr1maGC0txNGLza5AhoAip6GAfD9GLwm7
         tJEQ2oRNPJd9L7OIiw/CrENshCmOH/Ni4qG6XBC/cW0ryPpltMtV1a76eYuklZh/pqKh
         1XsA9O0QB3VdmwwwWvhjNQiq+FCLq888/3ch1hkNsRaMomZCSwBq9ZQ0Ve29N0Y/cVGw
         sObJ4ifR4yIqfY56jLs0D4YgyAFI7Gxm/o5hI5lHGy+zfdabw4SLeu54/8ZpCDesHH6P
         a+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Az6Wgq5Jf7hu+DVTeJuzFAcl1MVrvHQ+WRTWvnkft5Y=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=I1CB0smFrh6AGZjrNWUdXmcMVx4IgmvHQ9tX1E3TrUnLSsd083F52WadBhZyj1KRvV
         H8qDgcIuD0neQmbHLvFD7LiNZ3wvvxRViskhxdUPn0UZNS8pu8Sq5bGsc4xatCpI4Eh+
         u6LAA/AwKfUo9jio71BDe6mKC19e9Z2eyILRjws+aTT0gBqr2kXLTSMvMkiGe0g8WLOn
         ODWkQiOaqo037q1lV/F+dWeMwCi/bIyzgboNiq4/sbVzXGTQ9wnkwRNayv3BqROC2dFD
         gzI/7ONktAdJYeOGMaCk+//uLs9BytameecFUYuSvFmfddmXyN2kAe2okMM6f0chNCz9
         l8Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787754480; x=1788359280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Az6Wgq5Jf7hu+DVTeJuzFAcl1MVrvHQ+WRTWvnkft5Y=;
        b=KtvxVXa9icDsV4TAAXAbYg0QzQhDaCEoYV5wUyI3s++2aRDK6bCEBicAJ+MepzvnQW
         wOBy7Q6cINzu8zaHvpHLac8sAeWXQPUxCHvWOvflLIH3jtvyQhvCA1dcp+WTEwQMQIvf
         1y+3lEjahJErv1JDDkuOwHON5j/E/lDnDLbH2fn8X5XG5wRdtbBTkGL7pFwz4RlQ+omG
         hWvWehNgDaaPWIf9OR02nbuH0NsZPD5t6DOGF8M9B/htxDZvxKwcJDq2VBr16QisWEye
         hD6ICCvUIRvOkGX7Met4zWOQa/O/PunI9IFzkYITKObcDlnADaQ+D5l0pM6jFxHl/Jta
         nKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754480; x=1788359280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Az6Wgq5Jf7hu+DVTeJuzFAcl1MVrvHQ+WRTWvnkft5Y=;
        b=W36fIFTY5/n/BNYdwAgCc3J01OADfYnHFM/mR2Qrxe1IhxPRzIg0P7M2Aafbat0g8v
         Ubp2WIAJ54QEDYk5CvlToqkpSm7rhAMmB+6lbTG+ezNYTGdV/k+T7iyDie7Rdimn5QZE
         Lt0hwVj7fn4FyguIrDw9RfJQJYvDQ0D+EE2hCTuLIuotcqD004Eb/V0EKf+98Elz9YBh
         8otrGa6QPq+tBK40wpMSex3yfiic92+/t3YucoMzMiheF7NCWl5C35vcB1XsIG+rlNM/
         wUNo7DYeSu6Lspdb/9nj0zyZQYragWhiU7zhCe67xJiMJfCNNL4MOWCORH7bDl4PuWie
         GSGw==
X-Gm-Message-State: AFuF++my3GX8vatmwqgwDmJ2CV4w7MlR6ffKOOGhrs7QK2L3U6y7/5+3
	wgp3pbfUYUk9UeEWMsxgxcc6bvNJzAgSQDxXjidpzdp7U2dYxTaP8nOzLLDRd+bqTF+0DtmjX/y
	oT7TFGf9HH/uEpjYAu72LYsBlyvD5Gto=
X-Gm-Gg: AR+sD10sM/Y7wGodE8kIvIEgNTgAdjBZp7iW4AUD7v4vQIWcwgUVCo0z74wAfKVHSvo
	fE1HAyQt4eBYT7XVF/+sCsvSwpcwZqNkt/D8PXWJGMScM1VSZsAhVtMykHJx4BLO+pRrKxQV+F4
	ohe+rQI53eSfubSz9kxcXQ9jVj8QlNJrbzOk4ltkkXEVgzNpEaKAWdRgzHldwnO2e0qmdJoiVzu
	o3iuiU/JzngMr+n/UhcM1aQvaH/txCHYXmQxidfQ3laWKN6QmplEvQIyci/UX6I3lQXKUpl/zwx
	JWVk5mtk58w+CsjwU0G31vDrru9n0C3sRPAwA4yYJA==
X-Received: by 2002:a05:6402:304c:b0:6a5:d8f0:dc10 with SMTP id
 4fb4d7f45d1cf-6a5df63b144mr8725669a12.13.1787754479424; Wed, 26 Aug 2026
 07:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825124629.84128-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260825124629.84128-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 26 Aug 2026 10:27:47 -0400
X-Gm-Features: AcwNN1V8Il5S9DcQ9Spw7HW7uS0TZwmaAWoRLdiFoefO8uCLU62FactqHG2GmaA
Message-ID: <CAP+JOzRDnS5KxRUVJGAk6bS+aHdZa71EtyxOO=HovpgPtJ6T2g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not infer name-based bounds for attributes
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> hierarchy_add_bounds() infers an implicit parent from a dotted name
> for every entry in the type, role, and user symbol tables and stores
> it in ->bounds. Type and role attributes live in the same symbol
> tables as simple types, so an attribute with a dotted name whose
> prefix names any existing entry has ->bounds set on it. For types this
> produces a policydb that fails policydb_validate() on a TYPE_ATTRIB
> with a non-zero bounds, which oss-fuzz hits via the checkpolicy
> fuzzer's explicit call to hierarchy_check_constraints(). A minimal
> reproducer is any policy containing:
>
> attribute A;
>     attribute A.b;
>
> or:
>
>     type T;
>     attribute T.b;
>
> Skip attributes when inferring name-based bounds, and treat an
> attribute-named parent like a missing parent, mirroring the flavor
> checks the explicit typebounds code path already does.
>
> Fixes: https://issues.oss-fuzz.com/issues/550672317
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/hierarchy.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> index 0499bdfa..b87471ec 100644
> --- a/libsepol/src/hierarchy.c
> +++ b/libsepol/src/hierarchy.c
> @@ -617,6 +617,10 @@ int bounds_check_users(sepol_handle_t *handle, polic=
ydb_t *p)
>         return 0;
>  }
>
> +#define type_datum_is_attr(d) ((d)->flavor =3D=3D TYPE_ATTRIB)
> +#define role_datum_is_attr(d) ((d)->flavor =3D=3D ROLE_ATTRIB)
> +#define user_datum_is_attr(d) (0)
> +
>  #define add_hierarchy_callback_template(prefix)                         =
         \
>         int hierarchy_add_##prefix##_callback(hashtab_key_t k            =
        \
>                                               __attribute__((unused)),   =
        \
> @@ -629,6 +633,9 @@ int bounds_check_users(sepol_handle_t *handle, policy=
db_t *p)
>                 prefix##_datum_t *parent;                                =
        \
>                 char *parent_name, *datum_name, *tmp;                    =
        \
>                                                                          =
         \
> +               if (prefix##_datum_is_attr(datum))                       =
        \
> +                       return 0;                                        =
        \
> +                                                                        =
         \
>                 if (!datum->bounds) {                                    =
        \
>                         datum_name =3D                                   =
          \
>                                 p->p_##prefix##_val_to_name[datum->s.valu=
e -     \
> @@ -661,6 +668,16 @@ int bounds_check_users(sepol_handle_t *handle, polic=
ydb_t *p)
>                                 a->numbad++;                             =
        \
>                                 return 0;                                =
        \
>                         }                                                =
        \
> +                       if (prefix##_datum_is_attr(parent)) {            =
        \
> +                               ERR(handle,                              =
        \
> +                                   "%s is an attribute, %s is an orphan"=
,       \
> +                                   parent_name,                         =
        \
> +                                   p->p_##prefix##_val_to_name[datum->s.=
value - \
> +                                                               1]);     =
        \
> +                               free(parent_name);                       =
        \
> +                               a->numbad++;                             =
        \
> +                               return 0;                                =
        \
> +                       }                                                =
        \
>                         datum->bounds =3D parent->s.value;               =
          \
>                         free(parent_name);                               =
        \
>                 }                                                        =
        \
> --
> 2.55.0
>
