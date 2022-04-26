Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB3C433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Apr 2022 04:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiDZEWX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Apr 2022 00:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiDZEWW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Apr 2022 00:22:22 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1033F31908
        for <selinux@vger.kernel.org>; Mon, 25 Apr 2022 21:19:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ebf4b91212so169836607b3.8
        for <selinux@vger.kernel.org>; Mon, 25 Apr 2022 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0GcaF8LUNtQ/VcGNv7yf0Gg7VDi4U2EzhXVUK76yEg=;
        b=njLi7DoIAgYOwTX3faFgIDrku+P0ZmnRNcTGq7I3qUSmwUMsnLbEb1+i5FJRtHG9KP
         b0KQjHU59aK6VFLy9n9bNXp9O9BSYLxERSEWkZq87GAuP+ybEUAo6umNBMiDtOxXds3A
         7LbA5TzBtmJJOKPKs5uKdHVwPg40ILTmfxDdgywrZl4Lpuc/X9xu7iDjCpbyRmfEc+DO
         /pmGYrqaaKtd6LkU+HsqXVEw4pxLgxns7YDexb3YDBxPDt6/ogBbSrXah8C3lCJ3QPcV
         7VuuIbquM7j+6FzFmxzOM/8Fvms4UH4V7sxjrdUfCRfbBn4/M3kzXMhQ4g2lLUY9Kxrb
         p5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0GcaF8LUNtQ/VcGNv7yf0Gg7VDi4U2EzhXVUK76yEg=;
        b=g1+OV+TjC5Hsv/7JoslN6zEt/k/+TOKBIXN+e73+wP0vRR+MvUXytLAmqT6AwMAGcm
         pSYcdiQRGSEHDFH0PtEWnXBdlaoSj9trEMLefZ4YO8tORaNbPyCuLYOaCajQmZGDunT9
         K+6lXVnoijpD4gw0YdVPz8WxnIK4aiuPwDMA+KEY+DiGd0qSJrlNGcusQZaoOjsmm/AS
         PIEOyUOa/xKhaqgvQkuh+IhuAAw8UXn6PuKmUCp2deTIvVjMX26dlQcf/kitKzsfdrXu
         /0Ae5PU/KeAixttFhbVYPszSui6Uc4X/Wmci0mgQW5F5/TaxrgQ8SSy2p47p+yE/dkv2
         fGqg==
X-Gm-Message-State: AOAM53342Ge1ZSw/zwibyYpqmBPuv0Cp2MrwX50IIM1NH0eAHwgo7mTf
        c9//ZbgTSRlZ7rhMQqY2sFhayCn4pmHnvwgX1RMWxw==
X-Google-Smtp-Source: ABdhPJwqBv79DUWRQoYAXWxj7RmGgqEUHzGXj7uhZygu0z3BYwVgDlEdfTSZGsYX1lKCipPV7DtAYkndeVbuxoy/T/k=
X-Received: by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr19622038ywc.458.1650946756147; Mon, 25
 Apr 2022 21:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013215.2301793-1-tweek@google.com> <YmK9lhEENKFnr6sd@bombadil.infradead.org>
In-Reply-To: <YmK9lhEENKFnr6sd@bombadil.infradead.org>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 26 Apr 2022 14:18:59 +1000
Message-ID: <CA+zpnLfS4nTjXYYgE_BNcjQPF1vWynOe_118YgTZa9S5G9dVdg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading firmware
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> Can you elaborate on the last sentence? It's unclear how what you
> describe is used exactly to allow driver to use direct filesystem
> firmware loading.

I realize my use of the word "device" here was unfortunate. I meant devices as
Android devices/systems. This may have contributed to the confusion.

Previously, Android systems were not setting up the firmware_class.path
command line argument. It means that the userspace fallback was always
kicking-in when a driver called request_firmware. This was handled by the
ueventd process on Android, which is generally given access to all firmware
files.

Now that more devices are setting up firmware_class.path, the call to
request_firmware will end up using kernel_read_file_from_path_initns, which
would have used the current process credentials.

>
> And, given the feedback from Android it would seem this is a fix
> which likely may be desirable to backport to some stable kernels?

Yes, that's right.

Thanks
