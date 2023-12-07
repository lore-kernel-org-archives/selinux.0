Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dc8qcb7u"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD9D66
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 17:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701912855; x=1733448855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yns2qTVk0FLz+VFyvP2dxfrdb0MLUDQ2BghxqHfJvcA=;
  b=dc8qcb7uBXT2XAC9uilbQEVDC51Qd3nHfvgZl57id8kh6ct7+qceTyUX
   kZlQYTdPxkHOSdGKjZsTM2xOHNjS25uz56GUFjfngOQR8pmrtevDFat0H
   ak2se4d6nqD5ymhLn9k/TaOfmFHgEfLQ9fXgBLJjo7WsrWuwawiQo3lLM
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="689450562"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:34:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 5103D161AE6;
	Thu,  7 Dec 2023 01:34:11 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:34720]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.210:2525] with esmtp (Farcaster)
 id a99605e7-c406-4c5e-b7c5-4247f632481f; Thu, 7 Dec 2023 01:34:11 +0000 (UTC)
X-Farcaster-Flow-ID: a99605e7-c406-4c5e-b7c5-4247f632481f
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 01:34:11 +0000
Received: from dev-dsk-kamatam-2b-b66a5860.us-west-2.amazon.com (10.169.6.191)
 by EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 01:34:11 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <paul@paul-moore.com>
CC: <kamatam@amazon.com>, <selinux@vger.kernel.org>
Subject: [PATCH v2] selinux: remove the wrong comment about multithreaded process handling
Date: Thu, 7 Dec 2023 01:33:56 +0000
Message-ID: <20231207013356.20327-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAHC9VhS_WyFXN=4mqb+K92kx1YutnJcuuO8VdtRZNA1aJzziBA@mail.gmail.com>
References: <CAHC9VhS_WyFXN=4mqb+K92kx1YutnJcuuO8VdtRZNA1aJzziBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

Since commit d9250dea3f89 ("SELinux: add boundary support and thread
context assignment"), SELinux has been supporting assigning per-thread
security context under a constraint and the comment was updated
accordingly. However, seems like commit d84f4f992cbd ("CRED: Inaugurate
COW credentials") accidentally brought the old comment back that doesn't
match what the code does.

Considering the ease of understanding the code, this patch just removes the
wrong comment.

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---

v1 -> v2: just remove the comment instead of bringing back the old one as suggested by Paul

 security/selinux/hooks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 855589b64641..863ff67e7849 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6459,7 +6459,6 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		if (sid == 0)
 			goto abort_change;
 
-		/* Only allow single threaded processes to change context */
 		if (!current_is_single_threaded()) {
 			error = security_bounded_transition(tsec->sid, sid);
 			if (error)
-- 
2.40.1

