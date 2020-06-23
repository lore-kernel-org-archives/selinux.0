Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB6C433DF
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70703206A5
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MBIk3qxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgFWNVb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFWNVa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 09:21:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E438C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:21:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so21628870ejd.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7zbl5j6sfcCLOp7PY1MHFLx7BdRWHFOZ+p5EXyN/MM=;
        b=MBIk3qxirju0CqdTSWvDkRH9Zhd/W2G7TWKmqrHj8/fKip66ywjbDWRAE2ydTdxA5S
         q/IHU8eV3ydQ44bXaoyNMgEAV9p7lAGxXBkDDJ/QN2S/hUwlUpDtyMbJQcD8eJEe/oqN
         t39is3SvHotyew3eglBit9QSNRWNHtriR1w8SVKrJOYzyRGro1WjqbwPe6GpfOXuAFZD
         c9JhONKvBCZDWe2D4dw1ttG7mBN7mw3R1JI8Baxv4lyQR3qSxiMNw/R+joBi4eyopA59
         vDnrzczaMZFkONE8DuWxguIhdzzhQ1OXo8tIXrd8DKs8hy9ejzdcAU73kQmX8I4e4pfM
         KPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7zbl5j6sfcCLOp7PY1MHFLx7BdRWHFOZ+p5EXyN/MM=;
        b=YuqPGWef87X8JuS/xdCy7mSpNNzM4Mja/hrwaLCmbwyH/mKiHJhTZrxGK26dhfpa9a
         LJO02fkmPX4mPnF7Oia3MaCywMuHybSlZmSPXhqjU/AIMtI0eBolKn9MAGxuE8ZcW3p1
         CpQTBGD8K8UxNMuW2A/CSIhaGDOahgV8tpGp820dmP1CfBCMlc0x+C2LJROSgwMwtPNl
         8Ybpvt1Ta3ErKXRr9PAcpXfrgRL7/iVu+aPCDpvQ2tdMBDCgV+GqOl1hm6m8A517unHr
         I7qr9ykn3Aj2WHPChsov6egxgR8SZIWoRin8l5FG3qbqRENyUyISG6gG2NOF+PebqMeB
         PiLw==
X-Gm-Message-State: AOAM533u8g5TVN32vr1rJZ7XBtAIvyNtb+UQl53/oS7npz3B4TVrRirv
        Gz+NAxn7979o+PbFXPZ3GtYKLvJ57l7nYk5DGOdtE+8=
X-Google-Smtp-Source: ABdhPJxVpUZLsCU+EOVxCpz8NBxPimrDArR/GXoKYaeRhqZfOD054SHt5cb5VbOqaA05JCrccrWBsWCRPsqWfAvjD5U=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr19933543ejb.91.1592918488965;
 Tue, 23 Jun 2020 06:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-2-omosnace@redhat.com>
 <CAEjxPJ6tPfWrUOEGgkbOgeoxJL1Y0DJ2fKaWYbgu33STi+6ZAw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6tPfWrUOEGgkbOgeoxJL1Y0DJ2fKaWYbgu33STi+6ZAw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Jun 2020 09:21:18 -0400
Message-ID: <CAHC9VhTJdhFk6MH68V39L+LnBxHtB3vj=bNaXzFFq=17FHpFrw@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/4] Makefiles: remove bashisms
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 9:10 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In Travis CI (Ubuntu), the shell used by Make doesn't understand
> > bashisms like [[ ... ]]. Replace them with plain [ ... ] and also break
> > up the conditionals for better readabilty.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> When I ran into these issues (along with some similar problems with
> bashisms in some of the test scripts) in getting the testsuite to pass
> on Debian and Ubuntu, I addressed it by running dkpg-reconfigure dash
> and switching the default shell to bash (as noted in the README.md).
> Not objecting to changing it but just noting that there are further
> bashisms in the testsuite beyond the Makefiles.

Agreed.

I don't think requiring bash is the same problem that it may have been
~20 years ago; it would be even easier if Ubuntu hadn't decided to go
with dash (/me shakes fist).  Regardless of this patch, I think it
might be good to add a check to the test suite to warn (fail?) if the
current shell is not bash.

-- 
paul moore
www.paul-moore.com
