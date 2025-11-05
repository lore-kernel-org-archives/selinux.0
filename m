Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8730B27815D
	for <selinux@vger.kernel.org>; Wed,  5 Nov 2025 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374909; cv=none; b=Klnhww0xHEEXdD7DD4cCY+8Gr7Vg8YfzBMPJGeraXWsPk12C5b/PO6SaKXh5PIQCNzPGH2FIxO0HLD2POF2wSgCfuOsNlYfD8KSdyl3I/C6jETGl98kUphB/tStSpK+UrTI6t0cgtCJu1FOphmh3NkgbbEiUk6ZfsqUH2wMMcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374909; c=relaxed/simple;
	bh=QwqpdiKefZ+aJH+v64x7sG4LlGaIbBUEL77/OS+WrZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8M/0Gf7sZkPU0X2Zr1pSaMnqEF+2l1lYi7z+lMiGDaMAFRpcMLl4c5v7vAT938kpnIkOYsFUvSiglhGPQ4H0ZSfw+ibbrwxjkHkPkf05Y/LbRTEsbeueRO2dzDQixDcOF/YVTgzXrGPe/lDnIZtsHb0mpDG/coxqpS3YqMnmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QUVdyg6F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QUVdyg6F"
Received: from [100.96.217.96] (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id 31121211E325;
	Wed,  5 Nov 2025 12:35:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31121211E325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762374904;
	bh=R5NZAQwPqZJuavDctYzsqRBoXGcszHPC0XkuQKmFgR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QUVdyg6Fj5xINbiPGw1VPC9PYA2bMFHNsWxKTl9M2zBzOmUjG3bkBbWwk5FUBS4KG
	 Y7TszCVg3qsrJOPaK0CDsF+SC6cl8Gik2uRiisBKU3lZ8cL6eDEwn1USd3iA4JSaIG
	 wU6CBsXQf+E2QBdO/Rh+6e2DwMbMYtI2G24O2eDM=
Message-ID: <86627693-6ac7-485e-ab1d-091ff002ee9d@linux.microsoft.com>
Date: Wed, 5 Nov 2025 15:35:02 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SELinux documentation repo licensing
To: William Roberts <bill.c.roberts@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
References: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com>
 <CAEjxPJ5SX-9OyMPQF9B9wr4ixdaG9jxSmG5R7Ozev+KVztWoWg@mail.gmail.com>
 <CAHC9VhQjEo57SMp49A+iXMUiyEXkpMUOnHkSJ3cspTHGUFXdUA@mail.gmail.com>
 <CAFftDdr58R+9qGd8MYxyyxzY0wCRo7vSDKLMX78sm9dc7QMUUg@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAFftDdr58R+9qGd8MYxyyxzY0wCRo7vSDKLMX78sm9dc7QMUUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/2025 11:31 AM, William Roberts wrote:
> On Sat, Nov 1, 2025 at 11:30 AM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, Oct 30, 2025 at 9:02 AM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>> On Wed, Oct 29, 2025 at 5:19 PM Daniel Burgener
>>> <dburgener@linux.microsoft.com> wrote:
>>>>
>>>> Finally, Creative Commons seems like a fairly standard option. However,
>>>> we have decisions to make, since we can specify different CC variants.
>>>> Something like CC-BY gets us a more permissive MIT/BSD style license,
>>>> CC-BY-SA would be similar to the GNU FDL (but of course mutually
>>>> incompatible).
>>>>
>>>> My initial preference personally is for the CC-BY, but I'm happy with
>>>> whatever license the community chooses.
>>>
>>> I am fine with CC-BY.
>>
>> Same here.
> 
> FWIW, same.
> 
>>
>> --
>> paul-moore.com
>>

Thanks for the good discussion.  I've opened a PR to apply CC-BY to the 
repo here: https://github.com/SELinuxProject/documentation/pull/4

I think the ACKs from Paul and Stephen who have already contributed are 
essential to collect before applying the patch (which I intend to apply 
to both the website and main branches).

-Daniel
