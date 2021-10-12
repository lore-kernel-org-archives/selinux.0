Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67256C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 17:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4919060EFE
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJLRyk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhJLRyW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 13:54:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA9C061745
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 10:52:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n8so401359lfk.6
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOLmY/AhA3gayY94L/pswFE95oCI3JW4HZ99LF4RkXo=;
        b=KnImfnfKCEzhD6gol9Y1lSoBMIZ7CigH650YcgmtraFEwcKcPwvDF1vdtvKGKphj4e
         2EIwKsbbBTBAp+jhQceZp+8tAcqrijBeUEIRN2GEUdaCmwu2+FeajXh/7/bwdYcJGkCc
         RnvHXEvkBTg3ET7ntDSNcN2tV+FrqzLXKifuhHBR9a/ujdpyHsHifMDtYNUbv1YacsG/
         ZHdzgWCQDk+7vhb+MgpjKlUA/F0Bo+CHqG3JoAzmxNW08IvTZdlqXB07H8GiQX+puGYC
         exFYxrcmxp5El8DTCSA6OPw3Uz7GosEVYCX08FjeFf6WrEr+nAFR6tUYsRkUd8vNmKkL
         VUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOLmY/AhA3gayY94L/pswFE95oCI3JW4HZ99LF4RkXo=;
        b=gP+2oQ8bepI7BfLivrGEvuzsaKx3Pfmgvwzc5g+7Cw8LrSpg94jiVwSWxbR7+y31qa
         aFYX0gGJn7I2cWFdF/oIi5JXYzbwBk1vLNQWi2lmElup+7hfZgpJjuyHRzK1UrhikWAr
         QAsJWP2dOzewIEGCmvjeX0FjLRLeWnnUnX818FlyVMLdtqjM8LGiNZe0cHS4bP51fkdA
         VD7XSumWchsT1eiPgKSXHm3uyUgUtiiCsX4APY07+X0Ma7x+dP68kN3ftFfEJonCH+oW
         QVEh3WGlYQlK4LotmtvsXd2ueywZno+tmi/UHgbE070n3BkDfTFkXlo6b2nRJ40L6LsT
         ATjQ==
X-Gm-Message-State: AOAM532XKt7w9Wo9Iptqd8YfS+R4AQ8Gj9255AkHpbpLUggLvjl0EH1h
        A1ifIZVdiKE5x+kPQKPhWNhy4bcQ9CkT3khJkXA=
X-Google-Smtp-Source: ABdhPJzoESRp73ozLh0RqV1BUjaAb275UHxaviwzMEw92r9otnnDyUIBC6RuC3hPnE0jSWZGk+h7vT9JviBObdR5xaM=
X-Received: by 2002:a2e:4c02:: with SMTP id z2mr31326436lja.403.1634061137593;
 Tue, 12 Oct 2021 10:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <163399358463.185926.1386262780774440656.stgit@olly> <CAHC9VhQA+RMAGmzBpr6UEAi6EAp5bZ7jWKFSCWpJWZvJuW8Q5g@mail.gmail.com>
In-Reply-To: <CAHC9VhQA+RMAGmzBpr6UEAi6EAp5bZ7jWKFSCWpJWZvJuW8Q5g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 12 Oct 2021 13:52:54 -0400
Message-ID: <CAEjxPJ4gmU_ppLPZ5yNfN-pQ4u979dTo+wjnUV4iEA5PaOXWVw@mail.gmail.com>
Subject: Re: [PATCH] selinux: make better use of the nf_hook_state passed to
 the NF hooks
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 11:02 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Oct 11, 2021 at 7:06 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > This patch builds on a previous SELinux/netfilter patch by Florian
> > Westphal and makes better use of the nf_hook_state variable passed
> > into the SELinux/netfilter hooks as well as a number of other small
> > cleanups in the related code.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c |   53 +++++++++++++++++++++-------------------------
> >  1 file changed, 24 insertions(+), 29 deletions(-)
>
> FYI, I just merged this into selinux/next.

Don't know if it was this one or the previous one yet but
selinux-testsuite locks up my box hard during selinux-testsuite on
inet_socket test.
Completely unresponsive, no output.
