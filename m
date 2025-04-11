Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BB224226
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391727; cv=none; b=kK8Bx6awo7BBE8HMfQJ2i8ExzXdHkuBX4y0uvmHg0yscZjHsTpmw6uXhdRpD9Jp+mPrgFuFKb3NrW8LaUV4yWFpgjEuSjvha03IR3AQmThTdD+3uEGQ2EuSIgkT8gQbnHJ6Pc2u8udsEy5+fhc8bq4bQPgjSDSjxbNFJltoftKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391727; c=relaxed/simple;
	bh=/iZJiCPY6H+K/vnlEHE5xyYCw7sx04biFBqNb7Pfu68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW5/S4Fbvhpr9yo73vDkj+TuVvzz54azBb85BHEEAQF4U8rmS7gR4Klfoyf6lVXtZfeP24j61wO658fAmq3XoOzROjHSgckW3iF36WjjhLozkzkGG+PWOtp0kQSDJbDTzQD8dxcwIR2NWARoOKyBd9YigJ4ulsYzq1zUS/HgEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En2CFBHt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En2CFBHt"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c592764e54so281576185a.3
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391725; x=1744996525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4HdArXbbmevFDoPJUp4B28/caJgfXkCU3KY/NB3rHU=;
        b=En2CFBHtUoQw7YeZZVI6IJUjFQXzHK/Pl+DGTvHx3UnwXsoAMmwpN91gk7rX6mpJN5
         0VoM9UVx/Z203V5vcUcEYReeY7qhGWGLtsl5nWeGIvWWHmf6SStD2ip0Uc53SEOeCkd6
         aAzmuaNM+Gbbke97+ZXhGASIayg4rvkAAzdVT/KznRPh6ShNH2XdlbvUo97RWZ1rtUwk
         3RvidJ+3qMF9mDjuBD9uB7aLym7wdQe2QqnRJSw2DhqAtqHzKiYG/PhBSfAw+n36sb4h
         9++LogpmC8CtWBfEZDz51L85NwjVNTOJCbbOKSCSNOCiKrvKz3v9y8YrXVVh4rqQWwZj
         Cj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391725; x=1744996525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4HdArXbbmevFDoPJUp4B28/caJgfXkCU3KY/NB3rHU=;
        b=vF6lwXO5gh3lutMwaD3ogeclmBE8XYEVqecCo1AJICwFG/HK+RdePEUHRo3+cA/07Y
         1LSU4mxdg/3p/Zz87GwAxbwUcIckZIxrqEMqY4FmP2wwzn1chnk+QbtGC3Hr4CotLwX/
         ycG8WrzN7mDPButUObt4pK2pMr5DfxR2g/EtVuxAPuWI73wS4pZ0MnuMdKg1f/Xwm+Ms
         w+TN0UK5QJJYPjqDQ2SpkocPRd1xLar6VqT5p38lv+KYkvSf3nqanwjSSdtel6A+IHVt
         sDv34vpjHTmOOh6rGckF0Zi5W7uEgf/yyitzrIEnI8NlZW9A43FpCIYsed7ZoR6chNP7
         nsog==
X-Gm-Message-State: AOJu0YzFj3AkdWj4fD2udnpedHHp+rp3oBR/01T2YSRcgnKKXuzBzIDw
	4+OYvwSOXGal1whXgZKfFTtHmQe7OfguYj3L2WFExgfNeAkKNHcnXK6uIqSOxmFfz0RWaBtpgke
	I0/ZoUFnF7e9OttdTgZFDBJ9Pkb9PMdN3
X-Gm-Gg: ASbGncs8sMrtjmW+9TaQFyd1EqCwZFZR1Rz2F9uoRada9L861bTQ9VB/slWsMSpqAS6
	FqFYab3okyM8LKASePaO//76LqNWispH+sK1P2ayyQq2c1G6wx1VWesDEGcO8L+NRvxunednZzt
	qHctnbsaIhfkVxcqgpZeQ=
X-Google-Smtp-Source: AGHT+IGA/BF3ugm3e8ov3QmWwvs+kI921UPHS7/JVGsUtMniwFE/K7AZrpHvltrSvcIz5/orH7jvyBucv8u/yTGSzpw=
X-Received: by 2002:a05:620a:31a5:b0:7c7:9aed:1f36 with SMTP id
 af79cd13be357-7c7af1cab68mr563315285a.40.1744391725196; Fri, 11 Apr 2025
 10:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411010549.1688614-1-inseob@google.com>
In-Reply-To: <20250411010549.1688614-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 11 Apr 2025 13:15:14 -0400
X-Gm-Features: ATxdqUE9HjBZyOp3BjTC4SGq1LUkGaFffktwy_VnfDfgkp-IFdPy6mY2ddBKJp8
Message-ID: <CAP+JOzQ2aPJjodpMTHdtoY0N-fUCyAV8Rt5NA8tu1mNLadJUCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] libsepol: Allow booleanif to have info nodes
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:06=E2=80=AFPM Inseob Kim <inseob@google.com> wrot=
e:
>
> Allowing more info nodes helps debuggability, especially neverallow
> failure reports.
>
> Signed-off-by: Inseob Kim <inseob@google.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c      | 1 +
>  libsepol/cil/src/cil_build_ast.c   | 1 +
>  libsepol/cil/src/cil_resolve_ast.c | 1 +
>  libsepol/cil/src/cil_verify.c      | 3 +++
>  4 files changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index e84188a0..b0befda3 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2153,6 +2153,7 @@ static int __cil_cond_to_policydb_helper(struct cil=
_tree_node *node, __attribute
>
>         case CIL_CALL:
>         case CIL_TUNABLEIF:
> +       case CIL_SRC_INFO:
>                 break;
>         default:
>                 cil_tree_log(node, CIL_ERR, "Invalid statement within boo=
leanif");
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 072d2622..fc11758d 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -6164,6 +6164,7 @@ static int check_for_illegal_statement(struct cil_t=
ree_node *parse_current, stru
>                         parse_current->data !=3D CIL_KEY_AUDITALLOW &&
>                         parse_current->data !=3D CIL_KEY_TYPETRANSITION &=
&
>                         parse_current->data !=3D CIL_KEY_TYPECHANGE &&
> +                       parse_current->data !=3D CIL_KEY_SRC_INFO &&
>                         parse_current->data !=3D CIL_KEY_TYPEMEMBER &&
>                         ((args->db->policy_version < POLICYDB_VERSION_CON=
D_XPERMS) ||
>                           (parse_current->data !=3D CIL_KEY_ALLOWX &&
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index a8fa89df..392f03c7 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3849,6 +3849,7 @@ static int __cil_resolve_ast_node_helper(struct cil=
_tree_node *node, uint32_t *f
>                         node->flavor !=3D CIL_AVRULE &&
>                         node->flavor !=3D CIL_TYPE_RULE &&
>                         node->flavor !=3D CIL_NAMETYPETRANSITION &&
> +                       node->flavor !=3D CIL_SRC_INFO &&
>                         ((args->db->policy_version < POLICYDB_VERSION_CON=
D_XPERMS) ||
>                          (node->flavor !=3D CIL_AVRULEX))) {
>                         rc =3D SEPOL_ERR;
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index 550b4542..cde9dd41 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1176,6 +1176,9 @@ static int __cil_verify_booleanif_helper(struct cil=
_tree_node *node, __attribute
>                    booleanif statements if they don't have "*" as the fil=
e. We
>                    can't check that here. Or at least we won't right now.=
 */
>                 break;
> +       case CIL_SRC_INFO:
> +               //Fall through
> +               break;
>         default: {
>                 const char * flavor =3D cil_node_to_string(node);
>                 if (bif->preserved_tunable) {
> --
> 2.49.0.604.gff1f9ca942-goog
>
>
