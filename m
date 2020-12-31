Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C9C433DB
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 14:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78251223E0
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 14:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgLaOsw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Dec 2020 09:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgLaOsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Dec 2020 09:48:51 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD07C061799
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 06:48:11 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 75so17487232ilv.13
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=botpEHY51cKXE9Sm8u4Cd7vKmW82ASxZqF7rF+zokUg=;
        b=uVddhUV1zoJXQpLJNJHYuXlXmR6yOrC+pWHYhRia9L1CK9CC1DJYcn3uoGTJ0pHufv
         52MYSuDRRRF2oS0oxWtOKcfkCWoiqwdZuHJMoUfEsVSqk1QAwbGaE1VwCQCnrvMdK52s
         xwaZCuGN/qOue/5pm4x2WIFR7DsyTYwqo5opqhGJ0QSorW2PX/U2R9KmJmhezqCTKwfv
         VI8Cr0KdhfrezHuBH3er5Rzbag78Zt9MwvQ75ZJUZgcM4coZ6rmuSxM9ZOPwFXZhaFiI
         LC9E/SwQi7QDHxS8nh5d/BtfZKHArOZVVwAr+YMpiB3iuGCWiSHXYg6dxCSLb/Ir5IKO
         VG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=botpEHY51cKXE9Sm8u4Cd7vKmW82ASxZqF7rF+zokUg=;
        b=ZH3/7pBk9BRs4Hv+E51cKHeRxYwE1Vz/JTmSazPYfndbjTUqjKNYN1OMmWFg4+ey8X
         R87dutX9TYDb0TeD3MNXcLMLYTWSNa8ZKpy1HTzlvF9RtvIpsvB58jb/R/Pn/xU/+qGz
         Ky98q9UqduK4a6buPOu2vSADPLvyJJU23S3qlJcWkLJM580pjfpcD0wqXTllXXln0k/N
         OtromXpVzSsE3BDZ3D57hzJ09C17ikfP6WSOrDWEXEdqw/QYoXRW5Z36oLIE3f5lt6Df
         Cr7TCXnwpNwpBK4xMV17qSHC4PH1/dfllVlEsV9yTxwuHqj4OGlhAAvMZVpwZk9zoJ3+
         CyHQ==
X-Gm-Message-State: AOAM530SwY8xrlmzOym4io8kSCmXnUpnS8kbwREQuQxaw6FLBIXSGciq
        ZmcqLVDFOifTwK7NEjgsL4HdVQwe4ALoa+bF/Gc=
X-Google-Smtp-Source: ABdhPJzwaMAG8OsPv+T/nQWOSkuks6otYC9RB+MXu2WBkrXghNjZTPEsXfZwUw+NF8ynalLprCMux1YfEALwNUyPubc=
X-Received: by 2002:a05:6e02:8d:: with SMTP id l13mr55869442ilm.163.1609426090657;
 Thu, 31 Dec 2020 06:48:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=kiMYKgEn1YvxgVjxh=ud5Nd==bOmYnRVEqfc=hDDX1ZA@mail.gmail.com>
In-Reply-To: <CAJfZ7=kiMYKgEn1YvxgVjxh=ud5Nd==bOmYnRVEqfc=hDDX1ZA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 31 Dec 2020 08:47:59 -0600
Message-ID: <CAFftDdoT-=ndesm9bQ0DLkPoBVjK7ruVdcaOo9Z8-9b+vTEn3A@mail.gmail.com>
Subject: Re: libsepol/cil: infinite loop using invalid block/blockabstract
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 11:46 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
>
> A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
> policy compiler. One of the issue it reported was a "Stack-overflow in
> __cil_resolve_name_with_parents", which seemed strange
> (https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28491, for
> future reference).
>
> By looking into it, the reduced test-case is the following CIL policy:
>
> (optional o
>     (block b
>         (block b
>             (blockabstract b0)
>         )
>         (blockinherit b)
>     )
> )
> (blockinherit b)
>
> When building this policy with secilc, the command seems to be caught
> in a loop that never ends. Using gdb to break somewhere leads to the
> following call stack:
>
> #0  0x0000555555bab646 in __cil_resolve_name_with_parents
> (node=0x606000000fe0, name=<optimized out>, sym_index=<optimized out>,
> datum=<optimized out>) at ../cil/src/cil_resolve_ast.c:4070
> #1  0x0000555555baae73 in __cil_resolve_name_helper (db=<optimized
> out>, node=<optimized out>, name=0x602000002850 "b0",
> sym_index=CIL_SYM_BLOCKS, datum=0x7fffffffcd80) at
> ../cil/src/cil_resolve_ast.c:4122
> #2  0x0000555555b7865b in cil_resolve_name_keep_aliases
> (ast_node=<optimized out>, name=<optimized out>, sym_index=<optimized
> out>, extra_args=<optimized out>, datum=<optimized out>) at
> ../cil/src/cil_resolve_ast.c:4173
> #3  0x0000555555b70384 in cil_resolve_name (ast_node=0x0, name=0x0,
> sym_index=CIL_SYM_BLOCKS, extra_args=0x7fffffffcd80,
> datum=0x7fffffffcd80) at ../cil/src/cil_resolve_ast.c:4134
> #4  0x0000555555b96b9f in cil_resolve_blockabstract
> (current=0x606000001040, extra_args=<optimized out>) at
> ../cil/src/cil_resolve_ast.c:2457
> #5  0x0000555555ba4c2c in __cil_resolve_ast_node (node=<optimized
> out>, extra_args=<optimized out>) at ../cil/src/cil_resolve_ast.c:3450
> #6  0x0000555555ba6e00 in __cil_resolve_ast_node_helper
> (node=<optimized out>, finished=<optimized out>, extra_args=<optimized
> out>) at ../cil/src/cil_resolve_ast.c:3769
> #7  0x0000555555bb86ed in cil_tree_walk_core (node=0x606000001040,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:272
> #8  0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000fe0,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:316
> #9  0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000fe0,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:284
> #10 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000bc0,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:316
> #11 0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000bc0,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:284
> #12 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000980,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:316
> #13 0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000980,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:284
> #14 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000080,
> process_node=<optimized out>, first_child=<optimized out>,
> last_child=<optimized out>, extra_args=<optimized out>) at
> ../cil/src/cil_tree.c:316
> #15 0x0000555555ba9dd1 in cil_resolve_ast (db=<optimized out>,
> current=<optimized out>) at ../cil/src/cil_resolve_ast.c:3937
> #16 0x0000555555a1d64a in cil_compile (db=0x6120000001c0) at
> ../cil/src/cil.c:550
> #17 0x00005555559e9d06 in main ()
>
> However, if I understand correctly the documentation
> (https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_container_statements.md),
> having two "(block b)" and a "(blockabstract b0)" that does not
> reference "b" are not supposed to work. Maybe the CIL compiler needs
> to detect such issues and fail instead of entering some kind of loop.
> How should this issue be fixed?

That seems reasonable to me, but I would say this CIL not my forte.
Have you had any other
thoughts around this?

>
> Nicolas
>
