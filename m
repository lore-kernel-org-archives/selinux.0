Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BAC2D0C84
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771271319; cv=none; b=li8oZMBEyryALfRlJrTcP5xI7q3gY3LNmUtDJ5UfuiGnUBGtUFk/kEeVwN9R0K6p342x9SHRBsCry9mFg+sk/qx0byp+IiSgxaw0OY8Wug8ZZKFGlHsoO27k8zyNlZV3HUK3b5cdIWNLWph+JjjabojBbkZ8Taob6MHtUpMQxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771271319; c=relaxed/simple;
	bh=KWztL0dHrCNUVFkiQLvKX4ZinThimmRz9eZ2A1AX5po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dRljEvJ+GJiSgPg37Y5zw/R0eJlK7QbyBrez4KouyTjVMXIO8VKxTNVHO2PadFDsryV8O1a1/VOaVjqPA2so1ig23za3E/3hBGCK9YoGLUDLP1aoyJlanjDetaZtxvStjFCczX9RhEdZPrZBSKkqXlvuHI4hb/t8YyHLB73H/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDGIQHMA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDGIQHMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771271317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4+J5CqcCzYZC6oixyDC2G6v9J2hORbr3QDoXbR/GAeE=;
	b=YDGIQHMAt88fW8BMEmBV9ANxyol5RR3YIR16+LAtA6VpWF/Ts9MZ3i3QgiZiHAkYQGuLlM
	Jm9+xkzBg6dMuBuMT+3INB5oF2Tq/IWQmAn8dJ8mOSBUZeGl9+VZjmFcrlYzaArubZM2z+
	D69OqTdsVoGWLu9xpFWJL/WI0ux+Sm0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-wgJv_C0iNnaU-hbWzuypuQ-1; Mon,
 16 Feb 2026 14:48:36 -0500
X-MC-Unique: wgJv_C0iNnaU-hbWzuypuQ-1
X-Mimecast-MFC-AGG-ID: wgJv_C0iNnaU-hbWzuypuQ_1771271315
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674BB18002EB
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 19:48:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A558B19560A2
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 19:48:34 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] mcstrans: Fix translation for uncached entries
Date: Mon, 16 Feb 2026 20:40:11 +0100
Message-ID: <20260216194829.3372622-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

trans_context:
In case the raw context is not found in cache (find_in_hashtable returns
NULL) and the context does not contain a dash (dashp == NULL),
compute_trans_from_raw gets executed, but the translation (trans) gets
freed immediately after caching, at the end of the "for" loop.

untrans_context:
Same as trans_context, if the translation is not cached and "range" does
not contain a dash, compute_raw_from_trans is called, but the
translation (raw) gets freed right after the reverse translation is
computed and cached.

Also, fix the README for "nato" example and add README for "pipes"
example of setrans configuration.

Fixes:
  Pipes/NATO examples from /usr/share/mcstrans/examples

  $ /usr/share/mcstrans/util/mlstrans-test pipes.test
untrans: 'a:b:c:Restricted Handle Via Iron Pipes Only' -> 'a:b:c:Restricted Handle Via Iron Pipes Only' != 'a:b:c:s2:c102,c200.c511' FAILED
untrans: 'a:b:c:Restricted Handle Via Copper Pipes Only' -> 'a:b:c:Restricted Handle Via Copper Pipes Only' != 'a:b:c:s2:c103,c200.c511' FAILED
untrans: 'a:b:c:Restricted Handle Via Plastic Pipes Only' -> 'a:b:c:Restricted Handle Via Plastic Pipes Only' != 'a:b:c:s2:c101,c200.c511' FAILED
untrans: 'a:b:c:Restricted Handle Via Galvanized Pipes Only' -> 'a:b:c:Restricted Handle Via Galvanized Pipes Only' != 'a:b:c:s2:c104,c200.c511' FAILED
untrans: 'a:b:c:Restricted Handle Via Plastic,Iron,Copper Pipes Only' -> 'a:b:c:Restricted Handle Via Plastic,Iron,Copper Pipes Only' != 'a:b:c:s2:c101.c103,c200.c511' FAILED
untrans: 'a:b:c:Restricted Handle Via Iron,Plastic,Copper Pipes Only' -> 'a:b:c:Restricted Handle Via Iron,Plastic,Copper Pipes Only' != 'a:b:c:s2:c101.c103,c200.c511' FAILED
mlstrans-test done with 6 errors

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---

While working on this patch, I also noticed that s0 is treated
differently in the mcstrans code (as also noted by [1] and [2]).
Could anyone help shed some light on the reason for this?

Thank you.

[1] - https://github.com/SELinuxProject/selinux/issues/191#issuecomment-566124541
[2] - https://lore.kernel.org/selinux/0f7263c2-b16e-2979-cc55-9454a402b6a4@gmail.com/

 mcstrans/share/examples/nato/README  |  8 +++-----
 mcstrans/share/examples/pipes/README | 10 ++++++++++
 mcstrans/src/mcstrans.c              |  5 ++++-
 3 files changed, 17 insertions(+), 6 deletions(-)
 create mode 100644 mcstrans/share/examples/pipes/README

diff --git a/mcstrans/share/examples/nato/README b/mcstrans/share/examples/nato/README
index b8b30bf7..7d75e0d6 100644
--- a/mcstrans/share/examples/nato/README
+++ b/mcstrans/share/examples/nato/README
@@ -1,12 +1,10 @@
 NATO example test setrans.conf
 
 To use:
-mkdir /etc/selinux/mls/mcstrand.d
-cp rel.conf /etc/selinux/mls/mcstrand.d
-cp eyes-only.conf /etc/selinux/mls/mcstrand.d
-cp constraints.conf /etc/selinux/mls/mcstrand.d
+rm -f /etc/selinux/mls/setrans.d/*
+cp setrans.d/*  /etc/selinux/mls/setrans.d
 cp setrans.conf /etc/selinux/mls/setrans.conf
-sudo run_init /etc/init.d/mcstrans restart
+run_init /etc/init.d/mcstrans restart
 
 To test:
 /usr/share/mcstrans/util/mlstrans-test nato.test
diff --git a/mcstrans/share/examples/pipes/README b/mcstrans/share/examples/pipes/README
new file mode 100644
index 00000000..3963d300
--- /dev/null
+++ b/mcstrans/share/examples/pipes/README
@@ -0,0 +1,10 @@
+PIPES example test setrans.conf
+
+To use:
+rm -f /etc/selinux/mls/setrans.d/*
+cp setrans.d/*  /etc/selinux/mls/setrans.d
+cp setrans.conf /etc/selinux/mls/setrans.conf
+run_init /etc/init.d/mcstrans restart
+
+To test:
+/usr/share/mcstrans/util/mlstrans-test pipes.test
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index f18f9da9..5ef6a0b9 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1578,12 +1578,14 @@ trans_context(const char *incon, char **rcon) {
 			urange = dashp+1;
 		} else {
 			trans = compute_trans_from_raw(range, domain);
-			if (trans)
+			if (trans) {
 				if (add_cache(domain, range, trans) < 0) {
 					free(trans);
 					free(range);
 					return -1;
 				}
+				break;
+			}
 		}
 
 		if (lrange && urange) {
@@ -1728,6 +1730,7 @@ untrans_context(const char *incon, char **rcon) {
 					free(raw);
 					return -1;
 				}
+				break;
 			} else {
 				log_debug("untrans_context unable to compute raw context %s\n", range);
 			}
-- 
2.52.0

