Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF84E77FA
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611111; cv=none; b=R+M3NO3uL369sdsBq1jP3XZcuc5p+6WiMzktqLRYkq9d1udacJjFTuSVhI8K1q4tID5rHS12jJHevo4Gs8Gq+d1PenS9X51AmOWhxPFRkZkUTjThRD7q2qj/d2q8Tps+mO8iSgDaxC7R4J77Pbpf+JflGDR5DUbG/s1Q4oADwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611111; c=relaxed/simple;
	bh=k7q13XtqdtUdpT4U8hJcsAiV+pEInHA1/Vm2p0QYX58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ut9k6b6YBEQQ5eqF39AHHDV1pUfthDzInbYNioiOalQTvy2jhxoloHpL8ZnbS0ze7P4dlkR8FSnlH/glmMZgJN/RmAy+k4TyWMt2G1rjvs+NYkXeclD0XEveemF3tZX4KJXd3ZNLHiLfRgDC1t7NxqGXQqOTS7HNn/wFeBvNQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=OeI83hcc; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="OeI83hcc"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611099;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=I47ibhwF1DuKop14D55WLBT5fD/AriMCwbftgR1KYss=;
	b=OeI83hccA26MDXq88FPGyBNg9bAKPImcrfCDn0oot7u+98Io+ULt98ffvLpMHf1Xb5RYM6
	Eq08whUcwL3LqhhmwRB54EtWTMpwSOwMGCU/2tv0DR59nVzK3cfmksR6KJdEP+fDd4zXBO
	Jv6sEE5HLdXcBuE/bDoNuNEC2BUcwI3HZj3L080VAvkKBrUVPKC2v+/WFlqloRj9q9IPhO
	Ci8RELJo1afWMSvit7bXL4hxo+IPLIYZH95e1IQGRlSzmXaICBToDYZN2bLq8Ab+E+O8qa
	GGMlzDV+dx/9nOxNV2Jg7CV32vHck+Zsq4Gb5TSayzJo6fK6fRA4F6q9ufFmRw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 02/21] policy: fix build with Reference Policy
Date: Mon, 28 Sep 2026 17:57:33 +0200
Message-ID: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

test_file_load.te and test_bpf_token.te call interfaces that only exist
in the Fedora policy: files_rw_generic_tmp_dir(),
fs_rw_inherited_tmpfs_files(), userdom_read_inherited_user_tmp_files()
and fs_list_bpf_dirs().  With Reference Policy, e.g. Debian's
selinux-policy-dev, the unexpanded calls end up in the module source
and the test policy fails to build.

Fall back to the Reference Policy equivalents, as already done for other
interfaces in test_global.te.  files_rw_generic_tmp_dir() needs no
replacement, since Reference Policy's files_tmp_filetrans() already
allows writing to /tmp.  test_bpf_token.te also uses bpf_t directly,
which only got required via fs_list_bpf_dirs(), so require it explicitly.

Fixes: 011a106285e1 ("policy,tests: add tests for new permissions for loading files/data")
Fixes: 16ac3af8cf6e ("tests/bpf: Add tests for SELinux BPF token access control")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: use 12 chars for Fixes commit hashes
---
 policy/test_bpf_token.te |  9 +++++++++
 policy/test_file_load.te | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/policy/test_bpf_token.te b/policy/test_bpf_token.te
index bc7a777..5f05d1c 100644
--- a/policy/test_bpf_token.te
+++ b/policy/test_bpf_token.te
@@ -2,6 +2,15 @@
 #
 # Policy for testing BPF map create and program load with BPF token
 
+require {
+	type bpf_t;
+}
+
+# Reference policy does not have fs_list_bpf_dirs()
+ifdef(`fs_list_bpf_dirs', `', `
+define(`fs_list_bpf_dirs', `allow $1 bpf_t:dir list_dir_perms;')
+')
+
 ################### Allow map_create_as and prog_load_as ###################
 fs_list_bpf_dirs(test_bpf_t)
 allow test_bpf_t bpf_t:filesystem mount;
diff --git a/policy/test_file_load.te b/policy/test_file_load.te
index 5e5c85c..35387af 100644
--- a/policy/test_file_load.te
+++ b/policy/test_file_load.te
@@ -7,12 +7,24 @@ require {
     type user_tmp_t;
 }
 
+# Reference policy does not have the *_inherited_* interfaces
+ifdef(`fs_rw_inherited_tmpfs_files', `', `
+define(`fs_rw_inherited_tmpfs_files', `fs_rw_tmpfs_files($1)')
+')
+ifdef(`userdom_read_inherited_user_tmp_files', `', `
+define(`userdom_read_inherited_user_tmp_files', `userdom_read_user_tmp_files($1)')
+')
+
 attribute testkexecdomain;
 
 type test_kexec_tmp_file_t;
 files_tmp_file(test_kexec_tmp_file_t)
 
+# Reference policy does not have files_rw_generic_tmp_dir(), but its
+# files_tmp_filetrans() below already allows writing to /tmp.
+ifdef(`files_rw_generic_tmp_dir', `
 files_rw_generic_tmp_dir(testkexecdomain)
+')
 files_tmp_filetrans(testkexecdomain, test_kexec_tmp_file_t, file)
 manage_files_pattern(testkexecdomain, test_kexec_tmp_file_t, test_kexec_tmp_file_t)
 
-- 
2.55.0

