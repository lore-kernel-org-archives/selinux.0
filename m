Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48580604
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356414; cv=none; b=dAMyfhMGAgt5dmue+JKKJg13Z6+7URMvZohfNYGFJ2R2F8N8PJ2pXnGfE9RSzc2m0w6ASnsewK6MrXbw9NzOzjoH96y9EjezSMmfjqGR/sydMBR+n0dv6CbwmQ86T6fMJEFyviOztwyj7SyT8TvtXEih5PTljl0OlUMjuxTgg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356414; c=relaxed/simple;
	bh=VrnGtO1n4djP3QV8+oHU5FwiXGtuh6y9ZCFCRHXPn3I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1ZIZw5bfdYNkPFfYf1Suztzu200/X/izJIq80V+nwfiIKdDT2J/ip2yvY0n57CfQysYaCNRE3WzTUuO47EusHNLc8B6bNc7jYWU1yYZroDu6A/XwjeJsGDv1pb9G0QTcynp3zyjgUCpl9lPoeZMoG77UkX1EZf5hEebdDHOrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh/AOxtO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh/AOxtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736356410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=dgyyrShb5NRLrXLaQmN/sYiNMN5JNQ4sTYBVBhe+USc=;
	b=Oh/AOxtOiCtZDzV+kwx6LHU7gSTuavEYoIjTKSaVTeL1eh5/+UuIIF4j3FG/8oVeMqVOUL
	60Hg5qKkXdv68mo5L0BGgEW991CnBwgl3zO4tHbJpwf5aQ05Va4foLwdq2/aIaLJOusIoS
	sH07yA3UVfbni3kNLUt1N2hOA85RyPI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-EZn_1EEqMquBnEozDkPd5g-1; Wed,
 08 Jan 2025 12:13:28 -0500
X-MC-Unique: EZn_1EEqMquBnEozDkPd5g-1
X-Mimecast-MFC-AGG-ID: EZn_1EEqMquBnEozDkPd5g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16E86195609F
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 17:13:28 +0000 (UTC)
Received: from localhost (unknown [10.45.224.210])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F04019560AD
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 17:13:27 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: 3.8-rc4 or 3.8 release next week
Date: Wed, 08 Jan 2025 18:13:26 +0100
Message-ID: <87tta9xm89.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi,

there's only one change merged since 3.8-rc3 but it looks like
there's some important changes in the queue so I'm going to postpone
-rc4 to next week as the last RC and if there's no issue I'll push 3.8
release two weeks after rc4.

Does it work for you? 

Also feel free to suggest all necessary information which should be
included in release notes.

Thanks,

Petr


