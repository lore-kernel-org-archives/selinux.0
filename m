Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919A1E49E
	for <selinux@vger.kernel.org>; Thu, 20 Jun 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889424; cv=none; b=f9OQtktUd0rSVU2jTiIcoyKZxk+pri+Sl97PAXk2354EHHiKytWTAdAmxz9A6bTQMb6FcI/ZZtBQXAd9MXPi3BmTTj8N9jdG2Tq5iT1xHV+7VaVz+quvt26mNp7OK6GnFmFGhzzVSN7v7ZPYTkrLOnvjTz2LQ7H+ZnGYgvIQzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889424; c=relaxed/simple;
	bh=T6T8ZC8AlucKhhAdART1niN6pyv2YqLoiX4GEWF7w1E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOlp6FG4JZjdc9sUxICmwPTxYWawJ2SEzWHK1qS8K0BzTYhGM6GeFpXfeuPIzqWsdV8zKw2g7089nV01/f8kgav8oFtpx9UatsCEuGPIm+oe25yyDnQSx0eFsWmLu8+o3vZMimkQXCm3m0qDwthnhTUvCGJW+VM8ZuJIAdq6G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuQZ5WsG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuQZ5WsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718889421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mBlFVJCk4gEaHIddhJgXJ8gWZI2jp7U0Gf1yaCRz9SU=;
	b=CuQZ5WsGrNG3uyIQ7MydLRNHdE3HIB7rlsVL3MwovEbBGE/U0fqmlVuyrptFu8J+vmbdnE
	VUveGMBut/0NhvtCS50QyM6xL97gzCGwRYF001A3Aa7hFKh4bKncVbbdq0TLveyDI+iABK
	jmFTxdsbaO3X25U4MYvzuPr1e/Zj3PM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-eMcsw27wNAaKARoAx_zINw-1; Thu,
 20 Jun 2024 09:17:00 -0400
X-MC-Unique: eMcsw27wNAaKARoAx_zINw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F7CB1956088
	for <selinux@vger.kernel.org>; Thu, 20 Jun 2024 13:16:59 +0000 (UTC)
Received: from localhost (unknown [10.45.225.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 102BF3000218
	for <selinux@vger.kernel.org>; Thu, 20 Jun 2024 13:16:58 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.7-rc3 release
Date: Thu, 20 Jun 2024 15:16:57 +0200
Message-ID: <87a5jfycs6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello!

The 3.7-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me know.

IMPORTANT: if there's no objection, this is the latest rc release and I wil=
l push
3.7 next week on Wednesday


User-visible changes
--------------------
* Code improvements and bug fixes


Shortlog of the changes since 3.7-rc2 release
---------------------------------------------
Christian G=C3=B6ttsche (11):
      libselinux: free empty scandir(3) result
      libselinux: avoid pointer dereference before check
      mcstrans: free constraint in error branch
      libsepol: hashtab: save one comparison on hit
      libsepol: move unchanged data out of loop
      libsepol: rework permission enabled check
      checkpolicy: reject duplicate nodecon statements
      libsepol: validate attribute-type maps
      tree-wide: fix misc typos
      libsepol: contify function pointer arrays
      libselinux: constify avc_open(3) parameter

Petr Lautrbach (2):
      fixfiles: drop unnecessary \ line endings
      Update VERSIONs to 3.7-rc3 for release.

