Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644BE32E68D
	for <selinux@vger.kernel.org>; Wed, 21 Jan 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028058; cv=none; b=sY2hhFN8mg4aI0/jE/E8k7Whf/vLSTpDK01o6aiWi3wlGFRJ4NdscUHuAX3WBMFxXlfZJmo1myYOlzR6n3uVxkIiBQQwuCtGd/v/v6HrhYF5Ais+x8+/h4/A4yZNCxIwFFi8GC0nRaesvro17qMs+c+lNVg/OtjZdeTvtCUz4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028058; c=relaxed/simple;
	bh=GQvrhaD03hC+ffgaokB/i5YL7xDgZ8K0bv/O4K7JrgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJY5e8bE3RvQoq95byY6bNlXNfu83pjJpldasPaP+SV/YW37I+vor9cZRVLnmbB8B6GI+qdhKk43EX5YMc9FrM9sfSfyoCD6FoquTg0oq+A/xZq3NW/GsQLWMDkNTJ4qbEspBiW2uQBMriAC/MYT4CiaNMpRSV09TToC1LXpB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nUG6A3ws; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nUG6A3ws"
Received: from [10.137.198.68] (unknown [131.107.147.196])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8503420B7167;
	Wed, 21 Jan 2026 12:40:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8503420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769028056;
	bh=BXIjUEhAkn1Ae2atjm4ncNtQi4OueLYtqnP8qvHVcTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nUG6A3wsnvXwmBXHY/QlY+nqTPFZZZ7dFEKKuoNrSC5FGQS//DQ1cIl1YgjXbkNfq
	 3QqoEJKOOEbZI/Dm9stGmHB8kEeBHGGFFBE8OvV+fOUFlj5QgpoCEcYUTQmJGgV9GZ
	 aiLNwetbw1JmcWmZI0M35gsCDQpZ+3gyeKactgCM=
Message-ID: <1e33d0db-0be3-4f85-97db-88c68978815c@linux.microsoft.com>
Date: Wed, 21 Jan 2026 12:40:56 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
 omosnace@redhat.com, danieldurning.work@gmail.com
References: <20251205024259.704-1-ericsu@linux.microsoft.com>
 <b687544287eb8850f24592a207a0b846@paul-moore.com>
 <CAJ2a_Dfk7R2n99790ke+b+LBUAY+Jn2Uq-kgm8yzUvX-Hx4xAg@mail.gmail.com>
 <CAHC9VhQ8Z1YvpDGZK1m15nvU0qsNsyFtTvmyQAUMO+=9txaBpQ@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAHC9VhQ8Z1YvpDGZK1m15nvU0qsNsyFtTvmyQAUMO+=9txaBpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/2026 12:59 PM, Paul Moore wrote:
> On Wed, Jan 14, 2026 at 12:56 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
>> On Tue, 13 Jan 2026 at 21:45, Paul Moore <paul@paul-moore.com> wrote:
>>> On Dec  4, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
>>>> BPF token support was introduced to allow a privileged process to delegate
>>>> limited BPF functionality—such as map creation and program loading—to
>>>> an unprivileged process:
> ...
>
>>> Merged into selinux/dev with some minor line length and whitespace
>>> tweaks.  Thanks everyone!
>> I think there is a typo in selinux_bpf_token_capable():
>>
>> switch (CAP_TO_INDEX(cap)) {
>>      case 0:
>>          sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_USERNS;
>>          break;
>>      case 1:
>>          sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2_USERNS;
>> //  <-- SECCLASS_CAPABILITY2  ??
> Oooh, good catch, thanks!  I'll work up a fix right now.
>
>>          break;
>>      default:
>>          pr_err("SELinux:  out of range capability %d\n", cap);
>>      return -EINVAL;
>> }

Thanks a lot, Paul, for the help. Should have checked my email more often :(

