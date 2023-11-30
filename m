Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k5ETcX1g"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9983B2
	for <selinux@vger.kernel.org>; Thu, 30 Nov 2023 00:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701333922; x=1732869922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GoxLn/7V90eH0hAeU1sOAiR9J0L+7XUL5/I/8znXgx4=;
  b=k5ETcX1gBs0zixpwxXZJTs6nfu7826q7yLH4GTqJ2tKq8/DCS305aVaH
   6TxliLxujnbyISk8rRaRt7z9eYuq7f7e7H7DbaqRSXm3NjYnVYlWGHL1i
   xdCyM1w19cCh6kAS4Tdy5Aw9Obn5gu5rEJGqpl7yUvODt/Seqz0fnacNh
   g=;
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="371023188"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:45:21 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 39F46A0755
	for <selinux@vger.kernel.org>; Thu, 30 Nov 2023 08:45:20 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:44121]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id 707aab8c-4e02-40f0-82ca-a1e1a911171e; Thu, 30 Nov 2023 08:45:19 +0000 (UTC)
X-Farcaster-Flow-ID: 707aab8c-4e02-40f0-82ca-a1e1a911171e
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 08:45:19 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.106.101.41) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 08:45:19 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <selinux@vger.kernel.org>
CC: Munehisa Kamata <kamatam@amazon.com>
Subject: [PATCH] selinux: bring the comment about multithreaded process handling back
Date: Thu, 30 Nov 2023 00:44:53 -0800
Message-ID: <20231130084453.970742-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

Since commit d9250dea3f89 ("SELinux: add boundary support and thread
context assignment"), SELinux has been supporting assigning per-thread
security context under a constraint and the comment was updated
accordingly. However, seems like commit d84f4f992cbd ("CRED: Inaugurate
COW credentials") accidentally brought the old comment back that doesn't
match what the code does.

This just brings the updated comment back and does nothing else.

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---
 security/selinux/hooks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 855589b64641..d147f8ac9d9d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6459,7 +6459,12 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		if (sid == 0)
 			goto abort_change;
 
-		/* Only allow single threaded processes to change context */
+		/*
+		 * SELinux allows to change context in the following case only.
+		 *  - Single threaded processes.
+		 *  - Multi threaded processes intend to change its context into
+		 *    more restricted domain (defined by TYPEBOUNDS statement).
+		 */
 		if (!current_is_single_threaded()) {
 			error = security_bounded_transition(tsec->sid, sid);
 			if (error)
-- 
2.40.1

