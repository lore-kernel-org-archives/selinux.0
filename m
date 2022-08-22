Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45518C32792
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiHVWg4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiHVWg4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 18:36:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1B351436
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 15:36:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m2so11225794pls.4
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=U6f4POvMEJ4MqEhH1l1XcrUcGrKeoTJNzsuGYlXM760=;
        b=V6bX+bfzYav2Uts4onaAr6hETwzzqGBdFgC+CbMkVmSGShCE+1MozbKUQdwywWeq8p
         mmxXgoCC2SDNnIl85H2ASWchBI0HK9kFPgjX6TsV6ZYDPCRF4dfewHC3cNpchqo6qSKh
         Pf1Ex/cEkoH6RWrc2HK3ImQNEq6zyiDjNZZz0fvt1TqswkPyMg6CPc+9YFHXUJZmgVbJ
         RhyucVOCRSfhpS5880w+lyCqeWQpV3CHBomAZAfAIoIXKPhWjPMS9MWpIJTaBI41X9GJ
         hTbn9T3Von21ZmlwPRfWWXxPF2Azl0k+ohsCvUSoHihOTFQSvzy0e4D8yvhjnKqxGIl0
         HfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=U6f4POvMEJ4MqEhH1l1XcrUcGrKeoTJNzsuGYlXM760=;
        b=fMWFGHU2zNr5VDfiHj269xb1tomBJjmMNCE7ZBYCAbTIAcJYQSA3VWMk49URKdwWac
         Td9rjRhb6qVL4AlpxCoArCVWGCqRKzD44IxwqOYkPRkKH9VGVOBDnUjrb39jmws63opX
         tXAIDJENOnfAagZunbeJdmtjbgp6hZfx57WX87OXx7Q8K5nlNMmR+lbnQl6f5IAK/QvG
         67Hbyb3geyPc1yvaD8IKOCn7acVEYTE51ExPqLah+5SFbUA24Zdg/QV8T2M1Yl5hSCld
         X92w/U0NUQQIv9/DtRip7Vfn/rbhm1VFzIyErLg24csi47LlUVXu4fILbEaulh5YjN5X
         cA6A==
X-Gm-Message-State: ACgBeo3ZyGjUuOPBuSmlrc6bYsW4Q1+nDrbSWVf1JEsnIOkinyejQEU0
        U+xVfsddya6eJ1YO5+6XsRiMKw==
X-Google-Smtp-Source: AA6agR5s33Ofmuy+6pq0uTHdQn/LzA2KiAjG+YfzMF8gLlREerg64KcrAHz9vT7LuMa0zdE7XDsEvQ==
X-Received: by 2002:a17:902:d2c8:b0:172:f0a1:4d4d with SMTP id n8-20020a170902d2c800b00172f0a14d4dmr5276182plc.142.1661207814395;
        Mon, 22 Aug 2022 15:36:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ec9200b0016f1aa00abbsm5574545plg.195.2022.08.22.15.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 15:36:53 -0700 (PDT)
Message-ID: <1e4dde67-4ac2-06b0-b927-ce4601ed9b30@kernel.dk>
Date:   Mon, 22 Aug 2022 16:36:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] /dev/null: add IORING_OP_URING_CMD support
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120327984.369593.8371751426301540450.stgit@olly>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <166120327984.369593.8371751426301540450.stgit@olly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/22/22 3:21 PM, Paul Moore wrote:
> This patch adds support for the io_uring command pass through, aka
> IORING_OP_URING_CMD, to the /dev/null driver.  As with all of the
> /dev/null functionality, the implementation is just a simple sink
> where commands go to die, but it should be useful for developers who
> need a simple IORING_OP_URING_CMD test device that doesn't require
> any special hardware.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  drivers/char/mem.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 84ca98ed1dad..32a932a065a6 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -480,6 +480,11 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
>  	return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_null);
>  }
>  
> +static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
> +{
> +	return 0;
> +}

This would be better as:

	return IOU_OK;

using the proper return values for the uring_cmd hook. With that:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
