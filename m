Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F889176251
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526153; cv=none; b=Psjq1lqtHRx2mdXnO4clt60Ez/OEE1brMpriBzbneQoDXAfB8G9Weq/vGaXcC5ZozD8zIAh+2PPAs0DgqPiV32Fi/u7q2M2fUC76PmHsJD2EJH5Co7nIRFV1VD0sihLj2a0f3V+pwqzXDj4Xjpzxmw6OYXDwV9MzrP70hQAhaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526153; c=relaxed/simple;
	bh=DkkglnW5WN0vwOP3nALWZ9cDUq9mXtuubXaMZ9pg7S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TBDeNBmOduILs1EBsoSJF3Iwv3I1pz0SkpFf6uNOllQAyF8/VjHtD+UmElJpTbrpNoD+f2PxL1EKsCBCbWmd0mXltfSPsjGfgkVnJ4axyDj2hXamF6S4ximcOHR4RTBTbS40iHIc9+3A8F14IhFnEeDfcIyqvNjlMHBoMbfNDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Or6VT1nA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Or6VT1nA"
Received: from [192.168.254.48] (c-73-86-61-56.hsd1.md.comcast.net [73.86.61.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A51220BEBE6;
	Wed, 13 Nov 2024 11:29:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A51220BEBE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731526150;
	bh=vUsmxlPwsoDaIluOuoxnzaXFSoD20L5opQktJNreDn0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Or6VT1nAAPrXDIEjiUMjl5xHm2BkN0m1IyMHypKmQa4Mz1WoDcOdHec3JH5TNon99
	 APLxqQo6xu0LlTT55KgVF+PTbaI++Htj4U8egP4lYbIkO8GQMPLdXqbdsQua6BReZi
	 4gRdoRAGMh4A+0Foab69PR4+Db+8oRYNYJsjCJ14=
Message-ID: <ce0abacc-f350-4c1c-b52e-2c54c1c94fcf@linux.microsoft.com>
Date: Wed, 13 Nov 2024 14:29:08 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Adding a dyntrans in systemd pid1's forking
To: SELinux mailing list <selinux@vger.kernel.org>, bluca@debian.org
References: <34e77b6f-2c76-4bf9-8e3f-ac01047c952d@linux.microsoft.com>
 <8568d29a-1281-41ae-b693-2cdbff32c333@linux.microsoft.com>
 <yu6ym23durwgcu2vvt7vuekyfwzufbicl6t2suiayqn7j5sfa7@7yczpfibdthm>
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <yu6ym23durwgcu2vvt7vuekyfwzufbicl6t2suiayqn7j5sfa7@7yczpfibdthm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/2024 1:07 PM, Kenton Groombridge wrote:
> On 24/11/13 11:07AM, Chris PeBenito wrote:
>> On 11/6/2024 10:21 AM, Chris PeBenito wrote:
>>> I've recently become aware of systemd's credentials feature[1].  In a
>>> nutshell, the intent is to reduce privilege in units by systemd itself
>>> copying the credentials (crypto materials, passwords, though in practice
>>> it could be anything) and placing it in /run/credentials, with access
>>> managed by namespacing.  This is intended to eliminate the need for the
>>> daemon in the unit directly accessing the data.  My concern is the
>>> possibility of inadvertently leaking credentials or abuse.  i.e. putting
>>> in
>>>
>>> LoadCredential=foobar:/etc/shadow
>>>
>>> This illustrative, as systemd can't read shadow if it's confined, but
>>> you could replace shadow with a private key or any other highly
>>> confidential data systemd needs to access.  The common response to my
>>> concern is systemd units should be protected at high integrity; only
>>> root can modify them, etc.  However, I think we can do better to reduce
>>> the possibility of errors.
>>>
>>> I've discussed this with one of the systemd maintainers, and I'm
>>> proposing this change:
>>>
>>> 1. pid1 forks (to pidN) to run the unit, as usual.
>>> 2. pidN does security_compute_create() using the current domain and the
>>> label of the unit to get a new domain.
>>> 3. pidN does setcon() to the new domain.
>>> 4. pidN runs the unit as per usual (including the credentials stuff)
>>>
>>> Then we'd need to add something like this to the policy:
>>>
>>> allow init_t httpd_initrc_t:process dyntransition;
>>> type_transition init_t httpd_unit_t:process httpd_initrc_t;
>>>
>>> I have not yet prototyped this, but based on my discussion with the
>>> systemd maintainers, this should be doable.  I believe the added benefit
>>> is we can decompose initrc_t's privilege and maybe even reduce init_t's
>>> privilege.
>>
>> Hearing no objections, I've done an initial implementation:
>>
>> https://github.com/systemd/systemd/compare/main...pebenito:systemd:pidN-selinux-setcon
>>
>> If there is no policy in place, it does not incur new denials.  One nice
>> thing I found is that the unit name is available, so I used that in the
>> security_compute_create_name_raw() call.  I tested by adding the following
>> systemd-networkd.service drop-in:
>>
>> [Service]
>> LoadCredential=shadow:/etc/shadow
>>
>>
>> I added the following to the policy:
>>
>> type systemd_networkd_initrc_t;
>> domain_type(systemd_networkd_initrc_t)
>> role system_r types systemd_networkd_initrc_t;
>> allow init_t self:process setcurrent;
>> domain_dyntrans_type(init_t)
>> allow init_t systemd_networkd_initrc_t:process dyntransition;
>> type_transition init_t systemd_networkd_unit_t:process
>> systemd_networkd_initrc_t;
>> domtrans_pattern(systemd_networkd_initrc_t, systemd_networkd_exec_t,
>> systemd_networkd_t)
>>
>>
>> These changes resulted in this denial:
>>
>> Nov 13 15:10:54 azurelinux-vm audit[605]: AVC avc:  denied  { read } for
>> pid=605 comm="(sd-mkdcreds)" name="shadow" dev="sda2" ino=18058
>> scontext=system_u:system_r:systemd_networkd_initrc_t:s0
>> tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
>>
>>
>> The remaining policy for systemd_networkd_initrc_t would look like (denials
>> summarized by audit2allow):
>>
[... cut ...]
>> allow systemd_networkd_initrc_t bin_t:file { execute execute_no_trans getattr map open read };
[... cut ...]
>>
>> This seems like a very promising way to break up initrc_t, limit privileges,
>> and prevent administrator errors.  What do you think?
>>
> 
> Overall I like the direction this is going! I am curious, though, about
> whether this will affect systemd units' ExecStartPre=, ExecStartPost=,
> and similar directives.

It would affect Exec* directives in a unit and theoretically any other 
directives that generate a call to exec_invoke() in the systemd code.  I 
placed the setcon() immediately before

> One of the problems I have when writing policy for some systemd units is
> these directives will run commands normally under init_t instead of the
> resulting daemon domain. A unit may, as an example, want to remove a
> file on ExecStartPre=, which will run as init_t and therefore will need
> to be allowed to do so by policy if the command there is a simple
> /bin/rm.

This type of behavior is one of the secondary reasons I've been looking 
in to this.  In refpolicy, if init_t execs a bin_t file, it runs in 
initrc_t.  Then, because of unit-specific Exec* that run bin_t stuf, 
initrc_t gets bloated with permissions which could be (ab)used by other 
units.


> Will this be extended to have these commands run under the unit's
> corresponding initrc_t domain if there is one? That would solve so much
> headache when dealing with these types of units and also allow breaking
> up init_t potentially further.

This initial implementation does that; note the bin_t 
execute(_no_trans).   That's the unit running systemd-networkd-wait-online.


--
Chris
