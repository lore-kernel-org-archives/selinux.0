Return-Path: <SRS0=6fGn=ZA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE72C5DF60
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CC021D6C
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 08:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfKHIga (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:36:30 -0500
Received: from air.basealt.ru ([194.107.17.39]:55252 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfKHIga (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 8 Nov 2019 03:36:30 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 03:36:28 EST
Received: by air.basealt.ru (Postfix, from userid 490)
        id 351CE589B34; Fri,  8 Nov 2019 08:29:09 +0000 (UTC)
Received: from olesya.ipa.basealt.ru (obninsk.basealt.ru [217.15.195.17])
        by air.basealt.ru (Postfix) with ESMTPSA id 77545589B2C;
        Fri,  8 Nov 2019 08:29:06 +0000 (UTC)
Subject: Re: [PATCH] Replace www.nsa.gov references by
 github.com/SELinuxProject
To:     Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Aleksei Nikiforov <darktemplar@basealt.ru>
Cc:     selinux@vger.kernel.org
References: <20191106163043.1081424-1-plautrba@redhat.com>
 <b88fa654-dd3d-e9be-201c-718c31a74254@tycho.nsa.gov>
 <pjdsgmyeqom.fsf@redhat.com>
From:   Olesya Gerasimenko <gammaray@basealt.ru>
Message-ID: <d6e4ed26-3c01-0156-1ee1-5bca4661bdb3@basealt.ru>
Date:   Fri, 8 Nov 2019 11:29:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <pjdsgmyeqom.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

 > Aleksei, Olesya, could you please review changes in ru file in this 
patch?
 > https://patchwork.kernel.org/patch/11230695/

I think these are reasonable changes.


08.11.2019 11:08, Petr Lautrbach пишет:
> 
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 11/6/19 11:30 AM, Petr Lautrbach wrote:
>>> The original page doesn't exist anymore.
>>>
>>> Fixes: https://github.com/SELinuxProject/selinux/issues/170
>>
>> No objections although I can't verify the ru files myself aside from the URL
>> matching.
> 
> Aleksei, Olesya, could you please review changes in ru file in this patch?
> https://patchwork.kernel.org/patch/11230695/
> 
> 
>> I suppose someone might object on the grounds that SELinux can be
>> used with policies other than refpolicy, but the only other potential references
>> I can think of would be the SELinux Notebook or SELinux by Example.  Or we could
>> just drop the text and URLs altogether and only list other man pages under the
>> SEE ALSO sections.
> 
> 
> The most distributions use policies based on the reference policy and
> those who use their own policy probably started with refpolicy as well.
> 
> 
>>>
>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>> ---
>>>    checkpolicy/checkmodule.8        | 3 +--
>>>    checkpolicy/checkpolicy.8        | 3 +--
>>>    checkpolicy/ru/checkmodule.8     | 3 +--
>>>    checkpolicy/ru/checkpolicy.8     | 4 +---
>>>    libselinux/man/man8/selinux.8    | 2 +-
>>>    libselinux/man/ru/man8/selinux.8 | 2 +-
>>>    python/sepolgen/HACKING          | 2 --
>>>    7 files changed, 6 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
>>> index e55582f3..e597d9d4 100644
>>> --- a/checkpolicy/checkmodule.8
>>> +++ b/checkpolicy/checkmodule.8
>>> @@ -59,8 +59,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
>>>      .SH "SEE ALSO"
>>>    .B semodule(8), semodule_package(8)
>>> -SELinux documentation at http://www.nsa.gov/research/selinux,
>>> -especially "Configuring the SELinux Policy".
>>> +SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
>>>        .SH AUTHOR
>>> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
>>> index bdfd6acd..97e10ca7 100644
>>> --- a/checkpolicy/checkpolicy.8
>>> +++ b/checkpolicy/checkpolicy.8
>>> @@ -60,8 +60,7 @@ Show version information.
>>>    Show usage information.
>>>      .SH "SEE ALSO"
>>> -SELinux documentation at http://www.nsa.gov/research/selinux,
>>> -especially "Configuring the SELinux Policy".
>>> +SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
>>>        .SH AUTHOR
>>> diff --git a/checkpolicy/ru/checkmodule.8 b/checkpolicy/ru/checkmodule.8
>>> index 93e68e70..a1d687e3 100644
>>> --- a/checkpolicy/ru/checkmodule.8
>>> +++ b/checkpolicy/ru/checkmodule.8
>>> @@ -46,8 +46,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
>>>      .SH "СМОТРИТЕ ТАКЖЕ"
>>>    .B semodule(8), semodule_package(8)
>>> -Документация SELinux по адресу http://www.nsa.gov/research/selinux,
>>> -в частности - "Настройка политики SELinux".
>>> +Документация SELinux Reference Policy по адресу https://github.com/SELinuxProject/refpolicy/wiki
>>>        .SH АВТОРЫ
>>> diff --git a/checkpolicy/ru/checkpolicy.8 b/checkpolicy/ru/checkpolicy.8
>>> index 2ad39b8e..25b0e555 100644
>>> --- a/checkpolicy/ru/checkpolicy.8
>>> +++ b/checkpolicy/ru/checkpolicy.8
>>> @@ -51,9 +51,7 @@ checkpolicy \- компилятор политики SELinux
>>>    Показать сведения об использовании.
>>>      .SH "СМОТРИТЕ ТАКЖЕ"
>>> -Документация SELinux по адресу http://www.nsa.gov/research/selinux,
>>> -в частности - "Настройка политики SELinux".
>>> -
>>> +Документация SELinux Reference Policy по адресу https://github.com/SELinuxProject/refpolicy/wiki
>>>      .SH АВТОРЫ
>>>    Эта страница руководства была написана Arpad Magosanyi <mag@bunuel.tii.matav.hu>,
>>> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
>>> index e37aee68..31364271 100644
>>> --- a/libselinux/man/man8/selinux.8
>>> +++ b/libselinux/man/man8/selinux.8
>>> @@ -10,7 +10,7 @@ enforcement of many kinds of mandatory access control policies,
>>>    including those based on the concepts of Type Enforcement®, Role-
>>>    Based Access Control, and Multi-Level Security.  Background
>>>    information and technical documentation about SELinux can be found at
>>> -http://www.nsa.gov/research/selinux.
>>> +https://github.com/SELinuxProject.
>>>      The
>>>    .I /etc/selinux/config
>>> diff --git a/libselinux/man/ru/man8/selinux.8 b/libselinux/man/ru/man8/selinux.8
>>> index 5cc48df8..271809de 100644
>>> --- a/libselinux/man/ru/man8/selinux.8
>>> +++ b/libselinux/man/ru/man8/selinux.8
>>> @@ -9,7 +9,7 @@ Linux с улучшенной безопасностью от NSA - это ре
>>>    включая основанные на концепциях Type Enforcement® (принудительное присвоение типов),
>>>    Role-Based Access Control (управление доступом на основе ролей) и Multi-Level Security
>>>    (многоуровневая безопасность). Дополнительная информация и техническая документация по
>>> -SELinux доступна по адресу http://www.nsa.gov/research/selinux.
>>> +SELinux доступна по адресу https://github.com/SELinuxProject.
>>>      Файл конфигурации
>>>    .I /etc/selinux/config
>>> diff --git a/python/sepolgen/HACKING b/python/sepolgen/HACKING
>>> index e624a1b4..f7d07774 100644
>>> --- a/python/sepolgen/HACKING
>>> +++ b/python/sepolgen/HACKING
>>> @@ -75,5 +75,3 @@ Information about the SELinux object classes. This is semantic
>>>    information about the object classes - including information flow. It
>>>    is separated to keep the core from being concerned about the details
>>>    of the object classes.
>>> -
>>> -[selist]: http://www.nsa.gov/research/selinux/info/list.cfm
>>>
> 
> 

-- 
Best regards,
Olesya Gerasimenko (Basealt Translation Team)
