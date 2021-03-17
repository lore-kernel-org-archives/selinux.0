Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D6C433E6
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 09:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752C264F44
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 09:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCQJaC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 05:30:02 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53541 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQJ3b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 05:29:31 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 49F37564ED1
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 10:29:29 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id u18so473133plc.12
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 02:29:29 -0700 (PDT)
X-Gm-Message-State: AOAM5336T7/bObsAxFCYHEv7UH4/2rb4VmF2p68/+7Gp9KhuPlMuu0Ip
        9Zqb7K0l80m5JYWlNObAqTlVeeQnxc9O+j85ACA=
X-Google-Smtp-Source: ABdhPJyDTaSg8LTM4w0+xNTGpk/IMCA6xuKrkHHPCd7jqxNNFr9yHa/aJ02s1U/+pb1AtKJ6vAN4pmAOe0XQAro/PrY=
X-Received: by 2002:a17:90a:1642:: with SMTP id x2mr3901504pje.88.1615973367979;
 Wed, 17 Mar 2021 02:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210316203943.47733-1-jwcart2@gmail.com>
In-Reply-To: <20210316203943.47733-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 17 Mar 2021 10:29:16 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m0OfP6GCEJDY6zX=XJYPU=CZh+XsOp4Fh1YtinhrmxfA@mail.gmail.com>
Message-ID: <CAJfZ7=m0OfP6GCEJDY6zX=XJYPU=CZh+XsOp4Fh1YtinhrmxfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Write "NO_IDENTIFIER" for empty constraint expression
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Mar 17 10:29:29 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 9:40 PM James Carter <jwcart2@gmail.com> wrote:
>
> If a role attribute with no roles associated with it is used in a
> constraint expression, then the role bitmap will be empty. This is
> not a problem for the kernel, but does cause problems when
> converting a kernel policy to policy.conf.
>
> When creating a policy.conf from a kernel policy, if an empty bitmap
> is encountered, use the string "NO_IDENTIFIER". An error will occur
> if an attempt is made to compile the resulting policy, but this is
> better than exiting with an error without creating a policy.conf.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For these 2 patches:
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>  libsepol/src/kernel_to_conf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index a22f196d..263f9639 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -186,7 +186,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
>                                         names = ebitmap_to_str(&curr->names, pdb->p_role_val_to_name, 1);
>                                 }
>                                 if (!names) {
> -                                       goto exit;
> +                                       names = strdup("NO_IDENTIFIER");
>                                 }
>                                 new_val = create_str("%s %s %s", 3, attr1, op, names);
>                                 free(names);
> --
> 2.26.2
>

