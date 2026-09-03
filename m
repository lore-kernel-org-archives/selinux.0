Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34107495056
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435826; cv=none; b=IgyQyKRQ/V8NhK65x/UWFfzQucDrFkmUpH+B0FX9SKuKviqtuMbXrKegvD5lLrt871B/yezUbSh4vOjD1vrsFFugy6MHa3t8RIQcUpd36NYjOsZAgncym8zVv2LfK22TdhpjFsOmaMkDotQFsvOkdQWn9EE3MCbjbMGrqgny0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435826; c=relaxed/simple;
	bh=aXcNsKbj92C6FdpFQd9YUGONiKlKCkWA2zfX8zppvYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUd2I3aN81OVIt0EN5eSY20CMj7/F3aaB5/bedltTj7RTScug9RmVN9DJOwmpYiYu7r5YZyYrEf8udRo5Xd8sgFguBTqiNaoAlXJ6MbxoVstZmKiaWfo2D5EKeKmGTAT/ZNlg29bvcfbOBIqW9U0Vb4gDZ1OOBAZd18wk+6GT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ErLb0Nje; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ErLb0Nje"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1788435369;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uY+U1ww/ol2/9NGT/e9by+pxtOZS9ken2MO9W5uzJ3Y=;
	b=ErLb0NjebYuJxPyy8mapLbvZyuG+C+z+A4Enk1gaU+kXvD73+SSccVQFqcgVJ2cpsxodxx
	x2/66lpO1YlvS6RY2Po/fHtKgM7Rdb3QkZ6mWbesON+AIWOePgcVCJPetFq6iIvuBGqL2I
	HDiCS4sCIqtNEYdcQa1n/70ZohL2l6uZXhdcXexm9Bzb619u5L+In4QPKEByOWAN6CScuB
	gFDhBISoJwb9w7S/e0lTootqS8pfVeMevhDg44LdfKcw7S2yiFqvya+VRqcTewAwmvJs8V
	zK4tx2U+M6+vRzmq/Vk/uxLZHEisG9yYk4zANvfoPF9BKSjOOJLR4XcQ53Y44A==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/5] selinux: bounds-check filename transition source types at load
Date: Thu,  3 Sep 2026 13:35:34 +0200
Message-ID: <20260903113538.72942-1-cgoettsche@seltendoof.de>
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

filename_trans_read_helper() validates the target type, target class and
each datum's otype, but the per-datum stypes ebitmap is read without any
bound on its set bits.
Reject a stypes bitmap whose highest set bit is not a defined type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3451a0295cc2..1a60d0f4be55 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2367,6 +2367,10 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		if (rc)
 			goto out;
 
+		rc = -EINVAL;
+		if (ebitmap_get_highest_set_bit(&datum->stypes) >= p->p_types.nprim)
+			goto out;
+
 		rc = next_entry(buf, fp, sizeof(u32));
 		if (rc)
 			goto out;
-- 
2.55.0

