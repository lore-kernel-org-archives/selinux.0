Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D6C76186
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820C02084D
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGWUGs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:06:48 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58720 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfGWUGr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jul 2019 16:06:47 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8DA70564702
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2019 22:06:43 +0200 (CEST)
Received: by mail-ot1-f43.google.com with SMTP id j19so6926159otq.2
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2019 13:06:43 -0700 (PDT)
X-Gm-Message-State: APjAAAV8O3PHR0znCnVqmlaQHa6LwKCr+e7VPLM9Zi/OOLGSWI5EdrDF
        +/HPOgJrmt4FhY5X1QQb+7KVPGxEMcohl/e2Ad0=
X-Google-Smtp-Source: APXvYqxrVS499koMfa4ij/CWAtw3Qx6O3SHextonDOjF3w6V97sQBMOZe513383f6n1haARE4bQkCYSi4brIEynMshU=
X-Received: by 2002:a9d:744a:: with SMTP id p10mr52814946otk.321.1563912402549;
 Tue, 23 Jul 2019 13:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190311222442.49824-1-xunchang@google.com> <3a5038d7-cb5b-de62-23ee-e22324a8a989@tycho.nsa.gov>
In-Reply-To: <3a5038d7-cb5b-de62-23ee-e22324a8a989@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 23 Jul 2019 22:06:31 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mdnfCS6-PH-Mpu=237jZdfm9k0wpwcj-=W8YacOGa7eA@mail.gmail.com>
Message-ID: <CAJfZ7=mdnfCS6-PH-Mpu=237jZdfm9k0wpwcj-=W8YacOGa7eA@mail.gmail.com>
Subject: Re: [PATCH] Restorecon: factor out a lookup helper for context matches
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        xunchang <xunchang@google.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 23 22:06:44 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 19, 2019 at 4:45 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 3/11/19 6:24 PM, xunchang wrote:
> > We used to hash the file_context and skip the restorecon on the top
> > level directory if the hash doesn't change. But the file_context might
> > change after an update; and some users experienced long restorecon
> > time as they have lots of files under directories like /data/media.
> > Therefore, we try to skip unnecessary restores if the file context
> > relates to the given directory doesn't change.
> >
> > This CL is the first step that factors out a lookup helper function
> > and returns an array of matched pointers instead of a single one.
> > The old loopup_common function is then modified to take the first
> > element in the array.
> >
> > This change has already been submitted in android selinux branch. And
> > porting it upstream will make these two branches more consistent and
> > save some work for the future merges.
>
> There were some changes to this patch before it landed in AOSP, so they
> aren't quite consistent.  Do you want to submit the final patch?

Hello,

What are the states of this patch and the one which has been posted in
April (https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/)?
I do not follow what happens in Android but if the patches have been
modified there, it seems a good idea to post the modified patches to
selinux@vger.kernel.org.

Thanks,
Nicolas

> >
> > Signed-off-by: Tianjie Xu <xunchang@google.com>
> > ---
> >   libselinux/include/selinux/label.h |   4 ++
> >   libselinux/src/label.c             |   9 +++
> >   libselinux/src/label_file.c        | 111 +++++++++++++++++++++++------
> >   libselinux/src/label_internal.h    |   2 +
> >   4 files changed, 106 insertions(+), 20 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> > index 277287ed..e537aa11 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -7,6 +7,7 @@
> >   #define _SELABEL_H_
> >
> >   #include <stdbool.h>
> > +#include <stdint.h>
> >   #include <sys/types.h>
> >   #include <selinux/selinux.h>
> >
> > @@ -105,6 +106,9 @@ int selabel_lookup_raw(struct selabel_handle *handle, char **con,
> >
> >   bool selabel_partial_match(struct selabel_handle *handle, const char *key);
> >
> > +bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> > +                                      const char *key, uint8_t* digest);
> > +
> >   int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
> >                             const char *key, const char **aliases, int type);
> >   int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index 8d586bda..1d16f685 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -274,6 +274,15 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
> >       return rec->func_partial_match(rec, key);
> >   }
> >
> > +bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> > +                                      const char *key, uint8_t *digest) {
> > +     if (!rec->func_hash_all_partial_matches) {
> > +             return false;
> > +     }
> > +
> > +     return rec->func_hash_all_partial_matches(rec, key, digest);
> > +}
> > +
> >   int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
> >                             const char *key, const char **aliases, int type)
> >   {
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index b81fd552..90cbd666 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -843,22 +843,38 @@ static void closef(struct selabel_handle *rec)
> >       free(data);
> >   }
> >
> > -static struct spec *lookup_common(struct selabel_handle *rec,
> > -                                          const char *key,
> > -                                          int type,
> > -                                          bool partial)
> > +// Finds all the matches of |key| in the given context. Returns the result in
> > +// the allocated array and updates the match count. If match_count is NULL,
> > +// stops early once the 1st match is found.
> > +static const struct spec **lookup_all(struct selabel_handle *rec,
> > +                                      const char *key,
> > +                                      int type,
> > +                                      bool partial,
> > +                                      size_t *match_count)
> >   {
> >       struct saved_data *data = (struct saved_data *)rec->data;
> >       struct spec *spec_arr = data->spec_arr;
> >       int i, rc, file_stem;
> >       mode_t mode = (mode_t)type;
> >       const char *buf;
> > -     struct spec *ret = NULL;
> >       char *clean_key = NULL;
> >       const char *prev_slash, *next_slash;
> >       unsigned int sofar = 0;
> >       char *sub = NULL;
> >
> > +     const struct spec **result = NULL;
> > +     if (match_count) {
> > +             *match_count = 0;
> > +             result = calloc(data->nspec, sizeof(struct spec*));
> > +     } else {
> > +             result = calloc(1, sizeof(struct spec*));
> > +     }
> > +     if (!result) {
> > +             selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes of data\n",
> > +                         data->nspec * sizeof(struct spec*));
> > +             goto finish;
> > +     }
> > +
> >       if (!data->nspec) {
> >               errno = ENOENT;
> >               goto finish;
> > @@ -899,18 +915,33 @@ static struct spec *lookup_common(struct selabel_handle *rec,
> >                * specified or if the mode matches the file mode then we do
> >                * a regex check        */
> >               if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
> > -                 (!mode || !spec->mode || mode == spec->mode)) {
> > +                             (!mode || !spec->mode || mode == spec->mode)) {
> >                       if (compile_regex(data, spec, NULL) < 0)
> >                               goto finish;
> >                       if (spec->stem_id == -1)
> >                               rc = regex_match(spec->regex, key, partial);
> >                       else
> >                               rc = regex_match(spec->regex, buf, partial);
> > -                     if (rc == REGEX_MATCH) {
> > -                             spec->matches++;
> > -                             break;
> > -                     } else if (partial && rc == REGEX_MATCH_PARTIAL)
> > +
> > +                     if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
> > +                             if (rc == REGEX_MATCH) {
> > +                                     spec->matches++;
> > +                             }
> > +
> > +                             if (strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
> > +                                     errno = ENOENT;
> > +                                     goto finish;
> > +                             }
> > +
> > +                             if (match_count) {
> > +                                     result[*match_count] = spec;
> > +                                     *match_count += 1;
> > +                                     // Continue to find all the matches.
> > +                                     continue;
> > +                             }
> > +                             result[0] = spec;
> >                               break;
> > +                     }
> >
> >                       if (rc == REGEX_NO_MATCH)
> >                               continue;
> > @@ -921,19 +952,58 @@ static struct spec *lookup_common(struct selabel_handle *rec,
> >               }
> >       }
> >
> > -     if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
> > -             /* No matching specification. */
> > -             errno = ENOENT;
> > -             goto finish;
> > -     }
> > -
> > -     errno = 0;
> > -     ret = &spec_arr[i];
> > -
> >   finish:
> >       free(clean_key);
> >       free(sub);
> > -     return ret;
> > +     if (result && !result[0]) {
> > +             free(result);
> > +             result = NULL;
> > +     }
> > +     return result;
> > +}
> > +
> > +static struct spec *lookup_common(struct selabel_handle *rec,
> > +                                  const char *key,
> > +                                  int type,
> > +                                  bool partial) {
> > +     const struct spec **matches = lookup_all(rec, key, type, partial, NULL);
> > +     if (!matches) {
> > +             return NULL;
> > +     }
> > +     struct spec *result = (struct spec*)matches[0];
> > +     free(matches);
> > +     return result;
> > +}
> > +
> > +static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
> > +{
> > +     assert(digest);
> > +
> > +     size_t total_matches;
> > +     const struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
> > +     if (!matches) {
> > +             return false;
> > +     }
> > +
> > +     Sha1Context context;
> > +     Sha1Initialise(&context);
> > +     size_t i;
> > +     for (i = 0; i < total_matches; i++) {
> > +             char* regex_str = matches[i]->regex_str;
> > +             mode_t mode = matches[i]->mode;
> > +             char* ctx_raw = matches[i]->lr.ctx_raw;
> > +
> > +             Sha1Update(&context, regex_str, strlen(regex_str) + 1);
> > +             Sha1Update(&context, &mode, sizeof(mode_t));
> > +             Sha1Update(&context, ctx_raw, strlen(ctx_raw) + 1);
> > +     }
> > +
> > +     SHA1_HASH sha1_hash;
> > +     Sha1Finalise(&context, &sha1_hash);
> > +     memcpy(digest, sha1_hash.bytes, SHA1_HASH_SIZE);
> > +
> > +     free(matches);
> > +     return true;
> >   }
> >
> >   static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> > @@ -1133,6 +1203,7 @@ int selabel_file_init(struct selabel_handle *rec,
> >       rec->func_stats = &stats;
> >       rec->func_lookup = &lookup;
> >       rec->func_partial_match = &partial_match;
> > +     rec->func_hash_all_partial_matches = &hash_all_partial_matches;
> >       rec->func_lookup_best_match = &lookup_best_match;
> >       rec->func_cmp = &cmp;
> >
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> > index 0e020557..1fa5ade6 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -87,6 +87,8 @@ struct selabel_handle {
> >       void (*func_close) (struct selabel_handle *h);
> >       void (*func_stats) (struct selabel_handle *h);
> >       bool (*func_partial_match) (struct selabel_handle *h, const char *key);
> > +     bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
> > +                                            const char *key, uint8_t *digest);
> >       struct selabel_lookup_rec *(*func_lookup_best_match)
> >                                                   (struct selabel_handle *h,
> >                                                   const char *key,
> >
>

