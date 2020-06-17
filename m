Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F3C433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F012098B
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 13:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZS9uk5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQNYc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQNYc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 09:24:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81DBC06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 06:24:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id i74so1764942oib.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QuuSx9pf5laBXq8VHimPTNCjEooSer24LvYrHHswZ8=;
        b=CZS9uk5GKM8InmO2N5D3q2vEsKbO+8dD5wtyGc9KEAT834Hmnvn/TqyY2UkZeN0IIG
         3uJ+ujmTqn12D7j+czl3b50fXEu/WKZZSntPw2PNFwAa3OXWucC+RAd607MZXduJmFyE
         etw1LAO4rIboDg66yf8MBlUQOArgMIlTc1BJWZKTeQET4ca/zeagTIK9KXjJFG/aLPqT
         Py7g716IAurFsqRYK2eKtKXDyx4Km0DicKvGKNCW5/1pOOdaq80CgYSmb1+Mh/bs62rl
         evzRkwH9FRzovXAZ0K96oksZMtWvU5UUREhD9HUwq1qj43HpI0d8paY+is7pWxf3/0sU
         wesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QuuSx9pf5laBXq8VHimPTNCjEooSer24LvYrHHswZ8=;
        b=Xl5iWm6OPGAbXK6mvvya331ZsfUXBb3Orkdv0Vptc9/n0ByWX8Uh4gST+LexNJyT/W
         5Z28ziR1hDk9hKxmgrOp+BFvB3vVrX/kj42sKTqO+1aPBxBcv/9V+XzoYEEDjQ1DRYce
         H7kpCRdHCRO7D6NAQsgwE/hp2h6MWsjwSpF7V/xAIttCSjRTvNeAHPmrUyqdZ7CeUT9a
         IiDIag/4LAt1anr0JCxFRPoyDoF/m5XY3pHmKK+uSci9MAp6WzdZbz0ZGBR1kt25l5Oq
         7aOP02TsLPXddZQutmMF7oXR67Num+kbdq0WM8bWaZMow48dy+Ft9qwzFWokF2IpMynf
         DJ8Q==
X-Gm-Message-State: AOAM533snVfiH53wnH+j+bppt5NhZtLdY9LTGfZZYtaVQ6j/NO9OsHDz
        kLdcSSMUQvIWjv6epyVrz7p54nfnsEDB3P/TTN1hlaiy
X-Google-Smtp-Source: ABdhPJxNDjuKxIqvUTmrkecMc1S45G1yDPIzR91GQer+cVFfkNzdfNs/u91q4eYfxrPFna2uc4j6m0QSQMSIXnxS37w=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr6961158oib.160.1592400270276;
 Wed, 17 Jun 2020 06:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com>
In-Reply-To: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 17 Jun 2020 09:24:19 -0400
Message-ID: <CAEjxPJ4+cVRjWZ3=j7DoOadBarZBteqAsanCTp+fnH+ztpER9g@mail.gmail.com>
Subject: Re: Minimal CIL policy requires process class with transition permission
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 7:10 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Hello,
>
> I've recently started playing with CIL and for various reasons I wanted
> to start with the smallest possible policy.
>
> After having some issues with a tiny CIL policy that compiles but does
> not actually load, I tracked it down to a hard requirement (of the
> kernel ?) on the permission `transition` of the `process` class.
> Is there a reason for this or is this a bug ?

Yes, the kernel security server depends on at least this class and
permission being defined in policy for some of its internal logic;
otherwise you will get some rather odd behavior.  I suppose we could
make the kernel handle it more gracefully, or change libsepol to catch
this and flag it as an error when writing a policy with the target
platform set to Linux (it wouldn't be an error when writing a Xen
policy, for example).
