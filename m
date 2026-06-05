Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077533C5523
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684603; cv=pass; b=Z3qkQHY71LheGq/rEfnJl8/GkpBJRuQ6WrMGPW/DT8lQBQeNbCKo1Gc0B4WmELeFKTPW8ITqkGRFb7zrczMOnoI/rYPthhncLWPRdFXV4/XwhnaP/9ZOJqvUhs7b8rUfB52KU+DCxeRPa+tyPxV7yDR7MRGK5Wt6mF+h/TY2+5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684603; c=relaxed/simple;
	bh=4iMuxk1BELwi9HYqsWqfceePKK7jZJ2g6BcQUQEGEfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMbeYa73JCp9h+lwjFNaOxjy+/A1HILVdDiEOkQsMPQ2/IHvKDKJQubIVtpuTfLb4wWy9JL2A3ke67zvVq50nseeabEeurFzHVkjzBm0A34V36n0a3XLVy1sKXheQm7ghSxdhKOeJgV+9YHyLXIvhVzGJKXELTVTgGTdhgitOR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB1MA7jv; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB1MA7jv"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3967726bc47so21817001fa.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 11:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780684600; cv=none;
        d=google.com; s=arc-20240605;
        b=cM1hBDmZV6Tx5KKxfvfn4wSQbTThybmUZWGmo5VLdYgE4DKOdZV9Fs7tMHDKhtONSu
         Oss1U2oXlxnrpuam1usumy1P+Yij2VJcHzmi4AsvhF3i+6Z+ZJQCcOdBNcIWmwRB1TCT
         9Lx11D9de/Qgg7zar6yJTf1YZBFCx54u2c6GUE4V/kmBD8LtLWVZgorI+5fpgrmaQYjo
         gFHXYsLqw3w4N0sDDXG200FIc0ivUBJDGxuBt5x5zh2p00uhI2jkGd8vQJ0cRq5iaDIr
         J8E5xkb8UqS168iuAwOEg4kSiD2WtKqS8mWHDo2VJX9Idc9947ajsv1zeldhR9V+C86X
         Lwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6sxJOREQwODVgTnmmQajDGQ3LtPbfI0xB/kpq8HLqRQ=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=QeJkNmj4Ok7CpD6TyVDkSF4tTNir7T1GZgw3N9o05tFFPVApBulzHtRu7/ZJAeuOVD
         Lf4uaWXbgNfduWpy+T2yzC0QBjz7qe2AiMDJJnMpP4WjlC0+gB09p6WerhcCe7DAb5KZ
         RyEQv0BXplqPoSkHTWxKanY9F1gXIs/Fge+xQbj5fyZHYGsagNGAX+cMYf8ztJ92f2Gb
         PFJB3QHUOynyakQzqd+4Bw//3RLJOX2LTLoKIszCU17xTSxVWH5hcfysqheSgNvnzy80
         q+9VlFNYeAiLjUoh3iDeCmD4S9H/ydBOui5U38BxAKAhBs9la7OA81owYict2Dt4dCHX
         c/cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684600; x=1781289400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sxJOREQwODVgTnmmQajDGQ3LtPbfI0xB/kpq8HLqRQ=;
        b=VB1MA7jvicSpGDlUJAGGCdUDH+ekHxLew50ICkZe0y+4Z1HvkA7rZ5zJdKPWaQv95T
         R4bi9Vfmdod1BoBgqYx/dxQbqhMcXcR6RwibhD+033woOYBKkz3m6saG7UAacuL3IFoZ
         Sb5+gyI8Lu8rpZJ4cTojp34v1BIn7diB2YfzUcV6R9eZ1Te9dXoItHNqfRat+qNljCuF
         uD99HaUtE5yqK7azbeBoDREy+VU8FaXgbTtLb7wayn2e3jWrObTHr7d8fQlUFdiPxvQp
         5qBuJn9qNrjsaiDUVu7MfsZi3JdjJaIveDqwKwcybWoczy5fH4fDgZcyBv3CBST271+u
         sxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684600; x=1781289400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6sxJOREQwODVgTnmmQajDGQ3LtPbfI0xB/kpq8HLqRQ=;
        b=G5tY6blBPDBA2GqYBrvpWPfip8mqG2BxWEfE30/+lPX33zRb9zOZO2u+oZIvcH1H6u
         RfpgD0nBHsEfBfHO7OY3ZZV0aESgd9cuuIxvUr/bwhp7wQTJj1UF/1l7X2XrT6Ic62fi
         cr7lXrGeUs1BwauxkxYxoIwkimiQC5EkixpP8DJOK0yshBtm8/jEVj6/KdxYGhtS2F7C
         +5byqPcW2XfOb6OEkiEsYu7VNHFej03O5r0zcxDAbM7i3wyJ/XvanuOy7wBS8jbiHsrN
         JpYZohDI4p8JbEpMViodq7TJYUbV93eeqtJ6eckAT40nZYWsx2kHfQnCAHxBXLWvXlIU
         opQg==
X-Gm-Message-State: AOJu0Yz2iHtvcmHeF2dcjjiCTaqIjBskbpB4UmVe6xtRsRa8aabqkq69
	jNTjcNr1dLuCnvrNbHVchnmZWKIBfHE5tUgZaExaqwuQC6JafFQKD1xtIrRIZJNI/SH9W/Lnr2p
	fhldYCuV8BBTt6szJBhheWEuPeC//2nA=
X-Gm-Gg: Acq92OHWa9kqSEbxNsnlI+cHHjzR41rGSK+wbcmg4ns/DvkLXjosXdxdlkvog9MXLzr
	k1UFnbfJAFlXtx+wWF1AaKublTD2tpQu4QCWL3fLxN5As3erlsYZuTw2tkZ4tXnrq56LUGz0zBk
	bgWe/P17ty/VfLic3vL+p0rUDv/amWK6QdeJZw9EtV9jTnypqi13ckhfPdW4K/QcpNM3szM/hN0
	I1gm4pdt2mj6jqNys2ACEwagybKf2yT6dxBRcfCCb2y/qZg5l3Ycdy+9XfDi7SCCFcc+cOclS2e
	xEOai6vHtUwsHEw=
X-Received: by 2002:a05:651c:54a:b0:396:7fa2:e090 with SMTP id
 38308e7fff4ca-396d0ab3b1dmr15465321fa.29.1780684599945; Fri, 05 Jun 2026
 11:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531184111.691569-2-nvraxn@posteo.uk>
In-Reply-To: <20260531184111.691569-2-nvraxn@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 14:36:26 -0400
X-Gm-Features: AVVi8CeIDkPS1umfXcD7KF8wr2F4aR01DZmwp4iuv06ZLl6vxUuEUtRWKm1ovIU
Message-ID: <CAP+JOzR4feRbvZn7E_YyPypAHZ9r_gJEOo+pENAGJE5oXofBTQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cil_resolve_ast: add in a CIL_SRC_INFO for the
 copied data
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 2:41=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> wro=
te:
>
> Ownership of the data copied in from an in statement currently resolves
> up to the parent block. This is because when looking up a corrosponding
> path with cil_tree_get_cil_path(), the chain is walked up until a valid
> match is found from cil_tree_get_next_path(). However, as the content
> that is inserted into the block does not originate from the same file
> as the file where the block is instantiated, insert a CIL_SRC_INFO node
> so that for said content it is a src_info node with the original file
> attached that is matched.
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Unsurprisingly, the patch did not apply cleanly after the giant
reformatting, but it was simple enough to make it work.
I will handle the merge for this patch.
At any rate:

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 048b3aaa..af612f63 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2375,6 +2375,8 @@ int cil_resolve_in(struct cil_tree_node *current, s=
truct cil_db *db)
>         struct cil_in *in =3D current->data;
>         struct cil_symtab_datum *block_datum =3D NULL;
>         struct cil_tree_node *block_node =3D NULL;
> +       struct cil_tree_node *src_node =3D NULL;
> +       struct cil_src_info *info =3D NULL;
>         int rc =3D SEPOL_ERR;
>
>         rc =3D cil_resolve_name(current, in->block_str, CIL_SYM_BLOCKS, d=
b, &block_datum);
> @@ -2395,6 +2397,27 @@ int cil_resolve_in(struct cil_tree_node *current, =
struct cil_db *db)
>                 }
>         }
>
> +       char *path =3D cil_tree_get_cil_path(current);
> +       if (path !=3D NULL) {
> +               cil_src_info_init(&info);
> +               info->kind =3D CIL_KEY_SRC_CIL;
> +               info->path =3D path;
> +
> +               cil_tree_node_init(&src_node);
> +               src_node->parent =3D block_node;
> +               src_node->flavor =3D CIL_SRC_INFO;
> +               src_node->data =3D info;
> +
> +               if (block_node->cl_head =3D=3D NULL) {
> +                       block_node->cl_head =3D src_node;
> +               } else {
> +                       block_node->cl_tail->next =3D src_node;
> +               }
> +               block_node->cl_tail =3D src_node;
> +
> +               block_node =3D src_node;
> +       }
> +
>         rc =3D cil_copy_ast(db, current, block_node);
>         if (rc !=3D SEPOL_OK) {
>                 cil_tree_log(current, CIL_ERR, "Failed to copy in-stateme=
nt");
> --
> 2.54.0
>
