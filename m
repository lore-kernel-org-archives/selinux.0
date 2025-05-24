Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844019CC3E
	for <selinux@vger.kernel.org>; Sat, 24 May 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748100759; cv=none; b=gUX46vyQt7UrNi8cZbA7CSAKNPshmj3exLFffrWRrKOpcLllMjZVjEE1i8CT3wjvsGYt7w7bsHEDIwLIDFLHDAxO3PjboZ7CAGrcRfR+M6ktVhNt4Mtg6URjWiKSxtSdnr+B7up5BBfYOr0ct92sOa7uba9oYMjAEpIBJi3Hmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748100759; c=relaxed/simple;
	bh=d5oa58as+NRqca0MuESfRrehFaa/ZFam7Okv9wNkgUg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:Mime-Version; b=I+ljX+boI3+DmUsdHmy8qMrGO6J/Fpz8IHXlr96KA0BZS7hnAOJk7ApxTP+EanWrqnw7mHYbXdyQOqY3ffqn4Vspor+4tlfc6VOo2OSYnpvUjNmpCoWwlFdATdZvBKWAbLWcAJCgcW0SArzanwZGneEJH2uhFveXKY99tl8VYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=Da6f1is5; arc=none smtp.client-ip=62.149.156.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="Da6f1is5"
Received: from [192.168.43.2] ([109.54.131.67])
	by Aruba SMTP with ESMTPSA
	id IqoOuQaLSL0IyIqoPu2KEL; Sat, 24 May 2025 17:29:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1748100565; bh=d5oa58as+NRqca0MuESfRrehFaa/ZFam7Okv9wNkgUg=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=Da6f1is5UY6NW1W3WludxMQ4t9y7UozuO/1773oeAN7pTicV+J63SkB4KVrXa85x3
	 49vNqjx1ZuuB1qtrZspu6332WpPyphPL7t1TBb0WOuEYEyM1OmUTg/6Di+Ganr204U
	 I2fY7nh22T3J+txLZ/mFNEQ4oW8w6G2sG5Y0t/MrVpe2Nod42B7PLzb9l8COOQHM5P
	 XMdrPIKdYX2N5d2TmVzpEQqIzL/UcmDO9fzFKDZlVp+dRswNQBSY6n7zeAPedvfpwF
	 uAxvbVLSwJOs05NtrLcmupsy/ZRhnSMXR4skTmNPqc+GGjgAVPKn5TkPdFBrNdHaPw
	 ckHHMRD7daMoQ==
Message-ID: <1748100564.11369.2.camel@trentalancia.com>
Subject: [PATCH] Only set the initial SID for early-boot userspace tasks if
 the policy supports the new capability
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@vger.kernel.org
Date: Sat, 24 May 2025 17:29:24 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKKpxGeiIrEcm7Vn57BpAiDuCl7WmNsDdBTAq09Fy+tYPLwyM1aWB4yAmTcpdmOEq/t4Fv3Hegpc89h8N5jBTDGVAtdWUMe9BPZoqXtvKQJLm1Yto0Ko
 /e05FDuesAzM1xOncl/DLC76PermPYY4V8tg5psqkqE57FoGBGwjuCBiSJ38APvPoeKkUtXheAiCfSSz0fL0+kOt2TUZZvvcgmQ=

Before the policy is loaded, only set the initial SID
for early-boot userspace tasks if the policy supports
such capability.

Check for POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
otherwise preserve the old behavior of using the
SECINITSID_KERNEL label for early-boot userspace
processes.

Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/hooks.c	2025-05-24 14:37:45.499997561 +0200
+++ b/security/selinux/hooks.c	2025-05-24 14:36:58.453997848 +0200
@@ -2319,7 +2319,7 @@ static int selinux_bprm_creds_for_exec(s
 	 * early boot end up with a label different from SECINITSID_KERNEL
 	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
 	 */
-	if (!selinux_initialized()) {
+	if (!selinux_initialized() && selinux_policycap_userspace_initial_context()) {
 		new_tsec->sid = SECINITSID_INIT;
 		/* also clear the exec_sid just in case */
 		new_tsec->exec_sid = 0;
