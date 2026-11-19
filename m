Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093751;
	b=FOHjJMXZtbl8GaHkW8QPECl0IjgRWRH9VsLq8yRSA4PVQbtXz0OIYD7ouA9l4nk+KSpZ
	 BV7GdbdGw9GlinfeDrgATRSXbZIunHHqBpFv9+X653sCUqCSc/v8OhqR+WPCvhsyix6uY
	 fS25BVRlvGg1g2CDC2a/jMXP0SFXjuZT6OlMi1rM2mUsKMu7fqaG+1/aSJSdmdKM5iHJN
	 kUEppa4ZhdCNKLwJ7bTn42eJxwp27bdN+Ts+Pv8gFdZk/PX3RWLzK6yD0LHAUScucVxPc
	 skLur2Z9vZwraTdKk0n9zZu8eo4RbkrDn34HI5Ea768PQ/d24EAxM7l/x1SsxpfhZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MJLVRMeQBU4kDeFk1q4zrMc/hbBiWG2Gsse+qRAO4Hg=;
	b=bdChPLvgCUcyDmi3tj/8GOpXE8IKht/WdbJQceongraZXCvSAMtwmMghz6NZweM9l6Ri
	 FOG6D/iQi8OATSVVaICxJzB6qYrnDnniQ0ECh0lJy2ibXnZkT82kuZf6ZbBmG2bAgAUif
	 IONkt0lZA4GcdNxvP9cQ3jbApYDsfepegkMZSVPEA6wuEZa6rj8NAJxr+D8i5qUuO1wfT
	 y0NqNlY764TxZ16OgeK809U1XOzcf5BL8Jf5wDH2Aj+DUCdmFpS4wIxAGt9BQaK3HHXkN
	 SynnuYEpzLhuUyV45NyVJzR1iMvVWSGwYpL3i3IV0KK0aBl04no+QW1T4kcGBGH4Zzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wOsAfh2v;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765C606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3765C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wOsAfh2v
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-921318b2eb8so1394786d6.1
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093750; x=1795698550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJLVRMeQBU4kDeFk1q4zrMc/hbBiWG2Gsse+qRAO4Hg=;
        b=wOsAfh2v25uvifE+SF0+Jv+peO2o0ZVTHfCRSzpodBrzgJo4yy75zouTXx+L40nXT1
         yRF7XcdpcnbIjKeg8w6KuMP1MqYfkIMU7Vy3HohzzHP33Z7wTXawaOGLnTmOlUe1WV+X
         D6uAyiEUcVeI/xwgmK31bYja/bzIy3t5ytcjtm6o54cEbzNbP0N+4PB8BCzHUpjIEy9V
         5WPv3kDp+8AUScbVk0FaCQ8KwEXQWVPPdnIMSSxeBree4BO26SOl9TDy+YZoiTnG31WB
         o9PSJV3jyxW2odueZUlj41feIkvhyWKVbWh4rulA5smqBtljW5ErYZUQH79O5KPCyCL4
         3rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093750; x=1795698550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJLVRMeQBU4kDeFk1q4zrMc/hbBiWG2Gsse+qRAO4Hg=;
        b=cyXmoDfotyXa6bjXmD3j/mLUAqDiL3F4sD6gInIq3nqy8KzMUbBz69mu2t07tmjl/B
         7pIIt78YWVurt0xkb09yy6HckT7tjvJHooe1SQ0YVjURPrNBcla/JK1uX+8g2revWw8J
         4SU3vB9w1TV4mBD4seOf/nn78hfhe6ItI1SVj/AakJAkYTs5oMdsSY4hDWsdRyxOTZx1
         BRjt75ec47vcBgsr+yC0W7rj1ZPEwqvqdfXDm0EpT8+j6fWBQ8OKjygHyv90Of6j+8mR
         RdXuskpiimEMzo3wUR3yMsoiLM52aIbvuZ/10cHMGi+2KpRzIeBQNo3HiQD2TgwmI8iU
         CbQg==
X-Gm-Message-State: APuU4Z+DMp7D48SwGqBE42TCmeGHPNe6imVdT7FKqo7lVdctmVZ8HfD+
	tymT8ktgcvWMi1MdHm20nSHchSqTXJ9KxgNgKqWlsfvG85b/vSAY6YYyObj3cA==
X-Gm-Gg: AZFdTZdTD5AnMt/QX2QNonfBNcF3JT3KlXDwp1LWqei8zAagsIH0P/wezOOhJDnmhUR
	S6isIoxFOI05ty7/Z5d/ihmLe/CcnBtsJBnUsMrnddmnQLFFrQIpp8InSHgKpkmqgAVWg6YWDqi
	wGTLuIA57u7tNuzb2Wu2jPjqhdPPz+W4AAnmOMN5bbDoSVa8Dexn6HuQ5w74EQYAa+4wito/eTj
	XppaXktyuWlyq6thGWnDUlqznyqrGOmdgBXsRGbi0d9TKaGMW9rv6o4laB0ckdH4RwqCZ4Ap6IU
	VmwRAs1CGp+ONJw4+QIlnIRrpxw/+Myd21J17NYip1oGNJ7YvJ5sXd6lVTwq32v5wmERoeIX617
	bbKIyqsZMVBVwW8f86SW6hMmZNI1o+4PPp6B0ehfLhhtOm0NCCuYGyVaxEM7sT7cAwWfHVmY3AF
	aqpe2+6b1BLFER5+JzAchJChqVilzSAiqVaOMsI94xvhHGjWr450cuRnOWMxsOUTXHt6y70ql3C
	9TVYzXn8Ga4PcH9D1Q3VI3RrBXmJS4xdfT0Z0ZavZZe2ZPWtuHrO8k6AO6ZaLWQTL0rL9EqXtSZ
	tqlH4ARAvQZeyYOKwJhKvYU7CCkf+hsWTJ/GhxNBhGMIMKqC7QKH7E3VU1RMtYc6IhCyla2gh6+
	A9GBNLjBCiVkLp90O/R0jfWx7I/DZxXSw6Psx+jjem2nZWCBy/o9VLR79q/wdrAYjccsUsASo+T
	YIopK4jXMHsa+twNQ4icmaA9lT0h2W1Zkv
X-Received: by 2002:a05:6214:1c49:b0:91f:19ef:9ac3 with SMTP id 6a1803df08f44-92114e52ad6mr88960616d6.43.1795093750061;
        Thu, 19 Nov 2026 05:09:10 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114a00ad2sm48981206d6.3.2026.11.19.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:09:09 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libsemanage: prevent file-context injection via crafted NSS strings
Date: Thu, 19 Nov 2026 13:08:52 +0000
Message-ID: <20261119130853.858-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genhomedircon substitutes NSS-supplied strings verbatim into
file_contexts.homedirs: pw_dir for the HOME_ROOT and HOME_DIR
templates, and on the %group login mapping path gr_mem[i] / pw_name
for the "# Home Context for user %s" comment and the USER /
%{USERNAME} templates. check_line() only validates that the last
whitespace-separated token is a valid context, so a crafted home
directory or username can inject file-context lines that will be used
by subsequent restorecon/setfiles invocations and other labeling
operations. In directory-backed deployments (LDAP/AD/FreeIPA) the
passwd/group source is not root-equivalent, and every libsemanage
commit regenerates this file if semanage.conf does not contain
usepasswd=False.

Reject values containing whitespace or control characters at both
pw_dir entry points and for the user name in add_user(), and while
here also apply the existing absolute-path check to the HOME_ROOT
enumeration. Regex metacharacters still over-match ("john.smith"
matches "johnXsmith") but escaping those is left as follow-on work
since it changes existing behavior.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/genhomedircon.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index b0482f0e..2ef923ce 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -43,6 +43,7 @@
 #include <assert.h>
 #include <ctype.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -313,6 +314,15 @@ out:
 	return rc;
 }
 
+static bool is_fc_safe(const char *str)
+{
+	for (const unsigned char *p = (const unsigned char *)str; *p; p++) {
+		if (isspace(*p) || iscntrl(*p))
+			return false;
+	}
+	return true;
+}
+
 static int prefix_is_homedir_role(const semanage_user_t *user,
 				  const char *prefix)
 {
@@ -576,6 +586,12 @@ static int get_home_dirs(genhomedircon_settings_t *s, semanage_list_t **out)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
 			continue;
+		if (pwbuf->pw_dir[0] != '/' || !is_fc_safe(pwbuf->pw_dir)) {
+			WARN(s->h_semanage,
+			     "user %s has an invalid home directory, ignoring",
+			     pwbuf->pw_name);
+			continue;
+		}
 		int len = strlen(pwbuf->pw_dir) - 1;
 		for (; len > 0 && pwbuf->pw_dir[len] == '/'; len--) {
 			pwbuf->pw_dir[len] = '\0';
@@ -1201,6 +1217,17 @@ static int add_user(genhomedircon_settings_t *s,
 		}
 	}
 
+	if (!is_fc_safe(name)) {
+		/*
+		 * On the %group path this is gr_mem[i] or pw_name from NSS
+		 * and reaches a comment line and the USER / %{USERNAME}
+		 * substitutions unquoted; skip rather than let it inject
+		 * file-context lines.
+		 */
+		WARN(s->h_semanage, "invalid user name \"%s\", ignoring", name);
+		return STATUS_SUCCESS;
+	}
+
 	int retval = STATUS_ERR;
 
 	char *rbuf = NULL;
@@ -1263,10 +1290,12 @@ retry:
 		pwent->pw_dir[len] = '\0';
 	}
 
-	if (pwent->pw_dir[0] != '/') {
+	if (pwent->pw_dir[0] != '/' || !is_fc_safe(pwent->pw_dir)) {
 		/* an empty (or otherwise relative) home directory would
 		 * turn the HOME_DIR template into a regex that matches
-		 * everything, e.g. "/.+", so refuse to use it */
+		 * everything, e.g. "/.+", and whitespace or control
+		 * characters would let the passwd entry inject additional
+		 * file-context lines, so refuse to use it */
 		WARN(s->h_semanage,
 		     "user %s has an invalid home directory \"%s\", ignoring",
 		     name, pwent->pw_dir);
-- 
2.47.3

