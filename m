Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97121128D
	for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572978; cv=none; b=cvq7MWc/obeaatS/E8B1JOWgmfJZqO/ypkCfmbgIfGv8Ld36v6rhWmgvDxZkhf6VTNQARDIDORTPrPrrXXqJlcwzjdz2QsPnfi76vovWZ1dQYTnUEioUWXiQgAASSJF01ClEOEjy2ZASpFbmob6HImseEfHiDTWPmuIfWtiWTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572978; c=relaxed/simple;
	bh=sRTmSn4SrAioTPB6CcShYQgas+FSdG02rmqX9xhj+OE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aoz2QooGqUe4qKZuOXHUdsGzM5zdyn+Ecr16GMvoTbyAa6iah2tqLS38gtPyD57y230uQb1C/v6z/jZGC6hlQYMJh3B+LAA9PWJXBdbHLFQTRHpZjHz2UizkF4AckW459HMEyaIn7Ufovte46fx/WoEJgtOpCS3JRmtvLxtZRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlGPTPOn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlGPTPOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737572976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=r8fhyZKaaksTgmKcYJr6zSPCLyggixEJhCWN8sFra3c=;
	b=GlGPTPOnOrzMB+gP+cEwf7X/p/rGOizVO+AB1onZL+GO6OyblOw7/DprmDo7HKipI4vvfA
	5hfhoiz5WLyft2GO+Df7r4j0P4HEuaVHzxzE8QbyWI9oXbmeLl53aDHWXcMy2tXdoFuHqO
	8h2C66j7T0YBlW53334hddjrnGBMkoE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-UG-YEVcfOzudIPmCdaGZLA-1; Wed,
 22 Jan 2025 14:09:34 -0500
X-MC-Unique: UG-YEVcfOzudIPmCdaGZLA-1
X-Mimecast-MFC-AGG-ID: UG-YEVcfOzudIPmCdaGZLA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB6DF1956052
	for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 19:09:33 +0000 (UTC)
Received: from localhost (unknown [10.45.224.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B31919560A7
	for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 19:09:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: 3.8 postponed to the next week
Date: Wed, 22 Jan 2025 20:09:31 +0100
Message-ID: <875xm64qdw.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi,

there's a regression found between libsemanage and libselinux [1] 

But Thanks to Jim, there's already a candidate for fix [2] which needs
to be tested.

So we've decided to postponed 3.8 to the next week.

[1] https://lore.kernel.org/selinux/878qr54dd8.fsf@redhat.com/T/#u
[2] https://lore.kernel.org/selinux/20250122155828.151233-1-jwcart2@gmail.com/T/#t

Petr

