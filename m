Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555E3FBAC
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164928; cv=none; b=Ne0iUK6HwWqMayIgs4HcVvoT5hQmhwIitjsyEAK+K+kcVmLKy5uhjBmdRUB9k51Nd9OmlsaDecdyHSmyoF/QAPdt7kSOI24MH2YSYGIGlSxTQwQYs4nxnx+iHjM32ItCsRXHiiNdBNqO62Ybpn9GY4LLUp1fx2Bk1upzm26uh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164928; c=relaxed/simple;
	bh=zF2sZ8mVA+ZwHOD6no60HRuzpIyG7PFBzfXctSQgz08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpZ1maB8l4v0AUrgHxKh+6DFfZUng0TuJ08cdQqLU74DL9bkR8cFc3seBX7iZ7sUqFa84J8Q8SDANHM3gXlw+DkyMqI5cKrmFU5D4pVrVwglSW2infcuJpgKku2S5/mbbHrwy6SAPLee/+dd5j4EYtIJZPwdHb9UfdOVH2KPvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WZyDnJFy; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WZyDnJFy"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2928236276.2
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710164926; x=1710769726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UY9zn1SWCBl2RNnf1JhZuSoVtSgGddWnM12KsGbbpLQ=;
        b=WZyDnJFymdip+54bmo9/jGmqF6kHtCsLKwbWN1K3uwF5eVK7OWJ45osARKjlquMhR7
         mPCc/dFjlyPZGuIdlPj0GwdcmRUNq1Svn5iQ1AFntCkf8uTJ71UO0IAmWKh2w1zZdQp2
         ZFh2JHaOtDIzzHfVLrGUmsQgU5cApUclV4WqpJnVIcTjR908TX/pPFnYiFavEi3HzjRA
         lG5CLQhNT6zWg3w7ZCfJ0qwtRCuh1Z36e4UF9StVhE0qlIrQlQkNbSrL7hhvLobzg/xG
         t6/LDbEel1JYWAZghPeAb4+9Zo1V+L4vf+3AnCf8fFLXso285D1l+qpwJCu1rsWWg2Ft
         3uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710164926; x=1710769726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UY9zn1SWCBl2RNnf1JhZuSoVtSgGddWnM12KsGbbpLQ=;
        b=HeIMVVM7qZjzAV7n5BHPwMsRX6a8y7OHwTCdThLJouaTc876QpuPcRau4/I0VRzV4q
         nb0qWP8o94iVZ6nNWaFXAjETxdY5c5s58t2f3n7WEYz0kI6jZyFIMvSCfE2W5ZoBOSM8
         4tSU2C0MwVcGwCD3Me18LSgvm0e0SwBwSawKgR/Zk2NgSVIxzoNAue/S6vrI6KfCiNGc
         S63m9/Gpiiz/UVx27aycKarUcB3irNHRqEKrdhpBebePPP6Uk3oL+8MePWCG7yHAZ9I+
         2oRMrHAIJWkvdFiJlIHj8jLv5Ng11J9t4UpRVAPf18mpwaL6rLXd+z2R1+3oNpc2+s+F
         Ow0Q==
X-Gm-Message-State: AOJu0YzDH99500CdrdHfGchWbq3kOQcBSXcXNmykyJ6TL+sbDVhSFKIZ
	aEERYxUcez5qQxnvN+EbfNt79Gki1Q5BgbuRFw2BQLv2s5WjQbhiLJI05qHhGCOncJePyFvfk9L
	KGoBal0xEiUP9PWILw0swzj2+a/I=
X-Google-Smtp-Source: AGHT+IH9mJbubBUp59jAQlssVegE7x6uyeR+TdxfekCrEmuAqhs0at4k0AcPU0Gi+CW5CLuNHlid6Q0/5V9+NPUX4u0=
X-Received: by 2002:a5b:c8a:0:b0:dc7:43fe:e124 with SMTP id
 i10-20020a5b0c8a000000b00dc743fee124mr3614207ybq.11.1710164925695; Mon, 11
 Mar 2024 06:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311124832.2659731-1-jwcart2@gmail.com>
In-Reply-To: <20240311124832.2659731-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 11 Mar 2024 14:48:34 +0100
Message-ID: <CAJ2a_Df=V+sMzA9K1Qu-1PVYnrthq=kQMgtMZL3txO-a+jytsg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix buffer overflow when using sepol_av_to_string()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 13:48, James Carter <jwcart2@gmail.com> wrote:
>
> The function sepol_av_to_string() returns a list of permissions
> with a space at the beginning. This fits the normal formating of
> permisisons for a policy.conf policy which uses a format of
> "{ p1 p2 ... pn }", but not the formating for a CIL policy which uses
> a format of "(p1 p2 ... pn)". Both kernel_to_cil and module_to_cil
> skip the space by using "perms+1", but this is a problem if there
> are no permissions because sepol_av_to_string() returns '\0'.
>
> In kernel_to_cil and module_to_cil, check for the permission string
> being '\0' and return an error if it is.
>
> Reported-by: oss-fuzz (issue 67276)
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/kernel_to_cil.c | 11 +++++++++++
>  libsepol/src/module_to_cil.c | 12 ++++++++++++

I think there are also two occurrences in libsepol/src/kernel_to_conf.c.

Also: s/permisisons/permissions/

>  2 files changed, 23 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index a081915e..e20ba4af 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -302,6 +302,12 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
>                         rc = -1;
>                         goto exit;
>                 }
> +               if (*perms == '\0') {
> +                       ERR(NULL, "No permisisons in permission string");
> +                       free(perms);
> +                       rc = -1;
> +                       goto exit;
> +               }
>
>                 if (is_mls) {
>                         key_word = "mlsconstrain";
> @@ -1775,6 +1781,11 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
>                         ERR(NULL, "Failed to generate permission string");
>                         goto exit;
>                 }
> +               if (*perms == '\0') {
> +                       ERR(NULL, "No permisisons in permission string");
> +                       free(perms);
> +                       goto exit;
> +               }
>                 rule = create_str("(%s %s %s (%s (%s)))",
>                                   flavor, src, tgt, class, perms+1);
>                 free(perms);
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 6699a46b..3b3480bf 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -593,6 +593,12 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
>                                 rc = -1;
>                                 goto exit;
>                         }
> +                       if (*perms == '\0') {
> +                               ERR(NULL, "No permissions in permission string");
> +                               free(perms);
> +                               rc = -1;
> +                               goto exit;
> +                       }
>                         cil_println(indent, "(%s %s %s (%s (%s)))",
>                                         rule, src, tgt,
>                                         pdb->p_class_val_to_name[classperm->tclass - 1],
> @@ -1973,6 +1979,12 @@ static int constraints_to_cil(int indent, struct policydb *pdb, char *classkey,
>                                 rc = -1;
>                                 goto exit;
>                         }
> +                       if (*perms == '\0') {
> +                               ERR(NULL, "No permissions in permission string");
> +                               free(perms);
> +                               rc = -1;
> +                               goto exit;
> +                       }
>                         cil_println(indent, "(%sconstrain (%s (%s)) %s)", mls, classkey, perms + 1, expr);
>                         free(perms);
>                 } else {
> --
> 2.44.0
>
>
