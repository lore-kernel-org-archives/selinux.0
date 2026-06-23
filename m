Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9A305E28
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229692; cv=pass; b=GlU9gsjMJ3Z7FnZ5RDU2jnB+1u37DQHhPXJzQIk1i7lA+r7FOtaJm8SxKz8/8liId9AHSlDcud7ozQF0N+QozJjfUoqTA0iq2/DCl5y7zZxyMaLQ5vgASdvazlqOYdTmaNw4vVTniNsX2/sV30hF/klV0ip8rEqGvmwRIdGLBuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229692; c=relaxed/simple;
	bh=/lFSo32KtBF774JAL20jyCW1k0sgKeJ9/Yo0A/Z/Aek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmRxuJFZNjauq7RRemHZI0nwqalZNHKX4MMYMISNGY/GXtBO7vxlt3yU0dbTBvu/PNhGkdQMKdOKYaz9l6cVX6lXoF/EvCrrUVYu2AZfoEorvutm45F6/MA4gyDEXYLvkCBE6wNWoaJ/ywHVZ5+OIUcV67N+cSvyPMs8eRpF09g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOmm1lfi; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOmm1lfi"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9033d230so3743a91.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782229690; cv=none;
        d=google.com; s=arc-20260327;
        b=W4+VqU//ce8fECsNSH4lNLnO1mTwmwEvFjvCxLdgqDnzmqrtuCDwYWG5pGUOVfzF+h
         rfsMrefSAuCRjIJ/xtkfRWMLCZ7ZqkhmywFE3XXTltde6oHLT9zceTNLacE3UVbls3go
         oPcIBfZh0SbwdWg8k+HmhEBFjvvHTuhwoEXtlVyJtxY1taVdZhx+UhBUNMGmySXAipaZ
         XjvvKLBALHtjFqroljDGFP58eEEcGqD5xQhl5yzvJq4FJvhduINr1tx0rfniPxexQYHg
         1uTF/IDaeZmRDLg666hzLdCm0HD+w1xLh3y3CKGfFUoRsnwY7KPz4JQwK3h9NvvxRVQq
         IF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3rmoMkOMtCqSB77HUxYOQ89MWRC4SRjcqea17QIzcNs=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GslWpMkAeFp0ff94KBMTxAyk2DEM2pO+NA/AoLkzwGVwyPcKFbqzD+asglbKsGvSFJ
         HKN4tIeb2ObQsNgOY6kSy5cj9SF+j/2bOIosEUmdPQqLDLKselmTP9CJ5NmO3UtzXHBb
         +aeMiAC/FE2dIOtwFS2UG/JvCw3opL10jM7eeynLDzUj9lWmtpynlY2OPuceZRrQSP2l
         fVJIgJitpzpleFCvq4K/NMA38/2b84jkDyxcuO26bNZsQqaBhGKNk/GodA4SPATddSHQ
         Lsgwug7kBLZ5zRQFNFKaqFLMaVJwpw2C8stgOGNZX3Z1ms6f/VOK6bVNRDBZV0g4x2QZ
         jh7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229690; x=1782834490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rmoMkOMtCqSB77HUxYOQ89MWRC4SRjcqea17QIzcNs=;
        b=oOmm1lficJ24KlWKicwC1hffkWFmiFHzMvp/wJ18jg6kiW6MEScaiHXhvbDKlJzj2D
         zcB73imq8Ud/xu8qBtXDGsoYVPAMbT15jj4FasZJM06Sb1nQEf7529d9e+bj7SZeBfSS
         7bVSrMSIyXMXlb467UoybbzRCkr9YiWkHCOl6G0W3NUES8w32wXtdgh1ErWsB43vGNxl
         kAv+sLVl75vIQFqq7TCWdRkV1t3UoZoB846BgoTh2BA/87MtEwAUameINuWcvD9sdMpd
         U5AcG+azkjXnm1Y7qgEf/HhK1IhTmVYUf0QVsG3jlo1hlUFglt0dzURoaLd9UO21BOhR
         sszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229690; x=1782834490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3rmoMkOMtCqSB77HUxYOQ89MWRC4SRjcqea17QIzcNs=;
        b=ScdJXdu2LhfDRM2nls/kJLDC/GH8QyBD/UpsLOeMAFAqfCLeROzEQQe2uSWJjDnOh2
         Neh7h1RFhvWVzuXdJbT3i+BicuKVuL2yiTHRaVnFEdYagt1xIohuwXZwQLZ3hHISJBM+
         AqRk7wdKPewc6Ub2dSStAQkz4fowb8LeXWvWZG/qFGm3lt3QA0YNvLXcitm/w7FxxgCO
         eenV1zb6cax9wcMtVKqxvmCVB5zVZVsOossPkRaWqjWbVz850dClf5el7bCabKaQC0Cv
         P68Gdfk/687/jPocBnjdHtMeNXBAnQVa50z5i2cIOD1oGTMri79/jZNptpouaavH9IjB
         ZhVg==
X-Gm-Message-State: AOJu0YxX7Zx8TAKNhlT7ukG6wEt2SnSvijFPPQGgNgOUKPNxst+5O2ZO
	oZCsAbDWeW/d0vilLBkfKDPDcY33jbpvVNbEHvYJiWhULRzsXhO6W+q9DdzkgrVp2SSKDqee4t+
	VJPfKXe9xLDRBQvsdPAg0FaLF1SYX56o=
X-Gm-Gg: AfdE7ckoWIoFpQHmH0cIQWvUYyLQK2CNcIh0thktvWqKG9j73+0ml8wyysU8iDDYOrY
	jIjAZDmKFJF6G/EleTyC/tndM/Xq57vrgfphOp3ChQ2MZHNrsCC/2UPsvjH4T7wyHUFzvEiSeTf
	bb7PNuBAqO4L0tgIO/XHCK/rNe6F6Au1tWCtv5dhsSWYyhbz1OvMjnwUSwJAv8fw8Ot8uZj6Icd
	kEqvaH2LaMCUtVdtG6h0doBM8Ou9Ky3fJPjY38FuDOhVuo/1BeW795s6OHFras9z+QctaHi
X-Received: by 2002:a17:90b:1fc6:b0:37d:af03:f63e with SMTP id
 98e67ed59e1d1-37dcd66b18amr3603526a91.2.1782229690043; Tue, 23 Jun 2026
 08:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-22-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-22-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:47:58 -0400
X-Gm-Features: AVVi8CeKKdN49VyMPOJ63BRmcMbKlC-GRf7Mvh5Gfw_Dn4dlOalCiBFrTWx_pPA
Message-ID: <CAEjxPJ7xU9i_6Vo1BxxF1i0oW48w-WBurHqNNU3mKq2cmiA+RA@mail.gmail.com>
Subject: Re: [PATCH 23/24] libselinux/audit2why: free reason_buf on a TE
 denial in audit2why analyze()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> sepol_compute_av_reason_buffer() allocates reason_buf for a constraint
> reason, but only the CONSTRAINT branch freed it. A mixed TE|CONS reason
> returns through the type-enforcement branch first and leaked the buffer.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/audit2why.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index b03ecc91..5dc94302 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -418,10 +418,12 @@ static PyObject *analyze(PyObject *self __attribute=
__((unused)), PyObject *args)
>                 avc->av =3D av;
>                 nbools =3D check_booleans(&bools);
>                 if (PyErr_Occurred()) {
> +                       free(reason_buf);
>                         free_bools(bools);
>                         return NULL;
>                 }
>                 if (nbools =3D=3D 0) {
> +                       free(reason_buf);
>                         if (av & ~avd.auditdeny) {
>                                 RETURN(DONTAUDIT)
>                         } else {
> @@ -438,6 +440,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>                         b =3D bools;
>                         outboollist =3D PyList_New(len);
>                         if (!outboollist) {
> +                               free(reason_buf);
>                                 free_bools(bools);
>                                 return NULL;
>                         }
> @@ -447,12 +450,14 @@ static PyObject *analyze(PyObject *self __attribute=
__((unused)), PyObject *args)
>                                                                 b->active=
);
>                                 if (!bool_) {
>                                         Py_DECREF(outboollist);
> +                                       free(reason_buf);
>                                         free_bools(bools);
>                                         return NULL;
>                                 }
>                                 PyList_SetItem(outboollist, len++, bool_)=
;
>                                 b++;
>                         }
> +                       free(reason_buf);
>                         free_bools(bools);
>                         /* 'N' steals the reference to outboollist */
>                         return Py_BuildValue("iN", BOOLEAN, outboollist);
> --
> 2.53.0
>
>
