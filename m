Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0B19539F
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033258; cv=none; b=YQ9+5vYS5yam/U0TAiHVtND/yh9NDWhwhtZ3m/eCcXOOtWS2PudSWw9PBR3rm3/vYbcUeE6RS/K2tGFGr2wr8W3QV9Y4iqy2TU8xAXH9K/vx/GaUpmP1LdmTciv+rZx4VDWHGuZZh5h1LJwPqB4eLWi39xmabifQw5b9S4MNyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033258; c=relaxed/simple;
	bh=PzoC7WHdYgf5DHVZ8SSGSsdh4l3vFCyeSvA3A/1mDb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mykbj1gtenqTIJQOdNt/xhsS9pf9ZY04BieJVc/1dOJC89LeMIhrfZo5d5wLiabkqPYcsY0D8bq+HCKoDn5ng2lI7ehp+3L/qpgy8gThARQCWaTQdh2LqQJ1cMYUA6Ol9iz39GacR5yqYF+7NcFCdX4xlBnhlGjqtnHkcyKgDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXpxkrPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXpxkrPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737033255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IeqAwmPs1Sx+5eZ98zH3rU3YP9boqEEHGEGAkQlsayI=;
	b=dXpxkrPhdnusmBaDRyC6nHEqqJkrI+moyoJFJ3kM2jroehE/CTR22dxeoDfKKi7oqoLlzK
	eOyN1zfUJSyFZmeIg7ABxZjPZEtnqNmfYOec2b4DaVnNirs/2g79stI0Sz/EAsiM5xat7o
	KVWce/DXznvmQLgM95jJE83koOJVt0o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-DUu_V1wNMXSrleQOj5zXZw-1; Thu, 16 Jan 2025 08:14:14 -0500
X-MC-Unique: DUu_V1wNMXSrleQOj5zXZw-1
X-Mimecast-MFC-AGG-ID: DUu_V1wNMXSrleQOj5zXZw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a35a65575so707094f8f.1
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 05:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737033252; x=1737638052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeqAwmPs1Sx+5eZ98zH3rU3YP9boqEEHGEGAkQlsayI=;
        b=UCOkSdy6/iu79bYORcj8HfugbTRIBL5gfhYI+sfDPYJCp5p2rckmvJo06X6MtDRgsf
         QezpCGf3BtCWwlTPME20rbFxWs1PXsODgmP+oGMoe/F26f6IqvNcBoG/QmGoN4Jq+DsL
         zUmCXdgXuRYZ5wTQjAtG1qIC1M2SQaRMqFgTEyv3USWLSSzyEsHCSLdfiq5Am9IDUqTV
         i6HE5Sx3NDDyQEOweCR4ZEvtw8rEXnvqGzOWmWidd4QQhbLaVk572UyShtKAsoGzEqTS
         yEwNB9ogW0Y4Ztp64vfI9CanVIBOHQ5ih5jXHv+KpFiS2oEzefcF6UxRPInCGfAIbCSW
         VFYA==
X-Gm-Message-State: AOJu0Yx/K8TlwsUj2aTKki6Br5AZ4Bajo7eKWS1hbwwPcP4Y965W/QyJ
	gOEpR7jEb/alo/0m2T/pg5zPWjQXjElK2RwfhYpKJE5dJB32EY9pK25GCoomjwQ64sN3GWx5Hi/
	0mI4AfZ7PukwdWhGAiPVA1SSjVxNC6SVcIl8SXtvYGFzvuX1/nSaG116df22Kq/tGvu9X5QH1/D
	z1zBNIh6P8nsK1zoU3a9iUn/0nJkc37Mku0vy29Kc=
X-Gm-Gg: ASbGncsPMQ27LncY5O2S0GhD01lchsva31UGNF9BRqF5Y+2E83y6R866A6ixSkypoXI
	0u/XWxTZsGqDOxskyM9OGuJK+BOwoLkhQ/toesdn1J/MKXyixVH27X1bk3rc2yylt9yHkOkiz1f
	5ZoCGUQg0A/zk9FqIRLj4J77dE7hp+6K988XICo5P/qm5C8pCmgo1yflT5Ddsncv8u8eJNecGKl
	toWdiei8TA9xsVfm/Et0CAaW7X/nLCWRwk+x19DSjBXD+O9XehJ+WJiAflwBNel5WAoEZLsBPsY
	D4p4A5Obnv9QGLw1sw==
X-Received: by 2002:a5d:5f82:0:b0:385:e1a8:e28e with SMTP id ffacd0b85a97d-38a872faed5mr31788700f8f.10.1737033252560;
        Thu, 16 Jan 2025 05:14:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfsgNYoXBVbmI9tH1AqhDKMtFV+l1Vuyk4FYY3DsQ3BSZv5TilVgvAclFp8eGpkMO1oXWZ2g==
X-Received: by 2002:a5d:5f82:0:b0:385:e1a8:e28e with SMTP id ffacd0b85a97d-38a872faed5mr31788668f8f.10.1737033252159;
        Thu, 16 Jan 2025 05:14:12 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38f176sm20831276f8f.63.2025.01.16.05.14.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:14:11 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace] README: fix broken testsuite run status badge
Date: Thu, 16 Jan 2025 14:14:10 +0100
Message-ID: <20250116131410.50853-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workflow name has changed for the testsuite run, so update README.md
accordingly.

Fixes: ee667ed976b5 ("ci: use Testing Farm for running the testsuite")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 765b5626..1e16beea 100644
--- a/README.md
+++ b/README.md
@@ -3,7 +3,7 @@ SELinux Userspace
 
 ![SELinux logo](https://github.com/SELinuxProject.png)
 [![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
-[![Run SELinux testsuite in a virtual machine](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml)
+[![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
 [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
 [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
 
-- 
2.48.0

