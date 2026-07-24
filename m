Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBF2F99B8
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902985; cv=pass; b=K2E/4sf4X+3Ugacx2QlenBU1JTab/zsoyoc6WRIIVIA0LkoMp21e1+MEbX/WTEuqYfkVhedDYNSCO1tBYBpJ+Khy2Ub7UOmRQ44GJYTz3qtfR/36pYYf6SSZHwSG8+ZRPpgUA+5g59er8l1RzEd9qNdJwQW/gMlm09R5X57gYkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902985; c=relaxed/simple;
	bh=/+gSWUS99doYZt0VSZlFLg1rb+sXYOEtiNPtPRiDy7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rW4SEOzp+oRAQokM+AwdjPkCtEacmPlBe2jJqdRaGj6htd+49ysYtckbEs7dfzessAkn+wRC8sE02mgUzb/dPHnzYj2SezD/XvRnvWZ3gkazW2YiijO4FKm8jdo3uLtplwWrxp4IoXaAw0WwmJFoXvczNo+S0y7F/Ezf+SzDcvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncuYHWcX; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncuYHWcX"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a620eca7a5so275735eaf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902983; cv=none;
        d=google.com; s=arc-20260327;
        b=Dv/hX2WRHIddsiIrcOiL0h8BCfNwCS/EI9JUXTR5KmxiFs7X+Ah1b8Lvz538/AqiQA
         RR1nnTPH2WwjVYuo5A2a0MdT3wM0eA54N58VyMZkGVESO1DdA3Q9MnyGclZ2KelfaNxH
         i/oKQJQey0zr7x5QvCB9nJOUFl0bsw1zfPcVB3m72hXPeJVckH8qi0n32GBCWAQso7xB
         8f5wFUdsLdxSkwZqGlxGIt3HFMF1RiWF5XIAuGHR3m00w7CujFId3tsnH3vtzEXSIwNB
         +6OlR7BDkABBqQAzK/8RHOnvktRsTs6ASUgMFNNsy/joe5ndA/zGtwcjzbYgcfGumwor
         Cz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYw1kAQPayLsSDI17glIoTPkiT4bclhmhsRtsQRmuow=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=AAVu72QMQ1fAcp6eu6p6KHNyl7XvUkIow5wkzq5SlVtKm/2EvQpNm/lWPz7es+v6Jp
         paC73fokCroJz6n9Zw4cdd61ORhFLTQjiX+WapmeQl7eE7ULf//HMa/2l5kwgAQ2OCs1
         8VY+E6a2Ad9YYRG3fx4KP0Tm4/1u+KztI1WOdhj+8mjRX16+mHBZ2lqPkoTMdcQGoVd9
         SMAOdtYAmA+3J/7fKYwnDW0BIdK8OO09mJvEkweyaaTgBbdsaJDeYA/sFTzoTQjFWpky
         E425V7ERWw2RZDumP22vJTeyufWeMKLCcvOOHG+SP40rwIBKyspHdhM+mjfdLXniUToF
         KeMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784902983; x=1785507783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RYw1kAQPayLsSDI17glIoTPkiT4bclhmhsRtsQRmuow=;
        b=ncuYHWcXUNdTNJTiXkU2HchUJdvw0NZchvv9nqmZf0UwvBG2YmQWbWMYHRMT7dDHfG
         sm83Wse1JVh+7qKDfaA82/JwlUxNHu7huik2qIWfp2viGdnVOseVRfjyw4bu0krAuhE6
         2O9z3CVvTUEG2yxYPgXIP+CYTetBqL0nIoxr7gT7YQ/TqG1X7TEQH0J87epgTH5RoGUe
         BWMchMq+UOnMgngnmH1Ll/mTjBnICKSI9gTx1SRh/4YRj7YM+YSIyWoZBaZSB0N0hluP
         jP6eZWs7bzE4EhYcnGK5t8uef+rVq489aOGwBRqRUyNmzyw1x01j0C9LmFVdj5Y+sKmf
         FbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784902983; x=1785507783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYw1kAQPayLsSDI17glIoTPkiT4bclhmhsRtsQRmuow=;
        b=ivWIpxpwcQjncPlgpYbXBE50kF/ImEuzzEoxTQyrP3HaNipfurcyTEOAgo9FiE2kLF
         euhuKI7+gAXa11w66znMgGylHHX1MFrGyik2/d81HIdXAtpDwxpcEYAQjE+7RE9xB5GV
         84xoKH99CunzIyeRvTB55Lwgc5FFEHSb7/a31hv7JP2dPWNQrE0UqB5QCf+uARp643E3
         YtRQue7Gy0mLjpkqr2HKobjlBi/1QyVsnDLO/9gO1NJsz9QftINV8c7v4tfTBSt5uFFk
         aLQjKfuHpA/hato5voPdG8N45O/Q2IEMnWzv+dECR5SO7sOax1rbQ6sL7eQiAGe849JW
         vfHw==
X-Gm-Message-State: AOJu0Yx+/g/9Xohce7DNPSr//tl1tqg05sKf/vXJcOjgj2CKMYRty6lM
	jeit4/S+J9uXRTy9phueQhdMf4BzxcHQmsIa8G89DNNLwgUlQQWH60z0V+44CkJ46EWHBsYIwQM
	sV5y3tNMag8zx8E/v50cT+OAfB0lxGU344Q==
X-Gm-Gg: AR+sD11EUTikza8M7vS8+jVMmAGdPXRb3dsot7k9ccMt0g/bgbssebg/z4eWi0e/Ymc
	90ORsViWBidNv9Uo4lRWVzU5OjGfvfdwt0lLhaq2rvCdkuS/jaceIKf0SLMNSCijXB4bZeYMgKT
	4gEHPiEa32dLavsPzuJ1s88Qha5/BAqsBlbZCRSXY0tiCELkcNVpz+wIxuHms8czNGk16pm4AEV
	S5UkPV6ezaCTpcRoev2vrgqylB5qYON7zEkRxe24Yejy/LFGUFAMC6iP3JuKg==
X-Received: by 2002:a05:6820:4c09:b0:6aa:8917:2215 with SMTP id
 006d021491bc7-6aad4030609mr4183362eaf.30.1784902983161; Fri, 24 Jul 2026
 07:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721171607.61110-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260721171607.61110-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:22:52 -0400
X-Gm-Features: AUfX_myD6GvrrE6y59WWB8B_V5T4_sDJWPW2Wpsk1DuuuoOnORdcak0sa__Bhek
Message-ID: <CAEjxPJ7ZwBQ7A1-2qr-FB2pWKJdu45O7vyx+jvGtQ4jCFP==xQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix Python binding for security_load_policy()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 1:16=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Commit 9639f5d ("Add decent constants for python for return of
> getenforce call") also added a global typemap that forces every void *
> parameter to NULL from Python. This was intended to auto-supply NULL
> for the opaque auditdata parameter of avc_has_perm(), avc_audit(), and
> selinux_check_access(), but also matched the void *data parameter of
> security_load_policy(), forcing it to NULL and preventing its
> use. Restrict the auto-NULL typemap to only the auditdata parameters
> and provide a typemap for security_load_policy that supports passing
> any bytes-like object (bytes, bytearray, mmap) that can be handled.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/354
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  libselinux/src/selinuxswig_python.i | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinux=
swig_python.i
> index 03ed296d..c8c08a40 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -88,9 +88,30 @@ def install(src, dest):
>    $1 =3D &temp;
>  }
>
> -%typemap(in, numinputs=3D0) void *(char *temp=3DNULL) {
> -       $1 =3D temp;
> +/*
> + * Auto-supply NULL for the opaque auditdata parameter on avc_has_perm()=
,
> + * avc_audit(), and selinux_check_access(); it is not usable from Python=
.
> + * Restricted by parameter name so that it does not swallow other void *=
 args.
> + */
> +%typemap(in, numinputs=3D0) void *auditdata {
> +       $1 =3D NULL;
> +}
> +
> +/*
> + * security_load_policy(const void *data, size_t len) accept any
> + * object exposing the buffer protocol (bytes, bytearray, mmap, ...)
> + * as a single Python argument.
> + */
> +%typemap(in) (const void *data, size_t len)(Py_buffer view) {
> +       view.obj =3D NULL;
> +       if (PyObject_GetBuffer($input, &view, PyBUF_SIMPLE) < 0)
> +               SWIG_fail;
> +       $1 =3D view.buf;
> +       $2 =3D (size_t)view.len;
>  }
> +%typemap(freearg) (const void *data, size_t len) {
> +       PyBuffer_Release(&view$argnum);
> + }
>
>  /* Makes security_compute_user() return a Python list of contexts */
>  %typemap(argout) (char ***con) {
> --
> 2.55.0
>
