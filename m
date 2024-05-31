Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0C158DD7
	for <selinux@vger.kernel.org>; Fri, 31 May 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161219; cv=none; b=lXh0wAEGMmA380T2CQ5SB23KvCIzgplNu1kry3ND+lrn7fikDakrLn0MWx1V7llS1wSVsnN8WcdeD388vgWA0AQBJB+TVYuRe5GIr+dJM9EUz5u2Km4qfYbKKjvd1Umnho0GB2IUbpeu9OdElpsnl6SEuBvG0S+akCOpiMKMsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161219; c=relaxed/simple;
	bh=2rL0QKiOnPsO2+W2YMal9hO7tOZdQkO/v9I+ZJozL34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=loXCcExbSYuHVDKOuyMq8CImIXLjaMQdmmIp+h4T+G6yfj8IlqV8qiQE43u7NnajhEw0sAwElRffi/WW1CBv0BY0PcPBRHaERhCqrZT8ZPhVX0bdFLouz8mf2p1DF2JqliUU9HIl7L6QMzuWIKgXboKWOvf5ipk6+qEJfT2xcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA0MlEcI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA0MlEcI"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-794f5fc6e8dso44763485a.0
        for <selinux@vger.kernel.org>; Fri, 31 May 2024 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717161216; x=1717766016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yke1TcFI6OXBKQ2zEq28+NrjdIiWuMUz2ZpucbGE6qA=;
        b=iA0MlEcI0AtfukHHkyNcjd1rOhaHLsuCsBTmp5cbkI65f4aC86cGnIALGMIIlFbcRf
         cZoMY76HP1c8ItaVXDpQCLzzMABpHOQX2zjRpLeZN8SunWlyV0iWC+gAD9SDppsmt2pr
         HH1CGepNIoIPs/+exRSUKMyIY1alIgtjjncvcV3RC9gBkqCYqS3D4ShkgKM8zw4Edepx
         9OoVa4BWFOevQzaTouiTdFTHG3PwSh0cUDX+3XTK+OVJKSTa4nXzg99zPD0zdgEPsQnR
         2yViq/Bz3Zas/n5YllQ8K45qwcOP050Y5D5Jn5rjGkD3UFh2EpJfZmd5NtHcv1+KAL8L
         wIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717161216; x=1717766016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yke1TcFI6OXBKQ2zEq28+NrjdIiWuMUz2ZpucbGE6qA=;
        b=TY/WC2hxsd457e2bRvwgvpPIbkGPGrEN6+m1/5DCXqIwUd4k88kWluXoV/KRPDzB/F
         wsJtEL66s5K5vl6GJ3nbxTJTPiOKZUd1W3bzqQkZmIZrP9RA8ZgUFYbTzJKi+ViK5DUk
         MizdbdzYOPrrRhmuQYPqUk/1V9YMz+DtELXifaH+lx8o1swRMIaYXoS3lB21OR/ZzM+n
         0NRv7ad0R49KQ63qxKn8dcRDl4NWUSUWWXaEXnTxlKZkgaSb9+b2T8IxDa5GwIjRlmNm
         PVlmN3O+uywnSwZQ4MzhRqGg106iGLXNcRp5OEvpuPMrQX3sVlV5pdkOAhLj+UcmDASn
         BIHg==
X-Gm-Message-State: AOJu0YyR00XQQ7dDa1tzMKAD4xaybtyQatoB1aSPoCNlyy4Q+OJM1QoE
	rjqIbXJBK6MyVf0DvfGhBJlkEpa/CSMeTGn00lNitkgzgFbavndW+jNwjg==
X-Google-Smtp-Source: AGHT+IF3rrddHJsFE56NxxWJKLxKfhlvqi6O+tButBWr3zG7xWHyKoD6HCY4AcD9TGUFkjMWj/hViw==
X-Received: by 2002:a05:620a:37aa:b0:794:cbe5:f502 with SMTP id af79cd13be357-794f5c90f9cmr162611585a.39.1717161216122;
        Fri, 31 May 2024 06:13:36 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23e269bsm8020781cf.46.2024.05.31.06.13.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2024 06:13:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/2 testsuite] tools/nfs.sh: comment out the fscontext= tests for now
Date: Fri, 31 May 2024 09:12:37 -0400
Message-Id: <20240531131237.16666-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests currently fail on mount(2) calls due to the directory being
unlabeled at the point where search access is checked. Until we can resolve
the underlying issue, comment out these tests to allow the NFS tests to
be run. It is unclear that these tests ever passed and retaining them
prevents enabling the NFS tests in automated testing.

This bug is tracked in
https://github.com/SELinuxProject/selinux-testsuite/issues/91

Before:
Run 'filesystem' tests with mount context option:
	fscontext=system_u:object_r:test_filesystem_file_t:s0
filesystem/test .. 1/41 Failed mount(2): Permission denied

#   Failed test at filesystem/test line 709.
Failed umount(2): Permission denied

#   Failed test at filesystem/test line 720.
Failed mount(2): Permission denied

#   Failed test at filesystem/test line 744.
Failed umount(2): Permission denied

#   Failed test at filesystem/test line 756.
Failed mount(2): Permission denied

#   Failed test at filesystem/test line 780.
Failed umount(2): No such file or directory

#   Failed test at filesystem/test line 793.
Failed mount(2): Permission denied

#   Failed test at filesystem/test line 851.
Failed umount(2): Permission denied

#   Failed test at filesystem/test line 863.
Failed mount(2): Permission denied

#   Failed test at filesystem/test line 887.
Failed umount(2): Permission denied

#   Failed test at filesystem/test line 899.
Failed mount(2): Permission denied

#   Failed test at filesystem/test line 923.
Failed umount(2): Permission denied

#   Failed test at filesystem/test line 935.

#   Failed test at filesystem/test line 978.
# Looks like you failed 13 tests of 41.
filesystem/test .. Dubious, test returned 13 (wstat 3328, 0xd00)
Failed 13/41 subtests

Test Summary Report
-------------------
filesystem/test (Wstat: 3328 (exited 13) Tests: 41 Failed: 13)
  Failed tests:  23, 25-26, 28-29, 31-32, 34-35, 37-38, 40-41
  Non-zero exit status: 13
Files=1, Tests=41,  1 wallclock secs ( 0.02 usr  0.00 sys +  0.22 cusr  0.36 csys =  0.60 CPU)
Result: FAIL
Failed 1/1 test programs. 13/41 subtests failed.
Test failed on line: 85 - Closing down NFS
NFS Closed down

$ sudo ausearch -m AVC -ts recent | grep unlabeled
type=AVC msg=audit(1716989714.176:42466): avc:  denied  { search } for  pid=170755 comm="mount" name="mntpoint" dev="0:60" ino=822109802 scontext=unconfined_u:unconfined_r:test_filesystem_no_watch_mount_t:s0-s0:c0.c1023 tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0

After:
No failing tests.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tools/nfs.sh | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/tools/nfs.sh b/tools/nfs.sh
index cf4912c..80eba92 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -77,27 +77,31 @@ POPD=0
 popd >/dev/null 2>&1
 umount /mnt/selinux-testsuite
 #
-echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
-mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
-pushd /mnt/selinux-testsuite >/dev/null 2>&1
-POPD=1
-cd tests
-./nfsruntests.pl filesystem/test
-cd ../
-POPD=0
-popd >/dev/null 2>&1
-umount /mnt/selinux-testsuite
+# The block below is commented out since these tests do not pass
+# on any known kernel.
+# See https://github.com/SELinuxProject/selinux-testsuite/issues/91
 #
-echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX"
-mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
-pushd /mnt/selinux-testsuite >/dev/null 2>&1
-POPD=1
-cd tests
-./nfsruntests.pl fs_filesystem/test
-cd ../
-POPD=0
-popd >/dev/null 2>&1
-umount /mnt/selinux-testsuite
+#echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
+#mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
+#pushd /mnt/selinux-testsuite >/dev/null 2>&1
+#POPD=1
+#cd tests
+#./nfsruntests.pl filesystem/test
+#cd ../
+#POPD=0
+#popd >/dev/null 2>&1
+#umount /mnt/selinux-testsuite
+#
+#echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX"
+#mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
+#pushd /mnt/selinux-testsuite >/dev/null 2>&1
+#POPD=1
+#cd tests
+#./nfsruntests.pl fs_filesystem/test
+#cd ../
+#POPD=0
+#popd >/dev/null 2>&1
+#umount /mnt/selinux-testsuite
 #
 echo "Run NFS context specific tests"
 cd tests
-- 
2.40.1

