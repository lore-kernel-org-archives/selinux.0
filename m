Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E437FF46
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653104; cv=pass; b=tEeRxpVSxEOUlbUJ5zA+O4AvnyXShM6a9Qjd+5ae1l5GfV4N4XRU3jPxBVTBWOoI7J3xZaBZhpsv8ln/3/0yGWhzrCVxYq9DvC+jXD5IO+xU+HL11vm4ZjKVpgpxdfyWiEOENMZrjPRd3cjh1e6ZYSkT10CXDWRQ7glPX/G51zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653104; c=relaxed/simple;
	bh=PM5DOke797BOlyG2p30Rtnc9A5QAWI7PqQT+VOPZkgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqSLcEMDxq2HKLTJgEDS+af2S4/i7BwK/asgMoZQyIOqZES31014/07GyfIgdAlEHT0x/uSQVURK8qEmbElcIXIEjhTCr2mhbg6YvKnR11PJIbOEZ05moIHNt6L9FnVr38p7qCmqrNl5UhylHGFAj2zVdFVrHxD2Y5c8SwzbFEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV8F1sew; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV8F1sew"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so126548925ad.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 09:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784653097; cv=none;
        d=google.com; s=arc-20260327;
        b=bMl0hPPuazdw9EnO+IorLlKDDBpXB6Lyu93rwhxmjfzi6tmVV3z2UVTCm3pXEYx/6N
         3aGmRZe45orVrcY8nGWp9V1i23Iou0w5i8RVpkr//en4t+druyLHS7VwUpwjVys8bvxg
         CBhyMj3Hedyg8pNzOoJr4sNP1ov9hIFxhGJgbxHQxeaLLESxRfhjhwT4QD/wNDAFfMAy
         S0/rMMr/90IAr4jGz2FJTunzyhWOiud51JYH6LafbcNHwo7fxiyHBDINwKmstRPlMUa9
         d6MHf7gRkx5TjD9y1KpsNsSlc7rUzhPTVb9nCe+w+1t+/VInrX/AlNeMAomwhPd93Ugv
         h9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyDrF4z0BxUHc6iZda6NVOeuYTfnWULjmZ/WczIvI68=;
        fh=D/KQB4URPwWHblWqYL2gyhW/Myo+Pdi77+q8cnPSdWE=;
        b=WKEDlA6F3jVs+HBgeyi+CLEiN/kNtTobq9LSHhd5eAtkosGIiPn5nCAImo2mW49ltz
         cnPinm5EBbnXleF2jTtDpb96WH1qChaFQRj3JDd45qveK+mL6pYqSNnMfRc6pGEDDgpK
         74+SPt2lZqEPqrWyh7RtzPtTOBnHxFcbcXLGrs8c5EOdkw5TmPZIS1zDf2tD0n777jrW
         FZT7DlLrxUEby71eRywz5DdeTTBDl98Z259uY0rfthvrrQYh5YlewSo+HW0rW2IHOdJW
         ZKNXKCze5qO1kBy+95ik7TDf+uFU3cB1uFoEGJXNIUYrNtrKIk/6ynXOD1XYkFafN8yy
         mxRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653097; x=1785257897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyDrF4z0BxUHc6iZda6NVOeuYTfnWULjmZ/WczIvI68=;
        b=LV8F1sewKXK/wTOTMbrP5Moirp87q2UQ1WyqFD8FsbDmMIG51ua/3pZdwsTMS/3Fxm
         Fc3tG7VNWQFfTqI+OkWxBWTWFh0GDoyjfmT37M1lYPiwcOHH3/1gWVY2JiSp6loPLviB
         zf876cXO2FPRDRKv+I822WmHHU60/C0l12wLxFy7oTTo9/5fEEINrmcbKo5yaBSh0uhj
         Ij4MjpC6pBbvdnptU61LxjtfKE8yj/uTMAVD4ytK6CW451KYGyY35Qxuq77leo4M/eAo
         SbAuEyeQsZVHP8TrnEszwqxTEihG9p/9CucjOptvn6Lj3OjhkHP5spfMmM5eWQFpmv+V
         QDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653097; x=1785257897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyDrF4z0BxUHc6iZda6NVOeuYTfnWULjmZ/WczIvI68=;
        b=UiKeD4mtofL04YrPv4j7FrrlT+UBSDWxfeqSYZWaNrACrBEZ0+ANNabJE09BinQRPn
         jgI0NZwCW0juscHL+YcBkFCZcyMHc8QVL5FHIzxDuINkWlqf9c9H99sIUq1MGc2g/ieP
         Ekk/wRsuv9Q0oVo8QEbrJwFH0rhT19tu3aD5FkxPbFV9+hjkoh2DMdDWdK+2l0SWNT5H
         SzySWFr9YJgWHhUuYpZq3jSSNjne0c7ouM2uzKKLkivvZBLZ4F5jqdwwM0/ibDOBl6uv
         FgcFw3Wprkc5rhfWzRVl1LvY+hoYngcg85CczGBadV6WbScl9VzoGyeP+lBOz2/lY+uz
         zFZQ==
X-Gm-Message-State: AOJu0YwcuvWsImXvhS06EeadyNWcvXPAj3JKcTdtG4tfwAIjb1Q35LDC
	ZfNSWCKSTwDTxTB6raMIVTxXP+S/1j1N645n4jZcsS5sl2GqMQRFhfgpaaz6Jobu39pspD2Qnz4
	IdzE7ufNvJCo41dVKEw2R/ychwTkfvqc=
X-Gm-Gg: AR+sD11QYOnzCw8FrSL3wkFjYIL+JCfdOsU2KhslrNupcSESpqXGKfUkDV8/5pARD+W
	PDofn95ixoKZZbAA1jxi89fSAHFGXm/G3Xxh5gRDWDr4BaMUwM9n8V5uIdwxZABHanJd+HUqJAY
	pnRYdP8SDehX7I41tLXmHG7cuUyEccEHi/vCItq0av95gnH6Hsygh8/NyBan7RYC89Uz+J28YP3
	TeRosFh/NLdgePMFbPdx4YIxTB+FOyGvArlIslpEuvIxj2/o3fyAmAgOryyGA==
X-Received: by 2002:a17:902:f710:b0:2cf:7d44:e14f with SMTP id
 d9443c01a7336-2cf7d44f558mr61524395ad.26.1784653097046; Tue, 21 Jul 2026
 09:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <20260721021127.1313453-2-tweek@google.com>
In-Reply-To: <20260721021127.1313453-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 12:58:05 -0400
X-Gm-Features: AUfX_mybD8l9d1cmuVL0TPPUdGDRGG2RtZeixfTzB4Sv-Th-6Ef45xm1JG9_42M
Message-ID: <CAEjxPJ7pfTxcZ=DRO4WaW9J3Twrttc0LiK1RsEj_HMtUPDv00g@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: support multiple contexts for the file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Update the file labeling backend to support specifying multiple
> SELABEL_OPT_PATH options in selabel_open().
>
> All provided paths are stored in rec->spec_files and processed during
> initialization. Derived files, such as substitutions (.subs, .subs_dist)
> and auxiliary contexts (.homedirs, .local), continue to be based on the
> first path (or default selinux_file_context_path()) when enabled.
>
> Duplicate checking logic is refactored into a helper function
> report_dups(). A duplicate with the same specification result is not
> fatal anymore, but a warning is still logged.
>
> Additionally, duplicate validation is moved after all files (including
> .homedirs and .local) are loaded and sorted. For single file context setu=
ps,
> the only difference in behavior is that duplicate validation now extends =
to
> fc.homedirs and fc.local.

Not sure if this change in behavior is desired - it seemingly
precludes .local from intentionally overriding an entry's context.
Defer to distro maintainers.

>
> A similar multiple files setup has been used in Android for 9+ years.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  libselinux/src/label_file.c | 216 ++++++++++++++++++++++--------------
>  1 file changed, 132 insertions(+), 84 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index eb2e66da..902c9a25 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -104,9 +104,59 @@ void sort_spec_node(struct spec_node *node, struct s=
pec_node *parent)
>  }
>
>  /*
> - * Warn about duplicate specifications.
> + * Report a duplicate in the log.
> + *
> + * If the duplicate is considered fatal (i.e., if the specifications of =
both
> + * entries do not match), return -1 and set errno to EINVAL.
> + */
> +static int report_dups(struct selabel_handle *rec, uint8_t inputno1,
> +                      uint8_t inputno2, const char *ctx_raw1,
> +                      const char *ctx_raw2, const char *match,
> +                      const char *file_kind)
> +{
> +       if (inputno1 >=3D rec->spec_files_len)
> +               inputno1 =3D 0;
> +       if (inputno2 >=3D rec->spec_files_len)
> +               inputno2 =3D 0;

Since you are intentionally passing in num_paths + 1 and num_paths + 2
for the homedirs and local files, this will incorrectly attribute any
duplicates to the wrong file. Not sure we want cross-file duplicate
checking anyway.
