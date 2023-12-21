Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280178E68
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HPkHX68i"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78101c35ad4so77011085a.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197569; x=1703802369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv87OroEwvdXCg/dE3E+njIvxSH4FtKwDfJnoVPb35M=;
        b=HPkHX68imQhvSopiIGEZbmthjoEj6CpKhchzTgj7beyLUGAxUoP7EhHauGOrkVt9nz
         Of52IPjoGp1Vf8jaUgdcSEccKX41jCMeJDsYuwU0BFgmUO26ih7l1g62MNPg1MKIKu5z
         Gt6doG6wtULOy8x91EQFJEzkY7d+l8YTjbFn8UIwwS+OKwnde7bejchCwTKhVHnsVHYm
         LUFCdwlKDgt0nscpMTq/igY/xHVuOyGcrTcqezWY/zhHWfOuCzHojR64j12JRfbOFMIJ
         XJcDvH0EsXHgv1XQZK36h0xMwYsDeDqICEM1db0U3zhVLMXNs29GwN1FkuZv2I+JfRoY
         M93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197569; x=1703802369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv87OroEwvdXCg/dE3E+njIvxSH4FtKwDfJnoVPb35M=;
        b=uPTBrehJCZORHdEPgd2FPIX7wHkSOtSI+aVBDHU7T0udfgdl7j9eKWxI0gW47t9q0k
         RDC4Mbms7Dc5XDmp4OEbBbmgufxcThmnfc56uJ0rPC8282KHUKPXTDq+8O9GwM/yDSgN
         kAeh2+/UDGRghTQFOiy9ot6g92S5WaDMn1gZ+4NPAA1f73DJ5NbfOKisre/QaewAD2nW
         qq7dYtqgok9tTCBof2PfVJSi2mIzUzpxyTZyuB5nDvrDoY8ARAtX5Keuc+5EMqLl8kze
         QNofyK1E/bU+byWRzegHe2G4HSHKZkuLC+rkJXYdF3qVD0+N4JHwlloF9BKa/24Qkicn
         xcfQ==
X-Gm-Message-State: AOJu0YwABAKpBqZyZ7w/RjmsPmBk/O+XQYywNFOtzYDFNDXu+rKNdxTG
	30KH7n7COhhLwWknjXRS7rkPu9FQnIOeDEXSPGRa7UtgCw==
X-Google-Smtp-Source: AGHT+IHa2wHi8ZxArIFVrwI6dYfKsaZDPfVpxii3Kqv9AV1E+C89I9WYcs1l0wlq/Uej0CANe7PhQA==
X-Received: by 2002:a05:620a:22e6:b0:781:2a43:d2b0 with SMTP id p6-20020a05620a22e600b007812a43d2b0mr398243qki.123.1703197568914;
        Thu, 21 Dec 2023 14:26:08 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a126700b0077703f31496sm952084qkl.92.2023.12.21.14.26.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:08 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 08/15] selinux: fix style issues in security/selinux/include/netif.h
Date: Thu, 21 Dec 2023 17:18:51 -0500
Message-ID: <20231221222342.334026-25-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=paul@paul-moore.com; h=from:subject; bh=RkxNc4BWjitjeiF8+adeS37asZXmdnqWnznmfGhMplE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtAGwORLbKAI8h/lJS3vd/VjMZ/8XMsidllP dx/th6R+ciJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7QAAKCRDqIPLalzeJ c1SxEACN34xrOtugTolo9SmENd94eZ+xkT/nkhVYxtq6Nb8JvAIC226LBc9xKrnGphG/hRLe8R3 dJHnK1niqK+iLKRHgVK/B88/56JFafNX/pu9NF8vX7oUqwT3hojmLOrZzmgfX0jhXwgo+P2rJcQ l0/l2/QlFa+yLWRrsDw4wpqQX4hWy4Hluk/IQG3NfT7WqCOIJ8eWv4Ip2s0YBnLF81rjgIKFa2x GK/uhc1KI5OznBJHPZGRbFCQvmyPSz+EkdRE20eeJ9173u49Ag25WpxPVilCt9VIoOMkqhJnk0T JIEITl4Ihxhol6NRNbpTXZogNFYPMa+xmEIm/mxQM8C5u6UJGPNMKmSKOwwSQCl5sqQ8AQU5PVQ +AZgN82WzLro40Vt+d8HG5YnT6/osTG3OlnfO8MeteQTvBCt6ViweJmIQTa2DkuHBXPwTIPREXf 2UsoUsIo3Ia2VG615iwy+wdeDX1YsCxk0sLatmSqd+t+9sgkTcS8aCELhvuYGGRQuWtfgX4DKjd Sav1OysWCw0ctRBhYjfA7nlMuYdVyMWLNz2P49s4Q2v26bG1MSKNDLyYLiRYjLPp7VK0ihw98al jgZ6oFg57IXSbwKIfnVQgex9sityhhZWRmtxpHacmv1ZZMtDTyFJhxkb4/ap91GvqwoVcfNaIrx ZQwPJNoCYDI9Waw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/netif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/netif.h b/security/selinux/include/netif.h
index 85ec30d11144..2838bdc170dd 100644
--- a/security/selinux/include/netif.h
+++ b/security/selinux/include/netif.h
@@ -11,6 +11,7 @@
  * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
  *                    Paul Moore <paul@paul-moore.com>
  */
+
 #ifndef _SELINUX_NETIF_H_
 #define _SELINUX_NETIF_H_
 
@@ -20,5 +21,4 @@ void sel_netif_flush(void);
 
 int sel_netif_sid(struct net *ns, int ifindex, u32 *sid);
 
-#endif	/* _SELINUX_NETIF_H_ */
-
+#endif /* _SELINUX_NETIF_H_ */
-- 
2.43.0

