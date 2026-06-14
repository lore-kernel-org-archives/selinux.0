Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC2526F2AF
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781447818; cv=none; b=XlIdDqvnJOQdxI0uQ6IkSn1Mixi64pvA09FMR1lrIhi1Ect43N14kCDgXHoMGDSXRMFNugAC3vtLmPv7tRkIt1efTBb/4Bcmb8t6cQlgMAJxRONeHzqmt507VS7JOmMiMbzgEy0NqMvNPt2Rn/sbfJSvPhEeytxuNPNUPuXp5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781447818; c=relaxed/simple;
	bh=/8UdSbE/jjfEAVezTrata6OM4w7Sd1W2pFBPee/EOnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5w2zdoOLAesXayOp/Bwm1j8wSM8XHcgQ7s0q/gYZRBA2Eq9zs3if9hHBS7zVHyXRwv7jOgEskUMW6b6vj16Iepuq2BJ891kxSfAW9vnALqtuZc+IuQK4LmknPhDmxd3w1x8UvuHCxOYoE6GsZKrdGr+fgh7fFzLQPpolHrlNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=vw/ud3ar; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="vw/ud3ar"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6qYjM+LJJdMfJ+yQAPDeZGewqQZjav3PsJbNhrzyljU=; b=vw/ud3arRzL/IO0IVv2d4yYzvR
	1oBOPHNs6gatqlH5fkuqJt3mtlCY1eNh6r/r+4Zh5+6C10lWLZKSFGzptctY4qRSZt7V1176r4su+
	yQ09lNHn8IR8/0O7XSO1vF112ZhaEqqZq4YWl6Hgz0dEkwq9eXPWMGxY7ueTAnEel1DzJRQNbJ48I
	gsFz1jIuyyNA88yrEPt4c2wBCywzoTZeq6pP4EXiVEhR+LmCUZURchJnWvu1T7Kp4H0gwXPDFbfaU
	44SBLn1zGvCrYY+LJn/F0DCNGF6s0heaOqdJH1+7xiZALLqmHAH9V/LO5F/4XbY64/FU1lO5gK63n
	Y0s1YXHg==;
Received: from [87.95.76.183] (port=4493 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYlxE-00000008PB3-49um;
	Sun, 14 Jun 2026 17:36:53 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 0/2] policycoreutils: strdup() check, use null character
Date: Sun, 14 Jun 2026 17:36:43 +0300
Message-ID: <20260614143645.55809-1-kalevi@kolttonen.fi>
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

policycoreutils: Use null character in strings. Check strdup() failure.

Kalevi Kolttonen (2):
  policycoreutils: use null character in strings
  policycoreutils: check strdup() failure

 policycoreutils/secon/secon.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.54.0

