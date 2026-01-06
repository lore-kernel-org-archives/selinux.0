Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58333AD8E
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717848; cv=none; b=sBGePk4cPkbZqtPZeygD9QiXpsQ+sYU8iPwZZFOvG63eaLwsDFeKRZFY04e8lwITUdRK+1gckMZTDNszVi6Gog2LTseV3qHYILge7WDk6TRwLBSpjCbWNjW6bhWg30jL56PRLmKg4YopN9pdxPP68Z9XJB1p2SYz+XKgPEMXZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717848; c=relaxed/simple;
	bh=t6MEl16EldfvexF5bhqlU+e5UHGhrRRGSvxJ4wCNjJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2p5VaF24dwmtqfZnHX17n/DMsHHqL1FNmuA16FXrw0Od0agKmwua02gai0iLziGzIe+tIgYv3HWDl1Xmz2nVwxXmr4dH/sa1D5xwMus+xDukdFQkYljtzq3/9dGckZ7bBc9vsMKUm3E8c1FRiVNVJLnyYSPAbZdT9+NLis1Um8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OREGokT2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OREGokT2"
Received: from [192.168.254.48] (c-69-251-182-238.hsd1.md.comcast.net [69.251.182.238])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BE9B2016FF3;
	Tue,  6 Jan 2026 08:44:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BE9B2016FF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767717846;
	bh=NJMunAMeBCif939a8pQAF23aQqhZ6GQOzD5ivLZdwZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OREGokT256anOeAWP+Bj6dvFRHBwDFohFjf+ZgzCP0LHGoFtL313AAFipKTkDDwG4
	 ME2okbkJhI2Ec51s7wQ1nDl5qEqUO/gOovMe1KuDNetUWaM5pf8aeHcSoz7DTVWxu3
	 zyG0k1pWB4saCMKPFMgcobXso6OobS9IVTuHMyMw=
Message-ID: <508aca6e-7b32-4b4a-b309-6e6faebf0b8e@linux.microsoft.com>
Date: Tue, 6 Jan 2026 11:42:39 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC systemd-sysext/confext image context mounts
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SELinux mailing list <selinux@vger.kernel.org>
References: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
 <CAEjxPJ6yhZSbzMWXq4sQQ7hLydzzmz3i_Bnj9nhskdr0rWf5Hg@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <CAEjxPJ6yhZSbzMWXq4sQQ7hLydzzmz3i_Bnj9nhskdr0rWf5Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/6/2026 11:20 AM, Stephen Smalley wrote:
> On Tue, Jan 6, 2026 at 11:08 AM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
>>
>> Systemd provides tools for composing directories like /usr and /opt
>> (system extensions, sysext) or /etc (configuration extensions, confext).
>>    These tools create an overlayfs at the target location, with the root
>> filesystem and extensions.  While they support raw directories, files,
>> and mutable filesystems, my current concern is with extending immutable
>> distributions at runtime using additional immutable images.
>>
>> The challenge lies in ensuring proper labeling before deploying an
>> image, which is problematic for third-party images lacking labels or
>> using incompatible ones.  I haven't made any patches yet, as I want to
>> consult this group and the systemd developers first.  My proposal is:
>> for internally labeled filesystems (ext4, etc.), have the tools validate
>> the image's root directory label.  If validation fails, apply a context=
>> mount using the label from the contexts/systemd_contexts file in the
>> policy.  I'd probably also add options in sysext.conf(.d) and
>> confext.conf(.d) to override this behavior, such as for specifying an
>> alternate label for the context mount.
>>
>> What are your thoughts?
> 
> What does validate mean in the above? Check that it matches the
> mountpoint's match in file_contexts? Or just check that the context is
> valid under the currently loaded policy?

I meant the latter.


> A potential problem with only checking the root directory label is
> that those are generally the same across all policies derived from
> refpolicy, whereas you are more likely to find invalid or inconsistent
> contexts on leaf nodes.

I was thinking about grossly different policies, but this is a good 
point for slightly incompatible policies.  My main concern for doing 
validation across the whole fs is with how expensive it could get if the 
extension is big.  This could also be an argument for having 
configurable behavior in the sysext/confext.conf, as a tradeoff for only 
checking the root dir label.



