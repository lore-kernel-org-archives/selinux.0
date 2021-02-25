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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195AC433E6
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9322264DE8
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 13:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBYNzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Feb 2021 08:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBYNzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Feb 2021 08:55:19 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69414C06174A
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 05:54:39 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id f33so5685621otf.11
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K29ozvM+HRAc/LBUmqfIeYZBpoOBjVW+pMgdJCRG3LE=;
        b=BzH5CFAnSxR3RzS8S+QHhg32LEeCavjcxd68LvwMxNdOJUa4RBgeYAGT9IIbWdTFqn
         9xEJEm9tAYQWpMH5x9lpcJC9U75C48sZvr7qV6wycX8hcEAFmwOJFCmqrQRSLbkixsGm
         dLNNka/a7fYDPQNEQHVdCV1jVl6mphxSSJKXlHQ9fvBBm8oPJJjWG7P47Cw7Jw7FnG64
         1LEK+ckw8KbeIVJ0BtwvFeK34FU3uw88x+N9pdDxxqwSEBHye232xjGpuYCcgbg4yGlD
         1GzI0ElJdfnVCpTfRnUUCLuhIrMnyeUoB8tYe8zf6C1WqqyTv9BubohKY2Pn7c6+vlP8
         OLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K29ozvM+HRAc/LBUmqfIeYZBpoOBjVW+pMgdJCRG3LE=;
        b=WnUlbBvQvkgGXv7o1cYk1LLAGqDK77hR00YYuhHGyrEo2VzekQbv/kQnNrpViqykP1
         AWjrczzkgm3qEbagY4c4O7/psXpm4VdtcyvRrQIkuIDFbBt5bODgqqlKXwIDWWqW3bqg
         BIEHFvSpQEESc47dX3XrOSv+4mCtNgSFpqEY6+Z3ytkd2CDtqCTlxZNrvOepc2ap18kK
         WdGYFzps5sNjiW5F5qebTBsGkvQ2nXfdMudZf2yZi1OK+rUMF2UgFkV9qG+yKdVt3C5A
         JdrZw2kS2uMPQPH7IFNvoGiHYFAlvbINUMQ3ZkedCofsxsGxYFFmZjY3jPHVhFQI3jKL
         Lhng==
X-Gm-Message-State: AOAM533xo6XQ1B35pHSNR86ouIJ1BpmGQwbyR925Z4pcCrdyxwRhP3Se
        GkECXVHioJ0qZuLyjGBYqNnsoL0C0nN7Cmnrv2A=
X-Google-Smtp-Source: ABdhPJwdOCzG3GWvmZgbJIwtSwk9jh90N334IrBfTQw5qp3J0A/mTF/PWA+iMHmnNDZMxcUU6HHoAq8x14lO009kSEQ=
X-Received: by 2002:a05:6830:c9:: with SMTP id x9mr2269718oto.295.1614261278916;
 Thu, 25 Feb 2021 05:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20210225104002.1333-1-lutianxiong@huawei.com>
In-Reply-To: <20210225104002.1333-1-lutianxiong@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 25 Feb 2021 08:54:28 -0500
Message-ID: <CAP+JOzT1PPn0VoyjZgpUfJ3hrZK1gZeSK+tmvqLpmYTuD6=Wdw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix NULL pointer dereference in cil_fill_ipaddr
To:     lutianxiong <lutianxiong@huawei.com>
Cc:     SElinux list <selinux@vger.kernel.org>, jiqin.ji@huawei.com,
        liaoqingwei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 25, 2021 at 5:44 AM lutianxiong <lutianxiong@huawei.com> wrote:
>
> Found a NULL pointer dereference by fuzzing, reproducing:
>     $ echo "(nodecon(())o(e()))" > tmp.cil
>     $ secilc tmp.cil
>     Segmentation fault (core dumped)
>
> Add NULL check for addr_node->data in cil_fill_ipaddr.
>
> Signed-off-by: lutianxiong <lutianxiong@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 726f46c..4e53f06 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5660,7 +5660,7 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
>  {
>         int rc = SEPOL_ERR;
>
> -       if (addr_node == NULL || addr == NULL) {
> +       if (addr_node == NULL || addr_node->data == NULL || addr == NULL) {
>                 goto exit;
>         }
>
> --
> 2.23.0
>
