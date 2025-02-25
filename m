Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541425B67D
	for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470167; cv=none; b=XcthUyZz1OjPNx8O5kk8kuyONu7zSVzYrt9ErrNNcsadpaZAJkkfASmDXMxhgmmTfBxe7XGzOUJox0G95qMcT1clKB1/+rZFbCkTHGJIP0NVohuSc0EodR0cbV5bKC67ZSNwbAZPkioo6O0mgBbI1KRAe/hK8MZdfPP7t14YOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470167; c=relaxed/simple;
	bh=nX+JcrvA2VN5NPf/pvOm4HstWSSTBQrrT76sls4OnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=ZC5DHc037Y67KLQSlWZvrEUCV9WQJz5YVgx5APDKhcf0uE0eS5GkC8vqidocauP8NB59ItMG1F0eM7JGvoBbTRtimbjX5f1It2KbCI10UMByt1vc07TaTsOtQPfUZYedUavggKd0tbDPTaeIP2PMusjgivrJGBVLG6d/xcQo2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrjAFFMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrjAFFMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740470163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hAjpv4Hzpp7J+PVk3mbqTKKuT8TTd9TIOAhB2feG2r4=;
	b=IrjAFFMjxjzDy9leyF/l7k2gjN9tB3+BGDizCTEGU8e6+aT85GTnyxoSahqKO47gRRArKX
	NXMdpDKWvpHYDUjXaGxkrqhCSUp0AwbfygU/cbbgUWNuRwdP0DDLX5GHEq8H2gvqbpXRTy
	6KzPLBFopttcNe9sUTOzBositWcR0qI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-JXbrXs2GMIehjjpPTlNlng-1; Tue,
 25 Feb 2025 02:56:01 -0500
X-MC-Unique: JXbrXs2GMIehjjpPTlNlng-1
X-Mimecast-MFC-AGG-ID: JXbrXs2GMIehjjpPTlNlng_1740470160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B78C919560BC
	for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 07:56:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8434E19560A3;
	Tue, 25 Feb 2025 07:55:59 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] libsemanage: improve performance of semanage store rebuild
Date: Tue, 25 Feb 2025 08:55:23 +0100
Message-ID: <20250225075555.16136-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 9d107ab77ba4 ("libsemanage: Set new restorecon handle before doing restorecon
") added reopeniong selabel handle every time semanage_setfiles() is
called. It means that during `semodule -B`, `selabel_close()` and
`selabel_open()` could be called more than 1800x what could have a
significant performance impact.

It should be enough to reopen selabel handle just after semanage commit
when changes are applied.

Before 9d107ab77ba4:
    semodule -B  5.84s user 0.52s system 96% cpu 6.585 total

After 9d107ab77ba4:
    semodule -B  11.15s user 0.64s system 98% cpu 11.952 total

With this patch:
    semodule -B  5.51s user 0.41s system 98% cpu 6.014 total

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsemanage/src/semanage_store.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index cf9aa809b7f8..307f27f9838b 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1712,6 +1712,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	    semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
 	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
 	struct stat buf;
+	struct selabel_handle *sehandle;
 
 	/* update the commit number */
 	if ((commit_number = semanage_direct_get_serial(sh)) < 0) {
@@ -1822,6 +1823,8 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 
       cleanup:
 	semanage_release_active_lock(sh);
+	sehandle = selinux_restorecon_default_handle();
+	selinux_restorecon_set_sehandle(sehandle);
 	return retval;
 }
 
@@ -3012,14 +3015,10 @@ log_callback_mute(__attribute__((unused)) int type, __attribute__((unused)) cons
 void semanage_setfiles(semanage_handle_t * sh, const char *path){
 	struct stat sb;
 	int fd;
-	struct selabel_handle *sehandle;
 
 	union selinux_callback cb_orig = selinux_get_callback(SELINUX_CB_LOG);
 	union selinux_callback cb = { .func_log = log_callback_mute };
 
-	sehandle = selinux_restorecon_default_handle();
-	selinux_restorecon_set_sehandle(sehandle);
-
 	/* Mute all logs */
 	selinux_set_callback(SELINUX_CB_LOG, cb);
 
-- 
2.48.1

