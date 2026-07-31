Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E40299959;
	Fri, 31 Jul 2026 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535947; cv=none; b=BRfbppJhyxs9V5YaMY9g5S2xVTXIYoF8Navw8S24JnjsEH85G577ivoNHSEnFrDti8AFT+Pw1V2wOqOBk8V/2buodPbIf+nhsKJyAhFADMjL1o19weGOV2kstd9kUjbXKMiuZheI2KWFmfwTOVo7js2uzmq2qA58ChtlV3/4Vrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535947; c=relaxed/simple;
	bh=JihYSU/r9N+Sqgyh4Yk4a7uCOrmrkDfXe6QGEwCykWc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DK+77u0pz3fAfjW6i6GlfF03qbOJUrxzElHPveadiPFMbSC+q8R1NZ69kpdV49bkF8t/yZwGwoO4XTWOje4Pss1x891SaC9lOyUrgmOOlOcTTT4tUsovB6LkDuaQuVEzd66+Fs9fbtf3/GnZHePTeQ0PEOVhyd1S5dT51jwBFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amfNx4CT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amfNx4CT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EC81F00AC4;
	Fri, 31 Jul 2026 22:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785535946;
	bh=GodLeSl+4EW/i7R7ZxPDMk/tqStLWQen8gLz2GoqixQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=amfNx4CTYihZjtDD8q+P9uo/Qxq8m2eTZ7yqdETQu9CjuH27FOonTmKlN6ErYDVh0
	 t5sHpjht8ICZkcPWhHnHrrq2e5XlE7IpcsJT/Shrai13YItPDaUymkUtUyahMSicbS
	 /fhxDy2ELSc+SJfUc2SdHsXVEgGQabhpxo3/Iw/cshhgLYKxQBhtdjHanswAiGKSQq
	 LAln+kPkfiuRuZYT70n06BpgweuWdfo388f0ecVv6ocy/uBbWirQXuHus1KiZLhYED
	 cbVw7UcwE1SFMl4rjJNEdyfDzliqj0m5BJkjpvoC/W2IcgZQr5QiGe4aP7ffUuPOP/
	 9o2mgxtU28HCw==
Content-Type: multipart/mixed; boundary="===============1723855371719409092=="
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9951258c46ffe401f9f3aec54d442acbe2f791c9bc745783af1268f957e5272@mail.kernel.org>
In-Reply-To: <20260730234533.1912709-2-dwindsor@gmail.com>
References: <20260730234533.1912709-2-dwindsor@gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/4] security: introduce struct lsm_xattrs
From: bot+bpf-ci@kernel.org
To: dwindsor@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,jolsa@kernel.org,memxor@gmail.com,emil@etsalapatis.com,mattbobrowski@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,casey@schaufler-ca.com,stephen.smalley.work@gmail.com,omosnace@redhat.com,zohar@linux.ibm.com,roberto.sassu@huawei.com,dmitry.kasatkin@gmail.com,eric.snowberg@oracle.com,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-integrity@vger.kernel.org,selinux@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,dwindsor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:12:24 +0000 (UTC)

--===============1723855371719409092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
> programs atomically label new inodes, rework how inode_init_security
> xattrs are managed.
>
> inode_init_security receives the LSM xattr array and its count as
> separate parameters. For better compatibility with the bpf verifier,
> update inode_init_security and its callers to consolidate these
> parameters into a single context object: struct lsm_xattrs.

This isn't a bug, but could the changelog note the int -> unsigned int
change of the xattr count, since that is not just a parameter
consolidation?

The xattr count changes from int xattr_count in security_inode_init_security()
to unsigned int xattr_count in struct lsm_xattrs:

include/linux/security.h:
+struct lsm_xattrs {
+       struct xattr *xattrs;
+       unsigned int xattr_count;
+};

security/security.c:security_inode_init_security() {
-       int ret = -EOPNOTSUPP, xattr_count = 0;
+       struct lsm_xattrs xattrs = {};
+       int ret = -EOPNOTSUPP;

The cleanup loop changes accordingly:

-       for (; xattr_count > 0; xattr_count--)
+       for (; xattrs.xattr_count > 0; xattrs.xattr_count--)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30592505811
--===============1723855371719409092==--
