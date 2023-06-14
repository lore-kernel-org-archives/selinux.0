Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8230CEB64D8
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjFNRJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjFNRJp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 13:09:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF7E69
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 10:09:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so9019244e87.3
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686762580; x=1689354580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opSG0sDFbb1EoDt+R9Toy09C8g0ARKTLn69THxFkX7Y=;
        b=On2jS/0dSfzn7KfNy1cgDbWvHbGDiOC3fsCSwS49l1OhntjBKXARqZMCPtRjPYBW4R
         9Ao4rJtmY+zoOwpv2ZaRdUB4qXBcwn/5KcCttB+wl2vGcnROP4txFggZcaQrQJqbfYY6
         kfzVhmiiAa35L+/iCndHFi8u27Ou144grzPljbjUXDcFxHif3+LYBDREkNgTw19OPRqc
         AjHhicnhx0rE5zkBLLAA3HgQ96EbZaCh3vMBbFJcjAIHHFVq+iYTdN7ev92lbKPAasNf
         R5dJqiWqcPN8LKqY5H853GeeQSwZzL6kz0OV/xUcfuRfSpMg9deansmpK3ZjJl9r8wls
         jAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686762580; x=1689354580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opSG0sDFbb1EoDt+R9Toy09C8g0ARKTLn69THxFkX7Y=;
        b=Wk84Ru114x5/FE9YdIOCewgXlo/2kmE+jS5pfgPOg7tRqfREoKj8BvPbxPhC1y+vYi
         Q/pkKV46h7jkfq3BXjoKgtJSZ8MJKNOoacmYdpfqVnk9ga3sQ8I1QtSr1Pe0x8iSAVTe
         HMYHgurkYgmMJ9oywtbq/U08mDNllpymK/WcfhH3vX1RCPk15cFK6AmYt4O0UrL6VnWe
         iwWJMM2p6wyw2gkYBzn685wYusxGEDx/wn8vC+YqIP7HqCU7ntW9lzDes03ICfOleFp4
         RPyAjpCI8XjuTunA4Gnsg22Z1ntIUI5t5Sq3qFCE+tx3BVKTuwD1LAdTfyz8a8Uy2xUU
         Fj2A==
X-Gm-Message-State: AC+VfDxrxqFQ+/eWFEMXkj/KXDiGlUxRPhAVKDH3dJgqCkp4e+roi3sr
        weJkGYAQ9lIKUZc2dKVcF8GlBo1Hed0=
X-Google-Smtp-Source: ACHHUZ6dz4HdxmnKDzrotc4mzBLoVtEVwcXW9H7zBIYhb9rbp8pEpl+AYAe8BYd7NRWO2/4qnYrR5A==
X-Received: by 2002:a19:ca5d:0:b0:4f8:3b15:b879 with SMTP id h29-20020a19ca5d000000b004f83b15b879mr7066lfj.63.1686762580035;
        Wed, 14 Jun 2023 10:09:40 -0700 (PDT)
Received: from [192.168.1.13] (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id d29-20020ac25edd000000b004e83fbba141sm1497215lfq.164.2023.06.14.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 10:09:39 -0700 (PDT)
Message-ID: <4681ff7d-e10f-e57c-01a0-8d95a9dcc8d9@gmail.com>
Date:   Wed, 14 Jun 2023 20:09:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] semanage, sepolicy: list also ports not attributed
 with port_type
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20230613180756.12978-1-toiwoton@gmail.com>
 <87bkhinyxa.fsf@redhat.com>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <87bkhinyxa.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 14.6.2023 13.03, Petr Lautrbach wrote:
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
>> v3: use even better version, thanks to Petr Lautrbach
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
>>   __get_all_domains () {
>>       seinfo -adomain -x 2>/dev/null | tail -n +2
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index d82da494..323aae3f 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
>>       def __init__(self, args = None):
>>           semanageRecords.__init__(self, args)
>>           try:
>> -            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>> +            self.valid_types = [x["type"] for x in sepolicy.info(sepolicy.PORT)]
>>           except RuntimeError:
>>               pass
> 
> It looked good to me but I was getting different number of types when I
> searched for `port_type` attribute method and for `portcon` (seinfo
> --portcon).
> 
> So I compared lists and checked differences and it turned out that this
> would break using `semanage port -a ...` for all policies based on
> refpolicy.
> 
> In refpolicy there are types with `port_type` attribute but without any
> `portcon` statement, see this commit
> https://github.com/SELinuxProject/refpolicy/commit/a108d9db60747a887f626b99cce37738462dd3cd
> 
> SELinux notebook uses `port_type` attribute too -
> https://github.com/SELinuxProject/selinux-notebook/blob/main/src/network_support.md#socket-controls-access-control-for-network-ports
> 
> I.e. using this change it would not be possible to add a new port mapping for
> types like `stunnel_port_t`:
> 
>      # seinfo -aport_type -x | grep stunnel
>          stunnel_port_t
> 
>      # semanage port -a -t stunnel_port_t -p tcp 12345
>      ValueError: Type stunnel_port_t is invalid, must be a port type

Perhaps both plain types attributed with `port_type` and actual portcon 
types could be considered? Then the tools should work with refpolicy and 
custom policies.

-Topi

> 
> 
> Thanks,
> 
> Petr
> 
> 
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
>>   __get_all_domain_types () {
>>       seinfo -adomain -x 2> /dev/null | tail -n +2
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index c177cdfc..9d3b640b 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -989,7 +989,7 @@ def get_all_port_types():
>>       global port_types
>>       if port_types:
>>           return port_types
>> -    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
>> +    port_types = [x["type"] for x in info(PORT)]
>>       return port_types
>>   
>>   
>> -- 
>> 2.39.2
> 

