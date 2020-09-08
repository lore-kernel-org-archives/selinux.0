Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CFBC433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089CA20738
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 17:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqMriViL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgIHRe6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbgIHQPM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 12:15:12 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0FC0619CB
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 06:50:53 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id y25so3953071oog.4
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMHNpSNQxWkq2TWHkpZ+TLhjnQRyIx9gG+MOgvuEgFg=;
        b=LqMriViLOq/+yszaY+c0dgPXwRCiPWC9pUAfxOeCBw6b1jK8jH/PPUsxzfpwsk5gF9
         2s0MDJwb2+unEtzS41g7Ow7t2Lz+fkSMdyIA7c7xfj2yHNheKOWVPPe1iQQV4TX90F6E
         1Wa/zXDjLt1cWEK5qBtFnBKvx5LXh0jZId+nR6Bia4XtcOSBsYxCT3mjOd5kZxB+XQR9
         idk0CYhkQQps/74EBP4rs/Jer1JXxOXSG6PZwxyKfx3wCWKCojMuqn+27EkhQY7voybY
         T7Fa8c3nxc6HiPElAw8KoPehg7s8S8zoMJYMPxibIsvAZrjsmVjoZjxObkNPFclNnAuK
         DaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMHNpSNQxWkq2TWHkpZ+TLhjnQRyIx9gG+MOgvuEgFg=;
        b=ltnTPKt5VMtVLA9WAYXe3dAnXgv8FH7M9h8scRPdeSmMdHUm4QKNBTP9D2g7e+tzr6
         gCr5ptrcA+nOXZGotpD7zMv50P/77vvzHQmJyc9mde9vjKzW2FOTzHhG4chaZ5Rqa+V0
         UfyK7WQ+pRc9oQrFVIUjRtmr+2Y2nd/Qx3RcFArdkswZ5pCFbLHfxo+c8SX4ojoApAEX
         QUZAU7cfA83GXPfVRtFws23Wcr9nbA7Vr0b7HKK3DZLGtS1m9qHI1FQP2rm8v4hBKIti
         aeVqwgzyQTLzn7TeFPlin6+L19Pgn7k/94CxhYFxyn2DJaxeH/P0A9qVPEnMt8Q39Qk4
         8Ixg==
X-Gm-Message-State: AOAM530zGNlsROhzqolljbIVWlDHbpmA1nKeZZPO08fv5C9k+a/4FUr3
        h8rY6AdBlg1rvFkgyBVSZ5pqYnTCYW+Bpp1Ls0o=
X-Google-Smtp-Source: ABdhPJz2VMpPyw8hKgrhGSpwRz9VdqpjsEtZYpbw7+CiUWN8EcXS6RLOYVPTIT/AYpx1GJ7yY+E9qmx2vAKaFvygi9Y=
X-Received: by 2002:a4a:dc44:: with SMTP id q4mr18392401oov.71.1599573053129;
 Tue, 08 Sep 2020 06:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com> <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
 <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 09:50:42 -0400
Message-ID: <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 9:46 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 4, 2020 at 8:49 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > CIL was not correctly determining the depth of constraint expressions
> > > which prevented it from giving an error when the max depth was exceeded.
> > > This allowed invalid policy binaries with constraint expressions exceeding
> > > the max depth to be created.
> > >
> > > Correctly calculate the depth of constraint expressions when building
> > > the AST and give an error when the max depth is exceeded.
> > >
> > > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > The fix for conditional boolean expression depth checking can be a
> > separate patch.  For this one,
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Actually, this breaks selinux-testsuite. Will have to look into why.
> /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
> test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
> Max depth of 4 exceeded for constraint expression
> Bad expression tree for constraint
> Bad constrain declaration at
> /var/lib/selinux/targeted/tmp/modules/100/base/cil:919

Here is the failing cil module:
$ cat policy/test_mlsconstrain.cil
(mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1
mcs_constrained_type) (neq t2 mcs_constrained_type))))
(mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1
mcs_constrained_type) (neq t2 mcs_constrained_type))))

Maybe an off-by-one in your depth checking?
