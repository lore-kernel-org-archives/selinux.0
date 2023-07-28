Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3FAC0015E
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjG1SER (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjG1SEQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 14:04:16 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021344228
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 11:04:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407ff54164dso5708201cf.2
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690567454; x=1691172254;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hsd4ZqBI4xP964JP2IzxDEKVHRiOs6KK7KEA7coO+NA=;
        b=FCnfKzOBu2qoAXdB9XtZdunKOn0MXAkA8dVhWdgztvF8+bk55rb2XWixkZkU7PdcsJ
         OmCSkxh7GUyEPw7WUm+vNQ+8nsh9v14HoBFlflB+9ENNAfruHQBlSr/Ls43dm0lMCnwY
         gMhGlZkWucdeUpkjPpyctbNMKMnZ0Rre+DuSCvGVmnwu19kPzpj6mduy6wjgGr7sA+Am
         zpXqqwyctg9X/l0u9SV1jmIpIpyV19Lm83rFgTwlW1gsZTVaUxPbLqvYU7lnfhtZTCT6
         ckK8pL9KWL9qh2ztqGl8c1+KAOlLert0kr++PQ/qo6LLGfdrfmjBPvZ8RanIIeeX++Yq
         Hh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567454; x=1691172254;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsd4ZqBI4xP964JP2IzxDEKVHRiOs6KK7KEA7coO+NA=;
        b=FSxOjG9lEXVNZfWMvzIdVs3E0dk6wh9okqZtMaRvYYTdLW3stkMPaVw73Hyaey+qAo
         a+n0456XQv7aSqu1voKpf+jsZvD2mE6oCJ5Pmi4ticyYfGfmrSuFkxeP1EAtWAwx4ygI
         MUOp/+1Kjrbi0gJjIW2HNvgX06zhwDtX+MGr6h7A7KzY8xfSqiV7XcQF9Rk6Wrn/jE+h
         ayE9PuBnJ3lArWKkEiPn2Lx3gdyYTmtSGXw8J/JFmLYEZujwJzOqUeKOuxMxo+0nKKTJ
         Ll0DyEFeKuf4BwrVTpHzNVx/rIO8z/p6rY2W76al4kh+DEDmpoAXPc3NJ37EYh45YmT6
         bo2w==
X-Gm-Message-State: ABy/qLYLQDmc77BKOtTG8rGnm7vRAlatYQAC/H7nVBYM0//zkx5Wh12k
        KK98zDBd2pt2OfTAv5BOxbrv
X-Google-Smtp-Source: APBJJlEfucS+oqyxym3lpoCo7YMNUtBvCVTqxi1ndAHarmCd/6cnSqEprEaHC4ysRCYLKccaEeO2VQ==
X-Received: by 2002:ac8:7f56:0:b0:403:fcd9:963 with SMTP id g22-20020ac87f56000000b00403fcd90963mr4002198qtk.67.1690567454121;
        Fri, 28 Jul 2023 11:04:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i16-20020ac84890000000b0040554ed322dsm1303332qtq.62.2023.07.28.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:04:13 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:04:12 -0400
Message-ID: <375a357fce825c3d6b6d32e7a6396c62.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: log about VM being executable by default
References: <20230728150150.16224-1-cgzones@googlemail.com>
In-Reply-To: <20230728150150.16224-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> In case virtual memory is being marked as executable by default, SELinux
> checks regarding explicit potential dangerous use are disabled.
> 
> Inform the user about it.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>    shorten message as suggested by Paul
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/next, thanks.

--
paul-moore.com
