Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A006C433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F3161454
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbhDUQ5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbhDUQ5U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 12:57:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E53C06138A
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 09:56:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so43062579oif.6
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PX29pm3fbINXwEow/9B95B4Iab4aW9hCCo4GCIAf624=;
        b=muXUDemKvFNNdy/rD7hE4sN/Fnenagw8cq087L0+2y3I07Anwng9ZtSiDcHxOUwBfm
         JFzIlLe5aT5mjaNicMi2vgcmVCwMF3w8AObf13YNeE0VgH5hq6iS7h4+tXNNeL+hgOAm
         M7alt1F7/H0OoXIx7XybDAtkol+wCITNWcV3Dj128Z2NTprXnY9Ye+jYGZoqI9sZTlbC
         uouECD4K0UH4Xxnu1sy5tVLlT5B/ZG4cysqJaJ2TfP1y9jpjvVD/tbsuBB3p7ymBy26b
         aq5jK6w0+vQWPUjXu1nWuDSi9YoeHomYMJHIoxluY6h6H/fg+knQLDJ8/qyJ984sHjYL
         NmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PX29pm3fbINXwEow/9B95B4Iab4aW9hCCo4GCIAf624=;
        b=NxZEqjcnB6fPan35UXbI9tykdLBeKqXC9Ux5BaZvU7I3+GUaedKGvxuofIBcq6uQYa
         EcmUcRQ5y+j5aRRNE5ah3BHXNnzd++BW4qq78XyzGYKyBFVPaJCzJRHXV3MzPaHaoO6p
         aAcey8CcAJ5KIEZYPn1AdWpTsGwuXOenKm1nMl/8Oe6BN5EFhjj265pdoEqsRDbPOaEp
         OSWRSz4vTx+YrHKUbunR10Raapmk6Ku7kDgDH0UXAAWnHM5SWCiaPnW+Yn/4KVn8u7t9
         MeMba2W0N8YS8cr30wWuEZHVbeiadmk0CW6DeDiMUQ+FC3Oqeao7Gq1/oegllzcXSjHx
         kepQ==
X-Gm-Message-State: AOAM5319uT766WejtvNTPGIsRoUSHqWBO/FHIMdffaMt3T7DnVxlp0Lr
        30l59gEKDmhD5S+63KAKBGS2ytPAmfOCA5Dy+rZ2U0/hpkM=
X-Google-Smtp-Source: ABdhPJx5BMxywYAuEmeth2o0fkAWY6hhsXGcEFf90Tm6PaWaQyoyBIzkRuf1u+5GN574G3k147hXBCeA4S53KK2MB+c=
X-Received: by 2002:aca:abd4:: with SMTP id u203mr5415728oie.16.1619024206182;
 Wed, 21 Apr 2021 09:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210419152749.88086-1-jwcart2@gmail.com> <CAP+JOzRtCjKaXVW6jVs7k-fhZE+AkkJuP5ORUNap0r3GHy2_Sg@mail.gmail.com>
 <CAJfZ7=k6z6aRXtFnpzyjmkBdAYTeXouqYSePsQ-dQLxB=enHMQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=k6z6aRXtFnpzyjmkBdAYTeXouqYSePsQ-dQLxB=enHMQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 21 Apr 2021 12:56:35 -0400
Message-ID: <CAP+JOzQ_Ghm5nbPdOxwNrMNHTrMKwca59eUW7uNsKL_046=QoA@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] Create secil2tree to write CIL AST
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 21, 2021 at 4:58 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Tue, Apr 20, 2021 at 7:08 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > As an example of how it can be used, I have been using secil2tree
> > recently to make secilc fuzzing test cases readable.
> >
> > Running:
> > secil2tree -A build -o fuzz_613136.cil
> > clusterfuzz-testcase-minimized-secilc-fuzzer-6131368317812736
> >
> > The attached files shows the original and the output of secil2tree.
> >
> > Jim
> >
> > On Mon, Apr 19, 2021 at 11:27 AM James Carter <jwcart2@gmail.com> wrote=
:
> > >
> > > For debugging purposes it would be useful to be able to write out
> > > the CIL AST at various points in the build process.
> > >
> > > This patch set creates secil2tree which can write the CIL parse tree,
> > > the CIL AST after the build phase, or the CIL AST after the resolve
> > > phase (with names fully-qualified).
> > >
> > > Within CIL the function cil_print_tree() has existed from early in
> > > CIL's development, but it was not exported in libsepol and there was =
no
> > > way to use it except by adding a call to it where you wanted to print
> > > out the CIL AST and then recompiling everything. It also used cil_log=
()
> > > as its output, so other messages could be mixed in with the output. T=
his
> > > patch set moves all of this code to its own file, updates it, renames=
 it
> > > as cil_write_ast(), and adds libsepol functions that can be used to c=
all
> > > it after each one of the phases mentioned above.
> > >
> > > Both the parse and build CIL AST are valid CIL policies that can be
> > > compiled with secilc, but the resolve CIL AST is not always a valid C=
IL
> > > policy. The biggest problem is that fully-qualified names can contain
> > > dots and CIL does not allow dots in declaration names. There are othe=
r
> > > problems as well. It would be nice to get to the point where the outp=
ut
> > > for all of the trees are valid CIL, but that is a goal for the future=
.
> > >
> > > v2:
> > > - Remove whitespace errors in cil_write_ast.h
> > > - Use "const char*" instead of just "char*" when dealing with string
> > > literals to satisfy clang.
> > >
> > > James Carter (3):
> > >   libsepol/cil: Create functions to write the CIL AST
> > >   libsepol/cil: Add functions to make use of cil_write_ast()
> > >   secilc: Create the new program called secil2tree to write out CIL A=
ST
> > >
> > >  libsepol/cil/include/cil/cil.h   |    3 +
> > >  libsepol/cil/src/cil.c           |   92 ++
> > >  libsepol/cil/src/cil_tree.c      | 1471 ----------------------------
> > >  libsepol/cil/src/cil_tree.h      |    2 -
> > >  libsepol/cil/src/cil_write_ast.c | 1573 ++++++++++++++++++++++++++++=
++
> > >  libsepol/cil/src/cil_write_ast.h |   46 +
> > >  libsepol/src/libsepol.map.in     |    3 +
> > >  secilc/.gitignore                |    2 +
> > >  secilc/Makefile                  |   20 +-
> > >  secilc/secil2tree.8.xml          |   81 ++
> > >  secilc/secil2tree.c              |  206 ++++
> > >  11 files changed, 2024 insertions(+), 1475 deletions(-)
> > >  create mode 100644 libsepol/cil/src/cil_write_ast.c
> > >  create mode 100644 libsepol/cil/src/cil_write_ast.h
> > >  create mode 100644 secilc/secil2tree.8.xml
> > >  create mode 100644 secilc/secil2tree.c
> > >
> > > --
> > > 2.26.3
> > >
>
> Hello,
> Thanks for this tool! It looks great and it seems to work quite well.
>
> Anyway, while building with some warning flags, gcc reported issues
> about using non-const pointers to hold literal strings. For example:
>
> ../cil/src/cil_write_ast.c: In function =E2=80=98datum_to_str=E2=80=99:
> ../cil/src/cil_write_ast.c:51:28: error: return discards =E2=80=98const=
=E2=80=99
> qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>    51 |  return datum ? datum->fqn : "<?DATUM>";
>       |         ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> ../cil/src/cil_write_ast.c: In function =E2=80=98write_expr=E2=80=99:
> ../cil/src/cil_write_ast.c:122:12: error: assignment discards =E2=80=98co=
nst=E2=80=99
> qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   122 |     op_str =3D "<?OP>";
>       |            ^
>
> With the attached patch, the code compiles fine. Feel free to directly
> modify the first patch with these fixes.
>

I think that you might have tested the first version. The second
version actually has everything in your patch.

Thanks,
Jim

> Thanks,
> Nicolas
