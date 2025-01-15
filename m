Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0870801
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954354; cv=none; b=MaMNad9Ts1i6GsQban3GMf32wfxq9bibBNRQxKgRLjJ2kA7qL0nTKTbQoi0zAGFgInqO6JXYRTetQqdb4D7LKEqJcnjKNb1TqhHCfYOt84rf8945WR82MPoVSOxogTuI889ytt36sz+yDRoJW3tNO4qgJ9QLe/Duq8FXjI1Pzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954354; c=relaxed/simple;
	bh=QSUXwS4UkhK9RtlL2p2RgcgGrz3FIXWjKc0qSOOPQr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZD2vuDmMaju06dyVsBzIQnMevcpYi+xL2zd14fWfNVQrpR/CtGb7csZ2LR5tySI5hRlQlYLIWDIcKB2X4wpbGKTiJj1TCEWyFUcEDzNJFEO6fdp1VgPQy6wTJ0kKkpT8OBYa1l1L1v909YepNMPKimw4fLTChndbwp/bHjJsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl+ef773; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl+ef773"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afdf8520c2so2219133137.2
        for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 07:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736954352; x=1737559152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu5FrFbkX2SjGRhH57yNoKg0FNmc7jd8hsc8fd4Bd5I=;
        b=Nl+ef773vrALvi4nMRmZz+itEwoWOu4+3pTm2rl07fD4WCdSi8G/1Zpq0pSRdWFINs
         cokEuW2d/Ho6BYmLnBhWY+akEAMLakuBsfZL+bhHcx50rTnRIKcEsWqjoSdcafPFSUsN
         7dtRJz3ei0Puqq9X/g8KZ2+FQA0Hl7cCC9djOOK4JwARiRYO86woA94zxkqXgDZfeWCC
         MdGaxb85ZJyWOAnXXzxmsdKMLqW/waD6hjWO8VQpZxxLJXd2q4UphCVX+o2/uIOXpA+X
         zFnZglnks/0jMLM29RPpcoqF9ABq5v662wavf1dthEoMD7goWUm1+KpVJsfgp5SdWA0l
         z9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954352; x=1737559152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu5FrFbkX2SjGRhH57yNoKg0FNmc7jd8hsc8fd4Bd5I=;
        b=mRtld36ADmXZaGfsSNZQt13iGpJbB/5v+Hqg7wJ5XLm3f8SwK+sD57FJZ4Zqneam/A
         GLP8AktCzN+XjtDuBayCQvpwKJPGlMpc0a9Tv1TNMaNKbTdZD2G+8VKq33++wCKiNXQP
         8dlIFxDldImMq0p+zjx1HyeVpwBg9uvCd3mOMOt8kdDI/sddIG1YouVJ910j5EBHceto
         LMDls2GC9IyqJ0iISs8MrnxUvaxBT71oOdeA0ONtn7MG+WvVuowTMsvHvOCU/k/TuAQY
         lVfQp1wO18zI2tWL7LjbjvrimA0bH3IyiK9q6Je8p2uh92bJwN11AzWnS0iMrcFMW9uv
         59SQ==
X-Gm-Message-State: AOJu0Yzk65eZL84aQeE+RP08FLu0A6O2sMGH0GsgdKG0j4feybEq2cz9
	XcD51UghkcRcP+Sa7MBs9M5UrLXSiBlC0T7/Qredt4+vSRmZlmZ3g67BIvtcxjI6mc6hsCMjVq1
	iN5Akno5OARz51Jzw6EaA+h2F7Is=
X-Gm-Gg: ASbGnctqrEaW0xErxaK76Duf37fpCZbt/sdxN2E/xFuE/dPSbEwfooPhGZPnCl+FKI9
	ZD2rIsmv84DRWk3sc/xssYpLe52e5ck484z6qsw==
X-Google-Smtp-Source: AGHT+IEg/y+5NBAIDqGN/2xT/D5LkD2KqjfxiDLJ192/VWS39HOoOhbAg+G7ru2+LdcKrzBonLhk3f+JY1wkBX2h3bE=
X-Received: by 2002:a05:6102:a47:b0:4b2:5c4b:b0aa with SMTP id
 ada2fe7eead31-4b3d0fc5060mr25339198137.17.1736954352061; Wed, 15 Jan 2025
 07:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109121530.21728-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250109121530.21728-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jan 2025 10:19:01 -0500
X-Gm-Features: AbW1kvbWIosX1P4_8RfcmVz-QJNsn56V6CctQ54RAPdjb1jF6LxWkZsry7LCroc
Message-ID: <CAP+JOzRSxEH8refEFbP2vcjT80dQXPXKcmSjRmQ--xqpiL5bVg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: limit node depth while parsing compiled fcontexts
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 7:15=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Limit the node depth while parsing a pre-compiled fcontext definition to
> avoid unlimited recursions causing stack overflows.
>
> Use a sufficiently high value of 32, instead of the node depth of
> currently 3 for generating a database, to not unnecessarily limit
> custom changes.
>
> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> Reported-by: oss-fuzz (issues 388615595 and 388592303)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 56e20949..125eb601 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -674,12 +674,16 @@ static int load_mmap_regex_spec(struct mmap_area *m=
map_area, bool validating, bo
>  }
>
>  static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *=
path, bool validating, bool do_load_precompregex,
> -                              struct spec_node *node, bool is_root, uint=
8_t inputno, const struct context_array *ctx_array)
> +                              struct spec_node *node, const unsigned dep=
th, uint8_t inputno, const struct context_array *ctx_array)
>  {
>         uint32_t data_u32, lspec_num, rspec_num, children_num;
>         uint16_t data_u16, stem_len;
> +       const bool is_root =3D (depth =3D=3D 0);
>         int rc;
>
> +       if (depth >=3D 32)

I would like to see a comment here explaining that this check is to
prevent unlimited recursions and that 32 was arbitrarily chosen as a
sufficiently high value that is not expected to occur. (Or something
to that effect.)
Jim

> +               return -1;
> +
>         node->from_mmap =3D true;
>
>
> @@ -794,7 +798,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>                 node->children_alloc =3D children_num;
>
>                 for (uint32_t i =3D 0; i < children_num; i++) {
> -                       rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating, do_load_precompregex, &node->children[i], false, inputno, ctx_array)=
;
> +                       rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating, do_load_precompregex, &node->children[i], depth + 1, inputno, ctx_ar=
ray);
>                         if (rc)
>                                 return -1;
>
> @@ -969,7 +973,7 @@ end_arch_check:
>
>         rc =3D load_mmap_spec_node(mmap_area, path, rec->validating,
>                                  reg_version_matches && reg_arch_matches,
> -                                root, true,
> +                                root, 0,
>                                  inputno,
>                                  &ctx_array);
>         if (rc)
> --
> 2.47.1
>
>
