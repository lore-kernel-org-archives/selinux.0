Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A7C4167B
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448762311A
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgLGQnv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGQnv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 11:43:51 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF63C061749
        for <selinux@vger.kernel.org>; Mon,  7 Dec 2020 08:43:05 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n14so13951912iom.10
        for <selinux@vger.kernel.org>; Mon, 07 Dec 2020 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVGuEIn8WFe5tmS+wzm0IqaGhW13ZoXbGbbqgqYEA6Q=;
        b=kcClUcLLUTNIecUmT4B3UIyeIA3+lO5FgWmlYXMkoZk/uK8CBarv6py6KPWeqy0svW
         cTLuiu5/E9VbljLk5m8NsR35qYnwHva03/G82A3xqcPX78w52MVQ/48qbD2wSqMn0/Lg
         2eaKOZFLDdbJ9+1PnjLBSmlP6tzx+LdWsiFwLaq5q7N52Ex1dp5EQIKoDdsmxEnPrGsN
         M4HZS5DrYpDUuLNg6AWljRFqcwNP0EnTebJ3iWoAJV4WTQ6JhNDgaHFtP+5nreE998j4
         RkyTiyP4PqIr6MbaKqC1WLguNgYaFza+T0IWLkW0Xvj5NXi+wW77aLBEcJbNgIyPgBW1
         k56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVGuEIn8WFe5tmS+wzm0IqaGhW13ZoXbGbbqgqYEA6Q=;
        b=k/A0vtHmASWC35bWhW1/ozBknhBl6nMlkuMDrP/D6YWsUtXDmBcr5Dn4WTCLokY/7z
         yczIXvMws0mP5HUFCrbIg08d2DqhE/nXTPZNhuoRAyBKWYtnbsHwydwor08Nn8mJGCqj
         w36HxcMraLV6qlks+oG/gZbTy3lm8Yjd+9vIBVkSLWDP2FSe/lSBKqaJkrNibVEzM4uA
         AnqzYXpKVODmWxcUv+j2wnHUnUpMJ1whlgeEB/qf+gNdTT69IiCCwjIQ2NWMe6dmMGvK
         NaBOLTUoJmr/5nmlRBkwcIIenBqhVfUbJrefRIfM4Weg4FTAZa88v2oqs9+WZVlaivLb
         uezg==
X-Gm-Message-State: AOAM532+LuVjGG08xJ72z4FVRdjBn+nZRBJlLQfMUJeyQ+35VRdjbEb7
        Qk5w+rXMpjyWipAFc1jh97fhP4Avh2IFHKW9c2Qt8gFWbU4=
X-Google-Smtp-Source: ABdhPJz93wmSHS7VVqT8E3nRmfESeDyGhiLCRtDP8QPSBzfA27OJrzA233zad65HYExIc9cLlutdGysrKCp/9qjoiMg=
X-Received: by 2002:a6b:8b4c:: with SMTP id n73mr7505043iod.143.1607359384578;
 Mon, 07 Dec 2020 08:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20201206225625.3077530-1-nicolas.iooss@m4x.org> <20201206225625.3077530-2-nicolas.iooss@m4x.org>
In-Reply-To: <20201206225625.3077530-2-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 7 Dec 2020 10:42:53 -0600
Message-ID: <CAFftDdr+EYfx50vhV2LmSy0v=0-GH=DjR0ecE+utBOGGMGRDEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] GitHub Actions: drop Ruby 2.4 from matrix
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 6, 2020 at 4:59 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When migrating to Ubuntu 20.04, Ruby 2.4 is no longer available. As the
> migration of "ubuntu-latest" to Ubuntu 20.04 is coming soon, according
> to https://github.com/actions/virtual-environments/issues/1816, remove
> it now.
>
> Moreover the support of Ruby 2.4 ended a few months ago, so there is no
> point at supporting bindings (and testing them) for this version:
> https://www.ruby-lang.org/en/news/2020/04/05/support-of-ruby-2-4-has-ended/
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>
> I hit this on https://github.com/fishilico/selinux/runs/1507627386?check_suite_focus=true
> and the fix is simple.
> I would like to keep using ubuntu-latest image in order to benefit from
> automatic "LTS upgrade" when they become available. I find it better
> than having to update the Ubuntu version by hand (like was done for the
> Travis-CI configuration), because maintainers do not have to remember
> to update the configuration file for GitHub Actions.
>
> If you prefer using fixed Ubuntu versions (or even several Ubuntu
> versions!), the configuration can be modified accordingly.
>
>  .github/workflows/run_tests.yml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
> index d889b5d55604..ef4be8afc02f 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -24,7 +24,6 @@ jobs:
>            # Test several Ruby versions with the latest Python version
>            - {python: 3.9, ruby: 2.6}
>            - {python: 3.9, ruby: 2.5}
> -          - {python: 3.9, ruby: 2.4}
>          exclude:
>            - compiler: clang
>              python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
> --
> 2.29.2
>

ack
