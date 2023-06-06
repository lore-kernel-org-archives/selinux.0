Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BCC77B73
	for <selinux@archiver.kernel.org>; Tue,  6 Jun 2023 16:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjFFQV0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjFFQVZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jun 2023 12:21:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4E11F
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 09:21:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so1280920e87.0
        for <selinux@vger.kernel.org>; Tue, 06 Jun 2023 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686068481; x=1688660481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=korMQ2tMKidj34SDcSpO3jr10OplbsnO+GXTIgzcWUc=;
        b=njbPbuK9cwZZkIVNi71nTiqXzO9z7Rgm3bjEorBk9kl9r7SyZI1W/N7paBeRsQi7Qc
         e8G2wwn2gbfKDNZbUGBSilExq9HaQOu0KXatT2xLvxFz4A0yU7wMKYLF1ExYg+6FgWp9
         lqxV/ThmsYmhY2TttRr9rjLJPvhIrXb7MrOOFwZ0ofDs7rL1DgH9BclPBqlQdkrXtGPF
         uu05K33p8a/VQDoYMhSLonuStqIL8ibYfTnbDfQjoPeVL3R2MBiV6+l6ROvNBoHMiCaj
         f2v3tNUkHOwSgZNHr8DN4myRxs1o1aakJb31xQHzUOrD0ycqsCqeIves4tOPcRQDT0ir
         HCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686068481; x=1688660481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=korMQ2tMKidj34SDcSpO3jr10OplbsnO+GXTIgzcWUc=;
        b=GiPnivxBZF6HYamig0R59T3jsK+czq3oM0k2qzsNppZ84SmsP3XoQ/4SHMNt+7whDN
         Ng6W5JOkL/pPdgjJkcDI/BYfDGcrPJxAOYvOmy3LwhRcCuww48iU0JRaCfAA3RTHZAwh
         LSSTWC1gY3N+a+GHe/AaAAtHRHSCfRD1U4gyPAKUguM5NJ4xtkUjwHFGPAp4BX86r7SR
         63ZkzYdo8bpZKEFR0a011XdiPbYA+uWSti2aHq3gcfHp4XzCgzJzhMlYOfZyV2bi5muj
         7gyt0ajx3knFrkHjhK6AocSG+47FxBzK3ysJJb+8CL9JiL4bz5FNUafIusZmhjCZOHrB
         K09w==
X-Gm-Message-State: AC+VfDwuqvYJEBkFX+L6n2ptlWGJByqvzHXltsW/km1yYc4tnVDZo/qO
        Y5yKWj13ItrCoBbTPi9ip9ULtcuFNcA=
X-Google-Smtp-Source: ACHHUZ6s5YQ+/q5yu/jod2cfMPkwPNVyNYSBi/KnQWUyK/S9HE4XMd7n9VQvUZzUB0j3aUqybzFJhQ==
X-Received: by 2002:ac2:5637:0:b0:4f6:133e:a0e7 with SMTP id b23-20020ac25637000000b004f6133ea0e7mr983526lff.24.1686068481160;
        Tue, 06 Jun 2023 09:21:21 -0700 (PDT)
Received: from [192.168.1.13] (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id r23-20020ac24d17000000b004f4b0f20f1fsm1526438lfi.281.2023.06.06.09.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:21:20 -0700 (PDT)
Message-ID: <e31e4cd7-fa14-d30a-2acc-60a720132c92@gmail.com>
Date:   Tue, 6 Jun 2023 19:21:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] semanage, sepolicy: list also ports not attributed
 with port_type
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20230602190720.12623-1-toiwoton@gmail.com>
 <87o7lsj4ey.fsf@redhat.com>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <87o7lsj4ey.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6.6.2023 13.01, Petr Lautrbach wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> For `semanage port -l` and `sepolicy network -t type`, show also ports
>> which are not attributed with `port_type`. Such ports may exist in
>> custom policies and even the attribute `port_type` may not be defined.
>>
>> This fixes the following error with `semanage port -l` (and similar
>> error with `sepolicy network -t type`):
>>
>> Traceback (most recent call last):
>>    File "/usr/sbin/semanage", line 975, in <module>
>>      do_parser()
>>    File "/usr/sbin/semanage", line 947, in do_parser
>>      args.func(args)
>>    File "/usr/sbin/semanage", line 441, in handlePort
>>      OBJECT = object_dict['port'](args)
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^
>>    File "/usr/lib/python3/dist-packages/seobject.py", line 1057, in __init__
>>      self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>>                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^
>> IndexError: list index out of range
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>
>> ---
>>
>> v2: fix other cases and use better version courtesy of Petr Lautrbach
>> ---
>>   python/semanage/semanage-bash-completion.sh | 2 +-
>>   python/semanage/seobject.py                 | 2 +-
>>   python/sepolicy/sepolicy-bash-completion.sh | 2 +-
>>   python/sepolicy/sepolicy/__init__.py        | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
>> index d0dd139f..1e3f6f9d 100644
>> --- a/python/semanage/semanage-bash-completion.sh
>> +++ b/python/semanage/semanage-bash-completion.sh
>> @@ -37,7 +37,7 @@ __get_all_types () {
>>       seinfo -t 2> /dev/null | tail -n +3
>>   }
>>   __get_all_port_types () {
>> -    seinfo -aport_type -x 2>/dev/null | tail -n +2
>> +    sepolicy network -l
>>   }
> 
> I support this change but it could have a side effect on distributions.
> E.g. in Fedora we ship semanage bash completion in
> policycoreutils-python-utils while sepolicy in policycoreutils-devel. On
> the other hand seinfo is in setools-console package which is not required by
> policycoreutils-python-utils so completions would not work anyway.
> 
>  From upstream POV, it improves the situation so unless there's any other
> objection from other distribution maintainers I would not block it..

If you prefer, it's also possible to continue to use seinfo with:

seinfo --portcon 2>/dev/null | sed -n 
's/^\s\+portcon\s\+\S\+\s\+\S\+\s\+[^:]\+:[^:]\+:\([^:]\+\):\S\+$/\1/gp'

>>   __get_all_domains () {
>>       seinfo -adomain -x 2>/dev/null | tail -n +2
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index d82da494..21a6fc91 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
>>       def __init__(self, args = None):
>>           semanageRecords.__init__(self, args)
>>           try:
>> -            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>> +            self.valid_types = [x["type"] for x in list(list(sepolicy.info(sepolicy.PORT)))]
> 
> I know it's suggested by me. But looking on to it I see repeating list()
> which is unnecessary. sepolicy.info() returns a generator and so the new
> list could be constructed directly from it:
> 
> [x["type"] for x in sepolicy.info(sepolicy.PORT)]

Thanks!

> 
> 
>>           except RuntimeError:
>>               pass
>>   
>> diff --git a/python/sepolicy/sepolicy-bash-completion.sh b/python/sepolicy/sepolicy-bash-completion.sh
>> index 13638e4d..467333b8 100644
>> --- a/python/sepolicy/sepolicy-bash-completion.sh
>> +++ b/python/sepolicy/sepolicy-bash-completion.sh
>> @@ -52,7 +52,7 @@ __get_all_classes () {
>>       seinfo -c 2> /dev/null | tail -n +2
>>   }
>>   __get_all_port_types () {
>> -    seinfo -aport_type -x 2> /dev/null | tail -n +2
>> +    sepolicy network -l
>>   }
> 
> Here the change does not have any side effect and improves the
> functionality

It's also possible to use the seinfo | sed version here too.

> 
>>   __get_all_domain_types () {
>>       seinfo -adomain -x 2> /dev/null | tail -n +2
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index c177cdfc..76ac7797 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -989,7 +989,7 @@ def get_all_port_types():
>>       global port_types
>>       if port_types:
>>           return port_types
>> -    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
>> +    port_types = [x["type"] for x in list(list(info(PORT)))]
> 
> [x["type"] for x in info(PORT)]
> 
>>       return port_types
>>   
>>   
>> -- 
>> 2.39.2
> 

