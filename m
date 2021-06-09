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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92978C48BCF
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E9C613E7
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 20:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFIUla (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:41:30 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35651 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFIUla (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 16:41:30 -0400
Received: by mail-ot1-f54.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so25314044otg.2
        for <selinux@vger.kernel.org>; Wed, 09 Jun 2021 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ypRc5GxHrFAoVJepAI9P2N35uGDMoUG+wcMF0Bm0NU=;
        b=M16me05eXhY1jXqKHviV68uOaKkY4lQeQwsArq0qUBcK9/4LIQzOi5mEz21wSApDa7
         4gNkmiTmt1KzNGvv6bhaEGzoudvpkKm9tgSG4g9/UOBT0nzrnZHr/1e3jtLW0WCE5M29
         F7FWgXhgRGYUaf/Q7+Cqy88CIMKjlnbEzDRrwckGiDOcKFcQa0vUZ0YK8ArPJmnJDFHl
         0kfxMQSRDwQAfbGoP9eq5nnEE48ZJOORUweBOXCu7MLPuW2pVSINNurqNFtamAnNLMD+
         Mg/n6Z07lStrAHuA3ewr72o6JOFD0HLLadvRvu0elnChOyx2sgXAp/NDsC5/xRlXsRz8
         R95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ypRc5GxHrFAoVJepAI9P2N35uGDMoUG+wcMF0Bm0NU=;
        b=o5h5yZKeWXDhD+ih9zjQyn/ecr6A7P5XO4M2VOzBEkXOqmH66su442Vqm3mAEaPoL7
         W2yyC7jMwyCR3+dV+RR4Ta/KqLyp5L/Ij5mCyquGilM5dutDECLaoJuPTTq7IWcORN6l
         i8S+U02dJHToD+Zf57Fu2bZnCSMd9vDQlnA2Y7HFaicHPr+v6rFl2NvbxBABQw8oMpCP
         sk519u9aFDt+He1CuFXUg6W3lQtd0CBnhaCZhWSPwXgsk/RIOnGzKLFFiiKFubuDmU7A
         KFxR1B7NLTd3taF686VPyM1MEq0QMjrLvsnnlus+x8oJVQvrsh/gILpijS+5TWdPvRuH
         O6lg==
X-Gm-Message-State: AOAM533rjcYrbP8yKtvr+w6fLCXYkOAfwTfljMD/3IizloRwWBrOI7g2
        rzigZQD2uO/VuTNcwxiVtVkMMlTfRZtXwHostUU=
X-Google-Smtp-Source: ABdhPJxRTNbWE9R/eACGIfXbKMCxXQ9DN5xOIfI2xZDibbcxhowbWEwE/K2zCtkvpNL/QSLBC2wYJN6Kffwc/zYPvOI=
X-Received: by 2002:a05:6830:c5:: with SMTP id x5mr1051561oto.59.1623271106959;
 Wed, 09 Jun 2021 13:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <87o8crcljy.fsf@redhat.com> <20210601151704.2688389-1-liwugang@163.com>
 <87wnr3nv7b.fsf@redhat.com>
In-Reply-To: <87wnr3nv7b.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Jun 2021 16:38:16 -0400
Message-ID: <CAP+JOzQkfRh6wR4aXpMFgCRe=CA2F9B10nrabD1sdaH1W1-skg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: fix the leak memory when uses xperms
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     liwugang <liwugang@163.com>,
        SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 9, 2021 at 10:39 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> liwugang <liwugang@163.com> writes:
>
> > In the define_te_avtab_ioctl function:
> > 1. the parameter avrule_template has been copied to
> > new elements which added to avrule list through
> > the function avrule_cpy, so it should free avrule_template.
> > 2. And for rangelist, it does not free the allocated memory.
> >
> > The memory leak can by found by using memory sanitizer:
> > =================================================================
> > ==20021==ERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 10336 byte(s) in 76 object(s) allocated from:
> >     #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
> >     #1 0x55c2e9447fb3 in define_te_avtab_xperms_helper /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2046
> >     #2 0x55c2e944a6ca in define_te_avtab_extended_perms /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2479
> >     #3 0x55c2e943126b in yyparse /mnt/sources/tools/selinux/checkpolicy/policy_parse.y:494
> >     #4 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/checkpolicy/parse_util.c:64
> >     #5 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/checkpolicy.c:619
> >     #6 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
> >
> > Direct leak of 240 byte(s) in 15 object(s) allocated from:
> >     #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
> >     #1 0x55c2e9446cd9 in avrule_sort_ioctls /mnt/sources/tools/selinux/checkpolicy/policy_define.c:1846
> >     #2 0x55c2e9447d8f in avrule_ioctl_ranges /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2020
> >     #3 0x55c2e944a0de in define_te_avtab_ioctl /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2409
> >     #4 0x55c2e944a744 in define_te_avtab_extended_perms /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2485
> >     #5 0x55c2e94312bf in yyparse /mnt/sources/tools/selinux/checkpolicy/policy_parse.y:503
> >     #6 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/checkpolicy/parse_util.c:64
> >     #7 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/checkpolicy.c:619
> >     #8 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
> >
> > Tested-By: Christian Gttsche <cgzones@googlemail.com>
> > Signed-off-by: liwugang <liwugang@163.com>
> > ---
> >  checkpolicy/policy_define.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 16234f31..52105d3a 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -2400,7 +2400,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
> >  int define_te_avtab_ioctl(avrule_t *avrule_template)
> >  {
> >       avrule_t *avrule;
> > -     struct av_ioctl_range_list *rangelist;
> > +     struct av_ioctl_range_list *rangelist, *r;
> >       av_extended_perms_t *complete_driver, *partial_driver, *xperms;
> >       unsigned int i;
> >
> > @@ -2458,6 +2458,12 @@ done:
> >       if (partial_driver)
> >               free(partial_driver);
> >
> > +     while (rangelist != NULL) {
> > +             r = rangelist;
> > +             rangelist = rangelist->next;
> > +             free(r);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -2484,6 +2490,8 @@ int define_te_avtab_extended_perms(int which)
> >               free(id);
> >               if (define_te_avtab_ioctl(avrule_template))
> >                       return -1;
> > +             avrule_destroy(avrule_template);
> > +             free(avrule_template);
>
> I still think that avrule_template should be free'd before return -1. If
> I'm wrong please explain
>

It looks to me like avrule_destroy() and free() needs to be called
after define_te_avtab_ioctl() regardless of whether or not there was
an error.
Jim

>
>
>
>
> >       } else {
> >               yyerror("only ioctl extended permissions are supported");
> >               free(id);
> > --
> > 2.30.2
>
