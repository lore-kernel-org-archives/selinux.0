Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CE2E7376
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617832; cv=pass; b=PaJ4IQe/cbGBkVhWj07BzOOEoTTntARtopdWY8p6HX9dxws0LG5xZAM32f199eijX5ezy8cZOADtMTvaME6EsifdIcsJny+VkjCvrnYgaK7mJNLW3WSCbVTurgRBErxssW5jJbQ7SaDuhRCi8dXxJEFAMnKSHUFVGaWb4MyyX40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617832; c=relaxed/simple;
	bh=j0ix+pbk4WhCW7JNYTUMK8vD8mDxifBn891Nxw5NRqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dx2yy4IbJeFpHJsgD6rhawL39zOgNB8DS9C/4MRyAq+jUwkiBlXeVFdqVy1HGCV5NYP6d6KhbU++zFvaVOYCm7REWWH/ALGa6au92G6NvA0FLT0JamMaEta8HYELvtJeeEwLPKqC35QIoAOoHhaXw8++hyCnpoigGnwTXE0WrDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM/Pbbr5; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM/Pbbr5"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39677c434efso42710121fa.3
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 06:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781617829; cv=none;
        d=google.com; s=arc-20240605;
        b=Pdqc01eaO4ab8XlrtSk1nCWaDinBQ0vZslT3xdBvOqF6kPLs21SdXHBqEOLHFpexAQ
         Nec17LeaTk2zdgM+ZlAdOeFpvukWB349EwyBLi/JzQ1n/4nS2A9qNmbwR2yfN7pfYmBq
         yDTbXe7FMPbW3X69KziU1prizDq68n94E+F6+zD+9WUkBLM83SM2tS3KJIZ/Kuf3HDnP
         OniGYY5QoVCncXYP3tURFVSFGFyKzkwRoVr2soKdKfNJUF2KIGSAFrFtZZHdL7R1Zi7i
         GSXk4JQbRpYC4Itrv4sYhdc/cyu1f9SM2oY7AOJwnA934MKSM09YA1ZYH8JaL49dThXh
         BmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4niRuvP8ZAwsk1GNFrwVmlXSIiX7OUFdRZyLT2tcl4=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=MeIUHrwhSNQRq5cVNL+IAaoLx2eqWh6kONfHmUaNXzsz/YnpRL1gcnLXJ/1+0soEQ1
         Krdk+Pz+iVOoZ+36N6sluzOgtEYLknoRzdnwUCz1ODGNsPTPcFGwTebP5rzzLfaFw0Ed
         g409xiWL2w8hRx7xm72cysKTZnqrFGY89WCIC1Fz8Aua4nxOGSkCwUEzJ8ztYTAtqHzE
         iPI2/QH5A8HCeKs2jlM/RbBVLXjQeOLI9BKofzj8bMEYE243AQT62pfFFm0Udzr9a7jI
         t+sFTfqtXykLm5+xCfv0woorKVarpbOe5qU2Lwos4trG91JbuTWSdoOEanKlzVa/3iTB
         jU1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781617829; x=1782222629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4niRuvP8ZAwsk1GNFrwVmlXSIiX7OUFdRZyLT2tcl4=;
        b=EM/Pbbr5a+o35nGP5HDeA7b5iVWUXJ6o34jXrpctYSwBY12DC/9hwlw/yRta++NqaE
         fPv/KYOyOGOBd8frudmR2T086SQJA9VrljxITCJFjwVwlRAkn8ERvDeprIj0WtbwKpwL
         4gESdvrZQAZaq/8/m4CZtlkX+29K6iJRbH2pjm5Dpl4kq8V++cwQ6j2pWag33jjM2+3L
         mHrrX3eyge4BLvE9mF+aXtpmb7FdziFuWH4LfcRNFJ71x2UXBhsDoDeQDjhJ3so1obUB
         /W/dU+OwKkbFOWlvnH5qEouGtG5sZlAybejpzIcT2cp0G3quG2Bx3uFp14UOl5LJOVKn
         b13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617829; x=1782222629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4niRuvP8ZAwsk1GNFrwVmlXSIiX7OUFdRZyLT2tcl4=;
        b=Kz60JPPnxpS9YwIStCfAwlx2Bn/NTxVrNXU1B4cfzEprdwO4fvtRzrk/E+1MW6zAx0
         x9J1l1S+h7sFJE59taKJnEM6xWHYqCcxKZw/ZxYXDv/kEnC3auIn4vEag14vY2QRz0Go
         GeKVgQ8+D2WUCYtDmpx4Bc1MwavWlRZd3f0Cg32EXZ/ogz7N+51B+A31pXnNvY/U1bcU
         +MkDk3kIYKohJ72VwVMzzywk5fzoa8pzi87vVEJZ/TmFpf8Nq2kTSqxmOB2n0FCJE0Lj
         PcKUcJiMD9DKlpjtaNfpgqDnUeLCWmKdPgkQEA7N5/KLjZi20ZyuKrdkMMwNWJDnUAYS
         QTbw==
X-Gm-Message-State: AOJu0Yx2tlT/lg8sf/z1xZtoO6Oaj/tavwwGj5vaMSTgD76DaEGHqQiO
	VR0SHAaArzSRcnW3lenwJyKY81CcLsHKgu+wgsficxIvl+eTvuBs7OVnedgziaB/m8G5v+tW5aE
	oyH3jiPjtvjM+nD33tqdiDNfKnlRxooY=
X-Gm-Gg: Acq92OGhZXwk8Yx+XdTnCRKYpLgvZPvduBsnaiWk3GYj+EwBPCcme4MIILIIaEdTkTf
	mrCJm/sIRyGIy9WqYaGPLyAk80c5i38VDGFKnwgk09BbFyEyvoYW8sYydj0DfONX+6bynYRhUTj
	QwZU3e+wIqAYKbjgybc9ES8RC5c343IV3zPMHMJ1JIvEfQSVo9yQb4KhqyOK3UDNdhk5lM6C+OD
	d9224Fk/NGfkmU3lpodYUorBIPLuD4QOsQR6VkF9E98r131l4q420DwVNpT3/kDDxYqruSIN0T+
	vx68
X-Received: by 2002:a2e:a107:0:b0:396:5999:1f42 with SMTP id
 38308e7fff4ca-3992b2a7f39mr50928511fa.20.1781617828414; Tue, 16 Jun 2026
 06:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615122840.42032-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260615122840.42032-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Jun 2026 09:50:15 -0400
X-Gm-Features: AVVi8CcFuofFALehWPm6vkEb3dEwlw9UAXNs0wGFeWDYnO_DFx_9Ooer5l2QS4A
Message-ID: <CAP+JOzRhFeA=EUt4nu=Y60w=xusmB59EyZAabGqfoibR7-vc0w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cast to unsigned char in ctype calls
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 8:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> Passing a plain char to the <ctype.h> functions is undefined when the
> value is negative (C11 7.4p1). On platforms where char is signed, a byte
> >=3D 0x80 from a module name, seusers/file_contexts entry, CIL identifier
> or IP token sign-extends to a negative int. Cast to unsigned char before
> each isspace/isalnum/isalpha/isdigit call, as libselinux already does.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/525
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c |  7 ++++---
>  libsepol/cil/src/cil_verify.c    | 11 ++++++-----
>  libsepol/cil/src/cil_write_ast.c |  2 +-
>  libsepol/src/module_to_cil.c     | 10 +++++-----
>  libsepol/src/util.c              |  8 +++++---
>  5 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 2b0921f0..3a6b1631 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -4507,7 +4507,7 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_t=
ree_node *parse_current,
>         } else {
>                 char *addr =3D parse_current->next->data;
>                 if (strchr(addr, ':') ||
> -                   (strchr(addr, '.') && isdigit(addr[0]))) {
> +                   (strchr(addr, '.') && isdigit((unsigned char)addr[0])=
)) {
>                         cil_ipaddr_init(&nodecon->addr);
>                         rc =3D cil_fill_ipaddr(parse_current->next,
>                                              nodecon->addr);
> @@ -4529,7 +4529,7 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_t=
ree_node *parse_current,
>         } else {
>                 char *mask =3D parse_current->next->next->data;
>                 if (strchr(mask, ':') ||
> -                   (strchr(mask, '.') && isdigit(mask[0]))) {
> +                   (strchr(mask, '.') && isdigit((unsigned char)mask[0])=
)) {
>                         cil_ipaddr_init(&nodecon->mask);
>                         rc =3D cil_fill_ipaddr(parse_current->next->next,
>                                              nodecon->mask);
> @@ -5749,7 +5749,8 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node=
, struct cil_ipaddr *addr)
>         addr_str =3D addr_node->data;
>         if (strchr(addr_str, ':')) {
>                 addr->family =3D AF_INET6;
> -       } else if (strchr(addr_str, '.') && isdigit(addr_str[0])) {
> +       } else if (strchr(addr_str, '.') &&
> +                  isdigit((unsigned char)addr_str[0])) {
>                 addr->family =3D AF_INET;
>         } else {
>                 goto exit;
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index 67b98b09..eb732e44 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -115,7 +115,7 @@ int cil_verify_name(const struct cil_db *db, const ch=
ar *name,
>                 goto exit;
>         }
>
> -       if (!isalpha(name[0])) {
> +       if (!isalpha((unsigned char)name[0])) {
>                 cil_log(CIL_ERR, "First character in %s is not a letter\n=
",
>                         name);
>                 goto exit;
> @@ -123,8 +123,8 @@ int cil_verify_name(const struct cil_db *db, const ch=
ar *name,
>
>         if (db->qualified_names =3D=3D CIL_FALSE) {
>                 for (i =3D 1; i < len; i++) {
> -                       if (!isalnum(name[i]) && name[i] !=3D '_' &&
> -                           name[i] !=3D '-') {
> +                       if (!isalnum((unsigned char)name[i]) &&
> +                           name[i] !=3D '_' && name[i] !=3D '-') {
>                                 cil_log(CIL_ERR,
>                                         "Invalid character \"%c\" in %s\n=
",
>                                         name[i], name);
> @@ -133,8 +133,9 @@ int cil_verify_name(const struct cil_db *db, const ch=
ar *name,
>                 }
>         } else {
>                 for (i =3D 1; i < len; i++) {
> -                       if (!isalnum(name[i]) && name[i] !=3D '_' &&
> -                           name[i] !=3D '-' && name[i] !=3D '.') {
> +                       if (!isalnum((unsigned char)name[i]) &&
> +                           name[i] !=3D '_' && name[i] !=3D '-' &&
> +                           name[i] !=3D '.') {
>                                 cil_log(CIL_ERR,
>                                         "Invalid character \"%c\" in %s\n=
",
>                                         name[i], name);
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index e09f558d..ca3b0ce3 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -1708,7 +1708,7 @@ static int __write_parse_ast_node_helper(struct cil=
_tree_node *node,
>                 size_t i;
>
>                 for (i =3D 0; i < len; i++) {
> -                       if (isspace(str[i])) {
> +                       if (isspace((unsigned char)str[i])) {
>                                 fprintf(args->out, "\"%s\"\n", str);
>                                 return SEPOL_OK;
>                         }
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 9e61754f..9881c9ce 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -118,7 +118,7 @@ static int get_line(char **start, char *end, char **l=
ine)
>
>         *line =3D NULL;
>
> -       for (p =3D *start; p < end && isspace(*p); p++)
> +       for (p =3D *start; p < end && isspace((unsigned char)*p); p++)
>                 ;
>
>         *start =3D p;
> @@ -3534,7 +3534,7 @@ static int seusers_to_cil(struct sepol_module_packa=
ge *mod_pkg)
>
>         while ((rc =3D get_line(&cur, end, &line)) > 0) {
>                 tmp =3D line;
> -               while (isspace(*tmp)) {
> +               while (isspace((unsigned char)*tmp)) {
>                         tmp++;
>                 }
>
> @@ -3627,7 +3627,7 @@ static int user_extra_to_cil(struct sepol_module_pa=
ckage *mod_pkg)
>
>         while ((rc =3D get_line(&cur, end, &line)) > 0) {
>                 tmp =3D line;
> -               while (isspace(*tmp)) {
> +               while (isspace((unsigned char)*tmp)) {
>                         tmp++;
>                 }
>
> @@ -3699,7 +3699,7 @@ static int file_contexts_to_cil(struct sepol_module=
_package *mod_pkg)
>
>         while ((rc =3D get_line(&cur, end, &line)) > 0) {
>                 tmp =3D line;
> -               while (isspace(*tmp)) {
> +               while (isspace((unsigned char)*tmp)) {
>                         tmp++;
>                 }
>
> @@ -4411,7 +4411,7 @@ static int fix_module_name(struct policydb *pdb)
>         // CIL is more restrictive in module names than checkmodule. Conv=
ert bad
>         // characters to underscores
>         for (letter =3D pdb->name; *letter !=3D '\0'; letter++) {
> -               if (isalnum(*letter)) {
> +               if (isalnum((unsigned char)*letter)) {
>                         continue;
>                 }
>
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index 01616577..52faeaa6 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -248,10 +248,11 @@ static inline int tokenize_str(char delim, char **s=
tr, const char **ptr,
>         *str =3D NULL;
>
>         while (**ptr !=3D '\0') {
> -               if (isspace(delim) && isspace(**ptr)) {
> +               if (isspace((unsigned char)delim) &&
> +                   isspace((unsigned char)**ptr)) {
>                         (*ptr)++;
>                         break;
> -               } else if (!isspace(delim) && **ptr =3D=3D delim) {
> +               } else if (!isspace((unsigned char)delim) && **ptr =3D=3D=
 delim) {
>                         (*ptr)++;
>                         break;
>                 }
> @@ -273,7 +274,8 @@ static inline int tokenize_str(char delim, char **str=
, const char **ptr,
>         }
>
>         /* Squash spaces if the delimiter is a whitespace character */
> -       while (**ptr !=3D '\0' && isspace(delim) && isspace(**ptr)) {
> +       while (**ptr !=3D '\0' && isspace((unsigned char)delim) &&
> +              isspace((unsigned char)**ptr)) {
>                 (*ptr)++;
>         }
>
> --
> 2.54.0
>
