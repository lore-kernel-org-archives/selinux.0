Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42372314D08
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254395; cv=none; b=PU3rMvr65U3qjry4qTd5JGPtNH3aKkLw7J8xkyVl7vFMmQsnzz3Fq1k3Po5E8ir98mED/bQeqWiJ2AH+wQdGPz8FbplpUc1LjgDK/NbPTR5c1v/lDz1BUBgZCcKteHqOrF5XizkkH13FNccENp3xxwhd4kEzxz6WVpie0uj+9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254395; c=relaxed/simple;
	bh=ku1dmf4toeaGtX7VBobBNgDz1QSiC/bGi9Lw8fcbevM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njl1htRQ8q3ViCYJ6ZuoopvOABBb1EyPaDo4ptrv5Cg7TAvMHHO7q+2dHeNRjV6clvl8GPgNQVS97wqTNFkaP6FjmW38DXeyYL43hsg0aMRfaIp/Q+QdXm5/nb0lBHuRiQnap1nmYkeqD2a2adhogQowgau7YOAW2Bn0j9yoObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4/OYM8u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rn7DRheX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4/OYM8u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rn7DRheX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
	b=L4/OYM8urn2QSXNxTIaZKJFxYJBmkMoB7Hf9wg455waOb6XrnbhkjnJdET7y+8LsRy3icA
	xuWJjSoN3svj25mwIxSdzUv27JtfYkjFR/ORbxCfZLZwtgg5fqOYjfOZ1dEuWp2w9bEhQP
	6WZv6QKNcUZQk3vx8ARXOGpvQb0bNw4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-1-kDM8wEO167kgrdVwHIPA-1; Mon, 16 Feb 2026 10:06:31 -0500
X-MC-Unique: 1-kDM8wEO167kgrdVwHIPA-1
X-Mimecast-MFC-AGG-ID: 1-kDM8wEO167kgrdVwHIPA_1771254391
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43624564fc9so3336530f8f.2
        for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771254390; x=1771859190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
        b=rn7DRheXDTjheiqdd6YBnXlDjTn2snEwg44RmwxopDmHPZG0CmzKz8bHlbEIqb44HY
         cM17ZVgg8b0fKfaCqCEqU1YazVBAJIFL8b8g1r+1F6n2v9oJy/TIkCtF08Dk0RNpi3gP
         6UaT4u5m1ViX+WqyY4OwHCqesim+QpNBTiYXySJLQIXbL/2X7i7CN5fRQoeXJDZ5m6Dz
         7ZEDzzELLo7B5QW23UbPhN2u+EEZlZ1xVWrFqrAtEGNDbYJoqhVxZTMZGjikp/x/aMdb
         1Au42kraHRcck9jgnHy1qKZg63+xzCIvGI0pHVvYzfRyb7T45s8atcmNVBxbFokWJeXp
         U+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254390; x=1771859190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
        b=c+FhTIZlAILiLhY6NFf0vrf077YRSiBA+IOly+m0MpcV2t9oP9KNXG9+hSCbFpk8OB
         0SmMiZ0D1fyu/ySzOQEKEfGVR5xGZndUmX5WywOAMseZILT2DvaTBV9gMrVOFLG+k8J9
         Hn8WXY/b3hlBMOcv7EvQ6nHhaHMgn43mg0FyUiozJS4WoIyi80JqkbhNOJHyo50Ce+KB
         pgZREMOKBmtwzRjG2fz8B0zR63MCQcid0LWK4mazZ19zcHupzQq40tyYjWQeEwyYqWDu
         ln5FhM0ShJIM2UlS1jw5sUEMq1RRvSbEXw+D2IuxCq44mmn1dPP1j9PaszJZC2IsK/RM
         ljdg==
X-Forwarded-Encrypted: i=1; AJvYcCVaQEfTpsibnNBQB69TN07IGHO2+mToYKrZOHGBzr/pXtCAOgSsMxHf64jr7Uurb//pJLdJgpaM@vger.kernel.org
X-Gm-Message-State: AOJu0YztkX2iqiO8OEgQ02EJbNdpOJVXSqzzJszDrX0FRbo2GatAIDol
	iBNcmZy6mRp2uC0qINGRMsu8/ISdG1au7gDKd9ntddIyuh8lMMZXZqsKAejqCxXKqT1RPGhZoX1
	DzL5GkjuHGCTLhXZdy8Dx/EVUHDOStREbYzCYS+71z2JB2/8HQkI1PAf06XY=
X-Gm-Gg: AZuq6aJ0ae16vKkK6fFa89cq6DyWbWfBTTe5EDU4eAA9rNEtlMzIkJBYU7DxeyhSUp0
	I7kRxRO3tH6VNDWUB/zKI9Alqv6N0+15bmXiC7tKZbDxbgfDEtzPaVBlhGi5C2lTNm+TfLCXl4n
	d+YiAVGdNWVqzMhGyqzQG0jlpHAVNMTJdziy/dN+Zv8XuwKXcTBLmN1u2hKF921/OOAI1a3f6DZ
	5JDt75tocRk/uV+Y7OWJCs76J42KA2o0ZFs7fTTizxo4o+X5fGHAI43piFO80FM73oNtYGeoI6e
	mktEjMmJnTiUu4jXUe0olwycDmXogQmMgtfGiOc9kpVjTjANv6b69Zn0nK9l4NGuXD78tBxYBJ9
	cMYmF4sPLR24MDaD4DgrX17nnWxJdtgFDbNy3JZ103jB/QMYi
X-Received: by 2002:a05:6000:2906:b0:431:369:e7b with SMTP id ffacd0b85a97d-4379db61b66mr14358254f8f.18.1771254390359;
        Mon, 16 Feb 2026 07:06:30 -0800 (PST)
X-Received: by 2002:a05:6000:2906:b0:431:369:e7b with SMTP id ffacd0b85a97d-4379db61b66mr14358189f8f.18.1771254389851;
        Mon, 16 Feb 2026 07:06:29 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:29 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
Date: Mon, 16 Feb 2026 16:06:24 +0100
Message-ID: <20260216150625.793013-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
References: <20260216150625.793013-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure calling capable()/ns_capable() actually leads to access denied
when false is returned, because these functions emit an audit record
when a Linux Security Module denies the capability, which makes it
difficult to avoid allowing/silencing unnecessary permissions in
security policies (namely with SELinux).

Where the return value just used to set a flag, use the non-auditing
ns_capable_noaudit() instead.

Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d0b9b984002fe..9c9fca2976d2b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1615,17 +1615,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		/*
-		 * An unprivileged user can setup an fanotify group with
-		 * limited functionality - an unprivileged group is limited to
-		 * notification events with file handles or mount ids and it
-		 * cannot use unlimited queue/marks.
-		 */
-		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
-		    !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
-			return -EPERM;
+	/*
+	 * An unprivileged user can setup an fanotify group with
+	 * limited functionality - an unprivileged group is limited to
+	 * notification events with file handles or mount ids and it
+	 * cannot use unlimited queue/marks.
+	 */
+	if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
+	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 
+	if (!ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 		/*
 		 * Setting the internal flag FANOTIFY_UNPRIV on the group
 		 * prevents setting mount/filesystem marks on this group and
@@ -1990,8 +1991,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * A user is allowed to setup sb/mount/mntns marks only if it is
 	 * capable in the user ns where the group was created.
 	 */
-	if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
-	    mark_type != FAN_MARK_INODE)
+	if (mark_type != FAN_MARK_INODE &&
+	    !ns_capable(group->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
-- 
2.53.0

