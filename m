Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA318BEC
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849667; cv=none; b=WXSNMbzd7lenQT2im8nj96tdTdrwDbXWm/3q/BqXOygl6x2A2l6BwNB9T0L9+zYnunry9Wh1PtbRKzNl5c2aOS2QQGnePXzT8j4vedHAr4bBWsx1uzNSEBrf70oq60odomFWCDXrhj6pqE+Vnly80UPpi7CM1p45/VFwHlCde4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849667; c=relaxed/simple;
	bh=1Lk0jAiG0wZcXQaxK+sljrplsWao2wmROjnDrmuGNdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUGuq954n19IUDxjebmfZPPmcuyvUKYBfC0YxIZfXu8uByWWZrS8ZwXikgHX3nzKWZHuJYEGkQDtFlCqSseLTElV38JoU54S4oGy+Hkerurkuaxh2/8j3cvMoH6ZHQuyqPzfiqy5Z8HAqHbQ+1Bx3bXpcSSkXmUJ+nObvEc6RB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBAw2/rX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBAw2/rX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759849664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ajLnnjuGFA9JTCpNBdSIAAhavMMkiFlL0LF9c6ljtTA=;
	b=FBAw2/rXXRdxnsmCUcDKkM0EUaZB+JsJcx5GJ9t3MYn6LyQxKBYChBPwMp7Ph1QBy+gtM0
	Lrzq6baGKCIPlLYCWYMa4/9tM8QfgGQ+aZ3tgaX3CuSX8QYchnIxMJ+WttgPTjl7FxQGVf
	DyDrunFh08rFmi+HeEW92cKwiauT5+A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-NvcgoMM9PUO_5pvl0pbmqg-1; Tue,
 07 Oct 2025 11:07:40 -0400
X-MC-Unique: NvcgoMM9PUO_5pvl0pbmqg-1
X-Mimecast-MFC-AGG-ID: NvcgoMM9PUO_5pvl0pbmqg_1759849659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B46E1956089;
	Tue,  7 Oct 2025 15:07:39 +0000 (UTC)
Received: from plawate-thinkpadp1gen4i.pnq.csb (unknown [10.74.64.212])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC91419560A2;
	Tue,  7 Oct 2025 15:07:35 +0000 (UTC)
From: Pranav Lawate <plawate@redhat.com>
To: selinux@vger.kernel.org
Cc: pran.lawate@gmail.com,
	vmojzis@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/1] improve semanage man pages: Add examples for -r RANGE flag
Date: Tue,  7 Oct 2025 20:36:12 +0530
Message-ID: <20251007150659.33954-1-plawate@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Pranav Lawate <pran.lawate@gmail.com>

This patch addresses feedback from Stephen Smalley on my previous
submission.

Changes made:
- Added -F flag to restorecon in fcontext example (required to force
  relabeling)
- Changed port example from 443 to custom port 9999 (more realistic
  use case)
- Added seinfo --portcon -x verification command to demonstrate that
  MLS range is actually applied (semanage port -l only shows type
  information, not the MLS range)

The seinfo verification output shows:
  portcon tcp 9999 system_u:object_r:http_port_t:s0:c0.c255

Pranav Lawate (1):
  improve semanage man pages: Add examples for -r RANGE flag usage

 python/semanage/semanage-fcontext.8 | 4 ++++
 python/semanage/semanage-port.8     | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.51.0

