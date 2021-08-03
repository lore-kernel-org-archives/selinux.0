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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB3C432BE
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C336960F92
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 14:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhHCOEY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhHCOEX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Aug 2021 10:04:23 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E6C061757
        for <selinux@vger.kernel.org>; Tue,  3 Aug 2021 07:04:11 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so9196464oto.12
        for <selinux@vger.kernel.org>; Tue, 03 Aug 2021 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlmFm65fn1W/KDUHDULboihqGO7DCWIA+g6ADPbIBHA=;
        b=Zq00hjt+D2CJodTuQsjes8TGzzls7mD5RtgFWX/CZhTtsrfXUD3NOo5aiRpOFtyOGv
         8SfD1LFD6VE82kw97GfTH8Eo2+L9lEzF00+mmjgZ0ZNHh/x8vXXDN7AwKheskPCV9ZRG
         TIjJEeQHKhxOA5uTk7sIo6oXnxB+2f3Axq/9e4GFSq33A8wRPQd9UFVcKG03rZUfoAce
         ILY67pmle5i8WNWzURQU2+tM+sWT4szRiqTM5tr9d98ECGBQa4GMArQzCpZFoAkjCq35
         eZMCyo7vgPOlG5w2DFRvr31n2A7+7CPHNHZDN1D58xhjiNyiQamUx6OzaaRxYZlmpkDF
         R8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlmFm65fn1W/KDUHDULboihqGO7DCWIA+g6ADPbIBHA=;
        b=siYlD48psY3vpM5fkNzqwTkYQbvsHcJdLCvpGvtVkotOLEvrV9BLuwI2uhlv65KsH0
         ShJ1THRRzr6IvfKE5uGpO/J+K1KTSNYU4ECW4w25VlccaVgtIifjN8LOtZbtV+28ztDb
         8Kg2CtUPqJT1GOEyOq4jXgmHa0HZsiVKNI2Uk+Slt+OCemwxEcGh+usbb2kH2ubQXlib
         VJTmlaw4pKgGKge0IVNxVnsN8gsx0D1BrF9ukct8A/c6A43rzg7Xw65/lTRUkL3k0fEB
         P215cNzHqQW0AAUo9dHlnncIjQ5hNE8pNdTCeKTNt5MY44B9kxkzZTDv0DDy49K94/O8
         VRBg==
X-Gm-Message-State: AOAM5326T+xzoKCqIzXARjFiNpVtmw4Q72qJTCRT1ZxgXh0PHDUTS9Bo
        hKCayQuBFTf3WrQ0jBmmW/jTNKobvSjYvi3DYpU=
X-Google-Smtp-Source: ABdhPJxzy3DmLp3PmCw6FAJ2/iNwENebA5sN0fuf1/kd4LwZz73dQWa1np+5bbSLlPoLHAGt1cgDRbWuixP0l50YbQY=
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr15484767otl.295.1627999451368;
 Tue, 03 Aug 2021 07:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210728092135.132957-1-plautrba@redhat.com> <CAP+JOzQBmAHK3fLRhrKtaEuerBGmOj=w_+sWN34540YLf7i_vw@mail.gmail.com>
In-Reply-To: <CAP+JOzQBmAHK3fLRhrKtaEuerBGmOj=w_+sWN34540YLf7i_vw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 3 Aug 2021 10:04:00 -0400
Message-ID: <CAP+JOzSipuPqLreTrzrn4MUh4_TOa3q4La=ZhKRNdwagTQVT5g@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Fix USE_AFTER_FREE (CWE-672) in semanage_direct_write_langext()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 4:43 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jul 28, 2021 at 5:22 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > From fclose(3):
> > Upon successful completion, 0 is returned.  Otherwise, EOF is returned
> > and errno is set to indicate the error. In either case, any further
> > access (including another call to fclose()) to the stream results in
> > undefined behavior.
> >
> > Fixes:
> >     Error: USE_AFTER_FREE (CWE-672): [#def1]
> >     libsemanage-3.2/src/direct_api.c:1023: freed_arg: "fclose" frees "fp".
> >     libsemanage-3.2/src/direct_api.c:1034: use_closed_file: Calling "fclose" uses file handle "fp" after closing it.
> >     # 1032|
> >     # 1033|   cleanup:
> >     # 1034|->   if (fp != NULL) fclose(fp);
> >     # 1035|
> >     # 1036|     return ret;
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/direct_api.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > index 9a4e79385b69..f0e2300a2f58 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -1022,6 +1022,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
> >
> >         if (fclose(fp) != 0) {
> >                 ERR(sh, "Unable to close %s module ext file.", modinfo->name);
> > +               fp = NULL;
> >                 ret = -1;
> >                 goto cleanup;
> >         }
> > --
> > 2.32.0
> >
