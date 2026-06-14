Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116922D792
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452242; cv=none; b=jCKw8rKwkdhho7osizDI1XM7ZLOAjoCoU7/YgBCqwOZ8m59d/4vrAK+nTRz/oQPlZ8eFkPiga6Ry/Ii6fAASXla+OSJxdmg/g/ZDtlgaLcss9OWMWGIhUAwW/QOZ1RH628PObvCsbO9Wmp55gWQQ8rp6J7He3g+9IZsKJhg0PfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452242; c=relaxed/simple;
	bh=4b4J0J4qc+xo5xe7I35zT0ZGrDwp6xgwTSIxLwoypfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBH8sa9Jnmf+eCQFYQFMoV++MqdQAQE29eCOSYk7DQbZyTeCYI9ARknSsCE0aTfl2/upwwiHNbQB6SGTzdifU8uGiKV8N1EQz5EYqD0lqSAEojq+MpYfp3Ef9l7mOyIqX5VA/waiS5cIRTEbMILdD0/YGB1gsGrk4pwRjCELnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=tN3OR2Qb; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="tN3OR2Qb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u4P0TYycqAh2f7JWX78B7k7n7iUKDfUCeZQnnnKS2Jk=; b=tN3OR2QbMQG0CmpfH8t97SbSrm
	E/THrWgc+tG4FYo24N0BK1qMDunInkeIO7MBK1mASOM9rxLbKplgJQrwpX3+D2Kk0AodB6lfYnUzx
	pVkrQyVDPeEJ7YVNmG2nEXI2Vb7p5N/sSfkdW5MMtqJzPzFhte22R+2PuMcqopQj3W6PHYhAk1pk3
	hd7KgXd/hJU4m8WjTz/opMOfGDCbjD0GrLw08JpmPl/KYEZ1K/FT1wV/mEHA791xjAi+pJOrOKECF
	gqHjtm9PbftONEkISivH+/KHISkC/JInP1BBxQsBGkWnoHgHhygN/u1HTFb/1OTWHbRdvQEHYmKmZ
	iiOK8xFg==;
Received: from [87.95.76.183] (port=4233 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYn6c-00000008cgk-1cx1;
	Sun, 14 Jun 2026 18:50:38 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 0/2] policycoreutils: s/int/bool/ and use null character
Date: Sun, 14 Jun 2026 18:50:28 +0300
Message-ID: <20260614155030.97082-1-kalevi@kolttonen.fi>
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

Use bool instead of int. Use null character in a string.

Kalevi Kolttonen (2):
  policycoreutils: use null character in a string
  policycoreutils: use bool instead of int

 policycoreutils/setfiles/setfiles.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.54.0

