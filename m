Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E41F37A1;
	Tue,  7 Jan 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266205; cv=none; b=GJxswlCwmvEUFfv/MGSwAyVMqdQG3A4aWq/FOgtwcc98jZWkvXl7UjQUFxVXbn9Jbv2shi7aoqTD4ehb3C0FFzk7T83jCQ5feq+UIyjh5C2jRZHiOiuSH0zOuJAnVkzgzuogmJbqznB6S0CUPVGlkGBl0lVLtw9a2VdRjRy9JEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266205; c=relaxed/simple;
	bh=BLvBXkcC6ssstTngM2MxSIifHbhzF+9k4d6CngTIMN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUarqRW72nEZyqtCgBg+CVHf2I6H97WH1/xfNA09N14w7nj5xUDbCqEy8r5q/oxI16vdzJD6x2qwrzGeD71z9SBZKYTlE3QC9JPjcAoDq0NSofF5q6AzxvFbOBXy901pkVQUQrVT4mewA25Jwv6mvScqqi7ma9kpZmHBHxfPkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ijSVPE01; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ijSVPE01"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id E41AB206AB9C;
	Tue,  7 Jan 2025 08:10:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E41AB206AB9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736266202;
	bh=7ddpPet55sgnfnLofuy1LQslUTu20r7I0nEzfZLkYYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ijSVPE01H9JNPGr1EMzstpni+NHe7hl0ZK05v73Xdle2NDWbPpfRYcdlhzuWlLjJ5
	 S+KFyNplFbImqHwzxIcLQRKl7XhDzGQw5fzCpvdUa7X9EAj1+xxPyS0sb9Mv+v3S9s
	 jAUUtX0JiLw/4e+Tgb5iopjIhnYzK44C5X+YOT7g=
Message-ID: <6b9cd467-cc34-4ded-b68e-c98bd5870537@linux.microsoft.com>
Date: Tue, 7 Jan 2025 11:09:59 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 22/22] selinux: restrict policy strings
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Joe Nall <joenall@gmail.com>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
 <20241216164055.96267-22-cgoettsche@seltendoof.de>
 <CAEjxPJ7NdTWu4dspY9cbPMtRsW_jERoRbKBsObbvsEnwgmZ8Ew@mail.gmail.com>
 <EF4B3759-2C4C-4A15-A721-6B2D0FAFD84F@gmail.com>
 <CAJ2a_Dcw3KQUNv1HQFp4qPOoZ972hjr6Qa2LAXTTv6SkV_Pd0A@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAJ2a_Dcw3KQUNv1HQFp4qPOoZ972hjr6Qa2LAXTTv6SkV_Pd0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/2025 9:04 AM, Christian Göttsche wrote:
> On Mon, 6 Jan 2025 at 00:26, Joe Nall <joenall@gmail.com> wrote:
>>
>>
>>
>>> On Jan 3, 2025, at 2:12 PM, Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
>>>
>>> On Mon, Dec 16, 2024 at 11:42 AM Christian Göttsche
>>> <cgoettsche@seltendoof.de> wrote:
>>>>
>>>> From: Christian Göttsche <cgzones@googlemail.com>
>>>>
>>>> Validate the characters and the lengths of strings parsed from binary
>>>> policies.
>> Excellent idea.
>>
>>>>   * Disallow control characters
>> Fine here.
>>
>>>>   * Limit characters of identifiers to alphanumeric, underscore, dash,
>>>>     and dot
>> Fine again.
>>
>>>>   * Limit identifiers in length to 128,
>> Fine again, our longest
>>   - type is 51 characters
>>   - attribute is 31
>>   - boolean is 46
>>   - role is 12
>>
>>>> expect types to 1024 and
>> I don’t understand what this means.
> 
> Similar to your list of the length in you policy boolean, role, user,
> class, and permission identifiers are limited to 128 charatcers (not
> including NUL), types (and attributes, which are just special types)
> are limited to 1024 characters, and individual sensitivities and
> categories are limited to 32 characters.
> 
>>
>>>>     categories to 32, characters (excluding NUL-terminator)
>> One category or the whole category string? A single category longer than 7 characters seems pretty unlikely and 32 is wildly short for the whole string.
> 
> This only affects individual sensitivities and categories, like "s9"
> or "c1023", not whole MCS/MLS parts.
> 
>> Joe
>>
>>> One option if we are concerned about breaking backward compatibility
>>> with policies in the wild would be to make these restrictions
>>> conditional on whether the policy is being loaded into a non-init
>>> SELinux namespace, similar to:
>>> https://lore.kernel.org/selinux/20250102164509.25606-38-stephen.smalley.work@gmail.com/T/#u
>>>
>>> That said, it seems hard to imagine real-world policies that would
>>> exceed these limits, and likely could make them even smaller.
>>> But as Daniel said, we should make them consistently enforced in both
>>> userspace and kernel, and potentially these should all be #define'd
>>> symbols in a uapi header that can be referenced by both.
>>> Looks like you left the type limit at 1024 despite Daniel's
>>> observation that CIL uses 2048 as the limit, but as you noted, given
>>> the page size limit on the entire context by various kernel
>>> interfaces,
>>> this is likely fine.
> 
> I interpreted Daniels comment more like a assessment what CIL
> currently constrains, not as a request for a change, maybe I
> misunderstood?

That is what I intended, yes.  My related request was "I would think 
that we'd want to end up in a situation where the kernel is either 
equally restrictive or less restrictive than CIL".  In isolation, my 
opinion is that the 1024 limit is fine, but I've been hoping James would 
chime in about the feasibility of dropping the CIL limit at some point 
to get them in sync.

FWIW we have a few generated type names internally that subjectively 
feel long to humans, but are still under 100 characters.  So 1024 is 
plenty of extra margin in my opinion.

-Daniel

> 
> Exporting the limits via a public headers seems reasonable.
> 
> Maybe for a smooth transition one could introduce a build time
> configuration (CONFIG_SELINUX_STRICT_IDENTIFIERS?).
> This configuration can be disabled by default, leading to identifiers
> not being rejected only logged.
> Than after two releases the default can change to reject instead of log.
> And after the next LTS release the configuration can be dropped again.
> 
>>>
>>

