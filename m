Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0D12F398
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071786; cv=none; b=EBWYyWYfQzGWB8FTNwY8+bzfoX3uncvkykUskIw21acINHrIQ6epn7mppw7OiBPV8FIqZ4iV954qQ0fYi/S/CxmsG1dAh0Cc8yVYS77PHiVciHvjP2Azysxax2vrHB8xa+1u7rPHPnOyZcBGg7uY72NTZjbr7PVVcWNV220rDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071786; c=relaxed/simple;
	bh=yHJzMLggUhHjmv/Oq1rL8ejYdp0Mb40x6vIy31LAnb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu28VbtChu3Gp3Q6qE1f/DLt0cuhr6djJcWqYm9uZMkjVZ4NtR/Hw5Vzd/lS4JsPjckeq2gDjruAvkQsR/i17QTN9jGt5jzEZqNU30jBWd/IANopzSr8d+jdoOkTuAUfR2AExeCfHjGffq/8R3mw9TVi0I2tHgHfS4UJRQBP+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=l1RzH72T; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="l1RzH72T"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712071773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQKXK6uGLKYuM1UQkrHtlBQ5uWGclKVNoTlWXyP7Hpg=;
	b=l1RzH72TZlX0FDmtwgWG6w5sO0JcfimFR6gqOv0jXEdvGZGf8wpMxO6rEUI14m5FqCC/wB
	zn+Mlyf9qa33hVUMEFHEGtM48/au0X6s2pdKgR1PGOxolLSIGX+W0dnUs8Ynafphyx/B9P
	xgAseo9eWk+mWRtyHmJVIzW1XJTu2VDpOorgeO4n4jGw/N0yN+co3hFbMzhCGCMlw8BCiE
	bQhqc/mzrjT+V0fQn3Tw6bXXXN60W8/YXzRKVgheFdpdoweY3rZHnqqmDWwmWFmjpJT37X
	+jUN9TjEwyL/VjVnoB0DUILfBRNTHTTqCx/cRnpgZNSOY0eLCQ6eJM+4ejEMIg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 6/6] checkpolicy: free complete role_allow_rule on error
Date: Tue,  2 Apr 2024 17:29:25 +0200
Message-ID: <20240402152925.99781-6-cgoettsche@seltendoof.de>
In-Reply-To: <20240402152925.99781-1-cgoettsche@seltendoof.de>
References: <20240402152925.99781-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Free the ebitmaps inside the rolesets on error.

Reported-by: oss-fuzz (issue 67769)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4fc6c417..1c019a3b 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3186,6 +3186,7 @@ int define_role_allow(void)
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_roles(&ra->roles, id)) {
+			role_allow_rule_destroy(ra);
 			free(ra);
 			return -1;
 		}
@@ -3193,6 +3194,7 @@ int define_role_allow(void)
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_roles(&ra->new_roles, id)) {
+			role_allow_rule_destroy(ra);
 			free(ra);
 			return -1;
 		}
-- 
2.43.0

