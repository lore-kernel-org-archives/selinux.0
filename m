Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F21553A7
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836362; cv=none; b=CSJ64GNYjrg8fGkmzuiTkqaISHVKS+EWZWG/jg2e9WUVArBAkEg4iBTO/NSBfVolqADUBHocfB33Ue0NHwVp8jGO+K44KqS677WGyTtt1UWziXgUEDrwRK5QN0TyZrkM02hAydv+8k5W6bgiITov3wtMbXZJ7tbckoMDFiFLawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836362; c=relaxed/simple;
	bh=IswauXKqcYJPhhfGN1VUx2JAArghAv97CaUJ+GbPNwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R41y6M2uOr9M2JUXi8lJOopqzcWZCthSBWJK+39v/Rnlvnpi3OO6jUw4KcgW2WOU+lLrHeuLOIQq9oPHpIJF3a1kWj5yzJfYw0Q/A7j5fG1MUmzkvUwsk/ELLjtpQxL+8WS79kG0toNRYyzmd6F1QzuzRpfKL24vK6OtAvyZ7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYGyWfMD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYGyWfMD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46769b34cbfso171278361cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836357; x=1736441157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIKct/+Tt8KlsMRbFmx3VYVi1FpFrekyJRfYqe3w3ZQ=;
        b=OYGyWfMDTKRfPICN4x/EWaL9P4eqtmj2VGa37zf2K62z7GwV1HYDS1gSQpcBsXNCQz
         T1wmH+9DSXeiz6ARyTlZTn5FLpqcmweTn0n3lPNSOiFQTCElbpUQYmBnR59ufsU5M6h9
         5QLvKQTsVa1xbeTGIFkRtk6ATSwtsAQ3F6PqjorFmQNQgoeoOV92jnP4QYxIQY3u5Xrv
         RAc/QWF6dRTeLOo41EfD7x4Twn13SHHoqqp+TltJ4px6MH5ZEzkJ1TN5rACoLc8yMVT4
         SO3D2vM9qwOHlIMjfyOaXXbuN3mMFarBXwpSU+9DSjCXL5hm048eMY6X2aY0zThlcCFh
         H4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836357; x=1736441157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIKct/+Tt8KlsMRbFmx3VYVi1FpFrekyJRfYqe3w3ZQ=;
        b=WpW0iLaIZ2Fhu7VV+VI0bH5R24kd6CfU5iPP0sDBTEBnc5E0hWyGw9UGCa4BUBeEHw
         /8Rtjr61yGYDysu+y1dfX/qwz4tVPFDYGlSvWgbnSKF3I9tqujIIJ+WFF+LEaCyRQRPq
         02ypHni4xHkyYjOjmyMU7QfWiWVhSR56/COl3oXPVGZshsHtj4E9+zNhNwS2zWZTgl2s
         5yPozl26aoiVquS0il9GE6iW5i+Dswc+07bN8JxDP6cfrdFGeVmxaFoX42N+rUDDGF7Z
         fd1fb1f9zdhf2M1m36dgljDl6GRMbtL5HQFkglPHuf1JAyZ0uUEXQbFt753ZiWYZCi5c
         4eXw==
X-Gm-Message-State: AOJu0Yxm3DFhrdXVUmR3xilxEbXJGpYxhDLibFNrHKdEKwkXBnJZZnp+
	o6GOesphMWKTTAB2uQD8EV6IIyssJ5SBROSSuE0nUCuvo7FVUljiySK4Yg==
X-Gm-Gg: ASbGncs0PAfk2zmQzfIsaNDpOVh2uLxnFiXrxhMZB2SuOI/PkpY08SkmwutIGBg+q24
	n15utnnv4x/LflNDnQcVarCYjRvH4CskpY5Uq5zSQvDE/3nE572+uZRWxXj4iZvCzJwE/lXJ2eS
	e7kBmhasdKHGmO53lslZwzu7462yXAC5K4RlSsVD/2gFMRvFqwKh7Tvqi3DfWbcgMXjfWtlftjn
	6Fl1OrOY21VaAYaf8R2PE55PXw8kG7Y2n772DjV3bN+1idMoNRo2XtfPhVlNceErIU5yFgsjCZP
	eaID0lRcuqUYslOGwby2bFBpr6PHOcUMNaWf1LZ8UB1C2/5samgWIwZTxL9zFOnlLcYfVg==
X-Google-Smtp-Source: AGHT+IGvTLHNYPaxGV3nGsla9kyu3dU6Zy+eJzxc1EDXEZh0j+m9+GQ/3DiY6BEo1Uk0We+dNeBEQg==
X-Received: by 2002:a05:622a:14cd:b0:467:4802:e6a1 with SMTP id d75a77b69052e-46a4a9a3e94mr752693251cf.48.1735836357168;
        Thu, 02 Jan 2025 08:45:57 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:56 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 32/44] selinux: limit selinux netlink notifications to init namespace
Date: Thu,  2 Jan 2025 11:44:57 -0500
Message-Id: <20250102164509.25606-33-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent modifying the enforcing status or resetting the AVC
in the userspace policy enforcers, do not deliver SELinux netlink
notifications to the init network namespace unless they were
generated by the init SELinux namespace. If you want to receive
SELinux netlink notifications in a non-init SELinux namespace,
then unshare your network namespace too. Otherwise, just map
the SELinux status page (/sys/fs/selinux/status) to check the
enforcing status and to detect policy reloads which is now the
default behavior in libselinux on any kernels that support it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/netlink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 03678a76f4bb..fb55d3ba25f5 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -70,6 +70,17 @@ static void selnl_notify(int msgtype, void *data)
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 
+	/*
+	 * Do not deliver SELinux netlink notifications to the
+	 * init network namespace if they were not generated
+	 * by the init selinux namespace. Unshare network
+	 * namespace if you want to receive them; otherwise,
+	 * just get updates via the SELinux status page.
+	 */
+	if (current_selinux_state != init_selinux_state &&
+	    net_eq(current->nsproxy->net_ns, &init_net))
+		return;
+
 	len = selnl_msglen(msgtype);
 
 	skb = nlmsg_new(len, GFP_USER);
-- 
2.47.1

