Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A83B585D
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184318; cv=pass; b=TQIyZDLlahBsbsnC6u1HFyLMorfJSr2yaDnrHpcMQb4LYWYr3mJ0PYB6p6pmZaHMBWqBm33FZuKVSaQGirGPo6RsWwDX5EmDt9KocmlH0jiJc6t1YZh9url/rM3B8ZNcc+RAE9IeWmvUWh+0iHxfRRjLDqGAvpj9ocf8CkYWYQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184318; c=relaxed/simple;
	bh=wnMtkXvkyY9EhOipfPHr7ExpjK5UgIoZvDvTvKubQgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3cl8Lk39xONC7CVhgYpHq85iUTYkht+muTLajBBMBjAGm2ynrzvhxrnd3jQGh4d9Xb8UsTCFBioGD5cjgsX4E1vFlALphU5nxt+vSSnmIWKQROuRq7zk14qYqvHRtR8IvkIrJifytWESc5uHN5DV4Rch9ktfFW2/1L1luJ5cls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V53WMYze; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V53WMYze"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76906adso20714231cf.0
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 10:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790184316; cv=none;
        d=google.com; s=arc-20260327;
        b=ldtmqdfalRTgEAdzvl/vGZvzzgEsG+zkxprGdCFrxICblD/Fm0w1mxIECjRWqY39XO
         iOuYVHfH3ZD2TzI20Zk6WOmZpkIQkgQjeTGz6l0M/YD0YcKJ8ronffzF7jRsJ3IMfik5
         RlvpETf0JekgWGVcUt0jjLf9Y+CPeoVuuzjAveMo88RBg11YRQ/dvqmUrOnVNscGSqBZ
         Cp7ZnPy4cprF8v29mDlcuYiQgL0GIciSxwyWH6sLnQI/2kYQQ2XV9yF3Ys+lnA1rDHJn
         r0pIOzDBbycMVTa8K/AZLK/JQ6SxlBBcRgv9PJp4RrjMunxcCDJ1XtHsF5awdrRWA0Wd
         DlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6cp+nrMobZaAiOlwUVqbm/okkNXoQHwCqfgPbx/ZCP8=;
        fh=A0YOLGP9HbGE+1PJzcfoTIxl+c5FEtO7hvAJYzsryIY=;
        b=Pdm9j/DD8NJu9b82HNGYRUt/ZyKiziZ1xVZTahq13lgo3G3XTYBXBfB4X0ylNLmZk6
         bdlcCTZnRFWU7ok07Aw1tq4F31zr2CPYi2ChLzIQSs3tbb4TwGhLyeT5kBNn+DPHhnXe
         jyOUP2eQzvr9nTdUtQIlYjnb+I/UYXEXs1Q3TFzhppa6Di1zGBzG4PHCzYOvW2NUqXa0
         1H6JoJZJwe16ou5s+Ort8FDnTJXMLk3nH/w7qR5I8PPRJ1dXMC7gnjKI5J9iHM5P89Ep
         K/MYhz7h/VTB1QmZCnjrxQDjUGrsNJ6JqfswfjVHH16gOH1nFJSRO5dmDlukbCM7cs2S
         PgPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790184316; x=1790789116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6cp+nrMobZaAiOlwUVqbm/okkNXoQHwCqfgPbx/ZCP8=;
        b=V53WMYzeFWCvEMzKs9QqUq/Sm9WcfWrs4ZBduvZCmf9Sn1AER4JHLFAOcjPXAP9oRN
         cbPdU3OBrUyiRIAqB5liZs/AvRZ1Tn1TtrNfmmu3ytij1X3rXgt+9wHCmabGEvTa85Dm
         8KUqc59wEVOdvxZcdtKKIchHvmXz14gCXxJKKBI+tT1KbVjjCvXNzAdZ2oV5vQ7AXNWa
         ddIYOOP4+sFz3elq5xk3DGcma/6WMazUsKTJwumB4dkdyzHLv2slamjg2K2RpiGcqu2L
         7ohojpHtmpjcq3Az+bjQE8P6Pr7FoLqeMEejVNkci3WcTFjf3c59Nat1oxMR/yXUfM+6
         7Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184316; x=1790789116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cp+nrMobZaAiOlwUVqbm/okkNXoQHwCqfgPbx/ZCP8=;
        b=OCDK3IYQCF1fkUzjRvkxR/gXy1PPTkHAgT7syNtAAScs4C0qAjzBiySSnNyRZ/5AIf
         MAixnbWFZXrzAwW2z2R5ZDSGv5jYLsYtlUhy8mIrU8NyJuHyVhJw5YZoRj1dgLADq1YZ
         UzF0bxPNyX7bi1dfkRl+OzbmxQdJuiE3FfvB5IY6oWolDABfpxA26Fr9Hjti+2khwlvq
         JNpaMY/8W0MvGvRAUCXWlksjNtus8BESekbrg5VHD8NdG1XFTUO1Bi04sdJchsTckizo
         6JZlTP+9foiL4KkbYbSzTdZt12JgUawQQxCeWEv9S9f2Nm5VewwOUxHjTnCMYGwDTA0q
         On9w==
X-Gm-Message-State: AFuF++lV2TVtCTEPRgHJOYFr5YuwTPIInXyEdKUB56bq7dcBTL7kd4bq
	srJELfjFAEcBFaK+dFqHZP9tE6IIzIaiej1PRVv1bcbolgXmspIh6GZlqpbIZc8vk9zUBr1roWp
	IwRTHK/Nf9DAioXKHO2BePdBbITHz9VumjQ==
X-Gm-Gg: AYBFou1u3d9EQtwuqawP3kXVJUCsmERAyG3FD44pBCXjUjLpx/v3UlTy3MdrkgLgtpf
	tsSCgMVHkn75YavCQO5zn7DGha8JFZI7K3v2H/K9DmVVhrPJNDyZ4cQdDgE0RaAfp0GR9RIUfo/
	eq4u7zEAMosG8PFzbBtDDMLzYSu6c/8ixdrBdmwiNbfhAB/Yvdd7mDey9YpR3gxDhhbYMDjy6kW
	ed2UjquArZ2ZtqYXFqLXFGRrkq+qzRyZkM6b9nIsYg9BPfiTyFDLx1GygKvCK59V9vMTw3HUMSk
	V3m4vPE4AUhUQGBLn84hFxN1gPtWzWQGrPuuVYRV04nZvNfqCvbkReE=
X-Received: by 2002:a05:6214:1d29:b0:912:517b:40e3 with SMTP id
 6a1803df08f44-9140c4798eemr47496646d6.42.1790184316483; Wed, 23 Sep 2026
 10:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923101956.3005420-1-cgoettsche@seltendoof.de> <CAEjxPJ5PPzRBydR-d7nzmBKNq4bivmz=1C9tHyOGstXy+RM=+g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5PPzRBydR-d7nzmBKNq4bivmz=1C9tHyOGstXy+RM=+g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Sep 2026 13:25:05 -0400
X-Gm-Features: AclHuK9zwtntTXzMGAyQFScX4G61WP-evkkQ_jB4mfNJoc7qt6KKMtUa98p2hJM
Message-ID: <CAEjxPJ6YVkVuL7fmSqBVG-qoOqeQAtg6mWjXDwa=ZRC-2r84qQ@mail.gmail.com>
Subject: Re: [PATCH] CIL: misc doc updates
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 6:33=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > - mention self as supported target in type-transitions
> > - mention the special behavior of `"*"` as an object-name for
> >   type-transitions (means NO object-name instead of file named literal
> >   asterisk
> > - mention support of extended permissions in conditional policies
> > - mention requirement of at least one branch for conditional policies
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> but see note below.

Thanks, merged.
