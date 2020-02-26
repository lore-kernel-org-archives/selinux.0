Return-Path: <SRS0=jqI3=4O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73032C4BA24
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4113320732
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 19:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWx+JJEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgBZTYL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:24:11 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34103 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTYK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Feb 2020 14:24:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so716524oig.1
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2020 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERSWZC4Zv8QAWInzlsnr/m9fiur3B0pm28CxRQ6LzaU=;
        b=SWx+JJExEsFYu0btPLBUhqicHX8Acnb0sHviF6U2kb4XnmYtYK1B6gy3ev3uyJ8kmL
         Gogf9jYbelbvSAzM7U0/modZfd6GOc21Psqf9PiwPMnTNPY6Td39Ee8NMKNopO9WYP4Z
         oKZgjM+oqFgT7hjeK5lwfP78KrO1NIzMbn7Ss5GbyNlR6v4BhpP16140DmmabFLq3jNj
         UG9soUjKLgMbaO0MzFJsrn/IlgKr6juXc9PfTJHu9nKC1fj5K4KTPv2rA/o2bV0Nu1aT
         jSYb7zTsDhm2Z3fcVQ9r5GT7jhr4FsHwKd/UPspwNlw/qzVQwInI8zPqjPCsre1j1kvS
         AQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERSWZC4Zv8QAWInzlsnr/m9fiur3B0pm28CxRQ6LzaU=;
        b=UjzXp4QfTADtmtwbdDHTfQa1okbGyhwENVA44h3zlEJUXhqDKV6ItFa7Zo/FMlUwVl
         W7WFQcbjJ882lkPl12ap7/fjBf20graS8st+r8tXsiU7SnFTR6bCUpjYKT/IJidEOzlH
         NPK0OrJV1NK8dr/mHHVR6BHV76Zqygnd6Az9jaLwz7Zfz+jH/QKLKoXElCqtLQR6aWrn
         tLk+2r9dYMED5GGhx2Dk6M28ffRGKaLspHpHWUwxTzMf1GVk5/p5N52WPrI8r6O6Xkz2
         Ta34IV0slm9pQG8tc18IgyNHG/iTzv7bcTN3JG8MmL3o8CEJUYikQnDqSBDHd5xKcZyT
         wv/w==
X-Gm-Message-State: APjAAAVQ5xu/HMwA7w84KqBflmw0XLsBrsNic2jM36dHp3PvF13p2z21
        hFVlukkQO5F2zwVf5GIyeJXK1qCCcoKmIZ9aCQ8=
X-Google-Smtp-Source: APXvYqyysb4aB89tOUQloEeXcL+/aaBaFHfcUOB5BZZ/9ZbuWDaA+tdQc+/BLFH0fORGPst1QbE/NCwilZQzsvsy0L4=
X-Received: by 2002:aca:f517:: with SMTP id t23mr432828oih.160.1582745050145;
 Wed, 26 Feb 2020 11:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com>
In-Reply-To: <20200226155452.301544-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Feb 2020 14:25:10 -0500
Message-ID: <CAEjxPJ7Kp4ZgdbqKyAwLMQYcatBX7vN+ctU-RFuMfyL1XnU9NQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Instead allocate hash tables with just the right size based on the
> actual number of elements (which is almost always known beforehand, we
> just need to defer the hashtab allocation to the right time). The only
> case when we don't know the size (with the current policy format) is the
> new filename transitions hashtable. Here I just left the existing value.
>
> After this patch, the time to load Fedora policy on x86_64 decreases
> from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> from 750 ms to 122 ms. It is also likely that other operations are going
> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> but I didn't try to quantify that.
>
> The memory usage of all hash table arrays increases from ~58 KB to
> ~163 KB (with Fedora policy on x86_64).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
