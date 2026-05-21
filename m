Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E137DAAA
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386501; cv=none; b=RwA6cUedgpVZ9ywgtfpgG9pULIuuHt76Dyq2kUoPl4PbHzI1Gk6ezMboTAxqZPBcY3VQiZ+FqVLFujvXnl2qRvCyvVyAROiX3+BLWavtBMIHS1iGcxxyYH8B+rkR+WKs5cZyujtNId7lv4QNGqOXFFe6lTsc4sBbyQxaqpTBILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386501; c=relaxed/simple;
	bh=Br2IraOYmnSAO2HDJ55ML2x3EqGTIXZoRFCIWex6wLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ennlvJwnsQLCVDMiDbZU/y/PJtJTrYCJk9WHf437fLST6Fn+y+ANbS3snuVIBFU0hCgwe+tLAdIbhQSX6/0Kvhbamc6nWWyup2wf5sIPZDsvK5z2/7ZN32Fk+dYy2JmHn78tJrOjEBluOQTMz+hZXtSeuDAagEdU0PJKg4qw5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb4D+0v6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb4D+0v6"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90caad2e944so683166985a.2
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779386497; x=1779991297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNXD9hhnGc8w942J2g5ZJf95GuMvBbWkiPMguEN9kik=;
        b=nb4D+0v6w7UkNfBIi4pr5snwX6uOCS6c8mvygJklgF2uOdhOI0zTPgeAPoNSeFpOl7
         SHeZlab4GGIOSciWnbCWQyVUQ6yH72lBJjhtliojXVAiHSdsx8WgFZsxXNY702AUY5Ln
         g+Gk8wFXK36fnSCubGtNGtSIINtxROKi4aU1FjYnj/D2lEFjtFJzEuvoHucE9h25uLRY
         pK5eImw8l/W7czkoGlMs9kWFqdMiObpbqkN951xo3s/SnUNzXf9gpaXYfkphL4m5d2Ys
         sgIvW5BAQjouy3g+1KBHc/JgzpU8jO+8PJtNI9X932pLLhvhjoLa5B9b2yuekPBenyZI
         OCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386497; x=1779991297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNXD9hhnGc8w942J2g5ZJf95GuMvBbWkiPMguEN9kik=;
        b=egHM4AGTp6J3GC0L4BAALyB3m3z3JFbKvgzqTEbBN6AQCJP70ZYD0ydt8dZLlGbZJ8
         E9H0f/IfwCjLo4ftsCxTYcJ/8zfEiJYe/STVrmmTYL8Setm0KAeD8skVgcMp+dFOSEzH
         LMAJm7ldVmej3klqwAvjUKvJr9Nr/7rt45c6NMD8iPR1pRM2HNS5YFSYUw7uDGKb3EQo
         Vv9nhHGmxkMZ/KHT3qjDVQisjm9DvqDPFSn0zLTUBc1O7ykdgPh85fcXMAgZG+aTeLjH
         hNH9tH0L8a5oLTfdpuWv6jCTpv66uS+6+MJOzst/sl5oyYWFdHn+lw1ysyIYrWWR1X4E
         vxUQ==
X-Gm-Message-State: AOJu0YwrHUJnEwIFNzfvSHO0w0PAXfmQvUw0O076gU0ftgIil63xrqIR
	AeAlMD28Vzxcd2PVLBXhyzwvuImbaI1jvVz3FaGzsrU/z0+YdwVDlZMvMcRdtQ==
X-Gm-Gg: Acq92OH9swjrDlkds1Hx4G9chAuQw32zmiEqw9CAtOwYuIQJtTLI7tSeAl5/Oq3KJUf
	e+uOjHNqdpWLU3HKe4Cu7HNV3a55/6rYGgy/DzX2jwZ6pEbmTAMVPuAMkA27LwbUClaegerdXsO
	1V1hnUuCDX6xOw3ue35tYKLaydxfUMRPUn6VFIl/ZnCwQ7vh+m3O78qrNhIjbRVLTcuBAVDM1KU
	SfEpzvMWuQCZYhuiVCTy25LMfUNtkjmU3mSadWmb30zYfUOmGces8duMjzbdOP/G9A4gb2lOsel
	M7ElOPesbdif0mT0ckqnFBCNNrns6qTwoiFG61mAZXKhM+t8jR+M9LEnKg3pSYV4lPu9YAJl+ZK
	P3NiJd01tJCjpJWt6++JvEQFDgnUS7WsZDatsAIOivjJn715HDUriY1B1UCQCZRA+ncMat+WpS7
	3rbb4WvElzfuTAbrdBgSkJM6ray8l0n+q9AZMrtlUsiGMNwg==
X-Received: by 2002:a05:620a:4115:b0:910:48ce:4e76 with SMTP id af79cd13be357-914b48eeffemr32999385a.24.1779386475857;
        Thu, 21 May 2026 11:01:15 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914aba41b8fsm175919785a.18.2026.05.21.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 11:01:15 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix double free in copy_avrule_block
Date: Thu, 21 May 2026 14:01:00 -0400
Message-ID: <20260521180100.21791-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is a failure in copy_avrule_decl(), avrule_decl_destroy()
is called on new_decl and then avrule_block_list_destroy() is called
on new_block, but since new_decl has already been linked into
new_block, new_decl will be freed again.

Instead, just link new_decl into new_block after the call to
copy_avrule_decl().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/link.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 188b4020..e0da6575 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1757,12 +1757,6 @@ static int copy_avrule_block(link_state_t * state, policy_module_t * module,
 			}
 		}
 
-		if (last_decl == NULL) {
-			new_block->branch_list = new_decl;
-		} else {
-			last_decl->next = new_decl;
-		}
-		last_decl = new_decl;
 		state->base->decl_val_to_struct[state->next_decl_id - 1] =
 		    new_decl;
 		state->decl_to_mod[state->next_decl_id] = module->policy;
@@ -1775,6 +1769,13 @@ static int copy_avrule_block(link_state_t * state, policy_module_t * module,
 			goto cleanup;
 		}
 
+		if (last_decl == NULL) {
+			new_block->branch_list = new_decl;
+		} else {
+			last_decl->next = new_decl;
+		}
+		last_decl = new_decl;
+
 		state->next_decl_id++;
 	}
 	state->last_avrule_block->next = new_block;
-- 
2.54.0

