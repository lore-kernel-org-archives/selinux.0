Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4F13F43A;
	Mon, 23 Dec 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734937070; cv=none; b=Zlj5gHfZ7SgnSWzNIhSriZXqIZX2nJ4LtA0OdvX9rXULHP0QrFzjxGeCbCT9y7PF2C75bjMejAetLQB+vL0o0CTPnILYUzxPeiHieBcRMYIC7g7Lvumxwlo2kQHO4A8Lu9b1UleR8vkuhEmZ4jj/X3yMKNy2ffWzfdKUYboLBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734937070; c=relaxed/simple;
	bh=WGufmhjNmDMIR/IZ6GWBQmeQvvOu3n8Pl5/epJptMHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D83UG/f0DdIzYBSIICSWBDZ3CW+O6e786IsD6pVQSSASR9aqJ1Mn+FwOmy3so17TkIwsPv4wiu0BsMm1qqeEOBviAuVSKQkNsuj7efKmfWJM8r3/i/G1UCQPWH0jZVIpGkpbcHAOcQEYhqSVux+1djyx3BRdUhPAvUUfd1m71A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YGpjw0zGmz4f3lfV;
	Mon, 23 Dec 2024 14:57:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CCB601A06DA;
	Mon, 23 Dec 2024 14:57:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgC33oLoCWlnoBWSFQ--.8658S4;
	Mon, 23 Dec 2024 14:57:44 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	will@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH linux-next 0/2] Fix perf security check problem
Date: Mon, 23 Dec 2024 07:06:48 +0000
Message-Id: <20241223070650.2810747-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC33oLoCWlnoBWSFQ--.8658S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1DtryDKF45AF4DCrWkCrg_yoWxCrX_CF
	97Aa4kJrsYvFySva4xAFs2vFyj9rW0vw1FqF93tr98XrnIqw1UKF1xtayIqry3XF48WryU
	tFnxWry8XF1YgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRQAwsUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

From: Luo Gengkun <luogengkun2@huawei.com>


Luo Gengkun (2):
  perf: Remove unnecessary parameter of security check
  perf: Return EACCESS when need perfmon capability

 arch/x86/events/intel/bts.c     |  2 +-
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/p4.c      |  2 +-
 drivers/perf/arm_spe_pmu.c      |  4 ++--
 include/linux/lsm_hook_defs.h   |  2 +-
 include/linux/perf_event.h      | 12 ++++++------
 include/linux/security.h        |  5 ++---
 kernel/events/core.c            | 14 +++++++-------
 kernel/trace/trace_event_perf.c |  4 ++--
 security/security.c             |  5 ++---
 security/selinux/hooks.c        |  2 +-
 11 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.34.1

