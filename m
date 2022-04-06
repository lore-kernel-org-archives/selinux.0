Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E3C433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 17:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiDFSAX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiDFSAN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 14:00:13 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185378A6CE
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 09:16:10 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de3ca1efbaso3419933fac.9
        for <selinux@vger.kernel.org>; Wed, 06 Apr 2022 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7SZNBJWXDjJ7hxZcvxuAOM0n0DY6zjfGG6h+Dgpu2A8=;
        b=CfoaEb6lJmSdzzaZN7HNt14PBGW44suB/xrD2QOGltFISxk6wfL3YqOaTC2mMRRCDv
         julKS1Ujut8plUEu71RQttJDVwYyp0t6RanMMxl8tkyanQ3GvU1qcvhQbxryn+m1zMys
         G+SiWG692idSk8U9+NyhJeLH64f9kTfQkeQpFnhfrBQIP8fEm0ET/WJvAAI3vB0Ki+HT
         SI4jCUp2/1N0POkXKvdo2TsAv4YxiogBw11BgP703LI+gJoMNZN4IHGhCJUFsudq/qxb
         MVf0oPpj9W7Ue8964FeUXM4w/qbCqa7Badbt58sFAGtrVEjHDI3fkMoPiGdzhMy+tKsD
         XdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7SZNBJWXDjJ7hxZcvxuAOM0n0DY6zjfGG6h+Dgpu2A8=;
        b=LfzkHHIdJmNWAwIsSXpSb+AFXYbeJsUFr07SCNxGXLsf/j5xgOTv0RNy5KgtDKVVL1
         TUIWh5hJNSh+EAIhj8HIhutCkeS4BIbAX/4GiMKgRdtlwrYk7tNFBrnZI5vyz5vEQelT
         s/fznBdknxkPWV1a7YahU/EacwK+4wRp2J9gZzmt9t0DrfA86XsBwDcvV1UbHXPiAufo
         Uhqpi/ExAcxFlH+V0RTSaQFgid4EhBU7rWPAums+5MqhKpjbnZ9RPqUbcs85QhP3/OEk
         tEujptBuWWbWJObnDaHElMqhP0uru4Wl4DT78vDPlsmcgUCaX6nXRI1FiLGkFsCD+ZbY
         IHgw==
X-Gm-Message-State: AOAM530aOVd5S0yi/a+fgr5hul8n6hBeon4wGX7hHU87Bb7yyNwujm+Q
        rYyq82LiqkTt/gZYFln0ubHQ6J5QaRxpD5WY+ZY=
X-Google-Smtp-Source: ABdhPJwnpXOTMABgxo70ILLBHzG3cTuuTlSWDlMu/PK1PWFsgmr5pjf6L+fc95SnOE0niuQPhtnZBChv7gm3AL3VZPs=
X-Received: by 2002:a05:6870:f624:b0:e1:c071:121c with SMTP id
 ek36-20020a056870f62400b000e1c071121cmr4317683oab.182.1649261769463; Wed, 06
 Apr 2022 09:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com> <20220405133548.51598-4-cgzones@googlemail.com>
In-Reply-To: <20220405133548.51598-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Apr 2022 12:15:58 -0400
Message-ID: <CAP+JOzTXBr_jMK8PjoYJt2CXashgO1jyKkWhrVGKrdmLV-6EVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] libsepol/cil: comment out unused function __cil_verify_rule
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 6, 2022 at 9:28 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The function __cil_verify_rule() is currently not used as all call sites
> are commented out.  Keep the function for future references.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Patches 1-3 have already been merged.

For patches 4-6:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_verify.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index aecbdc19..4640dc59 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -970,7 +970,8 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_rule(struct cil_tree_node *node, struct cil_complex_sym=
tab *symtab)
> +/*
> +static int __cil_verify_rule(struct cil_tree_node *node, struct cil_comp=
lex_symtab *symtab)
>  {
>
>         int rc =3D SEPOL_ERR;
> @@ -1016,6 +1017,7 @@ exit:
>         cil_tree_log(node, CIL_ERR, "Invalid rule");
>         return rc;
>  }
> +*/
>
>  static int __cil_verify_booleanif_helper(struct cil_tree_node *node, __a=
ttribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extr=
a_args)
>  {
> --
> 2.35.1
>
