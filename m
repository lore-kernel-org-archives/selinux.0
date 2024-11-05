Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869D1E7C28
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831610; cv=none; b=P8Mqzu/HS9VrAA6UCp5ZAwnKIYSK3uC5ug0uxc1Xh4BwB4jJIWnJJf0hUZ4wu+2s76Ohg/gwINjjM3cFxLtqb8k0TxzNQP3/8xyrFvZbji83msflL/3WbKzhqp0V3pTYwgYDGZB3CoDp5+a19IJiGdZx87qos58jWL8lvgPgNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831610; c=relaxed/simple;
	bh=zq7qegPs+MIxHr2udYwPB6IuXyJjKDZIEzGVLHE6mDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5/gkNJE4NWscobte2cZzTsRIPj8zqo0J1S8aGrYPu1rKTcCX6ZKfbkhXG6aQi5i7FIbMxEVNgfLLP1plsC18MiUcPJe1oaz1rOBTtyWQD7pgy91Icl5X095zZr18Rg5ODsrW1C6CTGBvAclQrZ1iadRp8mNyrbaYBmPAK2xM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=k96EwGrt; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="k96EwGrt"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831606;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+zNG2cGuxfEII2EjpBflWb3xgf/1Ub8zkeGZTIGHXI=;
	b=k96EwGrtAsaSz3DiO7W1UGwsSayZKtOsQudaybcXHqXOaPREtICHm67rfuIY09gYcpU9Rb
	OSfI74TDrOvE62X5DF03P8Z8mejd5EzxwkK/UWlvaWRjqIfpAiBnFrUqyy6XaXIJdJijA9
	zZ29P9ZkqP9QuuURbVoJ83KT0ZwvQHIll6QQEAjPYPN2N8SIznHkAiCob6eBYLKrJSSWSf
	YvicWjzGm4MFLR/+VyeSN1xuSSRC4hoDWlFCoIrdAY46+8PLwxKzVSAP3iPFT+HkdS6b26
	uqsB6/o+LTSz9UmOrqqYNfWSxYIGvY9CpRhLC8MhLlXm3vOX0xmn7dbA0hBcrw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 4/9] libselinux: add unique id to sidtab entries
Date: Tue,  5 Nov 2024 19:33:14 +0100
Message-ID: <20241105183319.250410-5-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Reinterpret the currently unused - and always initialized to 1 - member
refcnt of the struct security_id to hold a unique number identifying
the sidtab entry.  This identifier can be used instead of the full
context string within other data structures to minimize memory usage.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  add patch
---
 libselinux/include/selinux/avc.h | 2 +-
 libselinux/src/avc_sidtab.c      | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 1f79ba16..c007b973 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -20,7 +20,7 @@ extern "C" {
  */
 struct security_id {
 	char * ctx;
-	unsigned int refcnt;
+	unsigned int id;
 };
 typedef struct security_id *security_id_t;
 
diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index fce5bddf..9475dcb0 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -4,6 +4,7 @@
  * Author : Eamon Walsh, <ewalsh@epoch.ncsc.mil>
  */
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -50,6 +51,11 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 	struct sidtab_node *newnode;
 	char * newctx;
 
+	if (s->nel >= UINT_MAX - 1) {
+		rc = -1;
+		goto out;
+	}
+
 	newnode = (struct sidtab_node *)avc_malloc(sizeof(*newnode));
 	if (!newnode) {
 		rc = -1;
@@ -65,9 +71,8 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 	hvalue = sidtab_hash(newctx);
 	newnode->next = s->htable[hvalue];
 	newnode->sid_s.ctx = newctx;
-	newnode->sid_s.refcnt = 1;	/* unused */
+	newnode->sid_s.id = ++s->nel;
 	s->htable[hvalue] = newnode;
-	s->nel++;
       out:
 	return rc;
 }
-- 
2.45.2

