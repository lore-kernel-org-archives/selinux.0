Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D0C433E9
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E065922C9D
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbhAEQJJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbhAEQJJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 11:09:09 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB5C061793
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 08:08:29 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id q25so106817otn.10
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op35E9TBWcLSo12Fp47s3iMdCRwn3ypy8/Wzz1x8NAc=;
        b=IKGTiQL5Rf3NMdI0IVo0R2ge3UzCpdVwdgztn67a+CNlE9654vzfFku3LhTWUQ4Otp
         wc5pLV/UX5yGPHQjqAApP/Yx94/bbglCUNQsWCZjJYE/BpXfEcsBU3Wv8USBrpbwhQhO
         M9tYxPZVqiZ4nfgACJ3q4auUaVjlfNOP+GEpLdWGtDpqvjJ5m94K5sAGqj2R0rWm7yZY
         6pXMx6chENAXDxFdqc2ofDBsMmgNPa/68WdER4rI9///SUaZS55nTiainO55M/+aiJCZ
         ISLVmpNEB1q918XqtgZzgqTo290ne/GldBpPozr6trHtQm6wQ8aqI5ClnmjlsGuchMhC
         xqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op35E9TBWcLSo12Fp47s3iMdCRwn3ypy8/Wzz1x8NAc=;
        b=Gsi0MafAxkRznoUtTJaHD+VpeYon0Q36L3XpMNOZeNOm9AtVNKyDXBbCA49i+TWjJ8
         ndJXZ2H/QS2yBNLTdoL+b7YWLJDhRW8d1s2KAJRx/1Tte/YL0jfX9dXvycmlK3YWDVEc
         13bNNeOiY2YnUiM9W7hFncRlK9PWLgctDQ8nkEO1g+7djZtjhB+Kryz+8oX+l+KYyxpf
         Fy8OXU4SMLm5Se+bge1RKvIoJqPF8PjjRM6xzfTONeJZjmZTq17paHPxf82nyf3byncg
         r9hQW5D+6F6vTUlOijVDWizZQMFdVdRl+vm2MuZUdM8Lp0p7bRNrQUMzKj8g8rtqhBG7
         LjTQ==
X-Gm-Message-State: AOAM533v41kvv/bjKJNlBXowrWxBleBvqZzwI8JF/4vZ8/XmoyJm5/v4
        dtOsSb0Sdsfb59NTDa7q7Qb+R2O0wHMtex8WXQI=
X-Google-Smtp-Source: ABdhPJyzfnDVpDlAVqP8oAinV7N1EqescxNl3YSi20z/VZ5+D5aKpBbU7pg9v2Iu1CuyXe/6Qi6D0F/rVB+N2vB8mbI=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr87427otr.196.1609862908575;
 Tue, 05 Jan 2021 08:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <20201230100746.2549568-6-nicolas.iooss@m4x.org> <CAP+JOzSpZcod2TF6j=XEXNw5VyQoDuaYGJ_65AQAD9G-ymUtSA@mail.gmail.com>
In-Reply-To: <CAP+JOzSpZcod2TF6j=XEXNw5VyQoDuaYGJ_65AQAD9G-ymUtSA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 5 Jan 2021 11:08:17 -0500
Message-ID: <CAP+JOzSOe4QK8jxuDEQQj0rJkLQCwi0LL7BZ0fmuW3VGR0c_7w@mail.gmail.com>
Subject: Re: [PATCH 6/6] libsepol/cil: destroy perm_datums when
 __cil_resolve_perms fails
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Applied.

Thanks,
Jim

On Mon, Jan 4, 2021 at 1:18 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 5:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > When __cil_resolve_perms fails, it does not destroy perm_datums, which
> > leads to a memory leak reported by OSS-Fuzz with the following CIL
> > policy:
> >
> >     (class cl01())
> >     (classorder(cl01))
> >     (type at02)
> >     (type tpr3)
> >     (allow at02 tpr3(cl01((s))))
> >
> > Calling cil_list_destroy() fixes the issue.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28466
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index ecd05dfa5dab..255f17ae7e30 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -146,6 +146,7 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
> >         return SEPOL_OK;
> >
> >  exit:
> > +       cil_list_destroy(perm_datums, CIL_FALSE);
> >         return rc;
> >  }
> >
> > --
> > 2.29.2
> >
