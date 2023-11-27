Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnY30YMr"
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D451DE
	for <selinux@vger.kernel.org>; Mon, 27 Nov 2023 09:36:07 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id af79cd13be357-77d72aeae3bso193151585a.1
        for <selinux@vger.kernel.org>; Mon, 27 Nov 2023 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701106566; x=1701711366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucMns5Age1llGov9C9MCXiXh9+URXhMwCw3IpXhK5AE=;
        b=OnY30YMruCEtVLeO0GohKfTu34L/0QcnSfS3su3GxNN8EVY8qTAKtcTjIu65x3VYHC
         3h1TxZc8qNwaMVek7oSeXPS40dRCdZlUj8E6zZRm1FE3HgU79E1tyOj1t8nwKyCdn1cq
         pRsb6BCNZnNFxsJc/rSdivylzpPwl2OUgdBQpheo02CfKlhxTml/eew18eBGhLkQwt5s
         qWsRyAkD4JW3h/oeu6LI2xANBAfVBizp9jxrxKUPSvp8+rtRnCsZaalNyCrdz+71C9Sv
         ewW7NP3ajsgcswFqO/msOBQWMRSKThxtZw6gfSH/xUNOrxTqr8qSbV/rs6CORvbNMt2K
         pzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106566; x=1701711366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucMns5Age1llGov9C9MCXiXh9+URXhMwCw3IpXhK5AE=;
        b=Xp7M/IlRJFiUlam0cwOq18ST2Bmyskt+6tovEQ6JmzuaG2s+3tqeNRjeDgEUjf+slO
         uJ5HBTW62AG3yQxJfDTOOWaQ1CwR6yMKiuXLdHbozI1bPnN2xgpJzQJNQ6nyZanqGQap
         7i9sIpaIiwK1QtCEVNTVEKJClm5KXucRTaTDGVrC+Ajo6GVAmsTBtX8gTDlpzvlTUuNh
         MOnuwVT7rPPFZobk26C5Iz0I88IBhm0ZKsVaOoEV6Aj2EVTSkgOFYA0ysbHws23ebZf3
         X1amvOKUTeJz8r8xIZHVwCMR22DToEvU9lp5psHOdH8ZaP1GK4s2kYphC1lUtPFUUtDa
         ER8g==
X-Gm-Message-State: AOJu0Yz8VB+KKybObx1Ze2EoFpT5HcsSnodckA7mfFhHVixewlkI4+lk
	k0coPRUzUMnM3UbgHNGIGr1rKJaR18+fx/tdBpY=
X-Google-Smtp-Source: AGHT+IHNiyImZelUj/S46wUxuomsdtvGOTFuFn/TsYmenRkE0q0+urKVBVZvGXD6nFDfBsX6HsFmlQ==
X-Received: by 2002:ad4:58ed:0:b0:67a:2235:76ad with SMTP id di13-20020ad458ed000000b0067a223576admr6840209qvb.30.1701106566556;
        Mon, 27 Nov 2023 09:36:06 -0800 (PST)
Received: from localhost.localdomain (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id ea14-20020ad458ae000000b0067a33b921cdsm2229346qvb.42.2023.11.27.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:36:05 -0800 (PST)
From: Alan Wandke <alanwandke.linux@gmail.com>
To: selinux@vger.kernel.org
Cc: omosnace@redhat.com,
	stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	Alan Wandke <alanwandke.linux@gmail.com>
Subject: [PATCH testsuite] defconfig: add NF_TABLES dependency for netlink_socket tests to pass
Date: Mon, 27 Nov 2023 17:35:35 +0000
Message-ID: <20231127173534.1080-2-alanwandke.linux@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support the NETFILTER_NETLINK protocol, either NF_TABLES or IP_SET must be enabled.
Neither are strict dependencies in Kconfig. Fix this by enabling NF_TABLES in the defconfig.

Before:
  ./netlinkcreate: socket(AF_NETLINK, SOCK_DGRAM, netfilter/12): Protocol not supported
  not ok 3
  # Test 3 got: "256" (./test at line 25)
  #   Expected: "0"
  #  ./test line 25 is: ok( $result, 0 );

After:
  ok 3

Signed-off-by: Alan Wandke <alanwandke.linux@gmail.com>
---
 defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/defconfig b/defconfig
index 2783c01..47938c1 100644
--- a/defconfig
+++ b/defconfig
@@ -55,6 +55,7 @@ CONFIG_IPV6_GRE=m
 CONFIG_SCSI_ISCSI_ATTRS=m
 CONFIG_NETFILTER_NETLINK=m
 CONFIG_CRYPTO_USER=m
+CONFIG_NF_TABLES=m
 
 # Overlay fs.
 # This is enabled to test overlayfs SELinux integration.
-- 
2.42.0

