Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E65C433E6
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 00:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78ED222838
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 00:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAEAsA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 19:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbhAEAsA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 19:48:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FAC061793
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 16:47:19 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ga15so7031372ejb.4
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 16:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6LdMArXyPdFuWQ7PiJhyFNo6cfCzV9v8MYGz9K6Bbo=;
        b=flCRnqLFkpTZJ2EVFFdSj/UWliMRnbJMlGZKE23haOgSYjx0WoInVDFWR7vLZvMdES
         9SsVGsJ0SshZvQmwHMxO0xpAdFASj5Nt1BzdeZ1l6WT8yqUqeVXwohD4WpNC9K9bBG7H
         kDEj22eL0j55fXF6tt6uWcF9tQgjSgZcJQzDHq+Z/k7lMZiACmePPRT+SBZdfmRm7dMo
         XQyMdpRGus7Dkbb6Cw/UgzFvgQOlZi4oQq7+L073cWk86E5xlXirVnL0YqB3/KJMMEjk
         YlDv24USQaNakImL5/EaRErZxHsj0uWhQCNJpJJ1OFD+kzmhttCDnJSfPkPm7qi5LCoa
         LOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6LdMArXyPdFuWQ7PiJhyFNo6cfCzV9v8MYGz9K6Bbo=;
        b=SUiiUtNf8mv1/aV52XTUnF5+yUvhxHobpfDhU2pd1HIRBTEdAGZs8Ord/yoCrhpJCo
         bbyrHxTXRCpZZw6DqePznbgb9A0xEuOC/JOEKws7oFunHDZedXJ6Tg02RIUu4sUQE3Xs
         /pLynLmhdhN35FOx6UA/hYUfbNWrdzxFbU8JP+jJIWjkhO4PxyuGFuRnD0fFcPal+WL/
         esVXC2an2ICbkRjlBOxjP6GcOw1L0tkM2zEXK96Vdpf2yGzxhEPl4V9S97YBBhRiNKd5
         2IrQsnj+NyniIjigO7vB7sJ1YONr/AJYhNj80TeUFBai+1jmlkpX7q9PAOIEsw+5IOsf
         hVbg==
X-Gm-Message-State: AOAM530bmMgpOVDA5t+K4JYVY+pgTUEWnrEQwMnZHGOc7ZWTvbFkZYVe
        oXnz2wtGSVXOCRR0TZVtOOe88gjp8zSXP9QSGfnz
X-Google-Smtp-Source: ABdhPJyxBOUFVkH5EGo2ivGaHgxBi89pcMpID3EIzsfBoCoRTSTmEKZvYV7C8SwfJCMqM/OuAfV6RCZr9tIT8SHAsy8=
X-Received: by 2002:a17:906:2e82:: with SMTP id o2mr69344116eji.106.1609807638276;
 Mon, 04 Jan 2021 16:47:18 -0800 (PST)
MIME-Version: 1.0
References: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
 <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Jan 2021 19:47:07 -0500
Message-ID: <CAHC9VhTVOZLPh32mgpV3aC7RFPETNACQU1_EC7iKoFG=pwNRtA@mail.gmail.com>
Subject: Re: [PATCH] linux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 23, 2020 at 9:53 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > The MPTCP protocol uses a specific protocol value, even if
> > it's an extension to TCP. Additionally, MPTCP sockets
> > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > support and available resources.
> >
> > As a consequence of the specific protocol number, selinux
> > applies the raw_socket class to MPTCP sockets.
> >
> > Existing TCP application converted to MPTCP - or forced to
> > use MPTCP socket with user-space hacks - will need an
> > updated policy to run successfully.
> >
> > This change lets selinux attach the TCP socket class to
> > MPTCP sockets, too, so that no policy changes are needed in
> > the above scenario.
> >
> > Note that the MPTCP is setting, propagating and updating the
> > security context on all the subflows and related request
> > socket.
> >
> > Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com/T/#t
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  security/selinux/hooks.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Based on our discussion in the previous thread, the patch below seems
> fine, although it needs to wait until after the merge window closes.

I just merged this into my selinux/next tree, you should see it in the
kernel.org repos later tonight.  Thanks!

-- 
paul moore
www.paul-moore.com
