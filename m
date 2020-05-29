Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FAAC433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98452207F5
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngGPktJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgE2Mxq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgE2Mxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 08:53:45 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0FC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:53:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g5so1315155otg.6
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyggyyRIPEg4W97WjDWkIUz2i0+29DFGeOu4Omxh3V8=;
        b=ngGPktJ5xjrqCta89DcC/uJsez7CMsn5mBgWvV8Dz1Jw6mUS6DGtRkXcrrrQBbEM/A
         K+L5eV/y/D/0FxIRYhMw0FthrOoY/5LrvHRor7TTQvQ8Z0unR19W2huIlDj2Pqvi2NiZ
         dEyQBxMP+UDKb8HEqgQ17QttnlbHycMM5MXiaD8E5iq/h42wknOpAQwvenYs17PVAssI
         q90Ljk8lahBs2D5L8Z6CCaexOqben3OUq0v+CxRWluCyQGlmxDvsaGn9nXpI3lvXCzQ/
         VILlFI9fsiCGrcvKpY5ARET1z5+8CP1IzXHxfebDQewb5CIfYTuUG/KITmTJ0IAyDKRq
         +vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyggyyRIPEg4W97WjDWkIUz2i0+29DFGeOu4Omxh3V8=;
        b=hsKFXDpo0cXyuh/ovNsWaRGuQxBfp97efvkCexGYypSAaHpYWmH/KTEHrW7/MSbXYf
         JhZHI8CjyaVzvX0ZdIhkEgOdUZyvrw1TlqS55IvtSQhKfLI1EwKwqZkQ/jn4X96/3ksx
         gDnQmSaDg1hSDCkzryuZ69GTU52UqyZeMz8iuTKd6a3a/rKUcQRTLViKqc6s2kMmLLmp
         +btV3WUHaDoN7FwJU3x0lzRfEgQISkFuPtBnFESmyZlWIJmbNPdwcDDi6bHIerPIPi4c
         3tUajLyZ9sUoa3cSihLEpohmP7AfHPypsmIZTHLZiSM+3OD3gSnPFpPA1ZEa7ozIbmXm
         OaCA==
X-Gm-Message-State: AOAM531XzjeUcTM7tHgoWicrgwgQvxQCxJVnnMiLqGFJGIfLXzZd60e0
        pAcXVC28b1TFOl0Tcg3tPW0ePkN80m06FAukx/Y=
X-Google-Smtp-Source: ABdhPJxTKWgHwTwFjparlOPHpd0wFHEdTMCm5uQVFVaKu8Q7RrPBMb490uWsaZ/XDkP7tMd8nXvxzNdqQ8ZPcsp5YII=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr3794499otp.89.1590756825306;
 Fri, 29 May 2020 05:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145038.194209-1-jwcart2@gmail.com> <20200522145038.194209-2-jwcart2@gmail.com>
 <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 08:53:34 -0400
Message-ID: <CAEjxPJ49JdTZP__ZmKu_U8F_h3iemyK88duR2bcYgLjit+iD9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol: Fix type alias handling in kernel_to_conf
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 10:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 10:55 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > Type alias rules are not written out when converting a binary kernel
> > policy to a policy.conf. The problem is that type aliases are not in
> > the type_val_to_struct array and that is what is being used to find
> > the aliases.
> >
> > Since type aliases are only in the types hashtable, walk that to
> > find the type aliases.
> >
> > Fixed the syntax of the typalias rule which requires "alias" to come
> > between the type and the aliases (ex/ typealias TYPE alias ALIAS;).
> >
> > Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
> >        policy to policy.conf file")
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> This fixes the missing alias problem, so:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
