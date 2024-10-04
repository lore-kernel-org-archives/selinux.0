Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3871798C
	for <selinux@vger.kernel.org>; Fri,  4 Oct 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062883; cv=none; b=daslp9JN3gHjRQl13LaYICmNNSMmuCPqBf7TqWwKERUhMy25cTiUwS6T2EZHkOlU3RMPazQqi6de5+6LsNjQWmH0S7A7Con+u2+aJFzqDNyf1jDMugO/BYG44ZucVvLwaLuIRpduJSpUFVK5/mjULAzSWIlpwVBtRrztO63XbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062883; c=relaxed/simple;
	bh=YYY8nFyVtma3dflUcLsWEo8gFutvNiwdEUugbJL9ccY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tknm44XZDnpuaNLbfnUe3KN3DD2giQGCqpYEVSck08CgQH5RSQ1nrnXRdtna8TS3R6lLM9aKOB1mpVXo4aNjwgdeOxEWqB55txHwLfLjEfR/CTI0eamNjIdD0V/ji2HIt1hGdQjhx5/j1tZjegIyuhcOgCMvAT43oDS+u4ke2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQWDi0F7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQWDi0F7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4582fb3822eso14051431cf.1
        for <selinux@vger.kernel.org>; Fri, 04 Oct 2024 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728062880; x=1728667680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjnjAAXuNKyfu+eW29mn1QDpW4u6YS7dPuusS2cgBKQ=;
        b=nQWDi0F7Co8l9ohBfSlwej8GWYMdU/cT8GQpotfCSQ6o+QcOXuCq2B09ZgnMDZcc5k
         fDlreFPQQqhnQa/k8DjuL6NwbKN6o6R3nc6IMihfODt0hTpVqUnlXcdqPXFwGJQ8BB9P
         U4eK+Padg52DORPDyYDwnFriLucaOJItvabqFpW20/RZOR5+lJePIEBYXxN88CdX5OQX
         zQczljCU6kMmJ5nM94SYebkL0Di6Wdlo1ArnzsjAaRkRToNH7t7xIoAFS2Gn6dA8drFd
         TyZhsN3yvSKR3O8rwr9oJUeMMnovv+H/2quw2+pPd/BD3ucPDdvLB6iGx9qAwQsU3hpq
         a7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062880; x=1728667680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjnjAAXuNKyfu+eW29mn1QDpW4u6YS7dPuusS2cgBKQ=;
        b=vryPi++7IjFK++E+9B/rAY2JU4Brhd3MRNuIol9HHiACA1XLA1mAj9fzJtiWp/cpPd
         Km9fWxuqJiGue9qOCVBZKNeXjl/ZFHnhjK6t3ReigpLfLcxV8oyMc7dWRMh8388Wbuka
         LqYCkN7dlZw1sG+xIl8LM+bOEHI2oWlEXzgRymr2UJachnANPRdW5g/NtMMdheIPuz/u
         OgnwfqKtZPIPhF15GBnrBbnvisqwkZdjCj1TrRAcr28hWkiHgV+/ISOrbGhCRSSSLpqN
         N2qEXp7b4gSO2dsxzj5g7v/P052sHcj22dRiVIHo+r9p3myHix43CVopSaLOWWlD5hGG
         JkUg==
X-Gm-Message-State: AOJu0YxSlO3/GI/u5UCTTlgPFMl9VK3hsxJaeCrihs5+C2IDZU6XmxQl
	h5o/IQeiAoSmTgo4Dsyn7RESGlIWbfyC45c5Q2hQgNRNXpXRnnsAF7VyjA==
X-Google-Smtp-Source: AGHT+IE4JM0Czoh7cVav0acr5Y1QnJD4tkOHtIbzcEQx5tFgQUqR3lRBwlBBaIjXjUCw5GFHSLorVA==
X-Received: by 2002:a05:622a:138f:b0:456:7fc9:63f8 with SMTP id d75a77b69052e-45d9ba20878mr48741791cf.1.1728062880310;
        Fri, 04 Oct 2024 10:28:00 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da7559ea0sm977741cf.55.2024.10.04.10.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:27:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: Deprecate /sys/fs/selinux/user
Date: Fri,  4 Oct 2024 13:27:10 -0400
Message-Id: <20241004172709.25165-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only known user of this interface was libselinux and its
internal usage of this interface for get_ordered_context_list(3)
was removed in Feb 2020, with a deprecation warning added to
security_compute_user(3) at the same time. Add a deprecation
warning to the kernel and schedule it for final removal in 2025.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 switches to pr_warn_ratelimited().

 Documentation/ABI/obsolete/sysfs-selinux-user | 12 ++++++++++++
 security/selinux/selinuxfs.c                  |  4 ++++
 2 files changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-user

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-user b/Documentation/ABI/obsolete/sysfs-selinux-user
new file mode 100644
index 000000000000..8ab7557f283f
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-selinux-user
@@ -0,0 +1,12 @@
+What:		/sys/fs/selinux/user
+Date:		April 2005 (predates git)
+KernelVersion:	2.6.12-rc2 (predates git)
+Contact:	selinux@vger.kernel.org
+Description:
+
+	The selinuxfs "user" node allows userspace to request a list
+	of security contexts that can be reached for a given SELinux
+	user from a given starting context. This was used by libselinux
+	when various login-style programs requested contexts for
+	users, but libselinux stopped using it in 2020.
+	Kernel support will be removed no sooner than Dec 2025.
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e172f182b65c..234f4789b787 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1069,6 +1069,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
+	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
+		" This will not be supported in the future; please update your"
+		" userspace.\n", current->comm, current->pid);
+
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
 			      NULL);
-- 
2.40.1

