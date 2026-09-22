Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89C541E70
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093394; cv=none; b=qtqGRhy4qIq02mt7IFIG+MEqiYtqiYD133Dv+tn2U9VC+y3oZ0dejyALjZZ4Exc+6LiTHM5cw4w/A5im6kIEvsOdoFXElCPq9Zsc7c9KrobZMfZZgI5aqrzH7TIGUJnaEIDh01anL+FLG0zlfC9tChpFr7YwKaGWyaXXGLghfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093394; c=relaxed/simple;
	bh=5Thrqr3d7LyhH5/DrRiIRUkCwHcWmCy//ZbE+TaZK9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9UabWJGhM7eKS1q3+ID2rG7djY9a+Kj0Vumg4c/3v6FqDhLKO1OWhiIoKWVxkFaGNLuqPQQFJezwRxkl5mR+EPhz9/BdKc6/ZdQMsHq4CWc/BYt0vdrueOLyLy8onTjrlW4EgD5S7Y6oHUA7sFk82t4otThIDhu5amSw7KGo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+jLdtSq; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+jLdtSq"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfc58ed04so2790085a.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093392; x=1790698192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmNUERpsJt6op1fpVDk0HWbR1IQoc2JnA50D1aIQtwY=;
        b=T+jLdtSqx2OytOdZQAlQRbGY/KbwnIwlOXiNjhXCdj4yZ+yf52QyF+HJz0GGUZ+H0P
         x15/LH9/LIwtbkCd0R2lR2ne3MiAANamjIu7OlTga97UM+oEHhesyyexsekPidJHPJ7H
         ACC+WrjNGiA5J40MBhvquOKU4SsrRCW3Ep2G8CHqR/Frv1+xJl921LupPbWAzmSiE4wQ
         2Owb/p/33od5w+QyTWWArdvn493hctQ1h3tz4vzpNA1fyxh3VviWcf5JOAaF71aRt74c
         uIwT67A1WJipikB+Ij7m4xzB73JwQKKuH3aWyN2BVDrsawCDBSsY1kTUMGuVAG63biaA
         9FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093392; x=1790698192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmNUERpsJt6op1fpVDk0HWbR1IQoc2JnA50D1aIQtwY=;
        b=jU5WgFV4tA6UT25BFKTsRgCkLoo9v0mjlnxgY6oTUw8GfurzSYKgTcFgo1yi/PjHv7
         M6aXvagys0km1mePed4b4qG5RZhNEN4od56EIwIBo8uuU18nz1IPTYbEGQGdpOWRB9SY
         FsLvLvF0Tb0oadKMfVeduObo9+kntNs2KCE4wBuOu/4ybvhBjpq0+qUZHOX3ljjcSYsQ
         SC/XzpRT5W9zYnjxpDa/q7+1Liu+dRRaKFD1iQASQvx//qxbLipdVEPSjUMPhkmA7wiA
         8woo11+IZnzOXbPB++4j/9tIcTM5XIVF9+qwf5rQJVmKu7oTRJ8XYsEn0FzSpM9RP8Eg
         Mgsw==
X-Gm-Message-State: AFuF++mofkpfNboEGWAROUE6eP/Gro5zTyhNo1g9iYjsR0Atwi+L29rs
	0kThm6n/OjfXBzfLscxrizzwixBQnLYLMb/X6SywCvg3P3mCwZEPMDT/CaniTg==
X-Gm-Gg: AYBFou1K3ApW80lqqyCLegV0M4Fo6nVg2tBSorWer6pQel4pPtcuqgPckGQPRm87BXe
	w8yDeF0x3Xk4NHPcT1PmbaB/pv+4XRJCeVK3m467ZKjjLfstka45p/8dbS45HoPo1xO63tQvsBP
	7uqpTj0a2cvVVPwq3box7fWNRoqOv4rFw3exlDKX3QQ0u1iuASWQxOOyGREzCheQAqdAXTygSfg
	UgXA0fzTrsr6X2EXeMZrm9KBbm3zaWB1h8lRuoNJfwt1A6pQR1JOS4IMNMpWYBEOJd1YH+6HhhI
	uOAKtqnA/Rw3xKZTTgI0/VTeSDAljRDgS52fM0wmfoLdHKJInxrvvOcUZ1b01vL0/uUzQTdeE4o
	UipVLPZjIWA1YraUYgsPJSkx8X7WatrSr534dhlMgZI+VQZYDFhjBgkFSzEj1nqetsrFWxZNiRI
	6RF7nwAbDyfeA2VNbPi17LpxLHi9LorLrNhA4GrUSr2kmDG9JzZHoUl8QDgK2cV7E97utWcKts1
	8UUsHnI7ndtKfzwrwX0AYuSkMx76Lsbbvl9h2/DnJJybfrAr0K94TU5shsNlcoTV6MP698jWoat
X-Received: by 2002:a05:620a:8014:b0:939:4baf:5b99 with SMTP id af79cd13be357-93c17e7d4bamr533829685a.18.1790093391675;
        Tue, 22 Sep 2026 09:09:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24753395sm9132885a.4.2026.09.22.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:09:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] mcstrans: search fallback configuration roots for setrans.conf and secolor.conf
Date: Tue, 22 Sep 2026 12:08:59 -0400
Message-ID: <20260922160859.47233-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922160859.47233-2-stephen.smalley.work@gmail.com>
References: <20260922160859.47233-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open setrans.conf and secolor.conf using the newly exported
selinux_policy_open() so the same fallback search that libselinux
internally uses applies here.

Include= targets in setrans.conf are user-supplied absolute paths and
are opened as written after glob() expansion; a vendor setrans.conf
that ships under /usr/lib/selinux should therefore reference its own
Include= fragments by their vendor-root path rather than /etc, since
the search is not applied to Include= arguments.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcscolor.c | 9 +++++++--
 mcstrans/src/mcstrans.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index e4a0db74..0b2dfef1 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -263,9 +263,14 @@ int init_colors(void)
 	if (getcon(&my_context) < 0)
 		return 1;
 
-	cfg = fopen(selinux_colors_path(), "r");
-	if (!cfg)
+	int fd = selinux_policy_open(selinux_colors_path(), O_RDONLY);
+	if (fd < 0)
 		return 1;
+	cfg = fdopen(fd, "r");
+	if (!cfg) {
+		close(fd);
+		return 1;
+	}
 
 	__fsetlocking(cfg, FSETLOCKING_BYCALLER);
 	while (getline(&buffer, &size, cfg) > 0) {
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 9704f5dc..20b074cd 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -921,9 +921,16 @@ int read_translations(const char *filename)
 		return -1;
 	}
 
-	FILE *cfg = fopen(filename, "r");
+	int fd = selinux_policy_open(filename, O_RDONLY);
+	if (fd < 0) {
+		syslog(LOG_ERR, "%s file open failed", filename);
+		return -1;
+	}
+
+	FILE *cfg = fdopen(fd, "r");
 	if (!cfg) {
 		syslog(LOG_ERR, "%s file open failed", filename);
+		close(fd);
 		return -1;
 	}
 
-- 
2.55.0

