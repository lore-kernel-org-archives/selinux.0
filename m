Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EF140E30
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590218; cv=none; b=jd3r7hbSpEod/9eGEgJVygRECCIZ/jwHeoyPHcF0ZkrDVFXTUDRwDw9h7+ZvLiKn4fecxJtWlbJG5odaMKHW8EMXbRcoO6+9YOTFBbNxb1pY0pGOtZt5ge7tic7E4P3CjuRCVfYgzIuuhH0dAx86r5Pc2lu1h245Wy8brgbllWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590218; c=relaxed/simple;
	bh=GLIC9M0eCW7AiHzNC/npr+6yq3htQM+wkNT6IrTyXG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bu79cbfAKHSbJURHvImrw7kAjEC4CKtN4wNH8xSBGQ/iloPGePjtIo5RerWi0NoJU89FtI3YRIDmPdLPZYMRSQO80yLlDXuGssXQmbWI8xGUBQgK2RRjKXtxhQMBgRvzDvek4acuxkroJLtkrykglhTJBPojhj0hrOeOSlJKki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=FLYYJfGc; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="FLYYJfGc"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712590214;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7SffyRqayEu4qpSG3ETHsvIL5iZxPTZ2IRgwqO2fqA=;
	b=FLYYJfGcLcg48JlBLXpY4TFiEXRf2SvV/O872uNE4MRYaOT7pdqIxuqzB1JRZp7I51s4tC
	57CyKQSRqv9NRu3BURgAPVDYledE6qHblI6r4UKFXLUEpBLV4GrPTLWNpTP1GSek8puII6
	Yo2MatqyrRxsHnUKn62sBqHKQSPh+1Yl7ZbD0Y5WhEx4lATgkF8awrYOb1rMJFU0ML5VSk
	7okUCkZpWK/bevbqusW5Vcp8NXD3ieCDNRwx1L/7mnkSPOaWJ+YJ45Hhr043xLHHwKagZD
	CygZ6yIEYcxgLmg1RBEIWF8BB4DIOUK7ZSAbKoGBS1Ydm8DWuXWetmTaQQhoGg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 2/3] newrole: cleanse shadow data hold by libc
Date: Mon,  8 Apr 2024 17:30:05 +0200
Message-ID: <20240408153006.69840-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240408153006.69840-1-cgoettsche@seltendoof.de>
References: <20240408153006.69840-1-cgoettsche@seltendoof.de>
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

Override the memory holding the retrieved password after usage to avoid
potential leaks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 1e01d2ef..59a5caa3 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -388,6 +388,7 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	/* Ask user to input unencrypted password */
 	if (!(unencrypted_password_s = getpass(PASSWORD_PROMPT))) {
 		fprintf(stderr, _("getpass cannot open /dev/tty\n"));
+		memzero(p_shadow_line->sp_pwdp, strlen(p_shadow_line->sp_pwdp));
 		return 0;
 	}
 
@@ -398,11 +399,13 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	memzero(unencrypted_password_s, strlen(unencrypted_password_s));
 	if (errno || !encrypted_password_s) {
 		fprintf(stderr, _("Cannot encrypt password.\n"));
+		memzero(p_shadow_line->sp_pwdp, strlen(p_shadow_line->sp_pwdp));
 		return 0;
 	}
 
 	ret = streq_constant(encrypted_password_s, p_shadow_line->sp_pwdp);
 	memzero(encrypted_password_s, strlen(encrypted_password_s));
+	memzero(p_shadow_line->sp_pwdp, strlen(p_shadow_line->sp_pwdp));
 	return ret;
 }
 #endif				/* if/else USE_PAM */
-- 
2.43.0

