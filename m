Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AD21129F
	for <selinux@vger.kernel.org>; Wed, 12 Feb 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376692; cv=none; b=FdTkXYDeL59+8AjNBFYbIcPoKW8aEyGZ07Qdydz45NwALbTGmQfUcvVWxwMAYJ8QmledQ+o3yOzAy/zcj2TSYA7JE4/2oqWLakK7vECyDhdtn3DuOjzHCnteB8w1uBhTK6yUuMPDKy6L87j1U09LAA3d+cO9P/fchuDIe2eNQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376692; c=relaxed/simple;
	bh=lQ9MphaFePCAGlC9qrbJMPLdF0FkytSCOm72fh/QuBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UrRUP0bCsQ/saNvZPRiMEHUraHAJLU7YbquXvJo58aYRlUDAZz6C5c0uCQw7o2oS2svmNA0/GRLtHR5HMjYVYua+6qXu2JAUVjjRL7qyw5nmiZ+uIRrx0xpakYUFpIgkHGXXf1pSSCctWLWWE/vWaJm1OC+rDfsmKdDpiTIFx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gDzamUG7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gDzamUG7"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 398212109CE9;
	Wed, 12 Feb 2025 08:11:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 398212109CE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739376690;
	bh=mz3Ss2mlpwOhItep6ipUt2d5oOPqtT9Vhco6ZJ1paNI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gDzamUG7YQWvzCnTBcs3les/LtcIOjSfcK3XEhSI/xtCR1Qnm+PzpPVTczDl34f2o
	 x367KVZWdz87QaJl9od5fY6jhlw+JVwNey8hJ6xD7xVxmBiaGhk0FDwWmmD1qZLx+G
	 9Kx/81pwxrqliaul11qAiUWwA4MEwQ08JVW7WMzM=
Message-ID: <06fd3492-f8b4-4b68-aeef-fd38f6f3587c@linux.microsoft.com>
Date: Wed, 12 Feb 2025 11:11:29 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Support static-only builds
From: Daniel Burgener <dburgener@linux.microsoft.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20250211211651.1297357-3-hi@alyssa.is>
 <9316b48f-64f0-469b-8dde-1386aa13d384@linux.microsoft.com>
 <87a5aro74k.fsf@alyssa.is>
 <d36501b0-e546-4de6-aa73-85613b276366@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <d36501b0-e546-4de6-aa73-85613b276366@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/2025 10:11 AM, Daniel Burgener wrote:
> On 2/12/2025 4:16 AM, Alyssa Ross wrote:
>> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>>
>>> On 2/11/2025 4:16 PM, Alyssa Ross wrote:
>>>> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>>>> index 32ad0201..7acd51dd 100644
>>>> --- a/policycoreutils/Makefile
>>>> +++ b/policycoreutils/Makefile
>>>> @@ -1,5 +1,10 @@
>>>>    SUBDIRS = setfiles load_policy newrole run_init secon sestatus 
>>>> semodule setsebool scripts po man hll unsetfiles
>>>> +PKG_CONFIG ?= pkg-config
>>>> +
>>>> +LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
>>>> +export LIBSELINUX_LDLIBS
>>>> +
>>>
>>> I think that in the DISABLE_SHARED case, the pkg-config command needs
>>> --static as well.  I tried your patch, and I get errors that the
>>> downstream users of libselinux have undefined references to libpcre2,
>>> and they are being build without -lpcre2-8.  Based on the pkg-config man
>>> page, it looks like Requires.private libraries are only included if the
>>> --static flag is passed.
>>
>> I think it's generally expected that the user set
>> PKG_CONFIG="pkg-config --static" when they want static linking.  See
>> e.g. <https://bugs.freedesktop.org/show_bug.cgi?id=19541#c3>.
> 
> Thanks for clarifying.  Yes, this command builds everything for me:
> 
> make DESTDIR=~/obj PKG_CONFIG="pkg-config --static" DISABLE_SHARED=y 
> install
> 
> However, the binaries still appear dynamically linked when I investigate 
> them with the "file" command.  Am I missing some other step?

It occurs to me that I've possibly misunderstood the point of your 
patch.  This is just about not building the shared libraries, 
independent of whether the binaries are statically linked?

I'm noticing that with the above command, restorecond is still 
dynamically linking with a libselinux.  Since no shared libselinux was 
built, it's linking with the one that happens to be installed on my 
system.  That is different than the policycoreutils/* like newrole for 
example, that was dynamically linked with libselinux without this patch, 
but now is not. That seems like surprising behavior to me.  Is it the 
expected behavior?

-Daniel

> 
>>
>>> I also see that restorecond is not including -lpcre2-8.  It probably
>>> needs the same treatment as policycoreutils/*.
>>
>> Does it fail to build for you?  It builds DISABLE_SHARED=y for me
> 
> Now that I added PKG_CONFIG="pkg-config --static", restorecond is 
> building.  However, as above, it appears dynamically linked.
> 
>>
>>> Finally, I was unable to get the install-rubywrap and install-pywrap
>>> targets to build with DISABLE_SHARED=y.  I wasn't able to figure out the
>>> ultimate issue there.
>>
>> I think Ruby and Python bindings need to be shared libraries, so it
>> doesn't make sense to build them with DISABLE_SHARED=y.
> 
> Fair enough. I think it would be helpful if these caveats could all get 
> documented.  I just tried following the README.md instructions and 
> adding "DISABLE_SHARED=y", which as mentioned, didn't work.  If 
> "DISABLE_SHARED" requires other options to work, it seems like that 
> should at a minimum be documented.
> 
> -Daniel
> 

