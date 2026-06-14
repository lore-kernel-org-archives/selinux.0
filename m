Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16371285C8B
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456532; cv=none; b=LeevnMchPbYh3e+X3dkdTAx24gYe2rpl86XQMzBgZEJwbYlkPyBUGt3Z4cV3BWewpabA+es8MtoQSOUhF68WeeDfoWgcoHDm+UrU9A59LEJGerttCfdUYtcvTuxro1Ck8qgKIOd7v8qc+1Z/+ldXr80wo+4Noan4TeaxZMVABdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456532; c=relaxed/simple;
	bh=MUheaQe+oMNUa14Q08TkcJBvhEuzjIui+TIHMS6XD6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsP87yHmgltkK+Me5V5WXgnn1k3JlCqYTTraHyqBw1XgoZMRBxzMPk5Yt0vO5XRYi6psN/d0+v+NscuZqFedZ0iK0A3EL+1kzIK8/Hju37b3jDSlDlnH/vh8NbBSpWAdVlB6O88L/+KlpMNlYzl6R2Nwdg5EpRbWGj+t2sGsQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=G2AkuQ21; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="G2AkuQ21"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F7Q7Gg5RY1VNJcJW3uGJjeesadIWYmx/+OqnpjeAR4c=; b=G2AkuQ216Vk0q6WmWzFWnz7nBt
	GRPa248FnKGLcvKZWdWb/8SHQEZX4ZyHmaLDtrSr4jru1VsQDdY/Oofyz5w2IQPfDCTU9hEU3Q2jT
	kjm26tCMqsCh5zUqoFI2tBF5e+6xx6kENDJGceTScLZZfcYeW8udzQ0pLPvWL/h2fZzDdq+/iY3Lp
	QCd8SC3SZd7ZzwYzhHefQsprlXNrLc4OdA0Wit3iTUXvNmrWDtSD4cGIGkiEPnBsalWoPZXScZeGw
	zsYVh5YbGG5RK6szBGaUsLT4V7yCC/BfSwcHXsznATH8DwpuTIjJJ6Rcfh5Bzm1JjFYiru5gpUx/X
	++xi1+2Q==;
Received: from [87.95.76.183] (port=4415 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYoDp-00000008pD7-0RJp;
	Sun, 14 Jun 2026 20:02:09 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] policycoreutils: use bool instead of int
Date: Sun, 14 Jun 2026 20:02:03 +0300
Message-ID: <20260614170203.69842-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 policycoreutils/setsebool/setsebool.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index d85b2a33..3cf1f063 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -1,4 +1,5 @@
 #include <unistd.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -17,9 +18,9 @@
 #include <semanage/boolean_record.h>
 #include <errno.h>
 
-static int permanent = 0;
-static int no_reload = 0;
-static int verbose = 0;
+static bool permanent = false;
+static bool no_reload = false;
+static bool verbose = false;
 
 int setbool(char **list, size_t start, size_t end);
 
@@ -44,13 +45,13 @@ int main(int argc, char **argv)
 
 		switch (clflag) {
 		case 'P':
-			permanent = 1;
+			permanent = true;
 			break;
 		case 'N':
-			no_reload = 1;
+			no_reload = true;
 			break;
 		case 'V':
-			verbose = 1;
+			verbose = true;
 			break;
 		default:
 			usage();
-- 
2.54.0

