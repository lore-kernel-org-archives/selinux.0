Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E5C00140
	for <selinux@archiver.kernel.org>; Wed, 10 Aug 2022 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiHJPeb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJPeb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Aug 2022 11:34:31 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334F22503
        for <selinux@vger.kernel.org>; Wed, 10 Aug 2022 08:34:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10ea9ef5838so18221404fac.3
        for <selinux@vger.kernel.org>; Wed, 10 Aug 2022 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=1y0S6E3uc4tvvp37IN8m33BnGD+wU6BzfLjl4zTxrgk=;
        b=Vn6eI79fHhyDvaahYDScP3uLPHRPSq/L3nARiPhrlYQNDekvCWfi+17XhiydAoEcyY
         KBEz0hCc8DrEXbBb2a63dcd7i05++zjg74UN22a4vANKwSG9eA89uo2Lq+ikj6///TTC
         bj1gThdBfuK/nKG9IUgmPHkJ/r0FA00siXCKQT3Yk1m9k9OaDmp4v5qG4HgoRJa2fled
         3YQ0+dwcZG3A4klrrnkNLVCSYoamJbU+ZEk979Spp51tQuF2IwLliH8DOmtLhJCUdi4H
         7G9vsnGByw8ruVo/XcaTgAbColp6gAi3z/35a9quHY6E3nwmt7waWVxuqCtgeAXjnsSh
         sFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1y0S6E3uc4tvvp37IN8m33BnGD+wU6BzfLjl4zTxrgk=;
        b=F7SzgM8pp/AH+ARu14AVxV0TJVscJXG7R1q3gtvjLEvI5nIvP05xscbU/btTm1b5XT
         SACcqC/f1FEkP4Tl7N2BH5APBWx8eBIJUIWXxqTx1tqCH7CUarm9bH3oMhOovwLFvQ1o
         8jCoIh4uFuT5OyCtTdfH08ssv1Jw/bIHwoREOkZ/kpKmFQPN6/bBbg0WYMUw5cJlA/C4
         u/haf8KVMlc5dmMJ3h6TXLQPLpLoyZ43CgkucUNJmTIRxiQ9GKzVIIFm0LMmho4Js/nL
         K5NoencTOkbzhw+/0nHzRbz+CZ9g8r+tQZcx3wdT/jRBNGEymJiv5QbpxcrPwbGOyfF6
         SlJw==
X-Gm-Message-State: ACgBeo1sKUt/lnJXepCY9dvlNKjUZUYlgoFNevofcO+v/4bc3Y7oyxyP
        RIWea5Ss3yFiFHysiXGB8lwRVgH5RglqPSGgqsrhsQeS96g=
X-Google-Smtp-Source: AA6agR5VecF4aJFqTUyzXASVCfLzxu5C4sXINGoF3m4XXmpF5lbSsaQl/7+FCsU5aJDs672O2vtoCclBYj0ViLDTN7I=
X-Received: by 2002:a05:6870:89a5:b0:116:ca99:6de7 with SMTP id
 f37-20020a05687089a500b00116ca996de7mr1221986oaq.182.1660145667639; Wed, 10
 Aug 2022 08:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220808173620.16760-1-cgzones@googlemail.com> <d395fef5-379b-faa1-d974-2e58ee8381cd@linux.microsoft.com>
In-Reply-To: <d395fef5-379b-faa1-d974-2e58ee8381cd@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 10 Aug 2022 11:34:16 -0400
Message-ID: <CAP+JOzQmkZOtk_c_aB8JMZT9gSkfy8GC1qJyYcqdLqnOZXSNNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: use strict function prototype for definitions
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 9, 2022 at 10:06 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 8/8/2022 1:36 PM, Christian G=C3=B6ttsche wrote:
> > Clang 15 starts to complain about non strict function definitions:
> >
> >      policy_define.c:4907:30: error: a function declaration without a p=
rototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> >      int define_devicetree_context()
> >                                   ^
> >                                    void
> >      policy_define.c:5298:29: error: a function declaration without a p=
rototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> >      int define_ipv4_node_context()
> >                                  ^
> >                                   void
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series:
Acked-by: James Carter <jwcart2@gmail.com>

> > ---
> >   checkpolicy/policy_define.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 8bf36859..f3b48870 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -4904,7 +4904,7 @@ bad:
> >       return -1;
> >   }
> >
> > -int define_devicetree_context()
> > +int define_devicetree_context(void)
> >   {
> >       ocontext_t *newc, *c, *l, *head;
> >
> > @@ -5295,7 +5295,7 @@ int define_netif_context(void)
> >       return 0;
> >   }
> >
> > -int define_ipv4_node_context()
> > +int define_ipv4_node_context(void)
> >   {
> >       char *id;
> >       int rc =3D 0;
>
> Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
