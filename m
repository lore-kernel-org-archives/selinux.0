Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1B274B46
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815434; cv=pass; b=Fp0hJZlr2JccGFQHgKyKbtDBypTav6j8r4oT25DfEX3DRuBOQuKuaLAJv+2kxSm7m9Fk57+LC3E3tb8CYIVu4iW7QYPTOMQq4ZhT2VCufIy9E/7VAI7FaU9TaTHxo0zWf667E0EKDishvzdCW3KSNI/t88VQ6KpLuPey+UoQKi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815434; c=relaxed/simple;
	bh=JTfo2MVrSIEhO8oW+z5elUO7JAyP0cWs7oTBbf2wcZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD2Qa7uVhZfbO0pDz2bsavH1vkWt2JLJTzkfjNSCCIU3w/XSSLWiHt3osn8W7jkXircPv78J1SL+RDS9G4r91XsnskTMluGL043EwgyDpS1TmrV55GEr9Kcw3/Cfn7UkeMS/aK56bjQxAwMaFEh0J1qQCY6P4wFqTOF/xAchidE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUknQRbP; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUknQRbP"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so417100a91.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784815431; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxW6UVgPBuD/3cp94afY1RB6ICSXRZLZm+5Rdk1lOR/z6ywysCMwxCh7Fpu7t2u0FR
         pKTgINCKUI0z7e8F071R4NwDJxUkeY2xdv5F7zBOaPgfl4D6+EU99ou7SLB2uJhEneZM
         LdiqcP1w9kjPVYfQXCv5iTzwQNq+FO1lcyvqpD9EHpC/hBIfBNeD8qTNBcaL++hLpvEs
         WpKPSp6yqjq+Y+sS6IxHzXmKe2rdtYySiYLK6nrXY5pnwLAdq1wXF0+Y+gv73BKuIIfO
         CPyNKWMTsDJC/IT5Bj3zdjAgEtwLOMnRWOsipaj61vQa6eCbAQiwjU43k2GQxKjX12bk
         Fifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wvPjSViAfJTtvNaTdtvHZbNLJNuT0b/pUjN1Ww0wv1Y=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=Jsv8leP4e+NwzJt+wDOyJov7X39XwaX4E8WgBqln17mLBQY7LALC4dCcdBxyJrFIPH
         xACBXjqB25WTvxL9GicU16EAfyCnOClVV5wuq73SNvj2Oq4Vpn40Fmfxlc7/7dXXwKwQ
         95YgEhhLzaeF7W3pcYHJ+xH/zEIRNlDUan/nLK+/dO/sK59BU0GvwAxHcE+NcnojovfW
         iHHJV9bnGkekBn5XdZ7/S6rQViRgJg0PJkVw/W24w42oRBZYxTEbJlL3EdkBpuzNzW4J
         tHPavptIYg40mvo+IYQdUG/GfPFJeOxCEc6k7Jd6aTcG8TPyY6erHAgplu0vq0HXrn1I
         rmWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784815431; x=1785420231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wvPjSViAfJTtvNaTdtvHZbNLJNuT0b/pUjN1Ww0wv1Y=;
        b=LUknQRbPScnxI4x9wL+0HwjEP59nbjeaojFYUQIsnli4rrCYrdnuxWrHbHC6nJ0cmH
         zKSxxm1vRKFcefaiTNd9k1PRAHvYH+3kg259bMQt1mmO5HKj3zo0leNoECbFYIwaqCum
         AgHNzi3bD6L2EX4Hl73/Fl3rJaTTFbp2YLjWvkqqWuxiTJRTC8zHxwV+zJz10C6WxzvN
         XpdQjcbpMIViItVQNrTDG3KUVOvjKGci/quIKoMmUGruxXFQcZlw4c/rKDvbLbzIxcyc
         xKJhdGB0+vOqPii6zgwtj9eWaALMd2b2b7rIvbbEhJ77kB39sAzy09mqdRJhY02IQ5cW
         bAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815431; x=1785420231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvPjSViAfJTtvNaTdtvHZbNLJNuT0b/pUjN1Ww0wv1Y=;
        b=swAzXYk5fm951Sxue0C7SugO19JMdjtKpYohMciq6zBntN8egTHp6yGAWcDbtR6M0A
         VCoAQDZVvboOEhPf+mt3QIK7vpkq5aWUu3vJPWIbOXb53fuDcDdr81bQQ7Wl0SBrW2+x
         lEn3Ydjkzpb3zqDpI5loTmUtxsKqHbiZdKHjADjwLSd07EuVMqODSVF59ITZgtOEPu6J
         aBAwnbLNCIxM8/JBYLpybgjHaFNNn/Al9ldXhY3QfEzInKUOjYVgCzh82nk/x+eOmUAY
         4j5KjK0+yaetAtD/45pLjxgWnN6D2XW3FHPa2mYi8ngz2UsL5Zdwte9FY9RXRr6wom6d
         uBRg==
X-Gm-Message-State: AOJu0Yx8cVPhoDsJixsunkkzGfhWJZ7VJw5yoXJ94em2KmdvpFwGT2Fi
	eRohYiq34/DdT5MqhqyU3t9AueMuY24CEp2GyriLlBhmNm+5CpbnyZmGy+p7O+upAmsoOc+g+ko
	LEjhEGE9h2rtTzz46BReDh5H2sBM/3eA=
X-Gm-Gg: AR+sD11uat5iRDASVUd91zQcBUbW76WAmBxeKYQEw46fMEorwj4Y+iY1gNjZKL9tWPm
	lFVYJ+oxHCL6qEiRt66m2VrtJZ6l0++omVdqr4C/EsLKt36wdIR/qZ3v/4m3pQw5dXGl2ndLW+s
	5pnUS0BgSDXxfSb36LZ3kLchXq/t/evqQBI7prq1nsvjmUULm90Q4Lt+wbjIeSve+8Ic0kDqj94
	3IDzdo3cTzZOHS20vCtUoZODHWIZ3mRnKRYRGZwfdLePS1cqKuYP2TTQLAE1w==
X-Received: by 2002:a17:90b:1d11:b0:385:3ab:fecb with SMTP id
 98e67ed59e1d1-38ec8389f0cmr1591149a91.4.1784815430426; Thu, 23 Jul 2026
 07:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723031102.2718093-1-tweek@google.com> <20260723031102.2718093-2-tweek@google.com>
In-Reply-To: <20260723031102.2718093-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 10:03:38 -0400
X-Gm-Features: AUfX_mw3na1nN_ji2_qSTFY7Rxta58cYpFy0zjaZrqMyTzl6a8G3VuP_oTT-e5s
Message-ID: <CAEjxPJ6_ZBTP=wVnF3=cW1NNQAAsnDLFG7FiA0rv0r_-nLCZUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: support multiple context files for the
 file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
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
> Duplicate checking is only performed within each context file. The curren=
t
> behavior expects the ability for a later file to overwrite a previous
> declaration (e.g., .local).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
> Changes since v1:
> - Restore nodups_spec_node, ignore duplicates across files.
> - Change num_paths type to uint8_t and check for overflow.
> - Check for NULL before strdup any path.
> - Use num_paths and num_paths+1 for homedirs and local.
>
>  libselinux/src/label_file.c | 139 ++++++++++++++++++++++++------------
>  1 file changed, 92 insertions(+), 47 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index d91e1462..02bd6f5d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -126,13 +127,16 @@ static int nodups_spec_node(const struct spec_node =
*node, const char *path)
>                             node1->file_kind !=3D node2->file_kind)
>                                 continue;
>
> +                       if (node1->inputno !=3D node2->inputno)
> +                               continue;
> +
>                         rc =3D -1;
>                         errno =3D EINVAL;
>                         if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) =
!=3D 0) {
>                                 COMPAT_LOG(
>                                         SELINUX_ERROR,
>                                         "%s: Multiple different specifica=
tions for %s %s  (%s and %s).\n",
> -                                       path,
> +                                       rec->spec_files[node1->inputno],

Here and below if we hit this error within .local or .homedirs we will
have an OOB read on rec->spec_files.

> @@ -1511,10 +1526,50 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                 }
>         }
>
> +       /* If no paths were provided, we will use the default path or fai=
l,
> +        * depending on the target. */
> +       if (!path_provided) {
> +#if !defined(BUILD_HOST) && !defined(ANDROID)
> +               num_paths =3D 1;
> +#else
> +               selinux_log(SELINUX_ERROR,
> +                           "No path given to file labeling backend\n");
> +               errno =3D EINVAL;
> +               return -1;
> +#endif
> +       }
> +
> +       /* If !baseonly, we reserve the last 2 indexes for homedirs and l=
ocal.
> +        * Let's make sure we don't wrap */
> +       if (!baseonly && num_paths > UINT8_MAX - 1) {

This is never true since you capped num_paths at 254 above (return on
UINT8_MAX).
