Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A333C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4F1206A1
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qY34pHg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGISA1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgGISA1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 14:00:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898AC08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 11:00:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so2540783edm.4
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvPmx5Iq59goBQm0o/Bm9SBqvWTKBiHjiFQUUpT1wYI=;
        b=qY34pHg2H018jMNJc5U9c9fpBajC8yTeECvEwGLVpEeQ3IYbolmqVlzd5ILRGxMlX2
         xwmHPL5pat1sqmK0vuzN87ZoSaReEcSVXLtJba/PyUbD0Wf58PvI/bjAc8Ilm51tZuP3
         6Z0jKCxOEkhfk86eynw7YyVgO7cjkuBq3BoH41cQ4J8O29/VRrWGOAN1eJWYU5G2HfJK
         P0FCCEMiYGDfuHv0K5wjswPJZixKcWcJYTBm3+s8qY5mk2YjGRJ/TJFPFalGm8yzZlpG
         2sLi27klPITr6xVBCCZxEAKjQ3cBGqcU1Hd5s4FPIg6uczetxwql12ALZNjUlW+KGTS2
         HmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvPmx5Iq59goBQm0o/Bm9SBqvWTKBiHjiFQUUpT1wYI=;
        b=Zlk7S6tz+FfrxDeUjMHnG2SmwtMdAaoPZp+/33vls4ScwNDIhbxQlIqpT2S0Bg+i9N
         s7aaWPk+52+trPRYXw9xFmtzJlHJr9UK0t/5ERU8gSEogBfT/2p852JfwW3206/SilMN
         NC/h94lQSbzZK3Q+vKobn6PTkNMyx0cscL016P9vHFHw+RVHo11UZy1cBWh2ofi5s6rF
         1W8Pg+b7EmRJDsazLx/fAVYGJPXC4Bh4bUBcojrAUh69i8ggg/MdcXDZk4VBPEhDdzFJ
         abQmIs5lEG/tn9Me3UmTA+7FKNVwu1ZSYMkf8bkT4Bo794L46eGA8Vg13HuHUBABfxpI
         +hxg==
X-Gm-Message-State: AOAM531U8U6H9J6Bwwe1rMKJEfRxPpt3xTHM1TZVUrMsVZ7j0eeVfYae
        0c+9lHNBFFZ5tONqMKsd0CrP4MMkUM5s3TLTQXLRYBk=
X-Google-Smtp-Source: ABdhPJz6LdLbBuyih2bqwwtdGmzdXWBnOr+NmrlqcmKDpbQLakuTuoTvLRwj7wx4wqJBm11jSMM9cus0AmSvjhUAk3M=
X-Received: by 2002:a05:6402:1d89:: with SMTP id dk9mr61556992edb.31.1594317624694;
 Thu, 09 Jul 2020 11:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpDN+8c2hQ+OoX8z+Fx3s-7-g2sn7ZV+Y=D=NZqqFwr6Q@mail.gmail.com>
In-Reply-To: <CAFftDdpDN+8c2hQ+OoX8z+Fx3s-7-g2sn7ZV+Y=D=NZqqFwr6Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Jul 2020 14:00:13 -0400
Message-ID: <CAHC9VhQkTgYFQ5ncLDJpOcqynWam3QY7udLQoUYSb3HgkvdboQ@mail.gmail.com>
Subject: Re: travis: any reason we have keep going on make commands
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 10:33 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
> So Nicolas initially created our travis script in commit c9adfe2d2653
> and has -k, or keep going, on the make commands. This causes make to
> plow ahead and bury the errors in the logs. Stephen noticed this the
> other day, and we have been chatting about it out of band and wanted
> to pull in the community.
>
> Are their compelling reasons for keeping this behavior? I am also
> concerned that we could get false positives on travis success results.

In my opinion the whole point of automated testing is to catch
failures early and often.  For that reason I would want the test to
fail and stop, both because I find it easier to identify the failure
that way and also because I'm not sure I would trust much of the
testing that occurred after an error condition.

-- 
paul moore
www.paul-moore.com
