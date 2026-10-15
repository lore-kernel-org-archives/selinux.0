Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519A261B9E
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043152; cv=none; b=r0hFkagNwq2SHkOdgBm/5kL+BuZyvcGftMXakP24M4/5cpnTRsce6FvXImHN/7+Me3yWAOBRiKUqm8KGEUTeJphUgBMm/Omi/Eys4AJ2qv8LLtc3uxKxyzdV4H5y6xo/l6pdSFTQDLjnuhfSX6X8UldLozEI4hZTcDBdiu4cWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043152; c=relaxed/simple;
	bh=ztgCMgfBHAW/LC+LpKPRjRdzsDYhawLtb+caGS8w8NY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoZgm5YEVZyHt8agFyG2F2DuMsBktEla8RDFApS8qc1LkdNqWCYv65rEUR5pCgG3ZrtDD3asTweUPgMYG069KANYZR7/wjo2zbws069bqsksH3bQzGNigGzlO+XJMYKqXYAU1iVVYJKm2H+BaZSikt9k7BAzP5JWw2CnzHyoBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5UDh0dz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5UDh0dz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a02718da81so38640985e9.1
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043149; x=1792647949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlcIzOxUeBOYI+MfhLbkRQgVQFlADMZoRF+UQ6p5JZk=;
        b=a5UDh0dzD34VCvbJqoZESZgEIDE/znY5pLybEfO/7LuKqJlV81KfbqyR8hhIGrXLWu
         kvQPMKQxnqEGMlb/EPPRnpywdSvCFHqS6b66MOMMRjwFz/7TA5sT+tIAUyMNIJttx7Io
         1W9pW2kEaLnUd8DRVuhdT1HYZ/sTWZOlcncOG656loly0r03Bm6d0pMR4NFfyD4iAi7F
         jcAE4ZscbX9Wc2mAuKrT01Ci+mwkccWUZGHxytxyRyaCg61VWElF1uPMYdAJyNyXSVQ7
         7WP6Azed9WFpAN0UmpnVlYJkLNY6FssHylZI2RCpoIp4pzUNQwZNiBEzHBS/qFOS7ITi
         96og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043149; x=1792647949;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IlcIzOxUeBOYI+MfhLbkRQgVQFlADMZoRF+UQ6p5JZk=;
        b=Ao/nneM2ddVW7dGIJRRPNX/T0/R+WLmxv2rE7qN8r7RC8Q+cLeNpHFQXxgrdlY8Gne
         wyaTegWtVKBQEjLq3taIKZY/CkWD6BcS23KFORM2U9z6p661p7aXeXvcvbFk8w8aROBj
         KB1cJX52aK0+HXNrhLlYMq3kXQvqeUBHuiMVscwUCG7WwG1uTnlloXRBpIMG1ezBwpLR
         aGcCoZqx+Itg/iOVIIFhsm+JW/ZULfxWyDBw45X/SwH6tA4fkX9QInyO1Fo5MnyvyQEJ
         MWpnwLj6WKOiAUFOpr4sQcTq8e2RZ8xDIO5bxvuThwckEwm9cLTEtHaLP6RJasUL4ihQ
         ZDcQ==
X-Gm-Message-State: AFq9FYLw5O3Sy7bysjsNuyiqkNNjuOnwq42CluB/pbt8reOM7HX3Qgd4
	KYA/KOwNlI0Jz88yF7e/rvUEUoAqR4EJEIUm90M8qSaQJyS6FNHRK0BcvSSM+g==
X-Gm-Gg: AYBFou29BtpxitCZMyOdr9hYUJniuyC8VpBPf6340/Y2+l0FGQmB8dyUAp0WVz9fxAv
	Z6CIFbxgh7kVR9dtYzVZkRLIiLH/j195a+9qchlVW8Dqgfd9v2CJDuc7koRn8V2+v4oSjqOaUN8
	ACFPqdpCKSHZN5XT/kKVyQWgDuAXUqCK/5rHlOVaaff+zWwJ2HRWuvd+3/D1Uwp8U/n85kL9rdi
	Cxm/4i+aQJ/pRMkxbTviYP0Zl2mF3Qnkm+aecgIRVPPCPE9QX8gPLYG0qG+MKwRFOtufn5PKXNW
	gRw2UTdblXYN5LbqMxXc/CxuXcr7nUvAPXDubdjbNiu//ulHJOfYi6MDSGjfUidqTSwAUG2KMQf
	ro8TolM1Dd1VuXl1ojsODtbimUHolsDCEieCW+BfxvCkjs33RBHIcQwCg0io5oh2t5ab9/9MqfW
	9OW99bmSbQu049+mfrItkrBoWDI+hCl/Fi3X3pH3I3nOXXnagkz3qn4EzJrMEpj4X7akanq2tom
	gJnVwoye/51Vho=
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr375090995e9.9.1792043149578;
        Wed, 14 Oct 2026 22:45:49 -0700 (PDT)
Received: from omos-acer ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm41982805e9.15.2026.10.14.22.45.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:45:48 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 2/5] nfs.sh: work around NFS hangs with nfs-utils 2.9+
Date: Thu, 15 Oct 2026 07:45:32 +0200
Message-ID: <20261015054535.844874-3-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054535.844874-1-omosnacek@gmail.com>
References: <20261015054535.844874-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a bug [1] in nfs-utils 2.9+ that causes nfs-mountd.service to
fail shortly after nfs-server.service is started, leading to a hang on
any attempt to mount an NFS filesystem afterwards. Work around it by
waiting a bit until nfs-mountd.service fails and then starting it again.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tools/nfs.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/nfs.sh b/tools/nfs.sh
index 80eba92..5c5f0d8 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -55,6 +55,9 @@ export NFS_TESTDIR=$TESTDIR
 export NFS_MOUNT=$MOUNT
 #
 systemctl start nfs-server
+# Work around https://bugzilla.redhat.com/show_bug.cgi?id=2547879
+# Remove this line once the bug is fixed.
+sleep 5; systemctl start nfs-mountd
 # Run the testsuite on a labeled NFS mount.
 exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
 mkdir -p /mnt/selinux-testsuite
-- 
2.54.0

