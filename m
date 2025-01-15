Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BA24169F
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946822; cv=none; b=SPY81PENmLBc73QjKcx7pC3dbCZ6JkSnpX4WM9PaR8ILeCE9SanR7QdnVgsNT6n4DoH9Bp/yXiO89rcig9I7p+rl3zp/1BzqG2LWx7p17uEk766UaxHJ9KdfzeobhXD79vEq5biLZbZiXMFdGeZKlaO+nw+FKDtOquLBE5jONaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946822; c=relaxed/simple;
	bh=iLw2zhzYaMGCbfepMz1FoJd3lwW9GbQHi125y+fEiB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni4d+Zgq0KzTyRsDZZQMsz6tplRlsdGj1C4DDFTgOp3zE+m+pCkE1Ldt6snxsoL2Wb0tV55wv3EfeTUcIvcSEz/I/OftqV4eN3ul6wfnBWFiAL3cwTT8ijqiB6fU3CF0gfDdfeXKbNm14DV7A08KANxzNt68yNcT+ohsvqUj7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=MqLwD4xs; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="MqLwD4xs"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736946815;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XithOf6M7STv6wMNF7emnD1al7QNo1xxyJumX8nUISY=;
	b=MqLwD4xsY3CE+GV6NeriWyNipVDDSsnClY7wqyrHJpwYzYZtMpP3Hf8zQSwigfGQ6lQl50
	CHF4PlCfjALFlC6vhD04+vtvtV1rDatzlp+effOQRsUs+Fv4Q5Yef72OfTt3BT/w3jMuyp
	1o0nxlVYcqR29+Ds0nN3j53MK51HhTq+IdQ1kr0odo+xiA3AodUx96NZiB36yss0GKpWTs
	RnGWfK4VyQsc3MYiFlZrGrv0CwjmPyb4FOrwDOAkj9C4K9bFYhIHk6fG4D0X129kRDJOFq
	BR5x5KB88uPz+kanDk/4skztW7N6AsfiNU2PTPeMGOU2SUbLJVSq/31+VdRh7g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/5] checkpolicy: remove unneeded queue_head()
Date: Wed, 15 Jan 2025 14:13:26 +0100
Message-ID: <20250115131329.132477-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250115131329.132477-1-cgoettsche@seltendoof.de>
References: <20250115131329.132477-1-cgoettsche@seltendoof.de>
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

Just check the value of the subsequent queue_remove() call.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 96a481f7..275ef5fe 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4686,14 +4686,13 @@ static int parse_security_context(context_struct_t * c)
 
 	if (mlspol) {
 		/* extract the low sensitivity */
-		id = (char *)queue_head(id_queue);
+		id = (char *)queue_remove(id_queue);
 		if (!id) {
 			yyerror("no sensitivity name for sid context"
 				" definition?");
 			return -1;
 		}
 
-		id = (char *)queue_remove(id_queue);
 		for (l = 0; l < 2; l++) {
 			levdatum = (level_datum_t *)
 			    hashtab_search(policydbp->p_levels.table,
-- 
2.47.1

