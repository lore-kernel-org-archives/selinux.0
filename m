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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5372DC433DB
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BF464E7B
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 19:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbhBDTWm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbhBDTW2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 14:22:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DBC061786
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 11:21:48 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d7so2271056otq.6
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyt5ECATksODRqk7y6CaYLLuBXd2sAczYokqmt7mbsI=;
        b=NGhtXTDlmG3wZ6nH+gIc8/keqrCLMdRteAVc8BizZOsqnkjb3NXiNsROoyMe2dqUNt
         Ov4d8gTl0A7IGbXNDV9yAqTc1YTT7FW554bquZRwZdIYL9otr7yBeR9dVAqG5bAhcUlA
         tzIpUFpXXetW8iomZdYqO88ezJBi1bwPJmD754v8qZp9BCx4+NLwGnGIqJCmGh4UvTUH
         6fWm5iucXSbwVISHnJSAdrS1d77HV4WVzhUede0X46wDwLW0z4VSj0x4FS1R4fheWsLL
         FDUOex/VQNtVJOupBeF6WmmgP7b/x13mEg5wvS2K8wDdELk6wn8yIZsDrLCjEJK+Gxd6
         ErGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyt5ECATksODRqk7y6CaYLLuBXd2sAczYokqmt7mbsI=;
        b=glB+xPVbtFKN6HdTomrPpU4heAENrGqfIShJUsDtNPMSbQTAoyBOCr6ibxXxsg5tqw
         VThgvFOs/HgJ8MNphzgMnAM1+KcjjsuonZVTqPCEE3D97LCGp4kk9/Fty7uwRqTjufZe
         HFjnIuE2o28i6TE1J7G8xMuRLXJDytIVqPrssKtWqE5aKYsx8wGpeE3H2Hl67+2/jW2/
         ut7/fQ1acULb8RgA48AOXzJav3cIqwkQFwXAuuQrBOtzPolXIipxyC6AbcGZZztMsrtY
         FCh+Fb2huPNdQboUwOeYTgN2CXg/VQrSwkjm4uXRKpbTB4fVn+ukZuh1gEMUiYNjlsyR
         t0bg==
X-Gm-Message-State: AOAM530XlZUajGh0Vd5GFsfz+OHm5VcvMPG2icv37xgBPWQUr7VHJcPl
        Z1naKvqYXRlruXgFqv+bb70/P6F8yjh8QHyksMHXKSi6rDg=
X-Google-Smtp-Source: ABdhPJwVGZX3p08wRmQJjGUuNffKl8/yeRtin5e80rbx6uKT4IR7zVv/TUSQoW02gsITo0fG/c9lhYDnTSl9wvgiWV4=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr700439otu.59.1612466507509;
 Thu, 04 Feb 2021 11:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20210203085846.6680-1-nicolas.iooss@m4x.org> <20210203085846.6680-2-nicolas.iooss@m4x.org>
In-Reply-To: <20210203085846.6680-2-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 Feb 2021 14:26:49 -0500
Message-ID: <CAP+JOzRUB6YWwTK1vx6hUuCw7SmPYa2vJQ1PA8mWbEN+8GLBqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: uniformize prototypes of sepol_mls_contains
 and sepol_mls_check
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 3, 2021 at 4:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> In libsepol/src/mls.c, functions sepol_mls_contains and sepol_mls_check
> used "sepol_policydb_t * policydb" even though
> libsepol/include/sepol/context.h used "const sepol_policydb_t *
> policydb".
>
> Add const qualifiers in mls.c in order to match the header file. Detect
> such mismatching error at compile time by including the header file in
> mls.c.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/mls.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index 1ee90cf8dee1..366a1114ce96 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -27,6 +27,7 @@
>   * Implementation of the multi-level security (MLS) policy.
>   */
>
> +#include <sepol/context.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/services.h>
>  #include <sepol/policydb/context.h>
> @@ -664,7 +665,7 @@ int mls_compute_sid(policydb_t * policydb,
>  }
>
>  int sepol_mls_contains(sepol_handle_t * handle,
> -                      sepol_policydb_t * policydb,
> +                      const sepol_policydb_t * policydb,
>                        const char *mls1, const char *mls2, int *response)
>  {
>
> @@ -703,7 +704,7 @@ int sepol_mls_contains(sepol_handle_t * handle,
>  }
>
>  int sepol_mls_check(sepol_handle_t * handle,
> -                   sepol_policydb_t * policydb, const char *mls)
> +                   const sepol_policydb_t * policydb, const char *mls)
>  {
>
>         int ret;
> --
> 2.30.0
>
