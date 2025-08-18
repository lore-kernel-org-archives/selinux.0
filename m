Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799ED2264B3
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504072; cv=none; b=MAzlxc6ZqvvwNPDl9SgY7iqJLISxSyR38Ho/hQWoFyRD1BR9v99YckxGVHQaWy9fhvdcdPqPbZsFljjXXtMgpjuLG8e6YavtPeyOwN7GEK7o8G31lp7Gj2ehxECwnLYssN8GbmWGeGTWbJ4nR2lgUM42N/ojvRnezUVzhY5YBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504072; c=relaxed/simple;
	bh=wOvTCdtMwD3Fm7U68XWQ0dR34dNr5sq2+MmcM5IuQb0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=FLNJ9w5cqW7nlK8BmrilkWF0RwzNsYg76Ph+BRCc+LF1Nv2GbeSlO5N9eP/UOODF7pmChd65dByhChHbzd89JggCqcOvIPE4U3dpRo4EOVVLqyFZ3pp8kcLaZIn8Fcg2XXbqAUzmxDNenpzVmb0tNSvipZN4W9JxrQ/Ovi5NHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eHmTdbmt; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eHmTdbmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:To:
	Content-Type; bh=nmvcD8bvEVik2Uc1yRGUfg44YzH4THutmGG72NsNJr4=;
	b=eHmTdbmtWkXCm7EUp7nOYsZ6bTklUv0duKG+g8pHkoiLFbCM9etC2VzmFvQOZR
	K+UTM94gH3HO/Jjohh8/7QQpOBmWO/bJnMZBNTaym3878ipPumd+T+v1LzlvT9qD
	I8hA2uNgFnm/kZ4u8iv/gCLG2gy0O7MHZ284YJcFPoyro=
Received: from [192.168.3.49] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCnivvB3aJoPLfGCg--.22211S2;
	Mon, 18 Aug 2025 16:01:06 +0800 (CST)
Message-ID: <8925af9c-2977-4acf-9b48-7f6ce3b280ec@163.com>
Date: Mon, 18 Aug 2025 16:01:04 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: BOBx <kabc005009@163.com>
Subject: [Help] how to compile te with checkpolicy.
To: selinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnivvB3aJoPLfGCg--.22211S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw17CF1ftr1kGw4Dtw4kXrb_yoWkZwc_Ga
	4UtF17Jr15Jr1UJF1UJr15Jr18Jr1UGr15Xr15Jr47Jr17Jr1UJwnrJr4UXr1xXr1UGr1U
	Jry5Jr1UAr17JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUtC7UUUUUU==
X-CM-SenderInfo: pndeuiqqvqimi6rwjhhfrp/1tbiYA6ttGii25E-sQAAs5

Hi all,

These days I tried to compile te with tools named checkpolicy. I have 
searched the process with google and chatgpt, and I followed the steps 
they told me but I failed.

The following is my te file,  cmd and response and other infomation.

My te file(my_policy.te):
----------------------------------------------
policy_module(my_mypolicy, 1.0)

# Define types
type my_type_t;
type my_type_exec_t, file_type;

# Allow rules
allow my_type_t my_type_exec_t:file execute;
----------------------------------------------

The command:
----------------------------------------------
sudo checkpolicy -M -o my_policy.pp my_policy.te
----------------------------------------------

The response  from command:
----------------------------------------------
my_policy.te:1:ERROR 'syntax error' at token 'policy_module' on line 1:


checkpolicy:  error(s) encountered while parsing configuration
----------------------------------------------

OS information: 6.11.0-29-generic, ubuntu 24.10.

Would you like help me to compile te with checkpolicy please? Or which 
URL should I read please?

Best regards

BOBx


