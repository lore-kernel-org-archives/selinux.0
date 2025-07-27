Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAC21C179
	for <selinux@vger.kernel.org>; Sun, 27 Jul 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631744; cv=none; b=IG8QXu2/vciDb//A+0+lVg3L9CiSNMLF1csaXZvZ79jhIG+6j3cfcyuejpFhWporxUSKgltMxG8jVZwSfAVdbxNLzpQKtmBuvNXTBwme8WqwrWe+YyQ2KtykBt41jhdTja1FJvgx+ELTAYWYYGy4d3eLeVaqDIxw0Uv8enti9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631744; c=relaxed/simple;
	bh=1M6qmyfepYtRYfs1O+Vf46fbbKgOr+/UuPd4u0cwflo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kg9bgcDRocqRVe11jHnKgDx2J3V1wAjinYBj8dGXD20VMXwgvIvx+yh74sBXRlDAXUnUq8S0Ivgt93Y9xexsT3RuFDLWdi8GMF03T7/IaHgDFQQWR0f/u8DkkuJAfteeq0NtuzeGinOMCfJIGByT9PsXhdf/GyXyXR4+dDkGYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGtuM5lj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGtuM5lj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso39049845e9.2
        for <selinux@vger.kernel.org>; Sun, 27 Jul 2025 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753631741; x=1754236541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKYRWWrhFnJGJZq0dfrJrZWC1t3EWxMMyewzSKKQHh8=;
        b=kGtuM5ljVykh2czRMustpXUdkguvxWd6P39Vl5sbczwsMf2Zo723DBtE4WFmvQTMsW
         9QaQU6tBUioZDF2yIfh3L7hkExhC7iAPmbDHFeY+SS4SvWthLTEv5mmwBq88uXpsLVnV
         ogQqLUoQgIR1Nj3go8uQZOu+heUI6ckBRw21Mvd0wSkzVrhUQu54bt8XN5WdbrVR6cMa
         OWm3i1YNJyMSOglR0YsUtqQiGuQBdTarDZnyvntLnrxeqpyjexxD/YYVHdLWTUWVEayv
         HaF+F/cv6qZNH1ivn70vCRBGwX6pyGO/g7YdAfAshohHBdjPRkFWAqYPapuJKFYU/h8R
         8UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753631741; x=1754236541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKYRWWrhFnJGJZq0dfrJrZWC1t3EWxMMyewzSKKQHh8=;
        b=CR3qlyaQebiiQY8UvFsPesF/zNIqpMRObWY8hIxVJYsyip6sZy38OP+N3V/3C57u7k
         vM8U4+D7pc5fENKVVE5fplPTkhz7m+1RyeTuS0lxPH7cnLFDPh3YioBp6LVwmbG7VpDe
         /YkhwKtkToiseRMxBV5389PkF9DrCgqsIaRSuMNIbrbEkePOZHiBK8lAF2vnBG1Uvlk5
         FMON628lMI9wSAyWInb58mHZdrNMXCCSPq9sJmkuS9dvKel+qV4Y4oIvxN9QvHW+zmNG
         c+V6TAH3qO8ww9/Rbzd33C+byw74Ql/HUvVn4OnqFoYRVGJ490fnCWf/BZYwUpIdwDWq
         y6vw==
X-Gm-Message-State: AOJu0Yz4VfLn5vmk86Orw4FBr2gw6Rd7RtB7DcT2FZxcnsA/aoTpjkVq
	RYICSDE8ZcVsdgWWWQuP4pZSYNFcqkWqWpOcEnpb7auqVlQEENOoQbjm
X-Gm-Gg: ASbGncsOMlOW24NCm56rudTbuKzb8TxkcF2DWGqOurDsMCCO2WnrxOcxv+CCD4uGpgi
	jv8QPyj0ITDhSCv9Xivsjzc01rtbOfPYi62NnWf7XQaMtTyal+MrJfJQn+JRWcB4XV7CVOGZX31
	XFdeSGBSLmPpEyYTCkBLYOO3OXAD0/XBXvMyi/85LRpo5kcGcP8uC/98afpf8xPzzM3EdW96h+I
	OQ+IT5IUyBot79f3E/odzuL/RccU9otrxE8dVdcHZfgw9Y0lpz6z4QySVBNaw71hsvSbzJzd553
	XzLMTeuMFFZJ4c5z5yFFhYQ4TFl23Z4q/1jGb82bKkS5HjlW4LvLZ5Q8w3M59aWjraBZl8gPz2S
	31rTgL3G/RLEO
X-Google-Smtp-Source: AGHT+IH+Ht804fZguvajr9XqSjRiuLkoHgaXAHfQcFyEmgeO6bTkpFv861QTe7QzjMz5Mk6Tz3Xopg==
X-Received: by 2002:a05:6000:2910:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b77664294dmr6267816f8f.38.1753631740515;
        Sun, 27 Jul 2025 08:55:40 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c65asm5912199f8f.62.2025.07.27.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:55:40 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: remove out2 labels
Date: Sun, 27 Jul 2025 16:55:29 +0100
Message-ID: <20250727155530.733633-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727154422.732647-1-nvraxn@gmail.com>
References: <20250727154422.732647-1-nvraxn@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The out2 label previously only existed such that free(buf) isn't called
if malloc(3) fails to allocate buf. However, posix says[1] that calling
free(3) with a nullptr is valid:

> If ptr is a null pointer, no action shall occur.

Hence, remove the extra labels to simplify the logic.

[1] https://pubs.opengroup.org/onlinepubs/009604499/functions/free.html

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/canonicalize_context.c |  9 ++++-----
 libselinux/src/compute_av.c           | 11 +++++------
 libselinux/src/compute_create.c       | 13 ++++++-------
 libselinux/src/compute_member.c       | 11 +++++------
 libselinux/src/compute_relabel.c      | 11 +++++------
 libselinux/src/compute_user.c         | 15 +++++++--------
 libselinux/src/get_initial_context.c  |  7 +++----
 libselinux/src/procattr.c             |  9 ++++-----
 8 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index 6af8491d..d9f0beb4 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -36,12 +36,12 @@ int security_canonicalize_context_raw(const char * con,
 	if (strlcpy(buf, con, size) >= size) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf) + 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
@@ -54,12 +54,11 @@ int security_canonicalize_context_raw(const char * con,
 	*canoncon = strdup(buf);
 	if (!(*canoncon)) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 354a19e1..bd31279f 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -46,17 +46,17 @@ int security_compute_av_flags_raw(const char * scon,
 	if (ret < 0 || (size_t)ret >= len) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, len);
 	ret = read(fd, buf, len - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	ret = sscanf(buf, "%x %x %x %x %u %x",
 		     &avd->allowed, &avd->decided,
@@ -64,7 +64,7 @@ int security_compute_av_flags_raw(const char * scon,
 		     &avd->seqno, &avd->flags);
 	if (ret < 5) {
 		ret = -1;
-		goto out2;
+		goto out;
 	} else if (ret < 6)
 		avd->flags = 0;
 
@@ -79,9 +79,8 @@ int security_compute_av_flags_raw(const char * scon,
 		map_decision(tclass, avd);
 
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index ff8553bc..b0c6ea34 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -81,34 +81,33 @@ int security_compute_create_name_raw(const char * scon,
 	if (len < 0 || (size_t)len >= size) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	if (objname &&
 	    object_name_encode(objname, buf + len, size - len) < 0) {
 		errno = ENAMETOOLONG;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	*newcon = strdup(buf);
 	if (!(*newcon)) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
index 53d2f559..ebe33264 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -41,27 +41,26 @@ int security_compute_member_raw(const char * scon,
 	if (ret < 0 || (size_t)ret >= size) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	*newcon = strdup(buf);
 	if (!(*newcon)) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
index 9c0a2304..b2c1520e 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -41,27 +41,26 @@ int security_compute_relabel_raw(const char * scon,
 	if (ret < 0 || (size_t)ret >= size) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	*newcon = strdup(buf);
 	if (!*newcon) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index d4387aed..584219c7 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -43,27 +43,27 @@ int security_compute_user_raw(const char * scon,
 	if (ret < 0 || (size_t)ret >= size) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (sscanf(buf, "%u", &nel) != 1) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ary = malloc((nel + 1) * sizeof(char *));
 	if (!ary) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ptr = buf + strlen(buf) + 1;
@@ -72,16 +72,15 @@ int security_compute_user_raw(const char * scon,
 		if (!ary[i]) {
 			freeconary(ary);
 			ret = -1;
-			goto out2;
+			goto out;
 		}
 		ptr += strlen(ptr) + 1;
 	}
 	ary[nel] = NULL;
 	*con = ary;
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index fb774c82..badcda9f 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -46,17 +46,16 @@ int security_get_initial_context_raw(const char * name, char ** con)
 	}
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	*con = strdup(buf);
 	if (!(*con)) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index aa16c934..f8e8f191 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -153,22 +153,21 @@ static int getprocattrcon_raw(char **context, pid_t pid, const char *attr,
 		ret = read(fd, buf, size - 1);
 	} while (ret < 0 && errno == EINTR);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (ret == 0) {
 		*context = NULL;
-		goto out2;
+		goto out;
 	}
 
 	*context = strdup(buf);
 	if (!(*context)) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	errno_hold = errno;
 	close(fd);
 	errno = errno_hold;
-- 
2.50.1

