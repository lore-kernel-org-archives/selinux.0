Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F3B658
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794271; cv=none; b=tplAj0zxBvTZm2qs+/x74HDvLBVSaUR9eXEHrO0glgBdvxhT7gm1MU1NUYi1JqbBRxQxBtBOO22dq0vzfqht/gEoScawqtSD+Y3QbaTumJnX11699vPd2kjYv9bZ4Jz3314OMqhJ1cVo2TpWA/BtKKWUJNvDof0Pc5X7muGbm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794271; c=relaxed/simple;
	bh=4WY+Crd4ctLH/evbytkENDeSBU1Hcee4d6vGUvE2mPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIFjXYHmAG78XhtfXeWIAHnUoCHT6V4Gsz920KcTr/aAZTAdKwhypV0EYa8SPNWPAdbd8pDMAiSOUK8FBOxwTUkTeRrGs+tvzNCKT3yH0HGgPCRK/ewsF2NKfHhBaxha9P9jl3z/tT1VNgRlqvX7+jJD3iw2i8L1o5Uah2UnGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NXFNZJlP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NXFNZJlP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b155cca097so107340785a.1
        for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729794267; x=1730399067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcgw3BRt2p/ZMd3wc0BL8XqRi6+ZF+u0IMHy0+u5E5g=;
        b=NXFNZJlPHhl7E58Z/gYaMTrrbX2q1oDK0HRUGiXvKpF8dXxw0LxVAECJOSSGK5L4Fd
         E5Aw3kdfAKjlz6rBvBbhcueP6N0nQrL855MxUVp+vixGKVG7g4J+zI/6jphz1HIy70iP
         kxVSAX6GtgUYHQBKW3xzz/DFs5suvNwiQlsehCbIG2hLH1zB75WQ9qD1MHRzNf81ykXy
         y1wr1o2pjLaGZFu5FVuG95uo08BNvGTawMmrJa6vIo14Szf//Ne22cxOTZdBL7RZtG6y
         gLECaa2ALRREDmJ47z3jGnubwLZsFLrA/FrD8KSS1Hz0uCyRZog/aT+DM8fBtNcZ9KqB
         jKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794267; x=1730399067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcgw3BRt2p/ZMd3wc0BL8XqRi6+ZF+u0IMHy0+u5E5g=;
        b=XeKWll8z1SD15j+BKNOSVe0ib7MluXluqBED75qd+ODqP3jGLW+zaIKRA5kdK/ZHyw
         UdvERmTG7HrpEzbEpbDJj14LF7KWo7L15cbIoUZ0C6iz4QGK0p8hyBjY93ckxdFWy+Um
         TPvzNxlRu1EJ/vlzgQx/73qA+lZiVORNK8D5kJAacTOduo/wps6MbklpdWgf6qDo9mVy
         0fK/7vLCrfZvwpp8TxWeBW+XF65g1Eqa7q6c4eDecpioKrBIkcwzqCSvDXKeQ80LxcxK
         X7qEIyyM7VIwi5ou92BmAPS6P5x51wK65YhKPQvMboJA+Fs5K//vGkxphntPyMX1QrpA
         7rug==
X-Gm-Message-State: AOJu0YxCij/LCqJmKdO2hFjT2IiP4/MVc92qn7zcSkdlomJHTn5oaweb
	d0MyxZab+9AKbcPiRNorbyWP9qO50h2MOdPxpy8wzozCsUWEFNuIgCwLsO9ycBkEpikzaDh/q8k
	=
X-Google-Smtp-Source: AGHT+IGpNve0SU6bq/5rhJ1/JXoNZ98aFUbMpNHyyX5I0XMw8Zw/22C6K3R+NUZGsX7ZhIFoex8fKA==
X-Received: by 2002:a05:620a:44c2:b0:7b1:36b7:3fad with SMTP id af79cd13be357-7b1865d3721mr551562085a.13.1729794267465;
        Thu, 24 Oct 2024 11:24:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a06daasm509380185a.70.2024.10.24.11.24.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:24:27 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/3] all: coding style fixes
Date: Thu, 24 Oct 2024 14:24:24 -0400
Message-ID: <20241024182424.138616-3-paul@paul-moore.com>
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

Fixed using astyle v3.6.2.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/file/test_sigiotask.c | 2 +-
 tests/ioctl/test_noioctl.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/file/test_sigiotask.c b/tests/file/test_sigiotask.c
index 1a8f8f51d438..97d343b71d6a 100644
--- a/tests/file/test_sigiotask.c
+++ b/tests/file/test_sigiotask.c
@@ -58,7 +58,7 @@ int main(int argc, char **argv)
 	/*
 	 * Spawn off the child process to handle the information protocol.
 	 */
-	if( (pid = fork()) < 0 ) {
+	if((pid = fork()) < 0 ) {
 		perror("test_sigiotask:fork");
 		exit(2);
 	}
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index 4b67e9a23640..319d90fa2ee3 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -63,7 +63,7 @@ int main(int argc, char **argv)
 	 * < 2.6.27 or >= 2.6.39:  Should only check FD__USE and succeed.
 	 */
 	rc = ioctl(fd, FIONBIO, &val);
-	if( !rc == !useaccessmode ) {
+	if(!rc == !useaccessmode ) {
 		printf("test_noioctl:FIONBIO");
 		exit(1);
 	}
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 	 * Old:  Should hit the FILE__GETATTR test and fail.
 	 */
 	rc = ioctl(fd, FS_IOC_GETVERSION, &val);
-	if( (useaccessmode && rc == 0) ||
+	if((useaccessmode && rc == 0) ||
 	    (!useaccessmode && rc < 0 && errno != ENOTTY) ) {
 		perror("test_noioctl:FS_IOC_GETVERSION");
 		exit(1);
-- 
2.47.0

