Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF33A873D
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291531; cv=none; b=eGsGu+Gpmi+kW6Cc9bbdH0b46OSokZbFShy1qRmlvhmCGbrtUxKMwxmStKo3uBNY1iEa00vS5VixwXBzF+WKjs/YqMLlCiid3bbeyQ4jah+utcmQsf0k5xWMQ3MD7j/KkKJZzD9ueLugIUic9WLNKlCxa8JdVLGiiYO+9IULC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291531; c=relaxed/simple;
	bh=X/0rE72HKITS+KOuVC8wjfVNhkOgvw88TlD2JCNdENc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBKV/J5X2g6DUzaLoV/U5psduu2dTvR4tggGbdS7T6YWwo9Zj9HHfsQtDO4VniuSxaC6zRLOk2xliObWju6rsODsqFN2AzOhIs81FE6ma+yeUCfP3gqfkY7UZXVwM9fDP6K/aoBbhewVyqQ3opQgk9yLYv++chOJCIygIMMmgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNkyEZvS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNkyEZvS"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91574384cc2so149435585a.2
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291528; x=1781896328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U92bXWxm6/CGI7/wW06ty/YEYXeT9NtxHTqdplBwI3M=;
        b=iNkyEZvS5Bv2w3zjweWweMjzGdC6Dj+XymPvCPqwnfS8v2weucYi7vvlrCkUQhs82D
         euIUsK7OoghjVmIiuFSfYX1RD0oUAOs0GKvoayji2GdroQ9L0MGunbk4pFnS6BrcMNzz
         4PJ9R5juGinYfLgNpWdIP9OfAQQ0v5GuNmLNXH66AkryoWxcn2rFMd1obUmF2lbN17Fj
         ORAhSfCsvCfF2CcG4gH+PxsQS/5jRar9BfBW5GgfL6HjBrRbM5/sXpj0MCfim33XFmmt
         V+NwT3Y4r4Wvc4xMycsy3WfNLDsfdgRBTlN7Mk4NkAcmvR0a8+m6hycJ4YgzC/3NWnMi
         9Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291528; x=1781896328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U92bXWxm6/CGI7/wW06ty/YEYXeT9NtxHTqdplBwI3M=;
        b=c/pYLT5fluw70JYV5kd6ivNdaMsWmbI39k17ZrDsuWTavziFV6JbN2+JntOvAGfn1i
         yO6Id+W19ZvqTKpAAr/nhf2pMzUbiMJZFfa1erAAoL6+qtGUT37USi0B8CKGdm5aa1x2
         rfRysxCcEFP8nkQYe6YS5QKWXH25diNSzlKbllBTovIAfH8uJaqFmcAf6JdAOkGxFQne
         AhOxih9KjxfgaLAFJZ8hKyRF1yzzamme1B4WfQihdiA3du0zxa9tBEK/WeW5LU6qj4Km
         1lVHtG/jndHPGItZki9fcNbJ9x8/6V4duJuptojzWXFB/UlBOq7EJ2aKPPSwCUEknhaN
         f4TA==
X-Gm-Message-State: AOJu0YzkQ3NVczb0hG95S7PwqGxtoqWo6+rNDJ2m2NYIxX0ux8gu6bPO
	UJphdss44/sW9+z794z/1p4IweRjDHjWrouxpkPUclrPM4e4Jl38IQv4uB3vdw==
X-Gm-Gg: Acq92OHpCyl7dIbnV1PCju0M9FbkCTnAj54HfcACgP2cI/xB3sUEdpaDPKD6n+mufK8
	iQYfZQl9vcfKPUjlkt3Qb80xWLw7OjtoAsSsSYsLGoXNE284ItvFRPiv1Rohtccd0nC1qkhb9tp
	kNDJsnSkAS7Q6dq9fbyC9N8akPgbehRHTt0OA1Odm2sxJ97kC7XXgdw8TY5Ejh3CG5NFK0CMsFP
	WiC9ZEl0FidNJouAuc4hzbVtkSy7xaivfCZU4ODiT/v1qL2tvd0zETIXuTagOMOXEELxzEAx9q2
	JAuEHLYfd3K/pjLK65lpRadFMQ1XPkpzJCra9DiC0xnpoHzibkzfZmW/uzuXyfU5+jr+xa6t05t
	6CNwR/e4lJ4qcneWp3851LieqIrQlv01eTqOEnPqvHsac1KlRFDI7cVYB2r1gYPIthRUdVhUjTq
	k1Tjlg+NV67WFSlins3g7fq1vTHFOO/LVtbeNw0MQPDyi4iBKaKJWj3C4N0xcphQn6ezCZoCNxE
	J/Js/AhzydyvJLCb6CPFsLrg6U=
X-Received: by 2002:a05:620a:3724:b0:916:16d0:c024 with SMTP id af79cd13be357-9161baf6cc8mr581652385a.17.1781291527657;
        Fri, 12 Jun 2026 12:12:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04b472sm295086885a.37.2026.06.12.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:12:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [RFC PATCH v2 3/3] libselinux: sestatus: serialize selinux status updates
Date: Fri, 12 Jun 2026 15:11:46 -0400
Message-ID: <20260612191146.20122-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
References: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When selinux_check_access() is used by a multi-threaded application
and calls selinux_status_updated(), every thread that observes the
same sequence number bump races to run the avc_process_*() functions,
so avc_ss_reset() and selinux_flush_class_cache() fire once per thread
instead of once per event, and writes to the last_seqno/policyload can
tear.

Introduce and take a status_lock mutex across the last_seqno
compare-and-update and the update actions so that exactly one thread
services each event. The kernel status page itself is a seqlock and is
still read unlocked via the existing read_sequence() loop.

Lock ordering:
1. status_lock is never taken when another libselinux lock is held.
2. Under status_lock, the code may take avc_lock (via avc_ss_reset) or
discover_class_lock (via selinux_flush_class_cache), but neither of these
ever nest back into status_lock.

Fixes: #287 #335 #336
Link: https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com/
Link: https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamchoudhary29@gmail.com/
Reported-by: Seth Moore <sethmo@google.com>
Reported-by: Purushottam Choudhary <purushottamchoudhary29@gmail.com>

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 restores a lockless fast path for the common case where no
policy change has occurred since the last check.

 libselinux/src/sestatus.c | 49 +++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index bb69fe90..e30380ae 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -36,6 +36,7 @@ struct selinux_status_t {
  * Valid Pointer : opened and mapped correctly
  */
 static struct selinux_status_t *selinux_status = NULL;
+static pthread_mutex_t status_lock = PTHREAD_MUTEX_INITIALIZER;
 static uint32_t last_seqno;
 static uint32_t last_policyload;
 
@@ -98,9 +99,25 @@ int selinux_status_updated(void)
 		return -1;
 	}
 
+	/*
+	 * Fast path with no locking is only possible when the status page
+	 * is mapped, the last_seqno is even (stable) and it matches the
+	 * curr_seqno.
+	 */
+	if (selinux_status != MAP_FAILED) {
+		curr_seqno = read_sequence(selinux_status);
+		if ((last_seqno & 0x0001) == 0 && curr_seqno == last_seqno)
+			return 0;
+	}
+
+	/* Otherwise we have to take the mutex and re-check */
+	__pthread_mutex_lock(&status_lock);
+
 	if (selinux_status == MAP_FAILED) {
-		if (avc_netlink_check_nb() < 0)
+		if (avc_netlink_check_nb() < 0) {
+			__pthread_mutex_unlock(&status_lock);
 			return -1;
+		}
 
 		curr_seqno = fallback_sequence;
 	} else {
@@ -117,11 +134,14 @@ int selinux_status_updated(void)
 	if (last_seqno & 0x0001)
 		last_seqno = curr_seqno;
 
-	if (last_seqno == curr_seqno)
+	if (last_seqno == curr_seqno) {
+		__pthread_mutex_unlock(&status_lock);
 		return 0;
+	}
 
 	if (selinux_status == MAP_FAILED) {
 		last_seqno = curr_seqno;
+		__pthread_mutex_unlock(&status_lock);
 		return 1;
 	}
 
@@ -134,16 +154,21 @@ int selinux_status_updated(void)
 	} while (tmp_seqno != curr_seqno);
 
 	if (avc_enforcing != (int)enforcing) {
-		if (avc_process_setenforce(enforcing) < 0)
+		if (avc_process_setenforce(enforcing) < 0) {
+			__pthread_mutex_unlock(&status_lock);
 			return -1;
+		}
 	}
 	if (last_policyload != policyload) {
-		if (avc_process_policyload(policyload) < 0)
+		if (avc_process_policyload(policyload) < 0) {
+			__pthread_mutex_unlock(&status_lock);
 			return -1;
+		}
 		last_policyload = policyload;
 	}
 	last_seqno = curr_seqno;
 
+	__pthread_mutex_unlock(&status_lock);
 	return 1;
 }
 
@@ -164,10 +189,12 @@ int selinux_status_getenforce(void)
 	}
 
 	if (selinux_status == MAP_FAILED) {
-		if (avc_netlink_check_nb() < 0)
-			return -1;
+		int rc;
 
-		return fallback_enforcing;
+		__pthread_mutex_lock(&status_lock);
+		rc = (avc_netlink_check_nb() < 0) ? -1 : fallback_enforcing;
+		__pthread_mutex_unlock(&status_lock);
+		return rc;
 	}
 
 	/* sequence must not be changed during references */
@@ -201,10 +228,12 @@ int selinux_status_policyload(void)
 	}
 
 	if (selinux_status == MAP_FAILED) {
-		if (avc_netlink_check_nb() < 0)
-			return -1;
+		int rc;
 
-		return fallback_policyload;
+		__pthread_mutex_lock(&status_lock);
+		rc = (avc_netlink_check_nb() < 0) ? -1 : fallback_policyload;
+		__pthread_mutex_unlock(&status_lock);
+		return rc;
 	}
 
 	/* sequence must not be changed during references */
-- 
2.54.0

