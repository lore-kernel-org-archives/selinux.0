Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21670208B0;
	Sat, 27 Jul 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722048900; cv=none; b=sZJvq8KLKGgVWvff/iiqLJuZOrCtOPvEQAhQje2Br/bYaCJT6p2c/sbW3b0JQKYyKAhqp80rGMC6oaQVn1i4+ukdvRK0zpfoAUutsepHoqB0xLD+pA0HfTI5JavefYOsoEfIKwRNsJosdPPws6e4g6JhpyvPP516ILwCsWWV8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722048900; c=relaxed/simple;
	bh=SC4ewOAvXzgVqB7T0j0VlxyhUMM9hasZjA4JU3RaXaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EMO6dx/psbJ9rzBJSvlXqZnPqKlte2jXFxCJGnGmPZfn8t8jxluwimrr8JlVDzfs2bg5LfA49EThQGeVUOcTbGoaf4XQCnpI8iyIzp+1wxkn2OYCXO3Gh8uNf5O6JT+tgUq6Staml5YdA9vbva+NYdq2mNk0i0Fz5oUsmtNd7f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WW8Lp4QGszMqnv;
	Sat, 27 Jul 2024 10:53:06 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A194180102;
	Sat, 27 Jul 2024 10:54:55 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 27 Jul
 2024 10:54:54 +0800
Message-ID: <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com>
Date: Sat, 27 Jul 2024 10:54:30 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Ondrej Mosnacek <omosnace@redhat.com>
CC: Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, <selinux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wang Weiyang <wangweiyang2@huawei.com>
References: <20240702095401.16278-1-gongruiqi1@huawei.com>
 <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
 <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com>
 <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
Content-Language: en-US
From: Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100016.china.huawei.com (7.202.181.57)


On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> On Thu, Jul 18, 2024 at 2:34 PM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
>>
>>
>> On 2024/07/18 0:17, Paul Moore wrote:
>>> ...
>>>
>>> Where (what distribution, version, etc.) did you see this problem?
>>
>> The problem occurred when I ran the testsuite on Fedora 40 with v6.6
>> kernel, and it was the only failed testcase.
> 
> Sorry for the delay... For some reason the test passes for me even
> with cgroup v2 only and without the patch (also when run from a
> regular user account with sudo). Do you happen to know what
> circumstances are needed for it to fail when the cgroup is not
> switched?
> 

As the comment in the script says, a process need to be in the root
cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. So
maybe in your case the shell process is already in the root cgroup?

In my case I need to ssh to a Fedora VM, and that makes my shell process
to be in a sub cgroup called /user.slice/.../XXX.scope (looks like some
systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in the
system with cgroup v2 only, the script skips moving the target process
to the root cgroup, and therefore the subsequent test fails.
