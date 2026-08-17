Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B0284896
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977331; cv=pass; b=C+IPuMkLOF0lzVZUZ48wm0bmVBRi+CI+2CRDEsA9/n9kD8wm+frxVHzumfduPeafXob+ed4xe+amad4mGUyI/XY1X/s3e0AmSLJ9UYi/Vw0ZmF+i5vCRPuwLs5ev4A3LW+Vg4q3NywjYXfCDHTslcWYIs0bAa75f89JcSjwseyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977331; c=relaxed/simple;
	bh=+JjnYjRNm+yscbTfIGy0xT3cOM47bVwkE10RKw10iJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0ylytEbfTJAkAotIEtojh0vzffKaXlgCbVhPX0L3Gl7oZgTFUkhD5g7+xWgV16M8uhoZ79FJFVUQj71gOqTJVLUrDALMIyTYLWkzFMpXPzk4ypteaNQC6Wt/+bVeqKLRrykvxrP9nS8XM11wdsi6VDaU3210H+zXKlUkniT0B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZlrnHa/; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZlrnHa/"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso27382561fa.2
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 07:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786977327; cv=none;
        d=google.com; s=arc-20260327;
        b=CuVgb0rTPiRba95os9l+QrzhD04NxvPwiQByc2sShNGe0LLXvE9um+bENlC2C1WB72
         SA860KcVHLLyOxNJTOoUUAUXx5x/7Bq7e7F0aAhliRgVPMClwRA39BpSGEb5P/YQyhKG
         2VGsi1l+9jImT/08DEJyn4twuGBjkIcfTiYmrVsfJAmINEQHIpUcYkw9zo1fUYIwtujV
         Z0uLmYJLnWGCVj7nrOfvz3+JgdC7UYzLb8jdKMk1Ht6GnB5Otmzso/XRsWVR2BkKuH+Q
         +kBgkrY8cUGevQ5TZvDo3d1mjKuXcuiOismEYegFwXp3xIbXhBiBB8qQiMI5QAK8h1G9
         F+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M52uEmrrbCOJ3+T3TKBz5OPlBJ80kWmHWiMHmflLKwQ=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=ThL5XMf94BvP0HtCH6eTDaAiBvwbplUV3h73OkeaM2ECZqk5XdV2622nci3GQfZYI3
         WMWP+VWVyMInId39rkLr5m/LmoYzoyqNRnb82zfLNq+XZedc9r233DNZQaIPO8FViv+0
         6uhMxbJaPaTHBWWrnvN8roh9Y9/IfU5t6Z2swd8pYt7hf6qDeY917VXSl/p6nYrhqoE9
         Vx90cboslHLU0l97/VFzO5MbIROQmrNi5DCgzUgPUGPUe/QHwT2Oxv9OHquk2TyC86md
         vmdi6TcrMaJNgoJ/VoFSnJNzw/Y1jG9sZgSXOMFCeepuvmwV1eyskvvPQIZWJERppPpP
         igLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786977327; x=1787582127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M52uEmrrbCOJ3+T3TKBz5OPlBJ80kWmHWiMHmflLKwQ=;
        b=gZlrnHa/q7pg0vJuLYIItPEYY8Ii3yGDhmqpdlCRxEi4ZITTK9eOOZsCq/HaksrBwM
         gHiSOBtv+mlXzXKUASRsZLJFz/03C15nxGvhQ4ykpPS0XmTD2zMmE4tQlm0NRxbvYG9t
         nXUkIjslF+FIulQWRXiV0UlN2YIN3iLcTs5eWUxUAIMYgiYiaoOuY/jOUODzdk75+ADB
         PfrT6fu7c4tHGYzZ9T04tXBPDQwCkZrotSVxkApwL9Txl35cXIWYNkyx8hBbQA/GT57+
         US1zkraXtxzIWyWkj9CCPaGrD9bVnsIEgKMMB+/ih4RifsQ4cJaIwEIcrqG6laz1P/i0
         AL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977327; x=1787582127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M52uEmrrbCOJ3+T3TKBz5OPlBJ80kWmHWiMHmflLKwQ=;
        b=errmHvRuFUN16Vhhf50f0otDu+skhx0U7RqcHZEUrybJjXBwscG97Iz8of6G2/Pvs+
         VLfuj9+pNmdaDH1M8LvAUbM61QDZgfvQTasUGQGotzjk1g45dt4qqhXKB6xZHv79g9iz
         X6mReNysg+2MGXPmJcQhsKIDUgo5UB37D2c7xbGisuQJmkW5L+N4y3x43doJtToQi3yF
         fEyKuvbEZ6pz2ufYPTcv4zCkFo5bTOV3foeJ0YY7d5ckpx/uL9skwzeUDynNWayvJ4MU
         dPh/wI3rG6A8r7K8uQu8TAbgVHzSpFs+THzdt8V9JvWFxBGVWyVZbDdYQ2X34/qi6fAh
         8obg==
X-Gm-Message-State: AOJu0YxeHC6AP4VTvWgUzmpefi2lj+KV//UMX3ITf214YugoSS490OI5
	LWTaV0qRQskj3qIpgXpBudUGrwqtgMSSq7xZMreoJvl9y5Y2CO5U3sO489iZcvIQD01SnchXvCC
	gPLF+3fabxG1G+CJMwVCzYK1M9Ss8/eU=
X-Gm-Gg: AR+sD13LFbETKNuQjEiObUWPjHjZd+vi3KC2TJrjCLEOMZjjmiLeXlwjhZJTJ1eIzdX
	ViOjC1aWudwCJ3adRoSR2uKIWl1PA8hL/R2BMSwtuN1c10uaqdEPduRThRIjT8kYZoay7ym1VPW
	QGqgW5NCM+hBkjsjWYzn+oqGKLa3TYNw7mE3w/+9qcwUsC46yeurJyzWCAAXwCD5WDeLFLmSAan
	OUIEOQrANUqTjapfJssT9WjsuHndmbLU9w8Y1bhnOXD8JsMA9aZvw5ZBlKwQTbLeAUTbVKMhnQS
	zjkdZszraRDC/N+pPND/7HMY6XJh5L9LiTbSyjAxsZYYYwpwDiLq
X-Received: by 2002:a2e:be28:0:b0:3a1:11d3:1716 with SMTP id
 38308e7fff4ca-3a1324bc02fmr26591041fa.23.1786977326666; Mon, 17 Aug 2026
 07:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184113.186092-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260813184113.186092-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Aug 2026 10:35:15 -0400
X-Gm-Features: AcwNN1X6hVingJoRgVa-1bJQORSMFAVZihq-ocU8eU_KjZ7iPAjhoM3OkS96L8c
Message-ID: <CAP+JOzR9S4Gpn-Q1Q3KVDT5o9qPMv1ayjSgBLBJYW2bQUL3b0Q@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: treat module data as bytes in the Python bindings
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> semanage_module_install() / semanage_module_install_info() take a
> (char *data, size_t data_len) pair, and semanage_module_extract()
> returns (void **mapped_data, size_t *data_len). In both directions
> the payload is an opaque module blob (.pp / bzip2 / CIL / HLL), not a
> NUL-terminated C string.
>
> On Python 3 the current SWIG bindings get this wrong on both sides:
>
> - install()/install_info(): the SWIG default for a bare "char *"
>   only accepts str objects and UTF-8-encodes them, so a .pp blob
>   cannot be passed at all, and even for CIL text the separately
>   supplied data_len is wrong for any non-ASCII content since
>   Python len(str) counts code points, not UTF-8 bytes.
>
> - extract(): %cstring_output_allocate_size turns the mapped buffer
>   into a str via UTF-8 decoding, which for a binary module either
>   raises UnicodeDecodeError or (with surrogateescape) yields a str
>   that cannot be fed straight back into install().
>
> Add a (char *module_data, size_t data_len) input typemap that
> accepts any object exposing the buffer protocol (bytes, bytearray,
> mmap, ...) as a single argument and derives the length from it, and
> apply it to the (char *data, size_t data_len) pair of
> semanage_module_install_info() as well.
>
> Replace the extract() output typemap with an explicit multi-argument
> typemap that returns a bytes object built from the mapped buffer and
> then unmaps it, so extract() -> install() round-trips.  Drop the
> now-unused <cstring.i> include.
>
> The Python signatures become
>   semanage_module_install(sh, data, name, ext_lang)
>   semanage_module_install_info(sh, modinfo, data)
> There are no in-tree Python callers.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/502
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/semanageswig_python.i | 43 +++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/sema=
nageswig_python.i
> index 0ca09763..1729e965 100644
> --- a/libsemanage/src/semanageswig_python.i
> +++ b/libsemanage/src/semanageswig_python.i
> @@ -102,9 +102,46 @@
>  %apply int *OUTPUT { unsigned int * };
>  %apply int *OUTPUT { uint16_t * };
>
> -%include <cstring.i>
> -/* This is needed to properly mmap binary data in SWIG */
> -%cstring_output_allocate_size(void **mapped_data, size_t *data_len, munm=
ap(*$1, *$2));
> +/*
> + * semanage_module_extract(): the (void **mapped_data, size_t *data_len)=
 pair
> + * is an opaque module blob (.pp / bzip2 / CIL / HLL).  Return it to Pyt=
hon
> + * as a bytes object; %cstring_output_allocate_size would UTF-8-decode i=
t
> + * into a str, which corrupts binary modules.
> + */
> +%typemap(in, numinputs=3D0) (void **mapped_data, size_t *data_len)
> +       (void *temp_data =3D NULL, size_t temp_len =3D 0) {
> +       $1 =3D &temp_data;
> +       $2 =3D &temp_len;
> +}
> +%typemap(argout) (void **mapped_data, size_t *data_len) {
> +       if (*$1) {
> +               $result =3D SWIG_AppendOutput(
> +                       $result,
> +                       PyBytes_FromStringAndSize((const char *)*$1, *$2)=
);
> +               munmap(*$1, *$2);
> +       } else {
> +               $result =3D SWIG_AppendOutput($result, SWIG_Py_Void());
> +       }
> +}
> +
> +/*
> + * semanage_module_install() and semanage_module_install_info() take a
> + * (char *data, size_t data_len) pair that is an opaque module blob
> + * (.pp / bzip2 / CIL / HLL), not a NUL-terminated C string.  Accept any
> + * Python object exposing the buffer protocol (bytes, bytearray, mmap, .=
..)
> + * as a single argument and derive the length from it.
> + */
> +%typemap(in) (char *module_data, size_t data_len) (Py_buffer view) {
> +       view.obj =3D NULL;
> +       if (PyObject_GetBuffer($input, &view, PyBUF_SIMPLE) < 0)
> +               SWIG_fail;
> +       $1 =3D (char *)view.buf;
> +       $2 =3D (size_t)view.len;
> +}
> +%typemap(freearg) (char *module_data, size_t data_len) {
> +       PyBuffer_Release(&view$argnum);
> +}
> +%apply (char *module_data, size_t data_len) { (char *data, size_t data_l=
en) };
>
>  %typemap(in, numinputs=3D0) char **(char *temp=3DNULL) {
>         $1 =3D &temp;
> --
> 2.55.0
>
