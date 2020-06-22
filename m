Return-Path: <SRS0=wZqU=AD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E65C433E1
	for <selinux@archiver.kernel.org>; Mon, 22 Jun 2020 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD41320720
	for <selinux@archiver.kernel.org>; Mon, 22 Jun 2020 12:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIYdzgIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgFVM0A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgFVM0A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jun 2020 08:26:00 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB5C061794
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2020 05:26:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a137so15427240oii.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2020 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdNb9Hm7qRlfUR2qpFXK3aryqGLP8BpZPhUjVK7wnZw=;
        b=sIYdzgIwM1TXgg5vG1gY7BE+/9TPX60j1T9I/+wuOO+24vWLAtdhl/cxFc9BiOVQN7
         Nmu+blFr837IGgv3qidMnttPiInsCaZ8bMwhtMp5SXSHsg3vzsWQchZ8dqyR37Zwt0gH
         QlQiI7FSu2cf7xYCPzY28hycj3Tjf+NDaydiHkeqrLoEa6HIOAQoK4CUoNjgKxXd9q0v
         iuGtsVJ0y3dzNaHLdpL5sQwje7bM9LG+E97cGrRHdamIdI8wRsr4ovoyeiN9FeAS8iJK
         OQbGJFk+SyTP+7z9vLdeJG58/XrEblCiW9UpK+j5ZFVIY568UisDJXSioIfYb9o6p5I2
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdNb9Hm7qRlfUR2qpFXK3aryqGLP8BpZPhUjVK7wnZw=;
        b=l8zTCr7XluZ2QQ94z1Rjq/pZIIHp3zy/2jKErTw339c32bhHOVhqEnljuTiSnUm2H/
         MSGHhJKJmL2MC4W+/twgWybHbc6otBosPPtF/7QKVIjlVZte+OzF9/Og1ErilKbnxYjo
         sDNANzMjgl8GIvJoKtwFrvtdAilMUIvqShD8c0a4X2aX3G6DjVg5uj2NOJZ/QidBKfwb
         YVbhUXZrZpFvVGSE2bzgOiAa7P9uf7NMRLjiX8o7ZonkJkSZmEaUcm2gWdIwL8AtxblF
         BxzxUyA1bQ1KWpClQirId9iE/gzcSvDbUuuznaMwgSqU4sesVqoyRd5gNJpB8zeGza+M
         qu7w==
X-Gm-Message-State: AOAM532biMsSi5g46mWw3+F9Lwi4x0E44GUpb9+JrAGybYRBFzuVfPN6
        pkFBO9JLfNg31wku6njlUykp4jztDnYLn1pOqoRKE0Rd
X-Google-Smtp-Source: ABdhPJyc1ZwTGW5hyIDym86XSohB/YkPAeEVwSJFiXjMFOmeSLzHvhGB+Oqi1vtcdHQD5PsY49wsXTFMt4cqrLK32KA=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr11634706oib.160.1592828759447;
 Mon, 22 Jun 2020 05:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200618182205.378233-1-jlebon@redhat.com>
In-Reply-To: <20200618182205.378233-1-jlebon@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 22 Jun 2020 08:25:48 -0400
Message-ID: <CAEjxPJ5H4QWQXB53uGtSdxFpqxJUjHYUmTeRKwYsNeHAajwyDQ@mail.gmail.com>
Subject: Re: [PATCH v2] setfiles: clarify documented path resolution behaviour
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 18, 2020 at 3:05 PM Jonathan Lebon <jlebon@redhat.com> wrote:
>
> One thing that confused me when investigating
> https://github.com/SELinuxProject/selinux/issues/248 (i.e.
> https://github.com/coreos/fedora-coreos-tracker/issues/512) was that the
> manual page for `setfiles` seemed to imply that paths were fully
> resolved. This was consistent with the issues above where `setfiles` was
> failing because the target of the symbolic link didn't exist.
>
> But in fact, the wording around symbolic links in
> `setfiles`/`restorecon` refers actually to whether the parent
> directories are canonicalized via `realpath(3)` before labeling.
>
> Clarify the man pages to explain this.
>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
