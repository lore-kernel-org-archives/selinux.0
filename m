Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2755C1B0
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093394; cv=none; b=KgwF/URcn9h/XotgLecCA6tcDf5FXLIavWh30VmUNgsUlXdmyI2btUKGNNgMDYC/UvGOj6Q4DPJIx12Y+le/zxURJmJu1BgamJP4qWOq5fjAtm1N2TskE2THtFU0givxLopUnnDodpMTn7Tb5fuSZut330vEfP59wXZVEFKNKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093394; c=relaxed/simple;
	bh=Wp2PZLyZQGojYT4m8q4HCZdhRWNDJpbEY/FOn3vzRGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCpoCErO4nwHYFY+jjXJBRBHchQnN7UQGXJ1KURffgDfvODQyMpWkEbbgP2dPQ8FJ6ohqsqv7SIzmUegIDgcllDJaBqYwBYi5VKMsKEIvCpW+QxRqqWu3gs9oik1dOWs1BiTJsEMQHEOTWjJ7pEHJ4h8QEeMTqDXZqboAGSQDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/iiJkU/; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/iiJkU/"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910a0cefaso6225685a.2
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093392; x=1790698192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pp52nelnor8g3amn0cOkjJDwsNKLEjOVoyaQIbCsaA8=;
        b=O/iiJkU/T4MhV6cvo0mI1I/fTi7/3r6aWbaeK59yuoYRGaESLtmhklGewDuaJoa5G6
         aue0ODCM5Taj5/X8dYewDWgHcmJPpT2lnUxo30VSyOeTEhKN/j98G983OXh7ZlssgoKn
         duS5rfm4dQpdrHixqHGRDaX9t5kRTzoIjl4e7k3kR7eneqpAW/DWUa/AKuPO4h52FPRg
         OZitN6dX6DJW23TzPpp1JGWPkVi1Oif5d53XwC6lj5Mdp0keatDSNqWVqRANv6jTcJ4U
         jNoSAMTA1HXuv/sUCSzFtr2U0WPBk1AJAR2lkXbs80da4QQAh//plkwTmAk+iP84ylFx
         hxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093392; x=1790698192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pp52nelnor8g3amn0cOkjJDwsNKLEjOVoyaQIbCsaA8=;
        b=yu/WL2I3xj4rb/iBH92iix1QvGbeyOSe/JC4JXLtKto6Eyn6XKWj8ZLPs/pMyUDBxF
         JdGP3Z6Gu38bErkYb9N7t06ppo5WtWKFRvr/KSUACiEffHe8dahbgmzhh3cuakN0o8hu
         /29ZC93eHVoUf9aD02HBFBrcH5RUp37v3yGQC6c+9w9RzJMNbL/DmGBBPtxFEpblB7ao
         lCshE33cqwEOavkhzveaVPqv7o5HTVYwS2Gqk8mOcWsx06OJwalv+e0AHA1BRLs4VrD8
         ToIOd7dB4j0TiP7NKdPM1iR0JjKAE9zS2W2JvN9acPktufYgsaSedhk4fD8aeQdzWigY
         ELSw==
X-Gm-Message-State: AFuF++lOlhqCdMUweUVDTdtxfNQZIZRAQWpJcSqHpl6qloms4EjNBLsi
	mJ/xPRk6PfJV4UKkMofrTG03hfret2m9wxbdDCk0SHANwIspc/DbhHuim4cG8Q==
X-Gm-Gg: AYBFou1lma+P4XZl+k0IYs7L5X597BH6BB7O98jtxTd2/e9cfxNb9RoEByePGISuP4d
	IXAMgCgm/4ydFeFZYDGJAZjsD7i5T6TbxMK7PUysx0Ias/bkCtGKQsuxzsmVyJovT9yWGuwXlLo
	DCCzMubwnLzZiJZSCo6q04FR2YzAg6WM/+HV80TAmxDd1G+VsUeZt53OZm58QIZ1xJxKXb9gebe
	g6jutSrCz3yh+Oc3ubAsqqc5hw8nrQqYx0fOBxNs3WVokKDHxLljymf+sKvPJJyJS5pToaiinUC
	z6VaHFvWC5t41EI+0319IlAZEDTYdswM+zgGChsCqxxFhD/DD7s4WpQaUoFwZfQHVjkYjDvSmaw
	W7qcLCSc9huKC1GR/w4kuEjdM8oiWlBYxCbDaBKV3UrUl7HbE4aV1cYgPE0t65oPOSuCQEdQuS0
	4msKCvykcMldgVgDGm+QkhUTElzRy7TraZa7U7B/iJ7GSNajQWrjmRAnsCw96pxRLp8M3T37XLk
	rMugK1vRKJG2QYn5D5AoTMgKP3fjjQl2lmgl9S6wHy4Ff9BT1MMUHNoI2lA9srYzXQoK1tsOeY=
X-Received: by 2002:a05:620a:4101:b0:939:8ecf:6025 with SMTP id af79cd13be357-93c15da261cmr620584585a.20.1790093392166;
        Tue, 22 Sep 2026 09:09:52 -0700 (PDT)
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
Subject: [PATCH v2 3/3] policycoreutils/run_init: search fallback configuration roots for initrc_context
Date: Tue, 22 Sep 2026 12:09:00 -0400
Message-ID: <20260922160859.47233-4-stephen.smalley.work@gmail.com>
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

Use the newly exported selinux_policy_open() so a stateless install
that ships the contexts tree under /usr/lib/selinux is found the same
way libselinux itself finds default_contexts and friends.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/run_init/run_init.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 89921b23..6c427dc5 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -302,12 +302,20 @@ static int get_init_context(char **context)
 {
 	FILE *fp;
 	char buf[255], *bufp;
-	int buf_len;
+	int buf_len, fd;
 	char context_file[PATH_MAX];
+
 	snprintf(context_file, sizeof(context_file) - 1, "%s/%s",
 		 selinux_contexts_path(), CONTEXT_FILE);
-	fp = fopen(context_file, "r");
+	fd = selinux_policy_open(context_file, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, _("Could not open file %s\n"), context_file);
+		return -1;
+	}
+
+	fp = fdopen(fd, "r");
 	if (!fp) {
+		close(fd);
 		fprintf(stderr, _("Could not open file %s\n"), context_file);
 		return -1;
 	}
-- 
2.55.0

