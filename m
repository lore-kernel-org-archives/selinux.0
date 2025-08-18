Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340B23AB81
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521096; cv=none; b=l8GLM7FmKFMEMywTkiOR1Bm7wfhWGsIKYihKqn6vVJJ/rrYjEqej9lNmkJ/dFDRO3fFHrJCjs1BxNtVojug+oVCMfIyftL3a1RaT/aajM58R4RwUDAcdeD6M/hsfegVKwD8n+OvdlPLFRJoYSdq+bvzf6PyEHTafUFYZb2s9K3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521096; c=relaxed/simple;
	bh=Fn0JJUQWJYM02+lie+D9izvxilHHADJS8lswG7CXg7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcZOUHDSXxZgxkDDFBh1I5PKK0p6F8zRIsl+/5H4pMxvjCTJEaGOXfK+CGuTxTlQXTujTCMCt2LYY8AFMaz3fd/PhyGSVk7bzgm+Jj7uhwOOjhG1bRjbCgHTbwYSuxXdjslWwyTunKySCrAXJT+oN1g5MtjCFvKe4ae0g3Z6R0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YS9AEzBx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YS9AEzBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Fn0JJUQWJYM02+lie+D9izvxilHHADJS8lswG7CXg7Y=;
	b=YS9AEzBx/IdhOd4vBPj2tgA9ELf32ESRUszhCggKem8Wwj5yxp6x/VVGFZ5maJ
	Eq2Ld3J0SuSa7qfrSdyeBLMnhBFFEqF1o192/9BJQ1UP+65xhqpdRShQKKVecEVa
	NDvvMcQdBPlbmpYjnPPYvvdgz7aOh3yU0kzzwgpt7q4ek=
Received: from [IPV6:2409:8a28:76:edf0:1d2c:c385:a186:62d2] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3f_A0IKNoqSdMCw--.30707S2;
	Mon, 18 Aug 2025 20:44:36 +0800 (CST)
Message-ID: <70497f1a-be07-49e0-8faa-8fde72f4ee2e@163.com>
Date: Mon, 18 Aug 2025 20:44:46 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Help] how to compile te with checkpolicy.
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
References: <8925af9c-2977-4acf-9b48-7f6ce3b280ec@163.com>
 <87ikilyn01.fsf@defensec.nl> <87ect9ymt0.fsf@defensec.nl>
 <fc5583ce-8b27-4818-ae05-96e6332dd6a0@163.com> <87a53wzz9j.fsf@defensec.nl>
From: BOB x <kabc005009@163.com>
In-Reply-To: <87a53wzz9j.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f_A0IKNoqSdMCw--.30707S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWruw4fJry7JFW8AF4fXwb_yoW5uF1kpF
	W3J3ZFyr4UXr1UJr1xKr1UXr1UtryUt3yUXFy5Jr1xAr1qyr1UWF1UJr18WrykCryUJw18
	Jw15JFZrXFyUArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbTmgUUUUU=
X-CM-SenderInfo: pndeuiqqvqimi6rwjhhfrp/1tbiYhmttGijG3icqQAAs-



在 2025-08-18 18:43, Dominick Grift 写道:
> BOBx <kabc005009@163.com> writes:
>
>> On 18/08/2025 17:57, Dominick Grift wrote:
>>> Dominick Grift <dominick.grift@defensec.nl> writes:
>>>
>>>> BOBx <kabc005009@163.com> writes:
>>>>
>>>>> Hi all,
>>>>>
>>>>> These days I tried to compile te with tools named checkpolicy. I have
>>>>> searched the process with google and chatgpt, and I followed the steps
>>>>> they told me but I failed.
>>>> Hi,
>>>>
>>>> checkpolicy is for monolithic policy. see below for modular policy:
>>>>
>>>>> The following is my te file,  cmd and response and other infomation.
>>>>>
>>>>> My te file(my_policy.te):
>>>>> ----------------------------------------------
>>>> This is modular policy that should be compiled with checkmodule and then
>>>> packaged with semodule_package:
>>> Oops.
>>> Actually I am wrong. This is reference policy.
>>> I should be compiled with the reference policy makefile. I am not sure
>>> what package provides this Makefile in ubuntu but probably package
>>> selinux-policy-dev:
>>>
>>> https://packages.ubuntu.com/questing/all/selinux-policy-dev/filelist
>>>
>>> /usr/share/selinux/devel/Makefile
>>>
>>> So this should work:
>>>
>>> make -f /usr/share/selinux/devel/Makefile my_policy.pp
>> I use this command generate pp file well.
>>
>>>> checkmodule -M -m my_policy.te -o my_policy.mod
>> This command doesn't work. The response is :
>> ----------------------------------------------------
>> my_policy.te:1:ERROR 'Building a policy module, but no module
>> specification found.
>> ' at token 'policy_module' on line 1:
> Yes the policy_module() macro is reference policy specific and
> checkmodule does not understand reference policy.
>
> For reference policy use the reference policy Makefile.
Got it。Thanks。
>>
>> checkmodule:  error(s) encountered while parsing configuration
>> --------------------------------------------------
>> It seems the articles from search engine are not wrong.
>>
>>
>>>> semodule_package -o my_policy.pp -m my_policy.mod
>>>> semodule -i my_policy.pp
>>>>
>>>> for more information see:
>>>>
>>>> man checkpolicy
>>>> man checkmodule
>>>> man semodule_package
>>>> man semodule
>>>>
>>>>> policy_module(my_mypolicy, 1.0)
>>>>>
>>>>> # Define types
>>>>> type my_type_t;
>>>>> type my_type_exec_t, file_type;
>>>>>
>>>>> # Allow rules
>>>>> allow my_type_t my_type_exec_t:file execute;
>>>>> ----------------------------------------------
>>>>>
>>>>> The command:
>>>>> ----------------------------------------------
>>>>> sudo checkpolicy -M -o my_policy.pp my_policy.te
>>>>> ----------------------------------------------
>>>>>
>>>>> The response  from command:
>>>>> ----------------------------------------------
>>>>> my_policy.te:1:ERROR 'syntax error' at token 'policy_module' on line 1:
>>>>>
>>>>>
>>>>> checkpolicy:  error(s) encountered while parsing configuration
>>>>> ----------------------------------------------
>>>>>
>>>>> OS information: 6.11.0-29-generic, ubuntu 24.10.
>>>>>
>>>>> Would you like help me to compile te with checkpolicy please? Or which
>>>>> URL should I read please?
>>>>>
>>>>> Best regards
>>>>>
>>>>> BOBx
>>>>>
>>>>>
>>>>>

