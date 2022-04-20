Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2505AC433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 08:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352657AbiDTIyd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbiDTIy0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 04:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C4F8329B4
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650444700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMLzADdj3hBelyDZJVvu4WE+V7vyalVPWQWnp5xGs+0=;
        b=Cs5BOn1c6nvdfvPJF0WJcgKHHAl/x0xisiyKkhLxag/NlVOxjdEVHblQzhXH7wPdjugcmz
        Bcj85BiTLZHWDiUl0FRtTcuKWTORlXuk/q9Y8gRYW5zRj1Q+arWsjWTaneaeKhlyS3gg3m
        dS2g8pagIzvApmWC+sV/cWqTsCbA5gg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-V3O9nOu9Pnq8D4CefyoStQ-1; Wed, 20 Apr 2022 04:51:39 -0400
X-MC-Unique: V3O9nOu9Pnq8D4CefyoStQ-1
Received: by mail-yb1-f198.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so903568ybg.8
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 01:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OMLzADdj3hBelyDZJVvu4WE+V7vyalVPWQWnp5xGs+0=;
        b=U30xbuEGUnmVSjCBB4m0+hTcKkPjlb2mdkey4i7QXT74BlpK55fRkSpnDdrzSqBJEZ
         mwt/ErBY1I8rwLi9HRgnx0O8Gof7pPOWUb7Mkq7wMwjwaYovSD58U2Z87kysaGxtZDfP
         xX3oU3NUbZ7hpOyTgnGucDcbdkn2iRhILabVGNm5Od+EcLF0mNu5avFSbRGP2iPTcDan
         uApyrzLtONnx9deQTZJkARnVpMax9lh/z1xH6x1RKP7WPzrbW5R/wzh5o3HIQmJVKKz8
         BImxacXuzXskiB61ani74kLpZvOy0ITig7bzcAFEBcUPVeeFAZj+wSpyoMQ12nLpv/NT
         w/qQ==
X-Gm-Message-State: AOAM533mJxOEbXvMD6p0svX1VNlvxXGzhRDc/O9GpnfcYRIe1Ou14tMO
        aqi0cUAxjfjUYt1lj8bkxw2h2yk+x9lLNTvxGOzej5sFWhSOmhZBTH+R0nfRXyfoTkoJK7OkbaD
        hXEwolf30KVNcb7Fjzx1DoCVKsDfZ5OLtiw==
X-Received: by 2002:a25:c842:0:b0:644:b7c9:374d with SMTP id y63-20020a25c842000000b00644b7c9374dmr17989799ybf.336.1650444698346;
        Wed, 20 Apr 2022 01:51:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0dYqHiE5Ht+X3rKp+Rpkk3iB1kGjBkAExb4riRQrWCAl//3k2/1RFwqzUYI1FgxzVtsj9IeI0JPvLr9lEQEo=
X-Received: by 2002:a25:c842:0:b0:644:b7c9:374d with SMTP id
 y63-20020a25c842000000b00644b7c9374dmr17989794ybf.336.1650444698176; Wed, 20
 Apr 2022 01:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164810.2122305-1-omosnace@redhat.com>
In-Reply-To: <20220413164810.2122305-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 Apr 2022 10:51:27 +0200
Message-ID: <CAFqZXNvOmnyWuv0P_zteo+886HfKi54T1yaVtTdd5EhSORGNfg@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/2] Make SCTP and Bluetooth support optional
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 13, 2022 at 6:48 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> SCTP support is already partially auto-detected - improve it to be more
> robust. Bluetooth is often disabled on architectures where it couldn't
> be used, so add checks for it and skip relevant subtests if it's
> disabled.
>
> Ondrej Mosnacek (2):
>   tests/extended_socket_class: make Bluetooth support optional
>   tests: check more thoroughly for SCTP support
>
>  tests/extended_socket_class/test | 107 +++++++++++++++++++------------
>  tests/sctp/test                  |   4 +-
>  2 files changed, 68 insertions(+), 43 deletions(-)
>
> --
> 2.35.1

Applied.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

