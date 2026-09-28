Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE44EBAC5
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617629; cv=none; b=mLOJd6VVHJv/a55IG4TGJv5e5p5joNaOeHZdAMlZhjBJWlR9CvVcRM7q5RgeMqd8DZIlpy7o7aqqmlcZ3AY1tNi7DwRn1wro5E0SUZtK6NANEn29/rIUaZgBmNZUFqIqIQxkhiFBFbLkI5nfL3e+6o1FtOTsVgJg7CzGqAqDckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617629; c=relaxed/simple;
	bh=gbqs+j0S9zz/jypJ2ozRl7fFCcvYoZBaDB4LX1BwTy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnFzztuZRJ/XBStG02SdDZtSTuPyI07hnsKm1i6xzO2wKkI0pvXc9tJlBHS/8IOZQMQNGqiSu3J0qMurJSt9CDibNCb2CBEu1Wil1xmCUJxip7TMb+VfxthnRrya6+Mc+9tamEoaSqATgOeyluAjoV+Tbzsa0NGz4kI6HJ5VDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=f49kalo+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="f49kalo+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WW3/Y6pqgjCQNyXW4JMuLaJYR7K+V+oVR2P7WKv+Ihc=;
	b=f49kalo+d7mDXa5OQa5fMEpnftFzaYf0UIOHWzHnP9U/vn0Gi64yVPIeXAcWlJQLfz+e4T
	HfoWh7hL8AGNqhWGXcCc1BK8npryQZNju3SkLKdfLjs2RzwiZv9Z3z6hfkL1+vPseA6baD
	77CljJILdbwAfGOd91OTzN5qXuPvJvpoNPb/tUwlOBAFDTiryW9Xcm+autzymow/Ufe5gi
	6nEVOlLh0l5DdLNRSFeBw3TsvwpWdEOnwNSAXsx69mvJll2Ev552MhdGteTk5tJSQzz9rN
	P258znkbS3AeVjKpiyUxU67lpdhed4ZKDjjFkfF8Y/AZ6W8bwXJldMNt5bz3BA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 19/32] selinux: drop no-op gotos in ocontext SID lookups
Date: Mon, 28 Sep 2026 19:46:29 +0200
Message-ID: <20260928174643.2458710-18-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Remove error checks that jump to the label directly following them.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ce9f9c483f49..1b8f420e5e1b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2482,13 +2482,10 @@ int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
 			rcu_read_unlock();
 			goto retry;
 		}
-		if (rc)
-			goto out;
 	} else {
 		*out_sid = SECINITSID_PORT;
 	}
 
-out:
 	rcu_read_unlock();
 	return rc;
 }
@@ -2535,12 +2532,9 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 			rcu_read_unlock();
 			goto retry;
 		}
-		if (rc)
-			goto out;
 	} else
 		*out_sid = SECINITSID_UNLABELED;
 
-out:
 	rcu_read_unlock();
 	return rc;
 }
@@ -2588,12 +2582,9 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
 			rcu_read_unlock();
 			goto retry;
 		}
-		if (rc)
-			goto out;
 	} else
 		*out_sid = SECINITSID_UNLABELED;
 
-out:
 	rcu_read_unlock();
 	return rc;
 }
@@ -2644,12 +2635,9 @@ int security_netif_sid(const char *name, u32 *if_sid)
 			rcu_read_unlock();
 			goto retry;
 		}
-		if (rc)
-			goto out;
 	} else
 		*if_sid = SECINITSID_NETIF;
 
-out:
 	rcu_read_unlock();
 	return rc;
 }
@@ -2899,8 +2887,6 @@ int security_fs_use(struct super_block *sb)
 			rcu_read_unlock();
 			goto retry;
 		}
-		if (rc)
-			goto out;
 	} else {
 		rc = __security_genfs_sid(policy, fstype, "/",
 					SECCLASS_DIR, &sbsec->sid);
@@ -2916,7 +2902,6 @@ int security_fs_use(struct super_block *sb)
 		}
 	}
 
-out:
 	rcu_read_unlock();
 	return rc;
 }
-- 
2.55.0

