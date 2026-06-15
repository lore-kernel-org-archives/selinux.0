Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79B3B582F
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552717; cv=none; b=JnUzbudGIxE2Xqd/Q6HReZfrYmJNMMS2uKXj/TZnYM/D40PQajj395gyaKs4fQ1W2c/IQ8RwcWvo5RR7AxkrtiiJLFrQUY4TUSL5ergp8sGG7hvsN81SvTRN14i7RkjPD47as07K0rIWppX7acMvc2qO3z48oQAsvos8M2F9KGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552717; c=relaxed/simple;
	bh=jaOd6FInukxk0oMsV3UUstr5yoE6ySpxXqzox6Z4yNw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a4Ha6V3h+M81ItYM3/hubFZtUUZKKDjQKv/tF2rL6QjgqBA7rMa+v2M1pR1vsPwwWu670mF/+tNPI2KBT5otoCYmtF4UOeR5n/fovVShk8hZhOBY3tcF/TAZbOnv7yJPbGXU6uz3wA4hMXBwpkUPCYDJKSL3PB0PuP3LuKclNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=afODyaou; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="afODyaou"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dFQG0a4c15J9ZfKf9OM7Y08XFfFgnS0SA6S4pH2j/8A=; b=afODyaouGndXx8wHZlL0LgLRs9
	XZVQlp1vQIMRRyin4UhumZXU/T1hCgXxqsTXFLvALYdJuBYq8n+SZJZri5uFialw0VLbbLQDpygg2
	xwtjbGRZcEkrK9y6g5tWi5LGhy6v3DJ2vqJuExUT1tI/9H/J/sgiuvnt6ZsqnmOmuKUeMBxWJVLnj
	bQEbGG95GXSBp82wHA7EUHBXNapfhiLTVE4lorhn9As5K34R5YDbHK65MDSFypsjNN4GFJijd68lL
	xB3vZ9jCyn55mnIsQMyzF68eI/VCMXhIslq9tsV+WfKKP/wmn/oDwLaSd14NVZu0WsnheJWtCJl4Z
	boEDDb0A==;
Received: from [87.95.76.183] (port=4392 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZDFB-0000000DzJi-0WMg
	for selinux@vger.kernel.org;
	Mon, 15 Jun 2026 22:45:11 +0300
Date: Mon, 15 Jun 2026 22:45:09 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: Should verify_shell() be in a library?
Message-ID: <ajBWRXiVfNj3T_Dl@AA-94-54-42-0F-E2>
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

While going through SELinux userspace sources, I found out
that verify_shell() is defined as a static function for
both newrole and seunshare. To avoid code duplication, should
this function be in a library instead?

Maybe in:

  libselinux/src/selinux_internal.c
  libselinux/src/selinux_internal.h

br,
KK
