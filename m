Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwM0PQCl"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF6BA1
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:49:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so5213967e87.2
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702309792; x=1702914592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CfyzvyacA3+NZG69a6qxLHVfxU9uXRLRHL3MO/VZwk=;
        b=IwM0PQClz73pvFM/exV8N7hnB+naz7TsqifSwonkpP+rz0bRWDEC4O3RvHtmYCfRRe
         ofBi78SFq2nWiZubg+FPFvmlUbywnnIr7rWWpObeWET5uAOUrKf1qtXbtFsddIv2ATbx
         BBf+Iqr3knsgWZg0dJanCysaWV21EecYqo3QiHNMiMvqNjNK0izHt281IstWD0tx3VRU
         LuXSXVGYxJScoJZKQ9n1atwjJBe82Fe8vI3u+MCwiXDqhDq4gvz9QZj3INNRhEiiuzNE
         hSX/QtadmNRFiBX+BCG2jx0hI/kh9EnPGevjfmOhBe8HdK0TfYXxCO/IuDu0pUHT7Tdm
         V2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309792; x=1702914592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CfyzvyacA3+NZG69a6qxLHVfxU9uXRLRHL3MO/VZwk=;
        b=Bt8MwG7dCxPmmmr/EfKSReZR6ZzuoyGRfRgaxacLfBVP95A6EuRbqZoptDBMVNjIeV
         RHQuQOflUXXaDSp4pc4UjhIWCCOPMvmsZdP70iPGOsyVW8bBpcn52sC4ci2xChboWSO9
         P5T3kRA0N8GeZCovXOOrbcDo1HDeykH61JbnwEOxfYf023jEJS5YLWTMDTSwoJrlWQIR
         9hjzWhsvxC1PwX9rzbcbV8oI9RQDJOiAZDc9dn/iD/2Rl2ifL79lItCeEG6wp/7Va5YK
         jzT+km2yopPeU/wcZkraSbTny5eYwIX6fhSB+LXedD3NYdsAdYpDAlyccw5yJcz3Roav
         KHHg==
X-Gm-Message-State: AOJu0YwDP4DFxXo7ucsuWD8JFebD/vvNE+kKhZyjDEKPKDepbFrZ5lzZ
	gYI1PdMxVoqiGpC0Gdpt9QYj7b5f8Lzh8n9pR40=
X-Google-Smtp-Source: AGHT+IGh6m12pXm/9xNTYeWehiq9Aw7lZ3IiUnX8j93rrgWiRPFTyfWlQqh4l3OspC2a7vRCdv8ce+Xf2HU9XtZW4TI=
X-Received: by 2002:a05:6512:3493:b0:50b:f233:ccad with SMTP id
 v19-20020a056512349300b0050bf233ccadmr1921322lfr.5.1702309792134; Mon, 11 Dec
 2023 07:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211144827.121636-1-cgzones@googlemail.com>
In-Reply-To: <20231211144827.121636-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 11 Dec 2023 10:49:40 -0500
Message-ID: <CAP+JOzRcTCL2yqk6PTJrvvc+116+o763voETrrcqDkNvO2KQ7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: constify tokenized input
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 9:48=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The input string to be tokenized is not modified.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/util.h | 2 +-
>  libsepol/src/util.c                    | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/se=
pol/policydb/util.h
> index db8da213..4ea5a346 100644
> --- a/libsepol/include/sepol/policydb/util.h
> +++ b/libsepol/include/sepol/policydb/util.h
> @@ -40,7 +40,7 @@ char *sepol_extended_perms_to_string(avtab_extended_per=
ms_t *xperms);
>   * The tokenize function may be used to
>   * replace sscanf
>   */
> -extern int tokenize(char *line_buf, char delim, int num_args, ...);
> +extern int tokenize(const char *line_buf, char delim, int num_args, ...)=
;
>
>  #ifdef __cplusplus
>  }
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index 2f877920..571f6c93 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -221,9 +221,9 @@ err:
>   */
>
>  /* Read a token from a buffer */
> -static inline int tokenize_str(char delim, char **str, char **ptr, size_=
t *len)
> +static inline int tokenize_str(char delim, char **str, const char **ptr,=
 size_t *len)
>  {
> -       char *tmp_buf =3D *ptr;
> +       const char *tmp_buf =3D *ptr;
>         *str =3D NULL;
>
>         while (**ptr !=3D '\0') {
> @@ -273,9 +273,10 @@ static inline int tokenize_str(char delim, char **st=
r, char **ptr, size_t *len)
>   * contain the remaining content of line_buf. If the delimiter is any wh=
itespace
>   * character, then all whitespace will be squashed.
>   */
> -int tokenize(char *line_buf, char delim, int num_args, ...)
> +int tokenize(const char *line_buf, char delim, int num_args, ...)
>  {
> -       char **arg, *buf_p;
> +       char **arg;
> +       const char *buf_p;
>         int rc, items;
>         size_t arg_len =3D 0;
>         va_list ap;
> --
> 2.43.0
>
>
