Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C5CC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DABE20774
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="tHtlXsVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgFIO3G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgFIO3F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 10:29:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF8C05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 07:29:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q14so17714706qtr.9
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0f5Fz+5BAgA2FEY4UOqDOxDSElR6Yfydhxcjf34Ovmg=;
        b=tHtlXsVbtVrp4Qe4MyjUHju+6Dw7m3a5K9cw33+qFWT7sv6b4jNXEmHoywKA9NxB8+
         owxlQcoy8Wx3f+u0YBCHYEc2Jtn0sV/JRS3wJ/E0XVEIS771CHXqnebBtQs3g0BQmFTo
         vwt1Wcxuu/tPlF0Z6Fj+WiJD88QrfNFIJEoYwGlryMZUdKPF+mVqpJ5/ZpLb8fKNeebC
         tWaXVD3DvqW4Gy+hROfw6VHNGietkCY0GGTJOKt9VbZ+3CnwtCuieTkFb9aoaAnXDQJp
         u0QqpabWi37Bu2P4io1eSC7m1dlFi4/sZ/+skEjJyjX/r9lXw2DSUbMEQaDgBkQPmi0r
         VeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0f5Fz+5BAgA2FEY4UOqDOxDSElR6Yfydhxcjf34Ovmg=;
        b=FMf/idL8/ZpvyFnUU1dlLQWNrq4gRC8C8CwfpeecRSxR5DXk4r7I+oSCIZl2SrtvVA
         I33/P203gpSaibtSlTeT1DbvmMUSTTMge7gUZneKSbG5Fzm/9i2Nj0yShuOx+vjEhMgV
         /d4+4Vg63B+XDeaO/8+CEdwDA6dxZ92pGnnCS29QBE1moa6+sbDHa0m+NcFMlBaJhloM
         VGK14/QxYQS0rqVH5LMpU4r+vA91f802DkW6GE7PAqSj6BWFu9qS92dRbp9M6TPsQ/tn
         ZEYGcHTPxm+qhJQjQmBcAU+NdNSmvYagaSGEdM1aUqwqK3StYQ5iDJXW5xtZJJy4vBQG
         M23Q==
X-Gm-Message-State: AOAM531b8SRp64AWRjlmFFzIQmIjlAdexDU8tYckFvKUw0nuhizKp+yj
        L80j5GaqaAkoX39vMG5R6cTHPXJNt+cIwcTo//dfHg==
X-Google-Smtp-Source: ABdhPJwYNZL33usoTRUlK9oZb5S9zydNrvnhO86X7vtCIaQ4Z9CRECCsG26ydez8bayCL9AppLo8fYq1Hk1XPKZes3w=
X-Received: by 2002:ac8:2201:: with SMTP id o1mr29044357qto.68.1591712944383;
 Tue, 09 Jun 2020 07:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200608162010.122077-1-pww@edgekeep.com> <CAEjxPJ4HAUZf4sSFxXv-Kkb2QQHp4DnoSdMo5MR632Z6Vo2z_g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4HAUZf4sSFxXv-Kkb2QQHp4DnoSdMo5MR632Z6Vo2z_g@mail.gmail.com>
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Tue, 9 Jun 2020 10:29:30 -0400
Message-ID: <CAGeouKE+ZNbh3PJO8bNfvEf6qJtKvRsoy5K+BYgakuhUJ-JpDg@mail.gmail.com>
Subject: Re: [PATCH v2] Add restorecon -x option to not cross FS boundaries
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Yeah, I wondered about that, couldn't see a reasonable pattern, and
put it in where it seemed, uh, least awkward?

Thanks for your patience on getting this built, it was an education!

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP


On Tue, Jun 9, 2020 at 7:56 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 12:21 PM Peter Whittaker <pww@edgekeep.com> wrote:
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/208
> >
> > Signed-off-by: Peter Whittaker <pww@edgekeep.com>
>
> Only question I had is about the order of options in the usage and man
> pages but that's a nit and doesn't seem
> terribly consistent currently.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
