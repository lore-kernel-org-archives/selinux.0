Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41D1F7087
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322656; cv=none; b=nSJmEFTCxUc2uGp1m+ww2u0lZ4soOxLHYttcUpLgkIHEG9pujnr72pmFwrETLdeglrQ7xlqENfJnG2LYmIgqDFlpZO/kFqBjwIOw9migPceTQMrm8g0b6cBrVWEnEb6UR9oVeMRa528PEcqZ36/PqilP+Q74fJ1EJrxwyIlYkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322656; c=relaxed/simple;
	bh=Q+hG+hnBAQFWksV26NXVMdh6UDcG/8r/o/e0gu/B2Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNfkQScz9p2jVKrDYxugkqNQSPWgscUBRkW9ZwMiq6xQznnX/CJeROBqeHOAdZYRf5n7xv8h8QT2lVQxJOzQ2lOBf6F/28fnHgXzEVlxpnvcpnz+8/gC3svLXhjgYC8CgduhNyvdVNYfzP5tcAyCw4oobnxWNr+XyjOKhSj6RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJJkZgVi; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJJkZgVi"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d47201b3fso2498862a34.2
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322654; x=1733927454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOZ3tHKGKgdQ3jyWnZGaj85lEWkbnTLZN+TxO+bOkO4=;
        b=WJJkZgViKi3OOlWB+qBh46cMjSPNgxG2mcO9SgGUnb0bS99tQqHCTApxe0M7UvmOe0
         ftGVACdTG1d93mPqsLrhooQUp/3MNklLRKggWwfo8F6w4JRmgrNLuIsTQMXzHRiBQVaP
         NCZrIizkNGGqUe/vCFhdmOwZ6tOjr3Dy3wUOawxiJbDuamz5nar14qnYbXiJ0/rB1+sQ
         yF68ho2z22UV4iEZAdtUBV3SDOE3f3jNbF1LIhi7C9BRjH8BttITGUOUO7oyyBoVpV16
         Z7kQCXmnC9eNt8faMKlcSXMtZbPh2U269Y4Rb3iOfqAe5G/14My9/e1/XfTFGqu1CTfr
         zWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322654; x=1733927454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOZ3tHKGKgdQ3jyWnZGaj85lEWkbnTLZN+TxO+bOkO4=;
        b=WwOpSU9jXZtG6EJjMPszaG806MNf7H02/1fxtx3uHdB5GpvzJjAkhBhV/Yr/8p4o2q
         rDD6KhEPX1Gv9Ri8cW9gqfS/z6tsqEQcVE5+u91KkEnpZbHWHY9FDmM/r88lgGfNMZUB
         X8VNbUe37o+JhF7sGBq76piXPrjhad//wfOocCM2F+OPdGPCPCxpYXMOH7WGqRP2i5Kd
         RnC1xUG41FG40tvGW0cusji/okuB6hrDZLthpM0TG8Bg68Ah5ulW/zDLVS+x/emPcriz
         HPFBKzkJglOp44pk0f5CrecT45qGPjwLKJP7FG+bURMQcFESpdnDd3mESqZqAB1l6BGw
         oGCw==
X-Gm-Message-State: AOJu0YyWq88f5PSYO0uu7v1W8eXQ1BrSOIMJp8wJcgzYTF/DMbZ49TDU
	vOvLb0p/23HXSxImbdpeJu/SrusOqs+/1WTCv9xNT9tuKJWofM7XzVdvgH5WiNVShLE8J4SJXsf
	SJ9PeOFuCiAHGjpgQxrsA3H73jC8=
X-Gm-Gg: ASbGnctd51BJulYXt7vjePoTWvTdhaUTrWOory6Jl6Udd07ZYPWQFbiiFsvg0jL4iOC
	dkMculq11jrsQbjqGUUidbqVtFN8h/jI=
X-Google-Smtp-Source: AGHT+IEtLIJaPnIBwk3Lb7mDL/DgNFgfjRRNMMbQPcv0tho/eJ1DfbQPPanK1qGLPvdPvPdINZrTv/HsuJTaNgnHweA=
X-Received: by 2002:a05:6830:410d:b0:710:f38a:191c with SMTP id
 46e09a7af769-71dad635c18mr5374622a34.11.1733322653665; Wed, 04 Dec 2024
 06:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126102621.20253-1-cgoettsche@seltendoof.de> <CAP+JOzSe-wfPdCXv4OKQ7eaXeH+qP7zDK=LiWp9HAjDW1uNG1Q@mail.gmail.com>
In-Reply-To: <CAP+JOzSe-wfPdCXv4OKQ7eaXeH+qP7zDK=LiWp9HAjDW1uNG1Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:30:43 -0500
Message-ID: <CAP+JOzR3G1cvmZPkAir9uGqhjQfBAFhmV6J1tj-vBAoRrsc95g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] libselinux: avoid memory allocation in common file
 label lookup
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:18=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Nov 26, 2024 at 5:45=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Remove a memory allocation during a common file label lookup,
> > e.g. requested by restorecon(8)/setfiles(8), by using a local stack
> > buffer for a potential lookup result.
> >
> > Additional minor optimization tweaks.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim


> > ---
> > v2: drop claim about this being the sole memory allocation, since
> >     applying a substitution path allocates as well
> > ---
> >  libselinux/src/label_file.c       | 103 +++++++++++++++++-------------
> >  libselinux/src/selinux_internal.h |   8 +++
> >  2 files changed, 68 insertions(+), 43 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 189a5ed2..4e212aa4 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -1467,12 +1467,30 @@ FUZZ_EXTERN void free_lookup_result(struct look=
up_result *result)
> >         }
> >  }
> >
> > -static struct lookup_result *lookup_check_node(struct spec_node *node,=
 const char *key, uint8_t file_kind, bool partial, bool find_all)
> > +/**
> > + * lookup_check_node() - Try to find a file context definition in the =
given node or parents.
> > + * @node:      The deepest specification node to match against. Parent=
 nodes are successively
> > + *             searched on no match or when finding all matches.
> > + * @key:       The absolute file path to look up.
> > + * @file_kind: The kind of the file to look up (translated from file t=
ype into LABEL_FILE_KIND_*).
> > + * @partial:   Whether to partially match the given file path or compl=
etely.
> > + * @find_all:  Whether to find all file context definitions or just th=
e most specific.
> > + * @buf:       A pre-allocated buffer for a potential result to avoid =
allocating it on the heap or
> > + *             NULL. Mututal exclusive with @find_all.
> > + *
> > + * Return: A pointer to a file context definition if a match was found=
. If @find_all was specified
> > + *         its a linked list of all results. If @buf was specified it =
is returned on a match found.
> > + *         NULL is returned in case of no match found.
> > + */
> > +static struct lookup_result *lookup_check_node(struct spec_node *node,=
 const char *key, uint8_t file_kind,
> > +                                              bool partial, bool find_=
all, struct lookup_result *buf)
> >  {
> >         struct lookup_result *result =3D NULL;
> >         struct lookup_result **next =3D &result;
> >         size_t key_len =3D strlen(key);
> >
> > +       assert(!(find_all && buf !=3D NULL));
> > +
> >         for (struct spec_node *n =3D node; n; n =3D n->parent) {
> >
> >                 uint32_t literal_idx =3D search_literal_spec(n->literal=
_specs, n->literal_specs_num, key, key_len, partial);
> > @@ -1495,10 +1513,14 @@ static struct lookup_result *lookup_check_node(=
struct spec_node *node, const cha
> >                                                 return NULL;
> >                                         }
> >
> > -                                       r =3D malloc(sizeof(*r));
> > -                                       if (!r) {
> > -                                               free_lookup_result(resu=
lt);
> > -                                               return NULL;
> > +                                       if (likely(buf)) {
> > +                                               r =3D buf;
> > +                                       } else {
> > +                                               r =3D malloc(sizeof(*r)=
);
> > +                                               if (!r) {
> > +                                                       free_lookup_res=
ult(result);
> > +                                                       return NULL;
> > +                                               }
> >                                         }
> >
> >                                         *r =3D (struct lookup_result) {
> > @@ -1510,11 +1532,11 @@ static struct lookup_result *lookup_check_node(=
struct spec_node *node, const cha
> >                                                 .next =3D NULL,
> >                                         };
> >
> > +                                       if (likely(!find_all))
> > +                                               return r;
> > +
> >                                         *next =3D r;
> >                                         next =3D &r->next;
> > -
> > -                                       if (!find_all)
> > -                                               return result;
> >                                 }
> >
> >                                 literal_idx++;
> > @@ -1556,10 +1578,14 @@ static struct lookup_result *lookup_check_node(=
struct spec_node *node, const cha
> >                                         return NULL;
> >                                 }
> >
> > -                               r =3D malloc(sizeof(*r));
> > -                               if (!r) {
> > -                                       free_lookup_result(result);
> > -                                       return NULL;
> > +                               if (likely(buf)) {
> > +                                       r =3D buf;
> > +                               } else {
> > +                                       r =3D malloc(sizeof(*r));
> > +                                       if (!r) {
> > +                                               free_lookup_result(resu=
lt);
> > +                                               return NULL;
> > +                                       }
> >                                 }
> >
> >                                 *r =3D (struct lookup_result) {
> > @@ -1571,12 +1597,12 @@ static struct lookup_result *lookup_check_node(=
struct spec_node *node, const cha
> >                                         .next =3D NULL,
> >                                 };
> >
> > +                               if (likely(!find_all))
> > +                                       return r;
> > +
> >                                 *next =3D r;
> >                                 next =3D &r->next;
> >
> > -                               if (!find_all)
> > -                                       return result;
> > -
> >                                 continue;
> >                         }
> >
> > @@ -1692,7 +1718,8 @@ FUZZ_EXTERN struct lookup_result *lookup_all(stru=
ct selabel_handle *rec,
> >                                  const char *key,
> >                                  int type,
> >                                  bool partial,
> > -                                bool find_all)
> > +                                bool find_all,
> > +                                struct lookup_result *buf)
> >  {
> >         struct saved_data *data =3D (struct saved_data *)rec->data;
> >         struct lookup_result *result =3D NULL;
> > @@ -1704,18 +1731,18 @@ FUZZ_EXTERN struct lookup_result *lookup_all(st=
ruct selabel_handle *rec,
> >         unsigned int sofar =3D 0;
> >         char *sub =3D NULL;
> >
> > -       if (!key) {
> > +       if (unlikely(!key)) {
> >                 errno =3D EINVAL;
> >                 goto finish;
> >         }
> >
> > -       if (!data->num_specs) {
> > +       if (unlikely(!data->num_specs)) {
> >                 errno =3D ENOENT;
> >                 goto finish;
> >         }
> >
> >         /* Remove duplicate slashes */
> > -       if ((next_slash =3D strstr(key, "//"))) {
> > +       if (unlikely(next_slash =3D strstr(key, "//"))) {
> >                 clean_key =3D (char *) malloc(strlen(key) + 1);
> >                 if (!clean_key)
> >                         goto finish;
> > @@ -1732,12 +1759,12 @@ FUZZ_EXTERN struct lookup_result *lookup_all(st=
ruct selabel_handle *rec,
> >
> >         /* remove trailing slash */
> >         len =3D strlen(key);
> > -       if (len =3D=3D 0) {
> > +       if (unlikely(len =3D=3D 0)) {
> >                 errno =3D EINVAL;
> >                 goto finish;
> >         }
> >
> > -       if (len > 1 && key[len - 1] =3D=3D '/') {
> > +       if (unlikely(len > 1 && key[len - 1] =3D=3D '/')) {
> >                 /* reuse clean_key from above if available */
> >                 if (!clean_key) {
> >                         clean_key =3D (char *) malloc(len);
> > @@ -1757,7 +1784,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(stru=
ct selabel_handle *rec,
> >
> >         node =3D lookup_find_deepest_node(data->root, key);
> >
> > -       result =3D lookup_check_node(node, key, file_kind, partial, fin=
d_all);
> > +       result =3D lookup_check_node(node, key, file_kind, partial, fin=
d_all, buf);
> >
> >  finish:
> >         free(clean_key);
> > @@ -1768,14 +1795,9 @@ finish:
> >  static struct lookup_result *lookup_common(struct selabel_handle *rec,
> >                                            const char *key,
> >                                            int type,
> > -                                          bool partial) {
> > -       struct lookup_result *result =3D lookup_all(rec, key, type, par=
tial, false);
> > -       if (!result)
> > -               return NULL;
> > -
> > -       free_lookup_result(result->next);
> > -       result->next =3D NULL;
> > -       return result;
> > +                                          bool partial,
> > +                                          struct lookup_result *buf) {
> > +       return lookup_all(rec, key, type, partial, false, buf);
> >  }
> >
> >  /*
> > @@ -1835,7 +1857,7 @@ static bool hash_all_partial_matches(struct selab=
el_handle *rec, const char *key
> >  {
> >         assert(digest);
> >
> > -       struct lookup_result *matches =3D lookup_all(rec, key, 0, true,=
 true);
> > +       struct lookup_result *matches =3D lookup_all(rec, key, 0, true,=
 true, NULL);
> >         if (!matches) {
> >                 return false;
> >         }
> > @@ -1864,25 +1886,20 @@ static bool hash_all_partial_matches(struct sel=
abel_handle *rec, const char *key
> >  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> >                                          const char *key, int type)
> >  {
> > -       struct lookup_result *result;
> > -       struct selabel_lookup_rec *lookup_result;
> > +       struct lookup_result buf, *result;
> >
> > -       result =3D lookup_common(rec, key, type, false);
> > +       result =3D lookup_common(rec, key, type, false, &buf);
> >         if (!result)
> >                 return NULL;
> >
> > -       lookup_result =3D result->lr;
> > -       free_lookup_result(result);
> > -       return lookup_result;
> > +       return result->lr;
> >  }
> >
> >  static bool partial_match(struct selabel_handle *rec, const char *key)
> >  {
> > -       struct lookup_result *result =3D lookup_common(rec, key, 0, tru=
e);
> > -       bool ret =3D result;
> > +       struct lookup_result buf;
> >
> > -       free_lookup_result(result);
> > -       return ret;
> > +       return !!lookup_common(rec, key, 0, true, &buf);
> >  }
> >
> >  static struct selabel_lookup_rec *lookup_best_match(struct selabel_han=
dle *rec,
> > @@ -1904,7 +1921,7 @@ static struct selabel_lookup_rec *lookup_best_mat=
ch(struct selabel_handle *rec,
> >         results =3D calloc(n+1, sizeof(*results));
> >         if (!results)
> >                 return NULL;
> > -       results[0] =3D lookup_common(rec, key, type, false);
> > +       results[0] =3D lookup_common(rec, key, type, false, NULL);
> >         if (results[0]) {
> >                 if (!results[0]->has_meta_chars) {
> >                         /* exact match on key */
> > @@ -1915,7 +1932,7 @@ static struct selabel_lookup_rec *lookup_best_mat=
ch(struct selabel_handle *rec,
> >                 prefix_len =3D results[0]->prefix_len;
> >         }
> >         for (i =3D 1; i <=3D n; i++) {
> > -               results[i] =3D lookup_common(rec, aliases[i-1], type, f=
alse);
> > +               results[i] =3D lookup_common(rec, aliases[i-1], type, f=
alse, NULL);
> >                 if (results[i]) {
> >                         if (!results[i]->has_meta_chars) {
> >                                 /* exact match on alias */
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 372837dd..964b8418 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -142,4 +142,12 @@ static inline void fclose_errno_safe(FILE *stream)
> >         errno =3D saved_errno;
> >  }
> >
> > +#ifdef __GNUC__
> > +# define likely(x)                     __builtin_expect(!!(x), 1)
> > +# define unlikely(x)                   __builtin_expect(!!(x), 0)
> > +#else
> > +# define likely(x)                     (x)
> > +# define unlikely(x)                   (x)
> > +#endif /* __GNUC__ */
> > +
> >  #endif /* SELINUX_INTERNAL_H_ */
> > --
> > 2.45.2
> >
> >
