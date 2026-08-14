Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF0473C82
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714520; cv=none; b=WO9Y29RoslanwqYjtmDbhns7vGHSb7WUvRxq46i3+2jsN5jrVA/IlW79UCTFYl0kpS8eiql2zI+bOs2uYDZ7JwE+rKMVZIFfNo079oO3mcQdTf+PHVbzdklCwcQ8gW7vvplmcVFpPRZLt6GOybZPiKOcyaNr8EGoh+VisLNfKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714520; c=relaxed/simple;
	bh=FESNDlcidZGWCDheDa9Z6frk+K5LU819UQM+pRV9ZOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dggad+R2GUR4azhDNb+1zUfDL94fw02NM3QbpSxBeX+IcmPjiKj+nNBs5d7ygZLdvIROBbMT4+qm1AxpnTqTPaCTZbDD6z+kDG861f5zUaZ2RtqK3ZwIrXET3unJldBdgvSvy2YDFolqLwuRnmpcc521X5nGwfJu8DpOqyA9GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9toZrKZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9toZrKZ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-936c02e58dfso65805685a.3
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714517; x=1787319317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzOty2VsbHWFicVI+z3qOvZ8hk5ms7eQXtIY5seD85w=;
        b=I9toZrKZRzwq468NvftSrTVIH1dB0+FnmdGuSei5UPB2aT0wZgJfQMOozGEvgoSFvY
         X5DJtNNy7wL2VglLm1PLs42RJZAxTOFustA2iBugKyYDbDbkZL9chNUyJdWmsRxSvMjJ
         RMwgZDGO8mt7KGEHPKHMmm1Sk4FpkYf2gbQF6OfHzbEKXuGhzj6fCU9oxSPZW2ZbgAks
         KAfIqkk4yWHfod/6yuqIzH01AlSGSg2msdqAzsuTNLPRZSPD6HUDe3D8aghn9beIxwD9
         TqHpR5SQLTobB6RI0BIGBYY2H5WAPiW4emARvH4YoUugwV3S0zzQ3zNSnu2wNwcK9e6H
         r9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714517; x=1787319317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzOty2VsbHWFicVI+z3qOvZ8hk5ms7eQXtIY5seD85w=;
        b=g42KJWzMr+4wW7TZnM5l9hod/zDkARiatL5u7+RVIa/ECCg/jS4cLnM9yT35fh/3Rk
         xK54KnIzC7Xxof4dg7WMXtBMkRATDcm1TyizNwXTCQkkfdBDvdxWss4I+QkrNGLqih/Y
         onWS2GZnSOMZ0BYC5VrYS/fEm4JnrTxJYQz7luEDB7g29GcP6ztbD7VDlKwrCgIujcPb
         9c1Am7n89JktrJlfpGAqLEW9+G/3Cd+VIc60VRKSp06pRnyKcSuubWiXqapOSiTrbcN+
         sVnQcco3ZbJLZURVhv3Nz5Y0QUs6piDjqzucacY+D4YEjv4jQw8emSdSo9527c+ZA9ri
         zATQ==
X-Gm-Message-State: AOJu0YwgSM/oM5PSCDsPYksumR9QmO0yW/m75/PKjh1hHG4jrkzEAZlV
	5tz7IQ3HR0ZTKleA2WHMh8F7n/upTjUhteUxTH05/8gjNKNp7t3zgf80AP5D8w==
X-Gm-Gg: AR+sD138xDTSA0gxKKnimsUiWNX+vhF7Koa8rEzRv7PrAMNQjyuwSeNufGRtXk3GvKJ
	G5Ks45Kd39NNyaG/Fx07nv9KMXCv/d1aus4VQasK8R5pD/NNuv/fg+VFiKzN00sU/W03B+drWOI
	KFEiudVXbzpmq1kmJXYZa3IaQK+SfpBQu605pOFr0cxs4ATFWHkMSar8PRu+VXvkuhcu/oSEif9
	6XTtkuVTwngwG7EJEpnj9HJRkYngv/8ciT+Fmak0Be/bd+OlXHCUNx6tZCJCND4HCSrMqzpl5wj
	QIQqqi1l3wi0q796/r/M75LuoYqmHR16PlI8WvKn9l97zdoCgEe8kGmcHabed6Dph8GOdwrsB+H
	+9esGLj9T/d7eYZyTn0RplJ0deC0lt31PVD6hk7aisvChVUlGKzkyf5pMT1wM7uhg39OHwV/miH
	0tBrSsxIZ5tyIBWdYH4DFpJ6+2qGQY9l3jXzjakvmKBJBi6XtoXZllizEonbSyHS7eql9RnxTBE
	WkNFl7WMITFQss2pyZP2jnpvsA9x58qfGbCJ88RHMCTkEy0/0V9t8F9TgjU2kLKtX0IFpxEgJo=
X-Received: by 2002:a05:620a:4413:b0:936:78c8:e286 with SMTP id af79cd13be357-936d234d4ecmr529633985a.25.1786714517496;
        Fri, 14 Aug 2026 06:35:17 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce0b710bsm279542285a.20.2026.08.14.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:35:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Krzesimir Nowak <qdlacz@gmail.com>
Subject: [PATCH 2/2] policycoreutils/setfiles: enable SELINUX_RESTORECON_REALPATH by default
Date: Fri, 14 Aug 2026 09:34:56 -0400
Message-ID: <20260814133456.203958-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814133456.203958-1-stephen.smalley.work@gmail.com>
References: <20260814133456.203958-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

restorecon enables SELINUX_RESTORECON_REALPATH by default for
selinux_restorecon(3) calls on its command-line arguments; do the same
for setfiles. The command-line interface is not a trust boundary
and we always want to label files based on their canonical pathname.

Reported-by: Krzesimir Nowak <qdlacz@gmail.com>
Fixes: 67bc978bfaf9 ("libselinux: restorecon: revisit pinning files to avoid TOCTOU issues")
Fixes: https://github.com/SELinuxProject/selinux/issues/540
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/setfiles/setfiles.8 | 4 +++-
 policycoreutils/setfiles/setfiles.c | 7 +++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 17cabe37..b521df22 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -264,7 +264,9 @@ otherwise.
 .IP "1." 4
 .B setfiles
 operates recursively on directories. Paths leading up the final
-component of the file(s) are not canonicalized before labeling.
+component of the file(s) are canonicalized using
+.BR realpath (3)
+before labeling.
 .IP "2." 4
 If the
 .I pathname
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 07f0b5fc..da5d2024 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -173,18 +173,19 @@ int main(int argc, char **argv)
 	}
 	base = basename(r_opts.progname);
 
+	/* Common to setfiles and restorecon */
+	r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
+
 	if (!strcmp(base, SETFILES)) {
 		/*
 		 * setfiles:
 		 * Recursive descent,
-		 * Does not expand paths via realpath,
 		 * Try to track inode associations for conflict detection,
 		 * Does not follow mounts (sets SELINUX_RESTORECON_XDEV),
 		 * Validates all file contexts at init time.
 		 */
 		iamrestorecon = false;
 		r_opts.recurse = SELINUX_RESTORECON_RECURSE;
-		r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
 		r_opts.add_assoc = SELINUX_RESTORECON_ADD_ASSOC;
 		/* FTS_PHYSICAL and FTS_NOCHDIR are always set by selinux_restorecon(3) */
 		r_opts.xdev = SELINUX_RESTORECON_XDEV;
@@ -195,7 +196,6 @@ int main(int argc, char **argv)
 		/*
 		 * restorecon:
 		 * No recursive descent unless -r/-R,
-		 * Expands paths via realpath,
 		 * Do not try to track inode associations for conflict detection,
 		 * Follows mounts,
 		 * Does lazy validation of contexts upon use.
@@ -207,7 +207,6 @@ int main(int argc, char **argv)
 
 		iamrestorecon = true;
 		r_opts.recurse = 0;
-		r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
 		r_opts.add_assoc = 0;
 		r_opts.xdev = 0;
 		r_opts.ignore_mounts = 0;
-- 
2.55.0

