Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C71ECAAD1
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 12:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHaMH6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHaMH5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 08:07:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B243301
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 05:07:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c7so11324304wrp.11
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc;
        bh=yQgekfceYjMF2aInmQTGRgjV/jX9aMGmFw1CL0ltm8Q=;
        b=lR0iuCnn5yzdr8+p0a9ZwI7glDMK3rP3GfatUXAAzKUgjoMGYIP8cuLALog2RhWbmt
         XoXHAdGFN3nq/bgXxpPSrN1KScLc9c9/yPJHVRT+L/OssOb9E07VWAJVWl+LcFzJPt/V
         h19xMrqkJfKW8+2HTPHiGymrkceTalZ1VpjtB49kr0pQDYJxOctcInnq7eKN86y+t+wQ
         dqb0PAzN6PVOF2oSxJCPeTwcQCsK+u56pnnNEGG1wdgth67wUHqV47eABtvrj1ql4/pV
         OJLwJP5tJlf35Jp4MiS1zkXvmvv+s1aI6Hposi3KIHWcBNplN/Ar5IR1eNn/l45LvHJG
         3p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc;
        bh=yQgekfceYjMF2aInmQTGRgjV/jX9aMGmFw1CL0ltm8Q=;
        b=hvGUpcGmddlZynGjkBmYlpX0JdOWrNUIS/a8mo++hbIfcKpRKEcdYfwzP8IIC5pQdv
         qMCkgh2hQWQCZk0ad57aG3826JmQFTSFmWSAbfRTPcSuCz4jmyXARdcSZAZlg/yQC8Z6
         5dG3lkUHioXjH8nN15blxEAEQFcqtOLRWGc1+pnszEIKnyeWSy8nuGnZFKpGdRJOF9/v
         SKFyxGHoxGCyi2WY1ajH257eqGosn01mydY144UnbefJvpzVr7BhorLYRrPkcwqfdJUH
         DnlhqAjzYCykypjP3UN5yAFtgmgCcAHeHUZwts9+IJHaiyf6Hlep0YmXfqnVPEHv4gXY
         rCaQ==
X-Gm-Message-State: ACgBeo1z6PwMNtfDnzLKpgZWyZCsY0C5h47YNSfV43Fi/daUD2IBOkfj
        FqjE7vxTWAmHBZrb0yuSHX8sdIyEMAU=
X-Google-Smtp-Source: AA6agR4P+lgAi1cpSkBCJImprvQ0C1gNLiY4wBSZ67KTEKw9cn8Tkmf7bUJpMwOai8N4KtT7uLJwzQ==
X-Received: by 2002:adf:d1c7:0:b0:226:ee75:3e73 with SMTP id b7-20020adfd1c7000000b00226ee753e73mr1143773wrd.239.1661947674924;
        Wed, 31 Aug 2022 05:07:54 -0700 (PDT)
Received: from ?IPV6:2001:4ca0:2308:627:d6a5:eea1:87d2:d975? ([2001:4ca0:2308:627:d6a5:eea1:87d2:d975])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003a62052053csm2617742wms.18.2022.08.31.05.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 05:07:54 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <b55846e5-0935-dd7b-d860-55284911cfc2@gmail.com>
Date:   Wed, 31 Aug 2022 14:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/3] secilc/docs: selinuxuser actually takes a string not
 identifier
To:     James Carter <jwcart2@gmail.com>, bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <4ad30dd7-ec19-e88a-848e-98de8af7a16b@gmail.com>
 <CAP+JOzS82HOzmEKbeofQGgWhf4mk76ywJ-2ogqYBJ4T_k29w_w@mail.gmail.com>
 <CAP+JOzQdPcAftPtqQ7+1Kma2d1P1MGy7bHo2xxh2jpaD3CD0aw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP+JOzQdPcAftPtqQ7+1Kma2d1P1MGy7bHo2xxh2jpaD3CD0aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/31/22 13:56, James Carter wrote:
> On Tue, Aug 30, 2022 at 4:45 PM James Carter <jwcart2@gmail.com> wrote:
>>
>> I don't see this behavior.
>>
>> The following:
>> (block b2
>>    (user user2_u)
>>    (userrole user2_u ROLE)
>>    (userlevel user2_u (SENS))
>>    (userrange user2_u ((SENS) (SENS (CAT))))
>>    (userprefix user2_u user2)
>>    (selinuxuser name2 user2_u ((SENS) (SENS (CAT))))
>> )
>> Gives me:
>> name2:b2.user2_u:SENS-SENS:CAT
>>
>> It works with quotes as well, but it doesn't require them.
>>
>> The following:
>> (block b3
>>    (user user3_u)
>>    (userrole user3_u ROLE)
>>    (userlevel user3_u (SENS))
>>    (userrange user3_u ((SENS) (SENS (CAT))))
>>    (userprefix user3_u user3)
>>    (selinuxuser "name3" "user3_u" ((SENS) (SENS (CAT))))
>> )
>> Gives me:
>> name3:b3.user3_u:SENS-SENS:CAT
>>
>> Thanks,
>> Jim
> 
> Attached is the policy I used to test and a program that calls
> cil_selinuxusers_to_string().
> Jim

Thanks, I'll take another look at this some time.
Obviously the other patches can be merged independently.

-- 
bauen1

