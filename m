Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADB23D2BD
	for <selinux@vger.kernel.org>; Mon, 30 Jun 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275291; cv=none; b=PK76JQJwlit6FJFWvPcukJ4nqYmWesur/wVtkK75lOh1HWZMkdrev14KGiWtEKOBkakbzma+talFAioOMZ/6rxExeu4qg1YGXzQGeom6U0VlN+bByC2S1A2xldkFzszTnAcbrQ5t8/59rWEtT+zvLW/Ql6vPYXxjyPGa4PuQGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275291; c=relaxed/simple;
	bh=yStgXp+t3ZcsO+YbV+6GGrcz2S1KsCmUdyuLuRTgtt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Po8T7vuzR/XsLL6iubARi2+cdgtjvrTWrwTdBboMxLGjbXzrm4afgP94clNbaMgEzyv0aTGCACj2PNRaY3l7g+Bye+3SzKxtozx6fWp/dksBx8GQvyM9dh27AgiDdKkZYkNj73R8jtJKKkcGHo/jZjD4IHANOwGzSlSq5C2+UAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lb2wcX/+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb2wcX/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751275288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0YDDbo9tnMcH9aS0pDaGujHNma34qp5oPj2niS1aNpo=;
	b=Lb2wcX/+/HF/HgJOgcCVlTGbSxUOWO68Ghyu+ROxLeAVagzB7VUXP3NwFGEfAVzvefT/j/
	l4vvv6zc9JHEjJCeiyPyxbkBeTcTWfwF0jCboxq592D0unj8Bn5U4VQT566h/gCanYe6g9
	12qwIHKac/fAu+W7/xouYZeOlnqjr9M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-FyssFlemP1KYNMwFL_5wJA-1; Mon,
 30 Jun 2025 05:21:24 -0400
X-MC-Unique: FyssFlemP1KYNMwFL_5wJA-1
X-Mimecast-MFC-AGG-ID: FyssFlemP1KYNMwFL_5wJA_1751275284
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2105C19560AD
	for <selinux@vger.kernel.org>; Mon, 30 Jun 2025 09:21:24 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB99E19560AB;
	Mon, 30 Jun 2025 09:21:22 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] sepolicy: use multiprocessing 'fork' method
Date: Mon, 30 Jun 2025 11:20:56 +0200
Message-ID: <20250630092117.21728-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

'fork' was the default starting method in Python before 3.14 and it's
necessary for this code to work correctly

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2374569

    sh-5.2# sepolicy manpage -a -p /builddir/build/BUILD/selinux-policy-41.43-build/BUILDROOT/usr/share/man/man8/ -w -r /builddir/build/BUILD/selinux-policy-41.43-build/BUILDROOT
    ValueError: No SELinux Policy installed
    Exception ignored while calling deallocator <function Pool.__del__ at 0x7f36f9d333d0>:
    Traceback (most recent call last):
      File "/usr/lib64/python3.14/multiprocessing/pool.py", line 271, in __del__
        self._change_notifier.put(None)
      File "/usr/lib64/python3.14/multiprocessing/queues.py", line 397, in put
        self._writer.send_bytes(obj)
      File "/usr/lib64/python3.14/multiprocessing/connection.py", line 206, in send_bytes
        self._send_bytes(m[offset:offset + size])
      File "/usr/lib64/python3.14/multiprocessing/connection.py", line 444, in _send_bytes
        self._send(header + buf)
      File "/usr/lib64/python3.14/multiprocessing/connection.py", line 400, in _send
        n = write(self._handle, buf)
    BrokenPipeError: [Errno 32] Broken pipe

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 82ff6af2bc2d..febb2fc103ed 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -25,7 +25,7 @@ import os
 import sys
 import selinux
 import sepolicy
-from multiprocessing import Pool
+import multiprocessing
 from sepolicy import get_os_version, get_conditionals, get_conditionals_format_text
 import argparse
 PROGNAME = "selinux-python"
@@ -350,7 +350,8 @@ def manpage(args):
 
     manpage_domains = set()
     manpage_roles = set()
-    p = Pool()
+    multiprocessing.set_start_method('fork')
+    p = multiprocessing.Pool()
     async_results = []
     for domain in test_domains:
         async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))
-- 
2.50.0

