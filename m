Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD81F942E
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464784; cv=none; b=Sa6ISQ5Yp0+nlMzMAjgrPNxJGD5K+wUG0hXlyruMuuWYDKQI7/46rUbDM27e13Udkg/VrfNUXXdTzvKRXgdmWW58YKOph2akIAlGcgOl7Wmnt5WOSmHa/PcvS9RLvLQN3FKrvC0s+KZpM7e93fG7NsID1A14sJ3wxKkiFOc4Mi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464784; c=relaxed/simple;
	bh=pfPPvWgxyhxTx2AzYLpZJKYzTwqatfbbkT8C9by7u58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqB+1d7dbl2RoOW9pKnYDr8uPmuZV0vkJFNpJDjcrbPIfNNLohzUQzz1ydirRFxL1mChNSaoR/0E6oep+nYFIQ34n87EA8+NUCXnePayWAWF1SvOrrNIAZ4a8ONmMJU2fr1wN5BML1IPWxElZCagujZjPEXWub+Ybp8buuyxeuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRK8x55f; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRK8x55f"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afe70b41a8so1607172137.3
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 11:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734464780; x=1735069580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pkjlN/iIbdBhvG+ERq4fgr2XRXe6dfhfInJXTWxkR0=;
        b=KRK8x55fKxbtpCaxs4RlNfcUzr0VUVtt6AUdL8xh5W1MZh9++dR9PR5sjL3vF2Z/x1
         /3t+OFxbrxfbTKIkcmXMD5L9FA+RIn+w0G16f4ngm8+bY50iFXWOr47y4DzMD9Zqbde2
         r7NP7dDGEZd3/AGgJiyRBFj2bzxUWWH+F+o1ivKbqQTAOG64AUbhVEe0vQ6yuceE8hud
         0YNl0h+nM8q7n+bsp9oNL7pAhsW0fbHy/14ec/0HPz2ZYeLQh/lIjbyfL/+qP5vqGgLP
         x93n7uyOr28+Utm6jdhGmAydNp8rzbUCltaP6en6JItcUxeT+7R2WbahvJTEAFspVsIU
         rNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464780; x=1735069580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pkjlN/iIbdBhvG+ERq4fgr2XRXe6dfhfInJXTWxkR0=;
        b=WS5laGhMimtAPtJkFyIeSQ0TkawZS1a/28mkkLI/GrKJ7A5DtEoOu3vjF+8ucwIK6V
         gfwgE/vqJ/iRFb8MS3/S9wGWofzkfqkJxYlU6dj0j2YLRqvqVpXZrQUFzbHNmreCZMns
         Q+jVaabs25s8TJslk/068s4FVoqZw6UGK/P+uFnVBo/xYlvJ+Xx1x+NSj+U9ZsuKVKA1
         AM/9DoGUp5ZEbXMTkNE/FfjKy4kNwcFC98lrGpXbjsYJHN4phsxL3qhlvcbob+LObKz8
         hNdwNxUSewYGdeSrYdtVJpVBN+xUCGGK6VFylf/IdNFKnUDTzwxmewrdHENdUXiTtiav
         vwnA==
X-Gm-Message-State: AOJu0YyuEdkY4NHPixHbO0rWMzPxKpPHNxt1ulBhuulwdjAX9ScUHu5t
	Arr//PhdCQKtawyTUaeKPeIXIQrQgQ9b9liWNRpMNGXp1DiqABkHkUZ1SSfFzOtAzVqf3cQ/xDr
	L7X5W2MK3obCuxNvHtYmp/cJXeYA=
X-Gm-Gg: ASbGncuHPNKgLbGVlnoqTs42pA0FsXVJdcc8DCy6oj0pTHmhlgFsru71QIgMwXIdDGm
	QGjwlfAIcFi+Y9ImateTUs3pa4twIeBLRHwY/rw==
X-Google-Smtp-Source: AGHT+IFbXgIWCasc9HFBUbo5MeIdBZrPrUMs+rIbQtoQie5CFkgmUEjG2zPhfscee7kIu4cQBXQ8r6CwhhXcjI239Dc=
X-Received: by 2002:a05:6102:3590:b0:4b2:4950:16fe with SMTP id
 ada2fe7eead31-4b2ae7770b5mr122719137.14.1734464779828; Tue, 17 Dec 2024
 11:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212211459.125929-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241212211459.125929-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 14:46:09 -0500
Message-ID: <CAP+JOzS2oZhbMU8x5J2+GG6ORRTpzWePgC-NjwhXjiT7MUkwiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libselinux: restore previous regex spec ordering
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 4:15=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Prior the recent selabel_file(5) rework regular expressions for a
> certain stem where matched in the order given by the input.
> The Reference and Fedora Policy as well as CIL and libsemanage pre-sort
> the file context definitions based on the prefix stem length, so this
> ordering was adopted.
>
> Do not alter the order by the input of regex specifications, and search
> on matches on regex specifications in in parent nodes, which might
> contain specifications with definitions defined later in the source
> file.
> This restores backward compatibility, especially for Android.
>
> Reported-by: Takaya Saeki <takayas@chromium.org>
> Closes: https://lore.kernel.org/selinux/CAH9xa6eFO6BNeGko90bsq8CuDba9eO+q=
dDoF+7zfyAUHEDpH9g@mail.gmail.com/
> Fixes: 92306da ("libselinux: rework selabel_file(5) database")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   - search parent nodes for later regex specs
>     The pre-compiled fcontext format changed, due to the addition of the
>     line number for regex specs.  Thus files generated with 3.8-rc1
>     will fail to load, but it won't result in wrong lookup results like
>     the v1 patch.
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_file.c           | 331 ++++++++++++++------------
>  libselinux/src/label_file.h           |  47 +---
>  libselinux/utils/sefcontext_compile.c |  11 +-
>  3 files changed, 202 insertions(+), 187 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 80a7c5ab..56e20949 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -87,14 +87,14 @@ void sort_spec_node(struct spec_node *node, struct sp=
ec_node *parent)
>
>         node->parent =3D parent;
>
> -       /* Sort for comparison support and binary search lookup */
> +       /*
> +        * Sort for comparison support and binary search lookup,
> +        * except for regex specs which are matched in reverse input orde=
r.
> +        */
>
>         if (node->literal_specs_num > 1)
>                 qsort(node->literal_specs, node->literal_specs_num, sizeo=
f(struct literal_spec), compare_literal_spec);
>
> -       if (node->regex_specs_num > 1)
> -               qsort(node->regex_specs, node->regex_specs_num, sizeof(st=
ruct regex_spec), compare_regex_spec);
> -
>         if (node->children_num > 1)
>                 qsort(node->children, node->children_num, sizeof(struct s=
pec_node), compare_spec_node);
>
> @@ -144,36 +144,38 @@ static int nodups_spec_node(const struct spec_node =
*node, const char *path)
>
>         if (node->regex_specs_num > 1) {
>                 for (uint32_t i =3D 0; i < node->regex_specs_num - 1; i++=
) {
> -                       const struct regex_spec *node1 =3D &node->regex_s=
pecs[i];
> -                       const struct regex_spec *node2 =3D &node->regex_s=
pecs[i+1];
> +                       for (uint32_t j =3D i; j < node->regex_specs_num =
- 1; j++) {
> +                               const struct regex_spec *node1 =3D &node-=
>regex_specs[i];
> +                               const struct regex_spec *node2 =3D &node-=
>regex_specs[j + 1];
>
> -                       if (node1->prefix_len !=3D node2->prefix_len)
> -                               continue;
> +                               if (node1->prefix_len !=3D node2->prefix_=
len)
> +                                       continue;
>
> -                       if (strcmp(node1->regex_str, node2->regex_str) !=
=3D 0)
> -                               continue;
> +                               if (strcmp(node1->regex_str, node2->regex=
_str) !=3D 0)
> +                                       continue;
>
> -                       if (node1->file_kind !=3D LABEL_FILE_KIND_ALL && =
node2->file_kind !=3D LABEL_FILE_KIND_ALL && node1->file_kind !=3D node2->f=
ile_kind)
> -                               continue;
> +                               if (node1->file_kind !=3D LABEL_FILE_KIND=
_ALL && node2->file_kind !=3D LABEL_FILE_KIND_ALL && node1->file_kind !=3D =
node2->file_kind)
> +                                       continue;
>
> -                       rc =3D -1;
> -                       errno =3D EINVAL;
> -                       if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) =
!=3D 0) {
> -                               COMPAT_LOG
> -                                       (SELINUX_ERROR,
> -                                               "%s: Multiple different s=
pecifications for %s %s  (%s and %s).\n",
> -                                               path,
> -                                               file_kind_to_string(node1=
->file_kind),
> -                                               node1->regex_str,
> -                                               node1->lr.ctx_raw,
> -                                               node2->lr.ctx_raw);
> -                       } else {
> -                               COMPAT_LOG
> -                                       (SELINUX_ERROR,
> -                                               "%s: Multiple same specif=
ications for %s %s.\n",
> -                                               path,
> -                                               file_kind_to_string(node1=
->file_kind),
> -                                               node1->regex_str);
> +                               rc =3D -1;
> +                               errno =3D EINVAL;
> +                               if (strcmp(node1->lr.ctx_raw, node2->lr.c=
tx_raw) !=3D 0) {
> +                                       COMPAT_LOG
> +                                               (SELINUX_ERROR,
> +                                                       "%s: Multiple dif=
ferent specifications for %s %s  (%s and %s).\n",
> +                                                       path,
> +                                                       file_kind_to_stri=
ng(node1->file_kind),
> +                                                       node1->regex_str,
> +                                                       node1->lr.ctx_raw=
,
> +                                                       node2->lr.ctx_raw=
);
> +                               } else {
> +                                       COMPAT_LOG
> +                                               (SELINUX_ERROR,
> +                                                       "%s: Multiple sam=
e specifications for %s %s.\n",
> +                                                       path,
> +                                                       file_kind_to_stri=
ng(node1->file_kind),
> +                                                       node1->regex_str)=
;
> +                               }
>                         }
>                 }
>         }
> @@ -190,7 +192,8 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
>  }
>
>  FUZZ_EXTERN int process_text_file(FILE *fp, const char *prefix,
> -                                 struct selabel_handle *rec, const char =
*path)
> +                                 struct selabel_handle *rec, const char =
*path,
> +                                 uint8_t inputno)
>  {
>         int rc;
>         size_t line_len;
> @@ -199,7 +202,7 @@ FUZZ_EXTERN int process_text_file(FILE *fp, const cha=
r *prefix,
>         char *line_buf =3D NULL;
>
>         while ((nread =3D getline(&line_buf, &line_len, fp)) > 0) {
> -               rc =3D process_line(rec, path, prefix, line_buf, nread, +=
+lineno);
> +               rc =3D process_line(rec, path, prefix, line_buf, nread, i=
nputno, ++lineno);
>                 if (rc)
>                         goto out;
>         }
> @@ -568,9 +571,10 @@ static int load_mmap_literal_spec(struct mmap_area *=
mmap_area, bool validating,
>  }
>
>  static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool valida=
ting, bool do_load_precompregex,
> +                               uint8_t inputno,
>                                 struct regex_spec *rspec, const struct co=
ntext_array *ctx_array)
>  {
> -       uint32_t data_u32, ctx_id;
> +       uint32_t data_u32, ctx_id, lineno;
>         uint16_t data_u16, regex_len;
>         uint8_t data_u8;
>         int rc;
> @@ -600,6 +604,20 @@ static int load_mmap_regex_spec(struct mmap_area *mm=
ap_area, bool validating, bo
>                 rspec->lr.validated =3D true;
>
>
> +       /*
> +        * Read line number in source file.
> +        */
> +       rc =3D next_entry(&data_u32, mmap_area, sizeof(uint32_t));
> +       if (rc < 0)
> +               return -1;
> +       lineno =3D be32toh(data_u32);
> +
> +       if (lineno =3D=3D 0 || lineno =3D=3D UINT32_MAX)
> +               return -1;
> +       rspec->lineno =3D lineno;
> +       rspec->inputno =3D inputno;
> +
> +
>         /*
>          * Read original regex
>          */
> @@ -649,14 +667,14 @@ static int load_mmap_regex_spec(struct mmap_area *m=
map_area, bool validating, bo
>         if (rc < 0)
>                 return -1;
>
> -       __pthread_mutex_init(&rspec->regex_lock, NULL);
>
> +       __pthread_mutex_init(&rspec->regex_lock, NULL);
>
>         return 0;
>  }
>
>  static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *=
path, bool validating, bool do_load_precompregex,
> -                              struct spec_node *node, bool is_root, cons=
t struct context_array *ctx_array)
> +                              struct spec_node *node, bool is_root, uint=
8_t inputno, const struct context_array *ctx_array)
>  {
>         uint32_t data_u32, lspec_num, rspec_num, children_num;
>         uint16_t data_u16, stem_len;
> @@ -744,7 +762,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>                 node->regex_specs_alloc =3D rspec_num;
>
>                 for (uint32_t i =3D 0; i < rspec_num; i++) {
> -                       rc =3D load_mmap_regex_spec(mmap_area, validating=
, do_load_precompregex, &node->regex_specs[i], ctx_array);
> +                       rc =3D load_mmap_regex_spec(mmap_area, validating=
, do_load_precompregex, inputno, &node->regex_specs[i], ctx_array);
>                         if (rc)
>                                 return -1;
>                 }
> @@ -776,7 +794,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>                 node->children_alloc =3D children_num;
>
>                 for (uint32_t i =3D 0; i < children_num; i++) {
> -                       rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating, do_load_precompregex, &node->children[i], false, ctx_array);
> +                       rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating, do_load_precompregex, &node->children[i], false, inputno, ctx_array)=
;
>                         if (rc)
>                                 return -1;
>
> @@ -796,7 +814,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>  }
>
>  FUZZ_EXTERN int load_mmap(FILE *fp, const size_t len, struct selabel_han=
dle *rec,
> -                         const char *path)
> +                         const char *path, uint8_t inputno)
>  {
>         struct saved_data *data =3D rec->data;
>         struct spec_node *root =3D NULL;
> @@ -952,6 +970,7 @@ end_arch_check:
>         rc =3D load_mmap_spec_node(mmap_area, path, rec->validating,
>                                  reg_version_matches && reg_arch_matches,
>                                  root, true,
> +                                inputno,
>                                  &ctx_array);
>         if (rc)
>                 goto err;
> @@ -1142,7 +1161,8 @@ static FILE *open_file(const char *path, const char=
 *suffix,
>  static int process_file(const char *path, const char *suffix,
>                         struct selabel_handle *rec,
>                         const char *prefix,
> -                       struct selabel_digest *digest)
> +                       struct selabel_digest *digest,
> +                       uint8_t inputno)
>  {
>         int rc;
>         unsigned int i;
> @@ -1171,9 +1191,9 @@ static int process_file(const char *path, const cha=
r *suffix,
>                         COMPAT_LOG(SELINUX_INFO, "%s:  Old compiled fcont=
ext format, skipping\n", found_path);
>                         errno =3D EINVAL;
>                 } else if (rc =3D=3D 1) {
> -                       rc =3D load_mmap(fp, sb.st_size, rec, found_path)=
;
> +                       rc =3D load_mmap(fp, sb.st_size, rec, found_path,=
 inputno);
>                 } else {
> -                       rc =3D process_text_file(fp, prefix, rec, found_p=
ath);
> +                       rc =3D process_text_file(fp, prefix, rec, found_p=
ath, inputno);
>                 }
>
>                 if (!rc)
> @@ -1434,7 +1454,7 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
>         /*
>          * The do detailed validation of the input and fill the spec arra=
y
>          */
> -       status =3D process_file(path, NULL, rec, prefix, rec->digest);
> +       status =3D process_file(path, NULL, rec, prefix, rec->digest, 0);
>         if (status)
>                 goto finish;
>
> @@ -1448,12 +1468,12 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>
>         if (!baseonly) {
>                 status =3D process_file(path, "homedirs", rec, prefix,
> -                                                           rec->digest);
> +                                                           rec->digest, =
1);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>
>                 status =3D process_file(path, "local", rec, prefix,
> -                                                           rec->digest);
> +                                                           rec->digest, =
2);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>         }
> @@ -1579,77 +1599,84 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>  {
>         struct lookup_result *result =3D NULL;
>         struct lookup_result **next =3D &result;
> +       struct lookup_result *child_regex_match =3D NULL;
> +       uint8_t child_regex_match_inputno =3D 0;  /* initialize to please=
 GCC */
> +       uint32_t child_regex_match_lineno =3D 1;  /* initialize to please=
 GCC */
>         size_t key_len =3D strlen(key);
>
>         assert(!(find_all && buf !=3D NULL));
>
>         for (struct spec_node *n =3D node; n; n =3D n->parent) {
>
> -               uint32_t literal_idx =3D search_literal_spec(n->literal_s=
pecs, n->literal_specs_num, key, key_len, partial);
> -               if (literal_idx !=3D (uint32_t)-1) {
> -                       do {
> -                               struct literal_spec *lspec =3D &n->litera=
l_specs[literal_idx];
> +               if (n =3D=3D node) {
> +                       uint32_t literal_idx =3D search_literal_spec(n->l=
iteral_specs, n->literal_specs_num, key, key_len, partial);
> +                       if (literal_idx !=3D (uint32_t)-1) {
> +                               do {
> +                                       struct literal_spec *lspec =3D &n=
->literal_specs[literal_idx];
>
> -                               if (file_kind =3D=3D LABEL_FILE_KIND_ALL =
|| lspec->file_kind =3D=3D LABEL_FILE_KIND_ALL || lspec->file_kind =3D=3D f=
ile_kind) {
> -                                       struct lookup_result *r;
> +                                       if (file_kind =3D=3D LABEL_FILE_K=
IND_ALL || lspec->file_kind =3D=3D LABEL_FILE_KIND_ALL || lspec->file_kind =
=3D=3D file_kind) {
> +                                               struct lookup_result *r;
>
>  #ifdef __ATOMIC_RELAXED
> -                                       __atomic_store_n(&lspec->any_matc=
hes, true, __ATOMIC_RELAXED);
> +                                               __atomic_store_n(&lspec->=
any_matches, true, __ATOMIC_RELAXED);
>  #else
>  #error "Please use a compiler that supports __atomic builtins"
>  #endif
>
> -                                       if (strcmp(lspec->lr.ctx_raw, "<<=
none>>") =3D=3D 0) {
> -                                               free_lookup_result(result=
);
> -                                               errno =3D ENOENT;
> -                                               return NULL;
> -                                       }
> +                                               if (strcmp(lspec->lr.ctx_=
raw, "<<none>>") =3D=3D 0) {
> +                                                       errno =3D ENOENT;
> +                                                       goto fail;
> +                                               }
>
> -                                       if (likely(buf)) {
> -                                               r =3D buf;
> -                                       } else {
> -                                               r =3D malloc(sizeof(*r));
> -                                               if (!r) {
> -                                                       free_lookup_resul=
t(result);
> -                                                       return NULL;
> +                                               if (likely(buf)) {
> +                                                       r =3D buf;
> +                                               } else {
> +                                                       r =3D malloc(size=
of(*r));
> +                                                       if (!r)
> +                                                               goto fail=
;
>                                                 }
> -                                       }
>
> -                                       *r =3D (struct lookup_result) {
> -                                               .regex_str =3D lspec->reg=
ex_str,
> -                                               .prefix_len =3D lspec->pr=
efix_len,
> -                                               .file_kind =3D lspec->fil=
e_kind,
> -                                               .lr =3D &lspec->lr,
> -                                               .has_meta_chars =3D false=
,
> -                                               .next =3D NULL,
> -                                       };
> +                                               *r =3D (struct lookup_res=
ult) {
> +                                                       .regex_str =3D ls=
pec->regex_str,
> +                                                       .prefix_len =3D l=
spec->prefix_len,
> +                                                       .file_kind =3D ls=
pec->file_kind,
> +                                                       .lr =3D &lspec->l=
r,
> +                                                       .has_meta_chars =
=3D false,
> +                                                       .next =3D NULL,
> +                                               };
>
> -                                       if (likely(!find_all))
> -                                               return r;
> +                                               if (likely(!find_all))
> +                                                       return r;
>
> -                                       *next =3D r;
> -                                       next =3D &r->next;
> -                               }
> +                                               *next =3D r;
> +                                               next =3D &r->next;
> +                                       }
>
> -                               literal_idx++;
> -                       } while (literal_idx < n->literal_specs_num &&
> -                                (partial ? (strncmp(n->literal_specs[lit=
eral_idx].literal_match, key, key_len) =3D=3D 0)
> -                                         : (strcmp(n->literal_specs[lite=
ral_idx].literal_match, key) =3D=3D 0)));
> +                                       literal_idx++;
> +                               } while (literal_idx < n->literal_specs_n=
um &&
> +                                       (partial ? (strncmp(n->literal_sp=
ecs[literal_idx].literal_match, key, key_len) =3D=3D 0)
> +                                               : (strcmp(n->literal_spec=
s[literal_idx].literal_match, key) =3D=3D 0)));
> +                       }
>                 }
>
> -               for (uint32_t i =3D 0; i < n->regex_specs_num; i++) {
> -                       struct regex_spec *rspec =3D &n->regex_specs[i];
> +               for (uint32_t i =3D n->regex_specs_num; i > 0; i--) {
> +                       /* search in reverse order */
> +                       struct regex_spec *rspec =3D &n->regex_specs[i - =
1];
>                         const char *errbuf =3D NULL;
>                         int rc;
>
> +                       if (child_regex_match &&
> +                           (rspec->inputno < child_regex_match_inputno |=
|
> +                            (rspec->inputno =3D=3D child_regex_match_inp=
utno && rspec->lineno < child_regex_match_lineno)))
> +                               break;
> +
>                         if (file_kind !=3D LABEL_FILE_KIND_ALL && rspec->=
file_kind !=3D LABEL_FILE_KIND_ALL && file_kind !=3D rspec->file_kind)
>                                 continue;
>
>                         if (compile_regex(rspec, &errbuf) < 0) {
>                                 COMPAT_LOG(SELINUX_ERROR, "Failed to comp=
ile regular expression '%s':  %s\n",
>                                            rspec->regex_str, errbuf);
> -                               free_lookup_result(result);
> -                               return NULL;
> +                               goto fail;
>                         }
>
>                         rc =3D regex_match(rspec->regex, key, partial);
> @@ -1665,19 +1692,18 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>                                 }
>
>                                 if (strcmp(rspec->lr.ctx_raw, "<<none>>")=
 =3D=3D 0) {
> -                                       free_lookup_result(result);
>                                         errno =3D ENOENT;
> -                                       return NULL;
> +                                       goto fail;
>                                 }
>
> -                               if (likely(buf)) {
> +                               if (child_regex_match) {
> +                                       r =3D child_regex_match;
> +                               } else if (buf) {
>                                         r =3D buf;
>                                 } else {
>                                         r =3D malloc(sizeof(*r));
> -                                       if (!r) {
> -                                               free_lookup_result(result=
);
> -                                               return NULL;
> -                                       }
> +                                       if (!r)
> +                                               goto fail;
>                                 }
>
>                                 *r =3D (struct lookup_result) {
> @@ -1689,8 +1715,12 @@ static struct lookup_result *lookup_check_node(str=
uct spec_node *node, const cha
>                                         .next =3D NULL,
>                                 };
>
> -                               if (likely(!find_all))
> -                                       return r;
> +                               if (likely(!find_all)) {
> +                                       child_regex_match =3D r;
> +                                       child_regex_match_inputno =3D rsp=
ec->inputno;
> +                                       child_regex_match_lineno =3D rspe=
c->lineno;
> +                                       goto parent_node;
> +                               }
>
>                                 *next =3D r;
>                                 next =3D &r->next;
> @@ -1702,15 +1732,28 @@ static struct lookup_result *lookup_check_node(st=
ruct spec_node *node, const cha
>                                 continue;
>
>                         /* else it's an error */
> -                       free_lookup_result(result);
>                         errno =3D ENOENT;
> -                       return NULL;
> +                       goto fail;
>                 }
> +
> +           parent_node:
> +               continue;
>         }
>
> +       if (child_regex_match)
> +               return child_regex_match;
> +
>         if (!result)
>                 errno =3D ENOENT;
>         return result;
> +
> +    fail:
> +       if (!find_all && child_regex_match && child_regex_match !=3D buf)
> +               free(child_regex_match);
> +
> +       free_lookup_result(result);
> +
> +       return NULL;
>  }
>
>  static struct spec_node* search_child_node(struct spec_node *array, uint=
32_t size, const char *key, size_t key_len)
> @@ -2221,81 +2264,69 @@ static enum selabel_cmp_result spec_node_cmp(cons=
t struct spec_node *node1, cons
>                 while (iter1 < node1->regex_specs_num && iter2 < node2->r=
egex_specs_num) {
>                         const struct regex_spec *rspec1 =3D &node1->regex=
_specs[iter1];
>                         const struct regex_spec *rspec2 =3D &node2->regex=
_specs[iter2];
> -                       int cmp;
> -
> -                       if (rspec1->prefix_len > rspec2->prefix_len) {
> -                               if (result =3D=3D SELABEL_EQUAL || result=
 =3D=3D SELABEL_SUPERSET) {
> -                                       result =3D SELABEL_SUPERSET;
> -                                       iter1++;
> -                                       continue;
> -                               }
> +                       bool found_successor;
>
> -                               return rspec_incomp(node1->stem, rspec1, =
rspec2, "regex_prefix_length", iter1, iter2);
> +                       if (rspec1->file_kind =3D=3D rspec2->file_kind &&=
 strcmp(rspec1->regex_str, rspec2->regex_str) =3D=3D 0) {
> +                               iter1++;
> +                               iter2++;
> +                               continue;
>                         }
>
> -                       if (rspec1->prefix_len < rspec2->prefix_len) {
> -                               if (result =3D=3D SELABEL_EQUAL || result=
 =3D=3D SELABEL_SUBSET) {
> -                                       result =3D SELABEL_SUBSET;
> -                                       iter2++;
> -                                       continue;
> -                               }
> +                       if (result =3D=3D SELABEL_SUPERSET) {
> +                               iter1++;
> +                               continue;
> +                       }
>
> -                               return rspec_incomp(node1->stem, rspec1, =
rspec2, "regex_prefix_length", iter1, iter2);
> +                       if (result =3D=3D SELABEL_SUBSET) {
> +                               iter2++;
> +                               continue;
>                         }
>
> -                       /* If prefix length is equal compare regex string=
 */
> +                       assert(result =3D=3D SELABEL_EQUAL);
>
> -                       cmp =3D strcmp(rspec1->regex_str, rspec2->regex_s=
tr);
> -                       if (cmp < 0) {
> -                               if (result =3D=3D SELABEL_EQUAL || result=
 =3D=3D SELABEL_SUPERSET) {
> -                                       result =3D SELABEL_SUPERSET;
> -                                       iter1++;
> -                                       continue;
> -                               }
> +                       found_successor =3D false;
>
> -                               return rspec_incomp(node1->stem, rspec1, =
rspec2, "regex_str", iter1, iter2);
> -                       }
> +                       for (uint32_t i =3D iter2; i < node2->regex_specs=
_num; i++) {
> +                               const struct regex_spec *successor =3D &n=
ode2->regex_specs[i];
>
> -                       if (cmp > 0) {
> -                               if (result =3D=3D SELABEL_EQUAL || result=
 =3D=3D SELABEL_SUBSET) {
> +                               if (rspec1->file_kind =3D=3D successor->f=
ile_kind && strcmp(rspec1->regex_str, successor->regex_str) =3D=3D 0) {
>                                         result =3D SELABEL_SUBSET;
> -                                       iter2++;
> -                                       continue;
> +                                       iter1++;
> +                                       iter2 =3D i + 1;
> +                                       found_successor =3D true;
> +                                       break;
>                                 }
> -
> -                               return rspec_incomp(node1->stem, rspec1, =
rspec2, "regex_str", iter1, iter2);
>                         }
>
> -                       /* If literal match is equal compare file kind */
> +                       if (found_successor)
> +                               continue;
>
> -                       if (rspec1->file_kind > rspec2->file_kind) {
> -                               if (result =3D=3D SELABEL_EQUAL || result=
 =3D=3D SELABEL_SUPERSET) {
> -                                       result =3D SELABEL_SUPERSET;
> -                                       iter1++;
> -                                       continue;
> -                               }
> +                       for (uint32_t i =3D iter1; i < node1->regex_specs=
_num; i++) {
> +                               const struct regex_spec *successor =3D &n=
ode1->regex_specs[i];
>
> -                               return rspec_incomp(node1->stem, rspec1, =
rspec2, "file_kind", iter1, iter2);
> -                       }
> -
> -                       if (rspec1->file_kind < rspec2->file_kind) {
> -                               if (result =3D=3D SELABEL_EQUAL || result=
 =3D=3D SELABEL_SUBSET) {
> -                                       result =3D SELABEL_SUBSET;
> +                               if (successor->file_kind =3D=3D rspec2->f=
ile_kind && strcmp(successor->regex_str, rspec2->regex_str) =3D=3D 0) {
> +                                       result =3D SELABEL_SUPERSET;
> +                                       iter1 =3D i + 1;
>                                         iter2++;
> -                                       continue;
> +                                       found_successor =3D true;
> +                                       break;
>                                 }
> -
> -                               return rspec_incomp(node1->stem, rspec1, =
rspec2, "file_kind", iter1, iter2);
>                         }
>
> -                       iter1++;
> -                       iter2++;
> +                       if (found_successor)
> +                               continue;
> +
> +                       return rspec_incomp(node1->stem, rspec1, rspec2, =
"regex", iter1, iter2);
>                 }
>                 if (iter1 !=3D node1->regex_specs_num) {
>                         if (result =3D=3D SELABEL_EQUAL || result =3D=3D =
SELABEL_SUPERSET) {
>                                 result =3D SELABEL_SUPERSET;
>                         } else {
> -                               selinux_log(SELINUX_INFO, "selabel_cmp: m=
ismatch regex_str left remnant in stem %s\n", fmt_stem(node1->stem));
> +                               const struct regex_spec *rspec1 =3D &node=
1->regex_specs[iter1];
> +
> +                               selinux_log(SELINUX_INFO, "selabel_cmp: m=
ismatch regex left remnant in stem %s entry %u: (%s, %s, %s)\n",
> +                                           fmt_stem(node1->stem),
> +                                           iter1, rspec1->regex_str, fil=
e_kind_to_string(rspec1->file_kind), rspec1->lr.ctx_raw);
>                                 return SELABEL_INCOMPARABLE;
>                         }
>                 }
> @@ -2303,7 +2334,11 @@ static enum selabel_cmp_result spec_node_cmp(const=
 struct spec_node *node1, cons
>                         if (result =3D=3D SELABEL_EQUAL || result =3D=3D =
SELABEL_SUBSET) {
>                                 result =3D SELABEL_SUBSET;
>                         } else {
> -                               selinux_log(SELINUX_INFO, "selabel_cmp: m=
ismatch regex_str right remnant in stem %s\n", fmt_stem(node1->stem));
> +                               const struct regex_spec *rspec2 =3D &node=
2->regex_specs[iter2];
> +
> +                               selinux_log(SELINUX_INFO, "selabel_cmp: m=
ismatch regex right remnant in stem %s entry %u: (%s, %s, %s)\n",
> +                                           fmt_stem(node1->stem),
> +                                           iter2, rspec2->regex_str, fil=
e_kind_to_string(rspec2->file_kind), rspec2->lr.ctx_raw);
>                                 return SELABEL_INCOMPARABLE;
>                         }
>                 }
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index c7fe3a48..2506f9b5 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -61,7 +61,7 @@ struct lookup_result {
>  };
>  #ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
>  extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *=
rec, const char *path);
> -extern int process_text_file(FILE *fp, const char *prefix, struct selabe=
l_handle *rec, const char *path);
> +extern int process_text_file(FILE *fp, const char *prefix, struct selabe=
l_handle *rec, const char *path, uint8_t inputno);
>  extern void free_lookup_result(struct lookup_result *result);
>  extern struct lookup_result *lookup_all(struct selabel_handle *rec, cons=
t char *key, int type, bool partial, bool find_all);
>  extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, cons=
t struct selabel_handle *h2);
> @@ -81,7 +81,9 @@ struct regex_spec {
>         char *regex_str;                        /* original regular expre=
ssion string for diagnostics */
>         struct regex_data *regex;               /* backend dependent regu=
lar expression data */
>         pthread_mutex_t regex_lock;             /* lock for lazy compilat=
ion of regex */
> +       uint32_t lineno;                        /* Line number in source =
file */
>         uint16_t prefix_len;                    /* length of fixed path p=
refix */
> +       uint8_t inputno;                        /* Input number of source=
 file */
>         uint8_t file_kind;                      /* file type */
>         bool regex_compiled;                    /* whether the regex is c=
ompiled */
>         bool any_matches;                       /* whether any pathname m=
atch */
> @@ -123,7 +125,7 @@ struct spec_node {
>         uint32_t literal_specs_num, literal_specs_alloc;
>
>         /*
> -        * Array of regular expression specifications (ordered from most =
to least specific)
> +        * Array of regular expression specifications (order preserved fr=
om input)
>          */
>         struct regex_spec *regex_specs;
>         uint32_t regex_specs_num, regex_specs_alloc;
> @@ -369,38 +371,6 @@ static inline int compare_literal_spec(const void *p=
1, const void *p2)
>         return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->fil=
e_kind);
>  }
>
> -static inline int compare_regex_spec(const void *p1, const void *p2)
> -{
> -       const struct regex_spec *r1 =3D p1;
> -       const struct regex_spec *r2 =3D p2;
> -       size_t regex_len1, regex_len2;
> -       int ret;
> -
> -       /* Order from high prefix length to low */
> -       ret =3D (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r2-=
>prefix_len);
> -       if (ret)
> -               return ret;
> -
> -       /* Order from long total regex length to short */
> -       regex_len1 =3D strlen(r1->regex_str);
> -       regex_len2 =3D strlen(r2->regex_str);
> -       ret =3D (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
> -       if (ret)
> -               return ret;
> -
> -       /*
> -        * Order for no-duplicates check.
> -        * Use reverse alphabetically order to retain the Fedora ordering=
 of
> -        * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
> -        */
> -       ret =3D strcmp(r1->regex_str, r2->regex_str);
> -       if (ret)
> -               return -ret;
> -
> -       /* Order wildcard mode (0) last */
> -       return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->fil=
e_kind);
> -}
> -
>  static inline int compare_spec_node(const void *p1, const void *p2)
>  {
>         const struct spec_node *n1 =3D p1;
> @@ -531,7 +501,7 @@ static inline int compile_regex(struct regex_spec *sp=
ec, const char **errbuf)
>
>  static int insert_spec(const struct selabel_handle *rec, struct saved_da=
ta *data,
>                        const char *prefix, char *regex, uint8_t file_kind=
, char *context,
> -                      const char *path, unsigned int lineno)
> +                      const char *path, uint8_t inputno, uint32_t lineno=
)
>  {
>         size_t prefix_len;
>         bool has_meta;
> @@ -642,6 +612,8 @@ static int insert_spec(const struct selabel_handle *r=
ec, struct saved_data *data
>                         .regex_lock =3D PTHREAD_MUTEX_INITIALIZER,
>                         .file_kind =3D file_kind,
>                         .any_matches =3D false,
> +                       .inputno =3D inputno,
> +                       .lineno =3D lineno,
>                         .lr.ctx_raw =3D context,
>                         .lr.ctx_trans =3D NULL,
>                         .lr.lineno =3D lineno,
> @@ -816,7 +788,8 @@ static inline int next_entry(void *buf, struct mmap_a=
rea *fp, size_t bytes)
>   * utils/sefcontext_compile.c */
>  static inline int process_line(struct selabel_handle *rec,
>                                const char *path, const char *prefix,
> -                              char *line_buf, size_t nread, unsigned lin=
eno)
> +                              char *line_buf, size_t nread,
> +                              uint8_t inputno, uint32_t lineno)
>  {
>         int items;
>         char *regex =3D NULL, *type =3D NULL, *context =3D NULL;
> @@ -886,7 +859,7 @@ static inline int process_line(struct selabel_handle =
*rec,
>                 free(type);
>         }
>
> -       return insert_spec(rec, data, prefix, regex, file_kind, context, =
path, lineno);
> +       return insert_spec(rec, data, prefix, regex, file_kind, context, =
path, inputno, lineno);
>  }
>
>  #endif /* _SELABEL_FILE_H_ */
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index b4445a1f..811b2a1a 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -31,7 +31,7 @@ static int validate_context(char **ctxp)
>
>  static int process_file(struct selabel_handle *rec, const char *filename=
)
>  {
> -       unsigned int line_num;
> +       uint32_t line_num;
>         int rc;
>         char *line_buf =3D NULL;
>         size_t line_len =3D 0;
> @@ -48,7 +48,7 @@ static int process_file(struct selabel_handle *rec, con=
st char *filename)
>         line_num =3D 0;
>         rc =3D 0;
>         while ((nread =3D getline(&line_buf, &line_len, context_file)) > =
0) {
> -               rc =3D process_line(rec, filename, prefix, line_buf, nrea=
d, ++line_num);
> +               rc =3D process_line(rec, filename, prefix, line_buf, nrea=
d, 0, ++line_num);
>                 if (rc || ctx_err) {
>                         /* With -p option need to check and fail if ctx e=
rr as
>                          * process_line() context validation on Linux doe=
s not
> @@ -160,6 +160,7 @@ static int create_sidtab(const struct saved_data *dat=
a, struct sidtab *stab)
>   * Regular Expression Specification Format (RSpec)
>   *
>   * u32     - context table index for raw context (1-based)
> + * u32     - line number in source file
>   * u16     - length of upcoming regex_str INCLUDING nul
>   * [char]  - char array of the original regex string including the stem =
INCLUDING nul
>   * u16     - length of the fixed path prefix
> @@ -307,6 +308,12 @@ static int write_regex_spec(FILE *bin_file, bool do_=
write_precompregex, const st
>         if (len !=3D 1)
>                 return -1;
>
> +       /* write line number */
> +       data_u32 =3D htobe32(rspec->lineno);
> +       len =3D fwrite(&data_u32, sizeof(uint32_t), 1, bin_file);
> +       if (len !=3D 1)
> +               return -1;
> +
>         /* write regex string */
>         regex =3D rspec->regex_str;
>         regex_len =3D strlen(regex);
> --
> 2.45.2
>
>
