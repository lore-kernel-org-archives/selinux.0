Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAF4685;
	Wed, 17 Jul 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182754; cv=none; b=bFQIqbHrq2AY0jnRTMqWDUhBzCpj6wJYCYOIw5MELAzzET98Gkfk05u4oyt58fzHP68B69tJCfagRAIlrFIh6Hyr7pJO1ql+kkfUUq4geAwgp9tOeQoWMcLTHz0MAXSTne+fvyqXB4eH8jhQrwWdf8CO+piCErs/t021EvMMiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182754; c=relaxed/simple;
	bh=8o9beL6AlKCzXsXyfDU4H0SuyTluNFbx2nwe8j0c8NU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=k6adpPTI6TC1QUJRTtenysh9pA0PSPqScBH8Qf8ZuAW0L/B/DntJ2rdZbECgcPeGaICkNw20yuvY4B613m7pkBKgQaWwAivqfvha40K9zbMTMIo5fL0jJTfForoLummNjRpEyhF1ozF76O93WnYC0+iGJNM1xzYvwPjrNTS6LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP03V0x4DznbSL;
	Wed, 17 Jul 2024 10:18:30 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B8F0E1402C8;
	Wed, 17 Jul 2024 10:19:07 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Jul
 2024 10:19:04 +0800
Message-ID: <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
Date: Wed, 17 Jul 2024 10:18:57 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
From: Gong Ruiqi <gongruiqi1@huawei.com>
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
CC: <selinux@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wang Weiyang <wangweiyang2@huawei.com>
References: <20240702095401.16278-1-gongruiqi1@huawei.com>
Content-Language: en-US
In-Reply-To: <20240702095401.16278-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Ping.

On 2024/07/02 17:54, GONG, Ruiqi wrote:
> Currently for systems that only enable cgroup v2, the test script would
> fail to move the target process into the root cgroup since the cgroup v1
> path is used, which therefore makes the testcase fail. Add cgroup v2
> handling here so that no matter which cgroup version the CPU controller
> is bound to, the target process can always be moved to the root CPU
> cgroup.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  tests/task_setscheduler/test | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
> index c2fe8c6..fa1efb1 100755
> --- a/tests/task_setscheduler/test
> +++ b/tests/task_setscheduler/test
> @@ -20,12 +20,17 @@ vec( $rin, fileno($f), 1 ) = 1;
>  select( $rin, undef, undef, 5 );
>  close($f);
>  
> -$cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
> -if ( -w $cgroup_cpu ) {
> -
> -    # We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
> -    # cgroup so move our target process to the root cgroup.
> -    open( my $fd, ">>", $cgroup_cpu );
> +# We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
> +# cgroup so move our target process to the root cgroup.
> +$cgroup_v1_cpu = "/sys/fs/cgroup/cpu/tasks";
> +if ( -w $cgroup_v1_cpu ) {
> +    open( my $fd, ">>", $cgroup_v1_cpu );
> +    print $fd $pid;
> +    close $fd;
> +}
> +$cgroup_v2 = "/sys/fs/cgroup/cgroup.procs";
> +if ( -w $cgroup_v2 ) {
> +    open( my $fd, ">>", $cgroup_v2 );
>      print $fd $pid;
>      close $fd;
>  }
