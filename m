Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00683420872
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348342; cv=none; b=gIHYyXa5FCKICMSXmM+1+DA3L/yvTm3POcRqXqrNPEgAIEB9AiAkFMjmfA2EfRFx1UK5BTQaidJd/tkh9PnXBxEXmmRjbyxZpEvU8boUD0mBxPTh7EOJ+2hXM58i4WBDkzZhTuT6hW5+k+kg9W1r0RuG6J/IXvcWU2FC6dGWiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348342; c=relaxed/simple;
	bh=HcyZSSL5i4dVSKwE2f6m0x4wtUv0Y+H/MXU2LvTmRCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpomKna6KKLSP6sQmz4m5PheZMQba7IaS6JpjzjwwAmyNI257R7VCFSiI8zDw0CViToqbyXWO0pBuUWDC9O5KbnPs0I3P/18KhA3ikrp8slHTmL89kh3OBi3OeFxQrRsE/Pqs9ayWGsTW+cYbk6AqxQYjYJPwCkavDTPrw1CWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOVZZAvn; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOVZZAvn"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66766d649fdso1974949d50.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348340; x=1783953140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5milYqAhCvbT/awAvV28/Ss1jNcaNFusJ7JF97m1d+E=;
        b=TOVZZAvnMnjHt6lRvPeI2VMvt/15le9v/is0NgSeYGun/HERzuc47HEUvAL8kvygHf
         x3C9QDA1yEdBpIz2wjrQkqcuBuNEW64GH7DkJObjr4/Ip6/bX3HZNV17OUtDzaczh4rY
         AkeRCctXitGLka+OGa+PVng0tKqx7Y2UcS1oSRvHL+ysQJKqexxpNaIn4wu+QvU9Z62P
         WAth+3uIV6YSfUZajXWwkMCmY6aR6rjMK0rCPv4nUR9FradFj35dDQ6NjVvWvOXeDISn
         pO+sPgAMuJqwrlV7RALaaPEdC3098v2WY7x1imNcriSp+24DvvFbO31F+kjWZB6djKsW
         9u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348340; x=1783953140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5milYqAhCvbT/awAvV28/Ss1jNcaNFusJ7JF97m1d+E=;
        b=bDHXLRpgKW8lxzdPFNoEW4fGYkCLq4+5mJjx9/9D40dcXNM6plNsq/i7TEYUfKPYkn
         W53dYS4+ruNA10prJvcn3QIvVO3Z0S07mGJi1LkiT5oQhQvf0ByEylANTT89kcVYcFN8
         ITsTGjFwP+yR/jwEsKC6FRxY59lIHP73JDtfCoKaU7X9QNoX8QxBo5QLbzuh1pbCK0Yp
         7751lAVZ5C6CEikTOf1+oYMJPedGrkDAGTMUODNkusuPBTR/RAHqijMci6wgZz81izf9
         +SXDeXYiZmSIri6SMLBP5BtbaOhh9lvZBr1paXg/f2/jfvcofFZ0AKLyhSfKV8RLyTOY
         Hmzw==
X-Gm-Message-State: AOJu0YxzBsz2l9FzYLGotiQMPz7vjC/3R/OCXbkxkyubTW6qc62s+OXw
	UP+Dzd8/9XDU9rknZngW2TpjrXg4UlwmzuEZusgvgAQuq/XAWT6G14IzXfUKlA==
X-Gm-Gg: AfdE7cmuVEEJ2CNumCBlfoQ4eF7Emiv1BhP+jI5V2+uJm7Na79E+TCIhyQUW8mQNQFw
	WspzHkTzifl2X6JY4p22+lV7IC2Ul5QtwRaN3ENX3htb6J2zVBE5WDUZfNY7NbRzjIrd27R2E/F
	xEUqw8BMYa3AT0rRkSpphoz4vtTj+WlfsfGb22aKw+f4SZJwIeAQSeJtjmgiRkDW6e340wbPZub
	Ll3h5p9lLiIZ1iQhghGDOjLHdz3FfqXA4Goq7QYpF8NKWZYm3BUrDmebGiGobAolmT8h3nPnAZb
	r/Fgny7188WadFansd7A/zMfeS7pUImHa8TdVzp6QNh4TzOtrpyCCorNfW9eMd3ARr8HsCfd82h
	IfOORAsAtleApMh4GGLNCHw+lD+mzLlqXZoGNs8Qm3SCSF0Btc+BXihmY8CZDWSh7mzO0i5nz9W
	rAyZvnwBFgueCoZ/zu2UVJg5orA8t3UduALfs1hlvksKap02zbyCHijPcqZ3j5rXKljR/oamTpR
	50C1fOKi0zY0m9Q16skGa5+L/o=
X-Received: by 2002:a05:690e:d0c:b0:667:73a3:d65c with SMTP id 956f58d0204a3-6677fdab234mr692051d50.76.1783348339518;
        Mon, 06 Jul 2026 07:32:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm92790761cf.3.2026.07.06.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:32:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [PATCH v3 3/5] libselinux: sestatus: serialize selinux status updates
Date: Mon,  6 Jul 2026 10:31:53 -0400
Message-ID: <20260706143155.36629-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
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

