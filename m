Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9A3DCD9F
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242434; cv=none; b=HUjfzscKxdNwZkWMZLvRSO6AiyDE/uQq2AIvP/s1WpSfdO3R2xK2UOKuZGP5ko0cQyk3M2Xs8bb6uz5gOhhcKW5jKv6ldWJnwcnVQxCSzTxceeLKenNEMccJpJuFe9uSVp40DyS3uc0Efkq+Xi0MNAw7C5FIQMnM94pIMoYF2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242434; c=relaxed/simple;
	bh=wk/MQQvle+ttD+y6aFsA77zTXEykC6uWE9ptW//p1/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaG1YmkORglG97ckAFfPdBS+TCDuQWZK96DOksuPi9rbhgC845/6N+oAxB0Nys0puGOeTdyLvcjelPncMsMh6/eOnHYxLG/1mDRWG6ozuxhsvmOp058vTGloR+LSTXRqAeXPtryM7bGhNkliAi4PI2yEBfopCuWiNblhlnH0mlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=AoyrEk4g; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="AoyrEk4g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/cwMRxjQ3uM+IdHz7Jw5DCyyVnZGyXR0C6zACOrY5Yc=; b=AoyrEk4gekdYzoRNEYe/pOy78i
	N+V49NyjOVRQV8mWHEgZ8FUp4uK5EBgRYt+83QpJmFKGnf0Hbq9ECeSAv34sR1Srn8xzshcSHC6Cl
	kRr2tjM2+ZVR/+tGjnA9+ypQU/vKZ1Q8urwN9/cR4Qb7bApRYAdc1GnOPn1PJwpp1lpL3rfOU3CpT
	Boe2MWd8W8jSmIdGUIamQkkjduUvoGJxGA7zg+Lt5FdXYQmTH0NrM3za4qtVohXH03PuJ2PdibfWe
	XCIED5kfH3qgmiN/4pZeEi+koC4ehmTGU6k6OfWIUl9oMrPhjc4XV5Q9kJQkdnNep2iJGUJb1Ll6M
	DQ9/sN3w==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11426 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLK5W-0000000BmhC-40BZ;
	Fri, 08 May 2026 15:13:50 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 3/4] checkpolicy: add missing strdup() failure checks
Date: Fri,  8 May 2026 15:13:26 +0300
Message-ID: <20260508121327.91410-4-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508121327.91410-1-kalevi@kolttonen.fi>
References: <20260508121327.91410-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

add missing strdup() failure checks. Also add one missing
'return -1' statement on error.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 checkpolicy/policy_define.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4f775111..755a8428 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1499,10 +1499,15 @@ static int define_typebounds_helper(const char *bounds_id, const char *type_id)
 	}
 
 	id = strdup(type_id);
+	if (!id) {
+		yyerror("Out of memory!");
+		return -1;
+	}
 	value = (type->flavor != TYPE_ALIAS) ? type->s.value : type->primary;
 	type = get_local_type(id, value, 0);
 	if (!type) {
 		yyerror("Out of memory!");
+		return -1;
 	}
 
 	if (!type->bounds)
@@ -3559,6 +3564,10 @@ int define_filename_trans(void)
 		append_filename_trans(ftr);
 
 		ftr->name = strdup(name);
+		if (!ftr->name) {
+			yyerror("out of memory");
+			goto bad;
+		}
 		if (type_set_cpy(&ftr->stypes, &stypes)) {
 			yyerror("out of memory");
 			goto bad;
@@ -4510,6 +4519,10 @@ int define_user(void)
 	}
 
 	id = strdup(username);
+	if (!id) {
+		yyerror("out of memory");
+		return -1;
+	}
 
 	if ((usrdatum = declare_user()) == NULL) {
 		free(id);
-- 
2.54.0

