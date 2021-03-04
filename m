Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BEEC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 10:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1964F2B
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 10:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhCDK3T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 05:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238477AbhCDK2s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 05:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614853642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsYjTLyVdSCPkM5BNhOt3p9mIfbREWB3WRds/xENO7k=;
        b=HAPTWDUwlQL1W87BpzVcUJNNqJ909QTWkwtCnD7NUtT8gRWatipQeFS8sjjGfi1l61P11J
        ZSiOWqPTF1Svwue9Z7QoUUW5L76BPratmo+LxtnbIWJXH0WVuE6rL81NbXJCA1T8eMvRMS
        3ctP01L6dRCy01Jphojl8rSh8sVlHUY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zav4zkKAMQye75spVFWz3A-1; Thu, 04 Mar 2021 05:27:20 -0500
X-MC-Unique: zav4zkKAMQye75spVFWz3A-1
Received: by mail-yb1-f197.google.com with SMTP id 127so30118197ybc.19
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 02:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MsYjTLyVdSCPkM5BNhOt3p9mIfbREWB3WRds/xENO7k=;
        b=Kwu4+kTCmNlhHeyJcGEJsKv8DQxrY21A4Bkw85rB/wHQPmiShhVweuioJwOBLeakoi
         aDb6OT6dmFWpH+YD/R1zFoW0bcNcy0SiElZpYlltuVOomGIJhis1Yers9KtZKwqldv2M
         5QbqGkgE7SmDwgnRf3lzsTvCmDd5xRJKP6J+Mq6Q88ClnR0TpO4k26GfPMjS+GUoyDcy
         s4S9qJx9oSu7U+AZdFN5F0d8o4TcEhCp2ThPpRXyAJvM67DtLZFf3TDC8OHuynuLKG98
         syD7hx6zO5BZDU3oF3NFT1ydVzF0ahYEKUIdUA3h8GbQ2h7YGFx14ahwBE4+1zSrSh7A
         0TiA==
X-Gm-Message-State: AOAM531tEQVGZKhm1FhbTWkhpCSAGNKcAyn1vNOpBobmQITM5uRS3en0
        lFsE4l1ivi27t6fnVj/jXxBUCGuwUrL5511mXkKYcV9+inT1zxgIDxQNke9AIZ116KUXaxD4VDh
        K8uCvq2ZjH19DD0kyC/0YHpWLEC7rD+S4KA==
X-Received: by 2002:a5b:4a:: with SMTP id e10mr5541644ybp.436.1614853639806;
        Thu, 04 Mar 2021 02:27:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycecrOtWfZ13KHbAcZbtXC8yeqigxlTNdz90rNWlfHgZeZneWHj2KWasyCHUcItjc9oicRzRjCfJ+or0icwrQ=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr5541632ybp.436.1614853639653;
 Thu, 04 Mar 2021 02:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20210302105917.402896-1-omosnace@redhat.com>
In-Reply-To: <20210302105917.402896-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 Mar 2021 11:27:08 +0100
Message-ID: <CAFqZXNuH=6izQ7pVv60Lv5J=bujfa_fpNRVVABoHrdqB+PfNYw@mail.gmail.com>
Subject: Re: [PATCH testsuite] lockdown: use debugfs/tracefs to test lockdown permissions
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 2, 2021 at 11:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The system policy interfaces for things that require lockdown
> permissions will likely grant those permissions, too, so we need to
> open-code them. Thus, use tracefs/debugfs access to test lockdown, as
> the interfaces for these are easier to open-code.
>
> With this patch, the lockdown test passes with latest Fedora policy in
> Rawhide.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  defconfig               |  5 +++++
>  policy/test_lockdown.te | 16 ++++++++--------
>  policy/test_policy.if   | 17 +++++++++++++++++
>  tests/lockdown/test     | 21 +++++++++++++--------
>  4 files changed, 43 insertions(+), 16 deletions(-)

Now merged:
https://github.com/SELinuxProject/selinux-testsuite/commit/de8246f5c853814b1a005d762ce7831255ff6ed3

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

