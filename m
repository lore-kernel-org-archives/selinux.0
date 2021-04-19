Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325EC433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57037611EE
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 18:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhDSSZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbhDSSZl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 14:25:41 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C5C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 11:25:11 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id i9-20020a4ad0890000b02901efee2118aaso384644oor.7
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UygCGkKkGuLF5psGIFmwIFTlISCL5HIE6sbHxXwqe04=;
        b=ojgW0gEqYLkplvvsTCbjz4Ge20ZUccmxi1qhF+wPGEwMzZkfH8EJkqHmOQzqGwubC/
         fyhI+u/ijLpuIbZV0dYGivEupeKB1d6Vg7vhzn2SnD0I4pHtORSaKlmCoocbznNyh/n0
         CXbAB9FnLXv4m5/Pkr912FkffLvcYBCvGm1rO7ZvFFXVQkIlgNHqcjoHHy3uFwEkeVOZ
         8gOxLNYxj9QQjPNP6nfW9K0W/WK6QL//+G7SJTLmiS8lV4+QwFYWAjSGgU4WfEhYtLnw
         Yk13EbuZOAn/bdQTziSYcj3uXlH1U49E1uSJNE8p4q2sAybB0/0y4cuYgvQzjk7TJHNH
         FfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UygCGkKkGuLF5psGIFmwIFTlISCL5HIE6sbHxXwqe04=;
        b=VgKrSVXmn9UMRDPT475vvEznbmrs9pEulRWWfvJh33/To3K2Gs2Kl0wJcXBh6AacTE
         SwguT7t84JZ4prQdN+rLunvAGmhjnSdjwsbYLaI8Dhm059yLWxVlCEk/sfHmWzkYveOw
         L34y+Qq9ZFQEorlPyZWD1qz1Oygxf+kgmUXT8unVAUfst8+H9jCnU7XUNJ4vnagfWjRu
         pdrIdzlKme4UBljgIyb32BOTqJOqNkPSmtvA8o9yLPyPC4KLWjumTbu04Spbsy8ZxHNj
         /4IQLX9MkCZ652npKkYuLyqWl7g5eMv2E9IlyO4gdxCNk3Q6U2+FENFZ4rfpW4h5XXWa
         svIg==
X-Gm-Message-State: AOAM5316friQwdQ7FlDdrCVTn1g8yzH/L6R9uxG2YtKJ+MFqJeVSuP+2
        8GMlUHK/1yZ0M5eYX/ICr4cA0WdGusTbUMJwotT/JqnF2ys=
X-Google-Smtp-Source: ABdhPJw2jNFxeiyEta8YJU1drdHn7hy/yf6WtzmJ/IxpUPVxDAxjqXO/Neyxot1k4c1iBneiuY5xDaTSm8+LRc96ALg=
X-Received: by 2002:a4a:8c0d:: with SMTP id u13mr14208469ooj.59.1618856710598;
 Mon, 19 Apr 2021 11:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210419151557.87561-1-jwcart2@gmail.com>
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 19 Apr 2021 14:24:59 -0400
Message-ID: <CAP+JOzTKsvpR7cWefO91pXbTBn1i_jwcAuB62zcJOgKUmFf6NA@mail.gmail.com>
Subject: Re: [PATCH 00/11 v2] Various CIL patches
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 19, 2021 at 11:16 AM James Carter <jwcart2@gmail.com> wrote:
>
> All of these patches (except the first) have been sent to the list in the
> last month. The first patch is a slight modification of an earlier patch
> sent by Nicolas Iooss. I also corrected a couple of whitespace errors and
> updated one patch that would not apply cleanly with one of the earlier
> patches applied.
>
> v2:
> - Remove redundant parenthesis from patch 7 "Exit with an error if
> declaration name is a reserved word" to satisfy clang
>
> James Carter (11):
>   libsepol/cil: Fix out-of-bound read of file context pattern ending
>     with "\"
>   libsepol/cil: Destroy classperms list when resetting classpermission
>   libsepol/cil: Destroy classperm list when resetting map perms
>   libsepol/cil: cil_reset_classperms_set() should not reset
>     classpermission
>   libsepol/cil: Set class field to NULL when resetting struct
>     cil_classperms
>   libsepol/cil: More strict verification of constraint leaf expressions
>   libsepol/cil: Exit with an error if declaration name is a reserved
>     word
>   libsepol/cil: Allow permission expressions when using map classes
>   libsepol/cil: Refactor helper function for cil_gen_node()
>   libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
>   libsepol/cil: Move check for the shadowing of macro parameters
>
>  libsepol/cil/src/cil_build_ast.c | 132 ++++++++++++-------------------
>  libsepol/cil/src/cil_build_ast.h |   2 +
>  libsepol/cil/src/cil_copy_ast.c  |  26 +++---
>  libsepol/cil/src/cil_post.c      |  11 +++
>  libsepol/cil/src/cil_reset_ast.c |  11 ++-
>  libsepol/cil/src/cil_verify.c    |  78 +++++++++++++++++-
>  libsepol/cil/src/cil_verify.h    |   3 +-
>  7 files changed, 160 insertions(+), 103 deletions(-)
>
> --
> 2.26.3
>

This has been applied.
Jim
