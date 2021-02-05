Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD4C433E0
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 02:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC61865011
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 02:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBFCfN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 21:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBFCco (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 21:32:44 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A96C061786
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 13:59:30 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id z36so2006677ooi.6
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvEocxIgt6yQ45L/1PBW5hc206MBEFwguIUpsixCgVg=;
        b=JRhHWnYPT1y1Z8SCfJn8lk3u8V7dc7UCDMQEHSvvv1/rTqESJa3Qm0KhKvryg09hRr
         PYJg7CkHiBnC+yInqjDmqop/GwFb77jpvWQ4Egs/b67XmNkWA94aP8TTqkfsTrlI8B1k
         9RmXWeP7+BEJl+vAUvJb58JVIACN4vhLRjxsE/CD8lhLhM+mVy8qsCbd5gZJH7IpN54P
         VTeZL6GnTdfpx+aIcdCaDUOfRcInvec3RbMFYyQ9O9tIuTg8mUUj+SaLeAzyu/ufE2B6
         HR22wbgKp6Nb4/bF8fGfFnTTZ5ba7Ws8KGRe+wfaLE+HRVpGKI1Az6QlpoRZUyi/nIeH
         In3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvEocxIgt6yQ45L/1PBW5hc206MBEFwguIUpsixCgVg=;
        b=Fjlq76CNL874YpQlL3JjeVbyE0A8EiLa7Ygqa2/RUQdAXupdjwIxTyU9gFGqg4yCwt
         4xNhQkueEBAHLae751twn6oFH3g6RvQzYTCdvkjDV09xOnYQqEK4gyx0DUgBZ/2zVr5S
         RUapL72HHLE+TuTdcdlhLXyfQNYuD1LCJY0KSw1349bn6pvcjMY08yeO4IjGcBdNeRdV
         /ZGkQcqh3l/XPvFQNRQiIGh7HypinhVGCWccp0ptLv6836ohEVM/IYUPCxW704Csj1c0
         E8O5wcY+3Ae4NS4RSsrSh8QBA5oaX1Vl3MeE9gfw4P9eUuV7geEcu5Cz4RtN0bPzdUr4
         bNTQ==
X-Gm-Message-State: AOAM5321I2YfaaD0+YNk3byGlfzSOfNKD801QPCqX9y25e+TprsSuwBe
        0RGwQesHrFLHhakmmJLhd6cwCnjOPM068mRJrV+dD0go2+bQWg==
X-Google-Smtp-Source: ABdhPJynh058Tzm98n5rkDy66mTuKAQG1JJN8ycNuTdLgjq0TyjJUoXJBPPrPOwnEgYKFeSLjpE7dD21fK5RZTwfET0=
X-Received: by 2002:a4a:1881:: with SMTP id 123mr4932481ooo.59.1612562369477;
 Fri, 05 Feb 2021 13:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20210205094539.388854-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210205094539.388854-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 5 Feb 2021 16:59:18 -0500
Message-ID: <CAP+JOzTC7171KWZkbTZSmrXD6u8RkT1DRfHvoARAoKuom-o4nQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: fix NULL pointer dereference with empty
 macro argument
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 4:54 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
> to compile the following policy:
>
>     (macro m((name n))) (call m(()))
>
> When calling the macro, the name (in variable "pc") is NULL, which
> triggers a NULL pointer dereference when using it as a key in
> __cil_insert_name(). The stack trace is:
>
>     #0 0x7f4662655a85 in __strlen_avx2 (/usr/lib/libc.so.6+0x162a85)
>     #1 0x556d0b6d150c in __interceptor_strlen.part.0 (/selinux/libsepol/fuzz/fuzz-secilc+0x44850c)
>     #2 0x556d0ba74ed6 in symhash /selinux/libsepol/src/symtab.c:22:9
>     #3 0x556d0b9ef50d in hashtab_search /selinux/libsepol/src/hashtab.c:186:11
>     #4 0x556d0b928e1f in cil_symtab_get_datum /selinux/libsepol/src/../cil/src/cil_symtab.c:121:37
>     #5 0x556d0b8f28f4 in __cil_insert_name /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:96:2
>     #6 0x556d0b908184 in cil_resolve_call1 /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:2835:12
>     #7 0x556d0b91b404 in __cil_resolve_ast_node /selinux/libsepol/src/../cil/src/cil_resolve_ast.c
>     #8 0x556d0b91380f in __cil_resolve_ast_node_helper /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:3773:7
>     #9 0x556d0b932230 in cil_tree_walk_core /selinux/libsepol/src/../cil/src/cil_tree.c:263:9
>     #10 0x556d0b932230 in cil_tree_walk /selinux/libsepol/src/../cil/src/cil_tree.c:307:7
>     #11 0x556d0b932326 in cil_tree_walk_core /selinux/libsepol/src/../cil/src/cil_tree.c:275:9
>     #12 0x556d0b932326 in cil_tree_walk /selinux/libsepol/src/../cil/src/cil_tree.c:307:7
>     #13 0x556d0b911189 in cil_resolve_ast /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:3941:8
>     #14 0x556d0b798729 in cil_compile /selinux/libsepol/src/../cil/src/cil.c:550:7
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28544
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Wow, that function is getting long and ugly. It probably needs to be
refactored at some point. At any rate, your patch is good.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 79 ++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 0c85eabe5a81..9300cd2be9be 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2828,6 +2828,12 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                         switch (flavor) {
>                         case CIL_NAME: {
>                                 struct cil_name *name;
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 name = __cil_insert_name(args->db, pc->data, current);
>                                 if (name != NULL) {
>                                         new_arg->arg = (struct cil_symtab_datum *)name;
> @@ -2837,21 +2843,57 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                         }
>                                 break;
>                         case CIL_TYPE:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_ROLE:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_USER:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_SENS:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_CAT:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_BOOL:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_CATSET: {
> @@ -2871,6 +2913,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                                         cil_list_append(((struct cil_symtab_datum*)catset)->nodes,
>                                                                         CIL_LIST_ITEM, cat_node);
>                                         new_arg->arg = (struct cil_symtab_datum*)catset;
> +                               } else if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
>                                 } else {
>                                         new_arg->arg_str = pc->data;
>                                 }
> @@ -2896,6 +2943,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                                         cil_list_append(((struct cil_symtab_datum*)level)->nodes,
>                                                                         CIL_LIST_ITEM, lvl_node);
>                                         new_arg->arg = (struct cil_symtab_datum*)level;
> +                               } else if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
>                                 } else {
>                                         new_arg->arg_str = pc->data;
>                                 }
> @@ -2921,6 +2973,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                                         cil_list_append(((struct cil_symtab_datum*)range)->nodes,
>                                                                         CIL_LIST_ITEM, range_node);
>                                         new_arg->arg = (struct cil_symtab_datum*)range;
> +                               } else if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
>                                 } else {
>                                         new_arg->arg_str = pc->data;
>                                 }
> @@ -2946,6 +3003,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                                         cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
>                                                                         CIL_LIST_ITEM, addr_node);
>                                         new_arg->arg = (struct cil_symtab_datum*)ipaddr;
> +                               } else if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
>                                 } else {
>                                         new_arg->arg_str = pc->data;
>                                 }
> @@ -2953,9 +3015,21 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                                 break;
>                         }
>                         case CIL_CLASS:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_MAP_CLASS:
> +                               if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
> +                               }
>                                 new_arg->arg_str = pc->data;
>                                 break;
>                         case CIL_CLASSPERMISSION: {
> @@ -2976,6 +3050,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>                                         cp_node->data = cp;
>                                         cil_list_append(cp->datum.nodes, CIL_LIST_ITEM, cp_node);
>                                         new_arg->arg = (struct cil_symtab_datum*)cp;
> +                               } else if (pc->data == NULL) {
> +                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> +                                       cil_destroy_args(new_arg);
> +                                       rc = SEPOL_ERR;
> +                                       goto exit;
>                                 } else {
>                                         new_arg->arg_str = pc->data;
>                                 }
> --
> 2.30.0
>
