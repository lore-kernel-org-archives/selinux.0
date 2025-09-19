Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5B3101DE
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284655; cv=none; b=gxhAB+/dxdbbZVIzbaia01UjB5OH9ab5vQDIlXkuqiQv4EIJGfpV8u0jxY5+RJxp0QCAQMAOtDiwKwVhetKJHAm9ZhZjAzbPd4JrAzqAr6AiN3QBrnay4Krgz6dO3JZtEr64BNxPoI2Yh4OKNqivIPi2wcqQOSzu880oFwL7IAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284655; c=relaxed/simple;
	bh=7TAoVOfUyxl9rRxmvY15lU4dIJx/63++npnUukU9Huo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTAqEQM60KKK0XvWrOwkjDe62R87r4BfJzgKSlPVon3+TlnaCrJOKWTb9i3kvkIe70DmH4Abd/nP3/M32JXDLm6oljg6wKVUnii+STFH37H6ABmdzMsCm7PituECptFFHNQEYrzQ7W6HtMW7BRdDPQ6pqgN9OyiozwYg5ANaWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlpDmBmq; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlpDmBmq"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-79390b83c7dso16959546d6.1
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758284653; x=1758889453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbYoGOe/IIwGPkdVl6KHwgSpVwNeYahnJmyOj5v2S8g=;
        b=YlpDmBmq/5SGNzdUgMkVxy4FrIJAXgfcYzgij+oA9/Nu/QGtpfKF0groI3QVXX6Xpu
         SlnC+YsE60wB5PvVIteYhx2dAXRO4sCTNP89+jAaNI0+sUQYJXOb1SiGeEDHbW1HXAxH
         RSOqRNhf3xDwGc7fThLY/m7YDa5NgWnWGsAxCk4HAV3n698itw3SbtYX7OswxKhnBpna
         qXfG/euXsUNYaBJGPeq1A9exsXhYpz+sJD4symJ7uEr8Hv6Jmn6UcoEGvqx5sLMc8IyT
         KvYCmbJ/h1qcoqfzVw763cNa4oVJ54tqeJrR2vXvsdUM6l++yb+tNZMzckx0smIG8Qw2
         EQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284653; x=1758889453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbYoGOe/IIwGPkdVl6KHwgSpVwNeYahnJmyOj5v2S8g=;
        b=bv30X/sOAM6WVSwk1Gil+FfNVvebpyk3qR/4/73v1rKdAu890nclE/rP7FhK8JuUe9
         MoadxIZsH/sMU7zqcJ4IkzMS23Ernq+zSYzTqIMzZ3btiV18uMLd2gHn1QrsLNYVFOxe
         4zKo1o6nWXsPgyxz+EIhVo1zMI1Spdg7FPdto/fjncJYlBJ7bFXFgZRJqCN/xVztWhzz
         Urvp/fBKy+FlUURGRlQY48KAQpSU+GKY4IgIg7kx1Z/jtQzgxZ6VyU0lgX60qU6MjUI+
         xEBSporXFsyoPBI09IT+mVSaQQ1kP2BW0xlqSHpJ4HeeltxbAbHG9VvKDRXxrPewZSxJ
         lK2w==
X-Gm-Message-State: AOJu0YzwB9XENulyxqNt2K0LlZQekaGYspGNEvbz+rES8Qv+nG5WLx2N
	el7EK9Y9O8LcDbssilHkz70CIrjeKyrCwt9yGWvcjuijYd3yUBa9zYNMf2g0oA==
X-Gm-Gg: ASbGncuoT0uPtf6RQqoxJkkN/AxXZHDuBpKyxHCfyYxEFtk0ZSfhbkoAcKiUFdAeXMQ
	bZ3DhuMl3DjbSqXz893WYGLXkcaDquALc5Hq6u39EIGbIbbTDpGIULSW0SnRZdoelDnuyEF2Iig
	CQpQvSqeNX3JfyFmx3SPPrE/13pSrsHBRya+b/Eg62+vWAWflLV+bPPaQFr1Ll+uEnuh56p61k9
	6wKZNB49tM5tu+NsvbY+oL1zm1pmR9mM94zsEKYwuBk4opDfP8/CtX+gfD/0/IOnRpX1aVWwOGp
	zlXL3qPvb/mDv63L6Bc6yRNknsTMKpYHkqj+YDXo2avvdB+H/YpMIiDQ0hZgsQCG1Qge/IfrohB
	Y6mstPlAPWJeXCSXP31CZKspAhkZjWFSnUhqfFZXkUoUjxa4qnWJ9GUNzpLoLY6eRvOW4s/KRO2
	zwBBGD8wsejkQZlZifslPHT/ZnCuH9z78CgxE41VCov+wCBq1Kbbc=
X-Google-Smtp-Source: AGHT+IHjJWhWk+3/SwAFVzFX5Us8sQnONUsVApbmmknjPrP6UnVxw3fq+4AwSZhiqJFNxB/T5d+tfQ==
X-Received: by 2002:a05:6214:5189:b0:78f:2a6c:19 with SMTP id 6a1803df08f44-79914361ce3mr33372686d6.23.1758284652565;
        Fri, 19 Sep 2025 05:24:12 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793546dd333sm28205366d6.56.2025.09.19.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:24:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 2/2] systemd: perform SELinux initialization again in a SELinux namespace
Date: Fri, 19 Sep 2025 08:21:02 -0400
Message-ID: <20250919122100.181107-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919122100.181107-2-stephen.smalley.work@gmail.com>
References: <20250919122100.181107-2-stephen.smalley.work@gmail.com>
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
 src/core/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/core/main.c b/src/core/main.c
index 3e7894ee5e..fb903b7646 100644
--- a/src/core/main.c
+++ b/src/core/main.c
@@ -3164,6 +3164,21 @@ int main(int argc, char *argv[]) {
                         log_set_target(LOG_TARGET_JOURNAL_OR_KMSG);
 
                 } else {
+                        const char *selinuxns = getenv("SELINUXNS");
+
+                        if (selinuxns) {
+                                r = mac_selinux_setup(&loaded_policy);
+                                if (r < 0) {
+                                        error_message = "Failed to setup SELinux namespace support";
+                                        goto finish;
+                                }
+
+                                if (mac_selinux_init() < 0) {
+                                        error_message = "Failed to initialize SELinux namespace support";
+                                        goto finish;
+                                }
+                        }
+
                         /* Running inside a container, as PID 1 */
                         log_set_target_and_open(LOG_TARGET_CONSOLE);
 
-- 
2.51.0

