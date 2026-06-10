Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6349250C
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106629; cv=none; b=sH9fza2Jk+TQC0SPFWC0CJlpU3TtpM53jZUtdXJrMdBPSyYb0O83o57TM3Ahqx+2rKrxkx7o7RWKriBa1d7L8V812ZrCjop93xrWWz8EaNS2RbplI1muNxWrpcU+JcI/iLCRKyYNeOodoes4msmErpZUlfrHgk+EXpPI6oBu3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106629; c=relaxed/simple;
	bh=JmIKW1QdEKQ3uBe9UifnMSt3Hd6xHy62HC0CE9l0eBY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ohQQtb4PcRVWp/Wn3/QBUk+3VgFxRjtNYlF0uC9TwPX3T2mmgyamAKyJImdbc0ZUBco5Q+zTLPu3CXNz6rmw5kknOi93iBSusi6OVM7CT7rY0z3EbQdL2MmtAbkZpmuKlRR9gy9HBbZw8K6igpKYvk5cH3OT4BkiStrI5BGDs18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=BM5Pntcb; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="BM5Pntcb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GV/5l8p3pXE1DXIZbMM54fCicnBbJqkFvsnxhUIyrFI=; b=BM5PntcbEqZyTytPVWA+txw3hb
	AwJgB2L3SdJzKcScC+btWArRBVUvPOpX1VkDh7In0SWoKI32ZfUYcWUum7f+Sawi9QyZ4bAFVS51A
	0CosRF+SUIpL/zKrZmKEWWF+hLxSPKIeFTUcXHmWNYgPMg70WuqU8GFmav6WjekOVXzDgsnUppUS8
	gYs16xVQOAQePrvnQ45YG1rPOu9T3DY+3qJX6kavreyU/XvIfI33FYC+6Cdb+YCkKX/T6EF9/9uov
	XBYZvlP+xz5EH+jd/mMr8SHdh+WZlqrLVlW2rSwKyyhlZ/Mzkst5p2m3CGmren0NQuOnmschw1BxZ
	bCvTdUYQ==;
Received: from [87.95.76.183] (port=4481 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wXLCD-00000008lgr-2zwO
	for selinux@vger.kernel.org;
	Wed, 10 Jun 2026 18:50:25 +0300
Date: Wed, 10 Jun 2026 18:50:23 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: SELinux userspace build fails on Fedora 44
Message-ID: <aimHv-w8yri0aoB_@AA-94-54-42-0F-E2>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello!

The instructions in README.md no longer work when
building SELinux userspace on Fedora 44. It has
something to do Python 3 as the error is:

python3 -m build --no-isolation --wheel .
/usr/sbin/python3: No module named build
make[2]: *** [Makefile:17: python-build] Error 1

Fedora 44 has:

Name        : python3
Version     : 3.14.5
Release     : 1.fc44

How we do fix this?

br,
KK
