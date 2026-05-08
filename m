Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6928B4E1
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242420; cv=none; b=RcDPiNiRHVca/03aaQ/3knRndN1lpKIbGTt1SAjy2eYoGgiTZVPWf7G3ImQO20auoabMksyOoymjxTq4Plf4vwGLbG9LOxWrUrEJc02CSbPn4tkxYohgFQsKhREKsIfDxKoY1taWgolqJd/djDQ1mgvhUNdeav8s6UvF9ZkkYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242420; c=relaxed/simple;
	bh=VekHy5yKik3l1qgiuyzIGt9xWlxFJ86tWM9+TxSUUeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5vWTNjDGxAc48igRcMZQ0kHMUeRHb7PzVmMjhH8wTiAHh9GgXRWGUjeVkinGD3YxfsFAKz3pC5VqjCkViHyNx5K+AtmgwTdhrws5B/VwBzgqpyIPPfGzomMDjKcWBjZpO0PCJRiH2C5Ai2ixisvsHmPSz6v4MZOFtTXNBVxxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=By7xnrQf; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="By7xnrQf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3i6j8bL7F3/x7awokBdVaqjeKDQVnu4UxTGaLpOpIEU=; b=By7xnrQfDBOoQ1fcUqHszRJM82
	n+Xyzdd439vTMn2Zu5shb0B4LhWMDZUxioX92QQBb3QetrCnln8BSm/Kg6DEEfXqgXnctQLviWvjw
	2JamC/AwmxI52QshBTcwLCgOVkj/bMfzvHnSGRM2EcwgqUwDA2TY9dpZI5zYKW/ctifUvpSSKFxO+
	7KzB12oEKYF+dNVaoFkxyE3m+vxvKGXnmmgd0+9Oye4JwwbMigmsk0D0h7KitVKvQhWv20wUDemFX
	RDwSjQfjSMis7yNCLDUGAqHMLM81rd3MVYmf/u+zvEWGu8PkAnZUQBToFFJgOJj3ibiuV5CWGO/BP
	jcvV0n0Q==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11426 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLK5J-0000000BmhC-1q4W;
	Fri, 08 May 2026 15:13:37 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 0/4] checkpolicy: minor miscellaneous code cleanups
Date: Fri,  8 May 2026 15:13:23 +0300
Message-ID: <20260508121327.91410-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
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

Here are some minor miscellaneous code cleanups.

Kalevi Kolttonen (4):
  checkpolicy: use strcasecmp() instead of two strcmp() calls
  checkpolicy: remove unneeded tests before free() calls
  checkpolicy: add missing strdup() failure checks
  checkpolicy: remove unneeded malloc() casts

 checkpolicy/policy_define.c | 98 ++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 51 deletions(-)

-- 
2.54.0

