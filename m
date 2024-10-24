Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA881FF7D1
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794270; cv=none; b=asvkiYSb+cUppLNM53XgUSzqN/j7tX9NR3MDVhmaHno/970NZDllsR+ARo0j+/Zv8QoggHH0aYD7bVOK9r96uOp32sk4D7+mImltv8EXvGHV5SC+tK05WsDa2AqgPRVb9VgQqvtXz0a4YghbjutzHRktI/kF//DWDcD4UJwmJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794270; c=relaxed/simple;
	bh=vIDGqfMAAfj1VQn2Ig3cIrxvNnivxIf/xxBwfcDd8NQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUZPQBpaj5Fnae5np9e7hPccT9b05btj5iXQGhMOJFXKZ4oqphbN7rsz4MeuthD54uB2tHeBQBrEU/AWh5VBYv4D32oKBniM8USAOL3SW9V87hyuD8XXpHUShbSQ9kP98j3nx8ti7bAR8lWZKRLKcEfHr76Q1MgBU8nKI2azoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SvwP8sin; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SvwP8sin"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27ce4f37afeso899713fac.0
        for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729794266; x=1730399066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErjSAAO0nliopgGm/OgPwfgSrxeukRY7S9V2/lFbhvY=;
        b=SvwP8sinLDMcdzG6yH0RKFKUT5hjRa7D2tfRuXCHDEw+hzr7SJ0KP3ohtOfsYZnPAv
         tZrate5dw/HKREgGNbrddlNcq+kVzsuTTrk88QVuoMT4s1SCZ18lJXMzNWZsHPXmj+om
         +xkTl7UOG3+OAFPC5O1tJ15CnUENPFj8odjrRdh1TIqju9cSBcC3cACVaRlhzbemnEiB
         U395p9Mfi6jWM9wLLWcChqiaN6VX/WxSDG362DAJYYi1w9WNIwjgJ07vHq20fTBuqK9E
         QxkZVBoh/HncDnbMHmupr7l6PEsIVpem19GkUVuXab1HcCU2jX0FcpUB7Imu9tLGwzUd
         3Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794266; x=1730399066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErjSAAO0nliopgGm/OgPwfgSrxeukRY7S9V2/lFbhvY=;
        b=EpjQcluxV3bqvLYB4/SaKKC8lhiTXUsjPL958i36epdF8iNGFkjEQvHo+vS72eUYcB
         lWbwgqWY4fCzmAvGZCV8PwlShZ+16IW+cRvS4zk1qWdgpLhbDr6F5U3T9qo9B1XbcvWc
         D7W7IUloK4t4aazGRc57FBMDt+kJWPJzUuGtINuFNbsH3wnA9LGST48Vu3+mBtaW+Yvd
         FjsGg1NDNCPBvVI1IEKEeU0gdJOV9U8zw9akTawdarA+L1lbOXQrq679joar6/K6CyLo
         FoiaEQ7trUYFGb8DfWJI+eDI/gQ3jyNv5h8dz409JgNLKnVLOCKlMFms6omcdncnKECb
         21eA==
X-Gm-Message-State: AOJu0YxvJBtB8U27Vduadn9jIQsL6y6Vz+aKn2SP6wSBPzB6FKLB757Q
	0f4T6PVGnIpMnxSBhoKPw3nrzCXMrujy+oF/UQfzt458xzqmPTdeTlIZMi7yqRysvKm2+yuWRMs
	=
X-Google-Smtp-Source: AGHT+IEvA8o7FWqKrb9UpDU8f7Oo6+2y6qWunB5goxSfT8at5q0wOBqbAayARkqTDRFQsl9wNJDQGQ==
X-Received: by 2002:a05:6870:819d:b0:261:1f7d:cf71 with SMTP id 586e51a60fabf-28ccb98558amr7523916fac.34.1729794266524;
        Thu, 24 Oct 2024 11:24:26 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659e69bbsm504025985a.50.2024.10.24.11.24.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:24:26 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/3] check-syntax: ignore "bad" astyle versions
Date: Thu, 24 Oct 2024 14:24:23 -0400
Message-ID: <20241024182424.138616-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024182424.138616-1-paul@paul-moore.com>
References: <20241024182424.138616-1-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a list of known bad versions of astyle and ignore them.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tools/check-syntax | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 2775eb46c6c4..c55c51420142 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -54,17 +54,26 @@ EOF
 #     1    Source file
 #
 function tool_c_style() {
-	astyle --options=none --lineend=linux --mode=c \
-		--style=linux \
-		--indent=force-tab=8 \
-		--indent-col1-comments \
-		--min-conditional-indent=0 \
-		--max-continuation-indent=80 \
-		--pad-oper \
-		--align-pointer=name \
-		--align-reference=name \
-		--max-code-length=80 \
-		--break-after-logical < "$1"
+	# filter on astyle version
+	case "$(astyle -V)" in
+	"Artistic Style Version 3.6.3")
+		# continuation lines indented vs aligned
+		cat "$1"
+		;;
+	*)
+		astyle --options=none --lineend=linux --mode=c \
+			--style=linux \
+			--indent=force-tab=8 \
+			--indent-col1-comments \
+			--min-conditional-indent=0 \
+			--max-continuation-indent=80 \
+			--pad-oper \
+			--align-pointer=name \
+			--align-reference=name \
+			--max-code-length=80 \
+			--break-after-logical < "$1"
+		;;
+	esac
 }
 
 #
-- 
2.47.0

