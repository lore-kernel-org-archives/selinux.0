Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC58C433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 13:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346406AbiDANiH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 09:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiDANhz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 09:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B2F218383A
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648820165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qCEz/9ZttHm40fOppDP2qHIaDBA3UgD8dN6t0mdZVY=;
        b=ca1vZtMrsl9HLdc7hHkOnGWEcysfebgFbU+9iBLcYOzdogzs7grG/gi6xrZlY5Db4FL5sk
        xr6dhnrcjNblCRkjMfUS3raq7SgkMag8PBYmYdLQE0CZxAEcoVZ/RaN7eaUp85jp5L1ahO
        yPAwt/ZeUOPRauXLFKrY/ScQ9VzCHt4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-RUXRU_CtN_mnyXl6i-TOJA-1; Fri, 01 Apr 2022 09:36:03 -0400
X-MC-Unique: RUXRU_CtN_mnyXl6i-TOJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98B9C3C00089
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D91AE40D1B9B;
        Fri,  1 Apr 2022 13:36:02 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 3/3] mcstrans: Fir RESOURCE_LEAK and USE_AFTER_FREE coverity scan defects
Date:   Fri,  1 Apr 2022 15:35:49 +0200
Message-Id: <20220401133549.122069-3-plautrba@redhat.com>
In-Reply-To: <20220401133549.122069-1-plautrba@redhat.com>
References: <20220401133549.122069-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 mcstrans/src/mcstrans.c  | 25 ++++++++++++++++++++++++-
 mcstrans/src/mcstransd.c |  4 +++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index d42760fdbfc2..af3f507ef718 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -632,16 +632,23 @@ add_cache(domain_t *domain, char *raw, char *trans) {
 
 	map->raw = strdup(raw);
 	if (!map->raw) {
+		free(map);
 		goto err;
 	}
 	map->trans = strdup(trans);
 	if (!map->trans) {
+		free(map->raw);
+		free(map);
 		goto err;
 	}
 
 	log_debug(" add_cache (%s,%s)\n", raw, trans);
-	if (add_to_hashtable(domain->raw_to_trans, map->raw, map) < 0)
+	if (add_to_hashtable(domain->raw_to_trans, map->raw, map) < 0) {
+		free(map->trans);
+		free(map->raw);
+		free(map);
 		goto err;
+	}
 
 	if (add_to_hashtable(domain->trans_to_raw, map->trans, map) < 0)
 		goto err;
@@ -1568,6 +1575,7 @@ trans_context(const char *incon, char **rcon) {
 			trans = compute_trans_from_raw(range, domain);
 			if (trans)
 				if (add_cache(domain, range, trans) < 0) {
+					free(trans);
 					free(range);
 					return -1;
 				}
@@ -1579,6 +1587,7 @@ trans_context(const char *incon, char **rcon) {
 				ltrans = compute_trans_from_raw(lrange, domain);
 				if (ltrans) {
 					if (add_cache(domain, lrange, ltrans) < 0) {
+						free(ltrans);
 						free(range);
 						return -1;
 					}
@@ -1597,6 +1606,7 @@ trans_context(const char *incon, char **rcon) {
 				utrans = compute_trans_from_raw(urange, domain);
 				if (utrans) {
 					if (add_cache(domain, urange, utrans) < 0) {
+						free(utrans);
 						free(ltrans);
 						free(range);
 						return -1;
@@ -1636,6 +1646,10 @@ trans_context(const char *incon, char **rcon) {
 		}
 		if (dashp)
 			*dashp = '-';
+		if (trans) {
+			free(trans);
+			trans = NULL;
+		}
 	}
 
 	if (trans) {
@@ -1696,7 +1710,9 @@ untrans_context(const char *incon, char **rcon) {
 					canonical = compute_trans_from_raw(raw, domain);
 					if (canonical && strcmp(canonical, range))
 						if (add_cache(domain, raw, canonical) < 0) {
+							free(canonical);
 							free(range);
+							free(raw);
 							return -1;
 						}
 				}
@@ -1704,6 +1720,7 @@ untrans_context(const char *incon, char **rcon) {
 					free(canonical);
 				if (add_cache(domain, raw, range) < 0) {
 					free(range);
+					free(raw);
 					return -1;
 				}
 			} else {
@@ -1721,6 +1738,7 @@ untrans_context(const char *incon, char **rcon) {
 						canonical = compute_trans_from_raw(lraw, domain);
 						if (canonical)
 							if (add_cache(domain, lraw, canonical) < 0) {
+								free(canonical);
 								free(lraw);
 								free(range);
 								return -1;
@@ -1752,6 +1770,7 @@ untrans_context(const char *incon, char **rcon) {
 						canonical = compute_trans_from_raw(uraw, domain);
 						if (canonical)
 							if (add_cache(domain, uraw, canonical) < 0) {
+								free(canonical);
 								free(uraw);
 								free(lraw);
 								free(range);
@@ -1802,6 +1821,10 @@ untrans_context(const char *incon, char **rcon) {
 		}
 		if (dashp)
 			*dashp = '-';
+		if (raw) {
+			free(raw);
+			raw = NULL;
+		}
 	}
 
 	if (raw) {
diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 536c0f32f23a..42262e580386 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -328,6 +328,7 @@ process_events(struct pollfd **ufds, int *nfds)
 					/* Setup pollfd for deletion later. */
 					(*ufds)[ii].fd = -1;
 					close(connfd);
+					connfd = -1;
 					/* So we don't get bothered later */
 					revents = revents & ~(POLLHUP);
 				}
@@ -341,10 +342,11 @@ process_events(struct pollfd **ufds, int *nfds)
 			/* Set the pollfd up for deletion later. */
 			(*ufds)[ii].fd = -1;
 			close(connfd);
+			connfd = -1;
 
 			revents = revents & ~(POLLHUP);
 		}
-		if (revents) {
+		if (revents && connfd != -1) {
 			syslog(LOG_ERR, "Unknown/error events (%x) encountered"
 					" for fd (%d)\n", revents, connfd);
 
-- 
2.35.1

