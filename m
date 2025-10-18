Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F3208D0
	for <selinux@vger.kernel.org>; Sat, 18 Oct 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760768877; cv=none; b=JNGZqd9qS1wH7XfGmsf4PhFekrqjcrJLonYsR/7VsP+rKcjWYychc11ynGNFCvYcudbtNpK7oaBCLQfPzfKpLPj8ol2qd9+zxFV4TOafYLWjVPKlOxy3sfvihlYUNGcJqLoDwlkDjT6FXuMQ167Czi/XwkwCJrZvVIEOqdPFEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760768877; c=relaxed/simple;
	bh=GFTYQ+GNYjRlDO/UIvAWB9wvEgWKGDTh2EyvU+4wBeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFn92L5wRBy+d1Cu2W6Inuv7viI7hBuCNxueH9MGFVL9IGFrHxtQETAbD2j3BL39sc+p/I9D1lGccTgmBT/XRXAZ2nMo3E+YjwdFtIHUt9+kNJAHu0zQ6tpROnHkaQfbkmPEhIx9tIjRsb1ctpTbMYLYrld9E7k2hFq4EXMIcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZWdSSMJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZWdSSMJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b48d8deaef9so517394466b.2
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760768874; x=1761373674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBFSFiarpU4A6GRzzftLcvkyLn9RBnccDUAErh1Iez0=;
        b=SZWdSSMJ7x5BlPS6bBLC7NUugbr0pI0t+Yz+pemQgKUclwXx1itqVColwNIenmedK4
         9Bk3BnEmuxx0fueQ9tpWZEbOIpkUT0/CcGZ+kG04VX0QB7q3ASIDmVfoeMYvoZaI876i
         Ti4o1bEjXt433oOorMHEzfDJF9/cpO/xbOHv4rfapkzACFlJYy3GZ6ZdtBXwtx2eRW09
         CSqClbAQSyRSbAFodF/YMloKBMboACmFA/pt6B6xgfPJFRzPANj9FIcGD65jbeF8XfGC
         ilVYKlF6aOC0B2/VmynEtAzv5RDWVw9s2OS6N2NDtGC1KoeSeVgZIMcAgT7K9xWB1cwp
         8Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760768874; x=1761373674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBFSFiarpU4A6GRzzftLcvkyLn9RBnccDUAErh1Iez0=;
        b=Joj+9XDfZ3T7uwwNBAxxv21MctzUsII14sgEq53uMOpS7+4o7P5LDjzQiXdPd4Dcob
         dfJM/tfQD7m7QQju393cNpCUARAIKazDYVf+Chdf+nDYfrTcG1OvFYIJEDVvawYvPxd2
         ru6SqenjGwLuaNdHt+nTgBoqYUZIobfA7o4pt+v+u3aVRfdoZueMelpJugJgsDf473Js
         SDllc3HvKXfIeVkk7pDQ4eIE5iSq04s7iERO8rcnD2kq4TOZJE7b+gEfHh61P5Ty2Yj9
         BMbPQ0hTixvFxyGvyk5EtMhZrCoquZpOsvsNq7Y6xsC4MtXcALxf5kFvzaxpTk5Hiaec
         au1Q==
X-Gm-Message-State: AOJu0Yz4uR/PhXhLIEBq6Q3uKTsCwbZZ6VFTJcCvFH6zK2B9HbPOlzKU
	hvPxGmEIlDWyXRSzEVGI2aWOfOGmarwG8J0fa57jjngnBLBzgM8fyZ3srl7kyA==
X-Gm-Gg: ASbGncuVRfingSRM7Ec0DTd6sH8nU7RSSPMxuRWU+n4kRILoUDJ30NYsWlsjCVjnDYk
	rXtRgVvloFQUCKYeieHH1vy8YJp2+4CsgXQmwA3ifCok5ej1SjYovUBfJu2iPFsDqtk8XofQNNg
	L8lFuLLkNuVKXtJQk0xmjqO/59LHIAdagfaL+I58bJYO3zMPUgKVMRw2pQiCC4SjeZ8lIYhcNZ3
	0IEXHxY4LYcjJatcpZU/iRLfqxMM8nd0BHXJLcEGgoONYPj7N9pq7GVEYAVFqBQrKWqrOVm4jRf
	BFcJ2PbaCErCendgGwCQzcngy5oxJ/uPvijxzG/p1SeYDWWvn3fotcmOIDk4/zn2VC6qriX07xz
	SYCM4SAMlanIDG5ATtlnZmOKHe7x/flP9n6POMJNnuGobWYyFmQhHp56xlaQKaA5JiBaf
X-Google-Smtp-Source: AGHT+IHdW3H50cbw/E04g2I0QBfUC53Bq0bWPHRCdY9M0UCXVEhHCBWCxle/lz9uazhodBXzN08jfA==
X-Received: by 2002:a17:906:f80a:b0:b64:764e:4cc7 with SMTP id a640c23a62f3a-b64764e4d08mr579767666b.61.1760768873450;
        Fri, 17 Oct 2025 23:27:53 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm164539566b.31.2025.10.17.23.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 23:27:53 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] add an editorconfig file
Date: Sat, 18 Oct 2025 07:27:41 +0100
Message-ID: <20251018062741.57106-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

editorconfig is a standardised way to configure editors for a project.
Based off the Linux kernel .editorconfig file.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .editorconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 00000000..2a2282df
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+root = true
+
+[{*.{c,h,mk},Makefile,Makefile.*}]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = tab
+indent_size = 8
+
+[*.py]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = space
+indent_size = 4
-- 
2.51.0

