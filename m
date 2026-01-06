Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED9A1E412A
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725823; cv=none; b=sCm+f2opmxy0T2aPeAf6r2me6S9YuJtofwIbUCUTqE4FfFxH9a7kvb/jqkI3fAyDwGFuJULFHJzRFxJy3EX2dhN9axFqihqE6cjFZ4XOWoBSo8isCIy/9dsmLzLbmzj45nckERh7c4OLT791pslMYudB7TECMZDklwoWo2SieY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725823; c=relaxed/simple;
	bh=34f+f98dEDzBK9k3mJPxf+PNVwKN0OWy6FMl5ylfGMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHwMBTaWlvNMt/ZNwbMiYUuD7p84vKvWPuJ7u0hWWs3+eevzVJtJyuxX5FSii/g9q3D3ocBqV3y5hlgtwG8pP0k6gOHL1hv42TXEYiLdvZZRvdiAwc5PDOh7Rj2MaQb8Alv5dgC8Z50Afc09J2XZHBlBsxbYynD/Ur1IqHDKDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HV3kXsYm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HV3kXsYm"
Received: from [192.168.254.48] (c-69-251-182-238.hsd1.md.comcast.net [69.251.182.238])
	by linux.microsoft.com (Postfix) with ESMTPSA id 162C62016FF2;
	Tue,  6 Jan 2026 10:57:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 162C62016FF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767725821;
	bh=izfPMFpfIa01Er2o2RRlic+cNhpX5qTDtmFei4/ggFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HV3kXsYmfIX7CGNzshBGGXn8aPua38yutBKhTKuGvNyhAclCT1yPJl20cCTBGmXOY
	 9k2eSJ7CiaPuaNQHKm0m+vupEFRHdV5voEOGoi7kqn3R8fUsNSdoE9vr/qu2dd7dw6
	 KCITEAcw3shvKCJ2FHdh2iU/YRXd+RnUPBjPEbXY=
Message-ID: <6692b25d-cfcc-4bde-a115-889be530e31a@linux.microsoft.com>
Date: Tue, 6 Jan 2026 13:55:34 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC systemd-sysext/confext image context mounts
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: SELinux mailing list <selinux@vger.kernel.org>
References: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
 <87o6n6iskb.fsf@defensec.nl>
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <87o6n6iskb.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/2026 12:01 PM, Dominick Grift wrote:
> 
> Chris PeBenito <chpebeni@linux.microsoft.com> writes:
> 
>> Systemd provides tools for composing directories like /usr and /opt
>> (system extensions, sysext) or /etc (configuration extensions,
>> confext).   These tools create an overlayfs at the target location,
>> with the root filesystem and extensions.  While they support raw
>> directories, files, and mutable filesystems, my current concern is
>> with extending immutable distributions at runtime using additional
>> immutable images.
>>
>> The challenge lies in ensuring proper labeling before deploying an
>> image, which is problematic for third-party images lacking labels or
>> using incompatible ones.  I haven't made any patches yet, as I want to
>> consult this group and the systemd developers first.  My proposal is:
>> for internally labeled filesystems (ext4, etc.), have the tools
>> validate the image's root directory label.  If validation fails, apply
> 
> Sounds fragile as these filesystems by definition have more then just a
> root directory.
> 
>> a context= mount using the label from the contexts/systemd_contexts
>> file in the policy.  I'd probably also add options in sysext.conf(.d)
>> and confext.conf(.d) to override this behavior, such as for specifying
>> an alternate label for the context mount.
>>
>> What are your thoughts?
> 
> I am not opposed per se but feels inconsistent. Consider for
> example verity authentication which will also most likely be used in
> these types of scenarios: why would one be able to deal with verity but
> not with selinux labels?

A third party would provide the hashtree and root hash along with the 
image.  If you're referring to a signature, that would be provided too. 
Are you expecting them to also put out an image every time someone comes 
up with a new policy variation?


> Also wondering where systemd is going to go with extensions will we get
> per-user instances that work together with systemd-mountfsd like we
> currently have with systemd-nspawn? If so how will that affect this design.
Can you elaborate?  I'm not familiar with these aspects.

