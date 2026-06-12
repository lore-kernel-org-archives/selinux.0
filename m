Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79864403AF9
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284161; cv=none; b=A45Pbyd0Dvn7eeRATEMa1yaHywqQ6wdaOBThxVzugvMkBwC4a9bZYHFaMEX2BmU/XD7DTYLfmUFlz627YvwMVisQB5hg9WrFnMvTcNMWKxyvsOejnWJozvxAelby+X3zPQ3HWA87KwjOc47iTflgMCSZFpSQpgbz8IOLMDa8QCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284161; c=relaxed/simple;
	bh=MRVJX4Pfu6eLCdjTaLu6ZOCAofP66//p4XcaKJYFADM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC2wXcJe43BkW19m2vQvdZl7fqfn3tW0tOMX8LG8m0k++kByZ0E1C8EMX6lCTRugqefw2njcj/2oxsvGjuEyaR4jAMgvA+iyk35uYhTCQL5iKe4oQTmYXr3W45229xpPuF8lateWsACZrv6my7xt1SbunWFcNbah9IBbhZ/K9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEMspWEY; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEMspWEY"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c25b040554so669465137.0
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781284159; x=1781888959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opo5Af103xLuBUGqePruuw3Gmsfj1cviPN860ZumqTw=;
        b=cEMspWEY91UnSTW8H7w+vRNQU19mQoU4HP8J1foqf5KzJjrjDGnBR0wNFpftARSyIw
         hjRflxWRcJfOm2DKsjDujRcw4D0zMvUONHuvpbRcJ23fGWqzokxDg7VRMRBUMwLNJKWF
         zk/pG5GHM6GmkNANckPTSSOBAIprrguQTFFaxHmvvpCeP8Syw68P81lv4mT2XiGNR/pb
         yEwQ5dyAFJQhETBzTxmMjBLFTckmfeTDAe0s9jzsG6mx6ndwMpXY+8/rMsKVY+u5GGc+
         saP57EZjATHwJYKWJURkXYmWD5qDdxF8qYpflM/1W1HhKbqTHnNqaqrHt0aYKEWS79tC
         aXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284159; x=1781888959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opo5Af103xLuBUGqePruuw3Gmsfj1cviPN860ZumqTw=;
        b=erGNsEVTrRl0NJNPz/pKwIzqS2Gz3rJD3osh0qxqUmivtaHgFnIcvLJ/fcHP2eZEeY
         S92wgtQvWBZjAZZURgOuGLZdgThRlOcNfmvjuS7QEod8b6lf/I3FhzFe5V9KujHLFxba
         VBtRNX+ejUlqL4CVJo4v2kx/o7QKsx7PqL6MkkLnB3re9d1CORyImEu6huSJEtJwc08n
         z3gLJ/IVkLPy5trTJtuSI698VGCww+hE84A7h2ZyFuuKO9L0DP0eRhr++45xIGUi85bB
         7WM4q107n2JJ3u7h1AsZVja3Nr3Nta7bAH0ZBgPeRF8kpLwVVbpugIfiuzXOBe570nNb
         vsEw==
X-Gm-Message-State: AOJu0Yx1yMjIQMQqA4ytJSu7Jczh4q21bjViAh0ocnUDP3IDV/tufmbV
	CVIYYfVesFkV58tiyZ92scqqluxuVAmemqluUEbd5kNrCzCocgnBhQx9Hkjc2w==
X-Gm-Gg: Acq92OHWwys85ksYvkdJrbIImt6NGsmrTrCieTMbIOACL+NWQjPbXQi1tEyyNYc8Ojc
	IaLUARLwbSafU9iRRemWmNnEJ+olrGZ5nbzlfDU1cicu8xEN/cfSFCSSJkaQmPWjVtoj9ePmg7+
	PZdwTgWIJOAfmI/Xcrjehd3STdE8Bc283iTihXgY50jzeea4cQNbUnC9op8Pm4Mc7LwvPRRJ5lK
	TUdspRI2J0FQcpir+m/tI/uvjE7p+zaeNOZ4KnhtvOUYG6jvLBevUywsLjdWdI+PU7WtB+0KxuJ
	0rH7YREGohXoRyJfWADM8NDnTShrKCCIwZlA5CrLBK6F7L7A9oXXpV/lYAEErsGzKwgvmVkfJTl
	3rKHA59sbfIwScPW6Qn114KTjSpLHWpl4PPTlaAZRp97SCxfGLlJinZiqZcxF4gt5nUnDXX62v3
	czGxrLqk6YRzgjW6ZFRVaSM+EIx1zdJH3QRd1pDCR5RGFi3ySWDvT1WwDh7o2ApwpYMeZq8QFgR
	22KnFLjyZaIxQYeBQnnEI4hD1dHd1w5G3L47w==
X-Received: by 2002:a05:6102:3e82:b0:660:c9e5:8d95 with SMTP id ada2fe7eead31-71e88b28862mr2998107137.12.1781284159386;
        Fri, 12 Jun 2026 10:09:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8aa6sm265590085a.2.2026.06.12.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:09:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [RFC PATCH 3/3] libselinux: sestatus: serialize selinux status updates
Date: Fri, 12 Jun 2026 13:08:56 -0400
Message-ID: <20260612170856.17904-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
References: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
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
 libselinux/src/sestatus.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index bb69fe90..12d04bd3 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -36,6 +36,7 @@ struct selinux_status_t {
  * Valid Pointer : opened and mapped correctly
  */
 static struct selinux_status_t *selinux_status = NULL;
+static pthread_mutex_t status_lock = PTHREAD_MUTEX_INITIALIZER;
 static uint32_t last_seqno;
 static uint32_t last_policyload;
 
@@ -98,9 +99,13 @@ int selinux_status_updated(void)
 		return -1;
 	}
 
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
@@ -117,11 +122,14 @@ int selinux_status_updated(void)
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
 
@@ -134,16 +142,21 @@ int selinux_status_updated(void)
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
 
@@ -164,10 +177,12 @@ int selinux_status_getenforce(void)
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
@@ -201,10 +216,12 @@ int selinux_status_policyload(void)
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

