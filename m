Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184707;
	b=BsTtpkn55B8XkXse/SVeRaaQchYdwX/ADCsC9S/5B9m/Zc1EYp1qC/dyPs7VcASVD29O
	 AmuVwyu4kqvtk60Jo9l+Gad+VRnrX0GFP1Mq+h7Bu3Ni4m4WHIBY8dnGEy6WapB36Rb9M
	 P2Ybs44S7po9xUFDDXIVMJZdiXnrNXtOgKNngy3MDjbr6IPMC4WgIlmmBvNQbf95OrUh0
	 wBJYO8rmIJBcKTNkBlWXJN5ay5oGBnnHFEweJ2BcMBO5thGXQYTd7GevIN54Mo7Mcy2hl
	 YQWtQiTU9pXZPP5UD+nxxAKgXNwksZUMv9dr8gG82Jpietm4SY7LKFqNNfhZBqjwlmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184707;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=QVuAkEilZ5oFK1qOIjgNohU8C9sqgDos/dquD82VOJ0=;
	b=3+fxlFKoLQ6XZi9KkJT9fZIgs27lv0GhNRSgqnMZz+Pdx41jplKiGpiPjVViiiQDIHrq
	 qCDAI0455Fa1/o6ytlvJIj+viTdfOaZOKCtPDJ6gShwpAJdx6VZo64Ijm8ACa10fCdddW
	 tfU8o5Ox0lxQrNt6vx+kyTl7YwPM5C7SwumFy0M1ha4go2zZ5ar8YaMYzPXtd21hQjx5S
	 FvdGMWj7cC93bDejXdCT1QwctAUmuo8OY3pQz4toSVAjrKwxi+Qu6I/lCSNA69ttXWP6g
	 nAH8M/MzY1vAm2iutOmKulwBvAUIm6/W7dWEd/XmO1LRG/LjTS3w1PO3mCpado9Nlzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Tjhpe1XE;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64033606A31A;
	Wed, 28 Oct 2026 10:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64033606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Tjhpe1XE
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QVuAkEilZ5oFK1qOIjgNohU8C9sqgDos/dquD82VOJ0=;
	b=Tjhpe1XEYDomJqQjMX/KSBw4At6Ih1wHlx9vV0r0NhfNLpLnl9LqJLfGM0Z2KbFMG2qQjBdq1
	/2/qXe1L4oAUtgtr6ufh4G6Z7rsuS8fKO9BPURZ/BEcOQdgjCRtysqIw+3ZYOro+R2d/My5Fr7f
	ldQynZZycNbuSEdLwcsbUmY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jF4110czvzRhT1;
	Wed, 28 Oct 2026 18:51:33 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id A0CA240561;
	Wed, 28 Oct 2026 18:51:41 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 28 Oct 2026 18:51:40 +0800
Message-ID: <a7a1a3ed-74e2-41a5-abc4-28efbc761263@huawei.com>
Date: Wed, 28 Oct 2026 18:51:38 +0800
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next 06/18] LSM: pass struct path and struct file to
 the inode xattr hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	<sashiko-reviews@lists.linux.dev>
CC: <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<dsterba@suse.cz>, Chuck Lever <cel@kernel.org>, Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-7-caixinchen1@huawei.com>
 <sashiko-outbox-186599@kernel.org> <DMFPMAYUPSDU.2AW3225P0W0ON@gmail.com>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <DMFPMAYUPSDU.2AW3225P0W0ON@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100010.china.huawei.com (7.152.184.41)

Thanks for the pointer. I will change in the next version.

The other issue the bot reported on this patch is real as well:😭
walking path->dentry in a BPF LSM program drops PTR_TRUSTED.
I will add BTF_TYPE_SAFE_TRUSTED for path in next version

On 10/27/2026 11:01 PM, Alexei Starovoitov wrote:
> On Tue Oct 27, 2026 at 1:02 PM UTC, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [Critical] bpf: missing __nullable on file arg in inode xattr LSM hooks allows NULL deref
> bot is correct.
> Please see commit 94e948b7e684 ("bpf: annotate file argument as __nullable in bpf_lsm_mmap_file")
> and add to kernel/bpf/bpf_lsm_proto.c when args can be NULL.
> That's how verifier knows.*2*2
