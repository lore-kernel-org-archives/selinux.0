Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4B26AFC;
	Mon, 23 Dec 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734937070; cv=none; b=CN82U9UYQYI3IQeDKa3u65qnPEtYErjMjCD+BMMJ7HvbwYShdJAwGH/UiOW6OsH9RuGbDua3pR7WyXFoTZAqghD+1H9llmnCmGE+RXlCGVMBKJIt5tv+7arbcpXhnDMaefOMdtZAymU1RtsFkH8VY8f/zWGJYQzwU8/GL05QYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734937070; c=relaxed/simple;
	bh=HS0KNAOg4XsiEleWtAziCDUTi4VgXxypT7CwTbgIjLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsPfKQAZNH7rKB0bfHB5UOjNkLdgdqSW0g6qVg8x+/1zZP0wNSoP8bnsWtfVL350X/wW0U6Qe4jrAn6qIqPSgIp7KbtNdlVUdDhXppdGE7mBcj2KDTYPuQ6LM0aK7YsLia7pin1DHncqdYUaV3nj16X3fI4BPz5frwS2xwFhBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YGpjw2Mp5z4f3lft;
	Mon, 23 Dec 2024 14:57:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 098281A058E;
	Mon, 23 Dec 2024 14:57:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgC33oLoCWlnoBWSFQ--.8658S5;
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
Subject: [PATCH linux-next 1/2] perf: Remove unnecessary parameter of security check
Date: Mon, 23 Dec 2024 07:06:49 +0000
Message-Id: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgC33oLoCWlnoBWSFQ--.8658S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1UtFy5JFykXFWkXFW5KFg_yoWDJr43pr
	srCFn8KFyUKFZrW3s8AF1DC3W7W3yFgrZxWr90gw4rAF4jq39rXF42qr1Yyr1FkryUAayI
	yw4qyrWak34DXa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRiQ6pPUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

It seems that the attr parameter was never been used in security
checks since it was first introduced by:

commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")

so remove it.

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 arch/x86/events/intel/bts.c     |  2 +-
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/p4.c      |  2 +-
 drivers/perf/arm_spe_pmu.c      |  4 ++--
 include/linux/lsm_hook_defs.h   |  2 +-
 include/linux/perf_event.h      | 10 +++++-----
 include/linux/security.h        |  5 ++---
 kernel/events/core.c            | 14 +++++++-------
 kernel/trace/trace_event_perf.c |  4 ++--
 security/security.c             |  5 ++---
 security/selinux/hooks.c        |  2 +-
 11 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8f78b0c900ef..485a09d61adf 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -559,7 +559,7 @@ static int bts_event_init(struct perf_event *event)
 	 * to the user in a zero-copy fashion.
 	 */
 	if (event->attr.exclude_kernel) {
-		ret = perf_allow_kernel(&event->attr);
+		ret = perf_allow_kernel();
 		if (ret)
 			return ret;
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 103ee41907c7..3b65df32daee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4150,7 +4150,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (x86_pmu.version < 3)
 		return -EINVAL;
 
-	ret = perf_allow_cpu(&event->attr);
+	ret = perf_allow_cpu();
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 844bc4fc4724..78d78b8a1530 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -776,7 +776,7 @@ static int p4_validate_raw_event(struct perf_event *event)
 	 * the user needs special permissions to be able to use it
 	 */
 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
-		v = perf_allow_cpu(&event->attr);
+		v = perf_allow_cpu();
 		if (v)
 			return v;
 	}
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..a55d10956ff6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel())
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -746,7 +746,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
-		return perf_allow_kernel(&event->attr);
+		return perf_allow_kernel();
 
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e2f1ce37c41e..e349e585cc07 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -445,7 +445,7 @@ LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
 
 #ifdef CONFIG_PERF_EVENTS
-LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
+LSM_HOOK(int, 0, perf_event_open, int type)
 LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..5d2ec4283ebf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1672,22 +1672,22 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-int perf_allow_kernel(struct perf_event_attr *attr);
+int perf_allow_kernel(void);
 
-static inline int perf_allow_cpu(struct perf_event_attr *attr)
+static inline int perf_allow_cpu(void)
 {
 	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
 		return -EACCES;
 
-	return security_perf_event_open(attr, PERF_SECURITY_CPU);
+	return security_perf_event_open(PERF_SECURITY_CPU);
 }
 
-static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
+static inline int perf_allow_tracepoint(void)
 {
 	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
 		return -EPERM;
 
-	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
+	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
 }
 
 extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cad..a3b35a699256 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2324,14 +2324,13 @@ struct perf_event_attr;
 struct perf_event;
 
 #ifdef CONFIG_SECURITY
-extern int security_perf_event_open(struct perf_event_attr *attr, int type);
+extern int security_perf_event_open(int type);
 extern int security_perf_event_alloc(struct perf_event *event);
 extern void security_perf_event_free(struct perf_event *event);
 extern int security_perf_event_read(struct perf_event *event);
 extern int security_perf_event_write(struct perf_event *event);
 #else
-static inline int security_perf_event_open(struct perf_event_attr *attr,
-					   int type)
+static inline int security_perf_event_open(int type)
 {
 	return 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b2bc67791f84..f2cb450eb134 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4883,7 +4883,7 @@ find_get_context(struct task_struct *task, struct perf_event *event)
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		err = perf_allow_cpu(&event->attr);
+		err = perf_allow_cpu();
 		if (err)
 			return ERR_PTR(err);
 
@@ -12488,7 +12488,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		}
 		/* privileged levels capture (kernel, hv): check permissions */
 		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
-			ret = perf_allow_kernel(attr);
+			ret = perf_allow_kernel();
 			if (ret)
 				return ret;
 		}
@@ -12745,12 +12745,12 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	/* Do we allow access to perf_event_open(2) ? */
-	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
+	err = security_perf_event_open(PERF_SECURITY_OPEN);
 	if (err)
 		return err;
 
 	if (!attr.exclude_kernel) {
-		err = perf_allow_kernel(&attr);
+		err = perf_allow_kernel();
 		if (err)
 			return err;
 	}
@@ -12770,7 +12770,7 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
-		err = perf_allow_kernel(&attr);
+		err = perf_allow_kernel();
 		if (err)
 			return err;
 	}
@@ -13603,12 +13603,12 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 	return &event->attr;
 }
 
-int perf_allow_kernel(struct perf_event_attr *attr)
+int perf_allow_kernel(void)
 {
 	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
 		return -EACCES;
 
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+	return security_perf_event_open(PERF_SECURITY_KERNEL);
 }
 EXPORT_SYMBOL_GPL(perf_allow_kernel);
 
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 3ff9caa4a71b..a6bb7577e8c5 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -49,7 +49,7 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		ret = perf_allow_tracepoint(&p_event->attr);
+		ret = perf_allow_tracepoint();
 		if (ret)
 			return ret;
 
@@ -86,7 +86,7 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	 * ...otherwise raw tracepoint data can be a severe data leak,
 	 * only allow root to have these.
 	 */
-	ret = perf_allow_tracepoint(&p_event->attr);
+	ret = perf_allow_tracepoint();
 	if (ret)
 		return ret;
 
diff --git a/security/security.c b/security/security.c
index 1db835c05a78..ad9655aa1322 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5885,16 +5885,15 @@ EXPORT_SYMBOL(security_bdev_setintegrity);
 #ifdef CONFIG_PERF_EVENTS
 /**
  * security_perf_event_open() - Check if a perf event open is allowed
- * @attr: perf event attribute
  * @type: type of event
  *
  * Check whether the @type of perf_event_open syscall is allowed.
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_perf_event_open(struct perf_event_attr *attr, int type)
+int security_perf_event_open(int type)
 {
-	return call_int_hook(perf_event_open, attr, type);
+	return call_int_hook(perf_event_open, type);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a503b8fd6611..14c7d331c3b6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7040,7 +7040,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 };
 
 #ifdef CONFIG_PERF_EVENTS
-static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
+static int selinux_perf_event_open(int type)
 {
 	u32 requested, sid = current_sid();
 
-- 
2.34.1

