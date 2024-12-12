Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E67210193
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998466; cv=none; b=NNLFV7tVf5I939BfbB9XQ/33qTWHT/BjWjFRPu9UH5HPpUXQlLTJyTAGGXGkA+S7enD7wxc2P2Gxnnj4vgPHAr4hfPPVzxhZD5YDRhYszwGbpDkQeYPnATYUbnHHQ9mMI19YyEgBUHX90jK+u5HZMjUzL2Co5zdhRtQ6sarubrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998466; c=relaxed/simple;
	bh=ovCn6kkM7LPI5eCO8cwlbmS3zS9S8izo8YCa2WYyNuk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mLnGhlbbIc95SQ1vHeCF7nlq7VAsaINMAgQj4sOmS9TzXrm5wyT8ebRhq0A8Ni/lp3m5YxICQ7mpi2RyZmhQZVxkTnaPYl81GZbRN2BU0zUgA0eaJ9J8rgPDCcHJqIn3lZYPkp4XGQUhcnuk0PMO4xFCT4eJ9rYRn6KvJGcO9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVNIKUAc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVNIKUAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733998463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ovCn6kkM7LPI5eCO8cwlbmS3zS9S8izo8YCa2WYyNuk=;
	b=BVNIKUAcV2JiAwsrIgt6gJ8TQ0orhPD0Q4DXM8h5zDJw1wF1cItEjSz81c80DCV7j8opcy
	YivW4YTpWy/lfw3qDL3nduPG6xqpqzBwT0Ha+bxnu5as7KafXeWE5oOa9j7XnwVO85G3gf
	s18org/Z4dzfcKlsFMt+8sPAqQlSgxQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-3I_wVMDeM1qmyD7lUx2Bag-1; Thu,
 12 Dec 2024 05:14:21 -0500
X-MC-Unique: 3I_wVMDeM1qmyD7lUx2Bag-1
X-Mimecast-MFC-AGG-ID: 3I_wVMDeM1qmyD7lUx2Bag
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 007A719560BD
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 10:14:21 +0000 (UTC)
Received: from localhost (unknown [10.45.225.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82997195394B
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 10:14:20 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: 3.8-rc2 will become rc3
Date: Thu, 12 Dec 2024 11:14:19 +0100
Message-ID: <87seqtjjic.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi,

Yesterday I tagged 3.8-rc2 but didn't announce it. Here's why.

There's a regression in regex spec ordering, see
https://lore.kernel.org/selinux/CAP+JOzT2YFKcvga5dM3XoRseGSVKs2MZ2ZijPZ8b4N0vekHF+w@mail.gmail.com/T/#t
and
https://lore.kernel.org/selinux/CAH9xa6etgNe24pGEL82WqgLzFq714WMpQLyDE4mKf6wReu4tvA@mail.gmail.com/T/#t

So I decided to not release and announce rc2, but wait for the fix and then release rc3.


Petr

