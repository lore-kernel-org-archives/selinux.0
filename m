Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552519006B;
	Mon, 23 Dec 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734937075; cv=none; b=jZUcDW94Vl0V3nhwcqHH7+2JbhXvjhlswwXYtsVMKzzGW4h9vl94rQWtqqspUNWq6fw4+X0zmddOvfAuxt5jiL2qnKwk503znHdeD1DNFrTJhJZJvP04Gq/QxaSJwbkG6LSP76KTqjON3MZxGCmniXEi0LcpG/CK+R49eBE/ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734937075; c=relaxed/simple;
	bh=iM223PkQZDqo/Te4I4lOt5OkAiDiGHc6wnKJ/ZHtVE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mu6mjKu71jcXdUBSJ/kgkdi6MGnIQrr6iCeMJA8L0+t4f5njmKXs1Zpc2lOj7NU4IASa+lKgxqhLHRqzl9Ew6/EiNuyujAww6m7X8ExWB/Bm4lJ61PnGmZ/YQiABrhQwFs7gk41U6lfI36b7E1+8eQXNqrBOO70dzyfYgWjpdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YGpjx4Fn2z4f3kFj;
	Mon, 23 Dec 2024 14:57:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 392441A018C;
	Mon, 23 Dec 2024 14:57:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgC33oLoCWlnoBWSFQ--.8658S6;
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
Subject: [PATCH linux-next 2/2] perf: Return EACCESS when need perfmon capability
Date: Mon, 23 Dec 2024 07:06:50 +0000
Message-Id: <20241223070650.2810747-3-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223070650.2810747-1-luogengkun@huaweicloud.com>
References: <20241223070650.2810747-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC33oLoCWlnoBWSFQ--.8658S6
X-Coremail-Antispam: 1UD129KBjvdXoWrZF13ZFy5ur43urW3Jr4UXFb_yoW3trg_u3
	WxJrn2vr1kWF12q3y7Jw1xtr15Ww1rG3WFvrn5G347Cr90gws5A34rJryDtrW7CFs7ursr
	Kw18Wr97Zr1Y9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRNrcTDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

For perf_allow_kernel and perf_allow_cpu, both return EACCES when require
CAP_PERFMON or CAP_SYS_ADMIN permissions, so update perf_allow_tracepoint
to keep them the same.

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5d2ec4283ebf..c1bc0d7a275b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1685,7 +1685,7 @@ static inline int perf_allow_cpu(void)
 static inline int perf_allow_tracepoint(void)
 {
 	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
-		return -EPERM;
+		return -EACCES;
 
 	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
 }
-- 
2.34.1

