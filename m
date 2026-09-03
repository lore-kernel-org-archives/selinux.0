Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A9468C29
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435394; cv=none; b=nJ6DcA0a2LWPeh53NC4MvqGx5QCJteKm99vZp/fvZe8jmA0B2hZ4tEnqHG03ZDehJmjo1uO7Q/vXwn4SKx+xdgibyBkkMZvswDP5SX/19jI5KMkZKK04TV3Pcl476tl++YgFwaKUwkTMHnnNwAkdFLJIvaGOb37FwkFJwFscNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435394; c=relaxed/simple;
	bh=73maRuCIdfQ1oZobv5O/FvDlxbdh15nc/oz2kLd6dzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiEEvmtI/wjRIp5mUCQuodJGXxkzdmwHRu0kaVXpubbaWYRlKmlUL9nA84YuGUVGNSWHvkFLomXLf/wVNRl/iC43I/ZBOrmyNVlMiV0LJjFQM8gT23BCwFpPWrvwkPUwf/iq6a7kozScHZXCNQP3hOIcZoaFzvKKZeN0IIXSfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dgjZW51i; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dgjZW51i"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1788435378;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ16gYkRUpXYYaXnDTDuSweUqB6y7/KY1WkQCQrIWyQ=;
	b=dgjZW51ifeF8AaGWf65VQ4rHISKdFF4H9VaQVHk2tGxuuYf8LcHwizN4LTjHmjzOgU6b+X
	N/kWLObv++9zdf5s2rB5sPU4Jw9gcKgiI4vAZpam2IL+IZ4jh7JoBrRQDgQ+O2f87EIdb3
	Z79/EFaXdgaDj+QfK2up+tCwRfoZBgEOJKeJ5Pd8a2FVaAc34XSBIiY7rzcUh6p337DyOT
	UNTNKNN7ofJxgSt9Ky8FSU6iQkEkcIjWjnoefQ4tvkL6o/UtjLjLps4C1VXzREpMY4Tu2W
	fcFPJhXqxft1aWXvxgKx40fj5U5+JoxcT8t25hjT86Zdbm1TJm/PB7xsK0gRmw==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/5] selinux: validate user MLS range and default level at load
Date: Thu,  3 Sep 2026 13:35:36 +0200
Message-ID: <20260903113538.72942-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
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
index 3bef28434180..efa8df26791d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -738,6 +738,20 @@ static int user_index_check(void *key, void *datum, void *datap)
 		return -EINVAL;
 	}
 
+	if (p->mls_enabled) {
+		if (!mls_range_isvalid(p, &usr->range)) {
+			pr_err("SELinux: user %s has an invalid MLS range\n",
+			       (const char *)key);
+			return -EINVAL;
+		}
+
+		if (!mls_level_isvalid(p, &usr->dfltlevel)) {
+			pr_err("SELinux: user %s has an invalid MLS default level\n",
+			       (const char *)key);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.55.0

