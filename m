Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255313B2D0A
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020444; cv=none; b=pSCvb+t0XtwM5Ic6JQ56/Kq/9OT7SYLVgAtyrK4QkdNBBAs91zzmUhlaGqUUIay4CfeYuDNGMYd1XWALCH3X0dMBy9VDCfCMqHq/0tpDiz7WMhrxrQ4Q+ZasaoWXHHUxEEPhxIp3RYAWIxRoWmlH3Wg8L+vMiDDahh29UA+BlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020444; c=relaxed/simple;
	bh=+p8wbgO2gxmNS6uyxmp646HFRAtBLqjxQV/920PW0P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhVpNqMTvpi5dCHIxtjr7b+sakxR0ZboUzhHncKjGKWIzP4kv7HPeM7b+m1Cy0VvltkqZcoFzZBFfQXbuUlZ5CH4EAQspA1I3ZGeE6eNYBQmXWjyUO/gp2wFJNJTlYoX3AwhwT6ZFYcDpHBn6PAsz3GQtqO/JpcQ2PewJubkafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Tyf9Ds; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Tyf9Ds"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530e2f50d01so40736891cf.0
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020440; x=1790625240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/bnxgUL2AjfrK7y/aaZwJd9DyupgVWA27N4eYkYAeQ=;
        b=A8Tyf9DsAmmkz7hkVqU8GUlYfanofCyoJyMRk9vCZhlvksA9pxYP9/Nvu7SQByxoza
         UHl7PWD966oMcJptRAsz5GdEFPBY8/pnDkPvYnmzHPHSKasP3dUWLgTaFWrUOc4EtUb1
         z/TN9cWsBVbneDh/g22K/MhcFoD0Zb35FxIIr2k9cIvCln4LgPAHEAh8M/5jAzmbfNN9
         e/u3MTedIQVQ4v6ZcLMaT7AjnBwG7y0ffh2u66kggtEOxFE4zKqsj09UshYvukeirqjQ
         Atm904XK7bYjjr0mAlGMqBL3a9fYDEahHB37eLgFu4sTg750ZAyWAjhGS1TfGBakzn5/
         MGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020440; x=1790625240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/bnxgUL2AjfrK7y/aaZwJd9DyupgVWA27N4eYkYAeQ=;
        b=azYtj8Ndm16AoWBECb7eCaFjQSs1zj434/FdwLt5E+VVBe9+o7c9x7Vk4upUu1rr1j
         Za4LtZ4d+BIzCbuwKm2QsOzIGt30mLmEgUUIFS1puNOEcpRnWydYTYcvB+kcRRoaWVKo
         KDL7qQMr85HsZ/uRyRNkRBBRjd2W/V3D2d5uq4O3HwAZpHVhnxxT2ZdnZ1XXPhMLeNkV
         ZMGCNFnyyCpxr5hE7pPa/P748eVU8wy3ai8KYyPuWDXDJjtHcnyX/HSEfuysfQ3n2RvE
         m5gjYvMuoPA9x7GUCMm3waEBq9iBwmn1cPcDjThUfzIa4DBrb0i5fAnG+ZAyB9+B8omA
         5qCA==
X-Gm-Message-State: AFuF++l9uAGQiGxviWBlzI1MCTX1Ka4gj15Pv29jHVNHoWOri3slX8gy
	DkGK9NTIPSOquEZbji/OyCjdLjr4RQameRktc4am90bAfazeNTVOjEQcvV6b2w==
X-Gm-Gg: AYBFou2QRRAEP3ljje3YnzM31gUmHH+3SluJtnuM5kB4vyHyKVWReudcTRzFSYXWynn
	mVOXyOPyfTMp3jqwtdfFhubuM1F7YyRE2lCUS9NxQY39U7x5AQkTdnlP0EbO92NF9ylame9rHfe
	qtx+dZ6cvAAza/x5gmabnEYuwZbtoMdwvtwGAEPLFphMuPweT18bCJYVXi2nTJJFKiQWhy4rZ6+
	vfzWP3HMqil3CSXY2Og+BhCvKB7udF08Z0Z61weBDzWU8m3i7GXi61IWRnjD+6PT62C5bKvAPvq
	nk8fO76BwKnzytQ+gYspH0qoUFqDziVX65lSbHkEP1uXDo/avlpjP0mjSBCqtGO0O/6laq4emXV
	eNtfxY+tjGkMCiKLASIlmA4oS+r4D0+1DUgl8/9Xbd98e4LdbqrVxFjl5EQpytVHzG7crg9pdNT
	rxBLptdqdEjFS1hj9bNalD9MKDGbW3x0P3A+ul3s9Ua+vJ5sJkeMsZDd7INnQyxcagzXENJihJU
	GTwjiP5XtiUPsQHNnmjFx8fjhtgIZYdO6QUu3s11eAf8jkPmjJPK40ekYpsOWkk1aZr0tQvc7X2
	V95GMD2MpA==
X-Received: by 2002:a05:622a:311:b0:532:c161:b968 with SMTP id d75a77b69052e-532d8d25d62mr24029951cf.1.1790020440355;
        Mon, 21 Sep 2026 12:54:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a8a0c0sm74709906d6.36.2026.09.21.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:54:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/5] secilc: drop stale integration.cil test, exercise bounds in policy.cil
Date: Mon, 21 Sep 2026 15:53:40 -0400
Message-ID: <20260921195341.25227-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
References: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

secilc/tests/integration.cil predates the current CIL syntax (two-arg
sensitivityalias/categoryalias/typealias, dominance, categoryrange,
permissionset, nametypetransition, two-arg filecon, no classorder or
sidorder) and has not been compilable for years. It is not wired into
"make test" so this went unnoticed. Every construct it exercised is
already covered by policy.cil except for the three bounds statements,
so remove the file and add typebounds/rolebounds/userbounds to
policy.cil instead. The chosen (parent, child) pairs have empty or
identical role/type/rule stes so the bounds checks that secilc runs
alongside neverallow checking do not fail.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 secilc/test/integration.cil | 224 ------------------------------------
 secilc/test/policy.cil      |   3 +
 2 files changed, 3 insertions(+), 224 deletions(-)
 delete mode 100644 secilc/test/integration.cil

diff --git a/secilc/test/integration.cil b/secilc/test/integration.cil
deleted file mode 100644
index 69c9ffd0..00000000
--- a/secilc/test/integration.cil
+++ /dev/null
@@ -1,224 +0,0 @@
-(type bin_t)
-(type kernel_t)
-(type security_t)
-(type unlabeled_t)
-
-(policycap open_perms)
-(sensitivity s0)
-(sensitivity s1)
-(sensitivityalias s0 sens0)
-(dominance (s0 s1))
-
-(category c0)
-(category c1)
-(category c2)
-(categoryalias c0 cat0)
-(categoryset cats01 (c0 c1))
-(categoryorder (c0 c1 c2))
-(categoryrange catrng02 (c0 c2))
-
-(sensitivitycategory s0 (catrng02))
-(sensitivitycategory s1 cats01)
-(sensitivitycategory s1 (c2))
-
-(level low (s0 (c0)))
-(level high (s1 (c0 c1)))
-(levelrange low_high (low high))
-
-(permissionset file_perms (execute_no_trans entrypoint execmod open
-				audit_access))
-(class file (execute_no_trans entrypoint execmod open audit_access))
-(class process (open))
-(common file (ioctl read write create getattr setattr lock relabelfrom
-		relabelto append unlink link rename execute swapon
-		quotaon mounton))
-(classcommon file file)
-
-(classpermissionset file_rw (file (read write getattr setattr lock append)))
-
-(class char (foo transition))
-(classcommon char file)
-
-(classpermissionset char_w (char (write setattr)))
-
-(classmap files (read))
-(classmapping files read
-	(file (open read getattr))
-	char_w)
-
-(type auditadm_t)
-(type console_t)
-(type console_device_t)
-(type user_tty_device_t)		
-(type device_t)
-(type getty_t)
-(type exec_t)
-
-(allow console_t console_device_t file_rw)
-(allow console_t console_device_t (files (read)))
-
-(boolean secure_mode false)
-(boolean console_login true)
-
-
-(sid kernel)
-(sid security)
-(sid unlabeled)
-	
-(typeattribute exec_type)
-(typeattribute foo_type)
-(typeattribute bar_type)
-(typeattribute baz_type)
-(typeattributeset exec_type (or bin_t kernel_t))
-(typeattributeset foo_type (and exec_type kernel_t))
-(typeattributeset bar_type (xor exec_type foo_type))
-(typeattributeset baz_type (not bin_t))
-(typealias bin_t sbin_t)
-(typepermissive device_t)
-(typeneveraudit device_t)
-(typebounds device_t bin_t)
-(typemember device_t bin_t file exec_t)
-(typetransition device_t console_t file console_device_t)
-
-(rangetransition device_t console_t file low_high)
-
-(nametypetransition some_file device_t console_t file getty_t)
-
-(allow foo_type self (file (execute)))
-(allow bin_t device_t (file (execute)))
-		
-(booleanif secure_mode
-	(true
-		(auditallow device_t exec_t (file (read write)))
-	)
-)
-
-(booleanif console_login
-	(true
-		(typechange auditadm_t console_device_t file user_tty_device_t)
-		(allow getty_t console_device_t (file (getattr open read write append)))
-	)
-	(false
-		(dontaudit getty_t console_device_t (file (getattr open read write append)))
-	)
-)
-
-(booleanif (not (xor (eq secure_mode console_login) 
-			(and (or secure_mode console_login) secure_mode ) ) )
-	(true
-		(allow bin_t exec_t (file (execute)))
-	)
-)
-
-(tunable allow_execfile true)
-(tunable allow_userexec false)
-
-(tunableif (not (xor (eq allow_execfile allow_userexec)
-			(and (or allow_execfile allow_userexec)
-				(and allow_execfile allow_userexec) ) ) )
-	(true
-		(allow bin_t exec_t (file (execute)))
-	)
-)
-
-(optional allow_rules 
-	(allow user_t exec_t (bins (execute)))
-)
-
-(dontaudit device_t auditadm_t (file (read)))
-(auditallow device_t auditadm_t (file (open)))
-
-(user system_u)
-(user user_u)
-(userprefix user_u user)
-(userprefix system_u user)
-
-(selinuxuser name user_u low_high)
-(selinuxuserdefault user_u low_high)
-
-(role system_r)
-(role user_r)
-
-(roletype system_r bin_t)
-(roletype system_r kernel_t)
-(roletype system_r security_t)
-(roletype system_r unlabeled_t)
-(roleallow system_r user_r)
-(rolebounds system_r user_r)
-(roletransition system_r bin_t process user_r)
-
-(userrole system_u system_r)
-(userlevel system_u low)
-(userrange system_u low_high)
-(userbounds system_u user_u)
-(userrole user_u user_r)
-(userlevel user_u low)
-(userrange user_u (low low))
-
-(sidcontext kernel (system_u system_r kernel_t (low high)))
-(sidcontext security (system_u system_r security_t (low high)))
-(sidcontext unlabeled (system_u system_r unlabeled_t (low high)))
-
-(context system_u_bin_t_l2h (system_u system_r bin_t (low high)))
-
-(ipaddr ip_v4 192.25.35.200)
-(ipaddr netmask 192.168.1.1)
-(ipaddr ip_v6 2001:0DB8:AC10:FE01::)
-(ipaddr netmask_v6 2001:0DE0:DA88:2222::)
-
-(filecon "/usr/bin/" "foo" file system_u_bin_t_l2h)
-(filecon "/usr/bin/" "bar" file ())
-(filecon "/usr/bin/" "baz" any ())
-(nodecon ip_v4 netmask system_u_bin_t_l2h)
-(nodecon ip_v6 netmask_v6 system_u_bin_t_l2h)
-(portcon udp 25 system_u_bin_t_l2h)
-(portcon tcp 22 system_u_bin_t_l2h)
-(genfscon - "/usr/bin" system_u_bin_t_l2h)
-(netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) ;different contexts?
-(fsuse xattr ext3 system_u_bin_t_l2h)
-
-; XEN
-(pirqcon 256 system_u_bin_t_l2h)
-(iomemcon (0 255) system_u_bin_t_l2h)
-(ioportcon (22 22) system_u_bin_t_l2h)
-(pcidevicecon 345 system_u_bin_t_l2h)
-
-(constrain (files (read)) (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
-(constrain char_w (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
-
-(constrain (file (read)) (or (and (eq t1 exec_t) (neq t2 bin_t) ) (eq u1 u2) ) )
-(constrain (file (open)) (dom r1 r2))
-(constrain (file (open)) (domby r1 r2))
-(constrain (file (open)) (incomp r1 r2))
-
-(validatetrans file (eq t1 exec_t))
-
-(mlsconstrain (file (open)) (not (or (and (eq l1 l2) (eq u1 u2)) (eq r1 r2))))
-(mlsconstrain (file (open)) (or (and (eq l1 l2) (eq u1 u2)) (neq r1 r2)))
-(mlsconstrain (file (open)) (dom h1 l2))
-(mlsconstrain (file (open)) (domby l1 h2))
-(mlsconstrain (file (open)) (incomp l1 l2))
-
-(mlsvalidatetrans file (domby l1 h2))
-
-(macro all ((type x))
-	(allow x bin_t (file (execute)))
-)
-(call all (bin_t))
-
-(type a_t)
-(type b_t)
-(boolean b1 false)
-(tunable tun1 true)
-(macro m ((boolean b))
-	(tunableif tun1
-		(true
-			(allow a_t b_t (file (write))))
-		(false
-			(allow a_t b_t (file (execute)))))
-	(booleanif b
-		(true
-			(allow a_t b_t (file (read))))))
-
-(call m (b1))
-
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index e3b07fc8..c9e306f6 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -130,6 +130,7 @@
 	(typealiasactual sbin_t bin_t)
 	(typepermissive device_t)
 	(typeneveraudit device_t)
+	(typebounds exec_t bad_t)
 	(typemember device_t bin_t file exec_t)
 	(typemember exec_type self file exec_t)
 	(typetransition device_t console_t files console_device_t)
@@ -232,6 +233,7 @@
 	(roletype exec_role bin_t)
 	(roletype exec_role exec_type)
 	(roleallow system_r user_r)
+	(rolebounds system_r baz_r)
 	(roletransition system_r bin_t file user_r)
 
 	(userrole foo_u foo_role)
@@ -251,6 +253,7 @@
 	(userrange u5 low_high)
 	(userrange u6 low_high)
 	(userattributeset ua4 (u5 u6))
+	(userbounds u5 u6)
 	(userrole ua4 foo_role_a)
 
 	(userrange foo_u low_high)
-- 
2.55.0

