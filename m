Return-Path: <SRS0=U9Ad=R3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EFC43381
	for <selinux@archiver.kernel.org>; Sun, 24 Mar 2019 10:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0435222A7
	for <selinux@archiver.kernel.org>; Sun, 24 Mar 2019 10:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfCXK5g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:57:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40460 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCXK5g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Mar 2019 06:57:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id 3so4859562oir.7
        for <selinux@vger.kernel.org>; Sun, 24 Mar 2019 03:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hVUhsAgvZtnx8r3Ef39s656IuqsCyUYiw0poxDFLhs=;
        b=NGrnUhe63q+BuQH01XwcSgPdfeFcttTrDgxMUhOOKbkG4CbExNfFn0liKsLChNTArM
         PNl4u8WfsGQxyfEpEngCzW4a2yaFlqNXr6lGTRUnOCf58EwgmbCb3DIWfAMNSolF7oW2
         IT3O0qrPjsQ0SvBBqk+yxxalhbM43B1fBshbh97uJoEx7pR/sTmhR+/yvyAobjnEImwa
         JILSX4IjFVNAZYfiQGkG+3o+97ZTFFeUkkY/0p2/J5l7eKLw5rW0nf1g+MyUECF1Xzyy
         YI9aw4yUxYu/MkJJzTbq4q81zASvC15flSEmRzbBrIsvLkt4HoLHCuDbWfiX8kNAjEhC
         +4Dg==
X-Gm-Message-State: APjAAAUT23LLx5WQDTzSjMkyeNIEzeKpHudjpeekbFFhezvNBDuyVJ+N
        hfTSnGBdQfSjPZpTXS5GqsaibQjAkeeA2B73qENYxA==
X-Google-Smtp-Source: APXvYqyIVULixzzNzbzaJ9gyNPYUv7ga0AGR78odQaExm9CJSwcoexz4TS3Br1hULsXra10jrgkOXbxTsZ72K+tMDnY=
X-Received: by 2002:aca:5747:: with SMTP id l68mr8367963oib.103.1553425055605;
 Sun, 24 Mar 2019 03:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190324101003.GA17131@hari-Inspiron-1545>
In-Reply-To: <20190324101003.GA17131@hari-Inspiron-1545>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 24 Mar 2019 11:57:27 +0100
Message-ID: <CAFqZXNsDrcfMsCwjqv=9H3LswS1jyigKgRCDmER59VJOVd-Edw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fixed parse warning Using plain integer as NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>, jannh@google.com,
        Alexey Dobriyan <adobriyan@gmail.com>, sgrover@codeaurora.org,
        peter.enderborg@sony.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 24, 2019 at 11:10 AM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
> Changed  0 --> NULL to avoid sparse warning
>
> Sparse warning below:
>
> sudo make C=2 CF=-D__CHECK_ENDIAN__ M=security
>
>  CHECK   security/selinux/ss/services.c
> security/selinux/ss/services.c:1323:32: warning: Using plain integer as
> NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ec62918..30cea59 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1320,7 +1320,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>         }
>         if (only_invalid && !context->len) {
>                 scontext = NULL;
> -               scontext_len = 0;
> +               scontext_len = NULL;
>                 rc = 0;

The warning is correct, but this patch is the wrong fix. I intended to
set the values to the objects pointed to by the pointers, not the
pointers themselves. As is, the assignments have no effect, because
they only modify the local variables, which are not used further in
the function. Fortunately, *scontext and *scontext_len are already set
to NULL/0 at the beginning of the function, so the code is technically
correct even without them.

The correct fix is actually to remove the assignments entirely. I'll
send a patch that does that tomorrow.

>         } else {
>                 rc = context_struct_to_string(policydb, context, scontext,
> --
> 2.7.4
>

Anyway, thank you for catching the mistake! One more reminder for me
to finally install sparse and add C=1 to my kernel build command
line...


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
