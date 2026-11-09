Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238709;
	b=eOpg272iUCMegaAPJplfXSqSyFuTWzcjJy9SpZsLGcq2xrttPy0frDaHIdlg7kZW7k17
	 Trd9LQQ9DuhfQrtYzYHy4/j5RfJ1hh0rfrSAQHv+bp+i2rEiIEtd/s3i6smH95j729kSV
	 OKsNPnETRJeJGU80ilgqa02L/D69Fxv1phI5TcPKmN7VsrpC+vR6o+nQpk2CtpFimxUzb
	 CwbOHfUlsf+/QWZCIqgj0i7++PKOmNXNlO5z6ImB5075YoGdFKtotQ+ka8EDdMIcrvRbf
	 6FQspTG/lrc4rSWt9WgMNq+ea2wHNCffNIJGZtFI2RP+mnVsKBw4iG/t/OJmDYwfOAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238709;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kRTOSOAgyO1FRznoPqL9r1KdI6pxSL3wTHiTlIBblUc=;
	b=cG8kIcBUZ2djc7tmTkv7GW8aRBxwKEQOKAINi4fzXEAM0NIMixCQD6cEdVxNG7bw8skR
	 r7GhAETr20OA3G+MXzoBdLyFgpMQY/rrxtfGijPzXiBkblasRJRcndu5Z8ldAea0qhe8f
	 mnnXSAPijb+uRru/kmj0K3zRt7nk6TGk8X0+hC7jrhuOH8+fZ56lpDNUaO27lgZiQxmQJ
	 8zfoHTf6T4o8avCEWJgmYm6jztU3SKsPy6EHKe5Pt0USb+3hFYvIVkYEPQA+mpxPaEyPu
	 eIKOWHwSN+PkUYj8FW0V4B3SbbeFP+bWNKMRyWxeJRPwzEDC4hWBQ8Bo9xxfxdg+0uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=GwvKPOWt;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB216606A32A
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB216606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=GwvKPOWt
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794238700;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRTOSOAgyO1FRznoPqL9r1KdI6pxSL3wTHiTlIBblUc=;
	b=GwvKPOWtu5TmVqVb1eZkv12AE8QrYyOl9aGx9TdN1I3fWHIiXIhJBCnSRM995+pa2Q8KDJ
	fa6+O/nrSwIm8KL+VIdD72QEqX4ewbvDpnKal9VxCdcuRF6v+Zf1evYfq7Hr1+3YPfAYoC
	TGY4pICLeS/ce4qZRnPQ7+SJUZo50VsLv2tPbqnSHlFWXQW9xOYpfqpiO3DPbLtrcrEAAJ
	o4dVaZXFLRln6jhcN3blY1rqD313ifbqG4u72BvFb4uN0gOCGPRIOA3BtDNk67OBGwRlH3
	buyUrBCgiAlorpy+gDN23xaWwGeNDpksO9+Sa4n66yVh0KrGVgpN3BdClAaKVQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 5/5] selinux: do not cache permissive grants after enabling enforcing mode
Date: Mon,  9 Nov 2026 16:38:01 +0100
Message-ID: <20261109153802.76176-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261109153802.76176-1-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

In permissive mode avc_denied() allows a denied access and records the
grant in the AVC node via avc_update_node(AVC_CALLBACK_GRANT).  Enabling
enforcing mode relies on the subsequent avc_ss_reset() to flush such
grants.  The enforcing check and the node update are not atomic though:

  CPU A (permissive check)     CPU B (setenforce 1)  CPU C (same access)
  avc_denied()
    enforcing_enabled() false
                               enforcing_set(1)
                               avc_flush()
                                                     cache miss,
                                                     avc_insert()
    avc_update_node(GRANT)
      finds the new node

Toggling enforcing mode does not change the policy seqno, so the node
inserted by CPU C has the same seqno as the decision CPU A checked, and
the seqno check in avc_update_node() does not catch it.  The grant then
stays cached in enforcing mode, and subsequent checks allow the access
without a denial until the node is flushed or reclaimed.  The same
applies to extended permission grants.

Recheck the enforcing mode under the bucket lock before applying a
grant, unless the domain is permissive.  avc_flush() takes every bucket
lock after enforcing_set(), so an update that takes the lock after the
flush of its bucket observes enforcing mode, while any grant applied
before is removed by the flush.  The current access is still allowed,
as it was checked before the switch; only the grant is not cached.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 6dcb4b354d7c..9064f688f553 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -872,6 +872,19 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
 		goto out_unlock;
 	}
 
+	/*
+	 * A grant made in permissive mode must not be cached once enforcing
+	 * mode is enabled.  A concurrent switch to enforcing mode can flush
+	 * the node checked by avc_denied(), after which a new node with the
+	 * same seqno can be inserted.  avc_flush() takes every bucket lock
+	 * after enforcing_set(), so checking again under the lock suffices.
+	 */
+	if (event == AVC_CALLBACK_GRANT && enforcing_enabled() &&
+	    !(orig->ae.avd.flags & AVD_FLAGS_PERMISSIVE)) {
+		avc_node_kill(node);
+		goto out_unlock;
+	}
+
 	/*
 	 * Copy and replace original node.
 	 */
-- 
2.55.0

