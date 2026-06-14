Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABA31A556
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781440168; cv=none; b=PR1MIXMxOLfoemsbL+XWhiG+ilMrxDE5tHvPM6F+ZJ850V7gYqXHf3cOZzIJcCP0gwtmYKl4SQGstzPOadJgUYy7/FooXoCpa/f8rMTGA4OnqXhhg+lnl1ak+Xe6K5kQmIp19Vui1W8OafCix+OywJQjcXg0hA9dtCzNftoR3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781440168; c=relaxed/simple;
	bh=/ke9idt3rLLyou+/f7BXv54pJcEP3QPZz4YlWrTOEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdR0hvpxJ6+D/p+I31W4fVna8SdXVWsZSgPC6awzmEwl3AnKr5KDkBlzD05sa1XhvnHQq2riUhNeS0EvrLqOK2HcFgtzOXXZONfDmDcgQZLppyzKV7GCl8RctYChihuD7nhtE6l7Mrt6Y9LPCkRm/Oglzy0Lg0zrxCmCxy3mzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=aEfyKq9S; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="aEfyKq9S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3lG/lmPZy+MmFAv2dJ0aVDy5sjPZhQVEY8OZB1cKEwo=; b=aEfyKq9Sp/d7WXxbyhDB7EC7Au
	1SRfv8qq8IiJMu2yXuxqtfJ9BmUFqXzsxiRldORbz6wdoZnjSCqWqX7ND/as2MFyYPYFAguzzyJ9i
	TkWPef1szPpyqVmi2w0cfgdGGZtVvUuiWYPWAKf6CBAgiAtLk8Ql9ueqiYacgli5B4QtpYWWUos55
	ENgUXqjLKdZMN/5pGtO/2XXYydCROyy9M20IJ8esLRq04/gyYNK8q/OWpyrAAspuVcrMn70cGCqIJ
	P+wCVt4JwFzpNpv9KqDlnZoEam2JBYfVqzKeqD4cVrKJFnoytS3wWUpy3ESrXBdvH/jfnETGevixq
	/UEurBow==;
Received: from 87-95-76-183.bb.dnainternet.fi ([87.95.76.183]:4557 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYjxm-00000007yqE-0PZz;
	Sun, 14 Jun 2026 15:29:18 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 0/2] policycoreutils: use stderr and null character
Date: Sun, 14 Jun 2026 15:29:02 +0300
Message-ID: <20260614122904.29873-1-kalevi@kolttonen.fi>
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

policycoreutils: Use stderr for error messages. Use null
character in a string.

Kalevi Kolttonen (2):
  policycoreutils: use stderr for error messages
  policycoreutils: use null character in a string

 policycoreutils/sestatus/sestatus.c | 52 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 24 deletions(-)

-- 
2.54.0

