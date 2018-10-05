Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9963C00449
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5020020875
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="cl36Fklc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5020020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJFCxh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:53:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43660 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeJFCxh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 22:53:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so15060930qtq.10
        for <selinux@vger.kernel.org>; Fri, 05 Oct 2018 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RQ+LFgL+EgyqKJkvEuIVIlP3g5KqapgrjtPEgmHkxtA=;
        b=cl36FklcQks+nKvgb195YCzdyOxdrNUeCfZd1x+T1Z/PHAUevQuXRjBYqBF3EamYAz
         3BVNq3cklHGlIdIPjNbG2+NbwsH8uUuPvEIpGlAKZaswcLf6vh24nvyU49yn2GK9b91U
         u0Cozf0H8qbuXw9AZB4l8TcM8ERk8pPhGyclo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQ+LFgL+EgyqKJkvEuIVIlP3g5KqapgrjtPEgmHkxtA=;
        b=NsDPpLNDbl9gg28RHwFuk/WZ5TF85oLXAR1HaKScJN5AOWnGNwKYArzUxYM3REQ2iL
         TQ2RfEOs7C++61Nrga8aXuFk7lT5NOUk4OW2161d6WFkX6GtBu2IiYBo8Cb1mAt10Sna
         2l86e6ijTrB2cAnwguuc4GHxt43g5gZBwRNx0fofwJFWq8f6fCnKgrXvTBm84se3QZ/0
         8Nc1TImm98vniueyRjK+7sMOxfkq/tJTW1MVUMpKWEuf8Jzqwr/bOUWARckBwiujwUZL
         GhUZcQpiCZQUUbTfHJnSIZNO8nSTRzZLgwyX/cxz+QAKbbGMgZhtAGv4XcH0YqwvFQu+
         OLcw==
X-Gm-Message-State: ABuFfoh3KJTEumbqHBXAhutl6TWsu6nCosBFNuzYznyxE/YlPf9rS5BV
        vLpRX0NTo7B1rirDO/jkH6VTciMLx6w=
X-Google-Smtp-Source: ACcGV63uywDwZq+FnDw/XAvCEFQn51s4GvaKQxsvAg27Mbvsb2NI2TeP7ehNCxBACwmefF4vblB1qg==
X-Received: by 2002:a0c:eac5:: with SMTP id y5-v6mr1933772qvp.161.1538769202322;
        Fri, 05 Oct 2018 12:53:22 -0700 (PDT)
Received: from [192.168.1.190] (pool-173-69-176-156.bltmmd.fios.verizon.net. [173.69.176.156])
        by smtp.gmail.com with ESMTPSA id o55-v6sm4902070qtk.58.2018.10.05.12.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:53:21 -0700 (PDT)
Subject: Re: [PATCH] libsemanage: improve semanage_migrate_store import
 failure
To:     Jason Zaman <jason@perfinion.com>,
        William Roberts <bill.c.roberts@gmail.com>
Cc:     selinux <selinux@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20181004194108.29485-1-yuli@crunchydata.com>
 <CAFftDdpNVByPh+fGgVbnd-hR_C=k7RtNM8GUVxLC2bftvfQjtg@mail.gmail.com>
 <20181005143239.GC3445@baraddur.perfinion.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <2b4b322c-c9ae-e12b-1119-02a4d0bfa732@ieee.org>
Date:   Fri, 5 Oct 2018 15:53:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005143239.GC3445@baraddur.perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/05/2018 10:32 AM, Jason Zaman wrote:
> On Fri, Oct 05, 2018 at 07:13:23AM -0700, William Roberts wrote:
>> On Thu, Oct 4, 2018 at 12:46 PM Yuli Khodorkovskiy <
>> yuli.khodorkovskiy@crunchydata.com> wrote:
>>
>>> The python module import error in semanage_migrate_store was misleading.
>>> Before, it would print that the module is not installed, even though
>>> it is in fact on the system.
>>>
>>> Now the python module import failure is correctly reported if the module
>>> is not installed or the exact reason for failure is reported to the user.
>>>
>>> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
>>> ---
>>>   libsemanage/utils/semanage_migrate_store | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/libsemanage/utils/semanage_migrate_store
>>> b/libsemanage/utils/semanage_migrate_store
>>> index 2e6cb278..50eb59ef 100755
>>> --- a/libsemanage/utils/semanage_migrate_store
>>> +++ b/libsemanage/utils/semanage_migrate_store
>>> @@ -15,10 +15,12 @@ sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
>>>   try:
>>>          import selinux
>>>          import semanage
>>> -except:
>>> +except ImportError:
>>>          print("You must install libselinux-python and libsemanage-python
>>> before running this tool", file=sys.stderr)
>>>          exit(1)
>>> -
>>> +except Exception as e:
>>> +       print("Failed to import libselinux-python/libsemanage-python: %s"
>>> % str(e))
>>> +       exit(1)
>>>
>>
>> We should really only be handling exceptions we reasonably expect and
>> discourage
>> the usage of catching raw Exception, especially considering not-catching
>> this will
>> cause the runtime to print a stack trace, the error and exit non-zero.
>>
>> We probably only need the except ImportError change and can drop the second
>> hunk.
>>
>> Does anyone disagree with this?

For this case, I agree that ImportError is the only thing that should be 
caught.

> Agreed. catching Exception is bad cuz it also catches KeyboardInterrupt
> and stuff like that.

That's not correct.  Catching BaseException would catch 
KeyboardInterrupt.  Catching Exception would not.  See the Python 
builtin exception hierarchy:

https://docs.python.org/3/library/exceptions.html#exception-hierarchy

IMO catching Exception has valid uses.

-- 
Chris PeBenito
