Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8249C433F5
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 01:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15C860F5A
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 01:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbhKPBQ2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbhKOTNw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 14:13:52 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC88C061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 10:04:57 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i11so17578884ilv.13
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNWkn0euYrddlaTUxBt9RiKgvk8R4zpd09YZVYXC3PM=;
        b=HJJsyzPFhUHPoNx6u4rIshbZ6jGAPTmRri3/8H4wPY4YDZBbXrbW+JD1PHIZBXSs8r
         13t5MIS62BpH/ywAzixrUC0Rz5y7XZ7Gedbsa8xLAJk1u9ddZZrhYSvMK7TOA3eMC/rp
         CL9kcM0FsXlvzb34vvbZnCGe0w+eyxKG4vXEqE1F5Wdhx88mn993b+plVNDee+RjldCr
         ukxMJCSO5lEuVYaLSq+BY3JD240Hm3aWkUKHDVg54/AmHUyA+73JH/JmV89WX2Zgwo68
         uMHLMwZMq66bjiHdWfxcU10tWeR+UxPL5jOJ2R4zOKp1U8m9NTHK07vx7EaeJT424wUJ
         wh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNWkn0euYrddlaTUxBt9RiKgvk8R4zpd09YZVYXC3PM=;
        b=Wi/mgcskOSzAgSIQCqdWqdOgwLz/ACeY8KhnFmlK1i4Mjx6aQr1ATM0ZMnIOX0KMHd
         sgzyNQSzn/ISw0yZL9mkqEjK/F7jKcJ99j7qUUdN5lXzu4mNWpihx6cxOc8sRztGfa4i
         lRfrBFge77JJOcJ8wNz23FAbNC2LJqz5QM/xEidYNQdiQxFm3nn1vwX12yII4bX+U4Jn
         mZ+88bMmZvlqllC639V2RNsDMPk3r4C3cbwpE7a0zy6rNjrDRzpDzjvMrC07W4lzuanC
         +r5+V8/K4MXfundwNUAWH3DJLw0nmrCdpkpFNyt5WFcIiWKBvHRvpDxU+azHoEcKc254
         3lAg==
X-Gm-Message-State: AOAM532h0X+Gpt3MezZPS6uj4/tLyYaHaMgTIrp0jR8mCfXfC0eGVfOq
        aLEjZgJIo51YAGE2RFsH7kz9+A==
X-Google-Smtp-Source: ABdhPJyp6zFNAuBeuoyQU4kkL68fGK2NiaH9e5RPs0cd09v4NWGILyi6DmolYUr1ntMgjfQFN9p19g==
X-Received: by 2002:a92:c569:: with SMTP id b9mr517353ilj.39.1636999496758;
        Mon, 15 Nov 2021 10:04:56 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b15sm10200671iln.36.2021.11.15.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 10:04:56 -0800 (PST)
Subject: Re: [PATCH] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
To:     Alistair Delva <adelva@google.com>, linux-kernel@vger.kernel.org
Cc:     Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
References: <20211115173850.3598768-1-adelva@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74179f08-3529-7502-db33-2ea18cab3f58@kernel.dk>
Date:   Mon, 15 Nov 2021 11:04:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211115173850.3598768-1-adelva@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/15/21 10:38 AM, Alistair Delva wrote:
> Booting to Android userspace on 5.14 or newer triggers the following
> SELinux denial:
> 
> avc: denied { sys_nice } for comm="init" capability=23
>      scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
>      permissive=0
> 
> Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
> better compatibility with older SEPolicy, check ADMIN before NICE.

Seems a bit wonky to me, but the end result is the same. In any case,
this warrants a comment above it detailing why the ordering is
seemingly important.

-- 
Jens Axboe

