Return-Path: <SRS0=8S61=Y2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BACA9EC7
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14621726
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKBRQu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:16:50 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:54613 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBRQu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Nov 2019 13:16:50 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3E0F6561296
        for <selinux@vger.kernel.org>; Sat,  2 Nov 2019 18:16:46 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id 94so11016140oty.8
        for <selinux@vger.kernel.org>; Sat, 02 Nov 2019 10:16:46 -0700 (PDT)
X-Gm-Message-State: APjAAAW35r52l3Gl4gJVl3wx3F09Mi18vh7LKOntuq2ta7uI2u+JfJ8a
        /IU0Vs8hiMgTvGG3IAe1WOuZJhzaUj6dgArAuDE=
X-Google-Smtp-Source: APXvYqzu+e2gyCSWn7r87FkxYvLcucQyRxSG97lsEoDp82uADbWVH2FYRfUvtO6Ri3BuNhtyQgE93CazEzWZD25OIQU=
X-Received: by 2002:a05:6830:1587:: with SMTP id i7mr13526046otr.321.1572715005183;
 Sat, 02 Nov 2019 10:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191101151903.15554-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20191101151903.15554-1-jwcart2@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 2 Nov 2019 18:16:33 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nLxMZz_Y_m59gzn1fo=wXeDtn2fFMbHpv_9erZKOedZQ@mail.gmail.com>
Message-ID: <CAJfZ7=nLxMZz_Y_m59gzn1fo=wXeDtn2fFMbHpv_9erZKOedZQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Report disabling an optional block only at
 high verbose levels
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Nov  2 18:16:46 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 1, 2019 at 4:25 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
>
> Since failing to resolve a statement in an optional block is normal,
> only display messages about the statement failing to resolve and the
> optional block being disabled at the highest verbosity level.
>
> These messages are now only at log level CIL_INFO instead of CIL_WARN.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

I confirm that this fixes the issue I experienced with "semodule
--verbose -B" being much noisier in 3.0-rc1 than in 2.9.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks
Nicolas

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 70a60bdf..87575860 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3761,14 +3761,16 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
>                 enum cil_log_level lvl = CIL_ERR;
>
>                 if (optstack != NULL) {
> -                       lvl = CIL_WARN;
> +                       lvl = CIL_INFO;
>
>                         struct cil_optional *opt = (struct cil_optional *)optstack->data;
>                         struct cil_tree_node *opt_node = opt->datum.nodes->head->data;
> -                       cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
>                         /* disable an optional if something failed to resolve */
>                         opt->enabled = CIL_FALSE;
> +                       cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
> +                       cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
>                         rc = SEPOL_OK;
> +                       goto exit;
>                 }
>
>                 cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
> --
> 2.21.0
>

