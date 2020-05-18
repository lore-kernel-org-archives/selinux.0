Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52CC433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 13:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F6520674
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhwDhRwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERN4F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgERN4F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 09:56:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA7C061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 06:56:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z3so6409821otp.9
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSB7ljk/jSGqeVsu2SRbLmcbyvLGELmc22SjZV70Mt4=;
        b=mhwDhRwua5gr+3kNCZSDPyf1pxlE8y8wlfMdrvHw5u4SKlV2V59gdmjmM8YHnqjBzv
         67tW7OeaM8oHbgggX7D1IqnmgiGPYiDP3kJLX1l6sz/bU3dkq4feZ1PdiupuwZ86Zm3f
         1KhRwO4z9cK6BFYh9ffCMh13ZQvVvAP7bYhSxEnP/L9UfFyyKGHx+QH0IfzC3RAArzDy
         17dYSRHLFKGQ4aGJ4lqA33LoeTeMada4AMUPD3EyVaYnhs1yjpSm5/sqkRjT4OgLs7zf
         jtBCIsYX4I+gtTdjNNQnJ5fkrMrRRrPWowdFe7mXdXdYlJRg/Tj7X8Yale+alUdN6RJF
         bVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSB7ljk/jSGqeVsu2SRbLmcbyvLGELmc22SjZV70Mt4=;
        b=TtF/16/SYWABoXONYUL2+eq3//nEayP2aKd2sFDs2UjGosFq24+FF7AUtmGgqJw1wg
         Y46RklEoQEbP9UTJ5ECttD73R2IZrWhyU9upf9uR91PhXhH2SK3by6EqYJfs2y2owLn2
         x+tztZAW32A6UvyUui+8FLyo5lkA7hXO+qS0B8anbQm2BS3pOFTnzHojpGvJ49UMhUjC
         PNIQJFPW9ODk2PHaYQz3/MsIQp/bh8YUpYL4eV99zdAiBfW34ZAcbPr6ToB4jXnG6Ayf
         JhYwljpkYTd+YAzht023WJ8QQ1N1KxQeYZVLUENt6McoJz2RZ9NemoB4fhSZclIknTeK
         379A==
X-Gm-Message-State: AOAM532iTMd6iXCCpryz5zrrpJYMsnBjUcJHu60Gwc+sN/d6mdCZu/nN
        t6gCrz9o8tBIqOjSHlVCcHVudo8x1JDAYOGxmiE=
X-Google-Smtp-Source: ABdhPJyWWYmIj51Z4+zCyQYDYasMj7LWy8MwTmqdPlshntdehQ1IeEbWagzTGQY1padUEvxl777gYAMxKbqlX6A1hn4=
X-Received: by 2002:a05:6830:158b:: with SMTP id i11mr2800508otr.135.1589810163479;
 Mon, 18 May 2020 06:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <85b4f600-a7f0-f017-0f54-74fe7de73bcc@gmail.com>
In-Reply-To: <85b4f600-a7f0-f017-0f54-74fe7de73bcc@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 18 May 2020 09:55:52 -0400
Message-ID: <CAEjxPJ47hbNA6P0kke-6K3_RtG-TgTin+FF52Dm-KGc-knJOjA@mail.gmail.com>
Subject: Re: Semodule accepts bad modules every other time
To:     Topi Miettinen <toiwoton@gmail.com>,
        James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 18, 2020 at 5:43 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Hi,
>
> I have a module, which can be compiled without problems but it can still
> generate errors during load. However, every other time the load succeeds.
>
> Here's the example:
> # cat foo.te
> module foo 1.0;
>
> type file_type;
>
> require {
>          type user_t; # dummy require statement to keep checkmodule happy
> }
> # make
> Compiling default foo module
> Creating default foo.pp policy package
> rm tmp/foo.mod.fc tmp/foo.mod
> # make QUIET=n load
> Loading default modules: foo
> /usr/sbin/semodule -i foo.pp
> Re-declaration of type file_type
> Failed to create node
> Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
> /usr/sbin/semodule:  Failed!
> make: *** [/usr/share/selinux/devel/include/Makefile:148: tmp/loaded]
> Error 1
> # make QUIET=n load
> Loading default modules: foo
> /usr/sbin/semodule -i foo.pp
> (no error)
>
> Running semodule directly:
> # semodule -i foo.pp
> Re-declaration of type file_type
> Failed to create node
> Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
> semodule:  Failed!
> # semodule -i foo.pp
> # semodule -i foo.pp
> Re-declaration of type file_type
> Failed to create node
> Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
> semodule:  Failed!
> # semodule -i foo.pp
>
> Maybe the failing transaction is not reverted properly and then the
> failed module changes the system somehow? Some problem with detecting
> redeclarations?

Looks like a bug in libsepol to me:
# valgrind semodule -i foo.pp
==5989== Memcheck, a memory error detector
==5989== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==5989== Using Valgrind-3.16.0.GIT and LibVEX; rerun with -h for copyright info
==5989== Command: semodule -i foo.pp
==5989==
==5989== Conditional jump or move depends on uninitialised value(s)
==5989==    at 0x48E02F5: cil_gen_node (cil_build_ast.c:129)
==5989==    by 0x48E3FD3: cil_gen_type (cil_build_ast.c:2315)
==5989==    by 0x48EBDC0: __cil_build_ast_node_helper (cil_build_ast.c:6261)
==5989==    by 0x490AF1D: cil_tree_walk_core (cil_tree.c:272)
==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
==5989==    by 0x490AF8F: cil_tree_walk_core (cil_tree.c:284)
==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
==5989==    by 0x490AF8F: cil_tree_walk_core (cil_tree.c:284)
==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
==5989==    by 0x48ED269: cil_build_ast (cil_build_ast.c:6571)
==5989==    by 0x48D019F: cil_compile@@LIBSEPOL_1.1 (cil.c:564)
==5989==    by 0x498A646: semanage_direct_commit (direct_api.c:1419)
==5989==
Re-declaration of type file_type
Failed to create node
Bad type declaration at /var/lib/selinux/targeted/tmp/modules/400/foo/cil:1
semodule:  Failed!

Without valgrind, I get a segfault.  This is with make DEBUG=1.
