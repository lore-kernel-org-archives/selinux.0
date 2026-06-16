Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9933D34AD
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632399; cv=none; b=EDnqqGv34z34iY8JsnaEAYhNpw0hvbmIiyQXWzEIKi/nSd5CwroYRgQAGIHZ1rL7UdPkTg2+biRdy0b6yS5HTCV3LARu0tN5rN6MPkWBQcJo/IhJ4MKrUD/XYeLTw1hyAHtArJX6ad2tkV7EdV5jd/m3Cjm41LeyI+nVrE+1hMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632399; c=relaxed/simple;
	bh=cgCYHM6V4IHL+VWu0DewJca9m8jd/F9oudpqqwA2h/Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=geIN0IyJqL8y57IivKHc2K4ek3KsPApB1nO61VNZHOREPd44a4ioLi/MVKnkuSUFuA8Tt/xMwtdORdV6pziQ2tZzlpRxl4KbsOl6Anp2Nea2U3IZgWZasEfYqXxtJUhf6LqF+sZAu+PWuL/F87gEqC9gblDVxyhOIcVDip4Xd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=pR5Blwkz; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="pR5Blwkz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cgCYHM6V4IHL+VWu0DewJca9m8jd/F9oudpqqwA2h/Y=; b=pR5Blwkzymr1UE1TRNehI7eSnh
	XZliVZKJ6U7xtOUF5rMftC2AJS9JOFepfrJ9OTbWbmaiex5MJ8xLlDC5kgnbwn8N+1UgqYqfxUk64
	d+yK+MSMjej8Wkw8kh938KJQu/tuG3vR/QQixeQizaVs7BmFTqKb3qw0r73ep4qab3fhnV7pSLNuc
	Z4z6PYz9fEeG1EqXTMmWmOuY0CmmpiyQRL1/Ue2pIzItI6q44LbvWg856GEHrUqowYk4eO0ihnuKr
	82PmW7yHGa9OZzt4buPJMBIdz6bkrIt64F0sGbbnu3OoBsEGmCL9cE+I/apmIawV+UgNnTeuMjgkF
	z/p9jBWQ==;
Received: from [87.95.76.183] (port=4512 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZXyG-00000000Uss-1JfG
	for selinux@vger.kernel.org;
	Tue, 16 Jun 2026 20:53:06 +0300
Date: Tue, 16 Jun 2026 20:53:04 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: About SELinux userspace AVC
Message-ID: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2>
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

When going through the SELinux userspace code base,
I found out that AVC is available in userspace too.

Just curious, does anyone know if there are many
applications that use this feature? As far as I know,
most of the AVC decisions happen in the kernel side.

br,
KK
