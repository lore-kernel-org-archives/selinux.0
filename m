Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A34C433F5
	for <selinux@archiver.kernel.org>; Tue,  5 Oct 2021 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1D61139
	for <selinux@archiver.kernel.org>; Tue,  5 Oct 2021 21:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhJEVEA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhJEVEA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Oct 2021 17:04:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF7C061749
        for <selinux@vger.kernel.org>; Tue,  5 Oct 2021 14:02:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x124so1033885oix.9
        for <selinux@vger.kernel.org>; Tue, 05 Oct 2021 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/kXiJX41K06grmPtnbfrE5BvCqY6+eKkwDjRlRfRBY=;
        b=FxY/DQ4NuOcJPRgM/BdMGhOOVhvHFf+tZLTmAeClNGMFgxRHRCM+X3pe2PV8BuCc+T
         +FAZWv3CiJG4rU+6VpI81GXcg75CMsdE9MWux4UYr1BrQo945UI4ayDUr+y/VEGXPhpI
         Fef3n092LvJ2dMoOnha6P0HGbDIfUTQ9OZ+BeXLCghwrjCdCpj+6c7ufeEmTl8vQfh/6
         YAnITD+QICzJl6qxOHmUQ56+PemX1ZaV+60n19gyAAR+dJvylVje83jnW8ojr9vc/Zr3
         5Kf2BB4aWOPDoHcXayQgPyuX+D6fSR9So8UEUYcaFMX/Q1Gpg5dmCyLZS3rSf/rIlfLe
         8wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/kXiJX41K06grmPtnbfrE5BvCqY6+eKkwDjRlRfRBY=;
        b=eOmqmYAyMsTNEj5gJeLwnia8sW+zRcFmbreEP/yavTj/lt1Ky76zd0G6xdOqtlJV6e
         4Tqg3yzkZGObVM9Mieb4q/js7jO121fkX8xRE3mNLTreZvTb69Q9Z9U+6tS4FdjYIgaL
         hZF5AZhqdijR+RY8+Ai4g1n2PtVxpU/KQggTEQhSczOhpA3qwf+sopFnLo87pauXycZZ
         aIjrDR9WliMyjy6oky/1rNM/EAc7VXT0yW3PngkN6elh0t37nd9RGnKBXSy5Ddt8IOz9
         iolyXQac+gHGUs7A6fQNpKL9kq3zwgYZmsLAsULYwqBggU40atKxZMiwcHX3AOrPSbZ+
         cnUQ==
X-Gm-Message-State: AOAM5303FQwW3DcGw3qfy/9lVhNVvygbvDUwzsVGS+KS62vcYP7u25y7
        CMDwJ9tDK52FNapFUTZ0Ha/2Hq2E2qn2avhvc3qn7KpJ
X-Google-Smtp-Source: ABdhPJyqchtu0gxFwvysNsR/P6vwodY6dUIor6dvW0A1rf2chQp/AcrNAQ6uFQoFf83RNwlnOl6C3Da9k+vbAe/aPNw=
X-Received: by 2002:aca:1c07:: with SMTP id c7mr4218198oic.16.1633467728700;
 Tue, 05 Oct 2021 14:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210928175521.79432-1-jwcart2@gmail.com> <CAJfZ7=kLPLT=jsqL7rMFEP=+LW6jHX_5icxjFp9u9j5h0qyDpg@mail.gmail.com>
In-Reply-To: <CAJfZ7=kLPLT=jsqL7rMFEP=+LW6jHX_5icxjFp9u9j5h0qyDpg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 5 Oct 2021 17:01:57 -0400
Message-ID: <CAP+JOzQ8qyGyeWt3Vo9kwS5Rx_atrH_3TN95HJoC-psOtFXxhA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Limit the amount of reporting for bounds failures
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 4, 2021 at 6:13 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Sep 28, 2021 at 7:55 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Type bounds are checked when creating the CIL binary using libsepol
> > functions on the binary policy db. The bad rule is reported and, to
> > provide better error reporting, a search is made for matching rules
> > in the CIL policy. These matching rules as well as their parents are
> > written out with their locations to make it easier to find the rules
> > that violate the type bounds.
> >
> > It is possible to craft CIL policies where there are many rules
> > that violate a bounds check each with many matching rules as well.
> > This can make the error messages very difficult to deal with. For
> > example, if there are 100 rules in the binary policy db that violate
> > a type bounds and each of these rules has 100 matches, then 10,000
> > matching rules along with their parents will be written out as part
> > of the error message.
> >
> > Limit the error reporting to two rules for each type bounds violation
> > along with two matches for each of those rules.
> >
> > This problem was found with the secilc-fuzzer.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Hello,
> I confirm this fixes the issue reported in
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36246&q=selinux&can=2
> which can be reproduced with this CIL policy:
>
> (class CLASS (PERM))
> (classorder (CLASS))
> (sid SID)
> (sidorder (SID))
> (user USER)
> (role ROLE)
> (type TYPE)
> (category CAT)
> (categoryorder (CAT))
> (sensitivity SENS)
> (sensitivityorder (SENS))
> (sensitivitycategory SENS (CAT))
> (allow TYPE self (CLASS (PERM)))
> (roletype ROLE TYPE)
> (userrole USER ROLE)
> (userlevel USER (SENS))
> (userrange USER ((SENS)(SENS (CAT))))
> (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
> (boolean BOOL false)
> (type TYPE_2)
> (typeattribute TYPEATTR)
> (block B0
> (blockinherit B1)(block B1
> (blockinherit B2)(block B2
> (blockinherit B3)(block B3
> (blockinherit B4)(block B4
> (blockinherit B5)(block B5
> (blockinherit B6)(block B6
> (blockinherit B7)(block B7
> (type TYPE_3)
> (typebounds TYPE_2 TYPE_3)
> (typeattributeset TYPEATTR TYPE_3)
> (booleanif BOOL(true(allow TYPEATTR TYPE (CLASS (PERM)))))
> ))))))))
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> By the way, even though the patch looks good to me, my personal
> preference would have been to use "unsigned int" types (or size_t) to
> count rules, instead of signed int.
>

I went with int types because numbad, which is assigned a value in the
libsepol function bounds_check_type(), is an int. I would want them to
all be the same type and I don't want to change bounds_check_type(),
so I think that I will leave them as ints.

Thanks for the review.

Jim

> Thanks,
> Nicolas
>
> > ---
> >  libsepol/cil/src/cil_binary.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index 4a80cb56..ec5f01e5 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -4825,6 +4825,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
> >                         avtab_ptr_t cur;
> >                         struct cil_avrule target;
> >                         struct cil_tree_node *n1 = NULL;
> > +                       int count_bad = 0;
> >
> >                         *violation = CIL_TRUE;
> >
> > @@ -4838,6 +4839,8 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
> >                         for (cur = bad; cur; cur = cur->next) {
> >                                 struct cil_list_item *i2;
> >                                 struct cil_list *matching;
> > +                               int num_matching = 0;
> > +                               int count_matching = 0;
> >
> >                                 rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
> >                                 if (rc != SEPOL_OK) {
> > @@ -4855,6 +4858,9 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
> >                                         bounds_destroy_bad(bad);
> >                                         goto exit;
> >                                 }
> > +                               cil_list_for_each(i2, matching) {
> > +                                       num_matching++;
> > +                               }
> >                                 cil_list_for_each(i2, matching) {
> >                                         struct cil_tree_node *n2 = i2->data;
> >                                         struct cil_avrule *r2 = n2->data;
> > @@ -4865,9 +4871,19 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
> >                                                 __cil_print_parents("    ", n2);
> >                                                 __cil_print_rule("      ", "allow", r2);
> >                                         }
> > +                                       count_matching++;
> > +                                       if (count_matching >= 2) {
> > +                                               cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
> > +                                               break;
> > +                                       }
> >                                 }
> >                                 cil_list_destroy(&matching, CIL_FALSE);
> >                                 cil_list_destroy(&target.perms.classperms, CIL_TRUE);
> > +                               count_bad++;
> > +                               if (count_bad >= 2) {
> > +                                       cil_log(CIL_ERR, "  Only first 2 of %d bad rules shown\n", numbad);
> > +                                       break;
> > +                               }
> >                         }
> >                         bounds_destroy_bad(bad);
> >                 }
> > --
> > 2.31.1
> >
>
