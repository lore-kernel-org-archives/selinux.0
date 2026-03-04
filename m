Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62E3016E9
	for <selinux@vger.kernel.org>; Wed,  4 Mar 2026 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654649; cv=none; b=S/wBHRX8gqtXrjLGHMSsLySpgZfRLryjpLrbl1PWIXVnzSJdqXe7B5CXbhHjlpmHsXEE+roh3sulsQTGpCEa4pq5Q2eGP8GSOOS6DC85N8scuaRwfedBF6Y4Cqqi+kj7ibo4l+PWsPIi5wcmCaiFsS2zCDEqnT1amkGP2iavI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654649; c=relaxed/simple;
	bh=cP0L7y6FBgo/5WXMTZJ6R73dRNh0BBLBfE2oaTGl9eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBBX9Q2uu+JWEwHXL0AqZ2PYOvXSj3sBJ2XftPa7OdAymlSCeeHXK+8hk5YTlAr+NXVOhx1xW1nHjyS9637gdsGa81oBxxmLGLTt9KeVvFSixl9Xs0O9eS9C0cGed86GgWr5srJ1smuaRYqBhckIAudbCdUhfVGbDOliY5TajdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmppug1i; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmppug1i"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506362ac5f7so67076601cf.1
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2026 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772654647; x=1773259447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CQml2RdrWTnIdg2/yTequ/Hc/Z6OqCs+jex4e7bzBY=;
        b=Pmppug1iWAsgJJVB6tCGTLblrNF9ifzJCTV7B5pbxptyXIeN4r5uDiLLruckeVqGXm
         q2G847iGHi/D59H2kaq11wMSTAaHLQsJFWQKi4EU4q99z2+/Tpnh3bR23o47pYh57seB
         zm83s7ZYynaV+07SzD1JUZcSm3BcWhpjWhxsW7KU8HNcS+5MuKqYaMR2phrpnDrqs+35
         x7pWVus/ElXTACa9AGvy4ciH5ipbG7lmE1Xy+aWeXNEM8nEGD+KxJtZaq5YWwNxOiuSf
         DWwMou8EAOFcSBG+ClPtnYDw8PNuyIAbbU/yFGfuOpJuwmj/K9BJ4BWKn+rNUzzQQ/ye
         3BhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772654647; x=1773259447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CQml2RdrWTnIdg2/yTequ/Hc/Z6OqCs+jex4e7bzBY=;
        b=LUWI0/24BMHw3jQ4XkkvqBbg6MDxCDZWac/bRohy0qVqQdX3v4RtqPF5nE3cu2WApB
         oth+tctyD27GhAj6REA8eK/TE5V2OOg9V8Gf06GDbXjqhm3vhx/iRQ71cPThKKXl4iNn
         59jsrPQM68QRQ/xcmPlhpyeb8MA3YJ/wgi8VL4bwHXLhfPzrx8OimnT2AXvSfDyYM2E1
         +qbtUmLRocGcpqq3AqBZTp3jGbIQUBHGAFcPkcTwdmdUH1jzDw8UwWF3Gz1WJXCwwErw
         4JetKi8G93wrZLjiLLJZ3bb3hFUkax+BKdhxgFHbEvucuqTuC6bVrT7tks/MTeWKEDRy
         Q+mQ==
X-Gm-Message-State: AOJu0YwNls9YrfMHvrfE7ojFvjgKjeP3kXFY6+A2fxomXI/Uy54WcvfX
	p1CEVzABmK2xiV2jXzLXP44G6Iuy2gqYqpsDjjWfbngyhSgdh2gfqKA0cl5qdg==
X-Gm-Gg: ATEYQzwxqAmDx66UOzYwXmDnMrGfTZNXgUmRjkvmzMSxcJPNfIjo4U65LeJG6LXUonc
	hH059fHP4WczsY86FZYIVaRN7zBAeYcAwsV1KNhVmgJiTlkN86fEVs+n/RY3FvLKnWK9yqgZK77
	5PaTfmuAY/db3esItqYj8nHhCmLmXuLkjmmfViFksppwGAtacKmnLIFC18j742WyPdgvrdH8PqO
	0GqcqLKB7+4LlHCKU9YNfZNNv5oBpj4oaJKzlU5iXGLxN7Rwg3nL4GrfoYqWh/J3Gz1RMLVSID/
	eFUXqWCxVv0hvIo/poUsTZtq90eaX5vXsoCg0t32yMiENFFDLjjcLi/UNUVbYgVv5nazgHs+oXZ
	y1zm2o8zJjvo59svY1/JDVSfG5oGX4TORxbSUTgJeu3Kxi0mggk+HtQgrM9K/jzz0tuZ+IM6GKH
	UkAJ+EppMgqGz71an4kJO1vldFSCQbS2dWoKlyLJKJacWxNtJDX3NFHI+Nm2/Qd1AU2YsHPLxae
	BaGtqD2DSu/vEdXqjAskCdqbGk=
X-Received: by 2002:a05:622a:11cf:b0:4ff:c61a:c8a5 with SMTP id d75a77b69052e-508db38f133mr44705611cf.49.1772654646051;
        Wed, 04 Mar 2026 12:04:06 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899eab5cf2asm100446456d6.13.2026.03.04.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:04:05 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: omosnace@redhat.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: Do not fall back to /selinux on a sysfs mount failure
Date: Wed,  4 Mar 2026 15:02:38 -0500
Message-ID: <20260304200238.26493-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if we cannot mount sysfs ourselves (e.g. in a user namespace),
we can still try to mount on /sys/fs/selinux first prior to falling
back to /selinux.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/load_policy.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 8e737a23..bb7f2dd0 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -290,16 +290,11 @@ int selinux_init_load_policy(int *enforce)
 	 */
 	const char *mntpoint = NULL;
 	/* First make sure /sys is mounted */
-	if (mount("sysfs", "/sys", "sysfs", 0, 0) == 0 || errno == EBUSY) {
-		/* MS_NODEV can't be set because of /sys/fs/selinux/null device, used by Android */
-		if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID, 0) == 0 || errno == EBUSY) {
-			mntpoint = SELINUXMNT;
-		} else {
-			/* check old mountpoint */
-			if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
-				mntpoint = OLDSELINUXMNT;
-			}
-		}
+	(void) mount("sysfs", "/sys", "sysfs", 0, 0);
+
+	/* MS_NODEV can't be set because of /sys/fs/selinux/null device, used by Android */
+	if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID, 0) == 0 || errno == EBUSY) {
+		mntpoint = SELINUXMNT;
 	} else {
 		/* check old mountpoint */
 		if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
-- 
2.52.0

