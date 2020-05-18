Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E3EC433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE5206D4
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 14:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpouhRJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgEROlZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgEROlZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 10:41:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7FC061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 07:41:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w22so8224662otp.5
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBQTnCOIMB4svC0TgpFjeAnhOxgMJdfdm5Vggu/slfM=;
        b=dpouhRJH4GhosMcLO0qxYM7lg5jVEbeDCnDC3KJrf6ldBabAGcj9/ZseKwYZHYE6zA
         mGT85liRFLwEFLMJ6KTi3XmrqmmMe4T20uzjv2MsM9eK8RFBJeQ+o5IV9PGjtZtaPLYi
         oFthtyW8K2BD2JZz/Ofq7niXhkjKZhKKYFUt3HdCvrGYYe4Q3jOL3gwds8Prhi8tyxfn
         Q4PE5/18dH7vrbDsGt5YuDXaWG0/tPFHtZ80O9fxSkVk1TQhmmcxRO/ffQD6SzkoGaRG
         PokmhgqouyNbWz0Mj5hKTaI9qEsAXIV+Vy4QONDyMKUyCIV398UKWeHz+1WrNMZqwM0W
         96CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBQTnCOIMB4svC0TgpFjeAnhOxgMJdfdm5Vggu/slfM=;
        b=jkGAI17n8EpJg9EqCxKyEmkkWZ1rHrZEFgaTkVQl65lRGf0sOOgF4zHwXdys0kMAE+
         km0FDTtwwwvh9kJUUWOORRW42tsm1oRGhFFxJgMnX0276isqmJyM5Zjf6zMdlrSLhWZC
         dX4RUZwftVs614iD06zLsx892bNtwv9ioEhtsWwngZYMeXqtGTodYZ4XC0/PDilMHU+9
         X/A2CHiYaHTmamvkZzLdKV5IIXRqh8QPbNbRPv+rR7Vj5d3SejjzWN6s4gdroUOpATRh
         qSCRaffcgUOtGQOW4EheDhTODT0N8sh0PcHbZyAL0F7Lm9uMEM6ndjpulQfky6538GMa
         iQIg==
X-Gm-Message-State: AOAM530Rb53IAo42joQ7ZsOOJQppadcCnsVIpQ/Aju6L1CVx4yLDRK5B
        6OjZ65aP8kVU9lJf0AcVAZ84Lj/PukABAaUxipPp/EYt
X-Google-Smtp-Source: ABdhPJw+yPbUJinVn4ozTqr8mEa1MhHgx6fSw3hpp7JQQWHTF5u7mxpvpJxi1v74Fm50ADetgXLTtGAXOZwi1zOArvk=
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr12304894otr.59.1589812884355;
 Mon, 18 May 2020 07:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <85b4f600-a7f0-f017-0f54-74fe7de73bcc@gmail.com> <CAEjxPJ47hbNA6P0kke-6K3_RtG-TgTin+FF52Dm-KGc-knJOjA@mail.gmail.com>
In-Reply-To: <CAEjxPJ47hbNA6P0kke-6K3_RtG-TgTin+FF52Dm-KGc-knJOjA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 May 2020 10:41:10 -0400
Message-ID: <CAP+JOzRr56cAH01Wr5xwcj7aT8C=ggT_4KiA2UKofxFPHpc34g@mail.gmail.com>
Subject: Re: Semodule accepts bad modules every other time
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 18, 2020 at 9:56 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 5:43 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >
> > Hi,
> >
> > I have a module, which can be compiled without problems but it can still
> > generate errors during load. However, every other time the load succeeds.
> >
> > Here's the example:
> > # cat foo.te
> > module foo 1.0;
> >
> > type file_type;
> >
> > require {
> >          type user_t; # dummy require statement to keep checkmodule happy
> > }
> > # make
> > Compiling default foo module
> > Creating default foo.pp policy package
> > rm tmp/foo.mod.fc tmp/foo.mod
> > # make QUIET=n load
> > Loading default modules: foo
> > /usr/sbin/semodule -i foo.pp
> > Re-declaration of type file_type
> > Failed to create node
> > Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
> > /usr/sbin/semodule:  Failed!
> > make: *** [/usr/share/selinux/devel/include/Makefile:148: tmp/loaded]
> > Error 1
> > # make QUIET=n load
> > Loading default modules: foo
> > /usr/sbin/semodule -i foo.pp
> > (no error)
> >
> > Running semodule directly:
> > # semodule -i foo.pp
> > Re-declaration of type file_type
> > Failed to create node
> > Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
> > semodule:  Failed!
> > # semodule -i foo.pp
> > # semodule -i foo.pp
> > Re-declaration of type file_type
> > Failed to create node
> > Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
> > semodule:  Failed!
> > # semodule -i foo.pp
> >
> > Maybe the failing transaction is not reverted properly and then the
> > failed module changes the system somehow? Some problem with detecting
> > redeclarations?
>
> Looks like a bug in libsepol to me:
> # valgrind semodule -i foo.pp
> ==5989== Memcheck, a memory error detector
> ==5989== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==5989== Using Valgrind-3.16.0.GIT and LibVEX; rerun with -h for copyright info
> ==5989== Command: semodule -i foo.pp
> ==5989==
> ==5989== Conditional jump or move depends on uninitialised value(s)
> ==5989==    at 0x48E02F5: cil_gen_node (cil_build_ast.c:129)
> ==5989==    by 0x48E3FD3: cil_gen_type (cil_build_ast.c:2315)
> ==5989==    by 0x48EBDC0: __cil_build_ast_node_helper (cil_build_ast.c:6261)
> ==5989==    by 0x490AF1D: cil_tree_walk_core (cil_tree.c:272)
> ==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
> ==5989==    by 0x490AF8F: cil_tree_walk_core (cil_tree.c:284)
> ==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
> ==5989==    by 0x490AF8F: cil_tree_walk_core (cil_tree.c:284)
> ==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
> ==5989==    by 0x48ED269: cil_build_ast (cil_build_ast.c:6571)
> ==5989==    by 0x48D019F: cil_compile@@LIBSEPOL_1.1 (cil.c:564)
> ==5989==    by 0x498A646: semanage_direct_commit (direct_api.c:1419)
> ==5989==
> Re-declaration of type file_type
> Failed to create node
> Bad type declaration at /var/lib/selinux/targeted/tmp/modules/400/foo/cil:1
> semodule:  Failed!
>
> Without valgrind, I get a segfault.  This is with make DEBUG=1.

I didn't try valgrind with semodule -i (it only segfaults for me when
running under valgrind), but I did notice a segault every other time I
did semodule -vB (with or without valgrind).

Since file_type is declared as an attribute, there definitely should
be an error when you try to declare it as a type.

I'll take a closer look.

Jim
