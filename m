Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAA76026
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094224; cv=none; b=V1C/gytXVVbowxCWxwussjxLN4RZtdUSnG9/gdBEOvex21/kHlEJA9IxW0p8ClMHHESvBg/IElhxmkGYpK2lz8w088AnIyWZU5ORQhbMzw/rjP3DAicyPq9hA6TY1NGQmZ5ctYT3jg5sZQDMEGe0unPSxW2xlORnDcpXLgHN82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094224; c=relaxed/simple;
	bh=ksyDlrKv4PPcJYhC1L/VZr+RGbcu8nZEWgodl9VIELo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdmDHIo1QWnEItKdgUH38BEEKoz7PhEY497c4+cGQ/SONw3QPqm67OHg5KkchbIEO20hVTlgXqP0T/mDWUPsnRmmG7DYINPnfGVuyM6z7kfsOlMympuGc7CS1t5nqGoFyf6DSNwxpSafgNOWYdjh82LQ7NwkF8o7SZ9da6sZaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=oJ8qjWTN; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="oJ8qjWTN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G2AGyPdxq4dY8rUuWqky2mZ9stFu2MepD8YWgKkR1pE=; b=oJ8qjWTNlcsAkue83ujJBZP50A
	NeTlg5IDBf/tAgXzrls0YQ4QUj191kySl5y4wrH67OUIS6OdZGhIr7TLdcQEWCQZpym1YVpvrB0Pz
	l4MENCCrprbs6M+IUZ55gwD8SbBmwbInX38VLMsg9WpmYulpcslLZsU5zTtxGlJU9646rh2oqRLRe
	qGpd8iHzeumqLfo8lwd5mNLoIezKQY1Zv2NmMB+RiyIDWxjsB10UPrIg31TT+BvB9ZL3kqu9h0+zO
	YU48NJbp8o893gq/G2OkPHzyk4bnoEjBgh6EZk9iKxJdE3RMFYSL8WbxG+mcBWVCtnpJ1il8Lrb4u
	5g+gvxhQ==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11566 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKhX3-00000003VWG-2q4y;
	Wed, 06 May 2026 22:03:41 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] libsemanage: make expand-check a proper boolean option
Date: Wed,  6 May 2026 22:03:32 +0300
Message-ID: <20260506190332.16318-1-kalevi@kolttonen.fi>
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

Make expand-check configuration option accept values
'true' and 'false' for consistency with the rest of
the boolean options. Preserve backwards compatibility
with old configuration file settings by still accepting
the values "1" and "0".

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 libsemanage/src/conf-parse.y    | 21 ++++++++++++---------
 libsemanage/src/semanage_conf.h |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b69ac75b..2a63b101 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -168,15 +168,18 @@ target_platform: TARGET_PLATFORM '=' ARG  {
         ;
 
 expand_check:   EXPAND_CHECK '=' ARG  {
-                        char *endptr;
-                        long value;
-                        errno = 0;
-                        value = strtol($3, &endptr, 10);
-                        if (*endptr != '\0' || errno != 0 || (value != 0 && value != 1))
-                                yyerror("expand-check can only be '1' or '0'");
-                        else
-                                current_conf->expand_check = value;
-                        free($3);
+	                if (strcasecmp($3, "true") == 0)
+		                current_conf->expand_check = true;
+			else if (strcmp($3, "1") == 0)
+		                current_conf->expand_check = true;
+			else if (strcasecmp($3, "false") == 0)
+		                current_conf->expand_check = false;
+			else if (strcmp($3, "0") == 0)
+		                current_conf->expand_check = false;
+			else {
+				yyerror("expand-check can only be 'true' or 'false'");
+			}
+			free($3);
                 }
         ;
 
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 2388faad..3b16af4e 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -36,7 +36,7 @@ typedef struct semanage_conf {
 	int server_port;
 	int policyvers;		/* version for server generated policies */
 	int target_platform;
-	int expand_check;
+	bool expand_check;
 	int save_previous;
 	int save_linked;
 	int disable_genhomedircon;
-- 
2.54.0

