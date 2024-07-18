Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501B839E4;
	Thu, 18 Jul 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306075; cv=none; b=bqoP2ESCvLLqoVIuRLGwU0sBOJ1y2V/1KNuLSDOpFlviFJVSe1ppKMkx+n5uMoTpvGJNkG19AX9y4p9b4z7X0SDYUsckY6uIkemmkB8andtpaCi3Z3UZGw4ORCb2MAub6lJTO8H7SyLHJZS/ksdwG5TDRNiX71vvIuxeDRfNnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306075; c=relaxed/simple;
	bh=6fyIP5W4v8tQ/4k7BHsFZtX4LIIGKOtkCQDYet7dKkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RFqTDG0rJw9/mj4ugr90aokffj+YlSVhxM0QmNhbk8d6SOqBlOLkwfCxSXfA4k9MGzDaMgxg4m4V6Wp6P0obx+S5IFhn5vqP81sq7Kf2OHBpTN/92TD3fPlW4Q3+vck116UPLc+8PvV0+CiV8QPRWOrMPTmmIh2InoHVCuBng0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WPsZH1N67zyN4g;
	Thu, 18 Jul 2024 20:29:43 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CECD18005F;
	Thu, 18 Jul 2024 20:34:27 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Jul
 2024 20:34:26 +0800
Message-ID: <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com>
Date: Thu, 18 Jul 2024 20:34:26 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Paul Moore <paul@paul-moore.com>
CC: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, <selinux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wang Weiyang <wangweiyang2@huawei.com>
References: <20240702095401.16278-1-gongruiqi1@huawei.com>
 <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
Content-Language: en-US
From: Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg100016.china.huawei.com (7.202.181.57)


On 2024/07/18 0:17, Paul Moore wrote:
> On Tue, Jul 16, 2024 at 10:19 PM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
>>
>> Ping.
> 
> Dropping the LSM mailing list to cut down on the noise as it isn't a
> relevant mailing list.
> 
> Ondrej currently maintains the selinux-testsuite project so I'd prefer
> to give him time to review/test/etc. the patch, but I see it has
> already been a couple of weeks without response.  If Ondrej doesn't
> get to this patch by the end of the Linux v6.11 merge window I'll take
> a look then.

Thanks for your help!

> 
> Where (what distribution, version, etc.) did you see this problem?

The problem occurred when I ran the testsuite on Fedora 40 with v6.6
kernel, and it was the only failed testcase.

> 
> Thank you for sending this out :)
> 
>> On 2024/07/02 17:54, GONG, Ruiqi wrote:
>>> Currently for systems that only enable cgroup v2, the test script would
>>> fail to move the target process into the root cgroup since the cgroup v1
>>> path is used, which therefore makes the testcase fail. Add cgroup v2
>>> handling here so that no matter which cgroup version the CPU controller
>>> is bound to, the target process can always be moved to the root CPU
>>> cgroup.
>>>
>>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>>> ---
>>>  tests/task_setscheduler/test | 17 +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
>>> index c2fe8c6..fa1efb1 100755
>>> --- a/tests/task_setscheduler/test
>>> +++ b/tests/task_setscheduler/test
>>> @@ -20,12 +20,17 @@ vec( $rin, fileno($f), 1 ) = 1;
>>>  select( $rin, undef, undef, 5 );
>>>  close($f);
>>>
>>> -$cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
>>> -if ( -w $cgroup_cpu ) {
>>> -
>>> -    # We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
>>> -    # cgroup so move our target process to the root cgroup.
>>> -    open( my $fd, ">>", $cgroup_cpu );
>>> +# We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
>>> +# cgroup so move our target process to the root cgroup.
>>> +$cgroup_v1_cpu = "/sys/fs/cgroup/cpu/tasks";
>>> +if ( -w $cgroup_v1_cpu ) {
>>> +    open( my $fd, ">>", $cgroup_v1_cpu );
>>> +    print $fd $pid;
>>> +    close $fd;
>>> +}
>>> +$cgroup_v2 = "/sys/fs/cgroup/cgroup.procs";
>>> +if ( -w $cgroup_v2 ) {
>>> +    open( my $fd, ">>", $cgroup_v2 );
>>>      print $fd $pid;
>>>      close $fd;
>>>  }
>>
> 
> 
