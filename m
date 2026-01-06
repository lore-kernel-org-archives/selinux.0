Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D226ACC
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725984; cv=none; b=AfZURwSvqe6srdfvxan8sus2y2gL826to/o0ew8a7Smy0mzMrkfEQnKZIXZv6yVnDjDG+ErtMarNvcy72Nv8962WLvvp+kXW1ZRcyrcviP8TLygyBI2b/qYR1ON1ytYE2A7lj1tjqhKD7dj4cpf9ZbRfn4eVTkUKNQXrY3hA1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725984; c=relaxed/simple;
	bh=ZcD74K2P9YLckj5Fafsb4wBu7RhTI4yoxiKGISdU/pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bj338bjDxt/gTuk4ZcVHC/KHD0bjo9cATev8yAT0DNgRt9W27Et5VDaMb0z+16B5mupPR9IwGqU97YtFUpuPZV59sJ7LDQvJktstYEIttkyDhOCNEON5aZRvShb8bg0eczu1+dpViirqjcCi847UZ21QQR/xIHsUafNe4xWe/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H+EJC3CC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H+EJC3CC"
Received: from [192.168.254.48] (c-69-251-182-238.hsd1.md.comcast.net [69.251.182.238])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE38F2016FF2;
	Tue,  6 Jan 2026 10:59:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE38F2016FF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767725982;
	bh=RfA9SUVreRXDaqFmb8kXmMqf2fOIgzsPskLJjDw6pkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+EJC3CCp4g0fb5tc+pr+ltSxtMZoI94NvuywrcV6uowjq2PonBhOvMy7oYkUhInO
	 5EzhcBoYWIvm97uFfSUEEmOeSlOminD0i9bvIp/or62xQ4OYWqQeZCIelBHSnjGdiN
	 0seh5KgN3P5PiQEgdysRSRy9gPsub4C0AVKbLEY4=
Message-ID: <b9204287-fb00-4a3f-835f-a59a4a35588e@linux.microsoft.com>
Date: Tue, 6 Jan 2026 13:58:15 -0500
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
 <508aca6e-7b32-4b4a-b309-6e6faebf0b8e@linux.microsoft.com>
 <CAEjxPJ5insPOkSdUuv0ziWFT_8S0bJ5VUtQ0kyrjJMATqw-=Gw@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <CAEjxPJ5insPOkSdUuv0ziWFT_8S0bJ5VUtQ0kyrjJMATqw-=Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/6/2026 12:08 PM, Stephen Smalley wrote:
> On Tue, Jan 6, 2026 at 11:44 AM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
>> On 1/6/2026 11:20 AM, Stephen Smalley wrote:
>>> On Tue, Jan 6, 2026 at 11:08 AM Chris PeBenito
>>> <chpebeni@linux.microsoft.com> wrote:
>>>>
>>>> Systemd provides tools for composing directories like /usr and /opt
>>>> (system extensions, sysext) or /etc (configuration extensions, confext).
>>>>     These tools create an overlayfs at the target location, with the root
>>>> filesystem and extensions.  While they support raw directories, files,
>>>> and mutable filesystems, my current concern is with extending immutable
>>>> distributions at runtime using additional immutable images.
>>>>
>>>> The challenge lies in ensuring proper labeling before deploying an
>>>> image, which is problematic for third-party images lacking labels or
>>>> using incompatible ones.  I haven't made any patches yet, as I want to
>>>> consult this group and the systemd developers first.  My proposal is:
>>>> for internally labeled filesystems (ext4, etc.), have the tools validate
>>>> the image's root directory label.  If validation fails, apply a context=
>>>> mount using the label from the contexts/systemd_contexts file in the
>>>> policy.  I'd probably also add options in sysext.conf(.d) and
>>>> confext.conf(.d) to override this behavior, such as for specifying an
>>>> alternate label for the context mount.
>>>>
>>>> What are your thoughts?
>>>
>>> What does validate mean in the above? Check that it matches the
>>> mountpoint's match in file_contexts? Or just check that the context is
>>> valid under the currently loaded policy?
>>
>> I meant the latter.
> 
> The matching file context for the mountpoint would be a more precise
> check of whether the directory tree is labeled compatibly with the
> host OS. Regardless, to get the actual on-disk xattr value the process
> fetching it will need mac_admin permission and CAP_MAC_ADMIN in its
> effective capability set, which we generally don't allow even for
> unconfined domains, and use the _raw libselinux interfaces or the
> getxattr interface directly. Otherwise it will be automatically
> remapped to the unlabeled context if invalid.

This would probably be done with systemd-dissect, which, I believe, 
directly inspects the image, without mounting it.

