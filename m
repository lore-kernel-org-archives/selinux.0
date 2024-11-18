Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2F1B6CF3
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944160; cv=none; b=QShTYqYo2z/Fwh/1SUBVw9XfgIuiU7j3NuHLOsaPXiFPwS6VMUgHo/7wBUw93YmQC0+ICDKMl5OvXq3ebEPCb7bMBf2BxsOCoORbNsF7RJ/zXMOVPXdEkfW4NojwpaWkQlVMLu0YYlHJRm9n7+stgEtVfS1RfoDI1sFBiY3HZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944160; c=relaxed/simple;
	bh=E2HjxNERFo24G8IUMG73YnBT6iNMO99le5YOdPOfEHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ev4sXQOhLLlULcSCKs+j+iOq6t0BbFCAc2B++2QxWnq/b6Si3n9bduUHqpOpR5YNsmBdxp3PCqipHo2RsFR1K0F6zye0MrcSz+8IiCAuuhYWVxC6aHT+YDl9rI07FPVF0w5JwT475gD8KO/XXyG7S/715u8Nt5iTUtBiYLadEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eM8cqUw1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eM8cqUw1"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B774206BCEC;
	Mon, 18 Nov 2024 07:35:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B774206BCEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731944158;
	bh=dAQT1PdEcsWCO7o+NU7bR0+MZGpQqqgrNDcE+7aQg5w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eM8cqUw1OTN3f+rPBMdcV4cVPTJ8rR9PJLOz7Iz8Md+q4faHIhPH6NJT+xxdKZY7i
	 2uFYECbtKAG/l6iXwoxthWaW3B+rYy47ron1RyUIKhJAmC9+DBvNeUN2HSYOqblOKn
	 GPXnVRUl/FCXNWLMmCJjyh1qtAfHpjm7K4BpA6Qo=
Message-ID: <342b4afd-3a1a-41bd-8e2d-63eebb1fbcd2@linux.microsoft.com>
Date: Mon, 18 Nov 2024 10:35:56 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/22] selinux: harden against malformed policies
To: cgzones@googlemail.com, selinux@vger.kernel.org
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
 <20241115133619.114393-23-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20241115133619.114393-23-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/2024 8:35 AM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> With the SELinux namespace feature on the horizon it becomes important
> to identify and reject malformed policies at load time.  Otherwise
> memory corruptions can compromise the kernel or NULL-pointer dereferences
> and BUG() encounters can bring systems down.  Currently this is not a
> security relevant issue since loading a policy requires root privileges
> and permission of the current loaded SELinux policy, making it one of the
> most privileged operation.
> 
> The first 9 patches are cleanup commits with overseeable diffs.
> 
> Patch 10 unifies the underlying type used for security class identifiers.
> 
> Patch 11 to 21 add various checks at policy load time to reject malformed
> policies.
> 
> Patch 22 needs some discussion:
> It limits the valid set of characters and the length for strings defined
> by policies.  Currently there are no restrictions, so control characters
> are accepted, e.g. Esc as part of a type name, and their length can be
> arbitrary.  Human formatted security contexts however must not be
> arbitrarily long, one example is they must fit in a page size for
> selinuxfs interaction and network associations.
> Thus the patch introduces the following restrictions:
>    * Disallow control characters
>    * Limit characters of identifiers to alphanumeric, underscore, dash,
>      and dot
>    * Limit identifiers in length to 128, expect types to 1024 and
>      categories to 32, characters (excluding NUL-terminator)

I believe that those first two restrictions match what CIL will do today 
(https://github.com/SELinuxProject/selinux/blob/9b4eff9222b24d4b5f2784db281f4f53019263b0/libsepol/cil/src/cil_verify.c#L96), 
but the length restriction in CIL is 2048.

https://github.com/SELinuxProject/selinux/blob/9b4eff9222b24d4b5f2784db281f4f53019263b0/libsepol/cil/src/cil_internal.h#L49

I would think that we'd want to end up in a situation where the kernel 
is either equally restrictive or less restrictive than CIL.

-Daniel



