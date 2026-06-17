Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A83AFB06
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726225; cv=none; b=YmizNhQiWwk44CH1s3+XPfzjDGAjpdFkUlzriMloNz3IfLVS2LOxhBNNpEArVEAXzhf6YiHq8L0lFro5KeCRCn366dDvErVGckSg6upDlwmtvH5qyNZDyRDPtjzAWfbfm8Z/xNKcp8lXEgADRhc6sSoUELC1xenR5njv9SpQ3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726225; c=relaxed/simple;
	bh=QVAgqfKLOX2/SnIEYvU7+mB7lr6y23H46omo/3/gg0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VL30zqP7m4Bl6J30zL1jzMlMySamg3dmQKz4LR93NF1PhfVH9yy3VCrIrp4dMZol9pobod3NGWRdscmPLtLkC391ArlYPacyzo+Gybg/qHI3BokISFmZHIeJ0pf+MbsGNl1KA7TwEqXpKqa6akwd/dL3d/QE//7Kypr7FWwSSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRoUeIAB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRoUeIAB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517b1f2c668so1796631cf.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726219; x=1782331019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyWhkgkf5ojcrSqJHPG7D+oOfBoBLyKx3p3LNrTvDsQ=;
        b=sRoUeIABwdyUDcI+s2zhuYUAJwiqWXFBmjcp7uCectgsPBS8NEd7UVP/XwRDcfp2Lu
         FbXxkd62B5bDnoqltbMSsUw8zfWs4RioKxvvxDHJxOk803msShFeJl6Ssj9pcN+pgtFV
         hKBW+88IPXHU2lcMQgH0b2SkCsxKatC88B4S4u04+Xv8BdJsmxvQeklibfLY8WLbLFFw
         Q8QmbAkn16tyGQA2EAem+7SgEu/SpEt9onuV+ks/4PmJ9T/edg/0ic9XIiJatxpkv86k
         S8KV94QNnimuG+iS/hZvQ+toxWKNMKHLQfhtsygR57jIPn0HOgzDYsKITeVnyPFVCbgi
         ADtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726219; x=1782331019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyWhkgkf5ojcrSqJHPG7D+oOfBoBLyKx3p3LNrTvDsQ=;
        b=ZcunQtJp6cOYlpSAsPR1qlmESwQ5nJke97FJzL6zFqF83J+gFJhkW+SS4delgdjwug
         0yj9dgbB9HTJrUPi/D9X5QoA92BT80vy8v04cTf23OnjK1WBM4FaAcuFe0vqTiQlsEVn
         4z84743VIPgj+DGLU7lcybNms4obAh8x8zyfFfYbZzBoZrNbfRL1CkNkz1laqx+ihkMm
         LjlcT3xx+N8M1e+0iWsUQXot7So4B9ItUHYqVlInJAVuBTYXM1m68/Ab9IY+hjb0yF1O
         krKdbJqOVXaghMs62Z8VfiQBV2vBFGh/ddEq2UtHaR47Yh6pZtnt5nNJR09oC1cRnaLZ
         m1tA==
X-Gm-Message-State: AOJu0YwOgdHMyUI54kfi6gV1zjrfdHVuiLIGpOWK3gBKqmZPKLrGWcCb
	Ts7krtM2bPWnolcm8a8p4b1MAz/eq+FO2DHl2ZwnFI58i0Xn6rmdHYDkbdkS1A==
X-Gm-Gg: Acq92OEcN3NwLGHYEP8xZ69BPhmA7mdChVj6+PBOSO21ts+ffShZHVrHoL+GjjD3mva
	zsh8cKvg4eHi8GGeJYev/hZGlV//XZOa1ki5VGVJb/uRLQUrDiwe4MifbiY4kgYiZa4XH227SEt
	UNZRaSxM0ZVxllCpB1uyCoG2y193MKBv2AXdGf2sGoKzH7uERSoxklac5B4zvvWlBqv8d1lbK+T
	nYtw1gwq81pPTBM2HwGy+6Q/ywpNZPb/dhFNDaBSfpFvWmpThILK/NB/KShPtNYpaxzZkcRh0PT
	UEs8GICP0gOuNOqipjZt60d0iDFMZbSAdJUU62yv63yhAfiEd88hkyfI0iBIkyGjEwB4jjRwMp8
	hW5tE6yhT7iULEpLfddabqBLnnpNNDEW417VVmFrobWIs68UolWr7KxwtBAIZPUBW06gzVwFEU5
	b/Mm4HyBrGmStMHgORjWF//PvysdnXSWyst98=
X-Received: by 2002:a05:622a:2485:b0:517:8353:3492 with SMTP id d75a77b69052e-519a8e5bb28mr86276831cf.27.1781726218946;
        Wed, 17 Jun 2026 12:56:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79c5absm171767341cf.18.2026.06.17.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:56:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4 v2] libselinux: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 15:56:42 -0400
Message-ID: <20260617195645.96604-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common idiom to grow a list or buffer is to use "len *= 2", but
it is possible for the multiplication to wrap on overflow. This
would result in the new len being smaller than the old len and
could lead to problems.

Add checks to prevent doing the multiplication if it would wrap.
The multiplication can always be done if len <= MAX / 2 and
should not be done if len > MAX / 2.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/matchpathcon.c | 4 ++++
 libselinux/src/seusers.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2623e5dc..dc276b7b 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -117,6 +117,10 @@ static int add_array_elt(char *con)
 	char **tmp;
 	if (con_array_size) {
 		while (con_array_used >= con_array_size) {
+			if (con_array_size > INT_MAX / 2) {
+				free_array_elts();
+				return -1;
+			}
 			con_array_size *= 2;
 			tmp = (char **)reallocarray(con_array, con_array_size,
 						    sizeof(char *));
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index e4a844df..08514bd6 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -114,7 +114,7 @@ static gid_t get_default_gid(const char *name)
 			break;
 
 		rc = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-		if (rc == ERANGE && rbuflen < LONG_MAX / 2) {
+		if (rc == ERANGE && rbuflen <= LONG_MAX / 2) {
 			free(rbuf);
 			rbuflen *= 2;
 			continue;
-- 
2.54.0

