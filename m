Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92C13B293
	for <selinux@vger.kernel.org>; Thu,  5 Feb 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261858; cv=none; b=NSLGSh82zn775TEkS++z9BcFDMPHDZlbPlHQtJv6fuwJ43ycx25cVtC9D1sCLEGS4gHuy/TbjMUExvhePFSVHeWy/2IQqdq/GfgKYiFaHqXPQU0oeRB368rhWRZhLblK/XvMjUhE2PCa6UIPyh6CyB69gm/x2WktuN9cvFRxiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261858; c=relaxed/simple;
	bh=nH0CMXvEbMu7ZkoHDWIvtduIVPxtJ+pS0i0govE2PF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU4Uex0fTbHCT6meRtNvvHHSxWlCQKTOYOp9ujnWv+xOIEIpLWlkQhWioPU40LiyzbHwamAJ8M08VyIKWRbnBD4RZXhtOmesvSX31UDbvCa0m7OtbbSm0Yb0DubjhH0abdL1cFDDCtYxRSFn6ELmbBnf2Nt18o52YyCsNecDXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pVjQIFXD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pVjQIFXD"
Received: from [10.131.18.45] (unknown [167.220.2.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4EDE020B7165;
	Wed,  4 Feb 2026 19:24:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EDE020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770261858;
	bh=PJcFJ5QYDBjjK9ol6hGuHjhOOSU0KT2TjMXccUL1VHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pVjQIFXD3i7/aJ9yD6ANnXzW1dC7XcV7ogFBA3aVVCwYKEqMdcU/0b07Wh3pkPgpI
	 +jEPH++s/sFfxBzvytSKPDlK1WOWRIIQJg0q95o6rCspjt5D6U+Yn+PvUI72lqZvyZ
	 5wr7A+ygQmwf5yoZUJMvR1k53JkplX52pinGc0jM=
Message-ID: <5f543094-2935-44c7-a566-cb508196a307@linux.microsoft.com>
Date: Wed, 4 Feb 2026 19:24:17 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH userspace v2] libsepol: add bpf_token_perms polcap
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
References: <20251008233305.2098-1-ericsu@linux.microsoft.com>
 <aXwYG58XDo-L3Pni@anduin.perfinion.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <aXwYG58XDo-L3Pni@anduin.perfinion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/2026 6:31 PM, Jason Zaman wrote:
> On Wed, Oct 08, 2025 at 04:33:04PM -0700, Eric Suen wrote:
>> New policy capability 'bpf_token_perms' required by patch to support SELinux
>> for BPF token control:
>>    https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.microsoft.com/
>>
>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Thanks, merged.
> As discussed in the recent maintainer call, this will be in the 3.10
> release soon.
>
> wkr,
> Jason

Thanks a lot, Jason.

>> ---
>> Changes in v2:
>> - Rebase to the latest changes
>>
>>   libsepol/include/sepol/policydb/polcaps.h | 1 +
>>   libsepol/src/polcaps.c                    | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
>> index 5a3fbdb4..ef529e76 100644
>> --- a/libsepol/include/sepol/policydb/polcaps.h
>> +++ b/libsepol/include/sepol/policydb/polcaps.h
>> @@ -21,6 +21,7 @@ enum {
>>   	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>>   	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
>>   	POLICYDB_CAP_MEMFD_CLASS,
>> +	POLICYDB_CAP_BPF_TOKEN_PERMS,
>>   	__POLICYDB_CAP_MAX
>>   };
>>   #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
>> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
>> index 526f35ed..31b52d70 100644
>> --- a/libsepol/src/polcaps.c
>> +++ b/libsepol/src/polcaps.c
>> @@ -20,6 +20,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
>>   	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
>>   	[POLICYDB_CAP_FUNCTIONFS_SECLABEL]		= "functionfs_seclabel",
>>   	[POLICYDB_CAP_MEMFD_CLASS]			= "memfd_class",
>> +	[POLICYDB_CAP_BPF_TOKEN_PERMS]                  = "bpf_token_perms",
>>   };
>>   
>>   int sepol_polcap_getnum(const char *name)
>> -- 
>> 2.50.1
>>
>>

