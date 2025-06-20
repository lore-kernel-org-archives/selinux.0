Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8032EAB63;
	Fri, 20 Jun 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441527; cv=none; b=q7b9gQcllcl8WHA5iyg1AQ/bnjGibih67GfNhQ2/H2PVAeztld13PJ/UJ1T0y2wfwfpGNOL+MRbN8/s5BgkhpmNNCl9Vcyl8cLhO4zytsjDJDpmZD5uRwDGOCa1tZnb0i0a4JQt+ykxGsO+OU4WR5lwrt1AUWV/ToLMXn4ekSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441527; c=relaxed/simple;
	bh=hOLC7JyD/qJay8UVSFDQtHKRrOfGXGt5tUCR15SY0Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhYbx9h7pyxjT8f1085ia1NgiNVIYXZrgcodoZin+xtl6bHhq1/YmZBl9xelQytlixDGCwI+8cV4HF99V4/tR3REp4IrIiFTUdkPSydWETAd9fwMCMAsOuc5Dc0Andct+/nqfGAyaLi9uo8qSCZ6R27gbbMQljQJ05yDspaCK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrWeICbR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrWeICbR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fafb6899c2so22690976d6.0;
        Fri, 20 Jun 2025 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441525; x=1751046325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9duPMefwFq9YsgU9sdEfNTtpa9menPP8+W6blYj7yc=;
        b=WrWeICbRfL+PJRYU8zKVmc5MH/NE8cT849g0NNMk4e3hX1922FlBzpH0A4QbIncggT
         7zTFVcuVdYqRnoaqkYSg/RXywmISm4moDnrIsMEor6whU+9OnIehBFHoVrm37OE3ch+8
         WMEKuQIH8qSsMHsnnvAbMLgZtJ/edfD5BuF8hpMBtxatBntnW2nXkfQ8V0D51Y6NuWfl
         UvKDYt2Dez7E5xGsXbeOxvLV2uhMg2ljNsuuSAL37dKEfelmfxFz37gPX9LMXGF1XruV
         WanK2W824KTBBfsDYcxa7ysiJxINQiBV4QFaQaPQe/+vzyOGw+EpJignpVgFSM4C2QNX
         hEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441525; x=1751046325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9duPMefwFq9YsgU9sdEfNTtpa9menPP8+W6blYj7yc=;
        b=cri49p3Q53nJr5oyOgdnimg5lpQIfcLHvtrK8lYVtSSvzbFeY13kYniLFd/Wh7XazQ
         BAFaZ6nbmPQPP09ck3JmXkO+8+YxD8jnYWz3yYbYUrTnnRBy3v85uV/1WmQhQDPbeS+5
         /LPbxH7Gc9hGbLaja0Far5VLNEkPD8C+YnzKig3ohlayn7F0Iu5tx5Qrt25XLsvvAtl3
         DGYYLEW+1k9cABc6CsriXJYxiOq7J3zuE8fKCiG43bcEX4jlZW8b9IBTqATngX+cK+pV
         X+KafkKiXQ/GjaSpbZiDzJ6FigZMjUMuC3NBV9kdAzSMCPUpKxVGxqNW4uAfdERWNigu
         lPfw==
X-Forwarded-Encrypted: i=1; AJvYcCVctkk3ls/eMhzDPzCvQEQXnwMnapWmMYCWRUanLQg/JpArIgevGO/Qxa66F5iZEVg2TK7r+00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj6hQNAVzZXSiqQ1XiUFINTS+M1S1clAqUHIgQK5LPlc+zbjKV
	jSGHundLBudtJofgySApCcXTVw/TTcY/DpVqQnjZ5zdQIsCb6HB5OlE1qIJ6mg==
X-Gm-Gg: ASbGncsvmqEYonuAO6e2mDoyDIpD5F/yJzD9mjiM6mZ2ImvL13MfBv0U/WQgTcRIHHF
	kXS+jzv4pixV2J22Pc4hLjzkm9Xq3nx9uj1LRVKTs3+3XhSxtb3tFGs7ljZnzUPeQrluxEBHgWk
	z/OcWTicnq7wnRvSSMF2r8xZ5YAa5sn4yJhndPMogrA1Yj3ARejQeYnF4jQnfQUg8waD8oUZaY+
	cqquCuGJQnGNpVV1UjAluCYbQXXtzSgF3SaoKQ3z4MfVsPCkl+4mNBFVcyob2I09EoXIz4QETnk
	Eqz2Z0K8dPrFhRTj7VoLnrN+IdvEDAFITwBDZu6Y4pPW3qvQ+Cfm/Gko8k6nHoWACWBS44whdQT
	o2RcraquLlKHbi4sQUpNivJyt51GrZg7aKpSOAE/ISIGQKCf2RgRJcWT1KLQiEdWNkg==
X-Google-Smtp-Source: AGHT+IFRXG0PqEKIvoUDOI0iB2wSShidUcDThZN3koDt0QDIn78q+a3Cbml6ByFHfZXf8x5fDkhBmA==
X-Received: by 2002:a05:6214:4e17:b0:6fa:fc4b:8ea7 with SMTP id 6a1803df08f44-6fd0cb81dfdmr41791676d6.21.1750441524728;
        Fri, 20 Jun 2025 10:45:24 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 06/42] selinux: limit selinux netlink notifications to init namespace
Date: Fri, 20 Jun 2025 13:44:18 -0400
Message-ID: <20250620174502.1838-7-stephen.smalley.work@gmail.com>
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
 security/selinux/hooks.c            |  2 +-
 security/selinux/include/security.h |  1 +
 security/selinux/netlink.c          | 11 +++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97cc7ae8943d..331b464fcec9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state *init_selinux_state;
+struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index fbfe486c91c9..fbbca70ab963 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -134,6 +134,7 @@ get_selinux_state(struct selinux_state *state)
 	return state;
 }
 
+extern struct selinux_state *init_selinux_state;
 extern struct selinux_state *current_selinux_state;
 
 static inline bool selinux_initialized(const struct selinux_state *state)
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
2.49.0

