Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6500C433FE
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 09:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKIJ11 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKIJ10 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 04:27:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A7CE9
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 01:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667985989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWvwssy+Ho07pZtdgEACT8xQv5Chka9q7JBje6a7WAo=;
        b=iV/t1X9Jxy3VqVJk3xVCNoxV34mtyF3vGV7Hx0FIX3sNijuIP0YtDvU3t6iR/1fWXh/poR
        7yjLNPnuEoC2i4UGM8NCwpzi1Qj0cQxsTQQOaLD5FXo47MSLudipkMGro4/PTLDG0PvILC
        N9C9QE2XYV1ius1+U1To6GenLGCKj90=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-Si_FpLv2MRywgnbURMtgiQ-1; Wed, 09 Nov 2022 04:26:27 -0500
X-MC-Unique: Si_FpLv2MRywgnbURMtgiQ-1
Received: by mail-pl1-f199.google.com with SMTP id c1-20020a170902d48100b0018723580343so13143479plg.15
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 01:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWvwssy+Ho07pZtdgEACT8xQv5Chka9q7JBje6a7WAo=;
        b=G42IR6dHhzv3DUTBv8KeHTS8wlpUPmoGv64AvNJQsW9G3S2hKUhRoxpBpkmA0n9ocN
         t/G4x1DrRHuMJqZyuR6niNLr2QnevUoWmXwTLB9uY0NVJH1tLvEjFZSQyLedf7wyobbE
         VerJA1KugXaNQ3rz4vwXMqTkLwUwLWYfZ/Jxdnu4lt/Y0sBXN7V1i8Q1/S7+bIcAzTVW
         MsvYlMA+pjYnEoDKL2EF44Ot9XQgEjYDDfLO7CF1oU2r40jDCQWdNBMOwN4G3m0ASkhH
         HKLqHrGVWi/QWD+8nFx0K1feMAW8PiDQPLoxMCeMkbDRhQLhfQGeUw3VQDB+YV/owlfS
         HdGQ==
X-Gm-Message-State: ACrzQf3RPX9GdXmGnZABjFZxy9KSus5aSCY0wisKNa6vK2tPeZzWuuUd
        Qi0pysNueQ3rXv/vTx4Rly2H5sq8fAl+CnZuxzo5OtoiEA7emhymzIHOo7DwLDSafHQ9l0FpuS/
        12TWHWmri7G0Z4yg+xuS0/q5815Uh43j1aA==
X-Received: by 2002:a17:90a:a017:b0:213:ad3:4d1a with SMTP id q23-20020a17090aa01700b002130ad34d1amr77985467pjp.120.1667985986538;
        Wed, 09 Nov 2022 01:26:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6IlKzYghNII39raGbTkrWLsWhMCV5o6vFtQhwI5epY/lDX9llxXgK027fmVmjsSldD4V2H71UmA0Hhq9abnxo=
X-Received: by 2002:a17:90a:a017:b0:213:ad3:4d1a with SMTP id
 q23-20020a17090aa01700b002130ad34d1amr77985455pjp.120.1667985986209; Wed, 09
 Nov 2022 01:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20221109040039.732341-1-paul@paul-moore.com>
In-Reply-To: <20221109040039.732341-1-paul@paul-moore.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Nov 2022 10:26:14 +0100
Message-ID: <CAFqZXNsEqFT0oYcdfdrp0WgR7S022=V6oZMr0F7YgFSuVumKhg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the sidtab context conversion indirect calls
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 5:02 AM Paul Moore <paul@paul-moore.com> wrote:
> The sidtab conversion code has support for multiple context
> conversion routines through the use of function pointers and
> indirect calls.  However, the reality is that all current users rely
> on the same conversion routine: convert_context().  This patch does
> away with this extra complexity and replaces the indirect calls
> with direct function calls; allowing us to remove a layer of
> obfuscation and create cleaner, more maintainable code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/services.c | 51 ++++++++++++++--------------------
>  security/selinux/ss/services.h | 14 ++++++++--
>  security/selinux/ss/sidtab.c   | 21 ++++++++------
>  security/selinux/ss/sidtab.h   |  3 +-
>  4 files changed, 45 insertions(+), 44 deletions(-)

The goal of the callback abstraction was to avoid the awkward coupling
between services.c and sidtab.c, but both ways are ugly in some way,
so I consider it a matter of maintainer preference. So if you prefer
this version, feel free to go with it :)

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

