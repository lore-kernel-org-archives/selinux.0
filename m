Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3505C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 14:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96A320665
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NDQAD1ZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHYOQo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOQk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 10:16:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF961C061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 07:16:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id di22so11374169edb.12
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBLXPZJS9r4wN315LT6tbrZxrohzyF/RndBKG2eFpxU=;
        b=NDQAD1ZMmo79WEoydtHhQtL6B+kcgPmM7dD/wH7WjSjtweLqTMgOBc/NCkWloWC+Kj
         rtHCSAHC4r+DJ6D+tEhJPMB3TY+M6/n9iSJWx7j9cCNLUdK57rnUTuzh3yMDCi2fae7x
         v9w/Z8hVjrZhxpXEvkSnSu7IWgWE7BIjAwOSldQDTFzCgRpCQKWUnylUrhiSnvIEkg6W
         glQBEnIVB2KTnu3ViTGWiGXHqscNPnNldnCNQXQsEmRIr4bMYMTurc5ZXrnpAewRisWw
         GPIrZxEm3xwtFVfUUwCZ0uKRCK4NAL9u1dvGpQKniVmLvjYaJDaqNU66RRP7xxSc2ehm
         pIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBLXPZJS9r4wN315LT6tbrZxrohzyF/RndBKG2eFpxU=;
        b=TQ2pTonv7VcDqGkhZEW2WxyHHLS+kHwn2LXNxW9abRFdihH3CUGMgRzFjVsShrGg09
         ZYDz8k88KO7hAr8uCeNn3GFOrCW5a82ANSxvI5IxviD12Ftqk7yKG8qIgEk3HnmWE1eO
         Q2sESUSc1kswpUIwtWE4bRHhx2DTReneleC3Us0yRa5HinKiQ+upcMuv7173Jodl8bxe
         V30qXFY9kcsOLXnslcIuexZZEn2zgRF9ZK1EAW9/fu9UCNUZTXC5fccOrpAexYYgj+8E
         57Ph7q2NziY2ceL3tUg2FXDEgw6rQnTaii/y8VkNPKIwdHz/zEe2oBHnNhaDWcMt8huR
         3u7Q==
X-Gm-Message-State: AOAM531CvUOQSe2Qwehq+5oSjb2mdXW4ehIZTNOCGxIKgRGxW4WAoA5B
        CGdBYv+SP531UhlBG9lF6eb5QDxUjZ7CsqyVMhkxPoPh1gOx
X-Google-Smtp-Source: ABdhPJx6zsReXPtiXQ6LYEx3a/sA9AqJCUs6bhgCjldHPAa9oG1ZtHUNpfhqxfDMlhxUT1rNzxFq2Z/HuJ69DxpFxRI=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr10125828edq.164.1598364998449;
 Tue, 25 Aug 2020 07:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200825125130.GA304650@mwanda> <CAHC9VhS5pAr8g9C18cniKDrh3NRgg1z8e3qYs14P1iBpioOS7w@mail.gmail.com>
 <20200825141242.GT5493@kadam>
In-Reply-To: <20200825141242.GT5493@kadam>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 10:16:27 -0400
Message-ID: <CAHC9VhRn17jYSWo2oUobn=7uHv7G=HD0QRJZZgQhR10UGBU7=Q@mail.gmail.com>
Subject: Re: [bug report] selinux: encapsulate policy state, refactor policy load
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 10:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Aug 25, 2020 at 09:38:22AM -0400, Paul Moore wrote:
> > On Tue, Aug 25, 2020 at 8:51 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > Hello Stephen Smalley,
> > >
> > > The patch 461698026ffa: "selinux: encapsulate policy state, refactor
> > > policy load" from Aug 7, 2020, leads to the following static checker
> > > warning:
> > >
> > >         security/selinux/ss/services.c:2288 security_load_policy()
> > >         error: we previously assumed 'newpolicy->sidtab' could be null (see line 2227)
> > >
> > > security/selinux/ss/services.c
> > >   2221
> > >   2222          newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
> > >   2223          if (!newpolicy)
> > >   2224                  return -ENOMEM;
> > >   2225
> > >   2226          newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
> > >   2227          if (!newpolicy->sidtab)
> > >   2228                  goto err;
> >
> > ...
> >
> > >   2287  err:
> > >   2288          selinux_policy_free(newpolicy);
> > >
> > > This style of "one function frees everything" error handling is the
> > > most bug prone style of error handling ...
> >
> > In this particular case I think the use of selinux_poicy_free() is
> > okay, we should just make selinux_policy_free() a bit more robust,
> > e.g. checking that ->sidtab is non-NULL before calling
> > sidtab_destroy().  While we are at it, it probably wouldn't hurt to
> > also check ->policydb.
>
> There are other bugs on this path as well.  For example in context_cpy():
>
>    150  static inline int context_cpy(struct context *dst, struct context *src)
>    151  {
>    152          int rc;
>    153
>    154          dst->user = src->user;
>    155          dst->role = src->role;
>    156          dst->type = src->type;
>    157          if (src->str) {
>    158                  dst->str = kstrdup(src->str, GFP_ATOMIC);
>    159                  if (!dst->str)
>    160                          return -ENOMEM;
>    161                  dst->len = src->len;
>    162          } else {
>    163                  dst->str = NULL;
>    164                  dst->len = 0;
>    165          }
>    166          rc = mls_context_cpy(dst, src);
>    167          if (rc) {
>    168                  kfree(dst->str);
>                               ^^^^^^^^
> This is the right place to free it.  That's what other coders generally
> expect and what static analysis tools expect.  Otherwise it's not clear
> if it's the caller which should free it or the caller's caller.  In this
> code we free it in all three places.

Patches are welcome :)

-- 
paul moore
www.paul-moore.com
