Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB4DC433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEC960FE4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhDSS1X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbhDSS1X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 14:27:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD02C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 11:26:52 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso31558826otb.13
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BMm0bWv4fG4Pd8ZAj/ky/2t6DA+yKhV3Y37wffHjOYA=;
        b=k/cw3u/YSjjLMiUgtdhR8dMZknZUP23AKFp+JcWe0a/3WlrAhBmFkJl2yDwwxrJQAH
         Lly7ngvgQn5wMUEmnMwPQqD+QPvDXelAh7bkQzjMgY7YZ6WzTpWD6+eXpkQStoksilcU
         XSzlvUxZ6U0NP/+i90S3kvg3lWDOJdy5WwM1qutTAKdThDeNMsSbdUx4HZJU5VAQ5QTt
         MFKZRS+YuZXWoFl6FrgDyebPDGRwxNN0pqyB4mOMXLqD9GHk6X4mNVq8NA9jhSqRl0hF
         tt/qqzizzE/9vMS3kQyjSdRhffXqtCar+E7t33boXb9buQNfTudpbuFNN3N8EP/GwMPO
         /nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BMm0bWv4fG4Pd8ZAj/ky/2t6DA+yKhV3Y37wffHjOYA=;
        b=VpbIlkN+Ar0u3nFm/oLQemMyZ4z+ZgsUTuZ6dCOaT6W3nqRaFyb9dIrj6d8cyo0tc7
         h31oAQkix3x87fmU7eTr7qALN+kvZBM/5OAxIWeKQ8wkzv/ZR6sTaJ6bdfK1TGBRbc2F
         5tZW4HAOB+TTuFhVBXZGVct+FMrXpd/0J7sOfC1LSLMeHOq24VwgumlPehY/+sCvfIPv
         EMx6fDuT8Br3GsIOMnhmSnInnoAmQ+4jo/9eg3aP0rQR7doGLMQbEkwl9fokkMU5B8Od
         h8pJsuNAQ5BzwJv7Frv3T2V0Z68qKFfKC12r2qG11IMOmFcIB3nwus3olZBKU+VLYihz
         n6mQ==
X-Gm-Message-State: AOAM531ppzy0Onqr8x/wMeGv4Rh0VkuWPja9kyQOeFsuZFv2x74x4YgC
        1wy0ku6gVuOCGfWz/XqZWKONtTIbxuoD1Ht4Q+L5+sJiYgo=
X-Google-Smtp-Source: ABdhPJz8gF+tFd/pCvYn8tqYfS1sERVjkmjbCx5UvBlwhagGJOa4m8qDzArdMtIZD6sE7ItUBTIR0FC8BsUc4ZvZhSc=
X-Received: by 2002:a05:6830:1beb:: with SMTP id k11mr1466356otb.59.1618856811544;
 Mon, 19 Apr 2021 11:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210330173920.281531-1-jwcart2@gmail.com>
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 19 Apr 2021 14:26:40 -0400
Message-ID: <CAP+JOzSE5w8595W75-FP0LW1W8LGW3XQ9G7sP1amnnXzMWs4tw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Update checks for invalid rules in blocks
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 30, 2021 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> Looking into a bug that OSS-Fuzz found led to patch 7, Check for
> statements not allowed in optional blocks, which is the most important
> patch in this series. Working on patch 7 led to fixing some other
> problems with the checks for invalid rules, cleaning up some of the code,
> and improving the CIL documentation.
>
> Patches 1, 2, 4, 5, and 10 are doing various cleanups.
> Patch 3 fixes a bug that prevents the first rule in a block from being checked.
> Patches 6, 7, 8, and 9 update the checks for invalid rules.
> Patch 11 fixes a bug that prevented some error messages from being displayed.
> Patch 12 updates the CIL documentation.
>
> There is still work to do in this area. I am not sure why sensitivity and
> category statements are not allowed in blocks, but everything else is. That
> is why I didn't add those checks when building the AST. It is not clear if
> mls, handleunknown, defaultuser, defaultrole, defaulttype, defaultrange,
> and policycap should be restricted to the global namespace.
>
> James Carter (12):
>   libsepol/cil: Reorder checks for invalid rules when building AST
>   libsepol/cil: Cleanup build AST helper functions
>   libsepol/cil: Create new first child helper function for building AST
>   libsepol/cil: Use AST to track blocks and optionals when resolving
>   libsepol/cil: Reorder checks for invalid rules when resolving AST
>   libsepol/cil: Sync checks for invalid rules in booleanifs
>   libsepol/cil: Check for statements not allowed in optional blocks
>   libsepol/cil: Sync checks for invalid rules in macros
>   libsepol/cil: Do not allow tunable declarations in in-statements
>   libsepol/cil: Make invalid statement error messages consistent
>   libsepol/cil: Use CIL_ERR for error messages in cil_compile()
>   secilc/docs: Update the CIL documentation for various blocks
>
>  libsepol/cil/src/cil.c                    |   8 +-
>  libsepol/cil/src/cil_build_ast.c          | 193 ++++++++++++----------
>  libsepol/cil/src/cil_resolve_ast.c        | 174 ++++++++-----------
>  secilc/docs/cil_call_macro_statements.md  |   2 +
>  secilc/docs/cil_conditional_statements.md |   6 +
>  secilc/docs/cil_container_statements.md   |  28 ++--
>  6 files changed, 205 insertions(+), 206 deletions(-)
>
> --
> 2.26.3
>

This has been applied (with the whitespace error in the last patch fixed).
Jim
