Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD00C433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 22:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F596136F
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhJDWPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:15:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59693 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhJDWPa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 18:15:30 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1B94B5605CA
        for <selinux@vger.kernel.org>; Tue,  5 Oct 2021 00:13:39 +0200 (CEST)
Received: by mail-il1-f180.google.com with SMTP id b6so19957956ilv.0
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 15:13:39 -0700 (PDT)
X-Gm-Message-State: AOAM531zhNAmmajEjOjvudhCHf3s7V/ZdbsIYUKByuh0JnO+HyquFX19
        dBVDGy/ibj4PcjdI6K4vI1sm7U/mwnpy4c0Baq0=
X-Google-Smtp-Source: ABdhPJyl2coe1xrsEFbUTV+RXza0rV+HIVC+k/1/w+lKpk04IaDr2yc3r1PLpf+A8AsHRY+M4juvCZdXA4K8hpjhYBc=
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr343006ilv.73.1633385618160;
 Mon, 04 Oct 2021 15:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210928175521.79432-1-jwcart2@gmail.com>
In-Reply-To: <20210928175521.79432-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 5 Oct 2021 00:13:26 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kLPLT=jsqL7rMFEP=+LW6jHX_5icxjFp9u9j5h0qyDpg@mail.gmail.com>
Message-ID: <CAJfZ7=kLPLT=jsqL7rMFEP=+LW6jHX_5icxjFp9u9j5h0qyDpg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Limit the amount of reporting for bounds failures
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Oct  5 00:13:39 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 28, 2021 at 7:55 PM James Carter <jwcart2@gmail.com> wrote:
>
> Type bounds are checked when creating the CIL binary using libsepol
> functions on the binary policy db. The bad rule is reported and, to
> provide better error reporting, a search is made for matching rules
> in the CIL policy. These matching rules as well as their parents are
> written out with their locations to make it easier to find the rules
> that violate the type bounds.
>
> It is possible to craft CIL policies where there are many rules
> that violate a bounds check each with many matching rules as well.
> This can make the error messages very difficult to deal with. For
> example, if there are 100 rules in the binary policy db that violate
> a type bounds and each of these rules has 100 matches, then 10,000
> matching rules along with their parents will be written out as part
> of the error message.
>
> Limit the error reporting to two rules for each type bounds violation
> along with two matches for each of those rules.
>
> This problem was found with the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Hello,
I confirm this fixes the issue reported in
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36246&q=selinux&can=2
which can be reproduced with this CIL policy:

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
(boolean BOOL false)
(type TYPE_2)
(typeattribute TYPEATTR)
(block B0
(blockinherit B1)(block B1
(blockinherit B2)(block B2
(blockinherit B3)(block B3
(blockinherit B4)(block B4
(blockinherit B5)(block B5
(blockinherit B6)(block B6
(blockinherit B7)(block B7
(type TYPE_3)
(typebounds TYPE_2 TYPE_3)
(typeattributeset TYPEATTR TYPE_3)
(booleanif BOOL(true(allow TYPEATTR TYPE (CLASS (PERM)))))
))))))))

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

By the way, even though the patch looks good to me, my personal
preference would have been to use "unsigned int" types (or size_t) to
count rules, instead of signed int.

Thanks,
Nicolas

> ---
>  libsepol/cil/src/cil_binary.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 4a80cb56..ec5f01e5 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4825,6 +4825,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>                         avtab_ptr_t cur;
>                         struct cil_avrule target;
>                         struct cil_tree_node *n1 = NULL;
> +                       int count_bad = 0;
>
>                         *violation = CIL_TRUE;
>
> @@ -4838,6 +4839,8 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>                         for (cur = bad; cur; cur = cur->next) {
>                                 struct cil_list_item *i2;
>                                 struct cil_list *matching;
> +                               int num_matching = 0;
> +                               int count_matching = 0;
>
>                                 rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
>                                 if (rc != SEPOL_OK) {
> @@ -4855,6 +4858,9 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>                                         bounds_destroy_bad(bad);
>                                         goto exit;
>                                 }
> +                               cil_list_for_each(i2, matching) {
> +                                       num_matching++;
> +                               }
>                                 cil_list_for_each(i2, matching) {
>                                         struct cil_tree_node *n2 = i2->data;
>                                         struct cil_avrule *r2 = n2->data;
> @@ -4865,9 +4871,19 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>                                                 __cil_print_parents("    ", n2);
>                                                 __cil_print_rule("      ", "allow", r2);
>                                         }
> +                                       count_matching++;
> +                                       if (count_matching >= 2) {
> +                                               cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
> +                                               break;
> +                                       }
>                                 }
>                                 cil_list_destroy(&matching, CIL_FALSE);
>                                 cil_list_destroy(&target.perms.classperms, CIL_TRUE);
> +                               count_bad++;
> +                               if (count_bad >= 2) {
> +                                       cil_log(CIL_ERR, "  Only first 2 of %d bad rules shown\n", numbad);
> +                                       break;
> +                               }
>                         }
>                         bounds_destroy_bad(bad);
>                 }
> --
> 2.31.1
>

