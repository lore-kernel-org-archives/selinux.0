Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C535FC433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 18:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C99E64DD1
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBMSHJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBMSHJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Feb 2021 13:07:09 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FEC061574
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 10:06:29 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r23so2981237ljh.1
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1w9XjWYULmNMprHn2DPomnbVAeJfDvxh5x/4W2pcEzk=;
        b=WB8FIbzvgFeZtf5pXatnTofcHjaKbuV1LwnekArMopK4FHS+GRALsddbYdHLqXZWng
         5sznAS7PZGqtq2VgHXt2adEcWiy1k0MQofRnDc5FXjwYR5YCwj3vsrCUMDcXjlfnEptv
         TgkMKNHL0ExNbcPENAlR9mH6orIfzbuDSKfqdWfOC4Dgab32gLySsmq2mcN4QXMBgITE
         YKWbgBeL3Qb7D4D14wffD1RNyevMfibbg7BwQObtrembwv5qRDwAZ2yLVtLNqbVERTUK
         gyjJX1/BlhS124Q/xywt4H718e7T5HwcICSIt/F6bFF5+vy3bLe16pWnEhpHDN0i9OzV
         Qqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1w9XjWYULmNMprHn2DPomnbVAeJfDvxh5x/4W2pcEzk=;
        b=TUbaJZ3CkyGdH6cqpEpCjFq+Nt7KgKn3xZppRcsQ15nWifY3sq3zNFMK/pQ6KwgmU7
         oEWP97QP96hhOpaR8yfQj4XvoZtq0/A4lpPvnqDh7kwtjJ6H9A6R046hTMkbCAoysczy
         kZhgbMnsrEfCp9YgD8dpxNXnw8ns1V081tHPKgD8Y4TUW8lzEDEC/rEuY0bnTa8E1hR2
         Lr0MYG0DTs3xqm052HBcE/yov/9z/Hvh8OoYgvbRlnE85QYcTt3y9cKOSlK68L6FCjlV
         nyd4g1w6TdyBFqiGkn9roOd6XSBRboVO3MFiQgWVt8T6T7oULivOoIPNKDG16AO/T+4L
         Cezg==
X-Gm-Message-State: AOAM533XCw2/iRgl96ttE2JL7feJY1DKPouaVgL0kBLT6B7p8iJuzBMi
        yEt6BO2bPRCL0HN0PVFzEZFVs6Uq92I=
X-Google-Smtp-Source: ABdhPJwnEOJ9sn+iqx7YidKsKEx1C7VCPJFgnJVlgsaVhhRs5+xX/s/LIgZbem1J3CEhDQaG9AGkQA==
X-Received: by 2002:a2e:b048:: with SMTP id d8mr4679302ljl.386.1613239587123;
        Sat, 13 Feb 2021 10:06:27 -0800 (PST)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id l9sm2091474lfk.76.2021.02.13.10.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 10:06:26 -0800 (PST)
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
 <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
 <ypjl35y1ot14.fsf@defensec.nl>
 <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
 <ypjlv9awo2iy.fsf@defensec.nl>
 <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
 <ypjlmtw8ne46.fsf@defensec.nl>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
Date:   Sat, 13 Feb 2021 20:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ypjlmtw8ne46.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 13.2.2021 18.09, Dominick Grift wrote:
> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> 
>> On Sat, Feb 13, 2021 at 2:24 AM Dominick Grift
>> <dominick.grift@defensec.nl> wrote:
>>> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>>>> On Fri, Feb 12, 2021 at 4:52 PM Dominick Grift
>>>> <dominick.grift@defensec.nl> wrote:
>>>>> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>>>>>> On Fri, Feb 12, 2021 at 2:58 AM Dominick Grift
>>>>>> <dominick.grift@defensec.nl> wrote:
>>>>>>> Dominick Grift <dominick.grift@defensec.nl> writes:
>>>>>>>> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>>>>>>>>>      BLUF: Logging in via SSH or directly at the console results
>>>>>>>>>      in "Unable to get valid context...". Help! Much info included.
>>>
>>> You missed a fundamental type attribute association:
>>>
>>> type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;
>>>
>>> It seems that you did not associate your process types with "domain":
>>>
>>> typeattribute xferHigh2Local_t domain;
>>>
>>> See if adding that helps
>>
>> It didn't - but! The failure motivated me to dive more deeply back
>> into /var/log/audit/audit.log, wherein I noticed that the desired user
>> context has been being computed correctly since sometime yesterday
>> (15:29:25 EST, in fact) - but SSH logins were still failing to assign
>> that context. So I tried a console login and it worked (I've not made
>> any console related changes since you started helping me with this).
> 
> Okay but all processes should alway's associate with the domain attribute
> 
>>
>> Progress: The desired context is properly computed and assigned, at
>> least with console (local) login. This leaves me two major items to
>> figure out:
>>
>>      1. Of the changes I have applied over the last 1-3 days,
>>          what is the minimum set required to achieve this? My
>>          immediate future includes bisection.
> 
> Yes i guess work your way back and see...
> 
>>
>>       2. Why doesn't it work with SSH, when it does work with
>>            the console (yes, the ssh_sysadm_login is on)?
> 
> see if the ssh daemon runs with the expected:
> system_u:system_r:sshd_t:s0 context (ps auxZ | grep ssh)
> 
> then doubt check that
> /etc/selinux/targeted/contexts/users/CDTml_high2local_u has:
> system_r:sshd_t:s0 CDTml_high2local_r:xferHigh2Local_t:s0
> 
> And use sesearch to verify that the following queries return:
> 
> sesearch -A -s sshd_t -t xferHigh2Local_t -c process -p transition
> sesearch -A -s xferHigh2Local_t bin_t -c file -p entrypoint
> sesearch -A -s xferHigh2Local_t shell_exec_t -c file -p entrypoint

There's also `sedta` (Debian: setools package) which AFAICT walks 
through the login process (except for the part that tries to find out 
the default context for the user):
$ sedta -s sshd_t -t user_t -S
Domain transition path 1:
Step 1: sshd_t -> user_t

Domain transition rule(s):
allow sshd_t userdomain:process transition; [ ssh_sysadm_login ]:True
allow sshd_t unpriv_userdomain:process transition; [ ssh_sysadm_login 
]:False

Set execution context rule(s):
allow sshd_t sshd_t:process { fork getcap getsched setcap setexec 
setkeycreate setrlimit setsched sigchld signal };

Entrypoint bin_t:
         Domain entrypoint rule(s):
         allow user_t bin_t:file { entrypoint execute execute_no_trans 
getattr ioctl lock map open read };

         File execute rule(s):
         allow sshd_t bin_t:file { execute execute_no_trans getattr 
ioctl lock map open read };


Entrypoint shell_exec_t:
         Domain entrypoint rule(s):
         allow user_t shell_exec_t:file { entrypoint execute 
execute_no_trans getattr ioctl lock map open read };

         File execute rule(s):
         allow sshd_t shell_exec_t:file { execute execute_no_trans 
getattr ioctl lock map open read };
         allow sshd_t shell_exec_t:file { execute getattr ioctl map open 
read }; [ ssh_sysadm_login ]:True
         allow sshd_t shell_exec_t:file { execute getattr ioctl map open 
read }; [ ssh_sysadm_login ]:False


1 domain transition path(s) found.

$ sedta -s local_login_t -t user_t -S
Domain transition path 1:
Step 1: local_login_t -> user_t

Domain transition rule(s):
allow local_login_t userdomain:process { sigchld signal transition };

Set execution context rule(s):
allow local_login_t local_login_t:process { fork getcap setcap setexec 
setkeycreate setrlimit setsched sigchld };

Entrypoint shell_exec_t:
         Domain entrypoint rule(s):
         allow user_t shell_exec_t:file { entrypoint execute 
execute_no_trans getattr ioctl lock map open read };

         File execute rule(s):
         allow local_login_t shell_exec_t:file { execute 
execute_no_trans getattr ioctl lock map open read };


Entrypoint bin_t:
         Domain entrypoint rule(s):
         allow user_t bin_t:file { entrypoint execute execute_no_trans 
getattr ioctl lock map open read };

         File execute rule(s):
         allow local_login_t bin_t:file { execute execute_no_trans 
getattr ioctl lock map open read };


1 domain transition path(s) found.

-Topi

> 
> Also, just in case, try in permissive mode to see if that changes
> anything (unlikely but worth a try)
> 
>>
>> I've read that the latter may have to do with network labelling and/or
>> default network context, I may need to explore that.
> 
> I dont think that is related
> 
>>
>> All suggestions welcome!
>>
>> Thanks! Progress restores optimism.
>>
>> P
> 

