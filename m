Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE434D913
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728264; cv=none; b=WbhO+I85g8Ax+MfdUkSrIOq79NRqXNH4n38WquzFrIZhAGhT06wKaJcARDIVYrrq9WJWBs4ihzY1EBHJcVz7soYn3K0ikDieO96aNPobvyyB4jD0ZKAUDWQAs2Efe48SyuXrYRwe8yy/LvBa7vjBd6kwSksTqINnYD8EZFhIBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728264; c=relaxed/simple;
	bh=jd0pTZliMrbeZH+EP248qTZhQ3owXXjnr5jxpL/AMgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P8YgHVIes8gvA9GqM9so7uS3nMwPuGOOHIhZRH5XukBUS3RBKfVF87XWe5nM4/37xb5qPlq2Sp90PjdswDqMHw0f5k21ehfpfUItao3e8SPCDvIj0oeJVVmGCk9ixMz4WtEu0r4zGWaRWgVps0ya+OTjbtnN29OEubyGy3YrbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=mY6FyyK3; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="mY6FyyK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1767728260;
	bh=jd0pTZliMrbeZH+EP248qTZhQ3owXXjnr5jxpL/AMgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mY6FyyK3Wx5vAG/D4gYrG+finUm0Z8cawa7ya7uz3+AgU6KkpOHwqWDz85jferjZe
	 VmmyPaygzwT5FtyqvL61onDP8C2grI26U/C2qTsyug2qM3uYLKAHyiZphmp/vsqaNR
	 85kP8wTfSEMDbLvGDGSNGDXgETzoHHTIaUALvKXk=
Received: from debian (debian.lan [IPv6:2a10:3781:2099::87a])
	by markus.defensec.nl (Postfix) with ESMTPSA id 23757240264;
	Tue, 06 Jan 2026 20:37:40 +0100 (CET)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: SELinux mailing list <selinux@vger.kernel.org>
Subject: Re: RFC systemd-sysext/confext image context mounts
In-Reply-To: <6692b25d-cfcc-4bde-a115-889be530e31a@linux.microsoft.com> (Chris
	PeBenito's message of "Tue, 6 Jan 2026 13:55:34 -0500")
References: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
	<87o6n6iskb.fsf@defensec.nl>
	<6692b25d-cfcc-4bde-a115-889be530e31a@linux.microsoft.com>
Date: Tue, 06 Jan 2026 20:37:39 +0100
Message-ID: <87jyxuilbw.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris PeBenito <chpebeni@linux.microsoft.com> writes:

> On 1/6/2026 12:01 PM, Dominick Grift wrote:
>> Chris PeBenito <chpebeni@linux.microsoft.com> writes:
>> 
>>> Systemd provides tools for composing directories like /usr and /opt
>>> (system extensions, sysext) or /etc (configuration extensions,
>>> confext).   These tools create an overlayfs at the target location,
>>> with the root filesystem and extensions.  While they support raw
>>> directories, files, and mutable filesystems, my current concern is
>>> with extending immutable distributions at runtime using additional
>>> immutable images.
>>>
>>> The challenge lies in ensuring proper labeling before deploying an
>>> image, which is problematic for third-party images lacking labels or
>>> using incompatible ones.  I haven't made any patches yet, as I want to
>>> consult this group and the systemd developers first.  My proposal is:
>>> for internally labeled filesystems (ext4, etc.), have the tools
>>> validate the image's root directory label.  If validation fails, apply
>> Sounds fragile as these filesystems by definition have more then
>> just a
>> root directory.
>> 
>>> a context= mount using the label from the contexts/systemd_contexts
>>> file in the policy.  I'd probably also add options in sysext.conf(.d)
>>> and confext.conf(.d) to override this behavior, such as for specifying
>>> an alternate label for the context mount.
>>>
>>> What are your thoughts?
>> I am not opposed per se but feels inconsistent. Consider for
>> example verity authentication which will also most likely be used in
>> these types of scenarios: why would one be able to deal with verity but
>> not with selinux labels?
>
> A third party would provide the hashtree and root hash along with the
> image.  If you're referring to a signature, that would be provided
> too. Are you expecting them to also put out an image every time
> someone comes up with a new policy variation?

Sounds like that won't be an issue then. Good. I don't think in terms of
"them". I would probably use the same key/crt for both the hosts root as
well as extension images. I also think that I would probably update my
extensions if a change to the hosts policy affects them negatively. I am
not sure if systemd.v (vpick) currently works with extensions and or if
there are plans to make that work but I can see the potential benefits
in that regard

>
>
>> Also wondering where systemd is going to go with extensions will we get
>> per-user instances that work together with systemd-mountfsd like we
>> currently have with systemd-nspawn? If so how will that affect this design.
> Can you elaborate?  I'm not familiar with these aspects.
>

systemd-mountfsd allows unprivileged users to request it to mount images
on their behalf. I don't know how per-user extensions for say ~/.config
and/or ~/.local(/share)? would be implemented technically but I have no
doubt that if there is a desire/interest for such functionality that Poettering
will be able to implement it.

I imagine that it could work similar with for example starting a
systemd --user service unit with RootImage= or systemd-nspawn -I ran without
root. Which by the way present similar challenges.

But. Keep in mind that we have container, root, extension and portable
image types. They all have similar challenges and aside from root images
they can be imported with importctl. importctl --user currently works
for container images and so I have no reason to believe that it will not
be made to work if there is a desire for per-user extensions and/or portables.

Again. Not opposed per se. Just contributing my 2 cents. Happy to share
my thoughts.

-- 
gpg --auto-key-locate clear,nodefault,wkd --locate-external-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
