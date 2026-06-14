Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E826F2BF
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452243; cv=none; b=cAAfsjRZD7ZeDMgGelkaZrIta9OfEx4fKkJjQXdFqa3/ZIS1XUNFc0lVMhtV1kaM7rjGTxQXmebfHpBkHAa+xoBOvZM0a+A8XJELn9QfbICIYhtI9u52xWiyWueAdbBcqdTgS4JBtGFKCcxFT5yAKI8cn5cV11wZEeU206BsViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452243; c=relaxed/simple;
	bh=kj/CoQHns9nG6Z4EYd/3CdSy9ptistIfuhPKmu3Jwwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpoCjo3jUECGfVoUg1f1qpCXmLGqiEWqzcdY8+GaVsGcamavuWRub0lknckbSYKZV6RVbXXP4FY9CSVMj5dKWU7of2N3PjhoEupbK80tc64v64jsytpgAZN6CxR/EJuNsPPVoLhK1hWbxKYUHb4+bSLB/Ns19DV2ccEBMhjtkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Yr++kHdH; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Yr++kHdH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gavIv6andkYs3mqBnCPBvBE8aRAW4Zofcwi1S2rvhJ8=; b=Yr++kHdH4cvxdlwmf03JukDdVs
	UPYmze7Ug/eRrIO5soc13wEibsMy0O3t3+wqIn6pYKThkV9oh81H8GPR8E3ymrgwI9Jdef4MLAmj7
	wTh4LOh7zbcXG1rJe0FyKMkVAiS8EUeaJfFu4rt0Rg0YqeWDGUkJh/DdTC02Xd6PdfNSnrqeXDq4I
	IX7uMIgaB3FBfUm3KimjdBeVT7XmRyIh9i+pgjg5hKu7NncZ4W6o4S/cEEEnOJI0NUY30YuePEfRE
	lF7iTSYD9F08lyc8u7GJ7PEZgVpU7i0IlbypLNk9RuVwzoPmO8s+lqJ/49hQrgChDSVEdkIDDqbU0
	v9i90q2A==;
Received: from [87.95.76.183] (port=4233 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYn6c-00000008cgk-3FBj;
	Sun, 14 Jun 2026 18:50:38 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 2/2] policycoreutils: use bool instead of int
Date: Sun, 14 Jun 2026 18:50:30 +0300
Message-ID: <20260614155030.97082-3-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614155030.97082-1-kalevi@kolttonen.fi>
References: <20260614155030.97082-1-kalevi@kolttonen.fi>
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
 policycoreutils/setfiles/setfiles.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 656848e3..2d38ea8f 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -1,4 +1,5 @@
 #include "restore.h"
+#include <stdbool.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -23,7 +24,7 @@ static struct restore_opts r_opts;
 
 #define SETFILES "setfiles"
 #define RESTORECON "restorecon"
-static int iamrestorecon;
+static bool iamrestorecon;
 
 /* Behavior flags determined based on setfiles vs. restorecon */
 static int ctx_validate; /* Validate contexts */
@@ -181,7 +182,7 @@ int main(int argc, char **argv)
 		 * Does not follow mounts (sets SELINUX_RESTORECON_XDEV),
 		 * Validates all file contexts at init time.
 		 */
-		iamrestorecon = 0;
+		iamrestorecon = false;
 		r_opts.recurse = SELINUX_RESTORECON_RECURSE;
 		r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
 		r_opts.add_assoc = SELINUX_RESTORECON_ADD_ASSOC;
@@ -204,7 +205,7 @@ int main(int argc, char **argv)
 				"Executed with unrecognized name (%s), defaulting to %s behavior.\n",
 				base, RESTORECON);
 
-		iamrestorecon = 1;
+		iamrestorecon = true;
 		r_opts.recurse = 0;
 		r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
 		r_opts.add_assoc = 0;
-- 
2.54.0

