Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491D1CACEB
	for <selinux@vger.kernel.org>; Fri,  4 Oct 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057232; cv=none; b=fkVFBujHqHu+2lYXnxjUlN12KQqQVjrVxBeaxniRnjP5OTz/6ZC3989H3iAE/JSDTjogA4vgIl3cci0BT1yj2d3aN+0H9LyzEctW9hezsh/s0kj8AIADgBc6vTqWqy1PeuacEtxhDm3kLXPuPU2293L1qskaKk6puR/0m7sgero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057232; c=relaxed/simple;
	bh=BavdwrW+JL+kkcBpN7fE7IIDCFYzuKRQ2XuIx7Cy3rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fGlLRBoQI1ONsWIRCR2hGQAB5763GIQgBFYX0hplxcXR77RsgcCgMrNzNC1EMGHOgZIReYlXkBHL6DWbJpRKGssC56NzvSEyvmp+NLtvBAtq87pGtIfxQvcJ83HxPWXbluKrqInxRa4G6VQNx2Jejh9+y8PGz/GwM72yjFnSS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/y6cQn1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/y6cQn1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-458311b338eso17429921cf.2
        for <selinux@vger.kernel.org>; Fri, 04 Oct 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728057230; x=1728662030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBfeQbRP8k8o8y1gznMrxMtoV8TgS58P8shgl/FCYRI=;
        b=L/y6cQn1jiJDQPmZ2gM/320+rMtJfT0xLFA2OrhfJUQFN9t2Zs66uLsu7OtVIPubzk
         B4i1x57rrDUh/BQ6HdiGoec/+gd/Bpay5m7CK8ntVxqYH6O/fapndEw3I+VQdHBXnJIA
         9HpDFoOMwKRo2OpYZosdgzaVhbJ3eaO1ShDt4d8ggDHueRXOCSwruHluxveJILeZ+5K5
         OJSqN3GrbyR413AYATjQhh//WTFIOPSccyz/Wf4BGXGhR+QZwMN3r9XAhVx1dYcu2wLv
         oQwyo6+Ti6EFTkIypbVuRyZk78DjTIvXP4OAqTcymxZ2zzQYp3ZJd//DC/IsNNSBG+QL
         Qj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728057230; x=1728662030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBfeQbRP8k8o8y1gznMrxMtoV8TgS58P8shgl/FCYRI=;
        b=CcsYiMbB33wpR9EQSnPyimixyADH/F8UwDqb1ceneDCbVUV1wmuVwLgVJ4cgj+pBhK
         uwZl5kJs7pkhFBTDaJW6GUk6gx3hTme5DTOhhXecKsDPbmmepoAqL8KxcjOgN37iPs+E
         7Iz0DWhrTL2li4ST2+0krz09b+hI/cbojvY0f1LGY7kR8LNMg/0uGBSn6OozPt9eMhWS
         DVW6LDdXvy+F7V7p1QyCNZycXaaRTYmghsqt3XkgqXrCch9C42KAAZE+dapMJgmTaafe
         oG0Lyxh2/Os+nujjVCsnGd7ZalfiQMQ1uvGGYgUDnhiOwe6rYPvBittEHilmT9Ex+3UP
         5Z7g==
X-Gm-Message-State: AOJu0YwrCf0WatirqQP5Qga1JwVViE9II4y4xGe5eq1OLLOVBHMKKclM
	u0lgddNvpsYgcfOrS3FQv2QyY/BOYher6tHODBok+FR0ZCOS6vorYav7lA==
X-Google-Smtp-Source: AGHT+IGTU7YhYF9F7C0xDA1DS3BPGWjBwzAOavnNsJyATINwMYaMDeF0Y0iteHrqVYtrLXII0ejimw==
X-Received: by 2002:a05:622a:1a28:b0:457:e895:428a with SMTP id d75a77b69052e-45d9bae4418mr44032951cf.57.1728057229652;
        Fri, 04 Oct 2024 08:53:49 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da763fdbdsm199751cf.82.2024.10.04.08.53.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 08:53:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: Deprecate /sys/fs/selinux/user
Date: Fri,  4 Oct 2024 11:53:20 -0400
Message-Id: <20241004155320.16629-1-stephen.smalley.work@gmail.com>
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
index e172f182b65c..8117d8f6ac2d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1069,6 +1069,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
+	pr_warn_once("SELinux: %s (%d) wrote to /sys/fs/selinux/user! This "
+		"will not be supported in the future; please update your "
+		"userspace.\n",	current->comm, current->pid);
+
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
 			      NULL);
-- 
2.40.1

