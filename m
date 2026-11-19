Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107728;
	b=2DI0W1eCpM7n2Muw7b5wBxW2rrCGVwRW1W9xNT5J0Z0Vg9r0O9yKEEEiAQKDxRxYHFNC
	 wtHrobSrY3w+7zHSClzKoCSNljBDUHskXDBg4u22KDiSY/tez0bNj5HnpkYWwgxVlSF3f
	 tjstAdzoRoe+h2h+lkdcX6Gvy/APhFtKmuLHSofuA4TnetA30M6iFrzwqpgfuhxAl81D2
	 //9wi5ibp3axWFfqcJfItNtGvBkDFVSSfTztYpi77/a2Ylqqr1aNNCLI0dD7fCHOfHyw+
	 spnHc7U/0K+HXSaUCSqdd5zY/y5C2X4fePlsHtmztzfI3bocPawr3tkL/wglOs6XfzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107728;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:X-Scanned-By;
	bh=WbIXDhtvcDAkS1+WqjnC2+W4DM6aeAsoYYVK9OYgUoc=;
	b=cLTmwxqgj02Askihdt3cJMDkgdeeGGzXqATPLNBYdBAkODDE/H7pbz9giQ8+Xnxw07SD
	 x0baW9M3gxOcvXeY5fsRw8xYG0viSBZNoVFG8iIlXahsLYfwMNF0FS0KupPgke/vqqCx1
	 iOIPzUkwMqVSyYcwb2rXOXrJf1APxZCMMWBBDo+oZ3+H39HgWtEu5fgjqNZWYHapd559x
	 g1g+d0i9rwETmSl9y4YQsbbZHs8KKdpnRWwtg5IjmuH2SFeH1epLa+ppyPpdAuVLh2BNd
	 pEYQ4ihKzdSb1Y33yAZUpU1hBRUBXGdLGavKyFXnbhbuGcCk1S5pzpqV3FUA+nZ+McQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JavgtagT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B019606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 17:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B019606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JavgtagT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795107727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=WbIXDhtvcDAkS1+WqjnC2+W4DM6aeAsoYYVK9OYgUoc=;
	b=JavgtagTuLQPUk6EwMP3Xd/hQfEMgLmG7WLn5R+Lu8/rUl3yhKcppUZNGUFHAte4FeOVit
	kpe3MjOtC79ZogeGFV5h9b/+NXILJvwRO505ro1NGMye4Vtu7Hvol+htXfBBf6X4PBi63/
	lVqdfySfQxg8ADdDYFvX6vgVdyUrlN4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-4AtRMkLKMCC_NRJicGAXVQ-1; Thu,
 19 Nov 2026 12:02:05 -0500
X-MC-Unique: 4AtRMkLKMCC_NRJicGAXVQ-1
X-Mimecast-MFC-AGG-ID: 4AtRMkLKMCC_NRJicGAXVQ_1795107724
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4AD319560BC
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 17:02:04 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 302211801971
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 17:02:03 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.12-rc3 release
Date: Thu, 19 Nov 2026 18:02:01 +0100
Message-ID: <pjdqzggvjp2.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello!

The 3.12-rc3 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.12-rc3
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

RELEASE 3.12-rc2
================

User-visible changes since 3.12-rc2
-----------------------------------

- Hardening of sandbox, libselinux, and libsemanage
- Bug fixes

Shortlog of the changes since 3.12-rc2 pre-release
--------------------------------------------------
Petr Lautrbach (1):
      Update VERSIONs to 3.12-rc3 for release.

Stephen Smalley (9):
      libsemanage: accept empty local file contexts when sorting
      libsemanage: use LF record boundaries when sorting file contexts
      libselinux: require a pathname in Python policy_open
      sandbox/sandbox: do not follow symlinks when shredding sandbox directories
      sandbox/seunshare: SIGKILL and drain the child process group
      sandbox/seunshare: run the sandbox in its own PID namespace
      libselinux: prevent path traversal via crafted username in getseuser()
      libsemanage: prevent file-context injection via crafted NSS strings
      libsemanage: escape regex metacharacters when substituting NSS strings

