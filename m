Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC41411CA
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590219; cv=none; b=AjaK+e71kSEHKV+MjtuaAwEEjkJ8X35vnekMdhZSZfybeyj0HXggRIf+LELsGWdTcnb0zNlaYNT0wsUyCywhq3bkQcW20jw525RJ/BCiBOasDmITF1bKAF5DS1sE4VniUFPfF7FiQQHqGQjalrkLUHbKegCakElSmBZV4Ea9V3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590219; c=relaxed/simple;
	bh=p6B2ou8ubjDyeouhAdqDD0+xgIlaWOZ/mUNA0kDXlwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGyHSJdYnzpS9C7e0uCU7HYcizULpPtRHNSY4jic7Cs1wvLshcepStetQd8+gopPlf6/Sx0VY/XmUuZUFNRg+2gf5i8nO2KRbSgKkyPdc18N7Fh8LkuViGE7xBJBoAgZoLigkL6vMXnbb9gsDcvMGZFcS+ha/Px5gO0HN9o3vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=m1mI8lF5; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="m1mI8lF5"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712590214;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6rtMpDnc7eFkyYnxLeIFrxFhRqsmdRqdyITiQzzXU+M=;
	b=m1mI8lF5XazkoGTkjnMMvdIqnk4N1AzdeW50aMKJqSKjS5fJSrS+5bmmDjwzlJdIfOPRn0
	KEUM3Xdq0qLbeuDoMstRnnG0ommdzrq8Doqr1UbcrZviXuiiPMK8Sql4YsIJu1j48Em2k5
	bZjZepUekwk9a8Zcc53tfk0fmT7Hc2NvfrqorhRsx9kPhbO/84J2owXV0Ukao6WB6vEK7A
	JCD+zK2XhrUywxG0RhAyJr901pxlFa9bRJzeo1ALotA6u/pmrQ+3Rf58nzJB6HSkKLn8T+
	aY/JCP68GLAT5a1iRVaTV7WueeC4yie3A3VdexppRwY0pS8VXHyl7h2jB13aZQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 1/3] newrole: constant time password comparison
Date: Mon,  8 Apr 2024 17:30:04 +0200
Message-ID: <20240408153006.69840-1-cgoettsche@seltendoof.de>
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

Perform the password hash comparison in a time constant way to avoid
leaking the length of the identical prefix via a side-channel.
Since only hashes are compared leaking the total length is non critical.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 5a1a1129..1e01d2ef 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -338,6 +338,24 @@ static void memzero(void *ptr, size_t size)
 	}
 }
 
+static int streq_constant(const char *userinput, const char *secret)
+{
+	const volatile char *x = userinput, *y = secret;
+	size_t i, u_len, s_len;
+	int ret = 0;
+
+	u_len = strlen(userinput);
+	s_len = strlen(secret);
+
+	if (u_len != s_len)
+		return 0;
+
+	for (i = 0; i < u_len; i++)
+		ret |= x[i] ^ y[i];
+
+	return ret == 0;
+}
+
 /* authenticate_via_shadow_passwd()
  *
  * in:     uname - the calling user's user name
@@ -383,7 +401,7 @@ static int authenticate_via_shadow_passwd(const char *uname)
 		return 0;
 	}
 
-	ret = !strcmp(encrypted_password_s, p_shadow_line->sp_pwdp);
+	ret = streq_constant(encrypted_password_s, p_shadow_line->sp_pwdp);
 	memzero(encrypted_password_s, strlen(encrypted_password_s));
 	return ret;
 }
-- 
2.43.0

