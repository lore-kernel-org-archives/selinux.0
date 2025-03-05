Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8681253357
	for <selinux@vger.kernel.org>; Wed,  5 Mar 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202626; cv=none; b=NAn2RJjOGsG2gopPBVn1ajH9s7p1YDf/QFaQTRiyyfNnqGop5re2OiGHJStjtfSF4a1Rkan3cvQTz/aMV0GSn0Gi7apByShgQJ4G7cHtt5xw88TS2FJvWum1TOyKtt73DaKLOIW6+5v4o0E2dBlEFhx7e0aTAf9PZxDWH38wUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202626; c=relaxed/simple;
	bh=na1zWvZtyCPTL1JfPA3eNyahi7WguSpFiSI6haqTf0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OUky1iA3IHUVnTJ+ZkgLa7y8PWMrImrmqc1J/Qgu7PXDUAyX8YyPlqwlZUtdZCFByVvr/I+rqpuAMFsqyza4u10Bx8k/1UbM7xkeJjKkaWor6dJ/N7Z/tljclSJFMnTQm9RVZ6Kj/y1RD9PtzXizSVNMr0BQ/6jqODgcmlVPiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIvMfuUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIvMfuUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741202623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MnlPQyBm5AHT1xHKC8stB6Rf8ue+UWveWUmTe1u5jRk=;
	b=DIvMfuUacLEVw+P70Ajv5xITXoIZPJ1hJdyFE/q4uuFIqeI2sFeTgOdrGCHbCI/q2d9oai
	joOJCo/itsRfhWfaV+5+O3Zn92olL95eRm6vvG3EKK5atjFIoVbFgO2iQHVxWBGG2v94QW
	kNBNXTr35whyam0VEtHPTdnsCRJ9WR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Oax2MPZjOx6YnEmQBxVxbA-1; Wed,
 05 Mar 2025 14:23:42 -0500
X-MC-Unique: Oax2MPZjOx6YnEmQBxVxbA-1
X-Mimecast-MFC-AGG-ID: Oax2MPZjOx6YnEmQBxVxbA_1741202621
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56898180AB1D
	for <selinux@vger.kernel.org>; Wed,  5 Mar 2025 19:23:41 +0000 (UTC)
Received: from localhost (unknown [10.44.32.66])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2B9A1800266
	for <selinux@vger.kernel.org>; Wed,  5 Mar 2025 19:23:40 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.8.1
Date: Wed, 05 Mar 2025 20:23:39 +0100
Message-ID: <87h6475lj8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello!

The 3.8.1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

This is just a minor release which contains only fix for performance
issues in semanage store rebuild introduced in 3.8 release.

Shortlog of the changes since 3.8.1 release
-------------------------------------------
Petr Lautrbach (2):
      libsemanage: improve performance of semanage store rebuild
      Update VERSIONs to 3.8.1 for release.

