Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787A657C6
	for <selinux@vger.kernel.org>; Thu, 28 Mar 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653655; cv=none; b=mVea25LHpX5C2FzWR8CYGvSVz9DggVZmJCfpxGqy+SyjVPBzOrMhIvyv6tQGKkV7EWe/7ws5VlXagLeoyQ53gC3Uhu1JgKjY+QdQJIBd+W01fv82GgXcasyNjsktOQyVTfQIKmPD8CnuB3bfXK6vvySbmX24gVtWsH0snAhecPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653655; c=relaxed/simple;
	bh=6lDaIiubL8ZN6Q8HHA4dr8BYb9dks4mw5ChWv3HEbaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t9On+zjtfIc26l+lRDPYSkVwHbiF4FbYMr6754Fj+5ZKixMpCukZ1z3rgV1Rc7JQjKVjYQW7JXjVxfsI3mr1HOqjAMfE9DE5Q1whlBLIeU1ETLs7zqer8e/a1myY53xlH/6KhDB+KN2WN//JgHr55kzgNroq/TJnmlfGGSnqfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gPnULeiF; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gPnULeiF"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1711653649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BxI6pWh+QdDvCJfAVA9WRxFO/7wL6g2by2edLUhHWCQ=;
	b=gPnULeiFUhfgRPMQE6mL02v3OZtKURoXjYdnJhCqWUojmKZ7tUC4lg4/t33RYCJJp7TlDX
	y2tsKYu6mMr+37O/yaNjkAADP0HTUJlGwq2esC2E84QC/4eTMT5/saFToj1GoLFMtRd20q
	0cA21Ntag/H+8KawX0aezaexYak6z3oltfLfiNfg8t8ZBsmTYQPquABrmXJE0BsxVxIPqU
	e7Fi4HBmzXHEyhqTFFfnZU7Kig9C0perH3fodW9E7o0pYTHa1q7s5Tfbpub2tJXVv7CMGf
	sJtWHIRMSnXQRZQ2PTeNjYYmTSssMTSdwhWhC7BuZsJTrqUkHGHoHM9n2a6FUg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: pre-allocate the status page
Date: Thu, 28 Mar 2024 20:20:42 +0100
Message-ID: <20240328192042.211948-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Since the status page is currently only allocated on first use, the
sequence number of the initial policyload (i.e. 1) is not stored,
leading to the observable sequence of 0, 2, 3, 4, ...

Pre-allocate the status page during the initialization of the selinuxfs,
so selinux_status_update_policyload() will set the sequence number.

This brings the status page to return the actual sequence number for the
initial policy load, which is also observable via the netlink socket.
I could not find any occurrence where userspace depends on the actual
value returned by selinux_status_policyload(3), thus the breakage should
be unnoticed.

Reported-by: Milos Malik
Closes: https://lore.kernel.org/selinux/87o7fmua12.fsf@redhat.com/
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 7e9aa5d151b4..ad57b5ad5829 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2131,6 +2131,7 @@ static int __init init_sel_fs(void)
 {
 	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
 					  sizeof(NULL_FILE_NAME)-1);
+	struct page *status;
 	int err;
 
 	if (!selinux_enabled_boot)
@@ -2163,6 +2164,14 @@ static int __init init_sel_fs(void)
 		return err;
 	}
 
+	/*
+	 * Pre-allocate the status page, so the sequence number of the initial
+	 * policy load can be stored.
+	 */
+	status = selinux_kernel_status_page();
+	if (!status)
+		return -ENOMEM;
+
 	return err;
 }
 
-- 
2.43.0

