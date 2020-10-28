Return-Path: <SRS0=BfnB=EE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44337C55179
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F227B2076C
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 00:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="v4M1qF5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390821AbgJ2ANk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbgJ2ANh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Oct 2020 20:13:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA001C0613D2
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 17:13:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i2so1192430ljg.4
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzLz4C8/7x6rzuhgwBujVtBwU24k/ip+cGwa/LEOhsg=;
        b=v4M1qF5mDiC5N28sULoJTYGg1WgaQQ/emZkfbpqBiOCzkX+SSPW5W1uM0NbvfAh6YO
         9E9NFQnet8PJcyRMTHhYtgpYE7bVrUSfAQVf3wXDtig0GDDzclpTy6RCpO/CDkSwzFSw
         1IjiOdkAOxxHfDbnNC4X71Ioj0EI2UIuG/QuQyhFg+gO9e1vtVjLNnMKoPxMtar9kcu4
         Y7/Mos6ATXV6NyOub+XMEgoIiLmTrlSZF1qa9xGdnBAtX4ze+iq63skPQoPnYCEQ+QDJ
         DG4aO1r32cPLM7r5DjYDFQtGKkXmijlPbjhfYhJ0O+jXMH3CNTs00phfFjMeNylPtiEr
         LRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzLz4C8/7x6rzuhgwBujVtBwU24k/ip+cGwa/LEOhsg=;
        b=P+/SCNWBe5Y0L7WhPJZFnnx8vYmmkxALfJitOS5SSrKcckJ6YCurCLvoOxT0ajm0a9
         4Z1Y6+nSPdh9ILWzLxCrKa3YYqlSlJlZ4RDbxUMFd/W01GC6H3RdiuzXyVXAFDXUA8gZ
         /fhDsSo28841DJUOCmknlE8yRl3tAVvXoAuPfeTcWcWb1z3D5xlAFusvGudTKD/3R4+J
         pDor1gcDc2vUAeOp2BDHQc/Kj/DZ9O58TobN8GXlG1FGENdXw/LKK3ck7nt68Jixx4AY
         QGljQKdGrUaNY2mISFBRyrgRTEhX50a1vXNQDHfvG5AsCgi9c4Re2P4BAx3ovNkii5Yv
         N6AQ==
X-Gm-Message-State: AOAM530gdhyGat6mqnSNASC5/Xa8If5LYw1tMXtdscE3TRZC6jvVJbQJ
        2qfBtKVhc/Hi5nS868ctDz8ZB/hn/9eXJZy6DywfadDHRA==
X-Google-Smtp-Source: ABdhPJyR411+6APaMeMHKRFz3XusXo7hZQPgNstyy+j9Bir1XmDNqruBwrAK8ySh4BzJWo1Qsqgz2KolL3IjMPV55EU=
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr5195940ejb.91.1603851000899;
 Tue, 27 Oct 2020 19:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <160141647786.7997.5490924406329369782.stgit@sifl>
 <alpine.LRH.2.21.2009300909150.6592@namei.org> <CAHC9VhTM_a+L8nY8QLVdA1FcL8hjdV1ZNLJcr6G_Q27qPD_5EQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTM_a+L8nY8QLVdA1FcL8hjdV1ZNLJcr6G_Q27qPD_5EQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 22:09:49 -0400
Message-ID: <CAHC9VhSq6stUdMSS5MXKDas5RHnrJiKSDU60CbKYe04x2DvymQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: pass the family information along with
 xfrm flow
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 30, 2020 at 9:44 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Sep 29, 2020 at 7:09 PM James Morris <jmorris@namei.org> wrote:
> > I'm not keen on adding a parameter which nobody is using. Perhaps a note
> > in the header instead?
>
> On Wed, Sep 30, 2020 at 6:14 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > Please at least change to the struct flowi to flowi_common if we're
> > not adding a family field.
>
> It did feel a bit weird adding a (currently) unused parameter, so I
> can understand the concern, I just worry that a comment in the code
> will be easily overlooked.  I also thought about passing a pointer to
> the nested flowi_common struct, but it doesn't appear that this is
> done anywhere else in the stack so it felt wrong to do it here.

With the merge window behind us, where do stand on this?  I see the
ACK from Casey and some grumbling about adding an unused parameter
(which is a valid argument, I just feel the alternative is worse), but
I haven't seen any serious NACKs.

Any objections or other strong feelings to me merging this via the
selinux/next branch?

-- 
paul moore
www.paul-moore.com
