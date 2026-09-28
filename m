Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD93783BE
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617620; cv=none; b=gI9tyh7xPFZzN2i7WlZe0ea1cqNWqIIn+5kP3OqFfPS1Kfqvriy+EftmDaDVPD2xGhiz7f0iZAUTe4Epc53PhqQcRs/e1q4qdJ1CixLobkQryuu6X+Ilrg6cxNCYhBpCmLBmi5eaKQSJlJkYWWsHmksZ3yzoAjGoDMdhl6FU6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617620; c=relaxed/simple;
	bh=tvf3wvV276xKEbUycEtUuyeO3QYNURToIqTb9msm6Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHW6j80MtCOsR/RIIixcZS8x1AHLWbMuc/GqQY0OrQdED0OQFoUWg2fzSWQMLYP2V0FRL95U91g1YgxXTTUhEf/CSRnRUU3TtnGgWo59GiGERMr3c40AvpOk2zuWw9uo9be+QRJ/0meRgHatjoJAI+cpRDfER8BJu39bVwiiYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=G4IFf+6b; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="G4IFf+6b"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617617;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNYmLxYBvqiq9CKwauVJ3j1r3OJ2E8EygpKVF5Cx0Fo=;
	b=G4IFf+6b4RvN8pivpq5KTtBtT5TtmJDtnOda+OiX0/sb4dlZ67oOOMIR1KzxQaky/mxahh
	9mfJbZNGzSPwWaECltffS6y2+UaIzWlcmBRgDlLVFBvMHKllnoVJdu10c3c1qKJ7q+b4a3
	j412cbj5pI7NO8aIkeQPD7PghOZ+5rTr8b6gmkGBLEVl+BuMuxhqMeWGCUl41gPtst/Ffj
	8VohWhsdI4JUjXfN9VWnxLf04GexXzSY85ROMhrYYAEe5IMOWs/DoM/U/K6REZ2comZp9T
	wZlraimDnZrYRYTcQ/qUCdqLZ+ONL0n/eY8I8zWI5jJtr2YyHBNk/AKRxqNkig==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 04/32] selinux: use vmemdup_user() for policy loading
Date: Mon, 28 Sep 2026 19:46:14 +0200
Message-ID: <20260928174643.2458710-3-cgoettsche@seltendoof.de>
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

Replace the open-coded vmalloc() + copy_from_user() in sel_write_load()
with vmemdup_user().

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ca821a812691..42cfef5fcca2 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -543,13 +543,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		return length;
 
-	data = vmalloc(count);
-	if (!data)
-		return -ENOMEM;
-	if (copy_from_user(data, buf, count) != 0) {
-		length = -EFAULT;
-		goto out;
-	}
+	data = vmemdup_user(buf, count);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
 	mutex_lock(&selinux_state.policy_mutex);
 	length = security_load_policy(data, count, &load_state);
@@ -574,8 +570,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 out_unlock:
 	mutex_unlock(&selinux_state.policy_mutex);
-out:
-	vfree(data);
+	kvfree(data);
 	return length;
 }
 
-- 
2.55.0

