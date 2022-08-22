Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C34C3F6B0
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 23:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiHVXZr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHVXZq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 19:25:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF2558CA
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 16:25:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y4so11302355plb.2
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gh1Oz9Hp1EIP/vEkDFpXrwyNYZdeHjPHmqPuWfBzxgo=;
        b=GmLX52bILLwFGUaHgqI+KcujjbB/PXEdKx1EMxbBC20nWp8YnN0MsoXehq7gzeRDhT
         K55UcfFR21FacL7QEJ0x4fQrAM9z/pqfHyH9LcYLUhdBOXUIJfI2Dq2W+UplJ06Ke3aF
         atLmMJxbyNBwXiRqDGWrfDH3PgtiY/wch8SGcAcOHykANTvPKGVAnltWoQU0wJsIioQb
         deH/j5i2ZqD0t1hfXdlhFuu7HsglqgOqeE2jDmhE02xXMH2uyes4j4W3dX0jPlPNgPAs
         axI4+zhd9231AAVGyfMdjH3Z6mDbtir+IP/1OMGO/91SXVMI/6sl4M6T8qeHHrauiJUr
         QpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gh1Oz9Hp1EIP/vEkDFpXrwyNYZdeHjPHmqPuWfBzxgo=;
        b=OrCdsdkZFyjjsJg1wYaIuRfximHxur0C3CDaVMC+NyPOweUgs+Zoa3KxD/UQcBsxPs
         RnEwv66+3yG2y24iGCmuvv5O055q4BjB5a7H4+PmLsxa/Na9p71oYvVx20J2IhuXg7K/
         maa67dMFhtOsoFPEGPb2a1KnED4oAxDcXkrjv+PGQkT/UgqxLbgsG7B5xeM82iJnN5AG
         Slm/B0KioiTev8hJQGKNiR4PONKMSAO/RYoHqpASHxxn7ScVyUSdRqHHHPh7UOrxUv0z
         9H8KaHYumZmPV9WKK3KlTuNJcf/XdqYNEHB/7TwMgny83fvqGe5tWLv7pN3/J9HvUNNk
         1xxQ==
X-Gm-Message-State: ACgBeo0KhceMCkvXLUH97zLKlO+cxnimPvvTPogldF5X6xUIxwCO9N21
        1M7gzm/XXutHlIfc10auA/HAKg==
X-Google-Smtp-Source: AA6agR4/VePDPEQK9n1GpktNm94uZbfCFu/nqXDjEdktsb+M/gRjvfX6v+772rbmQPhgs+KpAPY14w==
X-Received: by 2002:a17:902:8502:b0:16c:c5c5:a198 with SMTP id bj2-20020a170902850200b0016cc5c5a198mr21808137plb.88.1661210744670;
        Mon, 22 Aug 2022 16:25:44 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id rt12-20020a17090b508c00b001f334aa9170sm10581481pjb.48.2022.08.22.16.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 16:25:42 -0700 (PDT)
Message-ID: <73022e0f-4913-2620-605d-ad86d8b73494@kernel.dk>
Date:   Mon, 22 Aug 2022 17:25:41 -0600
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
 <1017959d-7ec0-4230-89db-b077067692d1@kernel.dk>
 <CAHC9VhQw5V_aH=y2vSX4=f6fofc01w32c5gfediubVU=LCVJng@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhQw5V_aH=y2vSX4=f6fofc01w32c5gfediubVU=LCVJng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/22/22 5:19 PM, Paul Moore wrote:
> On Mon, Aug 22, 2022 at 7:13 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 8/22/22 5:09 PM, Paul Moore wrote:
>>> On Mon, Aug 22, 2022 at 6:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 8/22/22 3:21 PM, Paul Moore wrote:
>>>>> This patch adds support for the io_uring command pass through, aka
>>>>> IORING_OP_URING_CMD, to the /dev/null driver.  As with all of the
>>>>> /dev/null functionality, the implementation is just a simple sink
>>>>> where commands go to die, but it should be useful for developers who
>>>>> need a simple IORING_OP_URING_CMD test device that doesn't require
>>>>> any special hardware.
>>>>>
>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>>> ---
>>>>>  drivers/char/mem.c |    6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
>>>>> index 84ca98ed1dad..32a932a065a6 100644
>>>>> --- a/drivers/char/mem.c
>>>>> +++ b/drivers/char/mem.c
>>>>> @@ -480,6 +480,11 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
>>>>>       return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_null);
>>>>>  }
>>>>>
>>>>> +static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
>>>>> +{
>>>>> +     return 0;
>>>>> +}
>>>>
>>>> This would be better as:
>>>>
>>>>         return IOU_OK;
>>>>
>>>> using the proper return values for the uring_cmd hook.
>>>
>>> The only problem I see with that is that IOU_OK is defined under
>>> io_uring/io_uring.h and not include/linux/io_uring.h so the #include
>>> macro is kinda ugly:
>>>
>>>   #include "../../io_uring/io_uring.h"
>>>
>>> I'm not sure I want to submit that upstream looking like that.  Are
>>> you okay with leaving the return code as 0 for now and changing it at
>>> a later date?  I'm trying to keep this patchset relatively small since
>>> we are in the -rcX stage, but if you're okay with a simple cut-n-paste
>>> of the enum to linux/io_uring.h I can do that.
>>
>> Ugh yes, that should move into the general domain. Yeah I'm fine with it
>> as it is, we can fix that up (and them nvme as well) at a later point.
> 
> Okay, sounds good, I'll leave it as-is.  Is it okay to still add your ACK?

Yep, all things considered, for 6.0 I think that's the way to go.

-- 
Jens Axboe


