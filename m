Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789EC4742C
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5DF206B6
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYR1XSxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgKENv3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKENv3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 08:51:29 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DDAC0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 05:51:29 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 79so1449713otc.7
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1azFYjPUnxVcYDN89Sr0bK7KwNAdEnHg+XzfPyM65b0=;
        b=FYR1XSxXIXM7+M1FRaH5u1s5R/IucSuM5N6bktThJef9a24N+xlUBoi6u5dFEC+s+M
         rqqzoUDuMBN1KiyhDJ2uspo53EaKTtgDdojAdK8DEvsZx2MVkGarxpyiQJy553mjSeqN
         BTW4DTzC0Vvx/ak0r/k148H9eE8+avmAbKq/9K/QBjg8mhbqCIqPXdOVqdqrURuB0/IW
         x9R+2H2IwQYbMhQfFssWBWU64vlAotoQ2uuWf1V8LB0obq1fUqt/ypUeFT1KVkX6IM8d
         Cyl2ldh/9Cca5+okvNbDkBNLKEp+7+O8kY+Jbr/54a9GALdco3n4jCSXhA0NKcAOcCFp
         1e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1azFYjPUnxVcYDN89Sr0bK7KwNAdEnHg+XzfPyM65b0=;
        b=rYEOM2jEurFHSBSbS1i+tADq3Mev9OdhOzXQg8BfIGD1GQvd3PkHchHa7Ef5P44OSf
         ETbXVWQIwZGwfrhZnW3uXz6jeEl1tiQLAPWvyhHqm9TWBmNnim+TTRzoTxf0ftsl8X/e
         KWbwgr75SwKhNDExXIbMSX3dlThcY7ItwRHNiUtQMRcus4xDJLk+04ayop0XjDc0YE76
         oL36V33Zcf3NCJOQWbb/caehjqFyK1EcVGD19DrN7PdfdtxnI75apbT+Vd1TiBGMuSOi
         Ql8Bldblh/fvMFsNVCoESQna8x8TLdTUp+yTHZe3GsyyQNpQ2hXq2c7NuemUkN70UA73
         6T/A==
X-Gm-Message-State: AOAM53229do0ERgI0X5uloYpnT/1IwC/xBY1j+VcQvto8WG1NZ6UDPai
        Fjdb0io88+TJ0y4ttR6gRbRKzwEEnGN/VuAITCkDtRABRf4=
X-Google-Smtp-Source: ABdhPJy4yOyut7vOoKLnByU8vJyRdIo6CHHQFq1pU00HAq3MvtXW5Io/BfjxBlAGe6NwiGRWJgxvENIOX01XByRuQzA=
X-Received: by 2002:a05:6830:1347:: with SMTP id r7mr1812966otq.203.1604584288761;
 Thu, 05 Nov 2020 05:51:28 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
In-Reply-To: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Nov 2020 08:51:18 -0500
Message-ID: <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com>
Subject: Re: Possibly unwanted rootcontext= behavior?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hello everyone,
>
> while trying to fix the NFS rootcontext= issue, I realized that this
> funny thing is possible:
>
> # mount -o rootcontext=system_u:object_r:lib_t:s0 -t tmpfs tmpfs /mnt
> # ls -lZd /mnt
> drwxrwxrwt. 2 root root system_u:object_r:lib_t:s0 40 nov  5 07:30 /mnt
> # mount
> [...]
> tmpfs on /mnt type tmpfs
> (rw,relatime,rootcontext=system_u:object_r:lib_t:s0,seclabel)
> # chcon -t bin_t /mnt
> # ls -lZd /mnt
> drwxrwxrwt. 2 root root system_u:object_r:bin_t:s0 40 nov  5 07:30 /mnt
> # mount
> [...]
> tmpfs on /mnt type tmpfs
> (rw,relatime,rootcontext=system_u:object_r:bin_t:s0,seclabel)
>
> I.e. if you mount a tree with rootcontext=<oldctx> and then relabel
> the root node to <newctx>, the displayed mount options will report
> rootcontext=<newctx> instead of rootcontext=<oldctx>. A side effect is
> that if you try to mount the same superblock again, it will only
> permit you to mount with rootcontext=<newctx>, not with
> rootcontext=<oldctx>.
>
> Is that intended, bad, or "weird, but doesn't matter" behavior?

I'd say it is bad.

> I have a halfway written patch to disallow altering the root node's
> context when mounted with rootcontext=, but I'm not sure if that's the
> right thing to do or not.

Probably the better fix would be to save the original rootcontext SID
as a new field of the
superblock security struct and use that both when displaying the mount
options and when
comparing old and new mount options instead of what happens to be
assigned to the root
inode at the time.
