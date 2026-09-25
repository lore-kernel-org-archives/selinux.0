Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016683B7749
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356724; cv=none; b=WwZpmKoIUk9y+QqBFJKtBDIP7zkqsOiY80dSUmSrYz2yHSMjeYQ+cmv6STZGcBbAIazXyGUzPO9ZSkwXfy1HtCLPldWa0hiHVAD6egaooM+1P9I7O0c33iAiW4FwCEHIAGUXGxwuIpjXrRe6mXzkHSafMgnx/iGGg6IM7jZd68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356724; c=relaxed/simple;
	bh=wIo/2aOXbs/C2FWpfmUQDGvTeFnXK5uFPHzs7aZavdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ippNrN+AkKwNo4iHY3cNzIWzVR63bh//3rg0dQB0EHdtALls0uEhJzSMGqN0uwZpZ3xHld3qoiP98Yu+ujGdt7OWcd4dEqSDymPlgYBfqFUYUPGDiLnXOw7crrvBdVWZqtfCfuVx8YKfQOvgJ/atcC8A2q3f9MJb0KDQ8xUTOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CK4aBAy7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CK4aBAy7"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356707;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=krne7TJFP5TaUqOiGtYolT5+z04Kh3KoMNLLeot4DM8=;
	b=CK4aBAy7plXblqJRIju5g3LOpHWbcrP9cls1rQBk9kJyAfOsiLUGlUTOTqM+Y3yRxZBB6e
	DtE9q2rI1bnX6tSomvIO4911c/kZj/jjDPUtrGWNUGWKOJy0kJp24IdIlhM3O7QDrMwvkA
	DC4rrvWRetfItLYCmgYOR4juMcl0IRockQJXp/grpkhTyZfJJ9K2JdXBXPB+KmIqx3lWFB
	T3FPquCdSiNDoYw8OTGOXcewr2Qa+mcz/41W1iQStLq3iQGIAQA/YzUxB+i2rDwO6NlH4v
	aFONhSiZhwVGq7UXKxkiVCEFVvZhLLMfeaUW8JWaDTdJOzfnZFIKGhYX/fVlbg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 02/21] policy: fix build with Reference Policy
Date: Fri, 25 Sep 2026 19:17:34 +0200
Message-ID: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

Fixes: 011a106 ("policy,tests: add tests for new permissions for loading files/data")
Fixes: 16ac3af ("tests/bpf: Add tests for SELinux BPF token access control")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
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

