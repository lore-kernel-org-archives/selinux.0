Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEC6C433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D175F20866
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvaOUKXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGSyb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGSyb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 14:54:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE3C061756
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 11:54:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id a24so2835286oia.6
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vm4iTjGyG2R7ONRY3+7UX7kH6s//B0VjDZsQj2tNBuA=;
        b=kvaOUKXRvKUDxww88i7cz/pkNW/AMmziufqX25UozX1Doby5224UESfR7ASktfopAa
         JO5jQCtCmiFBtBjLxj2usDnxdWkJnIOs242uzsoB5FUEVEasdwkVA3fZwcm8nYLXZp3E
         9Ddj0OG6rf40l5gD+HwXpxl3UzAFBsTQbWUGpF1PmpPutWYatMvVWNKJNh9+OAQiauVS
         Xh6IfMygxeBGJybiQG3RG+KQT6OK6rwREGMB31fO+8EbGVplbnOQz+rVLlJUu1rF2M93
         bIUJGSxSw2IRQ7U4NK0OurPOr71vJ5ysVOw72amAAWYTtiOTirZa5GXCRASLxU5/SiE0
         mW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vm4iTjGyG2R7ONRY3+7UX7kH6s//B0VjDZsQj2tNBuA=;
        b=O998GDHOucB6xp1duKlSDwxW+prN2ZHZylLeOFHdDmrlbhoFMhrtykTYwBOGHy1fVp
         kgqzz7KDUZ29y2zSwu5V8p3ijZT1La6gYx7YD0GuntIkkGLl0uLyrnAJ5SYJFjNOBAd7
         fICHatTlSjTrq12Cm4KtzkT0sfvXzYZYW7+djAaZMoYGtqPu3kUGNiuZGtsQMWtNhZE5
         3AjcInLPRZPHipeVew8TKS+HfjwQTzB/nA92FPFvZEs2QRumHtN7tg8XR/FdOfmd1S3A
         ShAsZV6u1UdYFrGK0CJiFdU+eKkXuJOt2oHfG/Bd+X0m/lviYR1S+GX9mYEQS6V5AneU
         uQTQ==
X-Gm-Message-State: AOAM532xEXLRMhzg/E4jnuCjVCDbNFo3372LANfmI00LMotHUVD2NZhy
        gY02k34NCP7CBzMED1mfNyKINWXpOJTulcdl4AdfrJnQN1Y=
X-Google-Smtp-Source: ABdhPJw3JGLBRPhSX8TwKEdDoF11ERubJuxxVDG4LjEU5APvIge2Sq8re9Ul5QlPT/kJIBOD9cKTkJSVKoZ7IjKKR9o=
X-Received: by 2002:aca:fd44:: with SMTP id b65mr11735025oii.160.1596826469541;
 Fri, 07 Aug 2020 11:54:29 -0700 (PDT)
MIME-Version: 1.0
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 7 Aug 2020 14:54:18 -0400
Message-ID: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
Subject: drop symbol versioning from libsepol and libsemanage?
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As noted in https://github.com/SELinuxProject/selinux/issues/245,
symbol versioning in libsepol causes problems for LTO.  libsepol and
libsemanage have a handful of versioned symbols due to incompatible
ABI changes made early in the CIL integration.  However, as far as I
can tell, these symbols were only used by other components of the
selinux userspace, not externally.  Should we stop supporting the old
versions going forward and simplify the maps? If so, does this truly
require bumping the .so version or can we omit that since there are no
external users?  Thoughts?
