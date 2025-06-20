Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495721FAC34;
	Fri, 20 Jun 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441523; cv=none; b=QpM/esbtibl+7CcisFMPblHZBv2zsuqKcMM1yRaSogKZbTgkJE98KCnoev0vjZ062lznZ99dobqN3tkP+rddsNUXO1NJBfvItnf0mF1M7J3RlASzZkBtM9/BaLIn5Rkab5TLyybo+HFUCOfEAq1RHp9d5Cxiq7a9M7liQnLyqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441523; c=relaxed/simple;
	bh=Vgdd62kQtHZhUV1xPbHRIBzBOV3HyEzrAFAVC6EVcdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfzAZLk8T6yhCuq/F77ngdjN+oTrWyZJc+z+l2+FWbCFb8KAIBrAi9olZ6oXO38+mmmhSrdUa+P4JIdV+bxo6FKWxoYVggCr/vzhS5xcXZTyFNeArkA9kroINWUTr+xRqxiEHRMiBus4bntZ9cIgWCI9cfoKIsZ5p9b3KbdPxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnVUaxmK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnVUaxmK"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecf99dd567so26005886d6.0;
        Fri, 20 Jun 2025 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441521; x=1751046321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVnpAGVQ9IOljiZmwmCLJUNC1q/ixoo+OOZwgCeJjgc=;
        b=hnVUaxmKttr7CUD7XFGq0jUFk7cgFbHyc/HGb6WIG4flGYsmaRGoouY/SwUmj6m0u4
         plP7GPKqyvIGKf4TDavNBYWpPLHrgLL03jErINQdCD4rDnZkgScAdXSE7NQIf1JmZGww
         uPPgWyH6QeBZbUAsjiX6j0VLNoTBJkbXL3aYa9moBpyo6yESXPYb901xMy5mtC2H5Td5
         JC/ehxjF3nSLrDvMaLxWnbbGe/CgQYT8Gt29Lw5JJNvm2ewkoiAB/b5XPKPfyhLkIb2d
         T/Kh8lNUbdzX+UZCa/neBopb0pg22QkZR9UahyvoZD1D7A2o6h9KaFkjrBeIswUI3XIz
         fxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441521; x=1751046321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVnpAGVQ9IOljiZmwmCLJUNC1q/ixoo+OOZwgCeJjgc=;
        b=mhrK5bd+gPk1Aze0ilMhmw7+svNXm4VLElxF+2ghIhCH9liexEqP3zLld86X1u1utD
         6WtKE/NthXzKMee374Cx4N8Q3fpP42SjPIahmWK8mKDPhLPGJEOdoUsqvUDn7pFIDqyt
         8B9g7uRUDv5FsDi3Nj5FFaKMrZ/CfPjO8kHFq9Ttl8iypoCQe6Dq1KmccGYRidPPtoTA
         6nDECQaB1OJRL0bJeN0zP0+YpphL59L1j/8+x7A7/mH+x64F5XXHmm9daWsAZQSIVTxi
         5/1eVYpS6UDWraqZCW82ZI2ADYCnK5GWIeyGaAqO5Cu0N16VuJyTbLujs67Ev5OPIr7H
         H5EA==
X-Forwarded-Encrypted: i=1; AJvYcCUlMFWhrRzT2pw3A5+iAkIliVnXQUgzSOo3Ro9Br9XmtwK66esUj0jirbQTJCJ3BrPAgINVyTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykq/PGaVN0OdN9hRl6DYGH9NEX9zJUXlDSwE3k2yKpGthle6KD
	mKmHYOzSN3s2EETYlx+WwizmkhREW7e1qjquZ10mezz5UwTMPkVthauwOEBsKw==
X-Gm-Gg: ASbGncuYRdNhPcNNYpJdSySVucZ9l0nrMXjG5ub6wcW5+T9ming6wG0yMfZJoa3cgh9
	RsGmSl17DdblYBPudi6SDndzAoCRCLMc+uaXW8BtxfN1ppuwi3eEiPM2gOhwqZtUe0v2SHIzuWP
	0j9D45H2Fzgrh7A2Qg6AnGgeJ9+38xgGzZVRMtcJDTAuBaGI7D7KgHkU1WmFWqGSjtVVw6MHDiT
	Ofb9V2yRdt5UXm88vdfmCSowWZNGILTqfp+0Omoa28P5RSjEBZPMAokoJZ6EIos19v8zE5xSEvZ
	PDfiwbdcibL7c6ncNe+5bMxcdEMQy7Z6gxX3JwLXk2cY07qPjgtN77tOD8lWHw+X1J4BWxtc8aO
	l17uRd8RyGRQvLyH5yX5SrNgmLjvd/ukKEso1B0TazLJUTISyxNfn2F3HkhPtpj4iNscdl+maSz
	Jn
X-Google-Smtp-Source: AGHT+IFUZXBJOhtuHB+lNmtJtnljHjJ12rlhHsRRRG57EXVl+qZfmRPjYqY/SaNcef5q570Nv3EykQ==
X-Received: by 2002:a05:6214:5b08:b0:6fb:14:5e89 with SMTP id 6a1803df08f44-6fd0a4de11bmr75685746d6.19.1750441520916;
        Fri, 20 Jun 2025 10:45:20 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 03/42] selinux: support multiple selinuxfs instances
Date: Fri, 20 Jun 2025 13:44:15 -0400
Message-ID: <20250620174502.1838-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 8340a53c6171..fd03ceb6c8de 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2153,9 +2153,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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
2.49.0

