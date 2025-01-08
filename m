Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF722611
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378164; cv=none; b=f5gOuCYVSqhH/6HL0CEYOLk32cXagAMPxYHQVXX4Vtbg7mnmCua+FB9RSGrOxnf457GHbJYxl7fUKSuaakBV7xppDWpmw5MeXol6VZswLk1tNA3kEXSO8l7M4G3RhJE5ZvVUg4je3P/nkWlOV0wotDWfyAjENoC7DmF74tR0hWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378164; c=relaxed/simple;
	bh=gfDfWMl38l2yw79xJDubgBGnB7ibCSC0VXqc8igoVHo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GeYA6p/JEI2VezqXS8RyiQ79Miaodi3v4BdmWAtpk7J6PfHwjLyDEvbsQaQdgsfDVQfpEzatj6ocBFXfPqbrikh7/ZaDyA6a1Uupa5qXWH8B7/pNG4DUKrCZVCxCRGa5jnypmgmJUwjE42d5sdyIFr4umoDKuv7nmDoaEEjT1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JU+Nmler; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JU+Nmler"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so510953a91.0
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736378162; x=1736982962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+m/zXwQxl417bFotYeyjcgAltt1JmgEl0Q6ZmDX3Dw=;
        b=JU+NmlerZFie+/gF3FqiY7XQZgD0S4BW35GLSXGEAqk6Ica86GjjSebdelwdY9IfNl
         7uPFzy+d3M0ILyBh/NxEzByzK7V7inY+md/Fjz9ifL1WGGmTqhcLiIn5OkQN0hetVxt1
         kxX0qy0YjjkS8HruL/r2+64H2XPUDHJT6Oy0KUvYnlS7XvMdifb1fqyA1OzwLEVqWEf6
         CdIS5W14nI0arWyOup2fQCbd5hdVoIMCsiQRdha0nKKyTukn/DZZKqYS2wX1h1FXablD
         TKr/zMx1VTKD1YaCYxzAfh+dYI7FXOJl/9fd1vjfc8T9+VEBtalharQsujzpWKfLnVG/
         4hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736378162; x=1736982962;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+m/zXwQxl417bFotYeyjcgAltt1JmgEl0Q6ZmDX3Dw=;
        b=twdttMpMe13XaLW6KHBKS8my7seZP163jkHFsUKVvq2gk3VcHMmJ/smRhk7iT9OYtq
         OzZ54akBizmoOgcd6jo92ujxu5u+pHvzkzd1LiR64NQPvfslRsokxwpiwzeQ3/8rPR7k
         Cz8h8v+Uhv8fV7mMrKUjZV0iwWwKug4kRbj0bVhkg7VBRQRSmTkIN9sgJFRSSNQB246Q
         bZ3byDiiD9s1LntXhQt9P/qFK258c+O88rCfr6InTy84XJneFyQaI4AKDYQgIeE/mu50
         yIUdwkzIz9yVYMb2eLUdVs7JNsC7z5AacNTRiIIBJ40g80Rmk4wmpcPOQytSYizgCRsC
         kkTg==
X-Forwarded-Encrypted: i=1; AJvYcCXNqihgxypAogBKfiYarW2rUQk6A9L8rxoVNd+JZcPPX/lHU0MrGiO5uy7quH1DQmRfVd4jme00@vger.kernel.org
X-Gm-Message-State: AOJu0YwZukyvmTCeIfuxY1qnh9CxKh8sSopHxI3cEIcWc77cpwRjwFNj
	yX/sOcChVjBFuEfSXJkAK2YGiSvAvi/mqgqF4vUtf4JHqpqV/H94DOK5mXZXbM1t3YSb1aCwyA=
	=
X-Google-Smtp-Source: AGHT+IEpUDhhYZDlsODaHK+9Oghl8wIcXcCWvkO3ghjIjP9lUGAU8gbpubdD9+v/SfMEG7kQ2cqmYK7CYg==
X-Received: from pjbsi3.prod.google.com ([2002:a17:90b:5283:b0:2ea:6b84:3849])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d88d:b0:2ee:edae:780
 with SMTP id 98e67ed59e1d1-2f548f34ebdmr7300823a91.15.1736378162337; Wed, 08
 Jan 2025 15:16:02 -0800 (PST)
Date: Thu,  9 Jan 2025 10:15:54 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108231554.3634987-1-tweek@google.com>
Subject: [PATCH] selinux: map RTM_DELNSID to nlmsg_write
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, "David S . Miller" <davem@davemloft.net>, 
	selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The mapping for RTM_DELNSID was added in commit 387f989a60db
("selinux/nlmsg: add RTM_GETNSID"). While this message type is not
expected from userspace, other RTM_DEL* types are mapped to the more
restrictive nlmsg_write permission. Move RTM_DELNSID to nlmsg_write in
case the implementation is changed in the future.

Fixes: 387f989a60db ("selinux/nlmsg: add RTM_GETNSID")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 security/selinux/nlmsgtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 3a95986b134f..f97e75301018 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -71,7 +71,7 @@ static const struct nlmsg_perm nlmsg_route_perms[] =3D {
 	{ RTM_DELMDB, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETMDB, NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_NEWNSID, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
-	{ RTM_DELNSID, NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_DELNSID, NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETNSID, NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_NEWSTATS, NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_GETSTATS, NETLINK_ROUTE_SOCKET__NLMSG_READ },
--=20
2.47.1.613.gc27f4b7a9f-goog

