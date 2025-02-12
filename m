Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE4256C8C
	for <selinux@vger.kernel.org>; Wed, 12 Feb 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379003; cv=none; b=np/hhiFvzjgr0Hv/9Rp7ccgu8glREZu1FnpgTqlT3Gc2aNyGAY3QuN65JYe9FoLNfFXw3WMpr1WS75vVmDDemztG3oXsjKmZSSpUwq5VZHG+PxX9CKwTeDc9FXTI3lYVz+2ZNVVWapcsRumVfDO36gFHQxLI1KBYAM2tYi9orq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379003; c=relaxed/simple;
	bh=sdN0h9KMJVVvMB7+IpZI/9FIGAso3oY7c0wORGhpISA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lyKRt9LRRXR4IiBT2SNvhdw2ym61hDF8RrKVWapHX0LM6+YOe7amRD6zCdXufwS+bsw+7bLy2d940gwgPh8O0XSe+msyZ6XreH7eNdwbtEPngbgQ1WguFJLTLkrYJ0o/m6F9AoOQZNATHfBMZX6lWLHEE3gQz9uyEXw2Dhx+CEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XrDMhNwL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XrDMhNwL"
Received: from localhost.localdomain (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ACAE2107AA1;
	Wed, 12 Feb 2025 08:50:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ACAE2107AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739379001;
	bh=GfqxHTqA2RY7grqWP6oTbwqQRgjO+3YS8gkyT6eswnk=;
	h=From:To:Subject:Date:From;
	b=XrDMhNwLXbBg/a3XasutL0+TLPdPGDulNAoT2K0z8X6OrGx4sXwS7TqiPn3eWVxxQ
	 Jg2Ev6qti2Wfn/CAHHuQ7XUW4UtP+I+HcaykpO8Nr6A9/QxcWojzVKw4yiutcrx4VE
	 aD2G1r6mjPJnUR+jkhy2tg7PFR+BTgyJ0nxE8x80=
From: Daniel Burgener <dburgener@linux.microsoft.com>
To: dburgener@linux.microsoft.com,
	selinux@vger.kernel.org
Subject: [PATCH] Switch from bison name-prefix to api.prefix
Date: Wed, 12 Feb 2025 11:49:32 -0500
Message-Id: <20250212164932.35152-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid a deprecation warning when building.

api.prefix was first released in bison 2.6, which was released in July
2012 [1].  name-prefix was deprecated in favor of api.prefix in bison
3.3, released January 2019 [2].

The new api.prefix construct rewrites additional variables when compared
to name-prefix, such as YYTYPE and YYDEBUG. However, these variables are
unused currently in conf-parse.y, so this does not affect libsemanage.

[1] http://savannah.gnu.org/news/?id=7269
[2] http://savannah.gnu.org/news/?id=9321

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 libsemanage/src/conf-parse.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 6cb8a598..93a04699 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -53,7 +53,7 @@ static int parse_errors;
 
 %}
 
-%name-prefix "semanage_"
+%define api.prefix {semanage_}
 
 %union {
         int d;
-- 
2.34.1

