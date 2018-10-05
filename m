Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA897C00449
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 20:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5897E20875
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 20:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="AcwTGe0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5897E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJFDFb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:05:31 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39558 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeJFDFb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 23:05:31 -0400
Received: by mail-qt1-f179.google.com with SMTP id e22-v6so8070499qto.6
        for <selinux@vger.kernel.org>; Fri, 05 Oct 2018 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P3V7nPzsvziruO+nmugYp5O57/Ox1N28cZxJuY9G1IY=;
        b=AcwTGe0eHSOwAkZDEF6mv4qAs3TwbwMYbtFZYRyr7WFHq1wuxPUoZQ0AwG/UHw96qc
         Qe2VFXqsCM4CI6w+mOxgMk6NaDKTeXOpPGFyVNIuFH53kBbspLjuu0fFlPeCYvxvx6zP
         AdsT6p7a4EamLMwZcVcWC6PJ7u8sjdl7W5scM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P3V7nPzsvziruO+nmugYp5O57/Ox1N28cZxJuY9G1IY=;
        b=gqhUhAKLttdK9aQxFX+wEj4RuNmO+LMioSE5piOLLJwdKaGgIioBByZbXkbs83Ou3R
         BZ7pwRvnYYu7RTBF2zwwFNg1XG+isELX5lwa6WK50ser+YGYGNQKmemqQql1Dg/MuYoa
         v4DxrVw3UKTy2eQXJUU66uAWema7VmOLs5Syox7+chy3RQobZYuSJc4pj9b5W95syjv3
         WgUzrDtvu2zgIPB4mvYveiwBl91y6+XQOz2sdAi5CzPiQtBZ+JxBk5ug8zCq4qiOlvhf
         9pAOM5O0d2R9x5vNi3QZ11wH1VrnXdrMXc4MxSboqI7oJGA5V2xP6tF3J5kQqfwlrmnH
         mL9A==
X-Gm-Message-State: ABuFfoiwTnpIqSbiOf1kZCqzWqo6aYxUW5HusL8hh8L99vCiWXW8ZVpc
        5FXod9jS2PLn1/NQFwwhu0QJCAx6RGA=
X-Google-Smtp-Source: ACcGV60Xp3YFsJAHLn4QgIKvx1oODu1DAB5+Py31NaDcHss4v/8qcifWGJwiJbTqXohC4kH1zLnwyQ==
X-Received: by 2002:ac8:3775:: with SMTP id p50-v6mr10450320qtb.220.1538769914668;
        Fri, 05 Oct 2018 13:05:14 -0700 (PDT)
Received: from [192.168.1.190] (pool-173-69-176-156.bltmmd.fios.verizon.net. [173.69.176.156])
        by smtp.gmail.com with ESMTPSA id l5-v6sm3988351qte.20.2018.10.05.13.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 13:05:13 -0700 (PDT)
Subject: Re: MLS dominance check behavior on el7
To:     Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Cc:     SELinux <selinux@tycho.nsa.gov>, selinux@vger.kernel.org
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <2E8FB4B5-598A-4741-9AC6-70C9995A48F9@nall.com>
 <052415f8-589e-909f-ac00-8e67c5c23e0d@tycho.nsa.gov>
 <62b6ac25-6528-79d4-a38d-7f75fe870a47@ieee.org>
 <6e21676a-249d-8b05-dd9f-09a3671f46f7@tycho.nsa.gov>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <308ffdc6-6d82-cdd0-4863-c08432b8b8de@ieee.org>
Date:   Fri, 5 Oct 2018 16:05:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6e21676a-249d-8b05-dd9f-09a3671f46f7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/04/2018 05:01 PM, Stephen Smalley wrote:
> On 09/30/2018 10:43 AM, Chris PeBenito wrote:
>> On 09/11/2018 04:20 PM, Stephen Smalley wrote:
>>> On 09/11/2018 03:04 PM, Joe Nall wrote:
>>>>> On Sep 11, 2018, at 1:29 PM, Stephen Smalley <sds@tycho.nsa.gov> 
>>>>> On 09/11/2018 10:41 AM, Stephen Smalley wrote:
>>>>>> On 09/10/2018 06:30 PM, Ted Toth wrote:
>>>>> BTW, I noticed there is another permission ("translate") defined in 
>>>>> the context class and its constraint is ((h1 dom h2) or (t1 == 
>>>>> mlstranslate)).  I would have guessed that it was intended as a 
>>>>> front-end service check over what processes could request context 
>>>>> translations from mcstrans or what contexts they could translate, 
>>>>> but I don't see it being used in mcstrans anywhere.  Is this a 
>>>>> legacy thing from early setransd/mcstransd days?  There is a TODO 
>>>>> comment in mcstrans process_request() that suggests there was an 
>>>>> intent to perform a dominance check between the requester context 
>>>>> and the specified context, but that's not implemented.  Appears to 
>>>>> be allowed in current policy for all domains to the setrans_t 
>>>>> domain itself.
>>>>
>>>> I think 'translate' predates my mcstransd work and dates from the 
>>>> original TCS implementation. There is an argument to implement that 
>>>> constraint, but we've been operating without it for so long it does 
>>>> not seem worthwhile.
>>>
>>> Well, I guess we ought to either implement it or delete the 
>>> permission definition from refpolicy.
>>
>> I'm fine removing it.  It's just the translate permission that is 
>> unused, not the whole class, correct?
> 
> Correct. Only caveat is that removing translate will change the 
> permission index of contains, which could break a running mcstransd upon 
> a policy reload (doesn't use selinux_check_access or even the avc; won't 
> flush the class/perm string mapping on a reload automatically).

Good point.  I think I'll remove all the rules and constraints and then
rename the permission to unused or unused_perm.  Then the indices will 
be stable, but it will be clear the perm is unused.

-- 
Chris PeBenito
