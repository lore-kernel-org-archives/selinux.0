Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D2C28D13
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 23:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiHVXUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHVXUD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 19:20:03 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832804DB5A
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 16:20:01 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11d7a859b3aso3592197fac.4
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wW2i3aCIFEo7pDQSECbSrbUwuUZTgGHFVPga5GFFMaU=;
        b=z9mkaAMA0OeKZigCW472MV8MaCLOsZ1u2mdtWmW4MgW5UTzvQSJgQqR1knQtAFW3iv
         k8p1vX2ci5FHFXgEJqBeVUJwKztqeSdkk8KQ5/LC/xJPAkRJpN7qHKQv3pvHhAgTezjl
         coBrXRhPFcBSSdQu8mC06QsOtmiaOC2MOPndSTXlFcyn3zSGfB/QFu+hcstD/uNe7kvy
         Cb378viSoOrjl5OtyzNiNXHSCD4Dgw2VNDCZ/FdRMSt5gUIl1PGTesfkBwG0TDxJh0SJ
         7/PwUp5fy3mQMLU4aq11jxOL7czwzsCUFULvRjaS1hq5q7pKtFF1KZHpRC+BRErzbyu7
         +RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wW2i3aCIFEo7pDQSECbSrbUwuUZTgGHFVPga5GFFMaU=;
        b=QFEZ0BXkTyl1txRJMVWKsVIx/AAAvsXZFMVKTTkrzJwdqUTFyaKrTg3Oa/RUFN4KX1
         ZI4i3qBQ8IcUCBYxew0AUTqHPQzenXJGnZhqSpn2kg/ARXMkCNLxgfVKkPXLq8whAE26
         DLmvPKaL0J2+QQjy3S7YL8yqr4b8FSxXcdm3jZMGc8hAvoI6yuIa3bEZale3tbtizVHr
         Kqm8I3pxokSaKvbnF9T7Kl9w7b/H7uRn2VHFtGG4I9AYDoWpv3HbBA6MQ8gN0QGfx9wl
         aj6Se8XSjX5C21Uf13LHoRmdqx3xpcULizMByOFqC93Bur01XI+9gNhyAplq6njzzPze
         dhvw==
X-Gm-Message-State: ACgBeo164tp3qvO7nhJB7qH5+T2X9t/XI2FoiPogMhbOBmpJxxj89hIk
        jBQbBlRPiZ0sE3qnew+vZu+a73xLtYH3JJIWVzIh
X-Google-Smtp-Source: AA6agR4NXF5r+CZHoIO8jkK74/6G8PipEhvgypC1bVeEdCHkwweg98XSiGOikc+X1is85jQ7GrR9fQKuOdB/WxP2FoQ=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr273300oao.136.1661210400814; Mon, 22
 Aug 2022 16:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120327984.369593.8371751426301540450.stgit@olly> <1e4dde67-4ac2-06b0-b927-ce4601ed9b30@kernel.dk>
 <CAHC9VhQbnN2om-Qt59ZNovEgRAcB=XvcR+AYK8HhLLrPmMjMLA@mail.gmail.com> <1017959d-7ec0-4230-89db-b077067692d1@kernel.dk>
In-Reply-To: <1017959d-7ec0-4230-89db-b077067692d1@kernel.dk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 19:19:50 -0400
Message-ID: <CAHC9VhQw5V_aH=y2vSX4=f6fofc01w32c5gfediubVU=LCVJng@mail.gmail.com>
Subject: Re: [PATCH 3/3] /dev/null: add IORING_OP_URING_CMD support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 22, 2022 at 7:13 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 8/22/22 5:09 PM, Paul Moore wrote:
> > On Mon, Aug 22, 2022 at 6:36 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 8/22/22 3:21 PM, Paul Moore wrote:
> >>> This patch adds support for the io_uring command pass through, aka
> >>> IORING_OP_URING_CMD, to the /dev/null driver.  As with all of the
> >>> /dev/null functionality, the implementation is just a simple sink
> >>> where commands go to die, but it should be useful for developers who
> >>> need a simple IORING_OP_URING_CMD test device that doesn't require
> >>> any special hardware.
> >>>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  drivers/char/mem.c |    6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> >>> index 84ca98ed1dad..32a932a065a6 100644
> >>> --- a/drivers/char/mem.c
> >>> +++ b/drivers/char/mem.c
> >>> @@ -480,6 +480,11 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
> >>>       return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_null);
> >>>  }
> >>>
> >>> +static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>
> >> This would be better as:
> >>
> >>         return IOU_OK;
> >>
> >> using the proper return values for the uring_cmd hook.
> >
> > The only problem I see with that is that IOU_OK is defined under
> > io_uring/io_uring.h and not include/linux/io_uring.h so the #include
> > macro is kinda ugly:
> >
> >   #include "../../io_uring/io_uring.h"
> >
> > I'm not sure I want to submit that upstream looking like that.  Are
> > you okay with leaving the return code as 0 for now and changing it at
> > a later date?  I'm trying to keep this patchset relatively small since
> > we are in the -rcX stage, but if you're okay with a simple cut-n-paste
> > of the enum to linux/io_uring.h I can do that.
>
> Ugh yes, that should move into the general domain. Yeah I'm fine with it
> as it is, we can fix that up (and them nvme as well) at a later point.

Okay, sounds good, I'll leave it as-is.  Is it okay to still add your ACK?

-- 
paul-moore.com
