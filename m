Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CF30100E
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151454; cv=none; b=Zb2XzOO+P2NZCTVv+fOmFZNfg+3tEwQZyXyGS7Yx78m3D8X18eIrBUJAa9B+O2cSaHwuik+g6FJW2nYBAevc9SsgMiTmjOE/4z41syRUjyQkvOoOeouTjaUneP4EzQWS9O/LTwmnZJ2fS4oNNfcNlulmUNZDYAUw71K2BENxGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151454; c=relaxed/simple;
	bh=ZD2vgaoHNCDVN+a3bC8XmchhSualWbf6Yr6Fit0dthw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJh+JZkAMmd6XgMNVwvzeUmuCeek7QJbmHruMed0r2U9GYEDlAJowQCAp28bhLAudVsFNQm3BRfQPpjRmD4Duu4p3vX19HI7WfDA0wOnc/PUlPVVR4QsIr2V9RWQJ2v+4XFpYY+L6gU/aEepmf90Y0F4oCknvDqOUeySBQe2BOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz4fTdLm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz4fTdLm"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso8442426d6.3
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151439; x=1787756239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l8iRtjUrQBoL1M9zjQN+e4JtB7ARMhNhZU6Va8q+rnw=;
        b=Hz4fTdLmY5jNFISr5IvruVy9i8B+XNhzyqDFsw88XQnBpOlbBcUZXp/P6o7h1p9Iwf
         LM7rMEQH3H2rzAco1TcvB1f/d6oxU9+gPoQSymUZF2ySnVGBr0aSc/FIo5TUZOhgRjRV
         rQQ/UkZS/6PgQX7Pspk4Vkb91JbRY360GLhZLx3mxX98BjvtCwb6cLxSc4CxjeVk77Ew
         vza7/YIEPZpX2z5xKL9DTzNtsZNHoKSHP5gB6B7xxyren3DsGQeWvIkco8a9pAtBf+Zz
         YgrIu7JxX8O/WR7g8sbwjRF3t8hush71Pshjn0/zwVblWIYJiqRxg4gZ6I3vy9u2FCU7
         cWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151439; x=1787756239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l8iRtjUrQBoL1M9zjQN+e4JtB7ARMhNhZU6Va8q+rnw=;
        b=l7kFo5QDBdlHccJzCMC1nIIdi2Q3XdY8BblKBXIzREjw2cPMWURnf3Q1p7kuH87eOg
         zrXVpIWo03kE5EVCfRqpxub0pLpiuRKX527IoedQ9tveFim/OnEPnrj9mJw0Iv6S2lc5
         e1LVFhHAK9kmhZB73t59G6YSUQofNh+MbHT2SW6D/dhyBnf6Gbv+oc4I6f+fiTuIB0YV
         xCYUgpBNdFHcgm35iwgkEZSIkmgoV6KW7WSN56eyetCZjEKJMkDz6DF9E0C1HK9XRsQc
         KqCXjwFUkkIBEgHReZQm/P3SS3ujBgfEU8Jg1KyZN6Gh+eAyAo/yex7Cx2VN0oy1YLMP
         3tbA==
X-Gm-Message-State: AOJu0YxRAHFvUrXGknVZxr3loDrEBGxo0KGhODuYiOjIKPZy7RNiYxTO
	AesoVl5Hl6+vohpWwOFgqAv0cNPmlx8OkTX9B4x79PCjWZSp9IiTrRqtoVNJmw==
X-Gm-Gg: AR+sD12cxeHH1yjSN4kd7VVDf7wTfBdc2gYvLktibHM4NAmvI0+t+U7ZpY5B4DX2zv2
	YL2GXIjnD9x2NuBHacp4IH6rYdvAsR42DlfstGHF3s2z67wWB+Id2ZgcSXZ0NiGu/ioS5pJye/l
	Szmv58vDChx4ZhAD2XARFNKzsdQY9/AkYeQwL+5D3LsqEMq8V83UTyCAPXsTWXUiD95UOwX/nxv
	J+xmBCbgeHlHYMwISmVY8KIU0BzQXJE0J+vmLNURluP0IlpXSVQuR1gXcQK2CTBO+kFBYiQimXT
	kvRbNHnaLQ7Twm8JSTyW6Yd6cl9yXe/kdeWUB7br/DYoxsaRdapI4vlFgnvtWUf5ftJ0UVMUi1b
	htYi5GirqZXBoQFqSB6h2zRq03g+6rsEC8enf1L3tZrwpoFze9ZfnwEEzZtqzh3iop91qF2GPQd
	ZVQ9vR8BNUI+HXjwkasWt2kb+SngtxK7KPsHV5kcQyd+CVVlFuwCP9IWp7e+0WiT4WTmTaLWUMs
	Zwn8wpzSCU=
X-Received: by 2002:a05:620a:2a0b:b0:936:ea3d:9313 with SMTP id af79cd13be357-9371e2799c0mr502584685a.20.1787151439342;
        Wed, 19 Aug 2026 07:57:19 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372049407dsm152030985a.8.2026.08.19.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:57:18 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Check all the permissions in sepol_check_access()
Date: Wed, 19 Aug 2026 10:57:02 -0400
Message-ID: <20260819145702.71314-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The program sepol_check_access() takes five arguments: a path to
a policy, a source context string, a target context string, a
security class string, and a comma-separated list of permissions.
It calls functions to turn all the strings into values that can
be passed to sepol_compute_av_reason_buffer(). Unfortunately, as
each permission in the permission list is converted to an access
vector, the previous access vector value is overwritten, so only
the last permission is used in the access check.

Use a temporary access vector when converting each permission
string to an access vector and "or" it to the final access
vector before processing the next permission string.

Signed-off-by: James Carter <jwcart2@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2: Fix commit message based on Stephen's suggestions

 libsepol/utils/sepol_check_access.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_check_access.c
index fb3b7edd..e80d6464 100644
--- a/libsepol/utils/sepol_check_access.c
+++ b/libsepol/utils/sepol_check_access.c
@@ -12,7 +12,7 @@ int main(int argc, char *argv[])
 	sepol_security_id_t ssid, tsid;
 	sepol_security_class_t tclass;
 	const char *permlist;
-	sepol_access_vector_t av;
+	sepol_access_vector_t av = 0;
 	struct sepol_av_decision avd;
 	unsigned int reason;
 	char *reason_buf;
@@ -58,6 +58,7 @@ int main(int argc, char *argv[])
 		char *tmp = NULL;
 		const char *perm;
 		const char *delim = strchr(permlist, ',');
+		sepol_access_vector_t perm_av;
 
 		if (delim) {
 			tmp = strndup(permlist, delim - permlist);
@@ -71,7 +72,7 @@ int main(int argc, char *argv[])
 
 		perm = tmp ? tmp : permlist;
 
-		if (sepol_string_to_av_perm(tclass, perm, &av) < 0) {
+		if (sepol_string_to_av_perm(tclass, perm, &perm_av) < 0) {
 			fprintf(stderr,
 				"Invalid permission %s for security class %s:  %s\n",
 				perm, argv[4], strerror(errno));
@@ -79,6 +80,8 @@ int main(int argc, char *argv[])
 			return 1;
 		}
 
+		av |= perm_av;
+
 		free(tmp);
 
 		permlist = strchr(permlist, ',');
-- 
2.55.0

