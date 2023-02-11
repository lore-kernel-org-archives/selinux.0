Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155CEC636CC
	for <selinux@archiver.kernel.org>; Sat, 11 Feb 2023 06:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBKGYm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Feb 2023 01:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKGYk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Feb 2023 01:24:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954E2A6F1
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:24:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id o8so6455952pls.11
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AHAGCl37VFmW68oVgsE+9Li5yDh+3xhDP3jxN//3fXI=;
        b=wuLtUWsBftCSOCM6iIs9gmiaP/qxswof/WqmtlA6bTFL7sEIHL1kCH/BmL62tNAS05
         Bf+GOyz0PdJqo+xHCUTlNqzApGZso/aFZZxT+lZ068dk6elWMnhSz4LaUbjCF02vg+Ws
         QXY078ZsVPBOuvzqlAOwbdAmBUU5cXG5WqIWTgn6tZ0RrndjOdzqp/0PiH6cjNiydIuX
         iOetOJ69b/nJgznlGRAcNxvWzSnDUuDYDwr5iT4vT81DFY19MkdeNF5/uUz0nI/zJf2l
         L/yIes6VY0yaW3UsyoOndwJu5chR+0H6G4+f1AKOnC1hnL7bW2pa1hsUWy/45rQJYUWm
         /5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHAGCl37VFmW68oVgsE+9Li5yDh+3xhDP3jxN//3fXI=;
        b=V8XPgj/R6MB9vS0Wnt9OgCMSpQHagpu8fYVWSboG0jqP1rx3uH9v1p24Lh062LWzVe
         UmJi0v+qAoima5ChQXbE91uouy7RyjjFtb9nrSq1Dqy+qTIk9mo6pJURLWZFoLy+UkPb
         rrGp1HRcSphi6drmd9o+R72rCU7XDIv8XWuj3hqFaRyQQZCaRDo3nBPaTB3Q27HioU78
         RbCioV6eHk2JD7ia2BaadzGmm8k54yaRviQylrHMjSxCCfTvSVMP4KfEqsukGCeyNeLT
         iPuRvGu1gtKPiiamDuf5IEvhapaaWqieNfFhVlpYeiJmtbIVsynowST+tMgnmz/iAxtq
         xRrg==
X-Gm-Message-State: AO0yUKUxGs+DpZM4akHloK0ykNzd/KyinW3ENL1XAvZijuG21YKXU/fS
        5Yoz7pFKOqjKVK/3o2pJhFKFRQ==
X-Google-Smtp-Source: AK7set9BWG6e+bk5A5kJAXWuYbDKUkF0QpRft0RftgZWT3t69IklqPbeNCU43cPpHtlkvm+4SKlngQ==
X-Received: by 2002:a05:6a21:9712:b0:bf:ca3:6896 with SMTP id ub18-20020a056a21971200b000bf0ca36896mr13632316pzb.2.1676096679167;
        Fri, 10 Feb 2023 22:24:39 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id g6-20020a63b146000000b0042988a04bfdsm3879470pgp.9.2023.02.10.22.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:24:38 -0800 (PST)
Date:   Fri, 10 Feb 2023 22:24:37 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: getcon.3: add note about PID races
Message-ID: <Y+c0pXzzwnn8uZTn@anduin.perfinion.com>
References: <20230109170912.57887-1-cgzones@googlemail.com>
 <20230201131516.19967-1-cgzones@googlemail.com>
 <20230201131516.19967-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201131516.19967-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 01, 2023 at 02:15:16PM +0100, Christian Göttsche wrote:
> Add a note that querying a foreign process via its PID is inherently
> racy.
> 
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Jason Zaman <jason@perfinion.com>
And applied, thanks!
> ---
>  libselinux/man/man3/getcon.3 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
> index 1b4fe4b7..be60341b 100644
> --- a/libselinux/man/man3/getcon.3
> +++ b/libselinux/man/man3/getcon.3
> @@ -149,5 +149,9 @@ The retrieval functions might return success and set
>  .I *context
>  to NULL if and only if SELinux is not enabled.
>  
> +Querying a foreign process via its PID, e.g. \fBgetpidcon\fR() or
> +\fBgetpidprevcon\fR(), is inherently racy and therefore should never be relied
> +upon for security purposes.
> +
>  .SH "SEE ALSO"
>  .BR selinux "(8), " setexeccon "(3)"
> -- 
> 2.39.1
> 
