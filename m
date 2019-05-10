Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1574C04AB1
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 01:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB253217D7
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 01:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReX6XQf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEJBo1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 May 2019 21:44:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34310 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfEJBo1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 May 2019 21:44:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so4180365otq.1
        for <selinux@vger.kernel.org>; Thu, 09 May 2019 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyX9kO7eiieOb51/bz7FaqzkRoGpEx5qUQbtFDZ1wts=;
        b=ReX6XQf4CjcmxB9/nRumtEIP38R6Oe8mdTtCZonJoJ4GvesL/2oEDryjNUxu8C3tOk
         QSRcg4bCUSbkiv2Db6XS5Bc4ln15GtQG/imqSAJdZd6GfJzlfc6jbABAR6jw5ObhE3Rx
         jeJ08xtas72BqogJ8eNyzda9DIJcM6bepZWKlAFpDouQSRisd/G8b2WGhzU9x4b+7Z8T
         gRDToGupQo8IExgcSCni6iTvASG/PM7zYunPRVWMBBGAQYU8klVRYsL+dUgSmH1qtuto
         Kr8NDVFGtTbPz7cO6NAaF3ikNI55V2ziFHiFd90xN1WzuCqj7W0PzR34jPhcXGrOPhSo
         jV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyX9kO7eiieOb51/bz7FaqzkRoGpEx5qUQbtFDZ1wts=;
        b=slJ/YynwHDmyHom/6ait9vP5i/2f6vSBKvJumIz+0wJnDJcxgApF32gpkc1kDg+HnD
         /Pl+1quCtuVWqTNMOPv3NSPKLKm7Q8VqN4lJUgWy/QQ2jPgzx5vprMTFS8Nd18xyc3Aw
         s3p9fNB2GKgNUM1QAEMLC2rgnZCrb5GNnD/3C7g3vRs9EfIqrk0xxO0Z7tDDbm27m9v5
         4yQ77mdq5FnJGXzSHv2FxxTEj2E58h26PuUtH1s3QXU0JWsUyvmUaFsGGPob27MiOGDM
         UxmGm0r5b1VRHlUC/lJY6sIAdURyXerU58LQFLr6NIqLdwpM/lZ7mshLb4joORRMIOwL
         l2bg==
X-Gm-Message-State: APjAAAU2L8A9yGgpm3qvSs7ilj0rQAKiTFapR9b2PZlVBRHjCaLjjBA/
        +eG2P+jZdaoghFdL9pcD7XNvVpWJqvUJmORk1kEazaAGFcg=
X-Google-Smtp-Source: APXvYqwJgBmkLpDwZW+l6IERCok7aOHPwkq+BWt3dvf8+1GvpSr6XYQMaLnyZLZB3yZVqmHiZ3mHygLakmW1xXPMs6s=
X-Received: by 2002:a9d:6543:: with SMTP id q3mr4596721otl.370.1557452666070;
 Thu, 09 May 2019 18:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190509084204.26198-1-plautrba@redhat.com>
In-Reply-To: <20190509084204.26198-1-plautrba@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 9 May 2019 18:44:14 -0700
Message-ID: <CAFftDdpQvKewRi6LZT0BfzqXeZ5at0Azk-ECi7asf6-XF2Aukw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 9, 2019 at 1:43 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
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

Whats the best way to test this?

>
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/get_context_list.c | 185 ++++++++++--------------------
>  1 file changed, 60 insertions(+), 125 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e4658..a36c6253 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -114,61 +114,24 @@ int get_default_context(const char *user,
>         return 0;
>  }
>
> -static int find_partialcon(char ** list,
> -                          unsigned int nreach, char *part)
> -{
> -       const char *conrole, *contype;
> -       char *partrole, *parttype, *ptr;
> -       context_t con;
> -       unsigned int i;
> -
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
> -               }
> -               context_free(con);
> -       }
> -
> -       return -1;
> -}
> -
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
>         size_t line_len = 0;
> -       ssize_t len;
> +       ssize_t len, ulen;
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
> @@ -180,7 +143,8 @@ static int get_context_order(FILE * fp,
>                 return -1;
>         fromrole = context_role_get(con);
>         fromtype = context_type_get(con);
> -       if (!fromrole || !fromtype) {
> +       fromlevel = context_range_get(con);
> +       if (!fromrole || !fromtype || !fromlevel) {
>                 context_free(con);
>                 return -1;
>         }
> @@ -243,23 +207,52 @@ static int get_context_order(FILE * fp,
>                 if (*end)
>                         *end++ = 0;
>
> -               /* Check for a match in the reachable list. */
> -               rc = find_partialcon(reachable, nreach, start);
> -               if (rc < 0) {
> -                       /* No match, skip it. */
> -                       start = end;
> -                       continue;
> +               /* Check whether a new context is valid */
> +               ulen = strlen(user) + strlen(start) + 1;

is their anything guaranteeing this doesn't overflow and result in
malloc(0) which is undefined?
also ulen is signed, why? All uses are where a size_t is valid, I
think it can change to a size_t.

> +               usercon_str = malloc(ulen);

spaces after tab, see:
https://github.com/SELinuxProject/selinux/pull/146/files#diff-55a16252233f48b841c06ffbe22bb66dR211

> +               if (!usercon_str) {
> +                       rc = -1;
> +                       goto out;
>                 }
>
> -               /* If a match is found and the entry is not already ordered
> -                  (e.g. due to prior match in prior config file), then set
> -                  the ordering for it. */
> -               i = rc;
> -               if (ordering[i] == nreach)
> -                       ordering[i] = (*nordered)++;
> +               /* set range from fromcon in the new usercon */
> +               snprintf(usercon_str, ulen - 1, "%s:%s", user, start);
> +               if (!(usercon = context_new(usercon_str))) {

You can drop the too free(usercon_str) if you rework this logic:
usercon = context_new(usercon_str))
free(usercon_str);
if (!usercon) {
    // error
    continue;
}

> +                       fprintf(stderr,
> +                               "%s: can't create a context from %s\n",
> +                               __FUNCTION__, usercon_str);
> +                       free(usercon_str);
> +
> +                       continue;

Why is it OK to continue?

> +               }
> +               free(usercon_str);
> +               context_range_set(usercon, fromlevel);
> +               usercon_str = context_str(usercon);
> +
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

oom error

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
> @@ -313,21 +306,6 @@ static int get_failsafe_context(const char *user, char ** newcon)
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
> @@ -395,11 +373,8 @@ int get_ordered_context_list(const char *user,
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
> @@ -413,23 +388,6 @@ int get_ordered_context_list(const char *user,
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
> @@ -440,8 +398,8 @@ int get_ordered_context_list(const char *user,
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
> @@ -454,8 +412,7 @@ int get_ordered_context_list(const char *user,
>         fp = fopen(selinux_default_context_path(), "re");
>         if (fp) {
>                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> -               rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
> -                                      &nordered);
> +               rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
>                 fclose(fp);
>                 if (rc < 0 && errno != ENOENT) {
>                         fprintf(stderr,
> @@ -463,40 +420,18 @@ int get_ordered_context_list(const char *user,
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
> 2.21.0
>
