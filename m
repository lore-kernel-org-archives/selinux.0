Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2662DAFA6
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899332; cv=none; b=nknxt6nH1E/jBqDO+RMwE4qASi40TJGywRq1Fub1xpLlftfCGu9sRhSJLZONm1NSx5HKhGRg9Mw50uhLoJJRc0QkoUde9ekI0wcq5cONFcbn2Z05SExOjuOAcx+jKGGdvi5MdnZvk+mFivLvwpiVteE8fojnDqerRozPMcHqT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899332; c=relaxed/simple;
	bh=UxDQ4EwtaIQAXcRJxuCsVi45rUHeEfmGcNMCOzGiZis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLI126SFpQNcC2l10wUXnPL1RX/xc3TuQ/QxNzquBEkDuu+4MPFhDMXE+caRyI3aUb/b7qgY3Ev7SPZq7eHAGJWPsej/l06JvHFKGF+3KrHLL3soYxxjXcD8lDMe0jVkIVh8PxUwH73Vl7/Gz8Qw2WjzW+CQ4hHfbMTDMrRjWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8mg5JW3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8mg5JW3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b783ea5014so74971f8f.0
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753899329; x=1754504129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnhvYbUaRC6RjumIl5ndHHZCiAjnqbMhHA4PVy5+flo=;
        b=J8mg5JW3k34ui04QZQxkrTyLIa5NioYP3lNXLoCP4RICju/bU/vb38AtMGcrIzM2uE
         js/sFXf7yc4CCRRaMhM2vxNWi9wo5ELSyL6kGLsWRj+LVO7h/eAoUWE9jK0DKIro7yzk
         r3Dw5rAhQrFqswkKNNhJVfc5L4/8y30tbwwpVbI0v4h0EQGoSYjN/Mn8L9MMkwUn3HZ1
         UJtnzLcd4NmD29gGSI8h/9t5XmbKoTdZHIkEoiOflWqnolgHG8CV8BEeJ1/2Uy+KIoxM
         tcBn3kF+EBMbHxM8hjJlN+7AclzZ7EakUHSQ5V7C/eqG5xMgqeoE0mL7fIcb5rt2cvhV
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753899329; x=1754504129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnhvYbUaRC6RjumIl5ndHHZCiAjnqbMhHA4PVy5+flo=;
        b=YX+bdrMkv6Au6W+xPJrca+jKIRyBiJWmlFW+NiKzN2RctzlsmRp3oa0NQ7h74775fV
         VKOl4+7F8c+pOSMJWjKsMJ85Cj0O1c04mMXJCf3kJluOrGHGQ/T1AR029no/+LAmXN4B
         w+6og6wb+b58uSTbX7GR76av+VLahTwV+DgLkLfGWqIiyhHDcSCHTDs/r3dP0f3I81pT
         VaDs/69dSpkaAgDmQ2gpkKwwTUADEAUc3rkLpZ1098g+FkRPLXncyi+cikFktdQDZFtQ
         WEpI5Qpb20yYVZToEL04ZRCD7BaBAEVomNRIfC11rwkuHZ6TmUZOVQ1eHoeS207A1Ou/
         +Ieg==
X-Gm-Message-State: AOJu0Yzs9UKtbXr57uFBdnZJIVkc6AM9mG/2tdzCD4HfUQy6g0P1j6UJ
	e2gIs51wIfrszlP3XR9C7/d1E1lcd+eqfDOvdG5+AXu8pzQMFgu/kkeTt4Rlzw==
X-Gm-Gg: ASbGncuHTtePSKOZd9YUM8zl5Sdrow8NcSQxcGHwRqADreImE2U2ZK8j66duoc35NHk
	iOQW9LRntguVhJrCFCosycGdfBU78rHXLfScXPILA8ZihW6zo2Z3LmklVZnIG99fKhEAWbBLNcF
	Kzd6mlMBT8EYeFyR6mHXylFXXyIkr8r7RG33e8AtiEowIdR3qFFSZhES+rPgdMhz/a3213da/vz
	dvJuZrOS0wrfpR6PgL80+R+SvilK1Mv/NDfweyHoB6DGlxoa/Rh0QJAFdLYvekPGhn8uiZA4auM
	YVwMFoGGIgDvlRWssSe3eyWNy8+Q5BKaBcMj2IfJx/KMVdXzUEsSmAFUwHzxy/oIxFKl4Zqv98E
	QoFR05tbXwBhJ
X-Google-Smtp-Source: AGHT+IG2M7JkW7MqYj2apGi7lQU3K/PYMvHc16NnK7WJj1NVLnEXDayatGyqjvs4mLEj6ATFHqz3tA==
X-Received: by 2002:a05:6000:2485:b0:3b7:895c:1562 with SMTP id ffacd0b85a97d-3b794fc1a60mr3557939f8f.11.1753899328559;
        Wed, 30 Jul 2025 11:15:28 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7819039efsm14853065f8f.11.2025.07.30.11.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:15:28 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libsemanage: get_home_dirs: cleanup parsing of values from conf files
Date: Wed, 30 Jul 2025 19:15:04 +0100
Message-ID: <20250730181503.991208-2-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atoi (3) is... bugprone.  It's virtually impossible to differentiate an
invalid value (e.g. the string "foo") from a valid value such as "0" as
0 is returned on error!  From the manual page:

>       except that atoi() does not detect errors.
> RETURN VALUE
>       The converted value or 0 on error.

In the case of get_home_dirs, atoi is downright wrong.  We are parsing
UID_MIN, UID_MAX, and LU_UIDNUMBER, which all have a numerical value,
without any validation that what we are parsing is actually a number.
This is especially problematic as that means that in the case of an
invalid value (e.g. UID_MIN=foo), UID_MIN is incorrectly parsed as 0.

Instead, use strtoul (3) to parse these values.  If parsing fails, such
as in the case where UID_MIN=foo, warn that parsing failed, and use the
default values for each key as specified by the manual page.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/genhomedircon.c | 41 ++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 8782e2cb..a7b44d8d 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -354,24 +354,53 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 
 	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
 	if (path && *path) {
-		temp = atoi(path);
-		minuid = temp;
-		minuid_set = 1;
+		char *endptr;
+		const unsigned long val = strtoul(path, &endptr, 0);
+		if (endptr != path && *endptr == '\0') {
+			minuid = (uid_t)val;
+			minuid_set = 1;
+		} else {
+			/* we were provided an invalid value, use defaults.  */
+			WARN(s->h_semanage,
+			     "Conversion failed for key UID_MIN, is its value a number?"
+			     "  Falling back to default value of `1000`.");
+			minuid = 1000;
+			minuid_set = 1;
+		}
 	}
 	free(path);
 	path = NULL;
 
 	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
 	if (path && *path) {
-		temp = atoi(path);
-		maxuid = temp;
+		char *endptr;
+		const unsigned long val = strtoul(path, &endptr, 0);
+		if (endptr != path && *endptr == '\0') {
+			maxuid = (uid_t)val;
+		} else {
+			/* we were provided an invalid value, use defaults.  */
+			WARN(s->h_semanage,
+			     "Conversion failed for key UID_MAX, is its value a number?"
+			     "  Falling back to default value of `6000`.");
+			maxuid = 60000;
+		}
 	}
 	free(path);
 	path = NULL;
 
 	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
 	if (path && *path) {
-		temp = atoi(path);
+		char *endptr;
+		const unsigned long val = strtoul(path, &endptr, 0);
+		if (endptr != path && *endptr == '\0') {
+			temp = (uid_t)val;
+		} else {
+			/* we were provided an invalid value, use defaults.  */
+			WARN(s->h_semanage,
+			     "Conversion failed for key LU_UIDNUMBER, is its value a number?"
+			     "  Falling back to default value of `500`.");
+			temp = 500;
+		}
 		if (!minuid_set || temp < minuid) {
 			minuid = temp;
 			minuid_set = 1;
-- 
2.50.1

