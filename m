Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B801917EB;
	Thu, 15 Aug 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710757; cv=none; b=D2iDAMe1P+AcV4vdF+4bfswkXzY3ecwhY382k38IJDKiPuwoh1hWLKEyYRdGx2CheGy960p5RgZ4dmQ7TbroFPvlsD3+xNRl9QtwnWUwZsgbisGhuHvgNpTGkLsSBRM1N70S9vAlWmKgAJAKTVQJybZBB8bqiWokUPpVT3czfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710757; c=relaxed/simple;
	bh=xun1LdYTUWtzLN4cSIGc4hdoJMNrVu5pXHbp3lcyMBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYcRI41FFPS4CI8gbx8Zju9H1acU1FaxYr8vcig51YxPlqYasqF30ZG5exUY30j8HhgsFNKgJOKTu0RIXBqjEkjsYi8KY0AHP9vKc1qU/mUc/WHam/tZMLvMHWNV4GWKypsW2MUrvkasSGgna0GpAGs9V4raiQMdcuWhH1GK86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtkfRjju; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtkfRjju"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso582746a12.2;
        Thu, 15 Aug 2024 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723710755; x=1724315555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pBJi//YHmkr8AxsdwGbk98JC1Itydd98KDeHJ1bJCo=;
        b=TtkfRjjumR8HORkEgnJ/eYsij1ArJfOh9X7o2wB6n+RMeBBPpkbt1DvpvX24aq9/TK
         KTELBqMCxG69K12qQGZcn4A2S41lYNIjyQO0zaztgB5ausf29g+9AmLcjwIOJC7TvBS3
         7A9SSvh2l+EEfP61IkvpzTcVoXaxjSjWuYYEEhQX2ajJThaNmsRV3/tzCbUhUhlZAk6E
         517ppu89IT377t/JoiBe01JLuaF7wCIo/U3iEEXpgACDrJ+IGcCJNMa3S/AUIQcMLIDN
         00R2/6FQKFGWWoWrF0aVY4Sa2C43p+My7YP0vQkuvd3Xh9dVuHCR0WlEZmn7hcM4xgbJ
         IZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723710755; x=1724315555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pBJi//YHmkr8AxsdwGbk98JC1Itydd98KDeHJ1bJCo=;
        b=PX+Th3emp0fv4eCqfT9H+lsAYDKzQ41e7c3V1UiMYeXe6wwl2LSnbDxrOiWlUwk4RK
         f2Ud+vt/P0nHZW3Gc8oWMk++P2ZA+qvIGeEMG6HqIE4J4rNoGDSqQNXZbTLUYg82hecU
         q4DuulNwOsWU/RGcWYx2pW8xsFi6oMmKUdlAGL5zySUbzLuoxfdMxCtt9LRxuzMc/+nc
         SVja119LSaOQwbJPrn6YSRf+RtlQcHP/9vNGPFLkZzutr9tRNf/jS2vLB4Nz+lHNJ4sK
         gu2OcLY++X2mkVxXTXzAsUB9kqUhKNd68MJMHTb6Y2DZE+lYGOOHul8KVDqxxbBDaed9
         FZsg==
X-Forwarded-Encrypted: i=1; AJvYcCWNyG/0ND4QJcXh3l0doKVKYWInRIqPXsTTlR/nWP2jzvHNr76pCXjAMVevH496Eidv6Va0mMdSPHNwQ3ib1uXL97Src970aLXHIP4v
X-Gm-Message-State: AOJu0YzBP3q45ggfxcslosHo6p+Swx1Am+UezmZFyT9ibfmYZZqNk1FL
	MVBwuZRljC6Yf1I85FGuX0ifyS7riabvg0zO96WO9z76mJ8x87zlNc8wrplYoDA=
X-Google-Smtp-Source: AGHT+IFD1hEZXiizLdWNBll/TAZAGXnfLGlz0+6nao9eB1Wq1KPOZWKiI/lstbY81gZHP4DhSQ4Svw==
X-Received: by 2002:a17:90a:e20d:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2d3aaabe1b5mr5942810a91.20.1723710755187;
        Thu, 15 Aug 2024 01:32:35 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3c8637145sm859911a91.10.2024.08.15.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:32:34 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: selinux: support IPPROTO_SMC in socket_type_to_security_class()
Date: Thu, 15 Aug 2024 17:32:29 +0900
Message-Id: <20240815083229.42778-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPPROTO_SMC feature has been added to net/smc. It is now possible to 
create smc sockets in the following way:

  /* create v4 smc sock */
  v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);

  /* create v6 smc sock */
  v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);

Therefore, we need to add code to support IPPROTO_SMC in 
socket_type_to_security_class().

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bfa61e005aac..36f951f0c574 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 				return SECCLASS_TCP_SOCKET;
 			else if (extsockclass && protocol == IPPROTO_SCTP)
 				return SECCLASS_SCTP_SOCKET;
+			else if (extsockclass && protocol == IPPROTO_SMC)
+				return SECCLASS_SMC_SOCKET;
 			else
 				return SECCLASS_RAWIP_SOCKET;
 		case SOCK_DGRAM:
--
