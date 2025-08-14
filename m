Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C9309DD0;
	Thu, 14 Aug 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178065; cv=none; b=gEW3MR4w+yflHwz9jd16pb2MzweSen+UpXqNPXhzBeAj/mKay3y0Jbuma24+dZTke2wDyvEt21n38SyImzz5ROnp0R94+sJ4jzE6/OBcMP7Ucta1+KagU+c49Nv52Gq0wrDtLFGOTKqgzstL/K4l+iOV1wZ8jMAY3aSFt3dMKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178065; c=relaxed/simple;
	bh=VnpAXArnuaXbTDu5UXg8qtUNEPRB+JxVqsVZORqvwIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMUrF8sWmu7rMph4XWerulN86aBloCwIONOGkbAk5IDDE1M9lriU3NUBSoz0TXNTYPv6biVQ5DvN4RPxndUdySkM4L1wzqt92sUX7vMAYeV7qzXg0XEOxBwKfzK2ayi/dy4u9153AfS1S5n6wk/wVeROJunP+qwZr//SZx01oIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te4eSDdM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te4eSDdM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109914034so9376161cf.0;
        Thu, 14 Aug 2025 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178062; x=1755782862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=127cErBYQVcc8jII/u6ILJAXHjgkfxygcht5qTx2juI=;
        b=Te4eSDdMo/QS7pkMkfqh4HRZlI973auA7IZoTWZEezF7Arar4cQk7WERc0ueuqeFj3
         rzyjvcbQjv2ZBh4sM8tFhx/9ib5ElQzHZi0ZWaSQMXHgzB+DfxI12f+G+DlWKX3EUTGg
         RhFySipDsv7zz3MAFUpVy88BOv/5XmxwFJtz7HD+t7sIrOmTH5ZnN9fXoOJyi6w0XQGi
         Z8Ui6/2wQ4iUnu4iOT8i1DVj9K2qmAcDFstBfuRosBecqdMrxaAfY8y7Z7dGNQEkYy9h
         OMnQ86v/g4pwSuE10l7S5rhdf9ULdMlkv0Bt6hkgZIvGI71MY/mMdHNo0DwZxDU8b8gE
         w6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178062; x=1755782862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=127cErBYQVcc8jII/u6ILJAXHjgkfxygcht5qTx2juI=;
        b=qHXNqEiU3tIwrlvdiFeJwQ3cu//J1TksiwkL3v04O24tNvWuxlt0Di7Z6jpfNih20c
         ZU9YSdbipIG352Lpshtu/1pYf2amyvqKZUNu6Aqf5/G7WfplXLEbJYidr4YyWTKHMYbv
         +zEmnW8kBs7Rcg4YQNlDyergCWJwiuiBlk46e2KlKgRDcIKqiPhsj0iw6QSFTzdb/dlL
         FWwBluof1v0QQIZlsEntBWFWatjMqckfFzpl9gT5/JnzyhCE5sU2K9Qh03vNSWrOxUZ+
         u2J4G6k2LlNNaP8GsKnHYhUxh/cwM2YEZ8sf1LmGicp1Muz1xC4dyHG06xmvHDZgZDJ8
         w62g==
X-Forwarded-Encrypted: i=1; AJvYcCXBATkulb6CeshmUSIxe57/A1EQDUH2Ta3sa55HrxrQ/IZaw+FcG4Aq17wc9/X2LR2pSZqGlN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NsMz5hwjBuz2hgYopzwp7rbMeUT+GW10+YkflSII4E2b0REk
	z4QploCgMVdmovr928p6LzY9n8rACtNtw1/OIp2igsAeDi1wVKFvoM97JeHvMg==
X-Gm-Gg: ASbGncs+ZK04FaIdkoGLn53d+HP8d6O32jlIOdrfhFGWqx998v4g8x64RVZ/E/JYQKH
	uA0MN9ecTnsOQavsOIPvbdJrYlLm5k1Y/hSWd6TQ7tWSjW8pgKkW6NzQBO4Roi3YA82qCsKTXO9
	J6Vc3KgUmyZKAvJxN3qNmBCcfwQhrScLC0C7khPsBR2/WOjoiMpHUTj7qHy9nLAGJCEgksIrDV9
	gsVCOkE+lPF6EHbYjxrz9pmSRm/khneQgdO6Y4NyiNH0Ku+o0SJb7fsoH6c1er7J4bk3vdwUz2B
	5dmVwGV7FpPo+PTDGHBcdWc3RSN8IwEtiCQRGXz6tx+982U1fHqLtdbLdlGoy6ZUk0WsMtF9Mi+
	sgEoUCQEjlpDpFr6bZP/QYhBGU+O2b7IGVJZbjx3tU5D7AmlHW5SzIlk+66ZPfOPkAMbz3uIXKM
	UtlRE+5kjElFSWaFgXCOYThrk8kg==
X-Google-Smtp-Source: AGHT+IHnqGrOswl/II5XoLgH2Tl2ks39iWCeA3xu523DRXIJgurmF1WDEfd8RcEOieI1+QvwBnUPkA==
X-Received: by 2002:ac8:590b:0:b0:4b0:7e22:36bd with SMTP id d75a77b69052e-4b10a97a743mr43372961cf.23.1755178062083;
        Thu, 14 Aug 2025 06:27:42 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 41/42] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Thu, 14 Aug 2025 09:26:32 -0400
Message-ID: <20250814132637.1659-42-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index b22dbb4a1a05..369e375bd9c6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6297,9 +6297,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(current_selinux_state, current_sid(),
-				      sksec->sid, sksec->sclass, perms,
-				      driver, AVC_EXT_NLMSG, xperm, &ad);
+	return cred_has_extended_perms(current_cred(), sksec->sid,
+				       sksec->sclass, perms, driver,
+				       AVC_EXT_NLMSG, xperm, &ad);
 }
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.50.1

