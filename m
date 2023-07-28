Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE5C0015E
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 18:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjG1SJh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjG1SJf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 14:09:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02091423B
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 11:09:24 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a37909a64eso1917981b6e.1
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690567764; x=1691172564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TICUNswaiy3hGzrdEHOhf450hXdu05dOSqoVSbTxlFE=;
        b=dlxe18JZ/R5T/cj1N4po5CDFM75FGKqR/keZ/dp1HTJBAD9IY775A5kPEXok7rd8Ml
         nsUt2+VbNcGo92PsVz46RSoT9ENiNEFVCCZh8jG4RPxGMF+ZiNNCrCNnV+UmSyqCR2Lh
         AoechusVVqfWu0eH5X3TF4o/zUEiwK4S68QxbWOgdF8Tu96nRHTagwaOpg4/0/rv9p6q
         puDKQ52Dd6fTd/6BZsMudZT2Dy3rLUYV5kJ1n/a470bCHsI0rQ0Y5TbzG4WoOqcAQclY
         6HF8uEmfoP/AV6q5otaksnjV+v4Pvzk+aymNO16Y3tczN3bqGCEcwuSRj6URwezS4jNE
         X8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567764; x=1691172564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TICUNswaiy3hGzrdEHOhf450hXdu05dOSqoVSbTxlFE=;
        b=JswY4uFwIM2cc3+UDsPpiGGBkPNJqLFeeHHbNak2uTvOIqODLBZwaglntEBbmsfIYP
         BKLf57+KZIQ5U2sdAUjXFVbHRmeeHmER0zfPrGDVyze+6Z+o0GXwKB0AYnjE0VPZSTcQ
         wuRzYqDLDwOt5ibCMr+iEm1b05ho2tY72ABmNCbEj3LuiOrFr0YBspL11siWFJletKIA
         6Pk5Sk4Hu7/33Cz/wQMWusjMZ+5oTNB98anIBx77kcIcY+XPXh93+axFb1VTi4kSRJ5W
         CUffgJKDLi+deEYfZ3SoE22kPHbB8y1HqgautYw3Chdaqt2ktBcEnPNlRXv3PcTqiGyx
         aO7g==
X-Gm-Message-State: ABy/qLbVCNDCTw7+Nv0YAb+0uyyywxBiySTxNAdJP+YJIwWbY88f0FYL
        TnFx3vGcKOpkJ6g47H75WCqZ
X-Google-Smtp-Source: APBJJlF737sAfy9uxAJq7mnhK6Pe6shkg35fxSrQSXzjf9O/X1EW+w/cyH0mee5HYQeKe7meePa4rQ==
X-Received: by 2002:a05:6808:19a6:b0:39a:bd0e:449 with SMTP id bj38-20020a05680819a600b0039abd0e0449mr4286448oib.26.1690567763731;
        Fri, 28 Jul 2023 11:09:23 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r2-20020ac83b42000000b00403c1a19a2bsm1328529qtf.92.2023.07.28.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:09:23 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:09:22 -0400
Message-ID: <a0288beb97f4561804d930667c38c196.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: move debug functions into debug configuration
References: <20230728151932.30160-1-cgzones@googlemail.com>
In-Reply-To: <20230728151932.30160-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
> the configuration SECURITY_SELINUX_DEBUG is enabled.
> 
> Move the function definitions under that configuration as well and
> provide empty definitions in case SECURITY_SELINUX_DEBUG is disabled, to
> avoid using #ifdef in the callers.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   - provide empty definitions for !SECURITY_SELINUX_DEBUG
>   - drop #ifdef in caller
> ---
>  security/selinux/ss/avtab.c    | 2 ++
>  security/selinux/ss/avtab.h    | 7 +++++++
>  security/selinux/ss/hashtab.c  | 3 ++-
>  security/selinux/ss/hashtab.h  | 6 ++++++
>  security/selinux/ss/policydb.c | 5 +++--
>  5 files changed, 20 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
