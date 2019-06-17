Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C31C31E5B
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 18:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A911020861
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 18:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9/hTj1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFQSBU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:01:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46030 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQSBT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 14:01:19 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so23116678ioc.12
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9n9KE3aFvi7Ea9o1N8dMuf98QvLPDybWDe2pVTOBUI=;
        b=b9/hTj1LvU71gw2KJe+q/Vhl6Mf4WKiBzA3oKkEieoIx/fzdix5LYobHESBKBZv0Ul
         M0rdnm6SfR9b5eD01qGYC94gjZiojNtcXEFr5Obn8fw7B9rIzM99VH/BbcoyBwZPSq+7
         +w4x+IVrMfx1msBlVlhGeIxexpv+vLerW9rb6EcdjfCkUPjpNUSgGQkqjGJQ4foQ4f7X
         iCmPjfRhfYwM8JQDjFX4uiF++0kUHkGAJE8P7dnhM06VCY1u/uyPzZoRQAr05ibf0A29
         dao+mln2+lHzZxdywuxwWr9EkPegr4wEFa/yVsHLOFBVfvR1bSljdptTSMKeyD/Whqpc
         FGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9n9KE3aFvi7Ea9o1N8dMuf98QvLPDybWDe2pVTOBUI=;
        b=TpsEi0M26xtTxu8XiwVNaCYfngBGRj4PNMFj5SIg6xzkAlfJ/N+i+wHsUYAmnf9G6L
         mhHaHHfzEIHwRUKKahRnLgVuJy6M1FNZBn0xUH7ni4k19mRyVw9Pn7nUYpm38WdA2ll1
         RbCrFRA/ox2gWJOm3s9/WBSnpht4g6P2jFwe30AVOvhKuVIp+UUBEmqglR3MLHzrV6b9
         Fm53xxYMVxYQwbhGfdGBAr9NSI7VkXHpCZA21VGVMdztoJVHfTwVNOvVelFXVM7TQM/F
         u9u++tAtfKtrJcPPT8rHELC8teTw0Pjkg8mkc3UXYxpnvFPng/+uAoTupdoUCKs5VqWX
         XshA==
X-Gm-Message-State: APjAAAWr6/2uSlRA3NoULXGNgzMLHJ+qo1AgnB9E5hrglLO3X4X/O1zH
        0n4+iKrq3l5WmhlKyBCxeS61EmEfQGzLqoS+b4I93VHbmpI=
X-Google-Smtp-Source: APXvYqyePYC3cBN+4EEqODUcYntSI2tUrIS7SQL3xuSd/r9qwgLvd5r0u7wxieJsBDToG2x55Jqnx2eEJnsM+Z81org=
X-Received: by 2002:a5d:8f9a:: with SMTP id l26mr123640iol.22.1560794478698;
 Mon, 17 Jun 2019 11:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190617151512.2209-1-mike.palmiotto@crunchydata.com>
In-Reply-To: <20190617151512.2209-1-mike.palmiotto@crunchydata.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 17 Jun 2019 11:01:06 -0700
Message-ID: <CAFftDdodVXDdgMyTSV5188W5HcSrJu4pvpsufQPcf5U1Bw3WJQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix mlsconstrain segfault
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ack and staged: https://github.com/SELinuxProject/selinux/pull/164

On Mon, Jun 17, 2019 at 8:16 AM <mike.palmiotto@crunchydata.com> wrote:
>
> From: Mike Palmiotto <mike.palmiotto@crunchydata.com>
>
> Installing a cil module with invalid mlsconstrain syntax currently
> results in a segfault. In the following module, the right-hand side of
> the second operand of the OR is a list (mlstrustedobject):
>
> $ cat test.cil
> (class test (foo) )
> (classorder (unordered test))
>
> (mlsconstrain (test (foo))
>         (or
>                 (dom h1 h2)
>                 (eq t2 (mlstrustedobject))
>         )
> )
>
> $ sudo semodule -i test.cil
> zsh: segmentation fault  sudo semodule -i test.cil
>
> This syntax is invalid and should error accordingly, rather than
> segfaulting. This patch provides this syntax error for the same module:
>
> $ sudo semodule -i test.cil
> t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side
> Bad expression tree for constraint
> Bad constrain declaration at /var/lib/selinux/mls/tmp/modules/400/test/cil:4
> semodule:  Failed!
>
> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> ---
>  libsepol/cil/src/cil_verify.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 1036d73c..346fbac9 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -225,6 +225,9 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
>                                 cil_log(CIL_ERR, "u3, r3, and t3 can only be used with mlsvalidatetrans rules\n");
>                                 goto exit;
>                         }
> +               } else if (r_flavor == CIL_LIST) {
> +                       cil_log(CIL_ERR, "t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side\n");
> +                       goto exit;
>                 }
>         } else {
>                 if (r_flavor == CIL_CONS_U2) {
> --
> 2.21.0
>
