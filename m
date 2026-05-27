Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895E364032
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908873; cv=pass; b=GPEtnhslEijs1cd6BmtlnVU/VwJ5X66VSojpm600xYkpYGhmtAJ4pq54pJpk6gzERoKu//ufNB2V4+DvL5jxGIRJa5ULRHCVzmiDSAE2yb1ywoY1/0V7rVM2thIrhQDvD/ai4ouOIhXQfhhAksV4+UP6lhjHhW+WCgxQYPPWXMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908873; c=relaxed/simple;
	bh=5XsCz2ifalNYZU7kbRMEVJP5kyXYlolsQ7mi6tMwLuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeqHTttWZuEYlXlGfn4sgJomHTKneu1AGXWZ2PaxwA7H0p8lwLy1iSDCl96tzo0Kvgfi21SKkCIqaD1fXjE9Ct81FS2cOgiJBxhDoCzLhfrTVYLt+uR2DNe9bCLnylu5VBBcWcVhcTD0uLNF+Vv6BpC4q6SBMnoKTK23q/OUqVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suzQEof6; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suzQEof6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf008a99d4so1614905ad.2
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908871; cv=none;
        d=google.com; s=arc-20240605;
        b=asDKeHKsh/gSAUVSYhE2lYf5Pip8R7hzE9c42d6hLfGbxuOnt4YgGduK4XJnQNinIF
         YxIhaJZybRJ3lDJ9AvepDRKw1Xops30gm8jq/nrQcqZXsZMBiCNcnrCp7DPp6omXo+WD
         V/p4qtsAdyAZoyPbSHKNJAoNkZH9tSypvmu1QEjaggFUcaRIQDnwCygjeOiLG2CYdLxL
         dBFO/ztDOFyp86FA1d8XgtoJvoBK7H5KEVrJEwXpu5lrJkmDdWTy/bJENYVOo5zS1Q2X
         9LYSSw6SVkq5nVWAsHIsTBdO/WEvJXdxN7i+JNk5zISGw5sIEnbwFiwCw2vloA7f9L2g
         OyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nzT+kobL0eG6Wps+8hh2RYOhfnLEzZCjkURWvZc4UFY=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=geCJ3JQAAJ8Ivf9rU1qO3H6BvMJqaIBzFZfulYIN4kBRwF0rMxoco7Qg3X6EJLc4uc
         1V5PcOwFomSXKQqHYj8gaRVK69umuZZs3FIIoznlIfZ8oVGrztv9yWzQ207ooAmAnBuG
         QSR9eNHHYQGMEmK2p6xOnZt6GLTJq3A2PFZOb2Fhv/BkIsBb6gLblNB9SNUOEMmE+h9Z
         eqvkSxGl6GnJi1KmXLCcYS7wSKDaAAH2ok7xSYKC+SPcJ9IwrmfBohToZp4f5tGKoapt
         0P4jqd10C8SETKGDLt8JaE1umVsdoQ9Pn2GG3x5ZS2rAFhkDzulq/IivlRT6/ibaAL9Z
         m4tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779908871; x=1780513671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzT+kobL0eG6Wps+8hh2RYOhfnLEzZCjkURWvZc4UFY=;
        b=suzQEof6/WXTZsMc/X4MiBaWRuAxn5nQ+m44rXx6y1EQvvwrAeFtTTtJeoW4gJBXr8
         Z4QCsOxxBKV1xVVSfAteEOOG4TMVDxNieasuWFo9vn3H1jQ7i4qv6ptkkEXZpgWIfEKl
         liQO5a0SP1Z8xXqyhhb7VUC3LIgpW7jr3BnVzwvkhw4n+hjVDCGmuSiNr0UfNVvCRLyc
         uJs0X3JnE+CyqEVeOh1pnlBHCiCvkckYSv+RRs8UMYUUlOQr8E9GnsnRwwx82XrhGpFl
         cNNcZnWrqtX9MTFA4rCyu4G1z05ZOlC511uXXa8EtXDNaj0tebPQxZzvNzcfQDrWkWA+
         4xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908871; x=1780513671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzT+kobL0eG6Wps+8hh2RYOhfnLEzZCjkURWvZc4UFY=;
        b=iNX2E9WduGV6asQN1/BPyyMumRspJPD6kz/LpOYVZNLfFGP+0DxQCS9xCqdsiwf58F
         qgpDgFhopyXXzexwqMbRHzQ2o7t2ymf4/58J5W16oKN2cqkWpiVIhK1SZchO+n6fjZ89
         UcuM8EWOGhxUsMT9cNyRO078C2MsHElnOW/Hl8cHEA4B773Db0sW8WuNlsA6kNXbLm5M
         sTbnpkFRF1ns51cC/C/oAKrbrNFCOsg/tWFIiAeFJucek7gO9GB8FNlDgLtqyTa6PhYr
         Fl+s+ieJPyVs+FefuOjjcdNM2u0VDYJu3k8ZG8S592Vkqq1gt8x7CL8p4Jj3MyORpj37
         XoKg==
X-Gm-Message-State: AOJu0Ywolw8kSVXj8VSjNKVSR9n9VO7qL+4rbVSjjfKpZHZ9Vhj5+G+m
	RjZVVFMUDuk01s3IaIOoZY1GyQGYQlRNH4nqKyZ1J6jCHGYAad/a96cFXSNaYkIbS5NGryC+JB4
	1UujVwYJFQtqLqjrjVzXxIcWK6DCQyYz/tw==
X-Gm-Gg: Acq92OFDqIMySPLZnG1K2YeqwDOkncKKSa0FOYHchfNzV4mez/8E137FR01I7P9CFp2
	Z9zaUPyfFZSxtASzEt9odUbRhJxJ8sHjz449cdRYsy3CgkwaRVgLXjVYI5f5vCwhAMqMwCweNjr
	tEnpRqZ8v9vCObIImKRLpmAtVd6bHQaprFuedEaHmpUmsIFHuyPBjJxuWg4VdkcSPaG6guwV7gF
	aZ0KXf2stYk5xmNz2eQqUF/hYPFI8seOYjEVL8dZwawcapAjev96H9wXGhtus69B+86aiWyTbRR
	ibUgYSIGIW0fdmQ8Ow==
X-Received: by 2002:a17:903:2f06:b0:2bc:8beb:525b with SMTP id
 d9443c01a7336-2beb058cf7fmr271373325ad.18.1779908871291; Wed, 27 May 2026
 12:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526195917.18869-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260526195917.18869-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:07:40 -0400
X-Gm-Features: AVHnY4Ks-KffgEnapEMCSuGcju6GMu5bXlAi1YbXeq7YTnEEl1uaTxUeCbXHc3s
Message-ID: <CAEjxPJ6FtK=tiBcFNioXvd9KVw2X1jwO8De_pemzzYJ6w-SrSA@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: prevent stack overflows
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 3:59=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> mcstrans calls strcat() repeatedly on fixed-size stack buffers. Under
> certain configurations and inputs, this could yield a stack overflow.
> Introduce a buf_append() helper that dynamically allocates the buffer
> and resizes it as needed and replace all uses of strcat() with it.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 137 +++++++++++++++++++++++++++-------------
>  1 file changed, 93 insertions(+), 44 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 5ef6a0b9..002877e4 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -21,6 +21,7 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
> +#include <stdint.h>
>  #include <ctype.h>
>  #include <selinux/selinux.h>
>  #include <selinux/context.h>
> @@ -973,6 +974,38 @@ word_size(const void *p1, const void *p2) {
>         return spaceship_cmp(w2_len, w1_len);
>  }
>
> +static int buf_append(char **buf, size_t *cap, size_t *len, const char *=
s)
> +{
> +       size_t slen =3D strlen(s);
> +
> +       if (slen >=3D SIZE_MAX - 1 - *len) {
> +               log_error("buf_append: length overflow (%zu + %zu)", *len=
, slen);
> +               return -1;
> +       }
> +
> +       size_t need =3D *len + slen + 1;
> +       if (need > *cap) {
> +               size_t ncap =3D *cap ? *cap : 128;
> +               while (ncap < need) {
> +                       if (ncap > SIZE_MAX / 2) {
> +                               ncap =3D need;
> +                               break;
> +                       }
> +                       ncap *=3D 2;
> +               }
> +               char *n =3D realloc(*buf, ncap);
> +               if (!n) {
> +                       log_error("buf_append: allocation error %s", stre=
rror(errno));
> +                       return -1;
> +               }
> +               *buf =3D n;
> +               *cap =3D ncap;
> +       }
> +       memcpy(*buf + *len, s, slen + 1);
> +       *len +=3D slen;
> +       return 0;
> +}
> +
>  static void
>  build_regexp(pcre2_code **r, char *buffer) {
>         int error;
> @@ -985,19 +1018,24 @@ build_regexp(pcre2_code **r, char *buffer) {
>                 pcre2_get_error_message(error, errbuf, sizeof(errbuf));
>                 log_error("pcre compilation of '%s' failed at offset %zu:=
 %s\n", buffer, error_offset, errbuf);
>         }
> -       buffer[0] =3D '\0';
>  }
>
>  static int
>  build_regexps(domain_t *domain) {
> -       char buffer[1024 * 128];
> -       buffer[0] =3D '\0';
> +       char *buffer =3D NULL;
> +       size_t cap =3D 0, len =3D 0;
>         base_classification_t *bc;
>         word_group_t *g;
>         affix_t *a;
>         word_t *w;
>         size_t n_el, i;
>
> +#define APPEND(s) do { if (buf_append(&buffer, &cap, &len, (s))) goto er=
r; } while (0)
> +#define RESET() do { len =3D 0; if (buffer) buffer[0] =3D '\0'; } while =
(0)
> +
> +       /* initialize buffer and cap to non-NULL/0 values */
> +       APPEND("");
> +
>         for (n_el =3D 0, bc =3D domain->base_classifications; bc; bc =3D =
bc->next) {
>                 n_el++;
>         }
> @@ -1005,7 +1043,7 @@ build_regexps(domain_t *domain) {
>         char **sortable =3D calloc(n_el, sizeof(char *));
>         if (!sortable) {
>                 log_error("allocation error %s", strerror(errno));
> -               return -1;
> +               goto err;
>         }
>
>         for (i=3D0, bc =3D domain->base_classifications; bc; bc =3D bc->n=
ext) {
> @@ -1015,31 +1053,33 @@ build_regexps(domain_t *domain) {
>         qsort(sortable, n_el, sizeof(char *), string_size);
>
>         for (i =3D 0; i < n_el; i++) {
> -               strcat(buffer, sortable[i]);
> -               if (i < n_el) strcat(buffer,"|");
> +               APPEND(sortable[i]);
> +               if (i !=3D (n_el - 1)) APPEND("|");
>         }
>
>         free(sortable);
>
>         log_debug(">>> %s classification regexp=3D%s\n", domain->name, bu=
ffer);
>         build_regexp(&domain->base_classification_regexp, buffer);
> +       RESET();
>
>         for (g =3D domain->groups; g; g =3D g->next) {
>                 if (g->prefixes) {
> -                       strcat(buffer,"(?:");
> +                       APPEND("(?:");
>                         for (a =3D g->prefixes; a; a =3D a->next) {
> -                               strcat(buffer, a->text);
> -                               if (a->next) strcat(buffer,"|");
> +                               APPEND(a->text);
> +                               if (a->next) APPEND("|");
>                         }
> -                       strcat(buffer,")");
> -                       strcat(buffer,"[        ]+");
> +                       APPEND(")");
> +                       APPEND("[       ]+");
>                         log_debug(">>> %s %s prefix regexp=3D%s\n", domai=
n->name, g->name, buffer);
>                         build_regexp(&g->prefix_regexp, buffer);
> +                       RESET();
>                 }
>
>                 if (g->prefixes)
> -                       strcat(buffer, "^");
> -               strcat(buffer, "(?:");
> +                       APPEND("^");
> +               APPEND("(?:");
>
>                 g->sword_len=3D0;
>                 for (w =3D g->words; w; w =3D w->next)
> @@ -1048,7 +1088,7 @@ build_regexps(domain_t *domain) {
>                 g->sword =3D calloc(g->sword_len, sizeof(word_t *));
>                 if (!g->sword) {
>                         log_error("allocation error %s", strerror(errno))=
;
> -                       return -1;
> +                       goto err;
>                 }
>
>                 i=3D0;
> @@ -1058,38 +1098,47 @@ build_regexps(domain_t *domain) {
>                 qsort(g->sword, g->sword_len, sizeof(word_t *), word_size=
);
>
>                 for (i=3D0; i < g->sword_len; i++) {
> -                       if (i) strcat(buffer,"|");
> -                       strcat(buffer,"\\b");
> -                       strcat(buffer, g->sword[i]->text);
> -                       strcat(buffer,"\\b");
> +                       if (i) APPEND("|");
> +                       APPEND("\\b");
> +                       APPEND(g->sword[i]->text);
> +                       APPEND("\\b");
>                 }
>
>                 if (g->whitespace) {
> -                       strcat(buffer,"|[");
> -                       strcat(buffer, g->whitespace);
> -                       strcat(buffer, "]+");
> +                       APPEND("|[");
> +                       APPEND(g->whitespace);
> +                       APPEND("]+");
>                 }
>
> -               strcat(buffer, ")+");
> +               APPEND(")+");
>                 if (g->suffixes)
> -                       strcat(buffer, "$");
> +                       APPEND("$");
>
>                 log_debug(">>> %s %s modifier regexp=3D%s\n", domain->nam=
e, g->name, buffer);
>                 build_regexp(&g->word_regexp, buffer);
> +               RESET();
> +
>                 if (g->suffixes) {
> -                       strcat(buffer,"[        ]+");
> -                       strcat(buffer,"(?:");
> +                       APPEND("[       ]+");
> +                       APPEND("(?:");
>                         for (a =3D g->suffixes; a; a =3D a->next) {
> -                               strcat(buffer, a->text);
> -                               if (a->next) strcat(buffer,"|");
> +                               APPEND(a->text);
> +                               if (a->next) APPEND("|");
>                         }
> -                       strcat(buffer,")");
> +                       APPEND(")");
>                         log_debug(">>> %s %s suffix regexp=3D%s\n", domai=
n->name, g->name, buffer);
>                         build_regexp(&g->suffix_regexp, buffer);
> +                       RESET();
>                 }
>         }
>
> +       free(buffer);
>         return 0;
> +err:
> +       free(buffer);
> +       return -1;
> +#undef APPEND
> +#undef RESET
>  }
>
>  static char *
> @@ -1349,6 +1398,8 @@ compute_trans_from_raw(const char *level, domain_t =
*domain) {
>         word_group_t *g;
>         mls_level_t *l =3D NULL;
>         char *rval =3D NULL;
> +       char *obuf =3D NULL;
> +       size_t ocap =3D 0, olen =3D 0;
>         word_group_t *groups =3D NULL;
>         ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_un=
handled;
>
> @@ -1482,39 +1533,36 @@ compute_trans_from_raw(const char *level, domain_=
t *domain) {
>                         ebitmap_destroy(&unhandled);
>                         ebitmap_destroy(&orig_unhandled);
>                         if (done) {
> -                               char buffer[9999];
> -                               buffer[0] =3D 0;
> -                               strcat(buffer, bc->trans);
> -                               strcat(buffer, " ");
> +#define OAPPEND(s) do { if (buf_append(&obuf, &ocap, &olen, (s))) goto e=
rr; } while (0)
> +                               OAPPEND(bc->trans);
> +                               OAPPEND(" ");
>                                 for (g=3Dgroups; g; g =3D g->next) {
>                                         if (g->words && g->prefixes) {
> -                                               strcat(buffer, g->prefixe=
s->text);
> -                                               strcat(buffer, " ");
> +                                               OAPPEND(g->prefixes->text=
);
> +                                               OAPPEND(" ");
>                                         }
>                                         word_t *w;
>                                         for (w=3Dg->words; w; w =3D w->ne=
xt) {
> -                                               strcat(buffer, w->text);
> +                                               OAPPEND(w->text);
>                                                 if (w->next)
> -                                                       strcat(buffer, g-=
>join);
> +                                                       OAPPEND(g->join);
>                                         }
>                                         if (g->words && g->suffixes) {
> -                                               strcat(buffer, " ");
> -                                               strcat(buffer, g->suffixe=
s->text);
> +                                               OAPPEND(" ");
> +                                               OAPPEND(g->suffixes->text=
);
>                                         }
>                                         word_group_t *n =3D g->next;
>                                         while(g->words && n) {
>                                                 if (n->words) {
> -                                                       strcat(buffer, " =
");
> +                                                       OAPPEND(" ");
>                                                         break;
>                                                 }
>                                                 n =3D n->next;
>                                         }
>                                 }
> -                               rval =3D strdup(buffer);
> -                               if (!rval) {
> -                                       log_error("compute_trans_from_raw=
: allocation error %s", strerror(errno));
> -                                       goto err;
> -                               }
> +                               rval =3D obuf;
> +                               obuf =3D NULL;
> +#undef OAPPEND
>                         }
>                         /* clean up */
>                         while (groups)
> @@ -1542,6 +1590,7 @@ compute_trans_from_raw(const char *level, domain_t =
*domain) {
>         return rval;
>
>  err:
> +       free(obuf);
>         while (groups)
>                 destroy_group(&groups, groups);
>         mls_level_destroy(l);
> --
> 2.54.0
>
