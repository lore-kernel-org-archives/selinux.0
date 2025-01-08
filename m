Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487431ACEDC
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369129; cv=none; b=l/ZNQfkLSRjkiR5FxBkRQ53zypqJ528C9s9rOSnTOL3u5QRkJM5DLDoL/uYBheOknuEApqf9NLDixvNUiPD5qZs2xFaTi8eXbwGhlnhpBZh8Trdkaguwwnw0kpevPTcitVvFc0bk5ns0p5VC0pfRW6/yaxRIDwgJR8QcJkW3v+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369129; c=relaxed/simple;
	bh=SxJDCB6Uup8eHpsuc3cND+QfchTboJDuhY2i8LxOxPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAQ1V9yDnd/mNeRzhaOFFVp/xwoucsSX9mMv2VX/Hiace9TlExTtbJ+pXbA0gctVicBmDl45hfwofHymH4CJ306Xx2Emt7+tGI8MRn/25VF+XVA2V/v6p5/QQbw8/mW5xfyb2flNuqs+gZPddqrpoJP86o2UpAFjK5NrHFXsOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0b0fYUm; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0b0fYUm"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afefc876c6so88496137.2
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736369125; x=1736973925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHjgN4f22tVhxKqH9MlqXh1gJVcfERKEEO/C0YwnCBY=;
        b=C0b0fYUmxIAUl/1jTc61wxmvt2uCYAt3XjsBD+a3UtWyMh2HQMKhJuJs8RlczaN0ST
         S19ONeTcQlZdiqqUntEJP2szrycXtUn1yxTDO8+P7rq+wbdoMQ7nJOrWgKqNLafpWfgY
         lZ4cAfeFfQ3aOvAlAA1RozBrGXR+26glht4EG0VyO7WlME8x8JPPIvlF7tGE4XqKrSTO
         A2LY2vvTyNg4mzKl6ddEn/mxoyNtkc2eUPBpj6iXGASqWNTsJ7bPIeQaAgyM1qZMGngr
         nkpLnb6wQL8JXVz20rMuMxj8dEjFumWxHn+WVFiocJe2L53rfzsB0qIMqUh7LhnFnoas
         4ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369125; x=1736973925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHjgN4f22tVhxKqH9MlqXh1gJVcfERKEEO/C0YwnCBY=;
        b=KpBXRf1qrl/wr3mg0+2Xqw6SrpI9+G1Ep/xilDSnsi6RBbqm+N3CaYfXei+6uaU/yn
         8F9C2JvHP1sagSxQG2twbw/RxLBOydI0F9MwniokE8xTbzWqlsWYUfQmtg8M8akyrS02
         k1mUIp2E5JOkSv6WZeg97aFROck1/VcrncwEQsfrP6Z2KavgaW0YYJssSW70auh/JeGT
         CrjlgdaGBaXqr4STkTFyOon92ENsgZJPQ//VvDr/25V4PBf9pAcHxy29I4W6algZMF32
         Co19S+zG4efYGNcwXNO5ZC1jsv61XzJuKBbx8ozQ1snsF2Tw37q8t+BXBI12HuXkcOIa
         DhzQ==
X-Gm-Message-State: AOJu0YxGpuhSOAD5PHkdNNmyqwcJaC8CxOmRbivhHvzKQA69VnnpCf3P
	2vbpgPcsvKQzf53TwZIHKBXaxWNWuClLJckJU4bCAXVZrgm0DO72QCAB4flGo4JScR77EE/AnwW
	eALbPbj41dtcEGnAI6lsUGKiZeNBfedNQ
X-Gm-Gg: ASbGncvwL6dTuocvKklUwzdxbBwDzFCInaAzwg9BnczptXCbPXW2DXk7PQUAeNecG5H
	IDoAXm+e5cKg84wf6s/YEhY6gieHyHJIjtiUGDA==
X-Google-Smtp-Source: AGHT+IEbYR52nbtO0wFruF+OOpUK1U4aMZ4Ui+5eEmWY95YSSNdDFZSiEowXN5QFm2YFi3yCzKehKzyB09GglLnZ3oo=
X-Received: by 2002:a05:6102:c8f:b0:4b2:5c72:cd55 with SMTP id
 ada2fe7eead31-4b3d0d7729dmr3732878137.5.1736369125130; Wed, 08 Jan 2025
 12:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108163149.104958-1-cgoettsche@seltendoof.de> <20250108163149.104958-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250108163149.104958-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 8 Jan 2025 15:45:13 -0500
X-Gm-Features: AbW1kva87ZyXl3zSDuOA3bK9vZbHZOx27cP1XuLD4PE8FA4RBHCQSG05mFGyU9I
Message-ID: <CAP+JOzTfK0gyiqnnoaOGb11o8iy26Obpw5P=ypoftH1jbUy-Mg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: free nlmsg hashtable on error
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:32=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Free the hashtable for nlmsg xperm rules similar to the ioctl hashtable.
>
> Fixes: 1fd41f48 ("libsepol/cil: add support for xperms in conditional pol=
icies")
> Reported-by: oss-fuzz (issue 388376332)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 070bf525..e84188a0 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2616,6 +2616,8 @@ int cil_booleanif_to_policydb(policydb_t *pdb, cons=
t struct cil_db *db, struct c
>         return SEPOL_OK;
>
>  exit:
> +       hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_destroy, NUL=
L);
> +       hashtab_destroy(avrulex_nlmsg_table);
>         hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_destroy, NUL=
L);
>         hashtab_destroy(avrulex_ioctl_table);
>         if (tmp_cond) {
> --
> 2.47.1
>
>
