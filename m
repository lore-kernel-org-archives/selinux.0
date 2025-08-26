Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E81D63C2;
	Tue, 26 Aug 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229042; cv=none; b=MVpq2SkArQyFDK32ectT2QPzmz/C3iBVFQMZq1b+Y6HvQKuX4dtHRMG4V+8t1F8qMCD3BPPa/Buw7YApgw0QtIl1nzHVqO9GvOXTxgxC/KpOiijImdh5dS+KMbnYINgFe/ok+rzd2l6AH+Z5jL8G2qbFtI2V7yWj9SDMt58cU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229042; c=relaxed/simple;
	bh=qhfDCM48UmEixyWmHVRvpy6ISG793cEtuyT8M6VM//g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOJBEYbz//yu0QdOkJvLluIIojy5c2boYNc0sAKkCzInvfvcPZKZQ1uymm6YtsIDH9XH4NuIICm6/awD80oKUNfsyZ7995Iwbcuk+YxLjqLDxhtDTVAbaHEKnJ6iI3gbWuab3GdI/UsSQzc7dtZPJKZeOviMPjMZiqB20pNabCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke6m2YRY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke6m2YRY"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so116085b3a.1;
        Tue, 26 Aug 2025 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756229040; x=1756833840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbHDbzMgxGu5cMB0kr41kfnXL748arGNstWhQxdal6Y=;
        b=Ke6m2YRYqf4SHgRwOhNGmdLAxNo3y5Up2zv6U/f+rzlhucZ+1mOoe30MHJwdAteXrK
         jJQDe51VlRnC+4G6Oa68xkd0n6aJipfWrtFfiyt8g8gUqY+WfC588b9Jb3r/zVKHHWGe
         +NK290sfc5Kyu8eEtgZE1jfz4CFeadsez4ORtKE/DAftEPBnPbxzV0Ea1Hz+aPrn9CG0
         2yN1rA4ElTH40+ib0hj6LOkyIQLecb9/k5hUKoF0PyCxw/rb20efppXPm340iiW3TzQ0
         r7Uuh8nd0K5GTp+dAvihOaS38N/MGOYAAPJlI7kBZtwNJevS1ajtkbtuTiGowqNL5jbL
         vSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756229040; x=1756833840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbHDbzMgxGu5cMB0kr41kfnXL748arGNstWhQxdal6Y=;
        b=OAeF8sjHBZw/zuFVnmyMe5vty9Stx2sb2bfhqT7ro9onz6r66D1AIYvsU+ie175kxb
         FeLooq7mURP8RGqtDdynA/QMstjFT8Cd3jthMIRfvQqfvDf8DL6wmVopIXWqn2B3pNu/
         93IGZwVE33vno72tCzVp008jt1tdoDEuhOsdy6FTVr1MVAKKx3ulCNIG26jofuZMWdwW
         h65BcikemO5XwtpEJZ+o69b4Gah7+0DNY6d0gBrWjUl1yCMZc/oY9fQAD6vYn7Co51vL
         7eO5BfS7wRR47LSZha5wEoNb+NRCihbUVWkdqNm+u/A6FpFqrbW30r2dlRZCXarF2v0x
         xvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV412zDM/+IF8WokPUIKFIICNMASsZRQXNaI+sGmZilhA+45Ww2XlexTBADG8mmvvNYgq7BtNMbHAK+3TI=@vger.kernel.org, AJvYcCXUyZKjmeagI/6lLoO4Q96EMCOLPGii7HkiRgL2m5zE4zWS56hEnSgGY4ZJKzbE4a150cq10QjRjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOB5Olf1K3w41g24pnz8d0a8RfS7SFw2/1kQf6wwR/Z3vC/Zm
	fJEYkkddWhkWZO3UinxDJfgropAvsBARPh4AGFQ24EYqHmsBIQ/mPEwWdkuXvfYP+W+9kA==
X-Gm-Gg: ASbGncuk8l8eKXyqxLGtehdKf8VcLb/ibYvStwy6jv8v1HaU0GRcnWYOsX4w4VnLTrv
	Wvn3h9wre5ymO7S1idMqqORvHCrmXNMQlHLynKq0PtsXvY+nkT99u2EN1w4OdLnrW3pCYnoiaHW
	yKTGvB3b3K9886inG2FgNhIUN8ktt+jGPoWEZwY3REAfPXRUyfcEzPz9Ifxc6iUbinlTWSB2+WN
	mO0xlXx20Lw16iQJrV23LBsYohmdY/I/Yf6mVGmRhmU5tIg1FPM38oj1FuN120XFO8lkjXIvFLq
	Uxh0uUs+Z1euAtIPzpk4hgIN0120yTl1icVdTU7MA854jdykegR6hash6oSkiEzmDlqIR+sM/e1
	zzjDuQnZ52OZRyBk7mJqN9hX5HbXIuTuqIg26pPMCafvM8PbgsF8=
X-Google-Smtp-Source: AGHT+IGBHVLU3cke2d53aK/IVcErkzot17aex8kwkhG8loJdcngNMlQvsrqpDisSoGnC+0/LJ3UOdQ==
X-Received: by 2002:a05:6a00:3392:b0:770:4753:b984 with SMTP id d2e1a72fcca58-771fc292dedmr3431017b3a.16.1756229040017;
        Tue, 26 Aug 2025 10:24:00 -0700 (PDT)
Received: from yugansh-Inspiron-14-5410.. ([2401:4900:1c5c:9483:ae9a:a417:d9cc:4f1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fb852dedsm2211702b3a.88.2025.08.26.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:23:59 -0700 (PDT)
From: Yugansh Mittal <mittalyugansh1@gmail.com>
To: paul@paul-moore.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Yugansh Mittal <mittalyugansh1@gmail.com>
Subject: [PATCH v2] [V2] selinux: restore sleepable revalidation; keep fast no-sleep check
Date: Tue, 26 Aug 2025 22:53:20 +0530
Message-ID: <20250826172330.44006-1-mittalyugansh1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250824130106.35366-1-mittalyugansh1@gmail.com>
References: <20250824130106.35366-1-mittalyugansh1@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prior change made __inode_security_revalidate() always return
-ECHILD when the inode label appears invalid, avoiding the potential
sleep in inode_doinit_with_dentry(). However, not all callers can
propagate -ECHILD; only RCU path walk reliably can. This caused
cases where the inode could be left with a stale/unlabeled context.

Fix by:
  * Keeping an RCU-safe, non-blocking validity check fast path.
  * Returning -ECHILD only when may_sleep == false.
  * When may_sleep == true, performing the blocking revalidation via
    inode_doinit_with_dentry() as before.

This preserves non-sleeping behavior in atomic/RCU contexts while
maintaining correct reload semantics elsewhere.

Signed-off-by: Yugansh Mittal <mittalyugansh1@gmail.com>
---
 security/selinux/hooks.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874b..170ae6d65 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -279,20 +279,34 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
+	struct inode_security_struct *isec;
+
 	if (!selinux_initialized())
 		return 0;
 
-	if (may_sleep)
-		might_sleep();
-	else
-		return -ECHILD;
+	/* Fast, non-blocking validity check first */
+	rcu_read_lock();
+	isec = selinux_inode(inode);
+	if (likely(isec && !is_label_invalid(isec))) {
+		rcu_read_unlock();
+		return 0;   /* valid and no sleeping done */
+	}
+	rcu_read_unlock();
 
 	/*
-	 * Check to ensure that an inode's SELinux state is valid and try
-	 * reloading the inode security label if necessary.  This will fail if
-	 * @dentry is NULL and no dentry for this inode can be found; in that
-	 * case, continue using the old label.
-	 */
+	* Label looks invalid. If we can't sleep, signal caller that a
+	* retry in a sleepable context is required. Only contexts like
+	* RCU path walk are expected to propagate -ECHILD.
+	*/
+	if (!may_sleep)
+	return -ECHILD;
+
+	/*
+	* Sleepable context: reload the label. This may block.
+	* If @dentry is NULL and no dentry can be found we'll continue
+	* using the old label, consistent with prior behavior.
+	*/
+	might_sleep();
 	inode_doinit_with_dentry(inode, dentry);
 	return 0;
 }
-- 
2.43.0

