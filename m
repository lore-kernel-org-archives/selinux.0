Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E2CC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 17:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbhLIRh0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 12:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLIRh0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 12:37:26 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E2C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 09:33:52 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so6945756otg.4
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 09:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VwmadAeoTs6xxWnt++8yQB9ROtqfL+iSnmT7ObrQQsM=;
        b=UawlVcSIgviRAR+WUslnibx5R7gmUhOiZhoS5ZdTuMCr+k5AyTH1NL3pi97OSI3fYF
         Zet/gfTl1U3D5XJA1VaobMSSFchlzxAZUSCh7dEcKbQbmbWJzFADsZxPNhq2gWC5vBv8
         HhJM7rAGYO1xAXfk93S1/UweYVYk8ire79R21rDSTDtQoDhgckTjr9HMVZomkwz4sDRl
         sg9ZkaE6R+vymth3FvhpL27GdjyJmqi8VTO34zOR8qvxUXzrqaBMixVeoIr0bKez86Tr
         9/ZW4J2HjPgWm2+kIu17YNcj3yW+Gg+0+nvWH3JpEnf4XrUxIOsPpL3z9eWC9jfRgbR7
         obVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VwmadAeoTs6xxWnt++8yQB9ROtqfL+iSnmT7ObrQQsM=;
        b=jMW0NVDhoef5LKAPB1ACIUPUGrmkGGlCyOegByPKBG9xc9MOI4FQGYdb95z+9lrxTf
         kCDG6kHPLDMHqeHHGGYUh5qXoqwfWz3IEY+tins/oYlWmLgU4XXNik3ReRWlf4n+tw0z
         SvWrXaGc6cOx4LAdiCK9wbKXIBlhcFr+ngcvDlAp73mCsWfoU/KaEWxHoyW58cv//UMW
         Eo9Po0DLaPqqtpWoTUHqJgI5eKrot4+WrrC2nUSghPWpTybTTInM0KhLmK4zZwk7u4VG
         3befwEOuRduY3nN/tz90fC/Znt9QZaKGGxD20J4NEnfLgTA4GdxGLpDb6SgAsWZsefLc
         L+BQ==
X-Gm-Message-State: AOAM5332wzTPQ2Cf+MYTj8q7d9KfBvpJfVeoP+QVyiqmDRL/l+NA/+WI
        FEA720ZfDVJBrQlz7vuxwAcay6h2IvZYZUeYwAo=
X-Google-Smtp-Source: ABdhPJze7fCldmeZ4Kh4aouzrzfEz3jg4tTk1aADCBm0Tt+WNJEw4M26t6hdIC0gNr2T/CRRhvxigvBvAfdNcmTZtUE=
X-Received: by 2002:a05:6830:1bfa:: with SMTP id k26mr6602331otb.139.1639071231990;
 Thu, 09 Dec 2021 09:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20211123183249.6133-1-cgzones@googlemail.com> <20211130110425.13595-1-cgzones@googlemail.com>
 <87sfvc1gmw.fsf@redhat.com>
In-Reply-To: <87sfvc1gmw.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Dec 2021 12:33:40 -0500
Message-ID: <CAP+JOzTNqbb=ygwBqP8wt_JDNPyJ6=4emZ_vm0yVTf7wSH-f=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mcstrans: port to new PCRE2 from end-of-life PCRE
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 3, 2021 at 2:43 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
> > Quoting pcre.org:
> >
> >     There are two major versions of the PCRE library. The current
> >     version, PCRE2, released in 2015, is now at version 10.39.
> >
> >     The older, but still widely deployed PCRE library, originally
> >     released in 1997, is at version 8.45. This version of PCRE is now a=
t
> >     end of life, and is no longer being actively maintained. Version
> >     8.45 is expected to be the final release of the older PCRE library,
> >     and new projects should use PCRE2 instead.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> There's few minor whitespace issues, see inline.
>
> Other than that
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

I fixed the whitespace issues and merged this series.
Thanks,
Jim

> Thanks!
>
>
> > ---
> > v2:
> >    - do not use pcre2_substring_get_bynumber(), fixes NATO mcstrans
> >      tests (spotted by Petr Lautrbach)
> > ---
> >  mcstrans/Makefile       |   6 ++
> >  mcstrans/src/Makefile   |   4 +-
> >  mcstrans/src/mcstrans.c | 131 ++++++++++++++++++++++++++++------------
> >  mcstrans/utils/Makefile |   6 +-
> >  4 files changed, 104 insertions(+), 43 deletions(-)
> >
> > diff --git a/mcstrans/Makefile b/mcstrans/Makefile
> > index c993a9f5..b20279ab 100644
> > --- a/mcstrans/Makefile
> > +++ b/mcstrans/Makefile
> > @@ -1,3 +1,9 @@
> > +PKG_CONFIG ?=3D pkg-config
> > +PCRE_MODULE :=3D libpcre2-8
> > +PCRE_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags $(PCRE_MODULE)) -DPCRE=
2_CODE_UNIT_WIDTH=3D8
> > +PCRE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
> > +export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
> > +
> >  all:
> >       $(MAKE) -C src
> >       $(MAKE) -C utils
> > diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> > index 76ef0557..ef518625 100644
> > --- a/mcstrans/src/Makefile
> > +++ b/mcstrans/src/Makefile
> > @@ -20,10 +20,10 @@ CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wm=
issing-format-attribute
> >  all: $(PROG)
> >
> >  $(PROG): $(PROG_OBJS) $(LIBSEPOLA)
> > -     $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDLIBS_LI=
BSEPOLA)
> > +     $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap $(PCRE_LDLIBS) $(L=
DLIBS_LIBSEPOLA)
> >
> >  %.o:  %.c
> > -     $(CC) $(CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -fPIE -c -=
o $@ $<
> > +     $(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -fPIE -c -o $@ $<
> >
> >  install: all
> >       test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(SBI=
NDIR)
> > diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> > index 09577ea0..6e4bfd3b 100644
> > --- a/mcstrans/src/mcstrans.c
> > +++ b/mcstrans/src/mcstrans.c
> > @@ -26,7 +26,7 @@
> >  #include <selinux/context.h>
> >  #include <syslog.h>
> >  #include <errno.h>
> > -#include <pcre.h>
> > +#include <pcre2.h>
> >  #include <ctype.h>
> >  #include <time.h>
> >  #include <sys/time.h>
> > @@ -36,7 +36,6 @@
> >  #include "mcstrans.h"
> >
> >  #define N_BUCKETS 1453
> > -#define OVECCOUNT (512*3)
> >
> >  #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
> >
> > @@ -82,9 +81,9 @@ typedef struct word_group {
> >       affix_t *suffixes;
> >       word_t *words;
> >
> > -     pcre *prefix_regexp;
> > -     pcre *word_regexp;
> > -     pcre *suffix_regexp;
> > +     pcre2_code *prefix_regexp;
> > +     pcre2_code *word_regexp;
> > +     pcre2_code *suffix_regexp;
> >
> >       ebitmap_t def;
> >
> > @@ -109,7 +108,7 @@ typedef struct domain {
> >       base_classification_t *base_classifications;
> >       word_group_t *groups;
> >
> > -     pcre *base_classification_regexp;
> > +     pcre2_code *base_classification_regexp;
> >       struct domain *next;
> >  } domain_t;
> >
> > @@ -317,9 +316,9 @@ destroy_group(word_group_t **list, word_group_t *gr=
oup) {
> >       free(group->name);
> >       free(group->sword);
> >       free(group->join);
> > -     pcre_free(group->prefix_regexp);
> > -     pcre_free(group->word_regexp);
> > -     pcre_free(group->suffix_regexp);
> > +     pcre2_code_free(group->prefix_regexp);
> > +     pcre2_code_free(group->word_regexp);
> > +     pcre2_code_free(group->suffix_regexp);
> >       ebitmap_destroy(&group->def);
> >       free(group);
> >  }
> > @@ -392,7 +391,7 @@ destroy_domain(domain_t *domain) {
> >               free(domain->base_classifications);
> >               domain->base_classifications =3D next;
> >       }
> > -     pcre_free(domain->base_classification_regexp);
> > +     pcre2_code_free(domain->base_classification_regexp);
> >       while (domain->groups)
> >               destroy_group(&domain->groups, domain->groups);
> >       free(domain->name);
> > @@ -963,14 +962,16 @@ word_size(const void *p1, const void *p2) {
> >  }
> >
> >  static void
> > -build_regexp(pcre **r, char *buffer) {
> > -     const char *error;
> > -     int error_offset;
> > +build_regexp(pcre2_code **r, char *buffer) {
> > +     int error;
> > +     PCRE2_SIZE error_offset;
> >       if (*r)
> > -             pcre_free(*r);
> > -     *r =3D pcre_compile(buffer, PCRE_CASELESS, &error, &error_offset,=
 NULL);
> > -     if (error) {
> > -             log_error("pcre=3D%s, error=3D%s\n", buffer, error ? erro=
r: "none");
> > +             pcre2_code_free(*r);
> > +     *r =3D pcre2_compile((PCRE2_SPTR8) buffer, PCRE2_ZERO_TERMINATED,=
 PCRE2_CASELESS, &error, &error_offset, NULL);
> > +     if (!*r) {
> > +             PCRE2_UCHAR errbuf[256];
> > +             pcre2_get_error_message(error, errbuf, sizeof(errbuf));
>
>   SELinuxProject/selinux/master/.git/worktrees/patchwork/rebase-apply/pat=
ch:127: space before tab in indent.
>                   pcre2_get_error_message(error, errbuf, sizeof(errbuf));
>
>
> > +             log_error("pcre compilation of '%s' failed at offset %zu:=
 %s\n", buffer, error_offset, errbuf);
> >       }
> >       buffer[0] =3D '\0';
> >  }
> > @@ -1088,12 +1089,12 @@ compute_raw_from_trans(const char *level, domai=
n_t *domain) {
> >  #endif
> >
> >       int rc =3D 0;
> > -     int ovector[OVECCOUNT];
> > +     pcre2_match_data *match_data =3D NULL;
> >       word_group_t *g =3D NULL;
> >       char *work =3D NULL;
> >       char *r =3D NULL;
> > -     const char * match =3D NULL;
> > -     int work_len;
> > +     char *match =3D NULL;
> > +     size_t work_len;
> >       mls_level_t *mraw =3D NULL;
> >       ebitmap_t set, clear, tmp;
> >
> > @@ -1114,11 +1115,20 @@ compute_raw_from_trans(const char *level, domai=
n_t *domain) {
> >       if (!domain->base_classification_regexp)
> >               goto err;
> >       log_debug(" compute_raw_from_trans work =3D %s\n", work);
> > -     rc =3D pcre_exec(domain->base_classification_regexp, 0, work, wor=
k_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> > +     match_data =3D pcre2_match_data_create_from_pattern(domain->base_=
classification_regexp, NULL);
> > +     if (!match_data) {
> > +             log_error("allocation error %s", strerror(errno));
> > +             goto err;
> > +     }
> > +     rc =3D pcre2_match(domain->base_classification_regexp, (PCRE2_SPT=
R8)work, work_len, 0, PCRE2_ANCHORED, match_data, NULL);
> >       if (rc > 0) {
> > -             match =3D NULL;
> > -             pcre_get_substring(work, ovector, rc, 0, &match);
> > -             log_debug(" compute_raw_from_trans match =3D %s len =3D %=
u\n", match, strlen(match));
> > +             const PCRE2_SIZE *ovector =3D pcre2_get_ovector_pointer(m=
atch_data);
> > +             match =3D strndup(work + ovector[0], ovector[1] - ovector=
[0]);
> > +             if (!match) {
> > +                     log_error("allocation error %s", strerror(errno))=
;
> > +                     goto err;
> > +             }
> > +             log_debug(" compute_raw_from_trans match =3D %s len =3D %=
zu\n", match, strlen(match));
> >               base_classification_t *bc;
> >               for (bc =3D domain->base_classifications; bc; bc =3D bc->=
next) {
> >                       if (!strcmp(bc->trans, match)) {
> > @@ -1138,12 +1148,23 @@ compute_raw_from_trans(const char *level, domai=
n_t *domain) {
> >               char *p=3Dwork + ovector[0] + ovector[1];
> >               while (*p && (strchr("  ", *p) !=3D NULL))
> >                       *p++ =3D '#';
> > -             pcre_free((char *)match);
> > +
> > +             free(match);
> >               match =3D NULL;
> >       } else {
> > -             log_debug(" compute_raw_from_trans no base classification=
 matched %s\n", level);
> > +             switch (rc) {
> > +             case PCRE2_ERROR_NOMATCH:
> > +                     log_debug(" compute_raw_from_trans no base classi=
fication matched %s\n", level);
> > +                     break;
> > +             default:
> > +                     log_error("compute_raw_from_trans: base matching =
error for input '%s': %d\n", level, rc);
> > +                     break;
> > +             }
> >       }
> >
>
>   SELinuxProject/selinux/master/.git/worktrees/patchwork/rebase-apply/pat=
ch:190: trailing whitespace.
>
>
>
> >
> > +     pcre2_match_data_free(match_data);
> > +     match_data =3D NULL;
> > +
> >       if (mraw =3D=3D NULL) {
> >               goto err;
> >       }
> > @@ -1154,23 +1175,43 @@ compute_raw_from_trans(const char *level, domai=
n_t *domain) {
> >               change =3D 0;
> >               for (g =3D domain->groups; g && !change && !complete; g =
=3D g->next) {
> >                       int prefix =3D 0, suffix =3D 0;
> > -                     int prefix_offset =3D 0, prefix_len =3D 0;
> > -                     int suffix_offset =3D 0, suffix_len =3D 0;
> > +                     PCRE2_SIZE prefix_offset =3D 0, prefix_len =3D 0;
> > +                     PCRE2_SIZE suffix_offset =3D 0, suffix_len =3D 0;
> >                       if (g->prefix_regexp) {
> > -                             rc =3D pcre_exec(g->prefix_regexp, 0, wor=
k, work_len, 0, 0, ovector, OVECCOUNT);
> > +                             match_data =3D pcre2_match_data_create_fr=
om_pattern(g->prefix_regexp, NULL);
> > +                             if (!match_data) {
> > +                                     log_error("allocation error %s", =
strerror(errno));
> > +                                     goto err;
> > +                             }
> > +                             rc =3D pcre2_match(g->prefix_regexp, (PCR=
E2_SPTR8)work, work_len, 0, 0, match_data, NULL);
> >                               if (rc > 0) {
> > +                                     const PCRE2_SIZE *ovector =3D pcr=
e2_get_ovector_pointer(match_data);
> >                                       prefix =3D 1;
> >                                       prefix_offset =3D ovector[0];
> >                                       prefix_len =3D ovector[1] - ovect=
or[0];
> > +                             } else if (rc !=3D PCRE2_ERROR_NOMATCH) {
> > +                                     log_error("compute_raw_from_trans=
: prefix matching error for input '%s': %d\n", level, rc);
> >                               }
> > +                             pcre2_match_data_free(match_data);
> > +                             match_data =3D NULL;
> >                       }
> >                       if (g->suffix_regexp) {
> > -                             rc =3D pcre_exec(g->suffix_regexp, 0, wor=
k, work_len, 0, 0, ovector, OVECCOUNT);
> > +                             match_data =3D pcre2_match_data_create_fr=
om_pattern(g->suffix_regexp, NULL);
> > +                             if (!match_data) {
> > +                                     log_error("allocation error %s", =
strerror(errno));
> > +                                     goto err;
> > +                             }
> > +                             rc =3D pcre2_match(g->suffix_regexp, (PCR=
E2_SPTR8)work, work_len, 0, 0, match_data, NULL);
> >                               if (rc > 0) {
> > +                                     const PCRE2_SIZE *ovector =3D pcr=
e2_get_ovector_pointer(match_data);
> >                                       suffix =3D 1;
> >                                       suffix_offset =3D ovector[0];
> >                                       suffix_len =3D ovector[1] - ovect=
or[0];
> > +                             } else if (rc !=3D PCRE2_ERROR_NOMATCH) {
> > +                                     log_error("compute_raw_from_trans=
: suffix matching error for input '%s': %d\n", level, rc);
> >                               }
> > +                             pcre2_match_data_free(match_data);
> > +                             match_data =3D NULL;
> >                       }
> >
> >  /* anchors prefix ^, suffix $ */
> > @@ -1179,14 +1220,23 @@ compute_raw_from_trans(const char *level, domai=
n_t *domain) {
> >                            (g->suffixes && suffix)) &&
> >                            g->word_regexp) {
> >                               char *s =3D work + prefix_offset + prefix=
_len;
> > -                             int l =3D (suffix_len ? suffix_offset : w=
ork_len) - prefix_len - prefix_offset;
> > -                             rc =3D pcre_exec(g->word_regexp, 0, s, l,=
 0, 0, ovector, OVECCOUNT);
> > +                             PCRE2_SIZE len =3D (suffix_len ? suffix_o=
ffset : work_len) - prefix_len - prefix_offset;
> > +                             match_data =3D pcre2_match_data_create_fr=
om_pattern(g->word_regexp, NULL);
> > +                             if (!match_data) {
> > +                                     log_error("allocation error %s", =
strerror(errno));
> > +                                     goto err;
> > +                             }
> > +                             rc =3D pcre2_match(g->word_regexp, (PCRE2=
_SPTR8)s, len, 0, 0, match_data, NULL);
> >                               if (rc > 0) {
> > -                                     match =3D NULL;
> > -                                     pcre_get_substring(s, ovector, rc=
, 0, &match);
> > -                                     trim((char *)match, g->whitespace=
);
> > +                                     const PCRE2_SIZE *ovector =3D pcr=
e2_get_ovector_pointer(match_data);
> > +                                     match =3D strndup(s + ovector[0],=
 ovector[1] - ovector[0]);
> > +                                     if (!match) {
> > +                                             log_error("allocation err=
or %s", strerror(errno));
> > +                                             goto err;
> > +                                     }
> > +                                     trim(match, g->whitespace);
> >                                       if (*match) {
> > -                                             char *p =3D triml((char *=
)match, g->whitespace);
> > +                                             char *p =3D triml(match, =
g->whitespace);
> >                                               while (p && *p) {
> >                                                       int plen =3D strl=
en(p);
> >                                                       unsigned int i;
> > @@ -1223,9 +1273,13 @@ compute_raw_from_trans(const char *level, domain=
_t *domain) {
> >                                               memset(work + suffix_offs=
et, '#', suffix_len);
> >                                               memset(s + ovector[0], '#=
', ovector[1] - ovector[0]);
> >                                       }
> > -                                     pcre_free((void *)match);
> > +                                     free(match);
> >                                       match =3D NULL;
> > +                             } else if (rc !=3D PCRE2_ERROR_NOMATCH) {
> > +                                     log_error("compute_raw_from_trans=
: word matching error for input '%s' for substring '%s': %d\n", level, s, r=
c);
> >                               }
> > +                             pcre2_match_data_free(match_data);
> > +                             match_data =3D NULL;
> >                       }
> >  /* YYY */
> >                       complete=3D1;
> > @@ -1264,10 +1318,11 @@ err:
> >       mls_level_destroy(mraw);
> >       free(mraw);
> >       free(work);
> > -     pcre_free((void *)match);
> > +     free(match);
> >       ebitmap_destroy(&tmp);
> >       ebitmap_destroy(&set);
> >       ebitmap_destroy(&clear);
> > +     pcre2_match_data_free(match_data);
> >       return NULL;
> >  }
> >
> > diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> > index 9dfe7723..a48f4e72 100644
> > --- a/mcstrans/utils/Makefile
> > +++ b/mcstrans/utils/Makefile
> > @@ -14,13 +14,13 @@ endif
> >  all: $(TARGETS)
> >
> >  transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
> > -     $(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
> > +     $(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSE=
POLA)
> >
> >  untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEP=
OLA)
> > -     $(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
> > +     $(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSE=
POLA)
> >
> >  %.o:  %.c
> > -     $(CC) $(CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
> > +     $(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o=
 $@ $<
> >
> >  install: all
> >       -mkdir -p $(DESTDIR)$(SBINDIR)
> > --
> > 2.34.1
>
