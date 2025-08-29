Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDC33436D
	for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485601; cv=none; b=Gf02c4mo8akS6nMIvkvHSjsYCA7WISeKlrWgmm7Wpj2pBJvee7q5P+RKJHbgO7yukRa/oFCQruMvSS2Y/Ca5JVLTdGppyieZlMm33eWyUfw7AELzZjCQLQtv2vcIIHBkOzseMM4x/xH0K/B0IDjRScdWV0vB7MOQpO/6OP4dFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485601; c=relaxed/simple;
	bh=vcqLonl5Zl3DcF71/LkZ3oLaMv1kYQP3S3aNygQmYy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdhvvYFw8lTqERgVvdoKlU5O532qPBj/Ekcpr41G3rRvl1JZhLmlaGAYetXXeIbpAL7ZmfeRtesgyFJ5IzTv6gg/5Ls/Buh38lWVPAOyCG+YTTYB+fpA0mO844odO/pGadwzjHV4emUEFrxTEO2XtysbedAh3/uv+UTgcaKKch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y+B5KFzl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y+B5KFzl"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 074E02116276;
	Fri, 29 Aug 2025 09:39:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 074E02116276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756485599;
	bh=cCAb2B7p7YxaAqgWcNSg1Id4EnqSVSi8tSB/28vg5oQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y+B5KFzlwT1ni7lfm2jLzdCS6KlueqfDMfslSRZrgxLquqzv1PxgKIpp1KXq3yI3T
	 FwkgIZDZ0d/a/wgfsiTQ+eBBaiaGjVB0Qp64fw+6OzUpb9FK9bL1sL8JR7KkCilviY
	 jX+/64yTczdvuprgvYw1JFTJKdbx4we0OQM1Rizw=
Message-ID: <bfed15d8-7a7f-4a69-b165-d87e901efb74@linux.microsoft.com>
Date: Fri, 29 Aug 2025 09:39:58 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite v3] tests/bpf: Add tests for SELinux BPF token
 access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
 danieldurning.work@gmail.com
References: <20250821190312.1361-1-ericsu@linux.microsoft.com>
 <CAEjxPJ7VKyDMbkS-+LLdJY+Rcf=hcv25iPpVd63wtiOX=+pSYg@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAEjxPJ7VKyDMbkS-+LLdJY+Rcf=hcv25iPpVd63wtiOX=+pSYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/25/2025 7:21 AM, Stephen Smalley wrote:
> On Thu, Aug 21, 2025 at 3:03 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>> This patch adds new tests to verify the SELinux support for BPF token
>> access control, as introduced in the corresponding kernel patch:
>>    https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.microsoft.com/
>>
> No need to re-spin just for this, but this also depends on the
> corresponding userspace patch for libsepol.
>
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
>>    sudo cp base.cil base.cil.orig
>>    sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>>    sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>>    sudo semodule -i base.cil
>>    echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>>    sudo semodule -i bpf_token_perms.cil
>>    sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>>        /usr/share/selinux/devel/include/support/all_perms.spt.orig
>>    sudo sed -i "s/map_create/map_create map_create_as/" \
>>        /usr/share/selinux/devel/include/support/all_perms.spt
>>    sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>>        /usr/share/selinux/devel/include/support/all_perms.spt
>>
>> When finished testing, you can semodule -r base bpf_token_perms to
>> undo the two module changes and restore your all_perms.spt file from
>> the saved .orig file.
>>
>> Changes in v2:
>> - Removed allow rule for 'kernel_t' in test_bpf.te which was added due
>>    to a bug in the kernel
>> - Cleaned up other unnecessary rules in test_bpf.te
>> - Added token_test.c which was missing from previous patch
>>
>> Changes in v3:
>> - Added original license in 'token_test.c'
>> - Updated patch description to
>>      - replace 'base.sil' with 'base.cil'
>>      - Remove extra quotation mark in 'sudo 'sed -i "s/"map_create'
>>
>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
>> ---
>>   policy/test_bpf.te     |  39 +++
>>   tests/bpf/Makefile     |   5 +-
>>   tests/bpf/bpf_common.h |  10 +
>>   tests/bpf/bpf_test.c   |  59 +++--
>>   tests/bpf/test         |  21 +-
>>   tests/bpf/token_test.c | 543 +++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 658 insertions(+), 19 deletions(-)
>>   create mode 100644 tests/bpf/token_test.c
> If I run the tests manually ala "sudo ./tests/bpf/test", I see the
> following output during the new tests:
> ok 9
> unexpected userns_map_create/token_create: actual -13 <= expected 0 (errno 13)
> test_callback failed. unexpected error: -22 (errno 13)
> waitpid_child failed. unexpected error: 22 (errno 2)
> ok 10
> unexpected userns_prog_load/token_create: actual -13 <= expected 0 (errno 13)
> test_callback failed. unexpected error: -22 (errno 13)
> waitpid_child failed. unexpected error: 22 (errno 2)
> ok 11
>
> Generally we try to avoid/minimize spurious output from the tests for
> legitimate errors, so ideally you would eliminate this noise if these
> are in fact operating as intended.

Stephen - apologies for the delayed response. Yes, that's a great 
feedback. Let me look into it and update in next patch.

