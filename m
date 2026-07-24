Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97B35CB6F
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923000; cv=pass; b=e4Xbzlz3nkpWCAJ4X7MGoh6/5OmMup8kLwf+9mewIW6W9dnY82OO6SW5jMO/IuDSbcprgUrQuaIECJyWUXTLoIEscsTSCTnpcG5aik8+/wPqiy0tK5ZFg6e+B2RYqtxVOX+AuCdfHJnQqUco3Z9IG5lWQLg2RqXlhrrwpntBrtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923000; c=relaxed/simple;
	bh=y5wxYNwzRMi9z1FbGIGxOfH7uYyIdJHjxrf2Z2WhtyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxN74yvArXT7kbS15grCaX1+ZxBz4ohkXPDam1ZJUbCrQDrZbr1HxPSB4ya2MZYEsqRt2rRMGTYhJNMw4Au9Z+sSNu0aV+uSFVuxaaqjgVb9OM+9/fham4vVdfVEeekGufQ9zRjkbgf3TI2g8okGIF+dh5C5Ao74KxTSgnKe1uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9lGJVrZ; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9lGJVrZ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6aaee9a5084so457840eaf.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 12:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784922998; cv=none;
        d=google.com; s=arc-20260327;
        b=muor9CJlTgFootoL94LRMPDCGHkqoh4DgeTShkWGC1KYFDdkJe2k1IgUU8YfLdKgLq
         pQrwzFuYIcJZr+iw4WNGBYMNCzoLdwgWQtiNcOVu5ejzs/t/LmbqrI7ynnu1xdb+hSLR
         7iOna/Hl6f7nupqEgUuYgxvg2MsiaKek+EuLQN3e4SBILVJvHxJLbJyelnBO76CNAab7
         ysgv6iAXyHCkVezgk5Ah3hkrqEhXfzcTNTCQ52ZV2xwW/eOE1f7lKZWTA1+JfDPUAeCV
         F5rorEQ2kRcTxEC/lv4qHeICtexw1BbpBTPXmTOuMbCpK/JAOloUmyrX+tCX86VfeReq
         o52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y5qGJ/QAO2pSgi9U9u5IUN7fNCmlDpNT2XVobWwTY6w=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=BGFNUULjUkG2u8HFduw3MBVNWkCM/NCMK2frKurjchjJibIwGR5QieOc/JNzrxuIz4
         1WyRlPCxRrUxB0Ql4V2fc+vqdwpi9QxrNeSGgxF7TKnYRsDLRiQqo76PNIyrtN0j4jOr
         geZC3PwTAaJjLKO2ZAI+Ujzw9U/gZPRbMX21uz+D/eTdnLZZoMMN7CNqlVaxF6fDHzJS
         QF/smP+YGUoIgrSEn6H8L/SdW7jcjeHinb3k+czuTcBTYeZzgScJdifqQZTsyS6yOMjQ
         DVuaOLJQ8+ewYeosP8E6nAZL36XUz5Unmqcm4CfKHzD1X6c+wtH6Yy+QalW+JxtJPk3v
         SPvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784922998; x=1785527798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5qGJ/QAO2pSgi9U9u5IUN7fNCmlDpNT2XVobWwTY6w=;
        b=M9lGJVrZtJ46WS3PGpMVFJQXCxrpPUG0Ez3A91lGbJyZu4IaUnx014F7ITn4SxzBDK
         1e9gsaqCef8ZJnvxrWtNMQV03jpWgPjeSa73uSnCrztY7OLOTM8IIgXGbGQqTi+Wsm6L
         YzHzk6RqKlf/2mfivp5ybMH2VfHli0uv4LBzZ2MlPqpw0gzV5+S+Y4xKLISE915zPhgN
         vX18dSPU8ACda/KY9oUs4h8Z6dMT6JZPDZ+mCLIF9S6Z+fYKAEYf/50qF4jVaNtHP9IX
         yb6W1TC/uPeP4MVqJWEEWgeRayB5Yr3YLXZy3mMKmYUhOnjh2XhtbtYY4Pvl/pz9aMvg
         pQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922998; x=1785527798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5qGJ/QAO2pSgi9U9u5IUN7fNCmlDpNT2XVobWwTY6w=;
        b=ogAbECeXassS6huZPzM/5N/iGSmsCGhHyaMmCUcmsZ5JA1/7bm2ZlwV3ZgqIa9SGsQ
         RyurMFvWmsBZm6ib5FIPFMyaH5DYJlEmW/Y9iHhHUyXf8yzTPdrX4p3SxEBjYQ+WcW0m
         k7Omg/6bwhO/RivPCauMsfIaHomKdpgsGoNI7G0wmUd1QzgYnN1APKRSCcR5eIDYBCYr
         7H9th7x3ZH9C+mnHaT38gYNJuR/PfRZhFWQCsp/n579/AkRruppyqFLY978E5YN8Mszi
         SDViRbWth9btdR+XD+ts1fc/hqmlH/ywFk0v21A1F1Dpc1yvH1lo2z3zWrMhpX125XCh
         X1Yg==
X-Gm-Message-State: AOJu0YyFOecAJ5qRuQxHzeqS347GDwqhgjY3xNPbSLIZ2pCtFdEg/5E0
	/xvGgRCZN6R9PMelBaBhTAREMAgEp8sH9mxGysxuqNLVk00VS8XAs8QUhpfVeVK/mefdThcBuZk
	dGsZTSZAE8a2oKcnuH3wQOeX/RQLIUOw=
X-Gm-Gg: AR+sD12GN+BbuMzjXJww7xdYfY+6fTrbO4E4f88yS34GpZyz4uGclhMmzB6Qzg0GghS
	ndBUzMWz2J0d1QFkKzmWA1OwOKDL/gDPJvXeQ/XcXdEFie/bYK+yvRgrTXk3v5peIq9cpsfCkTZ
	J3ZrPtPhicA14OmLMnVeCoYpU9sN4xIhx0GKeS6hQiG4deoGCimi6sAlDpl5v2m5KVGtrDgIH88
	xk/KBJhLd21dbkcfgMt8bHiVcpqqFN4MEXIKsqNqFBvlaZ1ilc8vJ/rGA2/OxcwDTNq/XGr
X-Received: by 2002:a4a:edcb:0:b0:6a5:293c:fe7b with SMTP id
 006d021491bc7-6aad4109f1dmr5326931eaf.33.1784922997775; Fri, 24 Jul 2026
 12:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724192831.106384-1-jwcart2@gmail.com> <20260724192831.106384-2-jwcart2@gmail.com>
In-Reply-To: <20260724192831.106384-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 15:56:26 -0400
X-Gm-Features: AUfX_mzcYCFQWYtH1tHtLpdxw4hF9RxhB2v2WDlXE5XvIoYb49219LCUj6dqGfg
Message-ID: <CAEjxPJ55VNg3fc58+mBk4zSFcu98b0nx4YY5dO23a1_vnMjAJA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use size_t for counting bytes in module.c
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:28=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Use size_t for variables used to count bytes in the functions
> read_helper() and write_helper().
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 5fcf5870..fdf05f12 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -345,7 +345,7 @@ int sepol_link_packages(sepol_handle_t *handle, sepol=
_module_package_t *base,
>  #define _read_helper_bufsize BUFSIZ
>  static int read_helper(char *buf, struct policy_file *file, uint32_t byt=
es)
>  {
> -       uint32_t offset, nel, read_len;
> +       size_t offset, nel, read_len;
>         int rc;
>
>         offset =3D 0;
> @@ -842,7 +842,7 @@ cleanup:
>
>  static int write_helper(char *data, size_t len, struct policy_file *file=
)
>  {
> -       int idx =3D 0;
> +       size_t idx =3D 0;
>         size_t len2;
>
>         while (len) {
> --
> 2.55.0
>
