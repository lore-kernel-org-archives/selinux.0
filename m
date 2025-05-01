Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19204236445
	for <selinux@vger.kernel.org>; Thu,  1 May 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129562; cv=none; b=UOaSiEg60bNYXcbHXaTwnOiS4icg2BCTXJ+eFvBC8OfDUOLVCU5aLxr0tLzsf4khBjOGKpxNR+ydi/6x3g2iE2j+OCu8KYNXCZCbaqpCoH61YFiK6RenOwYHd/Z6bOcmsaUSHZjI9ivrITTfZ9UovawFAPfaavjtpKhbtsR8pKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129562; c=relaxed/simple;
	bh=Bvvy+fPyUodjy6qFHD+HgSYu3rmtFmqyXq/DzV+52S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irCpzUqxeKBAs7UcArnnYJEtE/O20s2QwyyTBqmK5UF+wW+PDN0pnAcUbwf/Ino98m8IR4J5jnLZ+9XcaK/8AOP0BLfuT5Bd/2L331OsnpINMmmK5MnbOARdEvw8TrA1AFt0nkTPfZ5zbb6xbMKkTkC9xOiFt6Tnda5XrukLP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz/QaT9a; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz/QaT9a"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2aeada833so254996666b.0
        for <selinux@vger.kernel.org>; Thu, 01 May 2025 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746129559; x=1746734359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsDTbdeg/4BWddCTwdV20bTHrmKNAaqrLk9VIcVQaYA=;
        b=Nz/QaT9a9bhl2/bBEnKboulMeB3sc1B9ifO6Se6T8vG9NQMnEs+Hl3b8ecFWoCcOgA
         dOMNQlbQLG/vb/HgDoEnEg2SsS527ENII51bgNPxn3q3u2ffNVbWVigUCDPvlKTa5V4m
         PkxQ19Xuh0dhWW9Q4mf67o2j3g2xkDdoyEAq8/WsXLTsbrQ3e75b8A44tfU+dj9WXbBe
         oGhMwibmwZGx5PmJZBllxXJrjIgvIoxRiC6hv3AjKfgDt+HNyZ6cvk/RR8fA64M70RQZ
         +i6i9R7cCsuWlS5ZR+pMkyYYnV8n8RKL2nLQSGJaQgJ9jB6Lx60I1rj3GvR/eL2LbOay
         +qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746129559; x=1746734359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsDTbdeg/4BWddCTwdV20bTHrmKNAaqrLk9VIcVQaYA=;
        b=r90fXUyWb31GFNey0Kgwy9i0tVRqLjqApxS+ve3H6+zkjARkoleGQjTvG4AAKNZXzG
         dkBoSscAxZH5JmoPYuY9P49SUaQcvnmS6gwgf0BTT4ZRJFyPKPtRnDAjFOVm2BlaMVnH
         I4iRLAt+t4vLp2C+dMCbokQ6cEWZNWbdeMMRLJOGIkaN7cR4IL1hHbImz+9YTb2Qw/K3
         Qf1qaCNwp7n5BEu8DyaRRMPIL+HvDcadObMkSsqAhAwcpOUYRbJArpvE+UZ2OkgzbGCx
         Eg5fSBS6k0AHL8sYF4cMg/WhxHyANiHDAWpXhPGnw7+DrTDRPcNZuRXw5Dpbtu+IEnNe
         giRA==
X-Gm-Message-State: AOJu0Yz9MeL0B/gTsrV3PtA5mtlBbodiE64O+DiiX56tv0G2sXuMwTz3
	4g1G/At817tB93+oRIu+HfHjsoZ1bVMWGdXRbck6PfrpHaxgcR+wxRqXDN7I
X-Gm-Gg: ASbGnctdotvJ1cW0db2mHLL2PUbEN1d5DIRksVOS+T/xUQ55paT+pvCB7JTTmC2nv2i
	sVfdxcqPNYhojf7od7fYB+nMzpkxWQJmL+uQVIvw1GLtLxR6zWAEkIO+w2fqnInbPxE3I/yijkG
	tahMTJNqIf9VzVRwbvmLq9rjHxzcAC0qKvIgAWbycg+FeguSgpD55BkR7GiVqpc3KMyCRchvDm+
	pMl82nDGF5cj2tiP1A0Hm+URJhtIw49M6m2S3PzP0pOz7Yd1HfUpDblwdLCqGUFMMBZZyjKAmPK
	dyy1wdiQwPs2xImbjwA0JMETe9IsuOW9/H56IOkPjrYjPFhVgln+AfWaCdvIzwHD8R49CYVnXg=
	=
X-Google-Smtp-Source: AGHT+IGMXgWp2sCsK0h3sYT+DVPaT3Z/C1xVptZe95gUhf0YKZsXFukVbFHwXn70XbmbC4dIYVXZTA==
X-Received: by 2002:a17:906:c111:b0:acb:2050:c105 with SMTP id a640c23a62f3a-aceff023d58mr302216866b.21.1746129558486;
        Thu, 01 May 2025 12:59:18 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-228.dynamic.amis.hr. [188.129.44.228])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad0c70d4b18sm88412366b.12.2025.05.01.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 12:59:17 -0700 (PDT)
From: Robert Marko <robimarko@gmail.com>
To: selinux@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH] policycoreutils: run_init: define _GNU_SOURCE
Date: Thu,  1 May 2025 21:59:13 +0200
Message-ID: <20250501195915.820343-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to compile run_init with musl will fail with:
run_init.c: In function 'authenticate_via_shadow_passwd':
run_init.c:206:40: error: implicit declaration of function 'getpass' [-Wimplicit-function-declaration]
  206 |         if (!(unencrypted_password_s = getpass(PASSWORD_PROMPT))) {

This is because getpass in musl is guarded only for _GNU_SOURCE, so
define _GNU_SOURCE for run_init.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 policycoreutils/run_init/run_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index ce499781..4531a8ba 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -37,6 +37,8 @@
  *
  *************************************************************************/
 
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <stdlib.h>		/* for malloc(), realloc(), free() */
 #include <pwd.h>		/* for getpwuid() */
-- 
2.49.0

