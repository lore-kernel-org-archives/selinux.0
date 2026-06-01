Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1F2FFF9D
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331540; cv=none; b=RdkKqXD4fztUF3KfNYfL1mPIhE0nY2Sv58iAjAsbqq6aLNk46N7hC78k1dsQ+AmISoj4FP2RD/0AR/nSdwT3aLT8nfMk41TRLQnQEhyYazy4HsJmtbjHuXYj2DwBDbtsMm29nzihg/ZxHXHmXmQU2YpiHv6J0uCU7a7kmRLM0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331540; c=relaxed/simple;
	bh=niMVoEef98IscsH6Kek8rceKfNjWpaEcEMou4hvI0gw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FtbtmikdDhZXVJAOGhqKiiE5HSZpyekGXh4DKO7Rm07LxLHKecC/cljsROt8wIbdTzcbHb37tASeMtIIrvnqk65Mq6p3vmTLsIUMMAdUOCehUR5JvccXR00SzthZtRBQCsNcSPhjEtgq5oAqlNh4PSdORTEdK5XvB4oAWmmc6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jN4xIveM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN4xIveM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780331538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=niMVoEef98IscsH6Kek8rceKfNjWpaEcEMou4hvI0gw=;
	b=jN4xIveMSAqo0YYaWbaDRoLju9qwdE7uvN8Y0oqPVr2bzVzwiuWvppkZjZTl+Vkx9I8Y1X
	Akem3P1wAr8F7XzJRvFue+AED2XsDi/oISexVxRJl63qdi4BzKD8mKt3eB/uLvQmSgXLp2
	1+EAXH3bnj4zibfQiulKiXzHWUw1N6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-rB-JQoMWMTCIuuDJDLtkJg-1; Mon,
 01 Jun 2026 12:32:16 -0400
X-MC-Unique: rB-JQoMWMTCIuuDJDLtkJg-1
X-Mimecast-MFC-AGG-ID: rB-JQoMWMTCIuuDJDLtkJg_1780331535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755741800371
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 16:32:15 +0000 (UTC)
Received: from localhost (unknown [10.44.48.123])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF2AE1800577
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 16:32:14 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: HEADS UP: SELinux Userspace 3.11-rc1 release coming soon and code
 reformat
Date: Mon, 01 Jun 2026 18:32:13 +0200
Message-ID: <87qzmq5iia.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

it's time of the year when we usually release new version of SELinux
Userspace and given the number of recent fixes, we'd like to release
3.11-rc1 during this week.

Also it's planned that the last commit before the release will be code
reformat using `make format` - this will effectivaly make all unmerged
patches unapplicable.

So if it's not urgent, please consider to stop sending new patches.

Thanks,

Petr

