Return-Path: <SRS0=m4lG=AN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22874C433DF
	for <selinux@archiver.kernel.org>; Thu,  2 Jul 2020 18:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1676207CD
	for <selinux@archiver.kernel.org>; Thu,  2 Jul 2020 18:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbMvD1d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgGBSns (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGBSns (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jul 2020 14:43:48 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B253C08C5C1
        for <selinux@vger.kernel.org>; Thu,  2 Jul 2020 11:43:48 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j11so21820327oiw.12
        for <selinux@vger.kernel.org>; Thu, 02 Jul 2020 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jGfykNBOMNjzBV9HEpceWjJWuKiWAoyGgJLJ+y7J5Ao=;
        b=ZbMvD1d17jtnWAd+rjkR649dd+5sR9tSb8evZxHShnPWeawzWfV9F0qT3GPXzWTcvA
         lCm1Y17jd9wNZAftDm4JlF1UDgGPcrWaB0Bf0SCrYmAOUXHFzU2wzgRgmvkijCRn+yUw
         BIICm5si+ZDud1chIVS2vYMDVKty2ejejxoGY0fTUE1Fzi2lFbAmUWChB+on9BtEHLnx
         0wC/doApyGQbHe6jh7aT3TTcApVmMfYhWXx5grXOa3rvAcG4rIwKzp4Y8AlXzRkH0ir4
         MwS58tk5GGuZmS+uzB2DIA394qQEsNH6thx+XDAyZ19voJJ50I3+2uy/yTULB1yHXeyd
         Y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jGfykNBOMNjzBV9HEpceWjJWuKiWAoyGgJLJ+y7J5Ao=;
        b=tXvDtb/ymsFQ0/CMFb3BO7ajfAcHV0BY515fUUe+iGADe+fjPfL6qForpkIP/+Au1V
         iBblmjMlhJonQPIpcyel4YCqPPP1Ib7Y2syGkklj7+6lMZTknEKChp+VT8FsYqAhmSZw
         regufRSRYXdf9SzarxkGQbPVK2bqc9PQa6qoxrQdnMo3xL4blgBKF+pvMubiEdu89VbQ
         RiWPPl2kkSpK25KWbXKqSQKjwrgOnwiTTb5Xoazem5JdJEsQm0BGr1D/QqVX9hO1ZbOI
         ZQR8l8XnlyzxUB3iQGSECicUTHZaT6QrewM+RDFfrGK7t2jVnrz/WNXLbNSiodl55s8H
         e8bg==
X-Gm-Message-State: AOAM530Mt1laggcVo9rKBLoRHs+8KcmnxFPz1LerQDanSNYV8pmqjDpv
        ifSjTWPj8ib4t0Intw31Ltb7Vk24AAGK0m32Kln0lw==
X-Google-Smtp-Source: ABdhPJzRkcXD5GHbUYPvIMquxvS1LlVN89apR+qx6ott04AfDJ+Xwld9rpLMl37OORiiZmK2R6o+e6A5L2er7GNVx/4=
X-Received: by 2002:aca:3241:: with SMTP id y62mr17167244oiy.128.1593715427652;
 Thu, 02 Jul 2020 11:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <5f705897-306e-385e-1c92-bd7b410028f3@gmail.com>
In-Reply-To: <5f705897-306e-385e-1c92-bd7b410028f3@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Jul 2020 14:43:36 -0400
Message-ID: <CAP+JOzTduRu0U7gdvCrxRqTW+VUWc_imaOc0ozXGYe_GpXM9Cw@mail.gmail.com>
Subject: Re: [PATCH] Update the cil docs to match the current behaviour.
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch is malformed. It looks like leading spaces and blank lines
(at the very least) have been stripped.
Thanks,
Jim


On Mon, Jun 29, 2020 at 3:44 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Some features where dropped or change since the docs were last updated.
>
> Signed-off-by: bauen1 <j2468h@gmail.com>
> ---
> secilc/docs/cil_call_macro_statements.md | 6 ++++--
> secilc/docs/cil_container_statements.md | 2 +-
> 2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_c=
all_macro_statements.md
> index 17c46ed9..98b70368 100644
> --- a/secilc/docs/cil_call_macro_statements.md
> +++ b/secilc/docs/cil_call_macro_statements.md
> @@ -44,7 +44,7 @@ macro
> Declare a macro in the current namespace with its associated parameters. =
The macro identifier is used by the [`call`](cil_call_macro_statements.md#c=
all) statement to instantiate the macro and resolve any parameters. The cal=
l statement may be within the body of a macro.
> -Note that when resolving macros the callers namespace is not checked, on=
ly the following places:
> +When resolving macros the following places are checked in this order:
> - Items defined inside the macro
> @@ -52,6 +52,8 @@ Note that when resolving macros the callers namespace i=
s not checked, only the f
> - Items defined in the same namespace of the macro
> +- Items defined in the callers namespace
> +
> - Items defined in the global namespace
> **Statement definition:**
> @@ -80,7 +82,7 @@ Note that when resolving macros the callers namespace i=
s not checked, only the f
> <tr class=3D"odd">
> <td align=3D"left"><p><code>param_type</code></p></td>
> <td align=3D"left"><p>Zero or more parameters that are passed to the macr=
o. The <code>param_type</code> is a keyword used to determine the declarati=
on type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</cod=
e>).</p>
> -<p>The list of valid <code>param_type</code> entries are: <code>type</co=
de>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>se=
nsitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <co=
de>categoryalias</code>, <code>categoryset</code> (named or anonymous), <co=
de>level</code> (named or anonymous), <code>levelrange</code> (named or ano=
nymous), <code>class</code>, <code>classpermission</code> (named or anonymo=
us), <code>ipaddr</code> (named or anonymous), <code>block</code>, <code>na=
me</code> (a string), <code>classmap</code></p></td>
> +<p>The list of valid <code>param_type</code> entries are: <code>type</co=
de>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>se=
nsitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <co=
de>categoryalias</code>, <code>categoryset</code> (named or anonymous), <co=
de>level</code> (named or anonymous), <code>levelrange</code> (named or ano=
nymous), <code>class</code>, <code>classpermission</code> (named or anonymo=
us), <code>ipaddr</code> (named or anonymous), <code>name</code> (a string)=
, <code>classmap</code></p></td>
> </tr>
> <tr class=3D"even">
> <td align=3D"left"><p><code>param_id</code></p></td>
> diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_co=
ntainer_statements.md
> index a570cb23..58b3224d 100644
> --- a/secilc/docs/cil_container_statements.md
> +++ b/secilc/docs/cil_container_statements.md
> @@ -254,7 +254,7 @@ This example will instantiate the optional block `ext=
_gateway.move_file` into po
> in
> --
> -Allows the insertion of CIL statements into a named container ([`block`]=
(cil_container_statements.md#block), [`optional`](cil_container_statements.=
md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statem=
ent is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif=
) or [`tunableif`](cil_conditional_statements.md#tunableif) statements.
> +Allows the insertion of CIL statements into a named container ([`block`]=
(cil_container_statements.md#block), [`optional`](cil_container_statements.=
md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statem=
ent is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif=
) or [`tunableif`](cil_conditional_statements.md#tunableif) statements. Thi=
s only works for containers that aren't inherited using [`blockinherit`](ci=
l_conditional_statements.md#blockinherit).
> **Statement definition:**
>
> --
> 2.27.0
>
