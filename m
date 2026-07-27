Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB8417D7D
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159055; cv=pass; b=ivtmJAcJkd1g/65t0+vhzVsV4f11s9uUreFmkzP/W7+jE4HagqZ7p5EZ2t+ibMW6vsjK7xgDz568yCZX4D3ycEToTN245SdRmGKGR+Q3bpi2VeOIAvmI7cLkIFGdb4o43G4uOEu4rSW2SdQjdEk1TXvl41ll4atkLUOJierop9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159055; c=relaxed/simple;
	bh=Kfrq112/bKzkG8fbTB/RPM9/0slMJFhQLBt+TdAfcps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLmh/n/ObN2eqOsB314YQ9J2YZfxL1HpuQHTYqQ+AKqI2o5JWtOKymqHOUcz8QbAOKHaIWaY4IrwC2RcIGpYmdv38+jIOBaKmR3Tnf/U98EzYpswmhcya4PEPHgPzEgt9d7HmcmdldLLv5MSCtBXRVGbKgMyxBHW4k7zKO5Jk24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcyP1q/8; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcyP1q/8"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a168dc590cso1606758eaf.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159052; cv=none;
        d=google.com; s=arc-20260327;
        b=ZodTPhiUDQ8lCM7eiLB4G0s9Lstn/8wJi2JFItWcVaWtjRKUy5ugVf6APIde7HgKHl
         4Iejr/EGoe1yW2aBpRkGAJvFUELlLHw23yrcVzCpT9iJP5keJouDKDZ4o2NWKAlQfUF/
         xlvyzTGtfp7TpHcMS9NiIWf/iT9dccz75bdM0MDS5nnGJdDWs9zXXIpEHqCktsI4SRhC
         Gn4Le98NlObh5qdOmje4Rt9Alo0PcP355aZzj89pbFmHocSaAji6yBxs1/98GTbhlDbl
         Xs5fNoUizHKzzE0UqKqrS7g/zBtb8vcxmTfck2NDAe1uL3SMenuF39WKXtLcmMqVkN8F
         O6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tTszW4oSXRg2nAQooOC5PHLIa1jF7eSTmRTyAa9LVAc=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=Ze+ZlzeEm3rFPdkEXFOk7Xqo/lMauhZ0hffHmQRUV5NvZpEmKUzWMjHeeJ5uV3s3xJ
         exSSONbp7QihOcH9OBgTtbdDXNWUtFhP9v2xNhmHAqGnSyihmoJzaFSu2gDr6X0M+pAM
         0RdHmQn1dQhHpuFZ0TFsO/fj43DtfGmLZj1vgjQojIJTX/JyapJYrivIPUgpxezVHHhF
         ZS5lxIwf3O9EYPMJPAVERgVMy2ShzFfk6AsTMXL1JeEVVi0ugOYQR3sYcdV4XDlSK7el
         CAChaYctDMKXjZVZKAlbCOBTZj6Se1vEGCFH9gr8QS1lx1+KmyXSah5WNSs+CGNz9kgb
         HvaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159052; x=1785763852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tTszW4oSXRg2nAQooOC5PHLIa1jF7eSTmRTyAa9LVAc=;
        b=CcyP1q/8AgqPxPyfLXC6CfgHpon+10BXtb161T6aYx7FKLo0N7SRFRE7Z2Jc8ZDbjH
         om3zBUXICaRKIzIm9A1qicXLjyABT1kon0rYC6QrW/qejMf+emL3ZwIdJrIQOja6fAji
         zqQ/NmlukjRqqly4LiRsJf4jBAdgwibKGOjbimJt9rjidPWQUu4teTQq88qQfwzHgmW7
         6/V9FABuYAgI31CnGhFsPTahq9TmibK7K8jzjtJlFHWmUvdUIaySxyOf8NUdIZEBHJmF
         iKrVqHqTCd7q3omoptoYa9Puo0sIq19q3JzMk6f57d35ScY1ZM4KdqDn6mctkDtrqnHO
         lROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159052; x=1785763852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTszW4oSXRg2nAQooOC5PHLIa1jF7eSTmRTyAa9LVAc=;
        b=SHaX0nNzKkCd1+lQ7aX/RBSMgwxEvwpOnPKW7X6WF6tGi/zTKjCe+zeR7XKUKe6uN0
         hHldFfR4SN66Yu/ClG7LQbJ1Cp9kHby2KkChWhSbw3WWypDZGQN8vjmLeJx4XnGXRVxY
         IuTd9sSshDkF8FO898o+P/ak53bMGuNu71oE67T5TN7C83WZvHtINtpw5+kX8w92b23w
         NlLGKtbP5iPEvBq6i8VpzDPKMZx8H2/+3r1ZwdyAUlNE0RHDWVt8R9TH34xPGhEpzeEN
         jlTlTPwe5AIK3O5QtrT3IzpXlNquur9uiblheF5lO2zxk0b9EFYYP74YB2nXqR2GaKbC
         VQGw==
X-Gm-Message-State: AOJu0YyW9qJDdmOrN+vyFl/jTAHqifxaQP2voEAQ5fxm/TjMcwicodiU
	Zn3ZFYiIfxlLStAQDsCx35vXWuRuVTXctUUXl//IKMt5BDkroNup+VytUDjBnd43AmYt7aOiFba
	822l+V8NfmlnU4UsNBuhphP1HzMB5iio=
X-Gm-Gg: AR+sD10dSyP4Br23vmnBcm9+qbYAMD4CXJgXZyy0izudhm7pVhpdEkXNIHzQbt/FzHf
	tgECjyKBF8uLeSUznttVaMzQ8EGh17uTD11CVbmUXDA/xA3VcmNf/jRi3assWpqkGQeWOoMhmzx
	TcaJtoyFhVCQy1tNdY+hrSz6YjJSzg9J/IOiBY/AztTPFZrdj8zWyCXXsr0fRmu2ZU5dOp8zxUj
	88IrVhZHW0F6qSy0mxJO1y+iaTStTwOK2ocu2cfGHF5CmRZYkx5rLiTUWYSng==
X-Received: by 2002:a05:6820:612:b0:6aa:f172:3094 with SMTP id
 006d021491bc7-6ac8d9a5045mr379485eaf.10.1785159051866; Mon, 27 Jul 2026
 06:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727013929.2457799-1-tweek@google.com> <20260727013929.2457799-2-tweek@google.com>
In-Reply-To: <20260727013929.2457799-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:30:40 -0400
X-Gm-Features: AUfX_myYUOwHLIUBxlyzT7czF6uGJZCoRgo0nOhr_7cPzN3ByNn2klsvaGk4zh8
Message-ID: <CAEjxPJ5bkPUXBF5ge0zChcWHQVxMX3n0dGRFsYJnuSyfk44BCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libselinux: support multiple context files for the
 file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 9:39=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Update the file labeling backend to support specifying multiple
> SELABEL_OPT_PATH options in selabel_open().
>
> All provided paths are stored in rec->spec_files and processed during
> initialization. Derived files, such as substitutions (.subs, .subs_dist)
> and auxiliary contexts (.homedirs, .local), continue to be based on the
> first path (or default selinux_file_context_path()) when enabled.
>
> Duplicate checking is only performed within each context file. The curren=
t
> behavior expects the ability for a later file to overwrite a previous
> declaration (e.g., .local).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes since v2:
> - Add optional paths (homedirs, local) to spec_files. Since these might
>   be referenced, let's keep track of them as any other spec files.
>   spec_files now contains the required files followed by the optional
>   files.
> - Strictly validate that, at most, 255 options are provided to init().
> - Remove the intermediate `path` variable.
> - Note: the 2rd argument of process_file is now always NULL. This can be
>   cleaned in a follow up commit.
>
> Changes since v1:
> - Restore nodups_spec_node, ignore duplicates across files.
> - Change num_paths type to uint8_t and check for overflow.
> - Check for NULL before strdup any path.
> - Use num_paths and num_paths+1 for homedirs and local.
>
>  libselinux/src/label_file.c     | 154 ++++++++++++++++++++++----------
>  libselinux/src/label_internal.h |   3 +-
>  2 files changed, 107 insertions(+), 50 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index d91e1462..c955216b 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -106,7 +106,8 @@ void sort_spec_node(struct spec_node *node, struct sp=
ec_node *parent)
>  /*
>   * Warn about duplicate specifications.
>   */
> -static int nodups_spec_node(const struct spec_node *node, const char *pa=
th)
> +static int nodups_spec_node(const struct selabel_handle *rec,
> +                           const struct spec_node *node)
>  {
>         int rc =3D 0;
>
> @@ -126,13 +127,16 @@ static int nodups_spec_node(const struct spec_node =
*node, const char *path)
>                             node1->file_kind !=3D node2->file_kind)
>                                 continue;
>
> +                       if (node1->inputno !=3D node2->inputno)
> +                               continue;
> +
>                         rc =3D -1;
>                         errno =3D EINVAL;
>                         if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) =
!=3D 0) {
>                                 COMPAT_LOG(
>                                         SELINUX_ERROR,
>                                         "%s: Multiple different specifica=
tions for %s %s  (%s and %s).\n",
> -                                       path,
> +                                       rec->spec_files[node1->inputno],
>                                         file_kind_to_string(node1->file_k=
ind),
>                                         node1->literal_match, node1->lr.c=
tx_raw,
>                                         node2->lr.ctx_raw);
> @@ -140,7 +144,7 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
>                                 COMPAT_LOG(
>                                         SELINUX_ERROR,
>                                         "%s: Multiple same specifications=
 for %s %s.\n",
> -                                       path,
> +                                       rec->spec_files[node1->inputno],
>                                         file_kind_to_string(node1->file_k=
ind),
>                                         node1->literal_match);
>                         }
> @@ -168,6 +172,9 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
>                                     node1->file_kind !=3D node2->file_kin=
d)
>                                         continue;
>
> +                               if (node1->inputno !=3D node2->inputno)
> +                                       continue;
> +
>                                 rc =3D -1;
>                                 errno =3D EINVAL;
>                                 if (strcmp(node1->lr.ctx_raw,
> @@ -175,7 +182,7 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
>                                         COMPAT_LOG(
>                                                 SELINUX_ERROR,
>                                                 "%s: Multiple different s=
pecifications for %s %s  (%s and %s).\n",
> -                                               path,
> +                                               rec->spec_files[node1->in=
putno],
>                                                 file_kind_to_string(
>                                                         node1->file_kind)=
,
>                                                 node1->regex_str,
> @@ -185,7 +192,7 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
>                                         COMPAT_LOG(
>                                                 SELINUX_ERROR,
>                                                 "%s: Multiple same specif=
ications for %s %s.\n",
> -                                               path,
> +                                               rec->spec_files[node1->in=
putno],
>                                                 file_kind_to_string(
>                                                         node1->file_kind)=
,
>                                                 node1->regex_str);
> @@ -197,7 +204,7 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
>         for (uint32_t i =3D 0; i < node->children_num; i++) {
>                 int rc2;
>
> -               rc2 =3D nodups_spec_node(&node->children[i], path);
> +               rc2 =3D nodups_spec_node(rec, &node->children[i]);
>                 if (rc2)
>                         rc =3D rc2;
>         }
> @@ -1480,26 +1487,37 @@ static char *selabel_sub_key(const struct saved_d=
ata *data, const char *key,
>
>  static void closef(struct selabel_handle *rec);
>
> +static const char *const opt_suffixes[] =3D { "homedirs", "local" };
> +
>  static int init(struct selabel_handle *rec, const struct selinux_opt *op=
ts,
>                 unsigned n)
>  {
>         struct saved_data *data =3D rec->data;
> -       const char *path =3D NULL;
> +       uint8_t num_required_paths =3D 0, num_optional_paths =3D 0, i, j;
> +       size_t total_paths;
>         const char *prefix =3D NULL;
> -       int status =3D -1, baseonly =3D 0;
> +       int status =3D -1;
> +       bool baseonly =3D false, path_provided =3D false;
> +
> +       if (n > UINT8_MAX) {
> +               errno =3D EINVAL;
> +               return -1;
> +       }
>
>         /* Process arguments */
> -       while (n) {
> -               n--;
> -               switch (opts[n].type) {
> +       for (i =3D 0; i < n; i++) {
> +               switch (opts[i].type) {
>                 case SELABEL_OPT_PATH:
> -                       path =3D opts[n].value;
> +                       if (opts[i].value) {
> +                               num_required_paths++;
> +                               path_provided =3D true;
> +                       }
>                         break;
>                 case SELABEL_OPT_SUBSET:
> -                       prefix =3D opts[n].value;
> +                       prefix =3D opts[i].value;
>                         break;
>                 case SELABEL_OPT_BASEONLY:
> -                       baseonly =3D !!opts[n].value;
> +                       baseonly =3D !!opts[i].value;
>                         break;
>                 case SELABEL_OPT_UNUSED:
>                 case SELABEL_OPT_VALIDATE:
> @@ -1511,10 +1529,56 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                 }
>         }
>
> +       /* If no paths were provided, we will use the default path or fai=
l,
> +        * depending on the target. */
> +       if (!path_provided) {
> +#if !defined(BUILD_HOST) && !defined(ANDROID)
> +               num_required_paths =3D 1;
> +#else
> +               selinux_log(SELINUX_ERROR,
> +                           "No path given to file labeling backend\n");
> +               errno =3D EINVAL;
> +               return -1;
> +#endif
> +       }
> +
> +       if (!baseonly)
> +               num_optional_paths =3D ARRAY_SIZE(opt_suffixes);
> +
> +       total_paths =3D num_required_paths + num_optional_paths;
> +
> +       /* Make sure total input files do not exceed the 256 indices supp=
orted
> +        * by uint8_t inputno */
> +       if (total_paths > UINT8_MAX + 1) {
> +               errno =3D EINVAL;
> +               return -1;
> +       }
> +
> +       /* Allocate the paths. */
> +       rec->spec_files =3D calloc(total_paths, sizeof(*rec->spec_files))=
;
> +       if (rec->spec_files =3D=3D NULL)
> +               goto finish;
> +       rec->spec_files_len =3D total_paths;
> +
> +       /* Copy all the paths given. */
> +       if (path_provided) {
> +               for (i =3D 0, j =3D 0; i < n; i++) {
> +                       if (opts[i].type =3D=3D SELABEL_OPT_PATH && opts[=
i].value) {
> +                               rec->spec_files[j] =3D strdup(opts[i].val=
ue);
> +                               if (rec->spec_files[j] =3D=3D NULL)
> +                                       goto finish;
> +                               j++;
> +                       }
> +               }
> +       }
> +
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
>         char subs_file[PATH_MAX + 1];
>         /* Process local and distribution substitution files */
> -       if (!path) {
> +       if (!path_provided) {
> +               rec->spec_files[0] =3D strdup(selinux_file_context_path()=
);
> +               if (rec->spec_files[0] =3D=3D NULL)
> +                       goto finish;
>                 status =3D selabel_subs_init(
>                         selinux_file_context_subs_dist_path(), rec->diges=
t,
>                         &data->dist_subs, &data->dist_subs_num,
> @@ -1526,67 +1590,61 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                                            &data->subs_num, &data->subs_a=
lloc);
>                 if (status)
>                         goto finish;
> -               path =3D selinux_file_context_path();
>         } else {
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", pa=
th);
> +               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",
> +                        rec->spec_files[0]);
>                 status =3D selabel_subs_init(subs_file, rec->digest,
>                                            &data->dist_subs,
>                                            &data->dist_subs_num,
>                                            &data->dist_subs_alloc);
>                 if (status)
>                         goto finish;
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
> +               snprintf(subs_file, sizeof(subs_file), "%s.subs",
> +                        rec->spec_files[0]);
>                 status =3D selabel_subs_init(subs_file, rec->digest, &dat=
a->subs,
>                                            &data->subs_num, &data->subs_a=
lloc);
>                 if (status)
>                         goto finish;
>         }
> -
>  #endif
>
> -       if (!path) {
> -               errno =3D EINVAL;
> -               goto finish;
> +       for (i =3D 0; i < num_optional_paths; i++) {
> +               if (asprintf(&rec->spec_files[num_required_paths + i], "%=
s.%s",
> +                            rec->spec_files[0], opt_suffixes[i]) < 0) {
> +                       rec->spec_files[num_required_paths + i] =3D NULL;
> +                       goto finish;
> +               }
>         }
>
> -       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> -       if (!rec->spec_files)
> -               goto finish;
> -       rec->spec_files[0] =3D strdup(path);
> -       if (!rec->spec_files[0])
> -               goto finish;
> -       rec->spec_files_len =3D 1;
> -
>         /*
> -        * The do detailed validation of the input and fill the spec arra=
y
> +        * Process each main input file.
>          */
> -       status =3D process_file(path, NULL, rec, prefix, rec->digest, 0);
> -       if (status)
> -               goto finish;
> -
> -       if (rec->validating) {
> -               sort_specs(data);
> -
> -               status =3D nodups_spec_node(data->root, path);
> +       for (i =3D 0; i < num_required_paths; i++) {
> +               status =3D process_file(rec->spec_files[i], NULL, rec, pr=
efix,
> +                                     rec->digest, i);
>                 if (status)
>                         goto finish;
>         }
>
> -       if (!baseonly) {
> -               status =3D process_file(path, "homedirs", rec, prefix,
> -                                     rec->digest, 1);
> +       /*
> +        * Process each optional input file.
> +        */
> +       for (i =3D 0; i < num_optional_paths; i++) {
> +               status =3D process_file(rec->spec_files[num_required_path=
s + i],
> +                                     NULL, rec, prefix, rec->digest,
> +                                     num_required_paths + i);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
> +       }
>
> -               status =3D process_file(path, "local", rec, prefix, rec->=
digest,
> -                                     2);
> -               if (status && errno !=3D ENOENT)
> +       sort_specs(data);
> +
> +       if (rec->validating) {
> +               status =3D nodups_spec_node(rec, data->root);
> +               if (status)
>                         goto finish;
>         }
>
> -       if (!rec->validating || !baseonly)
> -               sort_specs(data);
> -
>         digest_gen_hash(rec->digest);
>
>         status =3D 0;
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index d54053df..4279637e 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -96,8 +96,7 @@ struct selabel_handle {
>         void *data;
>
>         /*
> -        * The spec files used. Note for file contexts the local and/or
> -        * homedirs could also have been used to resolve a context.
> +        * The specification files used.
>          */
>         size_t spec_files_len;
>         char **spec_files;
> --
> 2.55.0.229.g6434b31f56-goog
>
