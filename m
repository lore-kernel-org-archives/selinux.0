Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AD152500
	for <selinux@vger.kernel.org>; Tue,  2 Jul 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914460; cv=none; b=Nu/QgjP+549iT3QWke6MvL7uPo5UMUmCOyvOrSz4n/OULvfYh4YcGTY/iN8KmzfcFzCshOZMCmXjOrp5GWC8zoEpjaWOc7eczHCC/5lF/HKKK9g64kd54LPERs7SkN1pSEfpSD8bygxIDH/LQc5dNWuVJRFEn3A1wMrdqi/+8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914460; c=relaxed/simple;
	bh=bDZco+ln6sKXi2rTPfvBfYRA0S7E1HCcxAoDaZpnXqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XO5ZsF2QA6LH95ADewENi1viRKoZPiDK58wjGMX7LteT1dRRwN96OgCkyrb0rf3ydmcKoUF0l4ZDkp4bayZfvXI4yVyRZN1aHaEh+jVf/sBxR7AcgjjEAY3ACavPEkR7hWFm5cdVuKXfJK/XPEFm7kVFSBrFTlqqIY/iC4FA7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WCyxc6Hv5z1ytvS;
	Tue,  2 Jul 2024 17:57:08 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 73DFE1A0188;
	Tue,  2 Jul 2024 18:00:55 +0800 (CST)
Received: from huawei.com (10.67.174.164) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 2 Jul
 2024 18:00:55 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: <selinux@vger.kernel.org>
CC: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>, Wang Weiyang
	<wangweiyang2@huawei.com>
Subject: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for moving proc to root cgroup
Date: Tue, 2 Jul 2024 17:54:01 +0800
Message-ID: <20240702095401.16278-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100002.china.huawei.com (7.185.36.164)

Currently for systems that only enable cgroup v2, the test script would
fail to move the target process into the root cgroup since the cgroup v1
path is used, which therefore makes the testcase fail. Add cgroup v2
handling here so that no matter which cgroup version the CPU controller
is bound to, the target process can always be moved to the root CPU
cgroup.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 tests/task_setscheduler/test | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index c2fe8c6..fa1efb1 100755
--- a/tests/task_setscheduler/test
+++ b/tests/task_setscheduler/test
@@ -20,12 +20,17 @@ vec( $rin, fileno($f), 1 ) = 1;
 select( $rin, undef, undef, 5 );
 close($f);
 
-$cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
-if ( -w $cgroup_cpu ) {
-
-    # We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
-    # cgroup so move our target process to the root cgroup.
-    open( my $fd, ">>", $cgroup_cpu );
+# We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
+# cgroup so move our target process to the root cgroup.
+$cgroup_v1_cpu = "/sys/fs/cgroup/cpu/tasks";
+if ( -w $cgroup_v1_cpu ) {
+    open( my $fd, ">>", $cgroup_v1_cpu );
+    print $fd $pid;
+    close $fd;
+}
+$cgroup_v2 = "/sys/fs/cgroup/cgroup.procs";
+if ( -w $cgroup_v2 ) {
+    open( my $fd, ">>", $cgroup_v2 );
     print $fd $pid;
     close $fd;
 }
-- 
2.45.2

