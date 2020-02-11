Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1EC3B187
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FDF20870
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 21:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZcFRR5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBKVZh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:25:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31443 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgBKVZh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 16:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581456334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SGhMLbnamBzPLvl/MJ5klDvmdceqdvO6mHeWtI2B2To=;
        b=SZcFRR5ukdMYf5KHV6ezrC50r5UeJ5vanQw34b5uuxQpORDaHtzKLljPMYnEpFKrKXzFvT
        pyVTkWlx/hz8E8sEnO8Wr7ODzPynIOuYTbcp3Azk49WPTaJMoDHuI3BHQWTrI3x58zb8MJ
        LsS2o0jPaYQ4M9BKuaRdcRgYd2BFSBE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-trhcs0tqPfSeDaetGI-WyQ-1; Tue, 11 Feb 2020 16:19:25 -0500
X-MC-Unique: trhcs0tqPfSeDaetGI-WyQ-1
Received: by mail-ot1-f70.google.com with SMTP id d16so7735241otq.19
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 13:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGhMLbnamBzPLvl/MJ5klDvmdceqdvO6mHeWtI2B2To=;
        b=tEkWfNfMRRTUt2sMqLWXCWeJrRDGmvsYzkd2e5RrGEAG+Jb0eAEXPgjf6Mqbzqp759
         H2n8/aNsCU7oohJggaV72Tt5m6d13m3/XhymXtmg+oE29RL4g0epf2qWFwhWE7wvzuSa
         ivbHUV3ZQGm99Gk9az2EvVZlLEK6YzWVVw3p6jhvIg+zqTduV78K6SiXoS6sBk2dG/U/
         WyO0uZ7ZUUKfEmK7/ZHbXvKTuJdGXtjvHwDUpwk7qssHPmF208RouTEemIxdfXGpw4Vx
         blcrnIrQM2NUvh74PRHV8PAq50n529ldoZngmgoQt6d5EaV/WnOF5JLO5sMzLGTCoP1B
         v1mQ==
X-Gm-Message-State: APjAAAWfR3I3eOZDKUvsa3QzFmN8WWqy0RtMilt5fNLsYilRFi9J0yIy
        qgM6MbLnZP5yS80319vkEJ61Gk5q3skIRdF90Z1VYUanFOQgKPEYs3Sn1QG75Mz8910lxNQrDkU
        db3e5ZnhnalBKUndxoJ7it53HuYdOk9UklQ==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr4245571oid.26.1581455964497;
        Tue, 11 Feb 2020 13:19:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQSUE7txKpK+RYMUHscbDfqmUb6Y1nZ9TQUq6RhBI3Bo256MHYOOi/J7rFPo9IUy8RJDmbopUj6ht/N3R3k0Q=
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr4245561oid.26.1581455964003;
 Tue, 11 Feb 2020 13:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20200211101438.403297-1-plautrba@redhat.com>
In-Reply-To: <20200211101438.403297-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 11 Feb 2020 22:19:12 +0100
Message-ID: <CAFqZXNu7rFu6CQN0fhQefjmZGDLBuZhjuGH6VfGcBHCwGNyDZg@mail.gmail.com>
Subject: Re: [PATCH v5] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I found one memory leak and one style nit, please see below. Otherwise
the patch looks good to me (but I only checked the code flow - I don't
understand the whole context well enough to fully judge its
correctness).

On Tue, Feb 11, 2020 at 11:14 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
>
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> v5 changes:
>
> - context_free(usercon) when is_in_reachable() finds a duplicate
>
> I see some value in reporting problem context during parsing a file and skipping this context
> so I left the code after usercon = context_new(usercon_str) untouched.
>
>
>  libselinux/src/get_context_list.c | 214 ++++++++++++++----------------
>  1 file changed, 98 insertions(+), 116 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e46589f30..6078d980cde1 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -2,6 +2,7 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
> +#include <stdint.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <ctype.h>
> @@ -114,61 +115,38 @@ int get_default_context(const char *user,
>         return 0;
>  }
>
> -static int find_partialcon(char ** list,
> -                          unsigned int nreach, char *part)
> +static int is_in_reachable(char **reachable, const char *usercon_str)
>  {
> -       const char *conrole, *contype;
> -       char *partrole, *parttype, *ptr;
> -       context_t con;
> -       unsigned int i;
> +       if (!reachable)
> +               return 0;
>
> -       partrole = part;
> -       ptr = part;
> -       while (*ptr && !isspace(*ptr) && *ptr != ':')
> -               ptr++;
> -       if (*ptr != ':')
> -               return -1;
> -       *ptr++ = 0;
> -       parttype = ptr;
> -       while (*ptr && !isspace(*ptr) && *ptr != ':')
> -               ptr++;
> -       *ptr = 0;
> -
> -       for (i = 0; i < nreach; i++) {
> -               con = context_new(list[i]);
> -               if (!con)
> -                       return -1;
> -               conrole = context_role_get(con);
> -               contype = context_type_get(con);
> -               if (!conrole || !contype) {
> -                       context_free(con);
> -                       return -1;
> -               }
> -               if (!strcmp(conrole, partrole) && !strcmp(contype, parttype)) {
> -                       context_free(con);
> -                       return i;
> +       for (; *reachable != NULL; reachable++) {
> +               if (strcmp(*reachable, usercon_str) == 0) {
> +                       return 1;
>                 }
> -               context_free(con);
>         }
> -
> -       return -1;
> +       return 0;
>  }
>
> -static int get_context_order(FILE * fp,
> +static int get_context_user(FILE * fp,
>                              char * fromcon,
> -                            char ** reachable,
> -                            unsigned int nreach,
> -                            unsigned int *ordering, unsigned int *nordered)
> +                            const char * user,
> +                            char ***reachable,
> +                            unsigned int *nreachable)
>  {
>         char *start, *end = NULL;
>         char *line = NULL;
> -       size_t line_len = 0;
> +       size_t line_len = 0, usercon_len;
> +       size_t user_len = strlen(user);
>         ssize_t len;
>         int found = 0;
> -       const char *fromrole, *fromtype;
> +       const char *fromrole, *fromtype, *fromlevel;
>         char *linerole, *linetype;
> -       unsigned int i;
> +       char **new_reachable = NULL;
> +       char *usercon_str;
>         context_t con;
> +       context_t usercon;
> +
>         int rc;
>
>         errno = -EINVAL;

This is not your bug, but this should be just "errno = EINVAL". Should
probably be fixed in another patch...

> @@ -180,6 +158,7 @@ static int get_context_order(FILE * fp,
>                 return -1;
>         fromrole = context_role_get(con);
>         fromtype = context_type_get(con);
> +       fromlevel = context_range_get(con);
>         if (!fromrole || !fromtype) {
>                 context_free(con);
>                 return -1;
> @@ -243,23 +222,84 @@ static int get_context_order(FILE * fp,
>                 if (*end)
>                         *end++ = 0;
>
> -               /* Check for a match in the reachable list. */
> -               rc = find_partialcon(reachable, nreach, start);
> -               if (rc < 0) {
> -                       /* No match, skip it. */
> +               /* Check whether a new context is valid */
> +               if (SIZE_MAX - user_len < strlen(start) + 2) {
> +                       fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
> +                       errno = EINVAL;
> +                       rc = -1;
> +                       goto out;
> +               }
> +               usercon_len = user_len + strlen(start) + 2;
> +               usercon_str = malloc(usercon_len);
> +               if (!usercon_str) {
> +                       rc = -1;
> +                       goto out;
> +               }
> +
> +               /* set range from fromcon in the new usercon */
> +               snprintf(usercon_str, usercon_len, "%s:%s", user, start);
> +               usercon = context_new(usercon_str);
> +               if (!usercon) {
> +                       if (errno != EINVAL) {
> +                               free(usercon_str);
> +                               rc = -1;
> +                               goto out;
> +                       }
> +                       fprintf(stderr,
> +                               "%s: can't create a context from %s, skipping\n",
> +                               __FUNCTION__, usercon_str);
> +                       free(usercon_str);
>                         start = end;
>                         continue;
>                 }
> +               free(usercon_str);
> +               if (context_range_set(usercon, fromlevel) != 0) {
> +                       context_free(usercon);
> +                       rc = -1;
> +                       goto out;
> +               }
> +               usercon_str = context_str(usercon);

You can do context_free(usercon) right here (it's not used beyond this
line) and avoid doing it in all the paths after here.

> +               if (!usercon_str) {
> +                       context_free(usercon);
> +                       rc = -1;
> +                       goto out;
> +               }
>
> -               /* If a match is found and the entry is not already ordered
> -                  (e.g. due to prior match in prior config file), then set
> -                  the ordering for it. */
> -               i = rc;
> -               if (ordering[i] == nreach)
> -                       ordering[i] = (*nordered)++;
> +               /* check whether usercon is already in reachable */
> +               if (is_in_reachable(*reachable, usercon_str)) {
> +                       context_free(usercon);
> +                       start = end;
> +                       continue;
> +               }
> +               if (security_check_context(usercon_str) == 0) {
> +                       if (*nreachable == 0) {
> +                               new_reachable = malloc(2 * sizeof(char *));
> +                               if (!new_reachable) {
> +                                       context_free(usercon);
> +                                       rc = -1;
> +                                       goto out;
> +                               }
> +                       } else {
> +                               new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
> +                               if (!new_reachable) {
> +                                       context_free(usercon);
> +                                       rc = -1;
> +                                       goto out;
> +                               }
> +                       }
> +                       new_reachable[*nreachable] = strdup(usercon_str);
> +                       if (new_reachable[*nreachable] == NULL) {

Unless I'm mistaken, you should free new_reachable here, otherwise it leaks.

> +                               context_free(usercon);
> +                               rc = -1;
> +                               goto out;
> +                       }
> +                       new_reachable[*nreachable + 1] = 0;
> +                       *reachable = new_reachable;
> +                       *nreachable += 1;
> +               }
> +               context_free(usercon);
>                 start = end;
>         }
> -
>         rc = 0;
>
>        out:
> @@ -313,21 +353,6 @@ static int get_failsafe_context(const char *user, char ** newcon)
>         return 0;
>  }
>
> -struct context_order {
> -       char * con;
> -       unsigned int order;
> -};
> -
> -static int order_compare(const void *A, const void *B)
> -{
> -       const struct context_order *c1 = A, *c2 = B;
> -       if (c1->order < c2->order)
> -               return -1;
> -       else if (c1->order > c2->order)
> -               return 1;
> -       return strcmp(c1->con, c2->con);
> -}
> -
>  int get_ordered_context_list_with_level(const char *user,
>                                         const char *level,
>                                         char * fromcon,
> @@ -395,11 +420,8 @@ int get_ordered_context_list(const char *user,
>                              char *** list)
>  {
>         char **reachable = NULL;
> -       unsigned int *ordering = NULL;
> -       struct context_order *co = NULL;
> -       char **ptr;
>         int rc = 0;
> -       unsigned int nreach = 0, nordered = 0, freefrom = 0, i;
> +       unsigned nreachable = 0, freefrom = 0;
>         FILE *fp;
>         char *fname = NULL;
>         size_t fname_len;
> @@ -413,23 +435,6 @@ int get_ordered_context_list(const char *user,
>                 freefrom = 1;
>         }
>
> -       /* Determine the set of reachable contexts for the user. */
> -       rc = security_compute_user(fromcon, user, &reachable);
> -       if (rc < 0)
> -               goto failsafe;
> -       nreach = 0;
> -       for (ptr = reachable; *ptr; ptr++)
> -               nreach++;
> -       if (!nreach)
> -               goto failsafe;
> -
> -       /* Initialize ordering array. */
> -       ordering = malloc(nreach * sizeof(unsigned int));
> -       if (!ordering)
> -               goto failsafe;
> -       for (i = 0; i < nreach; i++)
> -               ordering[i] = nreach;
> -
>         /* Determine the ordering to apply from the optional per-user config
>            and from the global config. */
>         fname_len = strlen(user_contexts_path) + strlen(user) + 2;
> @@ -440,8 +445,8 @@ int get_ordered_context_list(const char *user,
>         fp = fopen(fname, "re");
>         if (fp) {
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> -               rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
> -                                      &nordered);
> +               rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
> +
>                 fclose(fp);
>                 if (rc < 0 && errno != ENOENT) {
>                         fprintf(stderr,
> @@ -454,8 +459,7 @@ int get_ordered_context_list(const char *user,
>         fp = fopen(selinux_default_context_path(), "re");
>         if (fp) {
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> -               rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
> -                                      &nordered);
> +               rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
>                 fclose(fp);
>                 if (rc < 0 && errno != ENOENT) {
>                         fprintf(stderr,
> @@ -463,40 +467,18 @@ int get_ordered_context_list(const char *user,
>                                 __FUNCTION__, selinux_default_context_path());
>                         /* Fall through */
>                 }
> -               rc = 0;
> +               rc = nreachable;
>         }
>
> -       if (!nordered)
> +       if (!nreachable)
>                 goto failsafe;
>
> -       /* Apply the ordering. */
> -       co = malloc(nreach * sizeof(struct context_order));
> -       if (!co)
> -               goto failsafe;
> -       for (i = 0; i < nreach; i++) {
> -               co[i].con = reachable[i];
> -               co[i].order = ordering[i];
> -       }
> -       qsort(co, nreach, sizeof(struct context_order), order_compare);
> -       for (i = 0; i < nreach; i++)
> -               reachable[i] = co[i].con;
> -       free(co);
> -
> -       /* Only report the ordered entries to the caller. */
> -       if (nordered <= nreach) {
> -               for (i = nordered; i < nreach; i++)
> -                       free(reachable[i]);
> -               reachable[nordered] = NULL;
> -               rc = nordered;
> -       }
> -
>        out:
>         if (rc > 0)
>                 *list = reachable;
>         else
>                 freeconary(reachable);
>
> -       free(ordering);
>         if (freefrom)
>                 freecon(fromcon);
>
> --
> 2.25.0
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

