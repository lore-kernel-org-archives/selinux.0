Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B56192589;
	Mon, 25 Nov 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532815; cv=none; b=cOIazRcxKQyHQFCeCdCzUuAhZqJDE5mOmqSDF7SJ/u4ecMMRjiolj+Xj1XszxbA4EGMYYHAtUjk1MWFFXzBby/IV4mFPOt/LPTmYA+Cwlj8tSbOn8fJyHy1ckksPWKvrN+Z3Yy/e60g1qfPbsiYw0rk4o1BM8/2fcpLZKiw9gGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532815; c=relaxed/simple;
	bh=UVNJLl8hFonaDEFxsXRGskK1o/7O9VRwYYLYXSB7WTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUeIf98fA9Hh3bD06zL/Dz+Hlt3hT8RCTv6z9pZhHoYiWHxhtx+STvXL14GAfRNne8wdi/RJyWuH1XpQ0IODA7Dm4aXZxAjmk8g8Bv7I4ZbZr2t6kS6po7aySoxfCAWmGaWrd+kTWqwtlcWkQKbXSldK1tKnte6H/1AlZw+QofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZQZH+PNb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZQZH+PNb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732532811;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L6d8K7ZSOHhNo5Pcm4o5EGE0pY7Wd8vWiLSOK+rhHxk=;
	b=ZQZH+PNbTtjpjwWgn5trae/MgLUEjewejT2SGIVaV5GVyBH259kw0Bz3ILROSQN0DnhYJf
	zGf890PNYuhmJKL7/iYQq5RbvKV6nn/Q9fNq5lqRcNkbWYnPabPZewe1INEzUBm+0PO4Ss
	1vOzZC9/frILziCy/A9wbxXN3O61ecpsOy4UEpfBHTebIQAZR2eFQuZRqsqbUPBW/lF0H0
	FYYlanCvpWy2cTvaF6RdyHHMsoVlY4jksqvvrP8p4QcGnYAvF9Zxl3qrw6T8mVWL2QIczw
	hRmJZyH4UDmoAlI+ciZD2orQDLQY4phoKL4hT0oM72/P4YbL/2JjWLCclzECHA==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selinux: use native iterator types
Date: Mon, 25 Nov 2024 12:06:44 +0100
Message-ID: <20241125110646.50799-1-cgoettsche@seltendoof.de>
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

Use types for iterators equal to the type of the to be compared values.

Reported by clang:

    security/selinux/ss/sidtab.c:126:2: warning: comparison of integers of different signs: 'int' and 'unsigned long' [-Wsign-compare]
      126 |         hash_for_each_rcu(sidtab->context_to_sid, i, entry, list) {
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/hashtable.h:139:51: note: expanded from macro 'hash_for_each_rcu'
      139 |         for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
          |                                                     ~~~  ^ ~~~~~~~~~~~~~~~

    security/selinux/selinuxfs.c:1520:23: warning: comparison of integers of different signs: 'int' and 'unsigned int' [-Wsign-compare]
     1520 |         for (cpu = *idx; cpu < nr_cpu_ids; ++cpu) {
          |                          ~~~ ^ ~~~~~~~~~~

    security/selinux/hooks.c:412:16: warning: comparison of integers of different signs: 'int' and 'unsigned long' [-Wsign-compare]
      412 |         for (i = 0; i < ARRAY_SIZE(tokens); i++) {
          |                     ~ ^ ~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c     | 2 +-
 security/selinux/selinuxfs.c | 2 +-
 security/selinux/ss/sidtab.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad3abd48eed1..8cab0413df95 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -407,7 +407,7 @@ static const struct {
 
 static int match_opt_prefix(char *s, int l, char **arg)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(tokens); i++) {
 		size_t len = tokens[i].len;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 234f4789b787..ea563e6215a1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1515,7 +1515,7 @@ static const struct file_operations sel_avc_hash_stats_ops = {
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
 {
-	int cpu;
+	loff_t cpu;
 
 	for (cpu = *idx; cpu < nr_cpu_ids; ++cpu) {
 		if (!cpu_possible(cpu))
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index c8848cbba81f..cb7125cc7f8e 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -114,12 +114,12 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 
 int sidtab_hash_stats(struct sidtab *sidtab, char *page)
 {
-	int i;
+	unsigned int i;
 	int chain_len = 0;
 	int slots_used = 0;
 	int entries = 0;
 	int max_chain_len = 0;
-	int cur_bucket = 0;
+	unsigned int cur_bucket = 0;
 	struct sidtab_entry *entry;
 
 	rcu_read_lock();
-- 
2.45.2

