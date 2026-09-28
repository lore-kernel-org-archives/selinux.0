Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B34EF15B
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614395; cv=none; b=ESLZqt6KHWhpPbnrHKcFogbjzePdUDu1QZyN1Stzzg81N/Fh70unfb2HfuQDzVeVyGlrIUqTzF1AhrP1ZxvOg0Wbwzark+CHv1ixI77Bt0iiXA08fu0SIqqCAbSYC42OkM8L6euL1trviNxiDJq2ivx8q/jMhzxtBzuCSOOxRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614395; c=relaxed/simple;
	bh=NLPdGvEMpxIz4BB8PlO8vv62yR2xavU5+IQZ1zYngQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=muYx+kQ6TbZCPuK8Nrx057tQA2rOQ6m56toHb6+K2MGcHRWmO6hAL1aq0K1/VlSZpxZh/8eELHQsJYx2ke8JU9N7nPheQHVuimcZSxj/C+790EEhp+OxPI8ZcWd7FAgsl+S5axHdyHS8TsQcn8ymJit7V0Qxl6fAs68qt7ZEaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Rqmqk8A0; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Rqmqk8A0"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790614391;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zI3OpxD+MPPymaUifMCm3gHcIIMssXXDdKVy1M3eE2c=;
	b=Rqmqk8A033SCqAovDeVW4mTWI5MkCO1oJwYcbcWB2sd0Og8QCoUDFAf3iTMT9w7woRDbHF
	dhyneN7G2kBT7xMZRiZpzpM4F3k/1X7R7VGRo35yngOw2OyAMFC8Cf8324FXSJRZ3lfAEP
	YXgqEjQ9JSEPob5ol+zN5Yp0B47JD2ciX5Wsc0/f9AqUwwWbC5J1rlMEEsJFP8/A2LQsn8
	ob5X3FXXrKz0C0Do/L79d0DOo9mbNvo8cqg5Erpd+m1Vg1yAOLtA+iX/0agErR8Vvp5Ivy
	NkbYb7Lv607NNAfpzGF8zNQ8GtCIBvTzggupH5Nl3Z+HDUjW9sswIrOwZdExhA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/3] selinux: validate user MLS range and default level at load
Date: Mon, 28 Sep 2026 18:52:51 +0200
Message-ID: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
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

user_read() reads each user's MLS range and default level but, unlike
range transitions and security contexts, never validates them.
Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
enabled, once the level and category symbol tables are populated.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e0304297def4..e51293e3ca8c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -748,6 +748,20 @@ static int user_index_check(void *key, void *datum, void *datap)
 		}
 	}
 
+	if (p->mls_enabled) {
+		if (!mls_range_isvalid(p, &usr->range)) {
+			pr_err("SELinux:  user %s has an invalid MLS range\n",
+			       (const char *)key);
+			return -EINVAL;
+		}
+
+		if (!mls_level_isvalid(p, &usr->dfltlevel)) {
+			pr_err("SELinux:  user %s has an invalid MLS default level\n",
+			       (const char *)key);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.55.0

