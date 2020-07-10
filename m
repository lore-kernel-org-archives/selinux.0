Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA7C433E3
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569EE207BB
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vL9X2OT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJQSC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgGJQSB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jul 2020 12:18:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA23C08C5CE
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 09:18:01 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so4577482otq.5
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u+PE1R0R7438FDIjJ6Zh+G1Lvc2cEJhmND8kZG47cw0=;
        b=vL9X2OT1x4yITZs8cjF5DMZ2lh4cPejQWscvLISDB6Jic6amPLtjySBYsLL3TTGvjQ
         HJldAQI7OK9FFadxBarNg+DGzLENs5w4RGgkXLs9wBwFEIiwPPaJk1bYkW6SVGa10ulr
         emjYTBBrXuBt7WXS3zP7/EalO+/UyL0ay0RwfgAzC+50/BJMKl8mMGfcihDub28s+ZWb
         YJHnhs5hfOLGzt9Gkrh7k58o80MIiGSAA30MVdfH2psdzSljlB1ZC6L2TZMv6Uqo7Nus
         bl8W7f6AzljxtU5v6k812etmpRWAQLo9zSICBiQh0Nw7IaHwmVO6DCDYS6UwtrzuVz/7
         4YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u+PE1R0R7438FDIjJ6Zh+G1Lvc2cEJhmND8kZG47cw0=;
        b=AWekxUv8qC2OxY5c4Lp7ZboewQZ5DmcFI+NMqXa1iKGLbIfWWgkQPgWhDRJFClrifW
         Jx+nLwrbqA3iCOYdOMevjqIGPt0NIPIXIjObJFbrmEWm7XhKIhQiVLUo6FIPWxtgAiJv
         IKI2eB2w5B2QSAz1perChYicbIT1H1QYPKv/2/nIaWpJhtQGQGhtb0CpaYsdCNOdWIci
         p/q2GmzXHfOvqtZVoc8pw1rmurw7vcFdIz/GZc0XI74MleIE4f+PfIiGlt7d5WM8kHGR
         Ce7l6JgIjo9t4ZiM4n5vCEouVhygxffPhq3MYlYoH0NbrBPpo+kY491f64Pf8hq5OYfR
         MXog==
X-Gm-Message-State: AOAM5316VF6Kt5r+Bzqcoj7v1AMXsNW2aHRrViIS7TKzrrhUKgex+uMS
        mgfd1gANMXjDCUGTOrowJwD3y6lcDnhTQUppUnavWgDZ
X-Google-Smtp-Source: ABdhPJy/VQIGpjVMQjTvur46LKqyKbMAjpZGiHN8voHKuOMn3yCGaFkOfug9gb9BGrTRdWD4IJwo+vnYYJPWCq72V1A=
X-Received: by 2002:a9d:20c9:: with SMTP id x67mr47969336ota.295.1594397880247;
 Fri, 10 Jul 2020 09:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzTduRu0U7gdvCrxRqTW+VUWc_imaOc0ozXGYe_GpXM9Cw@mail.gmail.com>
 <2da3deec-0098-9847-7412-9d9654b6645f@gmail.com>
In-Reply-To: <2da3deec-0098-9847-7412-9d9654b6645f@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 10 Jul 2020 12:17:49 -0400
Message-ID: <CAP+JOzTTmMrU3EPkbMnfYwbd5uRVMr+b2xo704teO_Fcm6sytA@mail.gmail.com>
Subject: Re: [PATCH v2] Update the cil docs to match the current behaviour.
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 4:37 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Some features where dropped or change since the docs were last updated.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> Notes:
>     Updated to include additional fixes and a correct Signed-off-by line.
>
>  secilc/docs/cil_call_macro_statements.md | 6 ++++--
>  secilc/docs/cil_container_statements.md  | 2 +-
>  secilc/docs/cil_reference_guide.md       | 2 +-
>  secilc/docs/cil_user_statements.md       | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_c=
all_macro_statements.md
> index 17c46ed9..98b70368 100644
> --- a/secilc/docs/cil_call_macro_statements.md
> +++ b/secilc/docs/cil_call_macro_statements.md
> @@ -44,7 +44,7 @@ macro
>
>  Declare a macro in the current namespace with its associated parameters.=
 The macro identifier is used by the [`call`](cil_call_macro_statements.md#=
call) statement to instantiate the macro and resolve any parameters. The ca=
ll statement may be within the body of a macro.
>
> -Note that when resolving macros the callers namespace is not checked, on=
ly the following places:
> +When resolving macros the following places are checked in this order:
>
>  -   Items defined inside the macro
>
> @@ -52,6 +52,8 @@ Note that when resolving macros the callers namespace i=
s not checked, only the f
>
>  -   Items defined in the same namespace of the macro
>
> +-   Items defined in the callers namespace
> +
>  -   Items defined in the global namespace
>
>  **Statement definition:**
> @@ -80,7 +82,7 @@ Note that when resolving macros the callers namespace i=
s not checked, only the f
>  <tr class=3D"odd">
>  <td align=3D"left"><p><code>param_type</code></p></td>
>  <td align=3D"left"><p>Zero or more parameters that are passed to the mac=
ro. The <code>param_type</code> is a keyword used to determine the declarat=
ion type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</co=
de>).</p>
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
>  </tr>
>  <tr class=3D"even">
>  <td align=3D"left"><p><code>param_id</code></p></td>
> diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_co=
ntainer_statements.md
> index a570cb23..58b3224d 100644
> --- a/secilc/docs/cil_container_statements.md
> +++ b/secilc/docs/cil_container_statements.md
> @@ -254,7 +254,7 @@ This example will instantiate the optional block `ext=
_gateway.move_file` into po
>  in
>  --
>
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
>
>  **Statement definition:**
>
> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_referen=
ce_guide.md
> index 1b1fccca..3e33c5f7 100644
> --- a/secilc/docs/cil_reference_guide.md
> +++ b/secilc/docs/cil_reference_guide.md
> @@ -176,7 +176,7 @@ Should the symbol not be prefixed with a dot, the cur=
rent namespace would be sea
>  Expressions
>  -----------
>
> -Expressions may occur in the following CIL statements: [`booleanif`](cil=
_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statem=
ents.md#tunableif), [`classpermissionset`](cil_class_and_permission_stateme=
nts.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typ=
eattributeset), [`roleattributeset`](cil_role_statements.md#roleattributese=
t), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrai=
n`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constrain=
t_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.=
md#validatetrans), [`validatetrans`](cil_constraint_statements.md#validatet=
rans)
> +Expressions may occur in the following CIL statements: [`booleanif`](cil=
_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statem=
ents.md#tunableif), [`classpermissionset`](cil_class_and_permission_stateme=
nts.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typ=
eattributeset), [`roleattributeset`](cil_role_statements.md#roleattributese=
t), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrai=
n`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constrain=
t_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.=
md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsval=
idatetrans)
>
>  CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.=
html) or Polish notation and may be nested (note that the kernel policy lan=
guage uses postfix or reverse Polish notation). The syntax is as follows, w=
here the parenthesis are part of the syntax:
>
> diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_st=
atements.md
> index bbd76eff..26e45510 100644
> --- a/secilc/docs/cil_user_statements.md
> +++ b/secilc/docs/cil_user_statements.md
> @@ -260,7 +260,7 @@ This example will associate `unconfined.user` with a =
named [`levelrange`](cil_ml
>      (categoryorder (c0 c1))
>      (sensitivity s0)
>      (sensitivity s1)
> -    (dominance (s0 s1))
> +    (sensitivityorder (s0 s1))
>      (sensitivitycategory s0 (c0 c1))
>      (level systemLow (s0))
>      (level systemHigh (s0 (c0 c1)))
> --
> 2.27.0
>
