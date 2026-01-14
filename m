Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DF304BB2
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413060; cv=none; b=MZbFPWOJLPEcQSnnLDn1FFJVWgIKjSKGchDNsRQck0wta27j6dyrotG06ah1gqG93kUZ6Wu2iv85L4F6BUmBcqyxZNoYalZGO1mjzTU9EH8OpFsrvpDgoY701t1eKL0ck5r+0h/4wWINl63sTW+nMYEDes2Q1TJS3E5pMBCf8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413060; c=relaxed/simple;
	bh=jEVU+jEsRgroD3LrhHK6P/6RoeXSMQ+MO0BR+SLKyZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqBESZHI7dfOP47mtygX9Q/iJC6dpGrJoxKw4eroFI2FS+aHD0Y/QbmKe6zT2W276xrIHX4aE3gVYVnqfurrpv/HWHTMBdB8H8Eo4Jl4AoxGES+ZISTO/KUVa5e1RC5kDTyGbhjhXQmPAVF4ht8ykvJS6cZNOBOsGWeutCXnoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KsEUPnWq; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KsEUPnWq"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6481bd173c0so3184842d50.2
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768413058; x=1769017858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrtR6OKxeBBYUj86i7FNzMXmJsqWTzwxiL2o7jd58o8=;
        b=KsEUPnWqNoViuR6NpaWQnaXbP0wsF8wwJnFvt8GhiybUeCDiElPdxf/6CvQgpLX04f
         M7GPDOYcnBRTRd9J3hOzDxeCCRQ8usRZVNzT0c7WSCd+NOzDsdbwANEhDTL0FzISbDDK
         7EdGH0jDNIWW7B4FhJTwlZ+iFWgIhB0982eYjH5AMlnDcTf4RTx7GhTL+PVgPKNg34UN
         YAM778gOcGLHkUJEgiGvLNb0aTtRYEUEWhWYX0Vu3qaVpCcr9Xu3VXOutxw3lD34HZ1N
         hNYIzj4vRUD2VZTYGnGA27p9evaRqW3w8ZzkBy2AiIqK6q7zNvB0QBYx4YXW0meKhyhL
         BzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413058; x=1769017858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrtR6OKxeBBYUj86i7FNzMXmJsqWTzwxiL2o7jd58o8=;
        b=www5CGJJ73ZyYOZW8y1X5LYLQ03PNJOh3XBJsfyEPhBX0eO1jvs20s6GOnIhf9ZeSK
         eMM+0ZzLqPerhD8ccnw9hNjF/bCDS8v5HkBlw52F3njmEZu9ka9yuBB3W1L0hlAC3PG4
         keVWGul5r0J0W7+U9rSO+etBbMEYBiRgh5pLuQITZifMz/BT7e1QvJAkdw/KbPwZpr/x
         6A2w/LQGaGva7MBj00yaPg73EFAUOIJDIH9ljMoXRzrS72HW+kP3X+EvRUUD4FQKjiPB
         6XJTER9sGTsnVH0gxL42tQIFCAzKgCdfaZIuatdD8sBPpZ8RwHVds4S4ndVlWOIC5DGz
         sJ6Q==
X-Gm-Message-State: AOJu0Yx4Iu19ivplWohQMrF8LItGVlH83TU6fhtoivdmy+ZjI+m8Pha1
	sSPOjyvSliJMGdXvAiqjsAOFUlDky/AYDYlIwl6fWbPZWltJZJCAODh2Bv5i/AhvrIjuJZpOZgr
	3LwqrYdh4dzB6X+OqIrrD9NynnGN1OD8=
X-Gm-Gg: AY/fxX5isYxuwpg1zSVCJvkc2pA+0fcjGqQwuhpX9/7ZOFxjqYYgieFmpyTZ9EpUc5Z
	Xs/GfoDo2OBCHycHus+JgIA0TL8iCmsrMYiVMR27pjFlNOB9EpOg4ptVHDMgE/gDkn3G53ojtnN
	+XTfaK5mLKmngzXRPT9kIolQZWEYi49ONO5Gkyi4EMabba431yKXKCtKVQRGN4jYqA9K8Sp5BnS
	by/2Z8QDr2ntU7AeI8gU0XHj85jeVDP4O2rm67DygUOLrXI6O+EshfJXnwdoaCNqJf8VZ6bIfMZ
	SvC6HQ==
X-Received: by 2002:a05:690e:e8b:b0:63f:ba88:e905 with SMTP id
 956f58d0204a3-64901ac0525mr2712183d50.30.1768413057802; Wed, 14 Jan 2026
 09:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112234839.13732-2-nvraxn@gmail.com>
In-Reply-To: <20260112234839.13732-2-nvraxn@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 14 Jan 2026 18:50:49 +0100
X-Gm-Features: AZwV_QhijXq6r9M_FPgMXccoi7NAMLb0X_KcwderHs39b-yWXc9RrTxf0MGrX1w
Message-ID: <CAJ2a_De_jo2NhUsszBjjaVygq8qY_VBjytTqZWzcp03RirR1FQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: policydb_read(): use a static string for policydb_str
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 00:49, Rahul Sandhu <nvraxn@gmail.com> wrote:
>
> We know the maximum possible size of policydb_str at compile time; it's
> POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
> As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
> avoiding an extra allocation.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsepol/src/policydb.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 6aaa18f2..2b0e32f7 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -4192,7 +4192,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>         unsigned int i, j, r_policyvers;
>         uint32_t buf[5], nprim;
>         size_t len, nel;
> -       char *policydb_str;
> +       static char policydb_str[POLICYDB_STRING_MAX_LENGTH + 1];

Using a static buffer will make this function non-thread-safe.

>         const struct policydb_compat_info *info;
>         unsigned int policy_type, bufindex;
>         ebitmap_node_t *tnode;
> @@ -4222,16 +4222,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>                 return POLICYDB_ERROR;
>         }
>
> -       policydb_str = malloc(len + 1);
> -       if (!policydb_str) {
> -               ERR(fp->handle, "unable to allocate memory for policydb "
> -                   "string of length %zu", len);
> -               return POLICYDB_ERROR;
> -       }
>         rc = next_entry(policydb_str, fp, len);
>         if (rc < 0) {
>                 ERR(fp->handle, "truncated policydb string identifier");
> -               free(policydb_str);
>                 return POLICYDB_ERROR;
>         }
>         policydb_str[len] = 0;
> @@ -4248,22 +4241,16 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>                 if (i == POLICYDB_TARGET_SZ) {
>                         ERR(fp->handle, "cannot find a valid target for policy "
>                                 "string %s", policydb_str);
> -                       free(policydb_str);
>                         return POLICYDB_ERROR;
>                 }
>         } else {
>                 if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
>                         ERR(fp->handle, "invalid string identifier %s",
>                                 policydb_str);
> -                       free(policydb_str);
>                         return POLICYDB_ERROR;
>                 }
>         }
>
> -       /* Done with policydb_str. */
> -       free(policydb_str);
> -       policydb_str = NULL;
> -
>         /* Read the version, config, and table sizes (and policy type if it's a module). */
>         if (policy_type == POLICY_KERN)
>                 nel = 4;
> --
> 2.52.0
>
>
