Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3320E31D
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149825; cv=none; b=k70jf4c4a8eXg/DJEy3IkZPKo3uJFcvpfzDe8YOGcPZONEemF9NDGtYQG1laRIhpNd3/nXqJBd1OHclJbRGuL4P/x7ngklS6P5q4xXF4YiR5y3UPPrJB3zZgCZFgg4RzntbXnkdaMfu2MWpaWqiKBlt5E2mLSnr0ImiPg4Mxhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149825; c=relaxed/simple;
	bh=+BS2H/jwkdiPaQ19Vc9kWIGSlpitWyQ75aADBCa63rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcmrWLSNxKcoT08UCFXc6tihYVlgROApcKr6Du4HZ8WR7pofO05cDETwnuiZiRbRQthQceYCWohxD6SOFx0V28Lpe//NSDRd/uzyCdr3w8MxuKEYi7O5KvH833QUTbbhp15/2ZvTqxt7w6LWZEEs9im8l+e361l4tzBx4EcuoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YOFheoxJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YOFheoxJ"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA6A8204E5B7;
	Fri, 21 Feb 2025 06:57:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA6A8204E5B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740149823;
	bh=z9GjJbKeJ5keGQJXQju5ESMe4W0kVgyaozsjHQfBoYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YOFheoxJilZAezNAyvLU+JEFFqUOfoUgPyB9fCvkOEEcc/6huU85gkJNrPA4ssw6Q
	 VMkf1mhntQyzEpz3duCz0vgKNrGBPz2ch5TvzuHUOoqitCLAQrNhcvtGU6yQ+PHlrO
	 10eMhuT7+yuHhew3XSOlEpBbI2erfwVcs7atUw+Q=
Message-ID: <76560279-4373-4cad-8d69-7c00fb0d2fa7@linux.microsoft.com>
Date: Fri, 21 Feb 2025 09:57:01 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: add permission checks for loading other kinds of
 kernel files
To: Paul Moore <paul@paul-moore.com>, kippndavis.work@gmx.com,
 selinux@vger.kernel.org
Cc: omosnace@redhat.com, stephen.smalley.work@gmail.com
References: <20250205205909.19515-1-kippndavis.work@gmx.com>
 <1e88f4bd89d4fa90e890877ff6ded21b@paul-moore.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <1e88f4bd89d4fa90e890877ff6ded21b@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/2025 4:08 PM, Paul Moore wrote:
> On Feb  5, 2025 kippndavis.work@gmx.com wrote:
>>
>> Although the LSM hooks for loading kernel modules were later generalized
>> to cover loading other kinds of files, SELinux didn't implement
>> corresponding permission checks, leaving only the module case covered.
>> Define and add new permission checks for these other cases.
>>
>> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
>> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
>> ---
>>   security/selinux/hooks.c            | 54 ++++++++++++++++++++++++-----
>>   security/selinux/include/classmap.h |  4 ++-
>>   2 files changed, 49 insertions(+), 9 deletions(-)
> 
> Thanks for putting this patch together, and double thank you for the
> tests too!  If you've got the time, it would be great if you could
> submit a patch/PR to update notebook too:
> 
>   * https://github.com/SELinuxProject/selinux-notebook

I went ahead and put together a notebook PR here: 
https://github.com/SELinuxProject/selinux-notebook/pull/45

Kipp, if you are able to take a look and make sure I have the details 
right, that would be appreciated.

I'll keep the notebook PR updated if the permissions change and merge it 
after the code is in -next.

-Daniel
