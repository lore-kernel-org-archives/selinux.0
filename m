Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A3C433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 21:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbiBRVRf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:17:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiBRVR3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 16:17:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDB244655
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:17:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id j24so2269180oii.11
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/NlE9yiTq2YexgBCevko6vCcqIYrkqIlwPQiMzcHF4=;
        b=dfHY/xA0YgjbA9cjta6fWe7+Sltl/pcSnz9Irdym16kWM3w5BqDtnsZ5cOea8MDhcv
         XNyLYfnYF/5sws2wI+Wk12CQHnPEpMtZ/KcktX7terpPTApq/ZcBovAR5TadIB/XZ4XR
         JVgbolgxBFlZG/poGCzS2lIaD72jeqWPeP744mPlTWRSdTf0smUPqzfZnVkqWNZzq8h3
         72jLcRDpog+KSv8FRsK4UFnEYwDST2+z1UImRPOLU5FB3/wI8+6BNqz48n1gmLFgRcC7
         KDP+aSqheUTxBTuHtZTucvA/hr0Cwl7t8ycnWzUWOjYXVz4/WRgab9KHEJD7d+VWAIRI
         qHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/NlE9yiTq2YexgBCevko6vCcqIYrkqIlwPQiMzcHF4=;
        b=vwfNo3T2/wyT43J6gipjJRnpA/ULdODEP7Lcyw/4SJ/zIhbwnjsM1BoltJYhsuGwbd
         DXcBaLqe/WKTJDEwk4hR8DXO0sFX/wVbkg5LQRjIsjCLwQqx5OW6VKDeM1MImlBnjqqF
         wMN2gFy5JgF4LFjRAFnfF/pfaX45x+HfqPbHkSR5+7eaKpq8ASeM5JbQ0QYOGqMhATJL
         yf79xkvWhotGrduvajiFHFtFJY4z74NWR1r9stJzO2JrjRj+TSPKeOeMAVxSQjqjEDqg
         nNnSEGoNuIc0Pg1lVWnLW+7rzllQTWRXvIPKIKzoWFx8mdwRs6YzrYkEPJ7uD04puNNU
         XduQ==
X-Gm-Message-State: AOAM532KiYj3hLkiCftA/CIAdykES3AH9sSszdEeooxpHwU4XbyyEDtf
        kKmKBNXWxB+yNHeL6dUsr3HUhRodRW0v3VSl3pi5ElVM
X-Google-Smtp-Source: ABdhPJycebkWPIj3Hmck8WyVrXkJ8nUwpTCnMyqymE4QatB45KdkU62uVHJH+C0Yk5sjx26HJrg+7n6Z4VsbHa0OnmU=
X-Received: by 2002:a05:6808:1147:b0:2ce:6ee7:2c8f with SMTP id
 u7-20020a056808114700b002ce6ee72c8fmr6004294oiu.189.1645219024492; Fri, 18
 Feb 2022 13:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20220111215446.595516-1-jwcart2@gmail.com>
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 18 Feb 2022 16:16:53 -0500
Message-ID: <CAP+JOzSc6Gmtc7b9rB6t=CLVG+83OOzU5ikUJ9S8JWv8LxqDiw@mail.gmail.com>
Subject: Re: [PATCH 00/16 v2] Refactor and fix assertion checking
To:     SElinux list <selinux@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I plan on merging this series next week.
Jim


On Tue, Jan 11, 2022 at 4:54 PM James Carter <jwcart2@gmail.com> wrote:
>
> The first 13 patches refactor and cleanup the neverallow and
> neverallowxperm checking code to make it easier to understand.
>
> The last 3 patches fixes errors in the assertion checking code.
>
> This series is to prepare for adding not-self support to assertion
> checking.
>
> The only change for version 2 is in patch 7 where target_type should
> have been used instead of source_type.
>
> James Carter (16):
>   libsepol: Return an error if check_assertion() returns an error.
>   libsepol: Change label in check_assertion_avtab_match()
>   libsepol: Remove uneeded error messages in assertion checking
>   libsepol: Check for error from check_assertion_extended_permissions()
>   libsepol: Use consistent return checking style
>   libsepol: Move check of target types to before check for self
>   libsepol: Create function check_assertion_self_match() and use it
>   libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
>   libsepol: Remove unnessesary check for matching class
>   libsepol: Move assigning outer loop index out of inner loop
>   libsepol: Make use of previously created ebitmap when checking self
>   libsepol: Refactor match_any_class_permissions() to be clearer
>   libsepol: Make return value clearer when reporting neverallowx errors
>   libsepol: The src and tgt must be the same if neverallow uses self
>   libsepol: Set args avtab pointer when reporting assertion violations
>   libsepol: Fix two problems with neverallowxperm reporting
>
>  libsepol/src/assertion.c | 193 +++++++++++++++++++++------------------
>  1 file changed, 102 insertions(+), 91 deletions(-)
>
> --
> 2.31.1
>
