Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F413C9D9
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836365; cv=none; b=SLJtESyqgOlcHMRPiA00xuwQgS+AHU7pcDX8zVYqK2D2O9Rgger0YS/g91N+bDSzLj4494PkkOPc69/9jy37DMAXWqtTukcCWIVQc/GzsZpeoshtZ2gx+6sstdDVgNhEaUeAjRTkppjFqcDOdh3afvr/6Fa3sWTeQJx056CdhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836365; c=relaxed/simple;
	bh=cKYt3gLji1Fc+2zfzPlwotrmC+VvsXLzznlnz/PcGIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apMB3wHGj1dA4+EQ9YOydK0T2iCg9i/OTXw44RU0gVQjkhxGLIompvvharnoqFEN5FmMD4dGahLY+5D4wParB9NflIzeuTWes01TMKlaOj3s0+OdOXe1aOE7RzwNx7ZG64uTK++o1RqQ2yEZwlAkrDbEp3gqGWVtIptwsXakhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARlFYmmJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARlFYmmJ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46677ef6920so99878091cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836361; x=1736441161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BC9UDm2mtl2zeQO28MY5z349mz+5z+hSD9ZmfQLetnc=;
        b=ARlFYmmJQsBh/VpB9UexlPrRdSKI4DBp9/MtoQObSGFd0v5KGqb7g3BV7PhD7l58Nf
         lxZRxN/HnR1wz1iIcEt7BON3zQERXTbxCyXW6S8qQXjeEwGRX0iEkgVfucEYhxqY6GbW
         60A+0hE+iH93LxdxaxqPoO1qx/CXv1SobxasheH2XSVpNDIpJLwj7MdjRwW1o0IBScf0
         tAQPnKwNNHAdXtZxWgMF2bLjpL/xXgv6cdA1s0VeXAnfHZcQvX4lkswgMGDuRLfIkPIx
         gdP/mvu3mP3pqU8O1Ffp6nUeZ4QAKdkjK1VooRnTw984SDpid40Bu/HfzCuy4RB6DYJZ
         J4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836361; x=1736441161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BC9UDm2mtl2zeQO28MY5z349mz+5z+hSD9ZmfQLetnc=;
        b=bkGofjDhThKOZWxPuO6hnra8ZqZpQQ98aEmya3E+dmnCnip81YWOJ450/ayZGQ5eRM
         oztwc+UNskfuCh8BKHUL9LIg4PVpjEN7bF8rK5WiZN4sqvw5Uijr5Lja8Cva9IWt5XeV
         u2UrGcRKXwvjpXIsQcFAWPQS8/VnSY/BROkQJQh7wKgR7kVVBsaOFX9goDHatHcde7jx
         9vwBOEe+TL0pywlvvWKf4aHpzXoR7dIBJFvk/v+1rWB+rYjIntM8aYag3Sobp7TGiWGN
         8S9i0d92DK7Hg6lxzOwtfc18TJgV46522sks779NV/n3JXcBkrS8vK2mJwittAHCeKGW
         Pnng==
X-Gm-Message-State: AOJu0YzZLzfQdoRpH1GqbWpgH8LKW1rF+agCAd/PRwaH2HgFHIjrIRFb
	s5hgxLe4nGmDFFjsQ29r+YSZCJUXQH/7fHFjZ91BLwmqBAMso1CZh5wVWQ==
X-Gm-Gg: ASbGncuChyiAptTn/CyvBL0gnk33jiSMgiJbGY7UCa3MalSLzJvgTuKGibNG1cNyc+1
	GIo9Gl+4rp9+EWX27QDpzD0Gh24xgNq4Pu21pADCAbKJ2cXeHMueLsave9OfB4sT7jCEF3HDA8Q
	HEeWHR+EJTcnDCpgVO/f5LgD9kh+YJNINAO8RQHrJBTyhfxIV3rfpQ9nh8kCEXVZ/m9UWFDMQtu
	J5mslS38EMVdGPOx/OaIOxmCqMVEKOQRcXQ4vLRsxxK7zkHe0krlYVAtmoOisCfXgewhies+Wa1
	QfQrKxfEm92ovwpAXNkCdgtUY3yKIUWY1L7ucDi/b2r9lt3xWvF/biczcUiNmUKLKRUfqQ==
X-Google-Smtp-Source: AGHT+IFKbjWtrDG6XZf9TmgjgLGQU/v6rmJ7pwjuEH4bRtZBUk93Bx+/PX7BjHOTC9dcFYsiVbfWvA==
X-Received: by 2002:a05:622a:1984:b0:467:6654:3dda with SMTP id d75a77b69052e-46a3af9ffdfmr923459591cf.12.1735836360848;
        Thu, 02 Jan 2025 08:46:00 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:00 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 38/44] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Thu,  2 Jan 2025 11:45:03 -0500
Message-Id: <20250102164509.25606-39-stephen.smalley.work@gmail.com>
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

Convert nlmsg_sock_has_extended_perms() to use the
cred_has_extended_perms() helper for namespace-aware checking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 68538c74dc99..11d940fb79bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6122,9 +6122,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(current_selinux_state, current_sid(),
-				      sksec->sid, sksec->sclass, perms,
-				      driver, xperm, &ad);
+	return cred_has_extended_perms(current_cred(), sksec->sid,
+				       sksec->sclass, perms, driver, xperm,
+				       &ad);
 }
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.47.1

