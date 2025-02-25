Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D71FCFD9
	for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494011; cv=none; b=ABhBA2xO1x4TSFZa+Gg2Z0VaLEiYldtjC81BLHpH8NEcf63TkqgWQ/d4MMkMEONC6Y9aVBUQQl3Qm/f/Yi6psMpTX+wC97OX+dtvKZTtPY+J/tpc0C+f5saUwU4kzc0Idu7DRXO60kTUh8qAteqlBy11kvyDdNtNLwQMSRJBkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494011; c=relaxed/simple;
	bh=MJOjnvAc/2XJRJnUd0gXSf3quU4fOODLSappYyYSOG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iQavTEGDj3kyilh8z8EUxhG5B9NwATxg6xtrCpLMWPfafL/gXzgo2J0n92kjhmG5b8SbDqQg50ZtRlo9PSv9zg2NagKtBASzg0jpS9Gdu9CMbfVeOWyvrGryV83hu3jDeWwAmyRGOG71u71Odv1Tz9JHb9UVu0oCXdnQvRx9GEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eXd8SWdz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eXd8SWdz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740494000;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IP8jQCXeMRlkXk6Et0h1aJ/qNT0ysPNweO4IpGnIKGc=;
	b=eXd8SWdzhuWbRjaRiAf7B3P93CbrCedhvI8b75b1X227uUK/w+LfoBhk85v4nAVMGP7v8b
	RfYUmlx90inDF0IlZpy37wJTUV0eh2rMsJq82kTP4BH3Nq7kscA06dcsv6IEdff2261/Yf
	KZ3j3YdRhmeBdKIbgvGIyErFB0+yhc2FREQ4hRnO7IBxcRdbJWGTEFX1+pTQKJjs9J97yL
	OdxV+XofW46qUbVkuurTvxrzHBR42//ZU4ZnXHtS3QHyC2QXqf2hUmNJ/c6ORGdGC2+lLa
	a3vVjeb4vh1lUEM6SqnbM1j9Ai39K8JCDgtZe7vPTfjtp9cZQ5K1v72TazZLWg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/3] checkpolicy: abort on mismatched declarations
Date: Tue, 25 Feb 2025 15:33:10 +0100
Message-ID: <20250225143312.47755-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

In case a type or role gets re-declared as an attribute abort parsing
immediately. Since yyerror() is called the variable policydb_errors is
increased and will signal an error later on.

Reported-by: oss-fuzz (issue 398527873)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 3a7ad1bb..efbcfa7d 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -291,6 +291,7 @@ static int create_role(uint32_t scope, unsigned char isattr, role_datum_t **role
 		if (*role && (isattr != (*role)->flavor)) {
 			yyerror2("Identifier %s used as both an attribute and a role",
 				 id);
+			*role = NULL;
 			free(id);
 			role_datum_destroy(datum);
 			free(datum);
@@ -428,6 +429,7 @@ static int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type
 		if (*type && (isattr != (*type)->flavor)) {
 			yyerror2("Identifier %s used as both an attribute and a type",
 				 id);
+			*type = NULL;
 			free(id);
 			return -1;
 		}
-- 
2.47.2

