Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FF36F426
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218559; cv=pass; b=gKyvCb/H/5EFt0XflY2WKFRfdeaE2fxemhOEUM1szxPKqeWoRiWbR5YTrfV1Q5iS9qpF2T+DMC68+cs4kfWgLNriU4VJrBJePSpLwbUi049TTct2KB/pXSYlRos3LTA9d5+5+URS4AWVt73q/9tMZfr5Ye9lcty5yahRB0krUss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218559; c=relaxed/simple;
	bh=NU1RqoG+x5X9e1XQZt2qrThFApxGLgIDF8yUhJfgCTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6su/Yutz8zAKepYqP0/6k85TPIvsa5sszKL7JlbcBKrSSg34xbA6SdCoiAk8Rby35PCc3DdvZHHZTIQDgOoJGkL+NvMUtdFoYCvkrZWH69+paq8ae+PWsHZ2qx2/AMYiyF+FFUEVIzKeLMnPoY2/zzwoOQh8jrCEalmnaeMkJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFM/ISCA; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFM/ISCA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so2114565a91.1
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218557; cv=none;
        d=google.com; s=arc-20240605;
        b=HIXCxCDjrs/RksnkDkxgqrVo0BgdIxFSLe91Og9UXhQOKc+fGeqR7LxufjlTo1ChIa
         AotZsB9DoE+6yVrvrHvnSDjNPXwH7ZKkkIXVBnby12MOARs+NDBC7r5SwCj4tWHUDMLm
         StAKKtYJvlrzY1Wn0ClTD+ftD67Ga4IN4IB/ajvOiIs9SJjSfoKZZxGO+35I87PloVHP
         u4oDF+otjHpmGjL3GTW2/tAvR87jt+V3xWo4oPeW/8fBjT4ROg6zrsVpXumIM5QkQc+7
         jegCLZJzJmOi0iOuQGp5h9Un7/6D2Dlw+reBiaIW3DjsFpcB5Kv6XOcE2zsupOUZY0VI
         Y4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9CIY1SjPHr4DBQ2E+xpfefa9fQbRSJ2IkFc2cKzkeg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Angi3u7izNg0Qre2YpSL6XNyrw1anJRqkg1w0JyxUb5JZXbrLiAOaXPBS/S4ajtWvD
         bTae0ZXtv0NIBW6ZA2wWsQtTlq1YtOwvf+qwXxgV4etunQZnR21xFRmxNeICZSs2ltDD
         A1ZSgTdWNDWe/53reaEH31H3CwpRzYjGJrgEmaoislvZQILjZ3R3cMRBLpza5t9IC2La
         r52eY6KkbMAUBTxViY+R4JGZ9l517dRpFUNCymhjrTu7wkgRLX5H/gU+SorVUaJE9IYS
         PktxWjcbdaHuRHO6GxUKuXuJdwDG+nTfb1Hrne474adyvmdb8BmpkV/3lYPAoir3ffU0
         9BHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218557; x=1779823357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9CIY1SjPHr4DBQ2E+xpfefa9fQbRSJ2IkFc2cKzkeg=;
        b=JFM/ISCAHS/M2d2k0/zQYH8iKtNcqMVdKCrk6iIScv0QMBFgx4ctKet8JgwlABwEas
         EoDZPEuBkJ2J0nDBgDqjaIl9XTrCHOS+EFskG7FsI/nkjSSqilEkvdkccWcsolmkUdmq
         7oJFUOFgjBOjw+5TAi93vS1FuGCMMCaWVYXEzni8wQSHJgBzZUB3GHDIT3ACgV2NTDk6
         CqWzUzsB4/wVzkVaxS878E1qQUE8KrhC75DHvw7wxEtyQnDw4vbF/IF31UOSJ83FzuEu
         3ryHCBDmw5rSSeLqh77ONmFqVnec5yVaCE/PAg2zlfE2OHRcM5t5ruHbXm9cfgMRCXzS
         uyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218557; x=1779823357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9CIY1SjPHr4DBQ2E+xpfefa9fQbRSJ2IkFc2cKzkeg=;
        b=PzG+N3GL3RtjekLqEK4xjvEeTDr+7zj2Djyq0OhpdnN4pAArFBGLYy6tgHNJncQJpd
         6pkyeEx3t87brt37SaRK4dQJbNeFnKmAY/vseT7FiZFTU811uG/G1+0i4QNZxtduowA6
         EQvplojZDn/MmwKU9g33eC5IUsEvZ03DPM3LAb17MlCMHA+3DR8T6MtUeiEy7OMiuQVw
         Z+gsX0E/+RF/zNH1MmlHczpyFemsnQJXIKgloYSkrspCXWJpCTCkWos1FTZrQi3J6aW9
         41OY6KQPOucRhjgmJ/ZEVdkp1xeLiyp3E6bXzfe4Xi4ENLQ8WA17LvxzzADivE2PK4AM
         1AAA==
X-Gm-Message-State: AOJu0Ywaibdwg4xd2SWPtsa7BwKMvheEkUW9ES/UBbE7G9G9MqCAe+pC
	vmKGBSpOPruy9XoxJBpqXlbwO5DFvMMySDzEAfwFk92b5qtp8HAZPtjV7fhktjgwnORUIHrd3gl
	Ztj05oc6JXXC21NfJ29BR7vGP+sc/wgwudQ==
X-Gm-Gg: Acq92OFWMAL50Ux2KtOeB617QVpRAstyZSxZZFiCQDtbtoKrC6kjDuPpEmbRGm33L/i
	5Ylo71ddcXaEPs8GqbhPig+cqKxrbnpLhxjNnKa2Sklhbe0g26ns7ORinK1cmes1ICTuqv1GPS2
	reA6tvOQAZsIXsS3Mj6zQ+UovdgAb58TF2xdoVXAZLbj+NOM3BELTyjXDWtDXStpcsqgaK5Ykfm
	3rhwDcQcEA7BkJdHL/0A0EGoP/NaeYkyn40rgYVQ7ff3vCeXZbqcMt9VG/yZzgkNWcTOMLbzg8f
	kBBnFVM=
X-Received: by 2002:a17:90b:5848:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-36951a66993mr20440354a91.16.1779218557382; Tue, 19 May 2026
 12:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519161440.420035-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260519161440.420035-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 19 May 2026 15:22:26 -0400
X-Gm-Features: AVHnY4L-3kpan9K8vmoz-sK-d9-aPCOjdJqOJi1BWh4RiNNy77cvQHq9utC1jGE
Message-ID: <CAEjxPJ4nUFNd90pxw9jxD8yCNKQ-uG2AwPWHgq=V4akcTtiDKA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid heap allocation in partial_match() leak path
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:16=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> partial_match() hands a stack lookup_result to lookup_common() and
> discards the return value with a `!!`.  For the non-partial paths
> that always works -- lookup_check_node() either fills the caller's
> buffer or returns NULL -- but in partial mode, when the key matches
> a child stem prefix, lookup_all() falls into its children loop and
> calls all_node_specs(), which unconditionally malloc()s the
> returned lookup_result.  With partial_match() ignoring the pointer
> and find_all=3Dfalse ensuring at most one entry comes back, that
> single malloc'd entry leaks every time.
>
> Fixes: 33930961 ("libselinux: correctly find partial matches")
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/label_file.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 31f134f9..bb866075 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1604,15 +1604,20 @@ FUZZ_EXTERN void free_lookup_result(struct lookup=
_result *result)
>   * @node:      The top level node to return all definitions for.
>   * @file_kind: The kind of the file to look up (translated from file typ=
e into LABEL_FILE_KIND_*).
>   * @find_all:  Whether return all file context definitions or just any.
> + * @buf:       A pre-allocated buffer for a potential result to avoid al=
locating it on the heap or
> + *             NULL. Mutual exclusive with @find_all.
>   *
>   * Return: A linked list of all file context definitions if a match was =
found.
>   *         NULL is returned in case of no match found, or an allocation =
failure.
>   */
> -static struct lookup_result *all_node_specs(struct spec_node *node, uint=
8_t file_kind, bool find_all)
> +static struct lookup_result *all_node_specs(struct spec_node *node, uint=
8_t file_kind, bool find_all,
> +                                           struct lookup_result *buf)
>  {
>         struct lookup_result *result =3D NULL;
>         struct lookup_result **next =3D &result;
>
> +       assert(!(find_all && buf !=3D NULL));
> +
>         for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
>                 struct literal_spec *lspec =3D &node->literal_specs[i];
>                 struct lookup_result *r;
> @@ -1623,9 +1628,13 @@ static struct lookup_result *all_node_specs(struct=
 spec_node *node, uint8_t file
>                 if (strcmp(lspec->lr.ctx_raw, "<<none>>") =3D=3D 0)
>                         continue;
>
> -               r =3D malloc(sizeof(*r));
> -               if (!r)
> -                       goto fail;
> +               if (likely(!find_all && buf)) {
> +                       r =3D buf;
> +               } else {
> +                       r =3D malloc(sizeof(*r));
> +                       if (!r)
> +                               goto fail;
> +               }
>
>                 *r =3D (struct lookup_result) {
>                         .regex_str =3D lspec->regex_str,
> @@ -1653,9 +1662,13 @@ static struct lookup_result *all_node_specs(struct=
 spec_node *node, uint8_t file
>                 if (strcmp(rspec->lr.ctx_raw, "<<none>>") =3D=3D 0)
>                         continue;
>
> -               r =3D malloc(sizeof(*r));
> -               if (!r)
> -                       goto fail;
> +               if (likely(!find_all && buf)) {
> +                       r =3D buf;
> +               } else {
> +                       r =3D malloc(sizeof(*r));
> +                       if (!r)
> +                               goto fail;
> +               }
>
>                 *r =3D (struct lookup_result) {
>                         .regex_str =3D rspec->regex_str,
> @@ -1677,7 +1690,7 @@ static struct lookup_result *all_node_specs(struct =
spec_node *node, uint8_t file
>                 struct spec_node *child =3D &node->children[i];
>                 struct lookup_result *r, *last;
>
> -               r =3D all_node_specs(child, file_kind, find_all);
> +               r =3D all_node_specs(child, file_kind, find_all, buf);
>                 if (!r)
>                         continue;
>
> @@ -1709,7 +1722,7 @@ fail:
>   * @partial:   Whether to partially match the given file path or complet=
ely.
>   * @find_all:  Whether to find all file context definitions or just the =
most specific.
>   * @buf:       A pre-allocated buffer for a potential result to avoid al=
locating it on the heap or
> - *             NULL. Mututal exclusive with @find_all.
> + *             NULL. Mutual exclusive with @find_all.
>   *
>   * Return: A pointer to a file context definition if a match was found. =
If @find_all was specified
>   *         its a linked list of all results. If @buf was specified it is=
 returned on a match found.
> @@ -2072,7 +2085,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct=
 selabel_handle *rec,
>                         if (strncmp(child->stem, rest_key, strlen(rest_ke=
y)) !=3D 0)
>                                 continue;
>
> -                       r =3D all_node_specs(child, file_kind, find_all);
> +                       r =3D all_node_specs(child, file_kind, find_all, =
buf);
>                         if (!r)
>                                 continue;
>
> --
> 2.53.0
>
>
