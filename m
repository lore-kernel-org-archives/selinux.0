Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE1270023
	for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681052; cv=none; b=D+59FWPYBylkMN2Hin3PKCXJrHDD6Tu9iMrpMbA7cizliSADXt7SuHXHWgwQrK3IbKFCVMGW4Abhteb+Je9/A03Hy7rSx1xIpTpdxj0GQLwAY9DpiyJBKhQ4N6df1jO0mKplEttENqRnR90iJjhxrvCyfo8sczlhOtzZmbTyTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681052; c=relaxed/simple;
	bh=D4NwanHkCkx1GyJhy1IUimxjxyaTEBt9K5csWzXuEWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIZPg0fybciNkLAy8+S2VKFCPsuszvyfs5aZBaD5/mrpra6Lkl+JiMRE7ElIC06TDTumsfDXzWL3vLt7SQu7X+QyAIi++mcf0mCe7shunbek9ILuxlpmZAPsM2cNpahE+sm9wqoXxsYo+3Rp7PZ8UaQKXNuL5h4iryF4EENrxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JzgbRFPv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JzgbRFPv"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A7072107A9A;
	Thu, 27 Feb 2025 10:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A7072107A9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740681050;
	bh=akCKmcYxc2XpLEoy24mWqqDpO2WeLguMOeUeQaOBvvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JzgbRFPvXDm1/bHULFrxopT2+56Hs4zzNcksdbnKQUi39/FwT+QImpjnK9icwuLQi
	 kl4kC/kcA2NfhGIps71Kan5eDW8dXJ38/GdrcvJqmCcODD1E8Sh7lG5OQVfyzQic9d
	 XZiUxPX+d8L6th/yPvVTbzz/zzXFVStinHV+FdjA=
Message-ID: <7ae30862-13ef-4875-a4fc-dff60c4c27b6@linux.microsoft.com>
Date: Thu, 27 Feb 2025 13:30:47 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>,
 Junichi <uekawa@chromium.org>, selinux@vger.kernel.org
References: <20241210115551.1225204-1-takayas@chromium.org>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20241210115551.1225204-1-takayas@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2024 6:55 AM, Takaya Saeki wrote:
> Currently, genfscon only supports string prefix match to label files.
> Thus, labeling numerous dynamic sysfs entries requires many specific
> path rules. For example, labeling device paths such as
> `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> requires listing all specific PCI paths, which is challenging to
> maintain. While user-space restorecon can handle these paths with
> regular expression rules, but relabeling thousands of paths under sysfs
> after it is mounted is inefficient compared to using genfscon.
> 
> This commit adds wildcard match to support rules efficient but
> expressive enough. This allows users to create fine-grained sysfs rules
> without burden of listing specific paths. When multiple wildcard rules
> match against a path, then the longest rule (determined by the length of
> the rule string) will be applied. If multiple rules of the same length
> match, the first matching rule encountered in the genfscon policy will
> be applied. However, users are encouraged to write longer, more explicit
> path rules to avoid relying on this behavior.
> 
> This change resulted in nice real-world performance improvements. For
> example, boot times on test Android devices were reduced by 15%. This
> improvement is due to the elimination of the "restorecon -R /sys" step
> during boot, which takes more than two seconds in the worst case.
> 
> Signed-off-by: Takaya Saeki <takayas@chromium.org>
> ---
> This patch is based on the RFC:
> https://lore.kernel.org/selinux/CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com/T/#t
>   security/selinux/include/policycap.h       |  1 +
>   security/selinux/include/policycap_names.h |  1 +
>   security/selinux/include/security.h        |  6 +++
>   security/selinux/ss/policydb.c             | 56 ++++++++++++++++++----
>   security/selinux/ss/services.c             | 13 +++--
>   5 files changed, 66 insertions(+), 11 deletions(-)

Takaya,

It sounds like below you were going to send a follow-up patch for this? 
I ask because we've recently had a similar use case come up that would 
benefit from this work and wanted to see if it was still in progress and 
if there was anything needed to help it along?

-Daniel
