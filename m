Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9430E0D7
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512465; cv=none; b=ofvxGHmZhbDAOCBLpTF2enXJq2GC5ciyFzqPWrYFqKNXekpRv6H410oHUhwFWKUjsyHKCd7+0d0dKIrqznyb+XjtZuNfEr9p1y7LFen9vDXXRfEZMsRGjbi80DKQhjbSvKT3TAlsDRi/4wlNJODzCV9C6ccSr5aU+fwDVyakXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512465; c=relaxed/simple;
	bh=xq9nfQjayQvYisYAXJJZBJorSy5b8ZSoPtpYEt0arSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJGS7PFGlS8F7qoE61n0+3YGOFLFx+JqBpStvcIAK83VVAqcqSMka9XOY6b6UsOYkV6/DjJkR/G3h+2ubq8nEPHshHkNKxfFc7Ck2h2QCiiX1CTWGqiczoOpFoQzF1G7H15EgC0YkB8HHLy93OV9mq6GJqUkCXpjStkSv5uw+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lAshp1RC; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lAshp1RC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Ee15XAq5g1Bsv219+pTIFjaUMC4meRXlWZtIpf9wyHM=;
	b=lAshp1RCgOLJ4MZQewiBG41VK9uvaUE2hMHCe1qLoH250UOUtOQI5CML1eXbHm
	B1nljmdgFq9h1n7lB7yYU2VUMMBGc8q/d7UgvZnmHxFnKK9YKlyG4Cj3gsAfQqPP
	NUw2sVdKTa7pAqisnpVuyjI0YZvZfQi/yp7ysNyMwKe+8=
Received: from [192.168.3.49] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3l8lw_qJoMy9GCw--.26830S2;
	Mon, 18 Aug 2025 18:20:33 +0800 (CST)
Message-ID: <fc5583ce-8b27-4818-ae05-96e6332dd6a0@163.com>
Date: Mon, 18 Aug 2025 18:20:32 +0800
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
From: Fei Shao <kabc005009@163.com>
In-Reply-To: <87ect9ymt0.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l8lw_qJoMy9GCw--.26830S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWrtr13uFykXFy7ArWxXrb_yoW5WrWrpF
	ZxG3ZIyr4UXr1UJrn7Kr1UXr1UKryDtw4UXFy5Jr18Ar1qyr1UWF1DJF18WrykCryUJw1U
	Jr45JFZrXFyUArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFD7fUUUUU=
X-CM-SenderInfo: pndeuiqqvqimi6rwjhhfrp/1tbiEQKttGii-hcM5gAAsD



On 18/08/2025 17:57, Dominick Grift wrote:
> Dominick Grift <dominick.grift@defensec.nl> writes:
>
>> BOBx <kabc005009@163.com> writes:
>>
>>> Hi all,
>>>
>>> These days I tried to compile te with tools named checkpolicy. I have
>>> searched the process with google and chatgpt, and I followed the steps
>>> they told me but I failed.
>> Hi,
>>
>> checkpolicy is for monolithic policy. see below for modular policy:
>>
>>> The following is my te file,  cmd and response and other infomation.
>>>
>>> My te file(my_policy.te):
>>> ----------------------------------------------
>> This is modular policy that should be compiled with checkmodule and then
>> packaged with semodule_package:
> Oops.
> Actually I am wrong. This is reference policy.
> I should be compiled with the reference policy makefile. I am not sure
> what package provides this Makefile in ubuntu but probably package
> selinux-policy-dev:
>
> https://packages.ubuntu.com/questing/all/selinux-policy-dev/filelist
>
> /usr/share/selinux/devel/Makefile
>
> So this should work:
>
> make -f /usr/share/selinux/devel/Makefile my_policy.pp
I use this command generate pp file well.

>> checkmodule -M -m my_policy.te -o my_policy.mod
This command doesn't work. The response is :
----------------------------------------------------
my_policy.te:1:ERROR 'Building a policy module, but no module 
specification found.
' at token 'policy_module' on line 1:


checkmodule:  error(s) encountered while parsing configuration
--------------------------------------------------
It seems the articles from search engine are not wrong.


>> semodule_package -o my_policy.pp -m my_policy.mod
>> semodule -i my_policy.pp
>>
>> for more information see:
>>
>> man checkpolicy
>> man checkmodule
>> man semodule_package
>> man semodule
>>
>>> policy_module(my_mypolicy, 1.0)
>>>
>>> # Define types
>>> type my_type_t;
>>> type my_type_exec_t, file_type;
>>>
>>> # Allow rules
>>> allow my_type_t my_type_exec_t:file execute;
>>> ----------------------------------------------
>>>
>>> The command:
>>> ----------------------------------------------
>>> sudo checkpolicy -M -o my_policy.pp my_policy.te
>>> ----------------------------------------------
>>>
>>> The response  from command:
>>> ----------------------------------------------
>>> my_policy.te:1:ERROR 'syntax error' at token 'policy_module' on line 1:
>>>
>>>
>>> checkpolicy:  error(s) encountered while parsing configuration
>>> ----------------------------------------------
>>>
>>> OS information: 6.11.0-29-generic, ubuntu 24.10.
>>>
>>> Would you like help me to compile te with checkpolicy please? Or which
>>> URL should I read please?
>>>
>>> Best regards
>>>
>>> BOBx
>>>
>>>
>>>

