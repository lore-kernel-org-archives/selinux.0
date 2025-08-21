Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069725B30E
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800512; cv=none; b=cZ4XLS/5W0Buw3Ouv/EtAUhvwOFipEZzXEiN41sARy0TtGurHPAUZprpE093/elevtIIn6rJuOiAPU9iBkQKu2FJHDOkur08GyYIofgmgHaV5eTq2/v8yLrcpNS5wX0uzHo+MI56fq2PR/fiHZo5tL5prsutI4elMqLHJ8WKGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800512; c=relaxed/simple;
	bh=5ifNQ/emdveSDOEGf2+g5I4JFE5yb99Nr6Ia6MrCMDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAZh7nBcT5DXZxDm71TdSCPRMsDpnnwPCa/tMxo7tJpJyQm0+DBjiUIJXVWBtm5vzP2egFZo0CS3OI+KkJ1q9gmShIABV3yaG7QthF+wW9yGYPu2CLViz8OI5cIoAADIS3ZhCMZFbpBsWSlUVcKA9ThHGtdHzGV8omMnyPmK4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PU0BnDf5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PU0BnDf5"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BA4F2116DA5;
	Thu, 21 Aug 2025 11:21:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BA4F2116DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755800510;
	bh=lI8bnenTFm22DfJI5Yieel3Ya7XdQV9qPGgaVY10A4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PU0BnDf5lLy3kYLfkMpyNaZ0N++oYIS/T22OOqg9SiCon/fq6bzDUxA957A5QsXu8
	 wYelHO3O6zkspf/DDM7rzeWUWrLmNLCnaGHEN5jW4c4/Vj3u9yAtXqoxHCSeKyqIiX
	 nQQf14E2IsjLTpEbSSIRXA9s5r4Qlk26ns/nBnyo=
Message-ID: <b61eb6c4-4fd3-462f-9e74-d0006f8d488d@linux.microsoft.com>
Date: Thu, 21 Aug 2025 11:21:49 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite v2] tests/bpf: Add tests for SELinux BPF token
 access control
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com,
 stephen.smalley.work@gmail.com, omosnace@redhat.com
References: <20250817191031.1150-1-ericsu@linux.microsoft.com>
 <CAKrb_fEMvB2h0uwwm3ZAWXXoEfA6Yk634njGpWoW8hDOQLbMEQ@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAKrb_fEMvB2h0uwwm3ZAWXXoEfA6Yk634njGpWoW8hDOQLbMEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/2025 8:11 AM, Daniel Durning wrote:
> On Sun, Aug 17, 2025 at 3:10 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>> This patch adds new tests to verify the SELinux support for BPF token
>> access control, as introduced in the corresponding kernel patch:
>>    https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.microsoft.com/
>>
>> Four new tests are added to cover both positive and negative scenarios,
>> ensuring that the SELinux policy enforcement on BPF token usage behaves
>> as expected.
>>    - Successful map_create and prog_load when SELinux permissions are
>>      granted.
>>    - Enforcement of SELinux policy restrictions when access is denied.
>>
>> For testing purposes, you can update the base policy by manually
>> modifying your base module and tweaking /usr/share/selinux/devel as
>> follows:
>>    sudo semodule -c -E base
>>    sudo cp base.sil base.sil.orig
> Should be sudo cp base.cil base.cil.orig.
Thank you so much, Daniel, for reviewing this.
>>    sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>>    sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>>    sudo semodule -i base.cil
>>    echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>>    sudo semodule -i bpf_token_perms.cil
>>    sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>>        /usr/share/selinux/devel/include/support/all_perms.spt.orig
>>    sudo sed -i "s/"map_create/map_create map_create_as/" \
>>        /usr/share/selinux/devel/include/support/all_perms.spt
> You have an extra quotation mark here just before map_create.
>
>>    sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>>        /usr/share/selinux/devel/include/support/all_perms.spt
>>
>> When finished testing, you can semodule -r base bpf_token_perms to
>> undo the two module changes and restore your all_perms.spt file from
>> the saved .orig file.
> Might be best to do a sudo dnf reinstall selinux-policy-devel to make
> sure everything is reset.
>
>> Changes in v2:
>> - Removed allow rule for 'kernel_t' in test_bpf.te which was added due
>>    to a bug in the kernel
>> - Cleaned up other unnecessary rules in test_bpf.te
>> - Added token_test.c which was missing from previous patch
>>
>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>


