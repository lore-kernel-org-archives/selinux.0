Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4D306486
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668147; cv=none; b=KSKLtXyFXlHlpBf46vFdy5fqoGc9MYsYdy2AaObygHmftr+Do4g51Z5dd5Bn4+wK+vqK5DDnzPvz6Yp0TMMOCtxb3NZJeWkcNyX4Caa4hmatH+KH+QK4XUFdlafNR7yD8jua+djkAYoRcy8SdR89sYq8a5lmTRzYcBjxibNMHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668147; c=relaxed/simple;
	bh=J+bPy6ZANurC6yL9ac57yBtzznncZ+hIE5nplXhzVzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM4Iyz557yHc2aOKhbpnjZqRkehh9ykpx59OSufSL6U9OAVSRsYObVfOyy23dIiRxdyk0R2xqr40tqmerzWJfPRFoCrAldssVjq1r5HFOR16a7o27vJsSfrNWbIxqKukXrEafBsFIZdS2ipudOaHbqy5//BQkmn168+FFPZITo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LtQVJEh+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LtQVJEh+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780668144;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWpo4G/cpbB3HZ6xHOafjA+E1vrovYhG76ZKJmRd+do=;
	b=LtQVJEh+cgPcZwRvqWPOvZJkrjJsVVKRa08g5bREQWEQRNLbistAH0mFlwvFQmpYnVInxO
	In93VEaLBxRF41f0CvvgLefKvyNlsT69VsoQv1WcjpcSJqkltXgA+FejGvgcopUtqoiIIO
	w3RAmc5hqXHD6R2xWYiKLv/9daPCAJlDqvyycaPDzugsUrcRY+cf1YJE9lda+Cd/bI+WCr
	9ma0ywDLCl68ne5SY1Cbl3PTd0nLGpDU7Vf34w9rhVIwlgn0LpFABqsZqX+zg7pYCFeVLp
	OLEYujYPHM1K4Jp9+d+NQ8bUfRa2AI7dtpjDfDD2Cw4ISQm94cikIML+LKLXYQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] libselinux: validate netlink message length before accessing payload
Date: Fri,  5 Jun 2026 16:02:02 +0200
Message-ID: <20260605140203.76848-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-1-cgoettsche@seltendoof.de>
References: <20260605140203.76848-1-cgoettsche@seltendoof.de>
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

avc_netlink_process() cast NLMSG_DATA(nlh) to selnl_msg_setenforce,
selnl_msg_policyload or nlmsgerr and dereferenced it without checking
that nlmsg_len was large enough to contain that payload.  A short
message would lead to reading past the received data (into the
uninitialized remainder of the stack receive buffer).

The SELinux netlink socket only accepts messages from the kernel
(avc_netlink_receive() rejects packets whose source pid is non-zero),
so this is not a reachable vulnerability, but the payload size should
be validated as defense in depth before being trusted.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_internal.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 41257ee6..ec19010a 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -204,7 +204,15 @@ static int avc_netlink_process(void *buf)
 
 	switch (nlh->nlmsg_type) {
 	case NLMSG_ERROR: {
-		struct nlmsgerr *err = NLMSG_DATA(nlh);
+		struct nlmsgerr *err;
+
+		if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*err))) {
+			avc_log(SELINUX_WARNING,
+				"%s:  warning: truncated netlink message\n",
+				avc_prefix);
+			return -1;
+		}
+		err = NLMSG_DATA(nlh);
 
 		/* Netlink ack */
 		if (err->error == 0)
@@ -217,7 +225,15 @@ static int avc_netlink_process(void *buf)
 	}
 
 	case SELNL_MSG_SETENFORCE: {
-		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
+		struct selnl_msg_setenforce *msg;
+
+		if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*msg))) {
+			avc_log(SELINUX_WARNING,
+				"%s:  warning: truncated netlink message\n",
+				avc_prefix);
+			return -1;
+		}
+		msg = NLMSG_DATA(nlh);
 		rc = avc_process_setenforce(!!msg->val);
 		if (rc < 0)
 			return rc;
@@ -225,7 +241,15 @@ static int avc_netlink_process(void *buf)
 	}
 
 	case SELNL_MSG_POLICYLOAD: {
-		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
+		struct selnl_msg_policyload *msg;
+
+		if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*msg))) {
+			avc_log(SELINUX_WARNING,
+				"%s:  warning: truncated netlink message\n",
+				avc_prefix);
+			return -1;
+		}
+		msg = NLMSG_DATA(nlh);
 		rc = avc_process_policyload(msg->seqno);
 		if (rc < 0)
 			return rc;
-- 
2.53.0

