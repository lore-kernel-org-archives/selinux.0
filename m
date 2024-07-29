Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199814B087
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265839; cv=none; b=XFAf1ZBDjvEy7cNaSpBV4uE5ynBMxTwQjQ8A/PYytqHs8RyRqXWvTPh2D1seOKJTUFqXAOPkXI/m/cd/b8Cp3+5OO4aHzoUDeZlpweHCqEd9/C4kQr3sF45qcH89ScS6QaSa84LrkwU3XgGcTDaELL208vMfRv3wn3nZx/ZYHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265839; c=relaxed/simple;
	bh=erxFxkNuxqum/SScs2WOscLEhKEc1oKQ1vzT22uoENk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQccWf5EFP/57+xQOCoXS66JuSJxXC7crGqrtiP0Tz91OQ41pAI9ErBBK5/O9+cICmJGMbpRmcLRmKxbcuqgh3pan/Skk1LnujQdP2YgwLccOQffhBfUO8JNNqP7JCJZhdSVuB2PYOxjNnqHvWV42XOkHyXhNMG46nUXPdBv65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GRczSlnZ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GRczSlnZ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0874f138aeso1661700276.2
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722265837; x=1722870637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVYsAD+zTnmRxbenkp6286T2mHXWLjdvia5PKQure6o=;
        b=GRczSlnZnfZlADeiFD11k0kVh+Go92MRAiC3E/XI0eNTmBL81ylIJRNar0smGAEtnF
         0SsXzIONYbZtHeMfl1gqP5+0zCWtAHB2Bxcd4nZ78J+2uCVZ8EGRUlfikS3z3J6oCBKu
         BUFYH7w1J0LJdLQiTDb6ndW6kLNWlW1eDf8Cq8or8SDdNDstOWBCzWBh72PY+vKSX13S
         0MnY7YjnUr2k2wus29Q7zF6MwqOH+GAyINyGrQ6+iVuKEGksk4yH5W5PiX3UtYfXfhOR
         g+Zn3bEnmTEKfphL8qR+in5dOyuAdg6sOKnR4F0udT564vE49FedRsLjjAbEbbor9gft
         /2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265837; x=1722870637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVYsAD+zTnmRxbenkp6286T2mHXWLjdvia5PKQure6o=;
        b=HHLjLzIGDpQ7E0wVZ6aQ3XIV955ffiPwTHVFMmseuNaHOVcsvNtfVhYdUGqk6fPDxo
         I3cnLCIRzJ+3TXXNK94PWhDesMqvD/fsDmPqFyoD00z2srQOsDnEMDSQIkcUlJVwqtj9
         9dUUjvNuWYMgBKXOLSDqjarw5k7JMmoKtJVKN+15OWm2OlanwJnja5l5clCcYTS5X+F9
         l4ios5O6ltPDnA+HwPsE2Ypu4hFC5Y3nAuhUhgrt5Yon5qDqevHUahFjAPp1ssaazva5
         VYica8cQv94RdtYmBnbeddUHTDr+6BqmggoPidgVfhb2zPYsxc7RQ+Ytk6Ydg3WPhkl2
         xauQ==
X-Gm-Message-State: AOJu0Ywuke12ljijLIQaIy3h7WC9aSIdcYWH0uuEZa5rQ75KylD6lVeT
	lxrBppA+4FmleUOrPxtMdPuUGFF3pQ60JEr5hHOHkytbQFUvH+hHSpsbOnfdsz8ib/e3D1s9Q8M
	5qeSnxJJjaQEHNs8tqJwMstKIQBE=
X-Google-Smtp-Source: AGHT+IERdQ8Q1QPiFtgxSRTCBxSjrvTJ2uElNhDwo2/yTmS7gbLkWNQy3F1e/6I0Z8VtSS7KYYXo3WD0NFpOkBJKrU0=
X-Received: by 2002:a25:6b11:0:b0:e08:6d43:ad20 with SMTP id
 3f1490d57ef6-e0b545018f6mr6205004276.22.1722265836818; Mon, 29 Jul 2024
 08:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719161713.963130-1-vmojzis@redhat.com>
In-Reply-To: <20240719161713.963130-1-vmojzis@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 29 Jul 2024 17:10:26 +0200
Message-ID: <CAJ2a_DcUarg-J64ZuNKuH6OUDvpadwiKnUu9-OeDuiZpE-ROAw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/sepol_compute_sid: Do not destroy uninitialized context
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jul 2024 at 18:17, Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Avoid context_destroy() on "newcontext" before context_init() is called.
>
> Fixes:
>   libsepol-3.6/src/services.c:1335: var_decl: Declaring variable "newcont=
ext" without initializer.
>   libsepol-3.6/src/services.c:1462: uninit_use_in_call: Using uninitializ=
ed value "newcontext.range.level[0].cat.node" when calling "context_destroy=
".
>   \# 1460|      rc =3D sepol_sidtab_context_to_sid(sidtab, &newcontext, o=
ut_sid);
>   \# 1461|         out:
>   \# 1462|->    context_destroy(&newcontext);
>   \# 1463|      return rc;
>   \# 1464|   }
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

LGTM.
Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

> ---
>  libsepol/src/services.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 36e2368f..f3231f17 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1362,14 +1362,12 @@ static int sepol_compute_sid(sepol_security_id_t =
ssid,
>         scontext =3D sepol_sidtab_search(sidtab, ssid);
>         if (!scontext) {
>                 ERR(NULL, "unrecognized SID %d", ssid);
> -               rc =3D -EINVAL;
> -               goto out;
> +               return -EINVAL;
>         }
>         tcontext =3D sepol_sidtab_search(sidtab, tsid);
>         if (!tcontext) {
>                 ERR(NULL, "unrecognized SID %d", tsid);
> -               rc =3D -EINVAL;
> -               goto out;
> +               return -EINVAL;
>         }
>
>         if (tclass && tclass <=3D policydb->p_classes.nprim)
> --
> 2.43.0
>
>
