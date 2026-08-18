Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875C346E43
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081050; cv=none; b=eRzyzwsbQ7yAZaiWdDaGgim5guJuwNDRUQcDM2+ROuqjz3MmZG1Ri8UEisBOyZlcTKb1VDmuAXsbPqTuTvcPDDVXim5cpEuM5uVyLsqiYimC7HyGd9iSYnp7uLWRhtZhCeHtns7v0r1wWyKHtEW1IttAtYoja06dWGdgQL17TkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081050; c=relaxed/simple;
	bh=UakWmUYggMCXCG863m7wHH9fCuh6VcCFc2UDHY4aMCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKL8HrXZyMeef+0lI5+x4UXRQbK/NCIv95AnLQ0iGb/nfVXeA/a6xeWfNFRxX9XqYFLU2QPR1F5BiIEQTP5E9dd1zuJkRBuEyW1IGI+HeLRYISIgU9aQGUl8x776l3pbtW6rY7dE7E6I7DeHHy9VCFyzOt5mLeMelO3T1o9Iz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmqE+lX1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmqE+lX1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52d590ce5cdso1268891cf.1
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787081047; x=1787685847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyKnPtfvjKK80MwwstbvLdeNOzergmsIRbUDPTDl+1s=;
        b=kmqE+lX1PC2OPsWbYcbYEM66NCRZKkZYCZzm7gWlBngBhT+Pc4Jyu9XYuaTw7qHc+V
         0UECC06l12wzfOxlcpTK+1ABJqZK6ZkzUZ28pF2NhQK4hvK++DaN3L4HbOXPNirv1TdD
         cwGrmsorIDGrsfP7gdNxNbxNKFHdA0Fb/k1D9Nm3zl7cYALzKqrd9wahpfr40l2eqdC5
         b34HhI8ZSc/78nRuVLrMZf9fxApuMLoA1Wt9uJPH7Nrksi/HQAhBo/yw10G1KpAPC/YR
         gRfX1JWsn2fmf8UBkHrqaYT4yBNTWgXsUjBz7EvS3ksZwAFSfMXN76+G4AnsXKFhJjMe
         uCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081047; x=1787685847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyKnPtfvjKK80MwwstbvLdeNOzergmsIRbUDPTDl+1s=;
        b=b7KQxyv9PYW5DLKJBhzzUTw8VHNoWIXz6cfiKunsJEjy3CTEi8G/6VE+0blFWuQFJH
         tP0MKnKZtnd0n4BPAxrpAh8Wk3VdfJ1uHhpr0P3oCjqISn6DGPRXfulNjmy+ddd33bPm
         qMKpFspxWAa0D01o0TzNZSwis52lLn1tE5JE49/h5yQHM+ybsRCl4H2in0Lrfy9kx+lR
         FuSbhyfMX2i2gRWqAs4wPxNrgnQXSgublLCr7OO/WDdVhFy1kQAaim0AnEqw9oixUpqh
         QukRIbrmiH7b7aLiD5BoU3DGlngiDO5Md925r2mJ8KeaGdu/WU+is6L+CJseehhubI7W
         erJg==
X-Gm-Message-State: AOJu0YyMVBIrNWB3vI815uDMh+rFBRYKIvhympRynAHG8T/ipLLtjDpM
	huU+5TU2FemZfMN8JC6MdVm2s8oY4pmLL4I/fw6ZPzl4za5ksrrb9GURPB4lww==
X-Gm-Gg: AR+sD131OgMUcfd8CEu7a68Z+Gp7WRR2TreAWXG5sQop6/0sfD/A5jr/1N7DxWsupnW
	JaaK4fk5ArQxXyjLCec2cDoaugTJnykjMMqLEuk3plU5jDrbBNY+nYzG3djBmukOPS/G2aItTOT
	Kz6EA8OYY2T/FHPhIfU34MqHbvlSVUzx29MKDhlyIdr9KsD1vvVm82jN2IsmOryyqWXE50pqt5v
	VuPf1O9lNNbNybjp3Mj7m9soM8oj/yG/ndNa7n3wgiurho65BHX1LRywuaVylLXuDvvFYGrJafG
	6PzJtPSQSWXFPx7O/M9NEXMy4yKydYk+rMavdotCtLYEmkn50voiIG51VsGpr1m86qUYBjRSKP4
	FQxsJ1IfnRqZw1cXAehtVN+4UFvFrbE5sy8Wh2OAglOooMIfiZSJ4mTBHF1BQ5BYXQ83t08Vfx6
	fQAOLyfaunFLThyBTBbrLoAmjv+4RIZPmcTsg2rDdL1Y9Zw600yfyUtMqo0EttXOH+N5O6hqG26
	g==
X-Received: by 2002:a05:622a:598a:b0:52d:8256:ac33 with SMTP id d75a77b69052e-52dd322df45mr4218971cf.28.1787081047120;
        Tue, 18 Aug 2026 12:24:07 -0700 (PDT)
Received: from z840.flat.mawenzy.com ([2603:6000:acf0:3410::10d7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db62175b1sm48784351cf.19.2026.08.18.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:24:06 -0700 (PDT)
From: jboero <boeroboy@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	cgzones@googlemail.com,
	Johnny Boero <boeroboy@gmail.com>
Subject: [PATCH v1 2/3] policycoreutils/setfiles: use all CPU cores by default
Date: Tue, 18 Aug 2026 14:23:32 -0500
Message-ID: <20260818192340.119297-3-boeroboy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818192340.119297-1-boeroboy@gmail.com>
References: <20260818192340.119297-1-boeroboy@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnny Boero <boeroboy@gmail.com>

setfiles(8) and restorecon(8) have supported parallel relabeling via -T
since commit 93902fc8b0b0 ("setfiles/restorecon: support parallel
relabeling"), but default to a single thread, so anything that does not
pass -T explicitly relabels on one core.

That is most callers.  RPM scriptlets, fixfiles(8) and hand-run
restorecon invocations all use the default, and on a machine with a high
core count the result is a long, almost entirely idle relabel: a package
upgrade on an 88 core system spent hours in restorecon with 87 cores
doing nothing.

Default nthreads to 0, i.e. one thread per available CPU core.  The
relabeling is already serialized where it needs to be, and -T 1 remains
available for callers that want the previous behaviour.

Relabeling /usr/share (~588k files, dry run) on an 88 core system:

  -T 1   20.43s
  -T 0   15.78s

Link: https://github.com/SELinuxProject/selinux/issues/489
Signed-off-by: Johnny Boero <boeroboy@gmail.com>
---
 policycoreutils/setfiles/restorecon.8 | 2 +-
 policycoreutils/setfiles/setfiles.8   | 2 +-
 policycoreutils/setfiles/setfiles.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 443f29ab..8d7b46f0 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -186,7 +186,7 @@ from crossing file system boundaries.
 use up to
 .I nthreads
 threads.  Specify 0 to create as many threads as there are available
-CPU cores; 1 to use only a single thread (default); or any positive
+CPU cores (default); 1 to use only a single thread; or any positive
 number to use the given number of threads (if possible).
 .TP
 .SH "ARGUMENTS"
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index b521df22..53cb97cc 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -191,7 +191,7 @@ produces input suitable for this mode.
 use up to
 .I nthreads
 threads.  Specify 0 to create as many threads as there are available
-CPU cores; 1 to use only a single thread (default); or any positive
+CPU cores (default); 1 to use only a single thread; or any positive
 number to use the given number of threads (if possible).
 .TP
 .B \-A
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index c86cc0c9..4c860755 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *input_filename = NULL;
 	int use_input_file = 0;
 	char *buf = NULL;
-	size_t buf_len = 0, nthreads = 1;
+	size_t buf_len = 0, nthreads = 0;
 	const char *base;
 	int errors = 0;
 	const char *ropts = "ce:f:hijIDlmno:pqrsvFURW0xT:";
-- 
2.55.0

