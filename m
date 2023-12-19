Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA71D140
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KBWhAT+5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a234139b725so365829466b.3
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002216; x=1703607016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3mQhCro7rIA//WgoTKoBpkiGulU0bbdLMCuyCwVh/8=;
        b=KBWhAT+5d9yGvqNftUCP7N2R4N1W655wDCIuDttq92QS+S+pWSwkDkNUuD1w1pC9eP
         Rv0FtyYxNG8FhpcdoHB95yR8z65v3Z0PLXe+rorOlexXaikKhqN1mNUsSx+1GsURXDNk
         wFvT0FEbqYeCdyFEZJ6DBGZRHuOh7A/k9SQE7rwqhYXjLfVuAhavza+cW4wqPJa4YwXz
         5c26CTeTJI8fyu6rGsNluU/TEOb7zULyStCQIfujKq/eMSiEcx274OPLF6XFzxX+Zl7S
         J8fCCE784mUNzzPDknumhahQ4g0Q4oOM71DkOvmtnh9m4lLpy7As5DSBtoaAazKsq/Jb
         uroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002216; x=1703607016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3mQhCro7rIA//WgoTKoBpkiGulU0bbdLMCuyCwVh/8=;
        b=QlxAOWU7gP54EAqFpCQwl43Bj/DGROz+EU4uyIjLQEMQvxF92K1fspBVsGsRC1lgKk
         /jByO9qsx+R2qwekauyBN2oUpqHNaD3qwBt7CI90NE0+094AAcpnNTPuSUzd7kPX4fjr
         fD9YWEdAGAwMTLBCqLrYSgfxov3tbQdudI3j5abG9lQ75DQQKiZ5PMqlWUu4p2k1Pe3j
         lksC7tkMPui1GhDo7WVaV9IvAF/oUrPVeffMvgzvkQ5rxcKvuo3qzniy82GfomZSE5U+
         BhXfijD4awKQWqNV8lzwOvQgM4g4tR1Hr0PzrxZk8nO7jwujDIcAfr/esKjBN+QAXD5g
         U0Lg==
X-Gm-Message-State: AOJu0YyTvlsLGprdTithDMXnVM9UdTqabQpAEUrrbEdLcoN+2/cbs/xA
	xnEx4Qe1ISCixQpSSJqvs4X/W0TfLpk=
X-Google-Smtp-Source: AGHT+IEHwSS8ZDrDxwxZ5Z5YCg1pgNsfKVkfZi4mHvlhtf+SoVSYAIzPnNFup+4nILrlqN1cPp8phw==
X-Received: by 2002:a17:906:fa17:b0:a23:456b:bd79 with SMTP id lo23-20020a170906fa1700b00a23456bbd79mr1135937ejb.199.1703002216307;
        Tue, 19 Dec 2023 08:10:16 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:15 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 07/11] libselinux: use logging wrapper in getseuser(3) and get_default_context(3) family
Date: Tue, 19 Dec 2023 17:09:29 +0100
Message-ID: <20231219160943.334370-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of writing error messages directly to stderr use the wrapper
selinux_log(), which by default writes to stderr.  This allows
applications to redirect or silence messages via
selinux_set_callback(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/get_context_list.c | 10 ++++++----
 libselinux/src/seusers.c          |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 9dafa519..7e23be05 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -7,7 +7,9 @@
 #include <string.h>
 #include <ctype.h>
 #include <pwd.h>
+
 #include "selinux_internal.h"
+#include "callbacks.h"
 #include "context_internal.h"
 #include "get_context_list_internal.h"
 
@@ -224,7 +226,7 @@ static int get_context_user(FILE * fp,
 
 		/* Check whether a new context is valid */
 		if (SIZE_MAX - user_len < strlen(start) + 2) {
-			fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
+			selinux_log(SELINUX_ERROR, "%s: one of partial contexts is too big\n", __FUNCTION__);
 			errno = EINVAL;
 			rc = -1;
 			goto out;
@@ -245,7 +247,7 @@ static int get_context_user(FILE * fp,
 				rc = -1;
 				goto out;
 			}
-			fprintf(stderr,
+			selinux_log(SELINUX_ERROR,
 				"%s: can't create a context from %s, skipping\n",
 				__FUNCTION__, usercon_str);
 			free(usercon_str);
@@ -439,7 +441,7 @@ int get_ordered_context_list(const char *user,
 
 		fclose(fp);
 		if (rc < 0 && errno != ENOENT) {
-			fprintf(stderr,
+			selinux_log(SELINUX_ERROR,
 				"%s:  error in processing configuration file %s\n",
 				__FUNCTION__, fname);
 			/* Fall through, try global config */
@@ -452,7 +454,7 @@ int get_ordered_context_list(const char *user,
 		rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
 		fclose(fp);
 		if (rc < 0 && errno != ENOENT) {
-			fprintf(stderr,
+			selinux_log(SELINUX_ERROR,
 				"%s:  error in processing configuration file %s\n",
 				__FUNCTION__, selinux_default_context_path());
 			/* Fall through */
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index 6da8c318..e5cfd510 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -8,7 +8,9 @@
 #include <errno.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
+
 #include "selinux_internal.h"
+#include "callbacks.h"
 
 /* Process line from seusers.conf and split into its fields.
    Returns 0 on success, -1 on comments, and -2 on error. */
@@ -197,8 +199,8 @@ int getseuserbyname(const char *name, char **r_seuser, char **r_level)
 		if (rc == -1)
 			continue;	/* comment, skip */
 		if (rc == -2) {
-			fprintf(stderr, "%s:  error on line %lu, skipping...\n",
-				selinux_usersconf_path(), lineno);
+			selinux_log(SELINUX_ERROR, "%s:  error on line %lu, skipping...\n",
+						   selinux_usersconf_path(), lineno);
 			continue;
 		}
 
-- 
2.43.0

