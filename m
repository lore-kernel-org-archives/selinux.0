Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C581A00D1
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334639; cv=none; b=Z76mA4CpPCcht/go0w8BhoxG93a0HGt4nPdrHFz4U6f5HWCAcvBnzWylPjUYfkWCZgyMG/AOlNaG5T7+GURHwjaT1GGw3lXd7KODNg73Lmr9+qGGxV6VqrJqPbIEOS0vx0Y+qy/IXRfGOY7DfkLq4842QcOQ3e5yjODjhlDGmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334639; c=relaxed/simple;
	bh=2k/SE5j0EINxxFGbrCAoXrkvCGVnbw62npcrd+ete2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwqdcJhY6NreLmPGAnorFYg8HgbL9cvnTIHQpKvBs9vLjbJov0PLFQ7drz0tRSgUCskufuV5s4akIXnxgyg7KAujJ7KmPSOIm8/ihu8ZrqY7CHZJivetEwA7v4/Wmnyn0ZEuYx/7S7wikNIdpLl7CMk9dBcw6e5BUKytGTkeOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=j4O3+Wn8; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="j4O3+Wn8"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334634;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85/NSBwfkaLi/eW2spTVrXDh85+C2F0E28qSCzfO65E=;
	b=j4O3+Wn8FSSECLY7wl13ljDUd3Gvrsvb2tpD8Svl9DJi4nID0sCLQWFWIyH4prL33khj/Z
	22NOcN9GiRSQuwqL5IzSsoLWfSdaAA3csBl9iB7ZZHzDMZi7+TNTil/hdKziogm6lq0Rnx
	BP+HzRaU24JhRF2AotaGAMwnTr6i/xYD5O4QF+veKYMXeclAGGsLgTNvRkO7eoAjlRTNXd
	rscJ6NpIv/0GgmGQNA8IgEiwwfqZc8WAlKS3kHEFptslvepgQ8ScWPlMaJ5fnzE3hiByhq
	HzQnCA6g0Lpqw5oC3iLAIxasGfS+if5wZVrV5R9rUnW//FYOb3ejgHexcbxygA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 07/47] libsemanage: drop unnecessary return statements
Date: Mon, 11 Nov 2024 15:16:26 +0100
Message-ID: <20241111141706.38039-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Drop return statements at end of void functions and drop one unreachable
return statement (compilers that can't infer it is unreachable should
just not be used).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/debug.c  | 1 -
 libsemanage/src/handle.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/libsemanage/src/debug.c b/libsemanage/src/debug.c
index 902ab5a5..1e375694 100644
--- a/libsemanage/src/debug.c
+++ b/libsemanage/src/debug.c
@@ -107,7 +107,6 @@ void semanage_msg_relay_handler(void *varg,
 	sh->msg_channel = sepol_msg_get_channel(sepolh);
 	sh->msg_level = sepol_msg_get_level(sepolh);	/* XXX should map values */
 	sh->msg_callback(sh->msg_callback_arg, sh, "%s", buffer);
-	return;
 }
 
 extern void semanage_msg_set_callback(semanage_handle_t * handle,
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index c489a75f..d5baa614 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -194,7 +194,6 @@ void semanage_set_create_store(semanage_handle_t * sh, int create_store)
 	assert(sh != NULL);
 
 	sh->create_store = create_store;
-	return;
 }
 
 int semanage_get_disable_dontaudit(semanage_handle_t * sh)
@@ -209,7 +208,6 @@ void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudi
 	assert(sh != NULL);
 
 	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
-	return;
 }
 
 int semanage_get_preserve_tunables(semanage_handle_t * sh)
@@ -244,7 +242,6 @@ void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts)
 	assert(sh != NULL);
 
 	sh->do_check_contexts = do_check_contexts;
-	return;
 }
 
 uint16_t semanage_get_default_priority(semanage_handle_t *sh)
@@ -285,8 +282,6 @@ void semanage_select_store(semanage_handle_t * sh, char *storename,
 	sh->conf->store_path = strdup(storename);
 	assert(sh->conf->store_path); /* no way to return failure */
 	sh->conf->store_type = storetype;
-
-	return;
 }
 
 void semanage_set_store_root(semanage_handle_t *sh, const char *store_root)
@@ -296,8 +291,6 @@ void semanage_set_store_root(semanage_handle_t *sh, const char *store_root)
 	free(sh->conf->store_root_path);
 	sh->conf->store_root_path = strdup(store_root);
 	assert(sh->conf->store_root_path); /* no way to return failure */
-
-	return;
 }
 
 int semanage_is_managed(semanage_handle_t * sh)
@@ -361,8 +354,6 @@ int semanage_access_check(semanage_handle_t * sh)
 	default:
 		return -1;
 	}
-
-	return -1;		/* unreachable */
 }
 
 
-- 
2.45.2

