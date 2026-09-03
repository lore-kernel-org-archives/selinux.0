Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7B4B66CD
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446712; cv=none; b=poYkHlocbInzddwwrrVZtHOSfs8n0GCx7OxMhfTtK7+M1Wz6W1eJll49i8cYhtahiJOHftTwQxuOsg9JcR92jNhKHfErIIf1jcvDjSwen93jP0D+RIY8qdtO3DeUKErHM3szJYI9PuFLG5Q95e7eO8CP7nWPcrVtRa+cfa1OdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446712; c=relaxed/simple;
	bh=pTlgUqFJlW0vMaOK4gYSqeJdWYp9jxJPaMVcCNvQNDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTXSvcoEmkv8mzLYHDA/YiCqC5nYGl+KMBWKRbPWjATnGT/96ZyrMopzxCWmy7N1I1rtoyifpy2UXm/detqlE6mwXr0HOcJxOhI1/WCNcRIl+pykCyaTwrY4QtuRFRQ6MZalreIodOa+SG/Xv29E+gb897Y1FJpOedpUhRn77Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3gbSphU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3gbSphU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5302b692c8eso23270261cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446710; x=1789051510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFzERo9uzTMCI+4EcQMzNmhw+0cQ7PYuxeL6HPvt4ws=;
        b=k3gbSphUoi2ci3xU0IMDGuzjl8psNNBa3s+HwsXZffgcRQHmij810NoyrTEW/BLMP8
         hCtSqzjBcrkD96P2S28Q/b4EqhjNqlbgeoNgcXF0CQwLFwnYefySDCrFesSd7wU7aB0t
         YeDnpWeXBkZhNMzxHRB4cxt0Fq7VQ6iHKcZSeI4ts8ARC/DjNG5KOi1FRarguaq/5pej
         0p1EDbGKQ04H70EbK+sQKu70Ml/R70wonAdOK4v5mJvmlIXPoQCyxz0oARp9dVulwIz1
         RslcJIA0CJ8FbbLbuj3GCYllQuYgdynfY2ecGYDS+LytXOO/PVTxZpETvxQdsUDu48TW
         kWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446710; x=1789051510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aFzERo9uzTMCI+4EcQMzNmhw+0cQ7PYuxeL6HPvt4ws=;
        b=feRaelT9RHlx2IBg5dqE9OOPc0dzSb3jbmAkVF+2O/WkpSPMvS5TVxR+OL4ULzw5lp
         n9r8ckZDCUTIY9qW2yATTekAOnbfnZ7KzQt7uHmqEVFTrk1nad7s3xXvdgNbVKfa4siM
         AI0zRwqAFGVz5K5WWCxtRDRYgk4jvx1dmxFeMGxAnz4rTPTzDmjdtGehPuG4qzVvgNSE
         lDPpvfz3j9eFUudWSwsWkRIr9KozXbxFd/CIx/0oCOYL7mW+/tmsNukeufsvl12ofz2K
         YwrJL1XZ9zAueAlo3XQRTCggSTRNdzLCtVCLp1Cyps/hPCI6Ocd2ZW6xL53Verd9qE+f
         L7Vg==
X-Gm-Message-State: AFuF++mluerc7FgGlxIA1nenRSrXi1D2Q6PSkG4lYAhFih0vwjaV3Ejd
	YA8bsMluuAFFaDey7/5B1nu4oWVIg8253hwYNPsMoq5iKSkiSheiG3RGTjgSXw==
X-Gm-Gg: AYBFou0xxj/7ueRxNe57BiE5QbBKou2PL2kn3cXOuN43VLp+whBlC1s3YcEug5Bm9fV
	/ZY1yt41dIUB8HfuB5aMtI8dOTkkb5uE+2g52FiXwRrN/LYechvQjkT2Bkjn5FsZY7kBT83CGgZ
	FMcWVGVnqIA8SEBAYrfIn6i6YYjgNzxy/56bhM3SidMzIlKzqtEZySOT/woUWGRhu16n9FKN/YO
	ryMsJzNnkXrGhUu0EwX+vyLHAiUzeVcV59rij8HgoeMHr0NP9M3YlUkb0DsMr0budw835jqh1Cg
	TruD9TiM1jBRf+6nUBrDH2IAxMioXUN0mYSU65KvzZ3JZgWQGNzO2aprXYR4Gm/bScaTSJqJj9r
	JeFI0xXrClPJKyF9WXD6EbHQRII8fBcNJw+0kq4WpywSsUYzzEvy+5kwmL1OIS1k2J7/dgg/qAX
	4//nDFUASRZaQHhOxr1ls1JM0Fv7Gt3VTmOk4o/WPtD9Qk4boiZlbaPEctmHLHfXdMQbBM0IRXV
	6gUjxBRbCgHaXLYqDwUlFB+5/jNaPLkQ+1pcrNYE0+yqnMX/hCI8U0SzPTEwwCo
X-Received: by 2002:ac8:5e10:0:b0:52f:b0f9:e4f2 with SMTP id d75a77b69052e-53036b97d24mr144154491cf.1.1788446708997;
        Thu, 03 Sep 2026 07:45:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:45:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 9/9] libsemanage: document semanage.conf search path and ro-store-root
Date: Thu,  3 Sep 2026 10:34:36 -0400
Message-ID: <20260903143433.19810-14-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new semanage.conf search path:
	 /etc/selinux, /usr/lib/selinux

and document the new ro-store-root option for semanage.conf.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 drops /run/selinux from the default semanage.conf search path and
example ro-store-root config since it is not required for the
stateless use case and it introduces the risk that any domain that can
write to var_run_t can inject files that will be used by
libsemanage. Distros are free to re-add it using -DSEMANAGE_CONF_DIRS=
but if you do so, be sure to create and label /run/selinux correctly.

 libsemanage/man/man5/semanage.conf.5 | 34 ++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 74f0d34f..9431de35 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -5,8 +5,16 @@ semanage.conf \- global configuration file for the SELinux Management library
 .PP
 The
 .BR semanage.conf
-file is usually located under the directory /etc/selinux and it is used for run-time configuration of the
-behavior of the SELinux Management library.
+file is used for run-time configuration of the behavior of the SELinux Management library.
+It is searched for under
+.IR /etc/selinux/ ,
+then
+.IR /usr/lib/selinux ;
+the first one found is used.
+This lets a vendor ship a default under
+.I /usr/lib/selinux/semanage.conf
+and an administrator override it under
+.IR /etc .
 
 .PP
 Each line should contain a configuration parameter followed by the equal sign ("=") and then followed by the configuration value for that
@@ -35,6 +43,28 @@ Specify an alternative root path to use for the store. The default is "/"
 .B store-root
 Specify an alternative store_root path to use. The default is "/var/lib/selinux"
 
+.TP
+.B ro-store-root
+Specify a colon-separated list of additional, read-only module-store roots to search after
+.B store-root
+when reading, e.g. "/usr/lib/selinux".
+Only the
+.I active
+subtree of a listed root is read; the sandbox, previous store, and lock files always live under
+.BR store-root .
+Module listing is the union across all roots, and a module at the same priority and name under
+.B store-root
+shadows one from a read-only root; installing at that priority overrides the vendor module and removing the local copy un-shadows it.
+.B semodule \-r
+on a module that exists only in a read-only root is refused (use
+.B \-d
+to disable it), as is
+.B semodule \-e
+on a module that a read-only root marks disabled.
+Unset by default, in which case only
+.B store-root
+is searched and behavior is unchanged.
+
 .TP
 .B compiler-directory
 Specify an alternative directory that contains HLL to CIL compilers. The default value is "/usr/libexec/selinux/hll".
-- 
2.55.0

