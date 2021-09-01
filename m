Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA590C432BE
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3B661058
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIATXq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:23:46 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59373 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhIATXp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Sep 2021 15:23:45 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 18F1856122C
        for <selinux@vger.kernel.org>; Wed,  1 Sep 2021 21:22:47 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id e16so623006pfc.6
        for <selinux@vger.kernel.org>; Wed, 01 Sep 2021 12:22:47 -0700 (PDT)
X-Gm-Message-State: AOAM531hRJ+jCIp/AUYmFoGlwxsl0nMAIE0jGwj8xDF1bwcakC3lOycM
        EIpbSVQv+pFfflYSXyOAuNNkvA5mN7IiS/QAyTI=
X-Google-Smtp-Source: ABdhPJyJ60lCsT63jaznipxleVKmCbtNcClDwpHDepK5idZiQLFclnZuApbWWaF9uVXfA3QnUAofVg/rXsbTR+xT9XQ=
X-Received: by 2002:a62:5e02:0:b0:3ef:81bc:be25 with SMTP id
 s2-20020a625e02000000b003ef81bcbe25mr901398pfb.11.1630524165811; Wed, 01 Sep
 2021 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210827141955.370777-1-jwcart2@gmail.com>
In-Reply-To: <20210827141955.370777-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 1 Sep 2021 21:22:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m_PJj2SaSqGs7phPhTYnfRD_fSxhVPZJwZXet2yMjrmw@mail.gmail.com>
Message-ID: <CAJfZ7=m_PJj2SaSqGs7phPhTYnfRD_fSxhVPZJwZXet2yMjrmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Properly check parse tree when printing
 error messages
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Sep  1 21:22:47 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 27, 2021 at 4:20 PM James Carter <jwcart2@gmail.com> wrote:
>
> The function cil_tree_get_next_path() does not check whether the
> parse tree node that stores the high-level language file path of a
> src_info rule actually exists before trying to read the path. This
> can result in a NULL dereference.
>
> Check that all of the parse tree nodes of a src_info rule exist
> before reading the data from them.
>
> This bug was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For the 3 patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  libsepol/cil/src/cil_tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 75293005..e70722ec 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -62,7 +62,10 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
>
>         while (node) {
>                 if (node->flavor == CIL_NODE && node->data == NULL) {
> -                       if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
> +                       if (node->cl_head && node->cl_head->data == CIL_KEY_SRC_INFO) {
> +                               if (!node->cl_head->next || !node->cl_head->next->next || !node->cl_head->next->next->next) {
> +                                       goto exit;
> +                               }
>                                 /* Parse Tree */
>                                 *info_kind = node->cl_head->next->data;
>                                 rc = cil_string_to_uint32(node->cl_head->next->next->data, hll_line, 10);
> --
> 2.31.1
>

