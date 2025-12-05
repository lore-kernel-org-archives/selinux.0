Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109A31B100
	for <selinux@vger.kernel.org>; Fri,  5 Dec 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945615; cv=none; b=cZbhAu6dEz1HjulH0tM8kjzg5xvQ/sk6AMXryH57D6utmTyRnXqxKOd7KCf2XgBhhJ7paX7V1yXO6ueOu7GyKCLIzABKE0ZBd2KrydqSDGHDFf6B2lsCmLAnkDKaopms0QYL9iDLA1k1qUtJx/WlaaKXuz33iztlMvv2+mjEXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945615; c=relaxed/simple;
	bh=caddqOopGF9RNpkMCeZAmKxW3gW/SzYZ3cMXOchHQUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coomBz362sndkraeYTIN+TDL2nbXNCg5cDfQnWRvfv7Vu7GTGGM64E1jS/6BLvyHXieF6h47u/zk1Jh16EQnxl9fJangSn9O9lVWJekih3uIkNkL0Ca6aYIV6DWjYwUOjMNjzT6kRrxx30KZyGOMIhpbkseKPTsno75Rrsel1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfpePYf4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfpePYf4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2148ca40eso281096585a.1
        for <selinux@vger.kernel.org>; Fri, 05 Dec 2025 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764945609; x=1765550409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+E0Pq3gHWUBjNMUx6jmJOzUgT3dZeo02EjqgCRV0+Zc=;
        b=mfpePYf43ZCTBl4YDA+x39yEtWJZBbLTlEBaCZzEMKw/GzEEw+trD8wzl+C7tFuVyl
         ngFgy325YtVdbVi5dZXRGlahH+GI8QE8Pjep59/OP5AusUSWFDyvahPplHWOeOlE1+Hn
         ko9VomE+kOb6Z09Hps0n9actt6TgQyHrvzNrgoF9ejkolNI32vFoIoOsJJ693ypIGDCk
         qFlFNfl1en1p0b9UgXGBa2e1OiM7rwE72v3YFpgxv/BlHC8maf80d5vB4DbOZUzwygjS
         k+l975vPwc4e9fspgpmFcurY9ny5Wrxc8lpZ4Ej/z1hdBF3JyWN7G642bR4s0KavdfWA
         oWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764945609; x=1765550409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E0Pq3gHWUBjNMUx6jmJOzUgT3dZeo02EjqgCRV0+Zc=;
        b=G1c6rLUurlskcOkafjvOuaQw54scG7iu0mSy3O9uisKec5Q7QvY3ORWp1yiKeOKFjD
         83uX48RXd2mLsUNVZmsYgK08LM8QXL6PppyoI/gvsukiDUVMRIYgBLr0uYvUKDWy/T+Q
         pgoNK4Hu0DkvHaNN0LNsIMly+QJ0kXjch1Ktx8ROYrvXxTJqVgLScrPcbxrjOL9eMQa1
         bQITPSP284sRJCmwHV8Cl94olo6l55bQDjknB6dPWQnfz/uKtwACc40s36LdVrrKLcOQ
         iQvNEbSVusTKex2XhZIArrUEvUfkBIX1BTfOhN9VSFWFm+ZsFS/4BOQ+/LzLjP4obCdi
         LKQg==
X-Gm-Message-State: AOJu0Yxcb5gl6xwmFa+Hx99yvtHplr9ULR+6ifggTmEYUp+vJ3KZi2u5
	jTjRvLzQe7vNakAjyItL60lSuabnN3zyJKktFggbvevNLXWeGMdTOnRxqHnH8y54
X-Gm-Gg: ASbGncve1uM7my+viLTSxZj8hBk0EEPTmomi/bHb+Z/ZcVYYTPivH+gqJ9s/8HM/DgX
	zmoRnImt74WLWvlHn8cFzs86JFsxTwaztKhaglsmTomVzjWdN5NCCkvg2WYtfvdu3JIuhy1QHFI
	gHNl96RF8YmDdk2MoDsvnAG2hZnHlwB7anRTdO1bumETYmJXV+A7doXs1pg+8GBB2MOVeAD70pP
	AFLiWGJu1GLD7Bv72czpBVV0R0FtQLTsayzcvcuyPCPaMUUowpYpf8n1FclFcVkFKWXqLMOkErv
	8oL1uja0AzB/2sSR6V8MibOkw+knP5nYQDDPxFVrpZpzfZYJmDvc1PYXUxGOlzPcNtKhkvA/CLT
	dJYniMmkLepMyHsmujIBKJEq5M8h3x/O+cFjjMDRdxfPWTLvLTUJm+S6DdLDk7zOmCwz7kzaZZU
	QCLft6E1XYNWqxFhHwPa1lZ0xy9DlAWQivczlV0JJXxoO7IDrQ1gEUA3USkDEZuunLeJnI4I3kW
	WYrXNssR2XGguM=
X-Google-Smtp-Source: AGHT+IGS7jchTgoxNPznunHCuVtxx1hg4RQ7xW9LbZfWyQL4JUvLkEZCtluVJVqnJlGa5QNUjsnhKw==
X-Received: by 2002:ac8:7e8e:0:b0:4ed:5f45:42bc with SMTP id d75a77b69052e-4f0175da770mr139846581cf.19.1764945609430;
        Fri, 05 Dec 2025 06:40:09 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f02b7bd0b4sm24199611cf.22.2025.12.05.06.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:40:09 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH selinuxns] selinux: do not free selinux_fs_info until after kill_litter_super
Date: Fri,  5 Dec 2025 09:23:50 -0500
Message-ID: <20251205142350.6299-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With SELinux namespaces, we can in fact end up freeing this while
the superblock remains accessible and thus we cannot safely free it
until afterward.

Link: https://github.com/SELinuxProject/selinux-kernel/issues/74
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 72a6fa8a91e4..fe3afb5d9616 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -101,20 +101,19 @@ static int selinux_fs_info_create(struct super_block *sb)
 	return 0;
 }
 
-static void selinux_fs_info_free(struct super_block *sb)
+static void selinux_fs_info_free(struct selinux_fs_info *fsi)
 {
-	struct selinux_fs_info *fsi = sb->s_fs_info;
 	unsigned int i;
 
-	if (fsi) {
-		put_selinux_state(fsi->state);
-		for (i = 0; i < fsi->bool_num; i++)
-			kfree(fsi->bool_pending_names[i]);
-		kfree(fsi->bool_pending_names);
-		kfree(fsi->bool_pending_values);
-	}
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	if (!fsi)
+		return;
+
+	put_selinux_state(fsi->state);
+	for (i = 0; i < fsi->bool_num; i++)
+		kfree(fsi->bool_pending_names[i]);
+	kfree(fsi->bool_pending_names);
+	kfree(fsi->bool_pending_values);
+	kfree(fsi);
 }
 
 #define SEL_INITCON_INO_OFFSET		0x01000000
@@ -2416,8 +2415,10 @@ static int sel_init_fs_context(struct fs_context *fc)
 
 static void sel_kill_sb(struct super_block *sb)
 {
-	selinux_fs_info_free(sb);
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
 	kill_litter_super(sb);
+	selinux_fs_info_free(fsi);
 }
 
 static struct file_system_type sel_fs_type = {
-- 
2.51.1

