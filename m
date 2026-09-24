Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3434BFE75
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285259; cv=pass; b=SMcblV2x7+zGp9vWke98fn+XTTSqxfmzIEuRBCHCymAQfw6fTUvWZvnRfQyug2SjW/4nryHFq6Hnd0r9yeIJQrd4A2PkCclDAEnc0k1fPUNAK5En7a5yLI+USRdTupNn+PzvHXfaemBIKYkcE7Q0nhyK58xPF0V5yKfQSBKOmu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285259; c=relaxed/simple;
	bh=LCK98wDJywAPCvyFDL2wz3usksGXUhBGmkJswp6ICSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNBlFn+II9FJtCfGYBNGOdDYWGCl1DHbHczabdoKH8J/SCaPvMzVH67crlLU0XbF1Rw5CzGyXR7H3kHbabc7NcjHZYCnNdChLgmTsmwQ7iNNAJpNz0q7gFArmIwc8vLq2I8aU+UzFMpJzWgoAP/hMlgXE0PzGkneG0HhfnViyfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ETp5lt7b; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ETp5lt7b"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so302213a91.0
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790285254; cv=none;
        d=google.com; s=arc-20260327;
        b=hBHVKOIGk2NGf4rX+1Fu8KqAju70+hpQh7pKVLwl5ZhaTzoa2B7unldut+49D9L7DY
         v8D4y+oeEMXG/RvsnaEq3y7izVovIZ8T991r6TdZCrYo+At1kiCA0mMFGGuBhmfCCias
         HOuTth2u9Hb3gXTedcHuKqfr0E6bAfYYwWUL+1dFWYnWqC3uODcfHMe7tesR0DV9ztMb
         GWqjBRNbS2aav4RQDVye5novac/StLSge7nHbw63i5TG2AvtsFZE5rIMWxpTnhNfw3gD
         zK3IAWbFAkNf75ZF0m+Rwg798x8nrQOTWBfhSW256trx2qX4vVwghnMP/fAr10YaKV4H
         dNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+DWFsHNDi9jWDD+wFeRw/v5uBeEmMnsRNnFzv+N5tOI=;
        fh=nK07ivbW4sW2qk8EIY5uzysStLgyYRjVCLp76Vq3G58=;
        b=X4hw67pr6dFhfOq66sVFoD9rE1IzZdW/WHBxfWqSfI3sC9mkLo60tY1kRNWB+6JwQ4
         7DPYj8mC7ts8SzFSG0cMVhzWJRPD6s05ii5mJlTXqpUkiwPi/1UVR7IZpApFP6D75ph3
         ilofujyZa+CHRhy25PWjchkKEsd8Dtsoll9bVjy/PJtdi/jhTnKqpApdXwc6twEwU2Ez
         9t56lG3mOuijTR4KSZa30JPCl+gkUnuZ4lJkb/NwGgeJr3k01L0DIm3bf+vxl0KKuaHl
         Isy7C9oL5DYOjfx+4lwqwv8RkaUlfADJaCPkYIjJLuqPZelyB7O63bcW+uEL3SzmyGdq
         uToA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790285254; x=1790890054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+DWFsHNDi9jWDD+wFeRw/v5uBeEmMnsRNnFzv+N5tOI=;
        b=ETp5lt7bEk9J9h5r+4M89Z8Z3W43K9wbuHoeL5XtbsWbcYXXPGiIOxwDJtoMoBqxC/
         nIy96HN4AvRc9dbyJGaExaVEquE24e3G9b2l8EPmfO0WWPPZ4dTW6lwEfb9FBo/F13ix
         hV8TqDz5Ji4Vo7XnWI8z/61at2JMg/8p/F4t93R6MNSJPQccsfelmhDViydTBhdEP+Fm
         o71ZWIWlMdFsGYfTvm4smqu72HY6szhIMf2OLPvxB557SwXWtJ3jY1aobfC8E6DuQKnp
         /iCFgOoxaQnZFFIY5qCUe9+/0g4XbWatXMDanWdwaxdcIn+W8AyGp1kDpRktvk44aUr4
         2jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285254; x=1790890054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DWFsHNDi9jWDD+wFeRw/v5uBeEmMnsRNnFzv+N5tOI=;
        b=0DIXwSAvrtncXxEGKTOuId5gQKsZtRL7f6jOb/SYVLRzbf3ron2aLi6faNs+sNGNSh
         xobEk1i/Aq4rTCiqRGJ4JsGPu9INwMlsOijZHHDD094uTygBAnyVsHW30YkEYqC87eOJ
         Lz+TYZYBlTITjZwTKB53DjFCWKznM/UY1phwGCe6IcTBB3hlh0cEZXADvklYbwFLdS7R
         PwHmcPdoYacihvHCSsPH0+M5Fg785i4mzthRvq0HMjtavZ25dlVrU2IyVtIzWm9Fa0NK
         hBUqTzLYKyeUhMJC/yo4JAKZC/JQYpxTg/qgCKeVwfSSqHMe5E3zHZwaI/lK2qSiFC52
         UCIQ==
X-Gm-Message-State: AFuF++k8+71Wk1aWhLrz+fowGUlqRF/+joH4Ozyw+wGQ23ykrlG4agvO
	HdM46bH0XLixvHvPO05smOsyPNB4sUaLHAzol8UPpRbYklEg664vjYufcUvThBRDG9qmqL3o0mV
	NXlYlI2/0XNkDI4zcZIbqV05qiXqKPQo7eapEpp7NPQKjUkG7wHU=
X-Gm-Gg: AYBFou0Xn8D7IlLtB4Laai8auFixzULwiFzL8DU3PnzFIrXJpfyg1KPQUtfwswu+IQ5
	Ay97bfggE0tm0mp0G8iPtA7REdObdTpc1gWH9UcTxJ6Jo+1JHTPgfXZ6S3QMyHGBB6Fj/x+5n+m
	k9myoYGh3VZWSszhJuDeAJZC8efp1ALC1umuzKcMosJttTpAgAYx5ZM1h2FgIeMsEYHUxe6PyB3
	/xbowgi7LmShuukbZL6+qtUN+AWslghD7+tPpXROvkXC9Nu/HNLz+YNucKO/JcZe2Gsb+z3jbY0
	gfU1Ue9v8uZHiZGKCo9q0eziPolr2yInXvYXm0UOVoV5FLDgEfypvk3RcNoa+N3p2SnpG52u58b
	fwc9OSk8z1ws=
X-Received: by 2002:a17:90b:4c42:b0:39e:6c68:c787 with SMTP id
 98e67ed59e1d1-3a098e5897amr3536906a91.61.1790285254464; Thu, 24 Sep 2026
 14:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de> <20260903113538.72942-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-3-cgoettsche@seltendoof.de>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 17:27:22 -0400
X-Gm-Features: AclHuK9SSDGGXlxge_CmA-yVXbtUfz_8stkYDHgXAWTecN-E6wcFeNmw2hmL4fg
Message-ID: <CAHC9VhT=BFAEVF3cZVQ=pNj9VBjSSk8wxd3zAe-HBfJqXKL6UA@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: validate user MLS range and default level at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> user_read() reads each user's MLS range and default level but, unlike
> range transitions and security contexts, never validates them.
> Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
> enabled, once the level and category symbol tables are populated.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Looks reasonable, but let's wait until patch 3/5 is fixed for obvious reaso=
ns.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 3bef28434180..efa8df26791d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -738,6 +738,20 @@ static int user_index_check(void *key, void *datum, =
void *datap)
>                 return -EINVAL;
>         }
>
> +       if (p->mls_enabled) {
> +               if (!mls_range_isvalid(p, &usr->range)) {
> +                       pr_err("SELinux: user %s has an invalid MLS range=
\n",
> +                              (const char *)key);
> +                       return -EINVAL;
> +               }
> +
> +               if (!mls_level_isvalid(p, &usr->dfltlevel)) {
> +                       pr_err("SELinux: user %s has an invalid MLS defau=
lt level\n",
> +                              (const char *)key);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.55.0

--=20
paul-moore.com
