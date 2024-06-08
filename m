Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4014A8E
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867127; cv=none; b=BrVJOQy5NCfOCz6QIh9ZDQvsVkSPKgY0v3uwzwTHDRYFYBlZX36hleQ6raTCyCzb8G4UyF4/9zX6ltbxciQpru2Wc2XZP6TnLfBbYXo/5W/fSEDz/F/uPcqOczGOjpnoQnQ2MgYxgqIi5d3z47FIXsXOPNEAWTc0Sq3VJFHQmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867127; c=relaxed/simple;
	bh=jVJlxr4cCG5OlYoTp1Huv9XgOcZuSzWZ+ixH6XOuYiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TcOrBCUJra7R5ylZT5/Cvv1tShncWfk52D6dmGu5Kiu1gU+ypJOMg8+9HxyJ5x1Yix/mreGgKVsYZ08LZYJvSDz+TUtq3r+1ax1ZmsVr0dcqzLnVZhas5Pvv/0CIhbGpD4XyStV+4yBacFGPINyzkpcwuqX243Eg1ykpyU/zBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XYNQWadq; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XYNQWadq"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867121;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PZdSkofHMHe53CuVfPH+3iV/NOZ2JWDGYULAXqAik5Y=;
	b=XYNQWadqOOXZlcV+YpbcQmKMLMhbI6XE8mxIQ3tJLuPp0xd927rTblTX8fqXP8bbzdYuIh
	Scc284pyR0pCUmMf//eknmvf2IpdA+ji5Ll3JFxncA1nrUF2GvO2JFr9ENiBHqQuf/JqzV
	+YAtmYpMPyh6Fim20oc+79+KZ68fOs3dajEN1WKhNunLqCZLg/091vubsLZGEB92gwpAoo
	UnitP8/dmMUPw4LXtqKdCKAV8etvaFaqHNrfQZ27o7GNv+tn5c3F0a+rmNZaMXlPly1q57
	LKcwP1IiZwLd7uGkazzVWrproHWt0ZamxWSMXLrFIr2PhODZa11dHuWxlNSVNA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: validate attribute-type maps
Date: Sat,  8 Jun 2024 19:18:38 +0200
Message-ID: <20240608171838.136163-1-cgoettsche@seltendoof.de>
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

Ensure the attribute-to-type maps contain no invalid entries, required
for generating typeattributeset statements when converting to CIL.

Reported-by: oss-fuzz (issue 69283)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 84c1071c..9746f562 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1654,6 +1654,26 @@ bad:
 	return -1;
 }
 
+static int validate_attrtype_map(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
+{
+	const ebitmap_t *maps = p->attr_type_map;
+	uint32_t i;
+
+	if (p->policy_type == POLICY_KERN) {
+		for (i = 0; i < p->p_types.nprim; i++) {
+			if (validate_ebitmap(&maps[i], &flavors[SYM_TYPES]))
+				goto bad;
+		}
+	} else if (maps)
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid attr type map");
+	return -1;
+}
+
 static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 {
 	switch (p->policy_type) {
@@ -1790,6 +1810,9 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_typeattr_map(handle, p, flavors))
 		goto bad;
 
+	if (validate_attrtype_map(handle, p, flavors))
+		goto bad;
+
 	validate_array_destroy(flavors);
 
 	return 0;
-- 
2.45.1

