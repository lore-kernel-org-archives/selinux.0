Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4963FF1;
	Tue, 25 Mar 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946258; cv=none; b=QoYzJ4qd0nK0kBIwfr98mBoCE+6lls6GI6kdEg8AUDsNcda2l58h6Bv6mRs+cUNO6gBOcWbU1tLjyDBkvG9mb6SD2chIQ5dIU/cwGZ4P76iydtNrp9TJdf70nICdPglmYy0h3EolSoH2rBnoT2txNfURTL024r8W5CnYZghd694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946258; c=relaxed/simple;
	bh=DdOHMzm56gcuGKAmKb5JIofqDdUM+vnewO5dm/udm9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoKnjD49N1Q16uUwcIisOpEH9e7KmOkYFqLW33/wyljE//35Y4nHEMPKgBP/wCv4NV5svpYo5qP+JtJCq343z/Gj5e2yOV/QtO5rs1i1Dm0GJcfiEm7H5aZ1KZKB+O3nUmszI362ZfymY12ZDCD81AmHnqNw71HWblCEiki1/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA0hemOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA0hemOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBCAC4CEF1;
	Tue, 25 Mar 2025 23:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742946257;
	bh=DdOHMzm56gcuGKAmKb5JIofqDdUM+vnewO5dm/udm9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tA0hemOrdR4EHq/wmJKxTi9PvrWLj7OS9lwO3411notuo7j8i55riYm5izgYHa7pi
	 tD+XhQ7v8gYGDdZ8y89BfruUTugGxbis8Pjq4vwFWyCm39+axWCZBRiDc4h7MV9vrB
	 v4RnK2ryA2+GW96GY+elaFV6V0PWDR/h4MqD30wE1vSRl2qZWWC5bkpRbBXG0QVuY/
	 ryH0HSIp68U6do/io8FDaUQn9tbh3+jv+B7G0HyRyr4IX7wJUAnkdK9yp0zBJz6sZ3
	 OWDp/uJU/70amxxe0rHbRBloNbTbIpFKd4Xk7KFBYDReZqWm4LlwBc85Bh8RtwsHWH
	 t/p2YMN2NmQQg==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e637edaa652so4561108276.1;
        Tue, 25 Mar 2025 16:44:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEIhnyoSAgC4x7eskO7ipNN4I5BbIpW2QHwyRs+D99eA3zYyTAoutknHJ/2Xqh0KanNy6yWiX9BopilU6G@vger.kernel.org, AJvYcCVRzStbKq37rGP9MFy75n/V7wyr5+RGnn7YAdN1bsUifmz9C4xRUoBGmLlUN3u4JpLAaJdbsgpbsg==@vger.kernel.org, AJvYcCWBrdHsJSShFlnPfYl/mx7Qo+nyu653CTuySELLvpfKQmXIqrY7qxiTQxYFfvCZU5Eka/LA8w==@vger.kernel.org, AJvYcCX9jrugQxPolBq2VffrMMjmlH8hoS170d+Ppf0eXRfwUukPWFPgjJb8916C38O9tCO/89hvm0PA91BK95r821wPiftt55UJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxmW+wmFMSzuYevMtKL/N/pJBFrMnlmI4rMnd5wV3W5FsVF+ES1
	RE/deUQNFkUyymYBhsj0JhaDYoI9Cz8Bb8T8QtEnzIXq8EtP5tlm/4Vkr+eiQPHyuN+5av/2js9
	sSVGwTw1M9Y3KZDJNtiJXBP5/buo=
X-Google-Smtp-Source: AGHT+IHUlpVF3JR11gc21lnog8AOzPHYMgz5YtFUABsOXE6btf7B2zjPo2qbm81fmLGJeWZoQwjmUQMiute8+8C5EFg=
X-Received: by 2002:a05:6902:2009:b0:e5b:42c7:8f28 with SMTP id
 3f1490d57ef6-e66a4fa4e51mr21905462276.35.1742946256704; Tue, 25 Mar 2025
 16:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319222744.17576-1-casey@schaufler-ca.com> <20250319222744.17576-3-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-3-casey@schaufler-ca.com>
From: Fan Wu <wufan@kernel.org>
Date: Tue, 25 Mar 2025 16:44:05 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGGbB8yeWo3V4y2cMfcB=GyxLHtcH4HkGJQ7KZ_jz=XeA@mail.gmail.com>
X-Gm-Features: AQ5f1JqMXrStTuJmRwKPaKn3N5g2o0K2YkB5bm9rJygAaGBj_Y-nYY3Q4HZDTxM
Message-ID: <CAKtyLkGGbB8yeWo3V4y2cMfcB=GyxLHtcH4HkGJQ7KZ_jz=XeA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LSM: security_lsmblob_to_secctx module selection
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, eparis@redhat.com, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:50=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
...
> diff --git a/security/security.c b/security/security.c
> index 143561ebc3e8..55f9c7ad3f89 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4312,6 +4312,7 @@ EXPORT_SYMBOL(security_ismaclabel);
>   * security_secid_to_secctx() - Convert a secid to a secctx
>   * @secid: secid
>   * @cp: the LSM context
> + * @lsmid: which security module to report
>   *
>   * Convert secid to security context.  If @cp is NULL the length of the
>   * result will be returned, but no data will be returned.  This
> @@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>   *
>   * Return: Return length of data on success, error on failure.
>   */
> -int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context=
 *cp)
> +int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context=
 *cp,
> +                              int lsmid)
>  {
> -       return call_int_hook(lsmprop_to_secctx, prop, cp);
> +       struct lsm_static_call *scall;
> +
> +       lsm_for_each_hook(scall, lsmprop_to_secctx) {
> +               if (lsmid !=3D 0 && lsmid !=3D scall->hl->lsmid->id)

It took me some time to figure out why if LSM_ID_UNDEF is passed the
first LSM providing a hook is used, might be better to change it to:

               if (lsmid !=3D LSM_ID_UNDEF && lsmid !=3D scall->hl->lsmid->=
id)

Otherwise, it works as described. I'm working on adding a new IPE
property based on SELinux file labels, and this just came up as I
needed it. Thank you.

Tested-by: Fan Wu <wufan@kernel.org>

> +                       continue;
> +               return scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +       }
> +       return LSM_RET_DEFAULT(lsmprop_to_secctx);
>  }
>  EXPORT_SYMBOL(security_lsmprop_to_secctx);
>
> --
> 2.47.0
>
>
