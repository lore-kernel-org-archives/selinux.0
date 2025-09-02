Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00146322743
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835412; cv=none; b=nR6TPfPOTSxmmJMec3NAwX884E556ERUrtme14MAKP7WMEroILZQRJ+miwtLKGda0Nj0l2ZuCJRIide5H31oaEpkxVEu5MWfaFf25rbGmJ9NBnimJY50UlufmJje4wVtZe7/W5q0nNrGRuO+uxlWE3NiCa5LA5Jo0/iAZ0ik2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835412; c=relaxed/simple;
	bh=qPIKTc37LGj84wc6WW3h3IkN7CxkPSO/ppEa/Kusa8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7wupFQkNAEBv1jo2ry+Sz3h8lYQYcyOOnu5+KQEEkncXXW/qI54/7EXmCziTlwirFExoZ7U70/gc2p7nKYa1Yqm9apzLiZVY2CYbjuMwfNf5+0ezCZKSXXcQFHHdwo61SyuiJVnqyvUtL7UHj979iq/41Hm3efXKZWGzsLgggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODqoxBod; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODqoxBod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756835406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qPIKTc37LGj84wc6WW3h3IkN7CxkPSO/ppEa/Kusa8Q=;
	b=ODqoxBodbhu5wKdocsxdT45EVhorw7nWon+92GEwqMwI45rLcBA2koyOeGlZmdfkNXefga
	Yb4cw98FE6CdZWHZdeOZgMlDX7f8NUnwPxFYerW1u+pMNjZI+j1Df9u+6YB76+MCgykSx0
	gLCPSz9BjLZcIZO8hSRXkIFjF5kzCDw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-uK8bNIzXNLeAexnHrJLAKQ-1; Tue,
 02 Sep 2025 13:50:05 -0400
X-MC-Unique: uK8bNIzXNLeAexnHrJLAKQ-1
X-Mimecast-MFC-AGG-ID: uK8bNIzXNLeAexnHrJLAKQ_1756835404
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1600180035B;
	Tue,  2 Sep 2025 17:50:04 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A03219560AB;
	Tue,  2 Sep 2025 17:50:02 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	lautrbach@redhat.com
Subject: 
Date: Tue,  2 Sep 2025 18:48:47 +0100
Message-ID: <20250902175000.3214164-1-rjones@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

v1 was here:
https://lore.kernel.org/selinux/CAEjxPJ5BbCtQNjEdeSaHH1-54xzkYn_Qgptu91QKwfMQyyB9Gg@mail.gmail.com/T/#t

In this version I fixed up the usage documentation for setfiles.

Rich.

