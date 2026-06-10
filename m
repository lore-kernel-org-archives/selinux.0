Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65783E9C1F
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104789; cv=none; b=bfhIemH+7xn7z/fMPtiGSlrTEmer0M1Q/fOO7S9kIe2m8W71L/tpIIESG6z1eHlEkxSV6CT7z2sWFJCPV/2jY/+hbGyOcTPeFqA7JhwTy2GBRgormxgzEfn6iWJ1KSbUhWXTTu8ZqxDypGYWVm4F4tAb7hOuqf6fMbOdLIacrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104789; c=relaxed/simple;
	bh=CTzajzGJw5xSzaP5dukGQGur8KFNCtkmg/JV224EMdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6FIWI7NDaYsOvLh+ZwUvkBSdBG9sY20bcWhesatYnb97PnNHXAh62JM8L/lIFft7ZCBURqwt0QCYXB6mNX54Buyd4Ligg1gmiBwmgWiFcOXxc+ZJM/ihINrD+dcyVTdnA7nEpxcolFmJpI8ql/X1OgCLSgdEk79K80FtW5yz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=rX5mvBNK; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="rX5mvBNK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dnKXcEpjpwCwK8b7gdXeLlfED4IIPOZTh0xFcpodhBc=; b=rX5mvBNKaSTjYbUH313cBDNQyh
	kmRmSKHdArpRzdwUhQw1iTs2bb0eTuKFX45gvL8WsHfO98nfjs/UF/T8mhmcVtJIxZyQq+vz1C3ul
	3DwB+HQPdzcXIHILJJlyeazuuLyoNoFNDna/UpO9GKfrrQvyREEB335GsmIlNT14Ku1c71XimnEMa
	2W48wmS1RMQylCkwTfv5L3i81fBwGur/CGo8mYDI8zckDUiLt0CWNq+7fO/8LsVhrNWCPgiUF+QS6
	yVMhHEQ8MDdOhMJRCRjHZlsuVL/83WkcNKqPHz+gRqjI0gKMeDFalJUHfWsdWM+kK/OAiDMf9qWBk
	1DG2qC+A==;
Received: from [87.95.76.183] (port=4180 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wXKiU-00000008fTq-3FlD;
	Wed, 10 Jun 2026 18:19:42 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] libselinux: use null character with strings
Date: Wed, 10 Jun 2026 18:19:30 +0300
Message-ID: <20260610151930.48676-1-kalevi@kolttonen.fi>
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
 libselinux/src/get_context_list.c     | 10 +++++-----
 libselinux/src/get_default_type.c     |  2 +-
 libselinux/src/is_customizable_type.c |  2 +-
 libselinux/src/matchmediacon.c        |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 01419b07..39d169dd 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -152,7 +152,7 @@ static int get_context_user(FILE *fp, context_t fromcon, const char *user,
 
 	while ((len = getline(&line, &line_len, fp)) > 0) {
 		if (line[len - 1] == '\n')
-			line[len - 1] = 0;
+			line[len - 1] = '\0';
 
 		/* Skip leading whitespace. */
 		start = line;
@@ -175,14 +175,14 @@ static int get_context_user(FILE *fp, context_t fromcon, const char *user,
 			start++;
 		if (*start != ':')
 			continue;
-		*start = 0;
+		*start = '\0';
 		linetype = ++start;
 		while (*start && !isspace((unsigned char)*start) &&
 		       *start != ':')
 			start++;
 		if (!(*start))
 			continue;
-		*start = 0;
+		*start = '\0';
 		if (!strcmp(fromrole, linerole) &&
 		    !strcmp(fromtype, linetype)) {
 			found = 1;
@@ -209,7 +209,7 @@ static int get_context_user(FILE *fp, context_t fromcon, const char *user,
 		while (*end && !isspace((unsigned char)*end))
 			end++;
 		if (*end)
-			*end++ = 0;
+			*end++ = '\0';
 
 		/* Check whether a new context is valid */
 		if (SIZE_MAX - user_len < strlen(start) + 2) {
@@ -308,7 +308,7 @@ static int get_failsafe_context(const char *user, char **newcon)
 		return -1;
 	plen = strlen(ptr);
 	if (plen && buf[plen - 1] == '\n')
-		buf[plen - 1] = 0;
+		buf[plen - 1] = '\0';
 
 	nlen = strlen(user) + 1 + plen + 1;
 	*newcon = malloc(nlen);
diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index 8955c505..6a09ca22 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -39,7 +39,7 @@ static int find_default_type(FILE *fp, const char *role, char **type)
 			return -1;
 		}
 		if (buf[0] && buf[strlen(buf) - 1])
-			buf[strlen(buf) - 1] = 0;
+			buf[strlen(buf) - 1] = '\0';
 
 		ptr = buf;
 		while (*ptr && isspace((unsigned char)*ptr))
diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 992747fb..4eac6cad 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -45,7 +45,7 @@ static void customizable_init(void)
 			while (fgets_unlocked(buf, selinux_page_size, fp) &&
 			       i < ctr) {
 				if (buf[0])
-					buf[strlen(buf) - 1] = 0;
+					buf[strlen(buf) - 1] = '\0';
 				list[i] = strdup(buf);
 				if (!list[i]) {
 					unsigned int j;
diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index ca3d7980..2bc0932e 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -27,7 +27,7 @@ int matchmediacon(const char *media, char **con)
 			return -1;
 		}
 		if (current_line[0] && current_line[strlen(current_line) - 1])
-			current_line[strlen(current_line) - 1] = 0;
+			current_line[strlen(current_line) - 1] = '\0';
 		/* Skip leading whitespace before the partial context. */
 		ptr = current_line;
 		while (*ptr && isspace((unsigned char)*ptr))
-- 
2.54.0

