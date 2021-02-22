Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23554C433DB
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 01:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F156564E4B
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 01:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBVBIH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 20:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhBVBIF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 20:08:05 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42435C061786
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 17:07:25 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c17so53454337ljn.0
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UH4IPTgqw8AV3WlrSAJLfYK0v76O6zMRzSlgWb6EEEk=;
        b=epNELKSmVgggxleUs/hUx8T5udyukRpdhNESQ+whKzNkBUy6vGiMQQL3+A5y/lgi86
         +wlCZKqU5cjhFnP3qkh2TQzHIEdpPg79WhCQCoWMn/JtXFV7I/H28CrBZaOs6sPM1AjU
         MGE+52zLo6WA9tDVuM0CFPYrOyrvsgWxn/oxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UH4IPTgqw8AV3WlrSAJLfYK0v76O6zMRzSlgWb6EEEk=;
        b=bzUBffvBSyyqZyuub+c1gRSgnxsFP/Tm7sV3eirP3AhKvX8WcOQXyJYD+k5U2lNW4h
         k7ksq59bueD5ube2c2ZP7v1C06a8OW53eQqlYdGr5jWsn4nbh58OLySHQTzQLgydjrr4
         9YTqpDsAM8Q49u4nufxZYLf1l6gRd7wR9qK+SKdsz+L2c3reKz1ooehhakXV9Ziomcco
         1bGlKXRU/2JxuLHwBV7FEJ64HybsprYPAGc2IrRHck0wHlhvjduztLCI3lP1LM6kMUDc
         LXjSX14n1crEvqyxOVvDv3LQ1rGRi8weaqybVo3wBLHcZ4ynoKVzjOqVyiLMkGKdJwVo
         dUmQ==
X-Gm-Message-State: AOAM531+6iFIb7ufwrcCbfL5iWrxF5G7tIioaTDNYQOVTbU/1X/swgfy
        hfB3kqsYNKU8bhAh13WefQWba4zPSTIu6Q==
X-Google-Smtp-Source: ABdhPJz9PvO1M7JSyav3lhs1y+nwZZpNhGhqJfcpmb5FYzrLgS87wSatGv8oeI95vBaxmpGvG0qZmg==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr12888036ljo.289.1613956043498;
        Sun, 21 Feb 2021 17:07:23 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id g26sm844396lfb.181.2021.02.21.17.07.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 17:07:22 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id g1so47413640ljj.13
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 17:07:22 -0800 (PST)
X-Received: by 2002:ac2:5184:: with SMTP id u4mr7249839lfi.487.1613956041861;
 Sun, 21 Feb 2021 17:07:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Feb 2021 17:07:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
Message-ID: <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.12
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 15, 2021 at 1:57 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - Add support for labeling anonymous inodes, and extend this new
> support to userfaultfd.

I've pulled this, but I just have to note how much I hate the function
names. "secure inode"? There's nothing particularly secure about the
resulting inode.

It's gone through the security layer init, that doesn't make it
"secure". ALL normal inodes go through it, are all those inodes thus
"secure"? No.

Naming matters, and I think these things are actively mis-named
implying things that they aren't.

              Linus
