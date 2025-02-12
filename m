Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A921127A
	for <selinux@vger.kernel.org>; Wed, 12 Feb 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373082; cv=none; b=lOEMqNd8lI9z6cfMZl7B3uPfeNfuLx4braTZCe+8pvKV8afEt8YBjqsW+M2/6vI+xHNGILOTnGeUpg2D9+0UdnE0FqCbyCMD5TkhASWN2mlyu3DYItWli5jOcfyQQGA/BYPTyAl8G+CLNjfadW7KSkSlr/SiOOj74rcjUm2Tp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373082; c=relaxed/simple;
	bh=r+0ckVH74UbZfZjJBGmvrgVqk8ReJFde2rNLTNHjHNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOAe3JBsR6TrJYi/KvSpkak/MTfVo1lANbhLcCiEUAvz3yWsUaNw2zWTFe6z2a7fboR7OqIhvYjLI7Dy6yzreMPB1qtuH0LJ5mdb9faagaRueoxNNI4CeFMxpJZdw+XOjBePPgZVpRkiTM4o3VX/OzMm4DybqRvcl5r4kBs/rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YImIuSrB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YImIuSrB"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 92DF72107AA0;
	Wed, 12 Feb 2025 07:11:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92DF72107AA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739373073;
	bh=89G3mbkSyJGvJjdcUMzwGSUxpaBUotr9UPBCInppSig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YImIuSrBV7M/Go4FDDGe0yUutM1qUlIKzl/D81DizpSpqdgpWxfSA87uQ/cMi+NU1
	 ZRvbiQwpdgh1tzpBpXmZTf1k11wiETHY58bpMX5qz9CrphchD1BexG/KkzagesR2i4
	 j8VMx+ZHuQYVsOSFtFlm2pblCPIpqZ4kMd9vC4Xw=
Message-ID: <d36501b0-e546-4de6-aa73-85613b276366@linux.microsoft.com>
Date: Wed, 12 Feb 2025 10:11:12 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Support static-only builds
To: Alyssa Ross <hi@alyssa.is>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20250211211651.1297357-3-hi@alyssa.is>
 <9316b48f-64f0-469b-8dde-1386aa13d384@linux.microsoft.com>
 <87a5aro74k.fsf@alyssa.is>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <87a5aro74k.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/2025 4:16 AM, Alyssa Ross wrote:
> Daniel Burgener <dburgener@linux.microsoft.com> writes:
> 
>> On 2/11/2025 4:16 PM, Alyssa Ross wrote:
>>> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>>> index 32ad0201..7acd51dd 100644
>>> --- a/policycoreutils/Makefile
>>> +++ b/policycoreutils/Makefile
>>> @@ -1,5 +1,10 @@
>>>    SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll unsetfiles
>>>    
>>> +PKG_CONFIG ?= pkg-config
>>> +
>>> +LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
>>> +export LIBSELINUX_LDLIBS
>>> +
>>
>> I think that in the DISABLE_SHARED case, the pkg-config command needs
>> --static as well.  I tried your patch, and I get errors that the
>> downstream users of libselinux have undefined references to libpcre2,
>> and they are being build without -lpcre2-8.  Based on the pkg-config man
>> page, it looks like Requires.private libraries are only included if the
>> --static flag is passed.
> 
> I think it's generally expected that the user set
> PKG_CONFIG="pkg-config --static" when they want static linking.  See
> e.g. <https://bugs.freedesktop.org/show_bug.cgi?id=19541#c3>.

Thanks for clarifying.  Yes, this command builds everything for me:

make DESTDIR=~/obj PKG_CONFIG="pkg-config --static" DISABLE_SHARED=y install

However, the binaries still appear dynamically linked when I investigate 
them with the "file" command.  Am I missing some other step?

> 
>> I also see that restorecond is not including -lpcre2-8.  It probably
>> needs the same treatment as policycoreutils/*.
> 
> Does it fail to build for you?  It builds DISABLE_SHARED=y for me

Now that I added PKG_CONFIG="pkg-config --static", restorecond is 
building.  However, as above, it appears dynamically linked.

> 
>> Finally, I was unable to get the install-rubywrap and install-pywrap
>> targets to build with DISABLE_SHARED=y.  I wasn't able to figure out the
>> ultimate issue there.
> 
> I think Ruby and Python bindings need to be shared libraries, so it
> doesn't make sense to build them with DISABLE_SHARED=y.

Fair enough. I think it would be helpful if these caveats could all get 
documented.  I just tried following the README.md instructions and 
adding "DISABLE_SHARED=y", which as mentioned, didn't work.  If 
"DISABLE_SHARED" requires other options to work, it seems like that 
should at a minimum be documented.

-Daniel

