Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891B61FCE;
	Thu, 14 Aug 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178029; cv=none; b=RjD2nN2UqC/CiW7aueD60RWIrRD4GglJkK1VnCZCWPnhaqvih2UpF/f5eCUkzw5PSIwqba81kDdrin3JOziqxHkDnEIen9YcuqM2j2LU1uJ9BAtlCs94odT8ssg/y5jPmNXtV/5+i2Ee9GkYpTdb2/JouBueaZZFpKec8q4MwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178029; c=relaxed/simple;
	bh=Vex8LuqpGKT5ySxjSC6hPoFFpBKFgPwhpH84IxzLuLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLY44k+rWNIj1S12OneA1TLlrDIGCPNXTQmy9uky+YWoQmAzLG7MD+UavMkF33ZuVha3Rz/zD8C8KTsA0vKlLOljj5WFhlFkH7iq5rTyE7chu6zC68Lma8DtLGEe4CGTLu2yzaUxFP8bpIdBJG7nokYmNTmUgZmdYUK1thlKPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLwcls7n; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLwcls7n"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109ae67fdso12838941cf.1;
        Thu, 14 Aug 2025 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178026; x=1755782826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBewJh7+OurxB9mNfLTTRzHfRsWP2dhYn8lbxjZoIl8=;
        b=gLwcls7nlsdrMF86/6gXOyXj1PMhVznDiLwPMZM04VONpjX1X7VVHlgswZFqXK5caX
         oQ8QuJ0Qes1s0cVeOcXwpe8jVRylyuOkfhcV6pxPlLdrO+29P/0QR/Smyd8RPDVH7MH5
         OK8Va+BMh6PhPERwj54bDirSpdtJv/U6DYfWRkKMnDmWQZKNlShmWTu9sTJ8i981EI7j
         hVd+4DbJ/GpTCduSXBRq1vUFonnoROQyIkRNrIQjqU3PIoMF7wogCp1T882TAbh1gkNv
         QOMoDk9xSgSRhTBym1/TCqoF/wf0TFo2VehVjaat9wlWiBP0W07Gg38W9wM1xjP0xd8l
         6dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178026; x=1755782826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBewJh7+OurxB9mNfLTTRzHfRsWP2dhYn8lbxjZoIl8=;
        b=KSTFcei9d+x5tVwE6bzg0ixBAjdUs+VfouaVGogFxmxf+T6LXula/AhBvy9V50Fqb1
         TucU4JrfUwShUVOGIpmUz/y2kD5BukoLcrKR+hAV350AVttQmDMOq2s2Ejp9IYyeiX0Q
         zQz1D+B2gQdGxIQMuJHAUVp2VjPJXfldYhCXfEFq15cyRCArUSuiIrYbA7TlFkDiw+sW
         ifhqPFk672kRmPSQ8cvrKyCkgU7lyZeZ6Tj64BmJlTgYbgJmN0g7bJIzG6MP8IcnaHh+
         hk7l+ejk8kaA6zGAA+H9IiOOdDqas92UNwa1R44To/H4UICaotTTNmaM0w3eKgn2mMty
         c9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Zz2FHNl+jNGzgR9/vSkE9qe+QkYi57MjlT5GMlgYkS+tnfom1BzEHSdTbvAnnTazOILyiNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvgPSHzkHVZ9IgnDGg/7j5dj3sDqcn6KFKWTiR6vL7EAOrpbP
	VCHGLKYopDfBpmvkR3YfsC/6CYtxPBrPgiipXPWWQrKJUNe8xN7lvvM6GQsIjg==
X-Gm-Gg: ASbGnctZjo16/sThTVrDHaoXkMPC/F/WR4m/KETrkfwMc5nxlucd9LTocL3bcTuQcQB
	jpc7x80T8nkZq8NHALmgoBWczSKmtobnR4EumrJroAvg2A6vw0RULGvslLcTzi1W1pxQszRDV3s
	712rtfm9tLpCU3YBLTThXyXsdzGvwGzq8ssyHtV2bI6fU0bBLgFcbyx4ikcTH1nuAd7CO5nAHkB
	vpk7qzADbJd/kDHBn0F/OrHXLLCK/jEzyLV9FgHJJUMReZzQGyTAqH0PTbFQckpYBE9nJqsMdew
	TqJTrQBhMxPFJO8GjaYvDlKIKwtSBtmBR9nf/zjGMHsW9NEndPldGWI2YUA/k99vRYGLHCtuHvs
	rp7rB91U975wgkHvkEn1aaVnP0Sic2iOMsJ+0iejmNLEi4UVuZcDhEA9BKp285FJ7QqYGc8Yttw
	aR8Tz93veecJK1hN/djVFOjV0b5eRj8huNSO4H
X-Google-Smtp-Source: AGHT+IEK3UxwOCmYT4dwtNGPsED8VYNOnGDSM7CntrnLfkZkbfNSLr7IwkaGJgL1snEb8G0n08MilQ==
X-Received: by 2002:a05:622a:1b13:b0:4b0:ead9:97fa with SMTP id d75a77b69052e-4b10aac09bamr43672191cf.44.1755178026016;
        Thu, 14 Aug 2025 06:27:06 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 03/42] selinux: support multiple selinuxfs instances
Date: Thu, 14 Aug 2025 09:25:54 -0400
Message-ID: <20250814132637.1659-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support multiple selinuxfs instances, one per selinux namespace.

The expected usage would be to unshare the SELinux namespace and
the mount namespace, and then mount a new selinuxfs instance.  The
new instance would then provide an interface for viewing and manipulating
the state of the new SELinux namespace and would not affect the parent
namespace in any manner.

This change by itself should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 221149e95dea..d07d585fa401 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2151,9 +2151,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	return ret;
 }
 
+static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
+{
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
+	return (current_selinux_state == fsi->state);
+}
+
 static int sel_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, sel_fill_super);
+	struct super_block *sb;
+	int err;
+
+	sb = sget_fc(fc, selinuxfs_compare, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		err = sel_fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	fc->root = dget(sb->s_root);
+	return 0;
 }
 
 static const struct fs_context_operations sel_context_ops = {
-- 
2.50.1

