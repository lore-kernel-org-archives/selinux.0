Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C93256C70
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791889; cv=none; b=Cb6H4H5KkpFOvhhwrBTa8rifRiM2AzJdEWOSFc2/IDQlWIzq/h2JoJefSgUPDD0BD6it7ppGUlLLPmZixMxURIvy5W/f8tAitqqcf6t/vDNSfywbUeRvfZkzDVWjgfszYfd3f1Ff8wtEMotPXTglaoPUwoIQ2muW4dlhqkSxj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791889; c=relaxed/simple;
	bh=OdRdv0pQVnhkUIG25Kvvycio5KV8Fn8KggRi29ELb50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dat7NzaPH1s9ovI5qSzAl0fkfrdOIme3PnxOCtQ+1QV7RTTaqZMTd1kX2nVeH2+odZpyNJtQIRjIJzDod3o2LEIlphELCatgKwNvP49sOxcT2ghM5v0JNPHXRb0WX/Ruwcm8UAPbFt19VXd3ICGU7WvZIlOHKhDbxPPXuoOJzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KElFNlXc; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KElFNlXc"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b23b6d9f11so10602385a.3
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764791884; x=1765396684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLz7g1Hvev0wd5FgWpjLejtdOxLw4LNND8SZ8Y1tb2A=;
        b=KElFNlXcVP4TOaddo3OguSj+GZhALuXX90/XCBoqjzVacGTBSSx4M+Ut569boztWYX
         moE91RW1Xzp8/cEFgRSi7QS2ou1tmXeRcB65yIdVqTw/UNWa4taVBcjPQQuDuXhnCPwj
         A9WPft0+kcnE9JeGRl6xZcmELtdSrItNoJDTR6VaQB0R0nKn7cCJLtrq1gSY6RyaUmGt
         RfUr+2tRfkT9+rTuB0jgFJ4DGC2ReYIZ7jTKMkyUz97KTjPhnlrTwR9E+EYSJqs4dKcO
         TTPr07bVIBtaq9FdFR7HkjYTDYg2nveVf9+iP002hXq/9yqZrsKmz7Zi53+iHzK4uUlD
         LxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764791884; x=1765396684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLz7g1Hvev0wd5FgWpjLejtdOxLw4LNND8SZ8Y1tb2A=;
        b=CEs4QJZaMhAiZGDOUfoJYcGDZ4KR6YYEDyv9SXWZB4sFQokBrESfDdjnZcnae8HJwI
         eFYz75sEqUeafZLk0jGlP2F9ewxishJ+6UsHDIk9E5mLlRCL3kXliDDW0YE6FvZJftFs
         6pefkC4kcrixCPq+/92kVzMehSIxmZPWZMTFhsPPk9Aj1ayvzC8O70Yka0kw6I6jHnVG
         bLMmWNMa91l5cvg41DbgldFcvJKCVmPP3jJJKw4rdFJl3LFBv2ssbmnfiy/EmvqXkD0S
         Ay3iAXuqPh4fnWzIDn+xuctQ9nTAa53TsnRj+6OjajgGsxIwEFHbQyZOTxG1FJmwXMmj
         soZw==
X-Forwarded-Encrypted: i=1; AJvYcCX54mZ2+M/RchnoqTrjor4e07HISuuVaB+vKOxX6ibYxOXGp0bvUkvz2Bl16vSZsPOuJeuRztGe@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4eYBEvASy86Q65+/p1WXox7oMcXYYbSGSoTT6OK6OFgPQXTk
	MnwX4Q1WaQ3E1lxj5tGhLiyumcmqbFFNzFqN8dgMCGMUVXl1kG8EaJAr
X-Gm-Gg: ASbGncvQCooP3cltnSeDAm9wl/c5JUf2b+8s4zBlbj9bYrHnbkp1kiC2SEleozWNBHy
	EiOoqleAQLdo59KaPRbFYa4rMTF7Xvgimq8j9pXQ+oSXMFmVXxBGxl6a2+zXaclCZawmEtxVi/J
	ViYWnzrcR2uHdET375RgFHK0S1GBBm1cO8M8e2iHgnZKc1uYXoSBBM7KOgI9JDnckwRVyICS/Bn
	wnxTyOlCi2nJnc64s8iXQuA2l88rGsBsz/S1BUJN0nLsyC3voQPPsPQzOi2kjbf7YX1H099EwV/
	nTEwjeTdipQbLNf0+uJF+EjKYXdxippwIxX0eVrebvSV6EdWll6MPWXzgH8xGaJO3LpPIL2+z+C
	l4yIwhG8qiriJhg5HHRFNxIyqDRDU8zuhNiv5dnaiIhM3OwzphxhnUufUw3x6zX8ZVZ1cU+LzAS
	CMVeFImoYC0h7wtTVI8X4GSDht+oa9jAYRrO46BreEo8k0lTv/eVEQX4whwm1fgsUPTuH9xsKKx
	GO88mccWKLiNf8dVcvZ31t8baXCIknnUvxhFw/0/ZQ=
X-Google-Smtp-Source: AGHT+IH0eqf6jnQMrlilQp3ChN0dB6Skt3Zy7RzjGv+1FbKSTII/e6UJEp2SuUPC8qN+HQVxd9KrMQ==
X-Received: by 2002:a05:620a:2805:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8b5e47cfe30mr525111485a.18.1764791883967;
        Wed, 03 Dec 2025 11:58:03 -0800 (PST)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529a9c030sm1406383685a.21.2025.12.03.11.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:58:03 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: paul@paul-moore.com,
	okorniev@redhat.com,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] nfs: unify security_inode_listsecurity() calls
Date: Wed,  3 Dec 2025 14:57:28 -0500
Message-ID: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
security label") introduced a direct call to
security_inode_listsecurity() in nfs4_listxattr(). However,
nfs4_listxattr() already indirectly called
security_inode_listsecurity() via nfs4_listxattr_nfs4_label() if
CONFIG_NFS_V4_SECURITY_LABEL is enabled and the server has the
NFS_CAP_SECURITY_LABEL capability enabled. This duplication was fixed
by commit 9acb237deff7 ("NFSv4.2: another fix for listxattr") by
making the second call conditional on NFS_CAP_SECURITY_LABEL not being
set by the server. However, the combination of the two changes
effectively makes one call to security_inode_listsecurity() in every
case - which is the desired behavior since getxattr() always returns a
security xattr even if it has to synthesize one. Further, the two
different calls produce different xattr name ordering between
security.* and user.* xattr names. Unify the two separate calls into a
single call and get rid of nfs4_listxattr_nfs4_label() altogether.

Link: https://lore.kernel.org/selinux/CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/nfs/nfs4proc.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 93c6ce04332b..441d4477d789 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8072,33 +8072,12 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 	return -EOPNOTSUPP;
 }
 
-static ssize_t
-nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
-{
-	int len = 0;
-
-	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
-		len = security_inode_listsecurity(inode, list, list_len);
-		if (len >= 0 && list_len && len > list_len)
-			return -ERANGE;
-	}
-	return len;
-}
-
 static const struct xattr_handler nfs4_xattr_nfs4_label_handler = {
 	.prefix = XATTR_SECURITY_PREFIX,
 	.get	= nfs4_xattr_get_nfs4_label,
 	.set	= nfs4_xattr_set_nfs4_label,
 };
 
-#else
-
-static ssize_t
-nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
-{
-	return 0;
-}
-
 #endif
 
 #ifdef CONFIG_NFS_V4_2
@@ -10893,7 +10872,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3, error4 = 0;
+	ssize_t error, error2, error3;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10904,10 +10883,9 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		left -= error;
 	}
 
-	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, left);
+	error2 = security_inode_listsecurity(d_inode(dentry), list, left);
 	if (error2 < 0)
 		return error2;
-
 	if (list) {
 		list += error2;
 		left -= error2;
@@ -10916,18 +10894,8 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
 		return error3;
-	if (list) {
-		list += error3;
-		left -= error3;
-	}
-
-	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_SECURITY_LABEL)) {
-		error4 = security_inode_listsecurity(d_inode(dentry), list, left);
-		if (error4 < 0)
-			return error4;
-	}
 
-	error += error2 + error3 + error4;
+	error += error2 + error3;
 	if (size && error > size)
 		return -ERANGE;
 	return error;
-- 
2.52.0

