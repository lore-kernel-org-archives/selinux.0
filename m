Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8D155310
	for <selinux@vger.kernel.org>; Wed,  3 Apr 2024 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173923; cv=none; b=ab52MGax1KixR4k4j0RljgdclJMoqWl1Z2na3wZ4ckQmuHSQcla+TJfn/XEnxgm5a7wuzQjrGfo55sl/ckthRU3vzk7CZsF+8yXVYN1PCogm2mcuxwDtAVidixb1DmoHowYD6lz3n/Vxny2rRIOYRI8uvs+FWauurr7z4dms57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173923; c=relaxed/simple;
	bh=I3XTpXzN3ks5xyIRVbA9u+ll/cSnD7eMTgcxcK1nm6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2Ghl/CfDpppZX2tqBWreofwQIggB8exlYqC3S3M1fIMfTPC/jj4viXx3wPVYI/bMCNoPh7PeiGE9IMz2f2J2WKAPJTlgSVQ4vY7I587fKRhRQE8d5O7R8QpVoYN3O5vr821ykq/ENLFOKHjFU6HAbuntB9rJ2l6vYXYOliFhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXt7HAYn; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXt7HAYn"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4766e56ccccso121637137.0
        for <selinux@vger.kernel.org>; Wed, 03 Apr 2024 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712173920; x=1712778720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fYolUpTvTrkz9WT/6+uTINXTWNsYGYfblwqSqwee+w=;
        b=nXt7HAYnQlpf7brydKa7Y49gzsSP5ri2sjmsPwYB8nQemPTrwhd9U5pCW7Nn+JLcJf
         r6OJ6wpp+5JRYuB17kzMG3TGfpN5rMDlx+Jh8uyHsU0Uy2D5vcsGijE6qxnnPp+AJgk0
         D0Bi6VZx0L0M9/+LovsHe753aP/Ec0DKENeOhmdysu4LLOmnECmqP3SlC8a1MHuMOSur
         +taXTBROZmviwxWx1LsTYqu/O8aNZ+4lxzD/xIz1vYiiymqK04dGmWohVK/FQYSpH3Xc
         gQPojQAQwXY9JhGoFU8qPdkrs/5UQNu14sprBHwNeR9qS7jamp0aKVAomYSKBcZze5HV
         JT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712173920; x=1712778720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fYolUpTvTrkz9WT/6+uTINXTWNsYGYfblwqSqwee+w=;
        b=c1Z8K3I9WSKh7bYfg9+S/6OuqQfUvDBsBVEYKjSxNbiSDHeFWDRzl+VVWa8e9WbP2r
         JgnWIgByvExGfw4UeVIro5COw6zyrDqyNE/Va8dtFkwLY9K/fFro36Blm0m+stC4+PVm
         8CFp9i3ySSIyOZ6yqgXsvvPz0MyoEOCV+0S4l/iQ38vSUaz+O8EnoY4mm11+Cko3KfZU
         41FoKVt/tPi0nvn/jvQdf/kaMiSWf7iJbeAgUDnWmOxLCKmFqkil0Y5LZKaTVqUa/2NC
         3KIh4e7qcLEKKez2BemxnLZ4Gk91H1/Hy6ZM+nUVDch6eso6lzWaCk3qwbmu6KbDjCQU
         D8kg==
X-Gm-Message-State: AOJu0YyTYfQY1+cb9Qksz7gTIWHoLCL7n5QVnbexClTk9fi325jWwQV6
	cY3Q/TOcn6gjPg29WI/o5rkMel2sfsBNBpKN14hHIlc10ggw3pdCrQWsQuzbwqdM877XHj4oYiP
	lGqAChwpz4w8jZsOHzQld9wdCulfMk/8Dth8=
X-Google-Smtp-Source: AGHT+IEf0gwM15lEojdacEMSWh80yoe6it94S75xMmeW/Z+FuSISS6V8+9sw5FtMqEprvOV5D4JOeXxmJyD7XnL7zhE=
X-Received: by 2002:a05:6102:4a06:b0:474:d382:1cbe with SMTP id
 jw6-20020a0561024a0600b00474d3821cbemr415590vsb.16.1712173920558; Wed, 03 Apr
 2024 12:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402154238.104378-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240402154238.104378-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 3 Apr 2024 15:51:49 -0400
Message-ID: <CAP+JOzQ9eHY6TxmSB+uDwB0wWvRiNSZ8_KpzQKjo14yve_zxwg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: constify function pointer arrays
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:46=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The function pointer arrays are never changed, declare them const.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 0c23a7a2..49f9e8af 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1126,7 +1126,7 @@ static int cat_index(hashtab_key_t key, hashtab_dat=
um_t datum, void *datap)
>         return 0;
>  }
>
> -static int (*index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum=
,
> +static int (*const index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t=
 datum,
>                                 void *datap) =3D {
>  common_index, class_index, role_index, type_index, user_index,
>             cond_index_bool, sens_index, cat_index,};
> @@ -1409,7 +1409,7 @@ static int cat_destroy(hashtab_key_t key, hashtab_d=
atum_t datum, void *p
>         return 0;
>  }
>
> -static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t dat=
um,
> +static int (*const destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum=
_t datum,
>                                   void *datap) =3D {
>  common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
>             cond_destroy_bool, sens_destroy, cat_destroy,};
> @@ -3410,7 +3410,7 @@ static int cat_read(policydb_t * p
>         return -1;
>  }
>
> -static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h,
> +static int (*const read_f[SYM_NUM]) (policydb_t * p, hashtab_t h,
>                                struct policy_file * fp) =3D {
>  common_read, class_read, role_read, type_read, user_read,
>             cond_read_bool, sens_read, cat_read,};
> --
> 2.43.0
>
>
