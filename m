Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81E30B514
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230791; cv=pass; b=lmJF2G5Q/NsKr9DO1hwKS4eFgySpfGBY+zTO8klJk2s/LyR4/dqvNrwM2THsHvGyFEZM9qZxC8K+C0o3Aw5WHo0AqOKXc6G4GNAdjAckNiPJsWuIj8MpyUJJ8GPvFua36ZEBnBXZK9DPjHol5g9dytq0PmCXCTuLd8JrALDWamA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230791; c=relaxed/simple;
	bh=5Wtn+oddBLr5J8RdL1mUOO/tCXr1k1Nu1NqsHr9PW3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT8UuOWlKt0Ati5Id86uW3aXInPn7DarwxoAMw2NNbvV1rR/FGzrHzNPAAQyYni8mVzhKrzja8CV1WjtSgJdbFVgNJOSjOCRjC9Ssll7QrhX64qC/LLZi56Xzy8LD/eYYP9z2FFeTlWoG0VOun9zWvrxkLE9c8bpH2Il571hnpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Sm0OKT; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Sm0OKT"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842848fd613so89257b3a.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782230790; cv=none;
        d=google.com; s=arc-20240605;
        b=gK/3sNSsSjl65Bsf15Uxe299KugfJwmGgVb+qwM5Z1gpk4zkeHeHGer704a8CJBAFx
         zv0isGX0dBG7Y9CEuVBCd5sohfSfP+ExzL2kzJiGnuvoNvgQFqt6ICoBAGWuUDcmxnUy
         5FCpLv8w9EsX6U8wc+i8pQ36UQw5W3WhYKWrG6neCmJb3XxgY458C+I1zMhXcPZTt4uN
         +Q4e9vOub6N16Q3tbKpvezFNulrOvMVQCcz2IsmS5k8vc+yakCnOrO8ggG1PuS0QOz17
         6lCy9qdl1bdN0Uf62SauJKFZtlbLOhuSUMZ2J7oWetwPmevs8g7xVLdF/eEbcA+bRr8p
         KgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IG0vuQ+WjTC8gt/s61Odl2z20Ua12Hbz0ahtkT1O8yQ=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=deCSZrXh5hIMrPfeItGOVXJOUwF/k57SkeK7OFsTktDRE/eBwPgvC87Xr+JvmZHaYd
         MBFbLsiOkFQ2Q0p+8j5AUOiXxYyDuGqzF8uRAnKc8HkjWH9/OpAfZq53R+8+etEu5tIP
         JvGnXdwVGm0kWzUVxyRiCRtrnLVCNxJj0df6qh1tVCkEF6PAsEMCXJcjNFqnxtLjfXgV
         mVExs+ksuqnSiGlIRLXeNaMHGawGTC1b9Ar/X8xT761iOfelnkbFsGm56OGmYUDv+TI0
         FBXECk4ql3Cv48oR9SUQ/UdljyxKlvoCkrzLYP1ZYY8MOMQjeK/Xk0X0FAE3kFyiuUV0
         xwWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230790; x=1782835590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG0vuQ+WjTC8gt/s61Odl2z20Ua12Hbz0ahtkT1O8yQ=;
        b=Z0Sm0OKTd+P9FOF2Lf5dD+8+NgVhJWqjBnywXwXI2qq/gABLEzPB7hFtynOXFXg9aF
         9DPAF24IJagM/Z4r2x0wR2LZY+6lChU7avGB4rqV1Ps6HTvP1Bb4l4Lw+qDl/P4To/Cq
         ghEwbgB02NsaVLo+bO3qTlXG60mtUoRqytE0hHb6UyZr0ByyuN3nxHH/xQ863Os6Ny9a
         0u14HcCWde+xO84IRGcIqC9wpUjWOpRc/Ti4G0jDEdBoAr7c1JqvO/UknhJy2FtyQ7Xu
         8Hk639QlzhzmeBsUr+R0XFUCW3L9Fm6gamIaNWS0vQ6NB5TCRMyVNztQddGaj6SsPtNa
         H2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230790; x=1782835590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IG0vuQ+WjTC8gt/s61Odl2z20Ua12Hbz0ahtkT1O8yQ=;
        b=beSol83qxq/yTZuft1EObp6hU7Hi90kOrUViidRCf7eRSze4+7cLEsCxyMsCq4rPir
         1sE8XvwDSffFwpsiLSm3gfy3AhcPPLRPADC22aymZCLD4WQHQ/aSiy7TH9CDwFZ3E5qL
         4OnZAOwy6gvNMnMqM5kZvr1FrSRkrQlXZ1HlX2FgJ03HsC0siHcdXGgqH82W/yWboOw5
         LfC0IukHLSd9NuEcFZezYby6UM9Wg3BX3nivDgxcGI6xXtU9KQkZ5NMrUKWgv4BvHw+m
         7E+O8+v00AQStBrl9iYqvlbfXzn+Sa/5yhYOYxRdsvgzrcAHiVreIu7Y2ExAYeu8S25/
         fwJA==
X-Gm-Message-State: AOJu0Yy2RxiYCqTG04vzfekzmMREyKBfeon8YZ1lkqzjg4L+NPKcg0IG
	WYFi1edvwqtxauSpMdgVgYSVaQQ43WDV5077cKngy/XVEt/ghRTGYlewjkD4ucVVNrjZsKbr63o
	4ozzTaHzwHuI0RdNDjqEvokyMeD/UB9E=
X-Gm-Gg: AfdE7cl5gtm+rqBAMkcl8mLm2rGrncXf23Jf1S900Brs70U4hxBUBq9sFBd/QiBIo4E
	v9NI2qKqbU1cXeqo5Ib05ydyWgDhEvgre7SB3ZK6BasiRtjOVaPx1oyrH7nC6bOnD+jswYgPsxc
	ScmC3bwTxcmIsEJPZc2JLvWA4oKsvJFFmWYUQyXgQwNwF6EOzEwVB2oDxC/itjwiRBcQGdhqchg
	eXwuP8ponijJbdVbyh3+SA59XFMHZQsmyH9DXRH7cL0t0iV9vTtxTQYZ1oL9BXin7vL8uUm
X-Received: by 2002:a05:6a00:420c:b0:842:5a18:9af4 with SMTP id
 d2e1a72fcca58-84562489b0cmr16371066b3a.18.1782230789732; Tue, 23 Jun 2026
 09:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-20-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-20-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:06:18 -0400
X-Gm-Features: AVVi8Cc2oOgeyePR4LLvykkSiaynLVvaeGajDKNB8xtzT38tUBD1ytd0xbqRrhc
Message-ID: <CAEjxPJ6uWS0v9C+aHiVNEh7M8fasUj8vxVoVe2OcZF0=mX5DwA@mail.gmail.com>
Subject: Re: [PATCH 21/24] libselinux/audit2why: use public PyUnicode_AsUTF8
 and Py_ssize_t list size
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> _PyUnicode_AsString() is a deprecated private CPython alias for the publi=
c
> PyUnicode_AsUTF8(); switch to the latter.  Also store PyList_Size() in a
> Py_ssize_t (and index the list with one) instead of truncating to int.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/audit2why.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index cae13f19..2e1a98a9 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -330,7 +330,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>         char *tclassstr;
>         PyObject *listObj;
>         PyObject *strObj;
> -       int numlines;
> +       Py_ssize_t numlines;
>         struct boolean_t *bools;
>         unsigned int reason;
>         sepol_security_id_t ssid, tsid;
> @@ -339,7 +339,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>         struct sepol_av_decision avd;
>         int rc;
>         int nbools;
> -       int i =3D 0;
> +       Py_ssize_t i =3D 0;
>
>         if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tcl=
assstr,
>                               &PyList_Type, &listObj))
> @@ -379,7 +379,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>                 strObj =3D PyList_GetItem(listObj, i); /* Can't fail */
>
>                 /* make it a string */
> -               permstr =3D _PyUnicode_AsString(strObj);
> +               permstr =3D PyUnicode_AsUTF8(strObj);
>                 if (!permstr)
>                         /* not a string; exception already set */
>                         return NULL;
> --
> 2.53.0
>
>
