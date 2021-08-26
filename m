Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30069C432BE
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 14:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103E560FDA
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhHZOrH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242881AbhHZOrA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Aug 2021 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629989169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiTnS35HHpK6EoJa8yAFTwPuxAryXLcpY9MIQxaG1hA=;
        b=RoT0rnf6ZW3Egfkd9+ft4CsNxMGgU53s9X6cfRvw2NuJE+jxalzHDYAHGa8toy83TqRME3
        ES3mSqqdyFgXBvFT716GwUxKlLi6R9Fs9Fx8XBuTyiPt1HTfIE/yUg4SGiSx7ImYaRuLSY
        b2Fn41iS4Q8xJJa5rIWYoZx7ak5gw3w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-y5MWUjxBNOOvQkih8JDwvQ-1; Thu, 26 Aug 2021 10:46:08 -0400
X-MC-Unique: y5MWUjxBNOOvQkih8JDwvQ-1
Received: by mail-ed1-f69.google.com with SMTP id i17-20020aa7c711000000b003c57b06a2caso1608423edq.20
        for <selinux@vger.kernel.org>; Thu, 26 Aug 2021 07:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TiTnS35HHpK6EoJa8yAFTwPuxAryXLcpY9MIQxaG1hA=;
        b=fo7DtHRjvkrTDRd+SkCwXzMoiKpkkhjAT+buBQeJn96Y2tETp1ZjPC6XA7Nh0PL1K7
         IR2COzuiWenERU6E5Uuxf5+lx3zpJtpgLxqxoI4zADFDbtYp7ABZuDRd/BOqqOWZQnEo
         8Sx5AwQYudjpYBhPO4AfWujDsChdGt/JuieexzNag5dGm95T7ic9PyxZLQhCR8sC9HnK
         69eo25IPVtPB4KAOJyIeqHdIZYOuxxPGV0IcKAsGX/VjdMuv5niTE2BI92OJ1MV9Slbq
         4z2KV4s5Gsno7F4mrUJdDA3Blx4980fis7gCEgOsIOBq2rIcPSL0mEEd/wBermCO8pCK
         hqqA==
X-Gm-Message-State: AOAM531l2hhE48yyqt+praePSnvl4gfFFeC4+A1Kf9SQriY5dFCQUT9I
        BUF1xESk9GCJmjfsDdWFe5to2gkP9vCUHXl5TJZ/lU3ku1DNMrLuuigK1cCN1Hi5+9+N9Smlufo
        zQttqssg4ztg4RCYXGw==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr4668442edc.21.1629989166759;
        Thu, 26 Aug 2021 07:46:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx75fP0RMpzJZq5o3D6OP5aeFoAo6VUmns2cORwqPpkNlejp4igslH4QY5B14cW/g3RtftVWA==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr4668426edc.21.1629989166572;
        Thu, 26 Aug 2021 07:46:06 -0700 (PDT)
Received: from [192.168.0.108] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id j9sm1535241ejk.112.2021.08.26.07.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 07:46:06 -0700 (PDT)
Subject: Re: Cil block inheritance
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org, Lukas Vrabec <lvrabec@redhat.com>
References: <81ea2624-ace9-4d86-9506-d6527a770cf6@redhat.com>
 <877dg8l83w.fsf@defensec.nl>
 <ce82e933-ceb8-a293-c57e-6dd6f8c31254@redhat.com>
 <8735qwl4tz.fsf@defensec.nl>
From:   Vit Mojzis <vmojzis@redhat.com>
Message-ID: <6da674c8-dd15-6688-82dd-ce606a89e014@redhat.com>
Date:   Thu, 26 Aug 2021 16:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8735qwl4tz.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 26. 08. 21 15:21, Dominick Grift wrote:
> Vit Mojzis <vmojzis@redhat.com> writes:
>
>> On 26. 08. 21 14:10, Dominick Grift wrote:
>>> Vit Mojzis <vmojzis@redhat.com> writes:
>>>
>>>> Hi,
>>>> recent changes in block inheritance broke our use case where we use
>>>> block inheritance for generating container policies
>>>> (https://github.com/containers/udica/tree/main/udica/templates). Basically
>>>> the policy is composed by inheriting selected "template" blocks, all
>>>> of which inherit "container" block, so that they can use types defined
>>>> there.
>>>>
>>>> Reproducer:
>>>> (block template1 (type t) )
>>>> (block template2 (blockinherit template1))
>>>> (block b (blockinherit template1) (blockinherit template2))
>>> In this example there is no point in inheriting template1, because
>>> template2 already inherits it.
>>>
>>> (block template1
>>>          (type t))
>>> (block template2
>>>          (blockinherit template1))
>>> (block b (blockinherit template2)
>>>          (allow t t (file (read))))
>>>
>>> semodule -i test.cil
>>> seinfo -t b.t
>> Sure, but with more templates (as we have in udica) we get the same issue.
>>
>> (block template1 (type t) )
>> (block template2 (blockinherit template1))
>> (block template3 (blockinherit template1))
>> (block b (blockinherit template2) (blockinherit template3))
> This boils down to the same as above, yes.
>
>> # semodule -i test.cil
>> Re-declaration of type t
>> Previous declaration of type at /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
>> Failed to copy block contents into blockinherit
>> Failed to resolve AST
>> semodule:  Failed!
>>
>>
>> Template2 and template3 mostly inherit template1 for the type defined
>> there (so that they can define rules containing the type).
>>
>>>> #semodule -i test.cil
>>>> Re-declaration of type t
>>>> Previous declaration of type at
>>>> /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
>>>> Failed to copy block contents into blockinherit
>>>> Failed to resolve AST
>>>> semodule: Failed!
>>>>
>>>> This used to work just fine.
>>>>
>>>> The following workaround seems to be working as intended, but I'm not
>>>> sure if it's the best approach. Types are only defined in template1
>>>> and the rest contains "optional" block, so that I can use types
>>>> defined in template1).
>>>>
>>>> (block template1 (type t))
>>>> (block template2
>>>>        (optional o
>>>>            (allow t t ( file ( read )))
>>>>        )
>>>> )
>>>> (block b (blockinherit template1) (blockinherit template2))
>>> You can just do something like this:
>>>
>>> (block template1 (type t))
>>> (block template2 (blockinherit template1) (optional o (allow t t (file
>>> (read))))
>>> (block b (blockinherit template2))
>>> semodule -i test.cil
>>> sesearch -A -t b.t
>> With more templates, this break as well.
>>
>> But the following works:
>>
>> (block template1 (type t))
>> (block template2 (optional o (allow t t (file (read)))))
>> (block template3 (optional o (allow t t (file (write)))))
>> (block b (blockinherit template1) (blockinherit template2) (blockinherit template3))
>>
>> #semodule -i test.cil
>> #sesearch -A -s b.t
>> allow b.t b.t:file { read write };
>>
>> Again, I'm not sure if this is the best solution, just the only one I managed to get working.
> Looks good enough to me (if it works then it works). I am just surprised that
> the duplicate 'o' optional block is allowed.
Thanks, I'll use different names for the optional blocks just to be sure.

>
> Duplicate type declarations are no longer allowed as you noticed, but
> fortunately you do not need them.
>
> Whether this eventually is the best solution probably depends on other
> aspects of the policy and on the requirements.
Sure, I guess I just needed to know that I'm not doing something wrong.
Thank you.

Vit

>
>> Vit
>>
>>>> #semodule -i test.cil
>>>> #sesearch -A -s b.t
>>>> allow b.t b.t:file read;
>>>>
>>>> Any pointers would be appreciated.
>>>>
>>>> Thank you.
>>>>
>>>> Vit
>>>>

