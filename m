Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56B13FD93
	for <selinux@vger.kernel.org>; Thu, 16 May 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850957; cv=none; b=LjmoehMhtvB72kBvGbTYLpzaFR0g7r21OyLXAQCK6Q+Xyo0YjFcYmmrOXCRY8MQfT79er2ArbvzkucW7JpI8guFIzvwwUAacSSPaSyWP+myt1l9+W/z2XUWLtVCGOgT1rQ6RZ8+JwPtJNrCOjAuhT08ee+HNy+TiAAhLXArIrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850957; c=relaxed/simple;
	bh=B4ocFBNvOdhGocu0AsPy1qb1IjWcomFMPp8+T9ktqdI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gVW2Z/mJbShCa3RbVgX466jQ16JLTKKtxCY/PsCTTKF+kDFuhjBLApv4ixONvMq4r1nVGdjLW23O5qpNEfP6LSd+yB4LApCm/VyqPoGBkD00eLkH1jJpM37dtMReP6ptUA0UpeYe2qO+EUNSNdho8hdnMH7qJF1ZJkVScqS6qW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9fL3/Tr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9fL3/Tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715850954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=f7iMN7oQko6zC1Zvoet+ReFLU62XTephKFE2nnJyoQc=;
	b=f9fL3/Tr9WzhBSPkPAc3u8iyaEYX/RqQhQZr6Tb2P1/cb8rnBVFzu/tv/spn40SrxbaSVc
	P1x+D2roKKuGXMCMjTCuZRDt7R3bOp8KxH7OTBf4o683+TYXk4eUUb6CCI8PL8ZDXUQwwj
	daAkTyYgONja7UOweh60vM6WJfVfVhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-BuLmOaUwMJCfoe07uCZyNw-1; Thu, 16 May 2024 05:15:52 -0400
X-MC-Unique: BuLmOaUwMJCfoe07uCZyNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D541E812296
	for <selinux@vger.kernel.org>; Thu, 16 May 2024 09:15:51 +0000 (UTC)
Received: from localhost (unknown [10.45.225.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96885100046D
	for <selinux@vger.kernel.org>; Thu, 16 May 2024 09:15:51 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Intent to release 3.7
Date: Thu, 16 May 2024 11:15:50 +0200
Message-ID: <87v83eyv5l.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hello,

It's been almost 6 months since the last release so we're going to start
the release process.

I'll tag and announce 3.7-rc1 on next Wednesday, May 22, 2024 and
continue with next rcX every two weeks. The target for the final release
is Wednesday, June 19, 2024. 

Petr

