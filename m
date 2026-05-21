Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62B3F5BDA
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370854; cv=none; b=nSvw432UIsyTyTBAYMqYzc1iNi2p8cmSFac6+ICBPAUuRehXIqDlH6FhMAnKJbcmt4i2L/BtPwhYVGbwhsvhPpOrEXZkJSWZJRBOtHM4PBzAf7CqUKBxK5m3CETnIbZDVQ6tNus33M/tSt9kO6m7ENfDEhxEovJMc0X4VpAkzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370854; c=relaxed/simple;
	bh=vFJYXv/fPdHRdo0K9F/qG+g6yfX92bF4b9JrPeuG6TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8IuhskuqcI8tTdy+TGGkS7I/e0zaHl/eiGa3I0wlWUAahBeBAnXuGmUnb4Mct/rIVOjLYdtlDe8mWJxIodS6aDJ27bMjQE/hu3GIRFmUIvbOupXqfGNSZkRh2IirGR1Z0IL4bMX7o1ltUyD4vBlm6gmN+v+s0jtjWVEoEWFkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD7Qv7Y5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD7Qv7Y5"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so111353936d6.2
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779370852; x=1779975652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2gkfGneT/Im7rGJ+clsda8iq1AihFqVE4NAnePUI+M=;
        b=PD7Qv7Y5vozvKE/W/Ky/4/w1yziofoBubKTIlgzvu0hU3ApmiiZzbXnXifhmEhSWxA
         4q/auZWuPprtjpDQmYuepsQSfh9/oQsDhNTHfIPoPVRHJmkhWXbl7PMqtwJv2hzrLxO9
         yLKD1JiQNiVHaRc55TY6NqcGmb18OVm+RcfEv/shrbNEWEd43igkKS5/T//wUbpVlrky
         nCnRrfbIOb5dl/SkVvRWlA7dSFxyw66LBU/qpXLxS2PkeCT5Rky+QTHFNcHYv0D4lUYk
         DYZIJdL7cOqI63BdagU7cS2JDgDJNAu5FugYGMFRkDbvTOJPgTJl38DwNTetJ8hs0j4p
         eiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370852; x=1779975652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2gkfGneT/Im7rGJ+clsda8iq1AihFqVE4NAnePUI+M=;
        b=RIzPs9ujto5dWjIE7nw5iDftMcN2Dbbshe/v1EyxDI7Z8xJdETnZIi06qhrHmWwjrb
         hedKWuM6be3/cQyoycwTgpf9oM1aBq2WSb/gIi9lP1QBHSJDVHipDxceNNSSSdmZEB0h
         TwUb7scvyx5xOGiKtMU59h+hnCr8JRSFnHvtZ+pUK8KpLKDsSAnZuCWMGS3MVkGt94K7
         dusKDW1frZqkxelWhek4YLY7vaiVSbABDW6U2Ull+iGiLdkWhBlF8FRcyyGHBWLuAc4/
         3ScJhUg/d+rU/9kh0hLcXHnhFyBXRCKFPru8qXeJUSykxjfXqnUmYzuA4YZ4GPbuS0db
         1I5Q==
X-Gm-Message-State: AOJu0YwcakauwR6A+d2VQMuSWk4Q9VUg9cxei30bLeWwCVBfTxdB6tfj
	kNKNGFPbYwzCQzZPopvXd29PP1KD+p7d4wULQtXFbKslgNwq6hVqRwM0sWVcig==
X-Gm-Gg: Acq92OEjOgcpD2379oQxY4mSqZLNgptVlf/Nly4UgDn3kHylB+RBgy+YYQqOektJlFG
	nPZ4rqUfjHzyBndUqJRAjhLVWGQicfwzbOU4Jb9N7uNLmm/vZD37hOtDQX91Z+YLVgRB+uIoFqA
	fWZSTkPVvrt6bc5+K2FHmMmFsFbxcG/93w6+ydNBBCTxNmGKo7sByDcD3QdAyBD4NAXMb5UhZdj
	vxaoZ0pg/O1LX1W3u6YsRFWK2vL4n6gO0PU72Glxeeuu2XqzJbUbrXc5DUOKPO+X6W8prbPWwtC
	7xCWBaHrU5G0TEn1rAmSbFA/YHasX7honQFb8igQUol0n/c+GrhF9vfuJUj5e20J5aDygpwhSAq
	0YfVhlkHtSk3abjjkklb6rufwEddQMiGMEn6UXfEOzI5L3LxzEkbibxgzdu1VH6Li6AwQ+Eb4BB
	psjeSzOHiYWGDQOXRF5avffkD8Ow+DWeYbHvjx5xwKdhX7q2nQEkiFKj/xp/gmeiArZmKwnsObf
	NcuMGn1ZyWc+Y+SX/G75B7x15iLUZOKk5NzVuBOsGBAx5DZ8MbWbvE=
X-Received: by 2002:a05:6214:3d9c:b0:8c6:2245:3f49 with SMTP id 6a1803df08f44-8cc6e380e43mr45043036d6.32.1779370852360;
        Thu, 21 May 2026 06:40:52 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781b428csm5027756d6.23.2026.05.21.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:40:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] restorecond: do not pass the same string to basename()/dirname()
Date: Thu, 21 May 2026 09:40:23 -0400
Message-ID: <20260521134024.11581-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521134024.11581-1-stephen.smalley.work@gmail.com>
References: <20260521134024.11581-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

basename() and dirname() may modify their argument and may
return a pointer to some part of their argument so we should
pass separate copies of path to each one to prevent clobbering.
For example, if path is "/foo", then:
   x = strdup(path) = "/foo"
   file = basename(x) = x+1 = "foo\0"
   dir = dirname(x) writes '\0' to x+1 = "/\0oo"
And file will become "\0".

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 40d30e53..aceb9c5f 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -170,10 +170,12 @@ void watch_list_add(int fd, const char *path)
 	size_t i = 0;
 	struct watchList *prev = NULL;
 	glob_t globbuf;
-	char *x = strdup(path);
-	if (!x) exitApp("Out of Memory");
-	char *file = basename(x);
-	char *dir = dirname(x);
+	char *xb = strdup(path);
+	if (!xb) exitApp("Out of Memory");
+	char *xd = strdup(path);
+	if (!xd) exitApp("Out of Memory");
+	char *file = basename(xb);
+	char *dir = dirname(xd);
 	ptr = firstDir;
 	int len;
 
@@ -240,7 +242,8 @@ void watch_list_add(int fd, const char *path)
 		printf("%d: Dir=%s, File=%s\n", ptr->wd, ptr->dir, file);
 
 end:
-	free(x);
+	free(xb);
+	free(xd);
 	return;
 }
 
-- 
2.54.0

