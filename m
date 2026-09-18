Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C84CDDF4
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726712; cv=none; b=YFmL9Xm22nUhm7BRmz4uivujMFaDMSloZFaioPu1uIAM9XXct7TJW4QRke/nef/DodsEzoZ6Ee7qCRfUAz8U+MDFQaN/c8MlSsGbPaTsOOdXggnuzF9hf56TTRAeMFIehwq2KpjoXRKwiK1s44T1RrUDGVojr2cPv9FbTgzw5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726712; c=relaxed/simple;
	bh=QnCX+k7uhi+6bQ9NVm1lq2ICegqDMGduXvBqJMCzwPo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=X9YK8XvGZywrptL0t2RKDaN0YPEwvKZ7v6cyPqdUT4YCNvWRlTZ4ATrr8LzPntikPG3RirJaRwHzzQF5DM0wrCfgrz/1awIaxBOtlFT4QDHJ5ebmVGmhFdp+ZEB3Co9PgnvNGLjW8oHgyvkjYbKWdTqDmFUoAZAclHzzMKye42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kfK7c143; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kfK7c143"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3yvzT7RSobImpb1GeaVhZKFvIP8Sm/Kpk4mFzciCgcI=; b=kfK7c143Do75teAKwbQtexL1Dn
	viQn8RckhM71YCwIE5BkeXqyFYrCMWXR1sAhog02zL0jVQjPHawPKODrRiqVZl9xASWTqh3Z8AypD
	FO3e1TFabshKLsiXde0C0gRS5BFUzD7gaibeehqB7AEIP7qy2tLrRxXoqjOQDi06XGywErZ2W3Zb1
	ZsEjJfLimswuLqaLhpEvhjgGeXMuVL8TH2jhRX6RisZpM7f3Uob34v0ze4bAwslJX2Is9QjnyG+Kz
	xC/BPuvXOu0y1HW8Y5rA7onxlrZQoT2HgXkZ1l15SiWmtobL/T2GCBNvCiNHOUt6hPcR/mpwhZaaB
	6CH/FaYA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.96)
	(envelope-from <bigon@debian.org>)
	id 1x7Vfj-006eGZ-1U
	for selinux@vger.kernel.org;
	Fri, 18 Sep 2026 10:18:23 +0000
Message-ID: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
Date: Fri, 18 Sep 2026 12:18:21 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Bigonville <bigon@debian.org>
Subject: selinux_kernfs_init_security() ignores genfscon-resolved parent
 label, breaks type_transition on cgroup2/sysfs
To: SElinux list <selinux@vger.kernel.org>
Content-Language: fr, en-US
Autocrypt: addr=bigon@debian.org; keydata=
 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
 wQOeCC+SiVSdSv0zm8D5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: bigon

Hello,

The other day I tried to troubleshoot (assisted with AI) why 
"memory.pressure" files in the cgroup2 hierarchy were never getting 
labeled memory_pressure_t, despite refpolicy defining:

   type_transition init_t cgroup_t:file memory_pressure_t "memory.pressure";

My understanding: selinux_kernfs_init_security() decides whether to 
compute a transition for a new child by checking kernfs_xattr_get() on 
the parent — kernfs's own private, per-node xattr store — and bails out 
immediately if that returns -ENODATA. But /sys/fs/cgroup (and everything 
under it) is still labeled cgroup_t for every other SELinux purpose, 
including plain getxattr()/getfilecon() — that value comes from a 
genfscon rule, resolved live, with no real stored xattr ever involved. 
So the parent "has a label" as far as policy and every other check is 
concerned, but not as far as this one specific kernel check is 
concerned, and the type_transition never fires as a result.

A simple way to confirm: force a real xattr to get persisted (e.g. chcon 
system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/) and then 
restart a service — its memory.pressure then correctly shows up as 
memory_pressure_t.

Tested on kernel 7.1.13 (Debian), refpolicy main branch, 
cgroup_seclabel/genfs_seclabel_wildcard policy caps active.

Has anyone got a view on whether this is intentional, and whether it'd 
make sense for that check to fall back to a genfscon-resolved SID when 
there's no stored xattr on the parent?

Kind regards,

Laurent Bigonville

