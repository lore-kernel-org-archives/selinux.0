Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA6C433E5
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 01:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FEF2070E
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 01:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="p28dIQLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgGQBhA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQBg7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 21:36:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB9C061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 18:36:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so8960294ejb.2
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 18:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uJtwl3hRYQ22rYv8YS94mlR9whY8xlg+vvUHW5rjI78=;
        b=p28dIQLjvaxRRUnfcyM2iXI/kFYWyM5iKo5Hdj7zVKWdF1QKEDlZpoSolMeRpGpLhh
         lTJOIq2cQ0BQeooht3iPlnu5RHaS1IoisUar3rI00l2e3g12VH7qGs+hbxdhNoHF8kWH
         smyNBVQoYfM/XdeOJOwAogKF4gtqWOuBJtOl/HxIKQmrlgaRcwGjdXaBqZlqtsPAkD54
         AKCcELORgflddU5j4eXXs/nhm8ZwwJ7N4UkAvWVFGbtbhg4X09qFwkL/484Mulosiznf
         QuNXLbhqOVUtwpQmTpbkwM7j41TJMnteHjSTC1aH5HNT46F7hhFVi3EGofhDu39CJUh2
         N/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uJtwl3hRYQ22rYv8YS94mlR9whY8xlg+vvUHW5rjI78=;
        b=dKFzFcDIz4rpJkEeFrgchAMOqY9tI2wlx1TRtbCHc7XZHqB2lf5nFAWn1SxGypyPn/
         wwD+Ep5LQFmOPpwRJ8JN0/+kb1FtWExGEbb8OxjLm44yMlBis0rFtufpQ7zwb07lbA8M
         Idqy4G8qFGARQ3uIw6cMLk/knUfO8y36zHGQv1o6H+IiVHDgzsxxkitS0JfknZ830HoS
         qNAa0idm6BIis8f84qwFwtwGDXGLf8hgiiD7ug0n4KsdUc4eUYfaklisA2q3DnTMKdj0
         OB5RZG8sh0KTxwhSFGZT05U89A+1j6QskzohIsivBwapIaLnXzhC4u7Ui2oCZK9g2j+c
         o+2w==
X-Gm-Message-State: AOAM532Zzr5z6BJ/xuolnaaRq3vkEWj/Yzn19/OvmTAaqjwYJS30emlb
        Y2K5pUJVckiywBjwvOUn63pm7ylRDDDcLBn06WOOHfU=
X-Google-Smtp-Source: ABdhPJxn2NaRQn0Gy73nmIf1dVzji5Ubgt5zqRdnPYYLyIgPeI9Ldw2OYW0sAXZxjP6d11x2a4vTQY8EhkkS4wVJ6Ic=
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr6063782ejf.398.1594949817781;
 Thu, 16 Jul 2020 18:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200716111825.953813-1-dominick.grift@defensec.nl> <20200716121729.962241-1-dominick.grift@defensec.nl>
In-Reply-To: <20200716121729.962241-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jul 2020 21:36:46 -0400
Message-ID: <CAHC9VhS1d_=gotE6eau2hmxM+OjujY=u8sMQE10gNKOJ1z87dQ@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v4] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 16, 2020 at 8:18 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Elaborate on labeling. Touch on the significance of the default statement=
, on various av permissions related to labeling using the libselinux API, a=
nd on how the kernel and unlabeled initial security identifiers are used to=
 address labeling challenges in special cases such as initialization and fa=
ilover respectively.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: fixes patch description
> v3: adding patch description, s/policies/policy's/, split unlabeled and k=
ernel descriptions for clarity
> v4: fixes another typo in description and emphasize system initialization=
 a bit
>
> src/objects.md | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/src/objects.md b/src/objects.md
> index 58664ef..c67787d 100644
> --- a/src/objects.md
> +++ b/src/objects.md
> @@ -110,14 +110,20 @@ objects is managed by the system and generally unse=
en by the users
>  (until labeling goes wrong !!). As processes and objects are created and
>  destroyed, they either:
>
> -1.  Inherit their labels from the parent process or object.
> +1.  Inherit their labels from the parent process or object. The policy
> +    default type, role and range statements can be used to change the
> +    behavior as discussed in the [**Default Rules**](default_rules.md#de=
fault-object-rules)
> +    section.
>  2.  The policy type, role and range transition statements allow a
>      different label to be assigned as discussed in the
>      [**Domain and Object Transitions**](domain_object_transitions.md#dom=
ain-and-object-transitions)
>      section.
>  3.  SELinux-aware applications can enforce a new label (with the
> -    policies approval of course) using the **libselinux** API
> -    functions.
> +    policy's approval of course) using the **libselinux** API
> +    functions. The `process setfscreate` access vector can be used to
> +    allow subjects to create files with a new label programmatically
> +    using the ***setfscreatecon**(3)* function, overriding default
> +    rules and transition statements.
>  4.  An object manager (OM) can enforce a default label that can either
>      be built into the OM or obtained via a configuration file (such as
>      those used by
> @@ -269,6 +275,23 @@ and manage their transition:
>
>  `type_transition`, `role_transition` and `range_transition`
>
> +SELinux-aware applications can enforce a new label (with the policy's
> +approval of course) using the **libselinux** API functions. The
> +`process setexec`, `process setkeycreate` and `process setsockcreate`
> +access vectors can be used to allow subjects to label processes,
> +kernel keyrings, and sockets programmatically using the
> +***setexec**(3)*, ***setkeycreatecon**(3)* and
> +***setsockcreatecon**(3)* functions respectively, overriding
> +transition statements.
> +
> +The `kernel` **initial security identifier** is used to associate
> +specified labels with subjects that were left unlabeled due to
> +system initialization.

You are iterating faster than I can review the patches ;)  Please
don't misunderstand, I'm very happy you're contributing to the
notebook; I was hoping people would get involved and I'm glad to see
that is happening.

That said, while it is true that there are a few objects that are
initially assigned the "kernel" isid, those should gain proper labels
as they complete the initialization process, unless of course they are
actually owned by the kernel.  Which brings me to the next point, some
objects are legitimately owned by the kernel, the fact that they are
labeled with the "kernel" isid is intentional.  The same holds true
for the "kernel" isid as a subject label, in cases where you see the
"kernel" isid as a subject, it is actually the kernel acting on
something.

> +The `unlabeled` **initial security identifier** is used
> +to associate specified labels with subjects that had their label
> +invalidated due to policy changes at runtime.
> +
>  ### Object Reuse
>
>  As GNU / Linux runs it creates instances of objects and manages the
> --
> 2.27.0

--=20
paul moore
www.paul-moore.com
