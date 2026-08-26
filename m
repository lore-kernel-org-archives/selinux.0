Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144B46EC8B
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766870; cv=pass; b=ayGzHs2dUVpumapiUQW9bb/rWxMJ2LlkcKaw6IGYZO3FfpvRTdajwtBud3DjLGFoHWKKwMbNCh5lC7nf5PUlRY6qDfXI4B0NEbLN6x3bDHCT32vkrqykfqu8kiLe7voPEbdyCcVsOVWG3+zsAqn+ok6qpc0Db6Qh61vC7t84Hks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766870; c=relaxed/simple;
	bh=4FkLuy9ScJjucdoQz26Xnd0IsoX3yntczhyE2O+tjmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDXl/TQd3KmSZ6D4LbJXNTaaxFJ0bAcWYh8ftSFeRbU57bpgoMT2BpJxEWpWa7wb8NtdlTGfdFeyvTQjot0yokZ3Oq7cpagxjQh3NXaOqXwxkyAQoRGTtV4vlDp7/IGNpWXlFlJCJhiL5GZsndII9w0oKKT5ytIKkgvrgJKTNtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO6z3tqx; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO6z3tqx"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b4afc8465eso295687e87.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 10:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787766842; cv=none;
        d=google.com; s=arc-20260327;
        b=Rq0cJmDcwWpZmf7JfK6wukUA89rAWa2I22MgePCdWg3F6mr+rrhbF2ski9hXHyIfTE
         wWHE6scTSHiF/q7idxlJ/10lRT6W71JCULnQjdT0Oj9+46/rTm3fjEwh0opo4wZkfIsN
         uTPvgxCnDWEbDUREUIoH+Omwz4IYxp8KrPDtrKVBVMY+RXo3HL8oqlUBStg+5Y5kYgkd
         D4HZXUBUAw8eZj/rKRJ/MXsOm6HPpP6IwASlJEl0fpWcJrF7gj9qUvVvveh5FVPzDXtR
         EQP+B+f/R2ZgjQc49qYRuasts/QSoIUHLeqfEaZ9eN+68/wXVSAeIy7miyzsI3yGrmwI
         xHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wTCeuDiL2E0bHOLY3P9KMSQElejnq6pUhgDGaq1yVs8=;
        fh=p/vpgII7nnWP4e09DvPdpCHWrNFIrvv7En2SfKVYZq8=;
        b=PEGpvZjIvtqUkDbaJKGmiJHcsBF9aDQXoG2ziXifD12npTPV8aZft/7K2i0eQUbI+c
         E7noWpggHfPiqBh37NoXKtGTVuRADkb201oF4G1ePfFlqfXCeSL3F905P4VTgM6Xy9sm
         UXCWXibpfIgMfhVLXajRqnz7rl2z4pG+q7mna9YXcQs665Y65GuexQgdFFaejDbqc5QG
         WApGafWnyiUKZfmUZ5DdLKQcMvA+oSs3M9lo3TUoNL5Y3VotaTiOsF/UJrGKH6nUTnGG
         ptO+UgVMQzbhNfmeY+EPnR/QCYVzvDBU8hcpwntMoBs2XqnsdELRlmD5YOo46we9Zeob
         KOuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766842; x=1788371642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wTCeuDiL2E0bHOLY3P9KMSQElejnq6pUhgDGaq1yVs8=;
        b=lO6z3tqxus9TgW9HM0Q2yOTXSoQi52/QQrQ0p03dRJ7VpPoOLcqP85Yr9ay0IJhUIW
         h6GtPT5oCvu71ZQ9TGldGh8nB7nPHnV+L9/qx43s2ZVugNoa8KvYVOJkdh3yTLyYbFIt
         /Z8+JpGTrkhN/4Enjzpf5djtOE+vI5rIcj2PDz7Y06SMCA6f6PqPG/SJBU2R2Jzb7loy
         SVdw/L1vTwRaxiM0O8OBPVvFaMga365PPM8RCjmVR+VhBpUEXA15fGLG9rUdJxRtC6m1
         fKsGv7swupY9x9QRJBh63yr/1C++3oiFolL6lXjMHh6d6C+SmWe6UllATf9Woleiilea
         mlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766842; x=1788371642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTCeuDiL2E0bHOLY3P9KMSQElejnq6pUhgDGaq1yVs8=;
        b=kiP17fplPl02TrDXaU9BDKQ0BkC+yhOIw4iWPzr9zYQuBGTvOVZQWHtacr6daw2fD7
         heCj6SMRN7HE4W2JiDXB7lShQDKOGhFADKO3RBGO6rLjdDHl0oQELxs1QJTEwoXA9lY0
         MeC+cXwuLxGn+1ok43E9lQeorOJxc6JX+3mikxf19lD3f5sMKFrvpczYWmhVBpQJxagv
         QqdZ5We2KECiErT0d2Duu+r2rIWUB3Qwv9SLzxQceqp22iUwOePYbkEe5C3sVOJa4dae
         +0YCr9B/HStFcr+bkLjGYTpzWSnE/xcKQCr34Ewyo0sVSvSmsLQzTdcIvpQvBNCwmDsh
         1BTg==
X-Gm-Message-State: AFuF++nDPtAboD8CWSTWUyJHcXthoHYIwoHOu41jXEomp575C0g71N0v
	kNwsmUcF+0HT5m51KbyRQT1IMUPZIQY8l/DXW1s/Y2Ni7NIAnel5PQs49FdETanVn4HQvSIBs9J
	M6A2hmTcjX4xtqLIScCJVIDAvwIRNwmCBpG1/
X-Gm-Gg: AR+sD10MllbiUWb+CEG850UDbx3rerktsyPGxnS+XpyLTsyiqfE3u0aueU53Wcuc+wU
	82GIasrvPQb04qzgErbDytoC3eNIs2K9YWCytNIAWmh0Xf71KqP5ZIOPWyM6dyl29Nt9RDDeBUg
	6oW6naUP1hqYgqepoTFjgJ2nw2MBb2C3k53zexqxsqIcGxeTn1UGB6ZFJ41BEG2qDni4VYtnSZY
	igKJ6w5TZXRPYkotwLMnJCXsDFyw8yJ014wYWhHxeHrNQPjCy6NSk8dc4/7gzji5QLGcMZY29LX
	tzmr+CSiKQqakmKC5bq+fYdzZjQ+v0uGpfGWpsF/7A==
X-Received: by 2002:a05:651c:2108:b0:39a:da70:2c77 with SMTP id
 38308e7fff4ca-3a1fd5ab5a0mr22881291fa.3.1787766841602; Wed, 26 Aug 2026
 10:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824191442.77835-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260824191442.77835-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 26 Aug 2026 13:53:50 -0400
X-Gm-Features: AcwNN1VoApRfAue0uKuqOUMY1M7eXf_iHMwUcWF-ndUdbNJ0Om0SZ4oopYLHjt8
Message-ID: <CAP+JOzQnHp8Z5_jwjAe9eRFWKqR=UvfEzewyHKDdZYmduPHkGA@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: label_file: make JIT compilation opt-in
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, p.matyas13@gmail.com, pmatyas@redhat.com, 
	tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Commit 92af7f1b61db6e ("libselinux: prevent ReDoS in file context
> regex matching") introduced the use of pcre2_jit_compile() after every
> pattern compilation to leverage JIT for regex matching to help
> mitigate catastrophic backtracking on crafted file context regexes or
> lookup keys. This triggers SELinux execmem permission checks on every
> caller of selabel_open(SELABEL_CTX_FILE, ..). Permission denial is
> non-fatal in this case but allowing this permission may be undesirable
> for some callers and will produce audit log noise for others. Further,
> the JITed matching itself is subject to stack overflow on crafted
> regexes. Make the JIT compilation opt-in rather than automatic via a
> new SELABEL_OPT_JIT option for selabel_open() so that we do not impact
> existing callers while allowing callers to selectively opt in when
> they want this behavior and run in a context that can be allowed
> execmem without concern.
>
> Link: https://lore.kernel.org/selinux/20260729131413.1390890-1-pmatyas@re=
dhat.com/
> Link: https://lore.kernel.org/selinux/CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW8b=
FEJ6NCXWerrSvvYA@mail.gmail.com/
> Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex mat=
ching")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v3 fixes a missing trailing __ for __attribute and drops the unrelated ch=
ange
> to sefcontext_compile.c.
>
>  libselinux/include/selinux/label.h |  4 +++-
>  libselinux/man/man3/selabel_open.3 |  7 +++++++
>  libselinux/src/label.c             | 13 ++++++++++++
>  libselinux/src/label_file.c        | 32 ++++++++++++++++++------------
>  libselinux/src/label_file.h        |  6 +++---
>  libselinux/src/label_internal.h    |  2 ++
>  libselinux/src/regex.c             | 16 +++++++++------
>  libselinux/src/regex.h             |  6 ++++--
>  8 files changed, 61 insertions(+), 25 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index bde2501f..10e3a718 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -59,8 +59,10 @@ struct selabel_handle;
>  #define SELABEL_OPT_SUBSET 4
>  /* require a hash calculation on spec files */
>  #define SELABEL_OPT_DIGEST 5
> +/* enable JIT compilation of regexes */
> +#define SELABEL_OPT_JIT 6
>  /* total number of options */
> -#define SELABEL_NOPT 6
> +#define SELABEL_NOPT 7
>
>  /*
>   * Label operations
> diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/sel=
abel_open.3
> index 0e03e1be..fa71d27c 100644
> --- a/libselinux/man/man3/selabel_open.3
> +++ b/libselinux/man/man3/selabel_open.3
> @@ -73,6 +73,13 @@ A non-null value for this option enables the generatio=
n of an SHA1 digest of
>  the spec files loaded as described in
>  .BR selabel_digest (3)
>  .
> +.TP
> +.B SELABEL_OPT_JIT
> +A non-null value for this option enables the JIT compilation of regexes
> +read from the spec files. This option is only currently supported with
> +the
> +.B SELABEL_CTX_FILE
> +backend.
>  .SH "BACKENDS"
>  .TP
>  .B SELABEL_CTX_FILE
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 4a97d3bc..93848bfe 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -155,6 +155,18 @@ int selabel_validate(struct selabel_lookup_rec *cont=
exts)
>         return 0;
>  }
>
> +/* Should we enable JIT compilation? */
> +static inline int selabel_is_jit_set(const struct selinux_opt *opts, uns=
igned n)
> +{
> +       while (n) {
> +               n--;
> +               if (opts[n].type =3D=3D SELABEL_OPT_JIT)
> +                       return !!opts[n].value;
> +       }
> +
> +       return 0;
> +}
> +
>  /* Public API helpers */
>  static int selabel_fini(const struct selabel_handle *rec,
>                         struct selabel_lookup_rec *lr, bool translating)
> @@ -261,6 +273,7 @@ struct selabel_handle *selabel_open(unsigned int back=
end,
>
>         rec->backend =3D backend;
>         rec->validating =3D selabel_is_validate_set(opts, nopts);
> +       rec->jit =3D selabel_is_jit_set(opts, nopts);
>
>         rec->digest =3D selabel_is_digest_set(opts, nopts);
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index d716e0f1..ce14e63d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -633,8 +633,8 @@ static int load_mmap_literal_spec(struct mmap_area *m=
map_area, bool validating,
>  }
>
>  static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool valida=
ting,
> -                               bool do_load_precompregex, uint8_t inputn=
o,
> -                               struct regex_spec *rspec,
> +                               bool jit, bool do_load_precompregex,
> +                               uint8_t inputno, struct regex_spec *rspec=
,
>                                 const struct context_array *ctx_array)
>  {
>         uint32_t data_u32, ctx_id, lineno;
> @@ -723,7 +723,7 @@ static int load_mmap_regex_spec(struct mmap_area *mma=
p_area, bool validating,
>          * Read pcre regex related data
>          */
>         rc =3D regex_load_mmap(mmap_area, &rspec->regex, do_load_precompr=
egex,
> -                            &rspec->regex_compiled);
> +                            jit, &rspec->regex_compiled);
>         if (rc < 0)
>                 return -1;
>
> @@ -733,7 +733,8 @@ static int load_mmap_regex_spec(struct mmap_area *mma=
p_area, bool validating,
>  }
>
>  static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *=
path,
> -                              bool validating, bool do_load_precompregex=
,
> +                              bool validating, bool jit,
> +                              bool do_load_precompregex,
>                                struct spec_node *node, const unsigned dep=
th,
>                                uint8_t inputno,
>                                const struct context_array *ctx_array)
> @@ -840,7 +841,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path,
>                 node->regex_specs_alloc =3D rspec_num;
>
>                 for (uint32_t i =3D 0; i < rspec_num; i++) {
> -                       rc =3D load_mmap_regex_spec(mmap_area, validating=
,
> +                       rc =3D load_mmap_regex_spec(mmap_area, validating=
, jit,
>                                                   do_load_precompregex, i=
nputno,
>                                                   &node->regex_specs[i],
>                                                   ctx_array);
> @@ -876,7 +877,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path,
>
>                 for (uint32_t i =3D 0; i < children_num; i++) {
>                         rc =3D load_mmap_spec_node(mmap_area, path, valid=
ating,
> -                                                do_load_precompregex,
> +                                                jit, do_load_precomprege=
x,
>                                                  &node->children[i], dept=
h + 1,
>                                                  inputno, ctx_array);
>                         if (rc)
> @@ -1064,7 +1065,7 @@ end_arch_check:
>         if (!root)
>                 goto err;
>
> -       rc =3D load_mmap_spec_node(mmap_area, path, rec->validating,
> +       rc =3D load_mmap_spec_node(mmap_area, path, rec->validating, rec-=
>jit,
>                                  reg_version_matches && reg_arch_matches,=
 root,
>                                  0, inputno, &ctx_array);
>         if (rc)
> @@ -1538,6 +1539,7 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
>                 case SELABEL_OPT_UNUSED:
>                 case SELABEL_OPT_VALIDATE:
>                 case SELABEL_OPT_DIGEST:
> +               case SELABEL_OPT_JIT:
>                         break;
>                 default:
>                         errno =3D EINVAL;
> @@ -1890,6 +1892,7 @@ fail:
>   * @file_kind: The kind of the file to look up (translated from file typ=
e into LABEL_FILE_KIND_*).
>   * @partial:   Whether to partially match the given file path or complet=
ely.
>   * @find_all:  Whether to find all file context definitions or just the =
most specific.
> + * @jit:       Whether to enable JIT compilation of regexes.
>   * @buf:       A pre-allocated buffer for a potential result to avoid al=
locating it on the heap or
>   *             NULL. Mutual exclusive with @find_all.
>   *
> @@ -1897,9 +1900,11 @@ fail:
>   *         its a linked list of all results. If @buf was specified it is=
 returned on a match found.
>   *         NULL is returned in case of no match found.
>   */
> -static struct lookup_result *
> -lookup_check_node(struct spec_node *node, const char *key, uint8_t file_=
kind,
> -                 bool partial, bool find_all, struct lookup_result *buf)
> +static struct lookup_result *lookup_check_node(struct spec_node *node,
> +                                              const char *key,
> +                                              uint8_t file_kind, bool pa=
rtial,
> +                                              bool find_all, bool jit,
> +                                              struct lookup_result *buf)
>  {
>         struct lookup_result *result =3D NULL;
>         struct lookup_result **next =3D &result;
> @@ -2002,7 +2007,8 @@ lookup_check_node(struct spec_node *node, const cha=
r *key, uint8_t file_kind,
>                             file_kind !=3D rspec->file_kind)
>                                 continue;
>
> -                       if (compile_regex(rspec, errbuf, sizeof(errbuf)) =
< 0) {
> +                       if (compile_regex(rspec, errbuf, sizeof(errbuf), =
jit) <
> +                           0) {
>                                 COMPAT_LOG(
>                                         SELINUX_ERROR,
>                                         "Failed to compile regular expres=
sion '%s':  %s\n",
> @@ -2274,8 +2280,8 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct=
 selabel_handle *rec,
>
>         node =3D lookup_find_deepest_node(data->root, key, &rest_key);
>
> -       result =3D
> -               lookup_check_node(node, key, file_kind, partial, find_all=
, buf);
> +       result =3D lookup_check_node(node, key, file_kind, partial, find_=
all,
> +                                  rec->jit, buf);
>
>         /* For partial lookup if the key matches a child node, recursivel=
y add all specs */
>         if (partial && rest_key) {
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 3be15f25..acfe2e0d 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -398,7 +398,7 @@ static inline void sort_specs(struct saved_data *data=
)
>  }
>
>  static int compile_regex(struct regex_spec *spec, char *errbuf,
> -                        size_t errbuf_size)
> +                        size_t errbuf_size, bool jit)
>  {
>         const char *reg_buf;
>         char *anchored_regex, *cp;
> @@ -473,7 +473,7 @@ static int compile_regex(struct regex_spec *spec, cha=
r *errbuf,
>         *cp =3D '\0';
>
>         /* Compile the regular expression. */
> -       rc =3D regex_prepare_data(&spec->regex, anchored_regex, &error_da=
ta);
> +       rc =3D regex_prepare_data(&spec->regex, anchored_regex, &error_da=
ta, jit);
>         free(anchored_regex);
>         if (rc < 0) {
>                 regex_format_error(&error_data, errbuf, errbuf_size);
> @@ -655,7 +655,7 @@ static int insert_spec(const struct selabel_handle *r=
ec,
>                         char errbuf[256];
>
>                         if (compile_regex(&node->regex_specs[id], errbuf,
> -                                         sizeof(errbuf))) {
> +                                         sizeof(errbuf), rec->jit)) {
>                                 COMPAT_LOG(
>                                         SELINUX_ERROR,
>                                         "%s:  line %u has invalid regex %=
s:  %s\n",
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 4279637e..47c5d3cb 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -11,6 +11,7 @@
>  #include <stdlib.h>
>  #include <stdarg.h>
>  #include <stdio.h>
> +#include <stdbool.h>
>  #include <selinux/selinux.h>
>  #include <selinux/label.h>
>  #include "sha1.h"
> @@ -73,6 +74,7 @@ struct selabel_handle {
>         /* arguments that were passed to selabel_open */
>         unsigned int backend;
>         int validating;
> +       bool jit;
>
>         /* labeling operations */
>         struct selabel_lookup_rec *(*func_lookup)(struct selabel_handle *=
h,
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 017647b4..d6b5bf02 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -87,7 +87,7 @@ struct regex_data {
>  };
>
>  int regex_prepare_data(struct regex_data **regex, char const *pattern_st=
ring,
> -                      struct regex_error_data *errordata)
> +                      struct regex_error_data *errordata, bool jit)
>  {
>         memset(errordata, 0, sizeof(struct regex_error_data));
>
> @@ -108,7 +108,8 @@ int regex_prepare_data(struct regex_data **regex, cha=
r const *pattern_string,
>          * susceptibility to catastrophic backtracking. Partial matches f=
all
>          * back to the interpreter, protected by the match limit. Failure=
s
>          * are non-fatal. */
> -       (void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
> +       if (jit)
> +               (void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLE=
TE);
>
>         return 0;
>
> @@ -130,7 +131,7 @@ char const *regex_version(void)
>  }
>
>  int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **reg=
ex,
> -                   int do_load_precompregex, bool *regex_compiled)
> +                   int do_load_precompregex, bool jit, bool *regex_compi=
led)
>  {
>         int rc;
>         uint32_t data_u32, entry_len;
> @@ -164,7 +165,9 @@ int regex_load_mmap(struct mmap_area *mmap_area, stru=
ct regex_data **regex,
>                 if (rc !=3D 1)
>                         goto err;
>
> -               (void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLE=
TE);
> +               if (jit)
> +                       (void)pcre2_jit_compile((*regex)->regex,
> +                                               PCRE2_JIT_COMPLETE);
>
>                 *regex_compiled =3D true;
>         }
> @@ -367,7 +370,8 @@ struct regex_data {
>  };
>
>  int regex_prepare_data(struct regex_data **regex, char const *pattern_st=
ring,
> -                      struct regex_error_data *errordata)
> +                      struct regex_error_data *errordata,
> +                      bool jit __attribute__((unused)))
>  {
>         memset(errordata, 0, sizeof(struct regex_error_data));
>
> @@ -402,7 +406,7 @@ char const *regex_version(void)
>
>  int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **reg=
ex,
>                     int do_load_precompregex __attribute__((unused)),
> -                   bool *regex_compiled)
> +                   bool jit __attribute__((unused)), bool *regex_compile=
d)
>  {
>         int rc;
>         uint32_t data_u32, entry_len;
> diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
> index 0eea2803..4cda7bfc 100644
> --- a/libselinux/src/regex.h
> +++ b/libselinux/src/regex.h
> @@ -78,11 +78,12 @@ void regex_data_free(struct regex_data *regex);
>   *                to this function. This structure depends on the underl=
ying
>   *                implementation. It can be passed to regex_format_error
>   *                to generate a human readable error message.
> + * @arg jit A boolean indicating whether JIT compilation should be perfo=
rmed.
>   * @retval 0 on success
>   * @retval -1 on error
>   */
>  int regex_prepare_data(struct regex_data **regex, char const *pattern_st=
ring,
> -                      struct regex_error_data *errordata);
> +                      struct regex_error_data *errordata, bool jit);
>  /**
>   * This function loads a serialized precompiled pattern from a contiguou=
s
>   * data region given by map_area.
> @@ -93,6 +94,7 @@ int regex_prepare_data(struct regex_data **regex, char =
const *pattern_string,
>   *            with regex_data_create and must be freed with regex_data_f=
ree.
>   * @arg do_load_precompregex If non-zero precompiled patterns get loaded=
 from
>   *                          the mmap region (ignored by PCRE1 back-end).
> + * @arg jit A boolean indicating whether JIT compilation should be perfo=
rmed.
>   * @arg regex_compiled Set to true if a precompiled pattern was loaded
>   *                    into regex, otherwise set to false to indicate lat=
er
>   *                    compilation must occur
> @@ -101,7 +103,7 @@ int regex_prepare_data(struct regex_data **regex, cha=
r const *pattern_string,
>   * @retval -1 on error
>   */
>  int regex_load_mmap(struct mmap_area *map_area, struct regex_data **rege=
x,
> -                   int do_load_precompregex, bool *regex_compiled);
> +                   int do_load_precompregex, bool jit, bool *regex_compi=
led);
>  /**
>   * This function stores a precompiled regular expression to a file.
>   * In the case of PCRE, it just dumps the binary representation of the
> --
> 2.55.0
>
