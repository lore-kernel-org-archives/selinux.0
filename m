Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073D55409A
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090259; cv=none; b=fokB54HgXRHHTWMU8+XToP6MYHQvvEiH8lBINu+4Oqg+LPX1loTCuCduHoKV7FaPzHt5AUn85epQxjGZAPWxguKk2BmmmsW/8nlw9JTi/KlV+djv3H68xVskaFuF9e2YVsvBYe0+tLOaYjifFDXh8nBES33J1ivBakw4qVQWhoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090259; c=relaxed/simple;
	bh=l8aQe+kGygYhnAczbytOkiUFcVlYxCca95fZ6Ado+1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fvb/xaKY2S+cDas8/Pgnj9zqWzB0P+Iia1c0OVytKixsM6OjbVLR51WwWBuQ1iLDQe8RrYZpSWgLjwZgKy80HC1kDEycWSOFq/yXNn2SOYx8OAtcHM6pt/GgW8/k6xr9qk6M8fR1DSLdzRdVJl+yBd1OBSwFs7zIINUpGRrPoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntBBr5hp; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntBBr5hp"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76c9deeso291311cf.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790090256; x=1790695056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOkwofbl+C8qBMAfl+svk98Ph532DHy/cBfhWxSEa7Y=;
        b=ntBBr5hp2dUkrBXY21T3wbEyZXJ46XeG0p2BXne+I9ENnTOJem+FVLKCx+WS0puoBr
         PptShyvS1sWgSr0o90s1KL+P14aNYvr8PGqwz/avY/qmYTpKOceGua4aELcjUdboYVTH
         VfV7bmnliKhCoqUjDaWDxWBRlmC1SIMJ06PD6OTFR6DQpFL/MidB8fSCsOrMefsEiEFi
         DB+Dcf0p9mJTwLpyKgrMeLbM+kWMQvrxV29yd/CE1T7480DqnrCpGhI/fh+XkxkBtYPR
         iX69OxEFTuPCkj3e6k7jnYvqbW4x6MVBVyWGodEj9FLo8IWvwtMNX1ZMkwKYsWFGCh86
         Zgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090256; x=1790695056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOkwofbl+C8qBMAfl+svk98Ph532DHy/cBfhWxSEa7Y=;
        b=lOCt8lv9wQx3YvcB7kAzeWRM0BuT3NLh6SFjUW1LCa2LKrujAqVqcWJOgQGiNpRFKl
         6DUoTEevXZzIjn6pdRoUgemu7IhZyoW2R9Uj5vFXK7E9R+ayF0Z8xWwoS0HQcffiZOUG
         O28ZEzsYDvaCW96Bx9vknx0eiWCSBoUuzud3DkPhmmbq8JhKCp4jWGOZagJKabjU0HYS
         +crA1uparWe7Q1rD7UN+St5UdiJObIbkk7Og5/pDEeFRhl+5nNqsdZ59cUWAU2v7OAI2
         +ERbGfjYSCeSY8ezYRSpwDqhJyxllsjhtvzU6Doum6jTzqNfxSKZsUf7pbN84Ve3hYLA
         lWGA==
X-Gm-Message-State: AFuF++k8N/NGXFh5fT482bCOKnRtLQocv0e/HoYk0kJD/4vteiVXtPSG
	IieuSluUx52P2rvOvlO8iwGBISeF3MOxjEoaS3ZHBPvMNZbW1yL2NccvMnn/PA==
X-Gm-Gg: AYBFou12k0Fj3z6PCLQHaX93RJcx1hBZWLTUyzfWrUHhFS0/OQclvB0QWbXz0F4bCB/
	XinQIc2a0NhGtDKyPGylY0ge0mHYMLwLYJh6u8W3/Qb0fNRBSBkSC3bHa2sOvKkJZwnpjcNM1KR
	aD0uP28PmgSOoKbSGneODBGJjAXfeFU+eb/rpgr22MH0TzU/bKz5ZLgQ460NJkWRLSLEkKaeNNI
	82iepRxjH3vmovXu0Czvzna4NiuOsgKqfvUqYDdjCtdgUkJnSu3HW7kIJgC4AqORP7IVSAuiIX7
	YQXzVnrCUnqx60G2yrvIsWd9m7a412VysF5O+s/e8hGbgyTSP6iuDD2fa6EUrUEJ2Nt0SidQw8e
	pYZRFXWNLPliJrbTS0WG7IGK+Ge0PCHEsxwXnaRxR3eMjWgs0sZcanM1pzomhCjJpu5yTIE0N+D
	BEIoE3pPCyOWUbZTE/9CibGMfF5EDTSPU6YdkNQlW0rUecQgj5teWnLRz7eQgJNxAfqINA4oA4p
	FPI4ZiW6gyM1lAdgvDgfoBGoEIUOhaD3nWcKz4FoYpjmbQ8cPgfpVAUrt1fg4liy/MbnMIBs8s=
X-Received: by 2002:a05:620a:4045:b0:93b:d79f:d951 with SMTP id af79cd13be357-93c15f11d3fmr584394685a.70.1790090256529;
        Tue, 22 Sep 2026 08:17:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d22e33esm167955885a.39.2026.09.22.08.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:17:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] restorecond: search fallback configuration roots for the watch lists
Date: Tue, 22 Sep 2026 11:17:18 -0400
Message-ID: <20260922151720.46824-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Search the fallback configuration roots for the restorecond.conf and
restorecond_user.conf configuration files. Resolve both at startup so
the resolved path is used for both the initial read and the inotify
watch. A path given with -f is used as-is. If the primary location is
later created, restarting the daemon picks it up, matching the
resolve-once behavior of the other stateless consumers.

These files live directly under /etc/selinux rather than under the
active policy root, so the libselinux selinux_policy_open() search
does not apply and a local list is used, mirroring
semanage_conf_path() in libsemanage. The list can be overridden at
build time via RESTORECOND_CONFDIRS.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/restorecond.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 6548634d..495bf197 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -65,8 +65,32 @@
 const char *homedir;
 static int master_fd = -1;
 
-static const char *server_watch_file = "/etc/selinux/restorecond.conf";
-static const char *user_watch_file = "/etc/selinux/restorecond_user.conf";
+#ifndef RESTORECOND_CONFDIRS
+#define RESTORECOND_CONFDIRS "/etc/selinux/", "/usr/lib/selinux/"
+#endif
+
+static const char *resolve_watch_file(const char *name, char *out, size_t len)
+{
+	static const char *dirs[] = { RESTORECOND_CONFDIRS, NULL };
+	unsigned int i;
+
+	for (i = 0; dirs[i]; i++) {
+		snprintf(out, len, "%s%s", dirs[i], name);
+		if (access(out, R_OK) == 0)
+			return out;
+	}
+	/*
+	 * Nothing found: return the primary path so the eventual open()
+	 * error names the location an administrator would create.
+	 */
+	snprintf(out, len, "%s%s", dirs[0], name);
+	return out;
+}
+
+static char server_watch_path[PATH_MAX];
+static char user_watch_path[PATH_MAX];
+static const char *server_watch_file;
+static const char *user_watch_file;
 static const char *watch_file;
 struct restore_opts r_opts;
 
@@ -152,6 +176,13 @@ int main(int argc, char **argv)
 	if (is_selinux_enabled() != 1)
 		return 0;
 
+	server_watch_file = resolve_watch_file("restorecond.conf",
+					       server_watch_path,
+					       sizeof(server_watch_path));
+
+	user_watch_file = resolve_watch_file("restorecond_user.conf",
+					     user_watch_path,
+					     sizeof(user_watch_path));
 	watch_file = server_watch_file;
 
 	/* Set all options to zero/NULL except for ignore_noent, digest, and skip_multilink. */
-- 
2.55.0

