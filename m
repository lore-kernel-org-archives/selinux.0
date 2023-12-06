Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="YXOz6/Ec"
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DC122
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 05:43:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4239f5c1ec2so5284261cf.0
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 05:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1701870212; x=1702475012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVLkToUaUYktxfsxkwm2vWDHAxhcQoKTNfgCFJqNK5M=;
        b=YXOz6/EcQNnPA0gNsEhQmm8/AXyqTMqbDZMcxgABVpi+JqRLI/jnunc28hjh9z8ZR0
         hNL0/ZrLs5PqJwNpxftsg3DjRapZOS3aMjahT1L4fpq+rBR0yI1LidtlrbLibDHdK760
         LHagcFRCWCHUi5N8MNkMYZKDuS2xXDcnjX1yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870212; x=1702475012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVLkToUaUYktxfsxkwm2vWDHAxhcQoKTNfgCFJqNK5M=;
        b=MpksDe9b8IbbrTw3k1Sh3ijLdStNvlLGx93P1uu+1ElRp7qe72fuXmI4qKvD90NZBj
         7E+coGOCroiAp0OlBHfUu/8cv7v0olrN523pkT8exvhu07dlrF1/MTxYd160F/WdE6UM
         AjUzihxoGXdxFTDym+0qR3K1O8+ucNYkUvR3LyybajlON9hKMMK7tkLfQk95q93f8JNA
         4pAp6eGkg6fkIHXC7vbbgIcJXmQCiol6lAvNznaRO6k52zTlsKI9NhL7gVJMymX4ZRss
         zU6KTdMNHaprOn9Szbe9Urtx0PulLgi/t9f9UsHJcTQDeZSOKnOyI2ykFOmP3tt02yYy
         omSg==
X-Gm-Message-State: AOJu0Yy1xoqfGmSbqmNvcaO9gKwCgrWTRntmThdV2fCWaTVgzOEkURMC
	I/NDa8xPFNaW5YsRZrMscPrYOg==
X-Google-Smtp-Source: AGHT+IH2tXZy9q2ur5Xbfq7gPUAlbRBtabegEmMV358BFDcMSOUhf9Dev9APTAShvCMbXUuxMLB0hw==
X-Received: by 2002:a05:622a:347:b0:423:7080:b98d with SMTP id r7-20020a05622a034700b004237080b98dmr1197710qtw.31.1701870212030;
        Wed, 06 Dec 2023 05:43:32 -0800 (PST)
Received: from ?IPV6:2601:145:c200:960:89f7:1e4:c9bb:6957? ([2601:145:c200:960:89f7:1e4:c9bb:6957])
        by smtp.gmail.com with ESMTPSA id b10-20020ac84f0a000000b0042588a4f370sm57693qte.30.2023.12.06.05.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 05:43:31 -0800 (PST)
Message-ID: <52f37212-ed54-6949-76eb-c8f2761f832d@ieee.org>
Date: Wed, 6 Dec 2023 08:43:35 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] Revert "libsepol/tests: rename bool indentifiers"
Content-Language: en-US
To: Petr Lautrbach <lautrbach@redhat.com>,
 =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
 James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, Chris PeBenito <chpebeni@linux.microsoft.com>
References: <877cluszxo.fsf@redhat.com>
 <20231204164558.43667-1-lautrbach@redhat.com>
 <CAP+JOzSK+p9Fm49ApqA+_V2ro6DADJH9Y0onjwpX7W01+8mgOA@mail.gmail.com>
 <CAJ2a_DcL-Dyby6rGjq23sDmdm+Mk2_KNvM0-iHq=paOQO0RHAQ@mail.gmail.com>
 <8734whu84b.fsf@redhat.com>
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <8734whu84b.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/2023 1:37 PM, Petr Lautrbach wrote:
> Christian Göttsche <cgzones@googlemail.com> writes:
> 
>> On Mon, 4 Dec 2023 at 19:20, James Carter <jwcart2@gmail.com> wrote:
>>>
>>> On Mon, Dec 4, 2023 at 11:46 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>>>>
>>>> This reverts commit 893b50c6ce661f3ee339145e76a0bbfa199671c3.
>>>>
>>>> 61f21385004 ("libsepol: rename struct member") broke build of SETools:
>>>>
>>>> setools/policyrep.c: In function ‘__pyx_pf_7setools_9policyrep_23ConditionalExprIterator___next__’:
>>>> setools/policyrep.c:27857:138: error: ‘cond_expr_t’ {aka ‘struct cond_expr’} has no member named ‘bool’; did you mean ‘boolean’?
>>>> 27857 |     __pyx_t_3 = __pyx_f_7setools_9policyrep_13SELinuxPolicy_boolean_value_to_datum(__pyx_v_self->__pyx_base.policy, (__pyx_v_self->curr->bool - 1)); if (unlikely(PyErr_Occurred())) __PYX_ERR(1, 336, __pyx_L1_error)
>>>>        |                                                                                                                                          ^~~~
>>>>        |
>>>>
>>>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>>>
>>> Also need to revert 513fc1570c16924080740b23fa34343ef64a90c0
>>> Plus there is a couple of new uses in policy_validate.c and one in
>>> checkpolicy/policy_define.c that need to be corrected.
>>>
>>> Thanks,
>>> Jim
>>
>> Could you consider https://github.com/SELinuxProject/setools/pull/113
>> as an alternative?
> 
> Nice, thanks!
> 
> I need to test it, but it looks good.
> 
> For me, this is better solution than reverting all the patches.
> 
> But we need to release SETools together with SELinux userspace 3.6.
> 
> Chris, is it feasible to release SETools with the proposed change on
> this Wednesday or a week later?

Yes, that can be done.

-- 
Chris PeBenito

