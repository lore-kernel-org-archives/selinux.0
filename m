Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55CC3F6B0
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 13:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiHANN7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiHANN6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 09:13:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9702255A7
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 06:13:56 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so13546565fac.13
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=S4v2xzmivjkPNxxCfifaPK4xR7fi1R2DYRzw0gzDhqk=;
        b=aU/EMjwvPmQHuC3EBkgE95P1u4OscFyLNRNnnObQ+qrX4FI5VdaEavlkuJv0eLaafS
         LRfaSM+ftYFZBzQXUQVTjMlxhJ82TBVrX2MBIhQvsXC+TEYUHrHEHfxiIZvTEcQvnkne
         otTWe5IN176ijSIBTW+IPCt5doE2JAB8vJu0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=S4v2xzmivjkPNxxCfifaPK4xR7fi1R2DYRzw0gzDhqk=;
        b=GrEqsiFkONkBc81mvzJkxEpD56PmWo5g1ukb8ikjYJ8wWukcakk1T1Z6djQfMwFVAw
         XRxTm2tYVDEWKTA5uyUjQ2JpPsJb4DUoAVOrZig0nqVPRR8tlQECjSE6ZNIHc782NaG5
         x+tUbGg3TpDuYKDL1v1GdG40+sFhWksp9Md+XoUciraZdh5PsFQ9lfjBgoYAUTMP7qHW
         fBQt/4pfUT2myLQc4JO4CyNM3veuNp/LJ1/vyKpLNApl7gMLbUayWpMu7b9w0nYiR2Yu
         ptpUqS684rqyGq6wDzz2UkTOJ8a7CV5MX1pN3/lq4WBadtkK2vsbNNNGXGlLOU871q/w
         FcuA==
X-Gm-Message-State: AJIora95q3tjjUijiJUXrlNT4O3HJ1swVGoFO5PyOX7hUwL8SKMA/qvC
        3VPioPuveJqdADEb5DlTbSomhg==
X-Google-Smtp-Source: AGRyM1vAYe6eYSqkhNEffp5nkSzS3sTGEFR4Fq4tFcvvlB80G4i7/GERIpfxWhXyvbYGQjvJ5+67TQ==
X-Received: by 2002:a05:6870:f149:b0:de:e873:4a46 with SMTP id l9-20020a056870f14900b000dee8734a46mr6761101oac.286.1659359635202;
        Mon, 01 Aug 2022 06:13:55 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id 22-20020aca2816000000b00339ff117f38sm2400911oix.53.2022.08.01.06.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:13:54 -0700 (PDT)
Message-ID: <a4db1154-94bc-9833-1665-a88a5eee48de@cloudflare.com>
Date:   Mon, 1 Aug 2022 08:13:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/4] Introduce security_create_user_ns()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Martin KaFai Lau <kafai@fb.com>
Cc:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
References: <20220721172808.585539-1-fred@cloudflare.com>
 <20220722061137.jahbjeucrljn2y45@kafai-mbp.dhcp.thefacebook.com>
 <18225d94bf0.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <18225d94bf0.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/22/22 7:20 AM, Paul Moore wrote:
> On July 22, 2022 2:12:03 AM Martin KaFai Lau <kafai@fb.com> wrote:
> 
>> On Thu, Jul 21, 2022 at 12:28:04PM -0500, Frederick Lawler wrote:
>>> While creating a LSM BPF MAC policy to block user namespace creation, we
>>> used the LSM cred_prepare hook because that is the closest hook to prevent
>>> a call to create_user_ns().
>>>
>>> The calls look something like this:
>>>
>>> cred = prepare_creds()
>>> security_prepare_creds()
>>> call_int_hook(cred_prepare, ...
>>> if (cred)
>>> create_user_ns(cred)
>>>
>>> We noticed that error codes were not propagated from this hook and
>>> introduced a patch [1] to propagate those errors.
>>>
>>> The discussion notes that security_prepare_creds()
>>> is not appropriate for MAC policies, and instead the hook is
>>> meant for LSM authors to prepare credentials for mutation. [2]
>>>
>>> Ultimately, we concluded that a better course of action is to introduce
>>> a new security hook for LSM authors. [3]
>>>
>>> This patch set first introduces a new security_create_user_ns() function
>>> and userns_create LSM hook, then marks the hook as sleepable in BPF.
>> Patch 1 and 4 still need review from the lsm/security side.
> 
> 
> This patchset is in my review queue and assuming everything checks out, I expect to merge it after the upcoming merge window closes.
> 
> I would also need an ACK from the BPF LSM folks, but they're CC'd on this patchset.
> 

Based on last weeks comments, should I go ahead and put up v4 for 
5.20-rc1 when that drops, or do I need to wait for more feedback?

> --
> paul-moore.com
> 
> 

