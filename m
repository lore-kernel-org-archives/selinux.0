Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E32D239F
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757411; cv=none; b=s7Z4QLf6K886ZPKIo29Zj5MOoucepqUVYUoVaRdvgEiv19pTpmvlzL0Wa32TAK6+3cafTP9nJUXxvieN7v6s6Br6oqc2SnKxL7mfin5hXVgIg/qkEzToxMdziny29Kd/pK8j4+inFMJxHjVGhXvOtgikQSvXNVPd9uwqd2ub/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757411; c=relaxed/simple;
	bh=sR5ZIcHr1sF6jU0QNTR112ENba+b2j7/AnR5A9YcGbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szzzou3Q6VP2Jj+vyPDJhqL7gquPpvhGQYeuFSMeH9m6BwBl133YwMt4j/YrrMlpGC57JTez35PrrebTRcHvbITLFyIYocKnkCkBM9f793yRAqTWduYBOf+ODmK0X6Ftd/kePfepVNHPdVdq9K+7XqAPuiuvurOq1cuW8beUw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyglEd+b; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyglEd+b"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-79599d65f75so42471276d6.2
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759757408; x=1760362208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zxfarspFWnDpbOtgkV6ZFHQcu/VRILR+6u+S9GZ8Pc=;
        b=FyglEd+bH5/tg7oZBoqYKs0QbyTT6JxsXDQVw6BF1FxpUj7zZiIB5iSya/8Wp5isXT
         UZ5O7rbENE7HOnT3xtnZbFfJvE+42pyg6HEr+hmVvJUr+P2Z261StkZy14veh3MYX8UW
         /gFFpsqo5autJaRglCck1yRoAJqfgMiBmziGT+n6HcfuEfD89sSxVMWBbyyd/Zwrqgk1
         Hs2pmcwkw1yLPW3MhaCBHXX6KcCVmJK33qjwYznk9JdwSQDzzGuqfwSW4pN1UKjglmav
         VWe4Kn1xDDoa/IKXufWlfGQO6uZ4WNPEK5b/t0SSOa7TETbY0u6livQAImAbn4ujSDh7
         kUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757408; x=1760362208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zxfarspFWnDpbOtgkV6ZFHQcu/VRILR+6u+S9GZ8Pc=;
        b=uQFyhiS7LImko4ympEZW2pBkt/+jF3JxwsmhUA+EgwPckUh7ClxPVdSUYogJWoiqhi
         hKwAFGIwN0NdUBgJzZuSkTgxUquL3EPiP3LJptWw46Oh0/Jc4onIo0YzXm2YUH3mcAy+
         Pl4tDygiB1pt6GKQNWhIuUB9XtcCTR4zAcW587mRsKwud7o5Jei83AXo+/6k4Tfc0+7e
         AFGrS6v3WcRE2q/JTP+WL0YMIExo7oMTYsM7QVA/bYdeZ/32BlfxyR/3gwa6M6uAR683
         LTTkA3AUva0TXgaUJmYqiTIcykb3hWh4ox5ehKjvvedTIwWs4G6r3MQRDWF5xqFzK2Ti
         XXyQ==
X-Gm-Message-State: AOJu0Ywo1XE3McTFM+3I2Bvd6oFTm8Iu1bpwr22Yyg/EuSwC0kp1hB/b
	aC+yPGMbvZrt5IUFOm4X0Y2tMrM6NDNm9jHroWIotXDzhS7+qyChfDBY1T/m0Q==
X-Gm-Gg: ASbGncvQIEVkwHs5Tjcx7pfkMFzMyzYZSNa1RbhIyUb3xsw0eHptV7w4zbalKgZgQHG
	yZbqv4qUMMV2c+Kh6ygmcLWA6Tg/TLt+GSRSs68omf9S1wRFG4fFmtyGxkCxYysL4d3U90zZqFp
	vDgJk81rq6a9Bau6XTTu92y8pr4uapTv2gihzk2shndO0mAFCzDteBksPwvGdRL2rKVMG4ZKCBD
	GHXvn+arwRBXfIm+5ArA/X3h/TZFEH+Mz+adtPt2B1JTF4Hzl5dcApOer7NGJqOiRUDbc0i8YdQ
	4c7MGFYMl7SYAcQX+P65Cq0G5wLLxgQFiGriGLFuJCrJb3b31JLrhuVzOKFwcobCYU2ter4yjYX
	NF6vC0pUBO1GBIFPocnt29wuxmDNCblnWyKNwK1jJQ80q/u6MFt0HL9ftG5Wkt/8pXd1MRxD34+
	f2A7f7NwNaY48hVXYnAavWx1z2lxiHn6oRyVGroEBayIzrXNg=
X-Google-Smtp-Source: AGHT+IHy5kaBMAuBztOUOrqwIhgcTpxEjq5VNlCYhxsrO9JIY5ZgAlGm05vj6wGNW0DOW3Y/Ap2jxA==
X-Received: by 2002:a05:6214:416:b0:765:619f:6412 with SMTP id 6a1803df08f44-879dc86a83dmr179202936d6.63.1759757408172;
        Mon, 06 Oct 2025 06:30:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60df0sm118104746d6.3.2025.10.06.06.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:30:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2 2/2] systemd: perform SELinux initialization again in a SELinux namespace
Date: Mon,  6 Oct 2025 09:25:10 -0400
Message-ID: <20251006132508.3430-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006132508.3430-2-stephen.smalley.work@gmail.com>
References: <20251006132508.3430-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only, this demonstrates the changes required to systemd to
perform SELinux setup and initialization when run in its own
SELinux namespace. Otherwise, by default, systemd currently skips
SELinux processing when run within a container to avoid conflicting
with the host.

Modify systemd to perform SELinux setup and initialization when
run in its own SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes the error handling as per Christian Göttsche <cgzones@googlemail.com>
and switches from using a SELINUXNS environment variable set by nspawn
to using the new is_selinux_unshared(3) API introduced by 
https://lore.kernel.org/selinux/20251003191922.5326-2-stephen.smalley.work@gmail.com/

 src/core/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/core/main.c b/src/core/main.c
index 4fc870d6c0..f33d5609bd 100644
--- a/src/core/main.c
+++ b/src/core/main.c
@@ -3124,6 +3124,22 @@ int main(int argc, char *argv[]) {
                         log_set_target(LOG_TARGET_JOURNAL_OR_KMSG);
 
                 } else {
+                        int selinuxns = is_selinux_unshared();
+
+                        if (selinuxns) {
+                                r = mac_selinux_setup(&loaded_policy);
+                                if (r < 0) {
+                                        error_message = "Failed to setup SELinux namespace support";
+                                        goto finish;
+                                }
+
+                                r = mac_selinux_init();
+                                if (r < 0) {
+                                        error_message = "Failed to initialize SELinux namespace support";
+                                        goto finish;
+                                }
+                        }
+
                         /* Running inside a container, as PID 1 */
                         log_set_target_and_open(LOG_TARGET_CONSOLE);
 
-- 
2.51.0

