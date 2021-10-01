Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBBC433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 08:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2C261A08
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 08:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhJAIS7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Oct 2021 04:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231327AbhJAIS7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Oct 2021 04:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633076235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UE2APLTsf4TfoW9jpD7MdAvTpE6rXWOM3IhczrAVMf4=;
        b=YlM3Jz8F3jC4xCQX98UQUmOF5gCsAc5SeRrEgwrnG3sULl7VM6xL4gc3oAVcbVlaob+sAw
        cmZxKqQHG5G0v3+X7cZzdvyoSqSwq06wyl70t+1KXW4mnerK3rri7haw2Jox/l6YBdPKBO
        bGkX9BAks3y4ZBQIu8jxTse0W1CPBNU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-2jwQZG_MPgSWWCIxQrwELg-1; Fri, 01 Oct 2021 04:17:14 -0400
X-MC-Unique: 2jwQZG_MPgSWWCIxQrwELg-1
Received: by mail-yb1-f198.google.com with SMTP id t9-20020a056902124900b005b64be937e1so12392735ybu.23
        for <selinux@vger.kernel.org>; Fri, 01 Oct 2021 01:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UE2APLTsf4TfoW9jpD7MdAvTpE6rXWOM3IhczrAVMf4=;
        b=HvNUtLZ8BktboQENSI6ZVIXfQIGMfyststxDCmcLZ+GTwXjIXmcBeJnAAkl67yAnb/
         0Z2sEE+O39S9nbOd2h+++vLUVsUqvVhgEZdylV0C0XPkKrITvVs3vuhJMrER+lNK7a6/
         7nC3tLcOCpNJh4k4PtqrgmBOBcf4HlGbZ6NrCriVB5Sda7Kxh+/wb/ymUL7ZMIaTa8ri
         MN0wHAemFbFqIrJkVcimFQhvV2kDz3yX5E9AT4LkZAu1dgEUcnfmhX+5roR9l0Gza7ch
         Rmevl4qArsg9gecmOfpfeoF6Fyl93YQo7VhQxkYSdOudn7WTTBqP+ZA4+e6Sni3ORO1B
         98Jw==
X-Gm-Message-State: AOAM5331FGQvZrgVDRMN4sjkX4Hv6UjMJ2sIXcQ39zyWh/OQmuq3YbFX
        XX+jqx2WitaheEd0mMCUeWDFPncaPok7hAnATmebKwO8IDa0mgVf9Jn1AT6Lf+tabZ9Iy/29qDM
        xd1bcRIOAvv/2lvKovRNM/SjgY4HpPcTWgg==
X-Received: by 2002:a25:3ac1:: with SMTP id h184mr4537094yba.237.1633076233774;
        Fri, 01 Oct 2021 01:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfp6I8gZITXxYEtH5ZHW3yzknXvQOHyz+7KG8V3v3xp1VKl4p9OWT8SkBLTvRG9nRQteb4QAQM/5cRYoKIQUU=
X-Received: by 2002:a25:3ac1:: with SMTP id h184mr4537071yba.237.1633076233453;
 Fri, 01 Oct 2021 01:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210930112639.657328-1-omosnace@redhat.com>
In-Reply-To: <20210930112639.657328-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 Oct 2021 10:17:02 +0200
Message-ID: <CAFqZXNvugmt4taraRNyj-=dL3uoscjtN4GaLQ1-SNd2oXT9V0w@mail.gmail.com>
Subject: Re: [PATCH testsuite] Remove the lockdown test
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 30, 2021 at 1:26 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The lockdown class is about to be removed from the mainline kernel due
> to the difficulty of ensuring that a relevant subject context is
> available during each call to the locked_down hook.
>
> Hence remove the lockdown test from the testsuite.
>
> Note that the module_load and perf_event test policy still conditionally
> provides rules involving the lockdown class so that these tests can
> still work on older kernels.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

The removal is now merged in next, so I went ahead and applied this:
https://github.com/SELinuxProject/selinux-testsuite/commit/bba37c007a0c7a12dd603bdac5e4431796f3e2e1

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

