Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C7189BBE
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490653; cv=none; b=HnkImyXqBzt06qnjxqRUfg6NzYLuQGVC8rt4zljRn61wRKCaCV1EQCvxF41CEYIBSBvibWVmPVO1Gb6Gy5Bglzv5/zntU4HIiEZLpGKMjfdgTkFUh5CGKRn5PIk3pXw0jtV5d/70uwogUBOLbDDdVVPd5VwUXh6AtDNHx+u5Z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490653; c=relaxed/simple;
	bh=/IXRfBrilN7E20z72sYAdpxfz1oJsX9jq9w1Eh2xxDA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HWDrQnXjCy6Gb43HLNo/0s7yb5uNHFLQFAI405M/GSneBhnxHgpNj9RLBRLOwjOVa3/PNTNMQ4htxmvoc1oigLNGbJieFXQnN4VGjUqCLMj7Au7ZcmTlo4HbghJMhyiGOoEqOPcUN7ewKVw1XAOzgWLWNLvUvalFVAwQ1KfN29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNqxiDlj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNqxiDlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731490651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/IXRfBrilN7E20z72sYAdpxfz1oJsX9jq9w1Eh2xxDA=;
	b=VNqxiDljoBSFcJj9+W1Lt7r4TPp0ERoAWcyPqCLgly8FS1K2amdOiPGcDr8HWSyVqHlkE6
	uJJTXYYX7WWcHtu7nkqbBbQt3b9ZWaHD8QnWAakTol5dZsghZG7jDi2+sF3EJvlqAm/t6x
	Hs48Q9lviJs2m7nO9DbHPdI6qNorSZs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-g_ZxOciCMgSZHVckPMloCA-1; Wed,
 13 Nov 2024 04:37:29 -0500
X-MC-Unique: g_ZxOciCMgSZHVckPMloCA-1
X-Mimecast-MFC-AGG-ID: g_ZxOciCMgSZHVckPMloCA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F151955F4A
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 09:37:28 +0000 (UTC)
Received: from localhost (unknown [10.45.224.101])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C0C51956086
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 09:37:27 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Intent to release 3.7
Date: Wed, 13 Nov 2024 10:37:26 +0100
Message-ID: <87ed3flbjd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello,

It's been about 6 months since the last release so we're going to start
the release process.

Original plan was to ship final release before end of the year, but
given the number of changes delivered to the mailing list in last day, I
think it'll better to postpone 3.8 to January 2025

I'll tag and announce 3.8-rc1 on next Wednesday, November 27, 2024 and
continue with next rcX every two weeks. As written above the target for
the final release would be at the beginning of the next year.


Petr

