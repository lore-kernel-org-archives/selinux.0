Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345C2E7180;
	Tue, 17 Jun 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169171; cv=none; b=fHsqkpe3UTaYGHExWeo9n58BF+2Ax2PqF3TDmQ4j0/goC+7P6gIRFugGSINFuBAarFzOKuOhpfYH21O6LugAd7IHoaKCQJsIIv7uLPUxJTa+qwth0MJ0hE389qHPSiFF2g5h6AY5MMWS/HNJB9i/1zZPNNsToLb6f2SJhd+eezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169171; c=relaxed/simple;
	bh=Vgdd62kQtHZhUV1xPbHRIBzBOV3HyEzrAFAVC6EVcdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdr2tV6d1wWsmcmeu8CvgntiWvoodpe2hVca95WXWQzTsYahs8J+uu25ufXFqXbRBNr//36Mov7tGRtJDt0Yo+WseFkHMB1DRvFZK54cR3D+Tsu/UZCxDj5dGCWFBVlqOtc1+emfzW6VLD2+PASelHp2GY8qEkcsMCGx1b9xeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS+15SFu; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS+15SFu"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d219896edeso640433585a.1;
        Tue, 17 Jun 2025 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169168; x=1750773968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVnpAGVQ9IOljiZmwmCLJUNC1q/ixoo+OOZwgCeJjgc=;
        b=kS+15SFu2ZLf4DVpb+KWO+wc3MsMn68whuKtX6HKyH5BQqZ+/fYGAla9atMSSDqhc+
         XG7vVdzo5XDPov09M/AmiGsAzXNATQx15bQPe2xcb2mZhpX88h6zRcC2lTUPSW+skqdP
         qwS+t2JSda1S6AyfYoptKwu4EwqXF6tr8SYVXajFhxtpiplnQUFya7S80wdy0ddTvtkR
         laUqB6/EzwEuw3qrg2Ktt7Xc+ogs2CpAMNep2pZFYib7SeDgizTD4ldhrAvQgfVA0xdh
         wzChi5+IQu5CYl73cbVfdTU/troz/JWsBSdY4mCcMW0wAxdp9614PWat1kbVek9P9YDR
         FV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169168; x=1750773968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVnpAGVQ9IOljiZmwmCLJUNC1q/ixoo+OOZwgCeJjgc=;
        b=vPuINFCgniYq+EpZUHlFRzJE/MKVgQdxMxxpRyBu2OVPRxneh7mPmVsuQlPoqqSZvG
         jJ1uvwMHEhmTSFquLMjCtspLcQViTSHf+BFpJxMFLqu9m1wEu7mgyrPEM6Hej2lcgkk1
         9zlJ6HUYDkms2QmII1OnoG4xfRwlBb8OSCErAD7K5rB5i+d2iTqNzCfvlKjNVVs57LyO
         Lugpw7r8H8S65rb3o2710Z0tOz1phS3Et46IAHyP1xz3gEBOudtUYTEkZV8UiUMBLD43
         jHHpfiYIWssxgNH3Ez3PqjSfbLLA3YjAt5Nl/aYfMEyPfHgt9oC4wBK4muFJHekYIWfy
         NrEg==
X-Forwarded-Encrypted: i=1; AJvYcCWkPlnd8zRuM3cFtbHCJnFYs3eLpvjo0ouRCioiqQavEyt1OUcxTtMUizNhS1plsHH6nT9Z8Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6u3kXzStvWLZbtOFHNTAOXSTEWRoi61FQme3kDHQVLreZH14J
	eUS9NfKNZ6lmW5zmWbuumKb6RhedY2egs0wpDnNwExp7ULKQ/0hHIAJoxLlx0Q==
X-Gm-Gg: ASbGncsTT2a8Gp9H5Yd6B6X5G+V8adoX0V2z1oBkOE50V8BKK00giHFFmvsnRRpDj7l
	u1OEqgYC71Cy8MQkz6gba22gXts1T/zujXuGaJzEqF8aMXyt5i5CcSoxFw0s5gfZu8YYzm/vFsJ
	7LwNzVcCteOJJOQKTU4jg+HX4842Fh15szRkcnRyyLpZcs0hiymhPBGEPnEOLjdMZREQbXZj9Nh
	wvymokJ4d6mt8O7+/AAQQJp36msrRn/P9LkI2LgsqHH4LtV9Wun7+lKpD4RynY7VPDU3EgheTqy
	NzECEUfexMDDMt6njTfJOUjvtmA4OhpivZp+7dq4KAyAiC8xkoFlLquXIzocvrH/baVal5rGY6x
	JuHdueRneLSHtCTcu6mjo4Yute128zdK9wsLVVqFoP3BI9dVTyYNhO1rnOxZPxXWBBQ==
X-Google-Smtp-Source: AGHT+IGTgP99j+uqTs5pHjlHnlg0Xu0z4WkpMUKSp1OYPj7J4oObxhZnUk+GDZaOuAvh2heTYkQpBg==
X-Received: by 2002:a05:620a:4414:b0:7d3:b093:b600 with SMTP id af79cd13be357-7d3c6cf5303mr2222533085a.43.1750169168437;
        Tue, 17 Jun 2025 07:06:08 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 03/42] selinux: support multiple selinuxfs instances
Date: Tue, 17 Jun 2025 10:04:50 -0400
Message-ID: <20250617140531.2036-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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

