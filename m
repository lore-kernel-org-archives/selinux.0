Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BCBC433EF
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA63611C6
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 21:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhIVVMZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbhIVVMZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 17:12:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67184C061757
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 14:10:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z24so17809772lfu.13
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GP6CZBA3eD/IT4DzplzBkxmwKra5+3ru6Q3LIyU/W9A=;
        b=KqSSJtCeked0SA1tw/NjFwzUk1jRrGMLi5V8kYMtiu7V4P6830H33s76KRGF3uMy6N
         u7Pc12nQ5gfzOhaoMByd+dxZFQ0sG8BD0uu2/A+2aejrflzaBvY7PnAXLpGDxOCK2wkT
         mb1upbY4uHLAqEGFsh3W1U9+aPS45OucgtjF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GP6CZBA3eD/IT4DzplzBkxmwKra5+3ru6Q3LIyU/W9A=;
        b=OFOIE7fAjm3JzYj+trKUgl0H59zshPIQS1C7ZltVrp78qWPpQKC1t+DqR5bfAeSo9c
         1jYqEj50MahsnlwKBuN7xH5aBy9rUBWJ8E2V/wLHlvMQtKDh0G9wofoqFAOsPbdcGO9x
         XwzGwVboPEuKMpOuBaFn5IijQ7OY98NcQz7dJl6rN05ag4FCAv89qoQWf2BQ605uA+Ph
         HNDNTJuUGJMV2f2o0IeD2bGMzQ4zc2ujyrL79Wz/TkCc/pgYQrgX4frmapu8wdpFtupj
         gGufM7tY2qVl2mUGsxfJvxamJKhiYnLKgozIoHm2/wAfj7tyAI9AAuuuNkr+s1+8sKim
         Hd5Q==
X-Gm-Message-State: AOAM530OJvR/gbRrd3sXVcJZmpZF3CfCvgOuR3AgVotxSD02fNRrVGGm
        kcUCMXGma4fc8t1bXF+1rzHwV67L1a0PfyOIBAU=
X-Google-Smtp-Source: ABdhPJyaIUeHIx0ROfloJPZRdXEhhMRMBzSbK4NSeZApW1BVoUksj1X1gmlEWE2LTX6qeDxtU41ZDg==
X-Received: by 2002:a2e:a7cf:: with SMTP id x15mr1425058ljp.227.1632345052523;
        Wed, 22 Sep 2021 14:10:52 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m12sm265319lfc.26.2021.09.22.14.10.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 14:10:51 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x27so17452837lfu.5
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 14:10:51 -0700 (PDT)
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr1466277ljd.56.1632345050955;
 Wed, 22 Sep 2021 14:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com> <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
In-Reply-To: <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 14:10:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
Message-ID: <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 22, 2021 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Make the regular security_locked_down() function do that, and add a
>
>     if (WARN_ON_ONCE(!in_task()))
>         return -EPERM;
>
> so that any bad cases get flagged and refuse to continue.

Actually, no, I take that back.

It's not the "!in_task()" case that is the problem. That's just the symptom.

The real problem is that we clearly have some lock-down rule that
seems to care about credentials and who it is that does the lockdown
query. That seems to be the real issue here. Doing lockdown checks
from interrupts should be fine.

The security layer really seems to be doing odd and random things.
Maybe we should have some debug switch with the above WARN_ON() inside
current_cred() (and a number of other 'current' users too). Just to
see if there are other cases where people look up basically random
credentials.

When the security layer is confused, that's not a good sign.

                 Linus
