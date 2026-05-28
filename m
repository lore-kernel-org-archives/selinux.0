Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889C3E8329
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971439; cv=none; b=qwpo5P+LMMtrLsQeBeAalvJppE6RxoVKuC4kTczwrXDD/FeqChzBMJygfbo1+6VooDt4PkOSyoAHC7VzFrTe91eVwDO+mMy5X/E5LEOJGQN2otElptsVksecjKuYAXHnP1NNbDj7yjDD473DcuWv5WIc1J+Ar3kKYtvHdIsb8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971439; c=relaxed/simple;
	bh=dBEsOkdnTalxRHT8BD4ymuqWPq/uX6M4ClIGWH8md+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AI2VXGRrwAhgHYkrpVOXanZXFyBo+69hDDWwtMiBKUuPI+wAaNQa8a51pfmu+XYEyzco2f539vZbhcRlq3dnQNrhoEHlBEdY+ipFWXP+dfLPfUjYiK0JMFjXSlyCkAaAQni41yAYWfyGSBGQaTa9Tf+q3HXdV891p6uBrDtzATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUlISWEZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUlISWEZ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-914c1ced558so313021585a.3
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779971436; x=1780576236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSQlyyFpDVdyyQ5NtFtIgXQ6J15U3qGEn5QOcy2ylAs=;
        b=UUlISWEZgKmqlfpUs7DRC/eQzmyYTeuOM62KAROrevA97RzO/DXIlsezYYvlnAT6Ee
         h92O8l9CCu3Gv3jLsB1QUCiwICHYIRYuKnkTaeXtVOxbxrA0ShPUOxGkIaAq5Ct7n4os
         1rgU9fvTA7dhhQ02KxEzs0ggjnPjy0nYN0+XNdz3MYYw9g5ZuaEj5fKlTdLjnUwQALDb
         U5E6NLu735EXwrcq/sdIWcHQNTdDcVK4wE3y3MchrJXgWPTBrpzAc6xH85EFF2xlnUus
         3UOvIu0mSw9FffUxY7BJI0JJzYu/q+eukCJsTz1Bu7avKWHRHeWTavsidzCH8inspvQR
         rL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971436; x=1780576236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSQlyyFpDVdyyQ5NtFtIgXQ6J15U3qGEn5QOcy2ylAs=;
        b=LNDEOxmiCXGZ3l4dLUDka210BdHR5EoSlWrYmtFzs5Kk5SheuPMfcY4LQXorRinWeG
         AxLbbnE+yoMA7FfIML3gg3lFeWoTSkOHspdcgzY8lliKSRpaJTBYvD4rmmAhA5+XX/4i
         Utnpgo7YHC938JiwE/kmdIjH/HKK2BybgsnAFLyIi5gpRywwvud1njGM/76nKGZCDnKE
         v3diMOcFbs49Q1ATDp6fl4io9YSyC3mjbjMmp6ZOAb0Z+5IBqs9ealGggqlTf72E77ov
         z3b7EAhgfVyDKAWS/mW/mc5JARnDQq9a64jzL22nH31gN8U++c/4XYdw8O2/CAYfg/C4
         1meA==
X-Gm-Message-State: AOJu0Ywk8XlZcJTnRnWamvb6pg6ZvnvN9i9NcSZe3NyVA/FnAyHdMUGb
	/Y95nWys3dE3B19cDuTxw+2JcO6YioucfXkCO2I5MpM5wlZe+orc7+VKFcPOdA==
X-Gm-Gg: Acq92OF6YvtMmy2PbExgvyT18bpFV28RLQvCa7P4EeYwVtrPqI0alyH6Q7GPLFi44VT
	ssllXZsIfDrJOEbC6KQC9D64TEImi0Xs4QLeOuw6hvn/amXyK3XQ2e9oFtVRp9WRQ9a1ToWB0Qp
	lIMUuFuW64quNCit9a08CGVim6qLQ0Ld545EkI/lrwZBWz1qrXu9Zo+CMeYKyugrftpUAUho0KA
	xtg5wACLdttaT+GKa9+JoNPTFKqDNT7sMWZ7LauunAJVaSyCXn6fkqAwgjP7Ve1lAYCgd3DrD0d
	sTl/17X3KVAFzG3xyVjBUzvgqai3yBA6wXN9BY8hZUx1jQ3A6gsJnJ+VcuLzZ8vBQJNUNn4UuZf
	FzlC6YB0K8zk4xUMl9azTR0EtW8kaFS9hbNRlvUqEJMwbWD9NYpbJHSFfONkMSWwbGOeC2oMbJF
	gP2FWrdkCntAVuHoqXghyp5YO9GHWinGKfkiso+3YSM/gioKQ2lOdSZqjkP+eCYPgNakOeAv9b7
	q2ra8z3iOHnQpFUd3NpfjHMsrnrGV/OQqyfpA==
X-Received: by 2002:a05:620a:4083:b0:8ef:3de6:c5a6 with SMTP id af79cd13be357-914b49dcb9amr3721525085a.47.1779971436167;
        Thu, 28 May 2026 05:30:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c1b1sm783298085a.40.2026.05.28.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:30:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] mcstrans: fix off-by-one in MAX_CATS / maxbit comparisons
Date: Thu, 28 May 2026 08:30:19 -0400
Message-ID: <20260528123020.35148-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a given category name cN, N must be strictly less than
MAX_CATS and maxbit, e.g. if MAX_CATS is 1024, the last
category is c1023.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index ee99a19e..ff33621c 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -192,18 +192,18 @@ parse_category(ebitmap_t *e, const char *raw, bool allowinverse,
 		}
 		if (sscanf(raw,"c%u", &low) != 1)
 			return -1;
-		if (low > MAX_CATS)
+		if (low >= MAX_CATS)
 			return -1;
-		if (!fromconfig && low > maxbit)
+		if (!fromconfig && low >= maxbit)
 			return -1;
 		raw += numdigits(low) + 1;
 		if (*raw == '.') {
 			raw++;
 			if (sscanf(raw,"c%u", &high) != 1)
 				return -1;
-			if (high > MAX_CATS)
+			if (high >= MAX_CATS)
 				return -1;
-			if (!fromconfig && high > maxbit)
+			if (!fromconfig && high >= maxbit)
 				return -1;
 			raw += numdigits(high) + 1;
 		} else {
-- 
2.54.0

