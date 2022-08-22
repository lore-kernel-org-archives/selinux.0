Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C6C32774
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 23:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiHVXN7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHVXN5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 19:13:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD92B1B1
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 16:13:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y4so11283073plb.2
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k57+dg2HrtlIQk/KpIf8ji4XrFU1DDWFtYYzHAM8E28=;
        b=WBSv8kdAEp+ZV1JgNI7nrDpKgcOJwUpuYjVtnVjv8R0wbr4rJFgy0kX7M7SPUp78gQ
         Yjwu5xTNCeoz9Fd0F0IJD1Fb1GzRPlaaN5IXLW5uCueLNqkTFxBMnUyJ0uXzKwsN2kII
         UACDJ8q1ft+DlA5gPMhBIA+L37LM8a8QIBBJ1dL9YE81AkL1vYlLr5vo/4/pBq4utrWz
         mZRZHukHrws4QZUnkn0c1WMMy9eZGM1z7mWw31x0EZ9pdMOwaI1Bqk3HtA78Qq5REZqC
         w/fuNcIs2hf3aqBsp6ExYI6GzAriEbRbE+b4kn0FFhhah+3wIg82ouK1YGt+VhJzbDZD
         iWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k57+dg2HrtlIQk/KpIf8ji4XrFU1DDWFtYYzHAM8E28=;
        b=lfJTig9EHF3t8rm3hd0SnwF0TprixBICzVaAgkG3XTm1Fep+6sRGzPjWPEtMXot/o1
         ISbDN2s5WzGULL/DkYVxJvUazQYzMh8FE3uJBiTB1SC29RRI6opqEYs88/1k2cta3W5z
         4IwwIbU0LliAtxUYZV3MZPmW92+L1XBR3XPzSHdy+Ur4VRD/mCdT0qZJqybdt0Xho2pw
         fYu7XEBduHjkZ9ZrirAekQ4XtxPinRxwxobxybOQxFsspRs8CanRbg5tPD5526POi74e
         r7qzxFdHzr/xNCIuHTqPMWGjg1mqed1EXC63w7fJyLSYTG7/Z/wXw3wfV/gTTCWYFdTV
         qZpQ==
X-Gm-Message-State: ACgBeo1CRX1GUoAGmFvbIxpxNe5NhdGgshQPjhSYD5njOpbFc8dD0OjY
        8SNV8k+fKtI7Y7vnXs/lilnCkw==
X-Google-Smtp-Source: AA6agR5aWrj6XXk0YCvQfpFrf3hSHf4DcTuq5UuPZEZRin5bdvMy+z40BIhjjhzb+uWrUBR54zKyDw==
X-Received: by 2002:a17:90a:ab15:b0:1f4:fc25:f180 with SMTP id m21-20020a17090aab1500b001f4fc25f180mr571343pjq.144.1661210034062;
        Mon, 22 Aug 2022 16:13:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709027b8900b001715954af99sm4769583pll.212.2022.08.22.16.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 16:13:53 -0700 (PDT)
Message-ID: <1017959d-7ec0-4230-89db-b077067692d1@kernel.dk>
Date:   Mon, 22 Aug 2022 17:13:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] /dev/null: add IORING_OP_URING_CMD support
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120327984.369593.8371751426301540450.stgit@olly>
 <1e4dde67-4ac2-06b0-b927-ce4601ed9b30@kernel.dk>
 <CAHC9VhQbnN2om-Qt59ZNovEgRAcB=XvcR+AYK8HhLLrPmMjMLA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhQbnN2om-Qt59ZNovEgRAcB=XvcR+AYK8HhLLrPmMjMLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/22/22 5:09 PM, Paul Moore wrote:
> On Mon, Aug 22, 2022 at 6:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 8/22/22 3:21 PM, Paul Moore wrote:
>>> This patch adds support for the io_uring command pass through, aka
>>> IORING_OP_URING_CMD, to the /dev/null driver.  As with all of the
>>> /dev/null functionality, the implementation is just a simple sink
>>> where commands go to die, but it should be useful for developers who
>>> need a simple IORING_OP_URING_CMD test device that doesn't require
>>> any special hardware.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  drivers/char/mem.c |    6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
>>> index 84ca98ed1dad..32a932a065a6 100644
>>> --- a/drivers/char/mem.c
>>> +++ b/drivers/char/mem.c
>>> @@ -480,6 +480,11 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
>>>       return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_null);
>>>  }
>>>
>>> +static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
>>> +{
>>> +     return 0;
>>> +}
>>
>> This would be better as:
>>
>>         return IOU_OK;
>>
>> using the proper return values for the uring_cmd hook.
> 
> The only problem I see with that is that IOU_OK is defined under
> io_uring/io_uring.h and not include/linux/io_uring.h so the #include
> macro is kinda ugly:
> 
>   #include "../../io_uring/io_uring.h"
> 
> I'm not sure I want to submit that upstream looking like that.  Are
> you okay with leaving the return code as 0 for now and changing it at
> a later date?  I'm trying to keep this patchset relatively small since
> we are in the -rcX stage, but if you're okay with a simple cut-n-paste
> of the enum to linux/io_uring.h I can do that.

Ugh yes, that should move into the general domain. Yeah I'm fine with it
as it is, we can fix that up (and them nvme as well) at a later point.

-- 
Jens Axboe
