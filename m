Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223A16E863
	for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108217; cv=none; b=DeOYrlcua8ekII0XB+MbZaV7di2HZKp5nyKyp4d80fHzCRMy6MehvB7vSA2sfywfA8xbXn3BpJNzcC47GIuC1fYKaen6b67nldyD930Q8oM/KsH6/UTiGjsKdWM+5aFDD6onzKsL7ND+VWI7naZZ5sIHS2s/1du8HvgWA07j+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108217; c=relaxed/simple;
	bh=ZCtf+sRaoN7nESpIXyg6rlncXVEizdn6TnLJ3vD6CLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OxkxwOMtsz577UXwAeWWYAZMThUbrkphMEQzTdpwV3geUaEle9qbkOjJAPkzz0cIgj+hNlTUIN5y2FtNmkYD+6TAVfCAa/egm0upaBIlPzExTgi2I+/1rGs5fw37JZyDjJeel9vR+JnlxLx1F9al+sAVpeNV4PPMyw958jWxZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=S9Li3Bkp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="S9Li3Bkp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732108212;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A1TVC6AqTMMpgotZ6ZV8OJUe+AisptsuT8z8QJsWwdc=;
	b=S9Li3BkpAmrVTxa/iIVQGIl4jI4EbWEasyXsglJkc2kOFpdn1BuaIiUullqs4czgCAJJSc
	QH6VVYiTWWi8xu8VYnDAS3/4rIwAN27/6lSBNUdXI0eMp+e5eZaLbACm2y0Qxv/CrxG+LA
	zeA5XukMGoZ87Y3NyTpy0hwgZpDYz179EN1ipMYvKMorgYyqWsKtfhojjcJ5D59b5b7tua
	Ho6YpzNLpusRmuvHVPhqysHdcFiD0IQs4iE0EMuHNWWqAww/LkEfH3JK0bIwv+Ii0wwA+E
	s02ISjUkdjnPD7rmQUjjmo87HFjiwrkJ0EMFuZyLXxtd+xtd+oxIG1itXXkykg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libsepol: harden availability check against user CFLAGS
Date: Wed, 20 Nov 2024 14:10:03 +0100
Message-ID: <20241120131004.58662-1-cgoettsche@seltendoof.de>
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

If CFLAGS set by the user contains the warnings override
`-Wno-error=implicit-function-declaration` the availability check does
not work properly.  Explicitly enable and treat this warnings as failure
by appending the appropriate flag.

Also include CPPFLAGS in the check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 7b0e8446..71fa3ed7 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -31,7 +31,7 @@ endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-- 
2.45.2

