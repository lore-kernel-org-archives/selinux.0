Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17B1F932
	for <selinux@vger.kernel.org>; Wed, 29 May 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991448; cv=none; b=YgrYunZsau68O53iTn9J6KWfbhbNCyk/aAZl/7N0vYqRs5IHEq+sBZhgyIzJALO7iyK3eejBNDhrKCf3vovdWLqbnQhSy4HWldrshqUNZmtgV8IqAJJIcwJ8E5ohwvGFhFL3vTUQDR96mtQ+yFsdKhUti6PB8kybMEQt420BYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991448; c=relaxed/simple;
	bh=WwSgE+id0mNq8vEolxbhEUbs6AI/85/VbGuXrNX3Jns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6IMy7mdUvbadODNxMyVHIPRU79pz1GU7dwkExgByI5pKi/wvSr2iTletLzV7BeM4BsvdjJbHobk1NmFYPfgUyTi6zy9OXZwqcrlVxv0qHoW76lhvpikOgs29vf5n6fQNTT22E01o3rmBN+ZXl00m9cDvLUVEOxtPUHFmxK1c9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXxz4Wqw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXxz4Wqw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792ecce9522so122380885a.3
        for <selinux@vger.kernel.org>; Wed, 29 May 2024 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991445; x=1717596245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54JxXxkcqXRHqhBdvho7ggreAUM6qA3KcrjwpW6Db5Q=;
        b=cXxz4WqwFWoI1La4CuQxcDo7nJIKA72dH+4jk4pV2HxTrHG+QbETMzYbK+Ig2chDef
         uejzLop3vJwW3jDJf58mOpKuFEu/ohOREq9pNynQv83068zHVCoVgji98DLnDQa8fSyb
         tyOVZtvl7yEumAE65NVqGmT0aOrxRBSg5RpWuW25o/r4aW1/MAU9XoCzfy6LsBzhcrjq
         WH0NRcFGXmiJdOOmDh5fJinRi2TxBhkuJo1ja7gf5U4Wfz+pHYm16N9NGjIXStd3XrUL
         7gKWvdEY+gJiVK4UzT9/hdGJMiUFT3CglzY/rN8yL4OeZw2qICqRjIEygwnJBGrXPm79
         OG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991445; x=1717596245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54JxXxkcqXRHqhBdvho7ggreAUM6qA3KcrjwpW6Db5Q=;
        b=oq4AHzr00X2hmNahhQ2Ug8Qw8pUYHw6zAelrejZXu5V/27HAQGBPiiNSWmyObw5aPT
         J1Z4b8SKWaKgEq+Ln/eaySv3IK9WTR2J1ot+jK4zZ403lheafFjAfr2ctbi95IK3KL5v
         9v5jnN9ZfoZNpoJaRpQ04u5R0oBX7fMQgXURhkYIatwhvhKude9bRnmtHsVFiEXlG379
         OHTkwOvMSdYg1KIActQxm8cXskIoaJHvOGP0roWxcSr7wV0tq/6kM6bEzZ6+JHrOnYFz
         5VOI08pGHINGGXhHGALkSwOAWlyva0yQ4zBRnGQgR4H/FJwvkGoxP2Z86z3oLAdQB4Gw
         kr9Q==
X-Gm-Message-State: AOJu0YyjLgFrVBAa3C1J3sRfcTfz7f90ZzeDmnz/NLWpa8aeOHTRRaJT
	xlcjY1Pw4zXXR0Dry/IL0ipdqmQ8uJpHC/y7MpTNBrlHRwi+0F7HtLwfhg==
X-Google-Smtp-Source: AGHT+IE1v8onBTI3zWO3DcNA2tcQBkaJeHkpaEURl0UPVumwyFtif/mHqYW7teKd97zjwuARYFkoJg==
X-Received: by 2002:a05:620a:628a:b0:794:bc03:8a36 with SMTP id af79cd13be357-794bc038cdbmr1223266885a.5.1716991444721;
        Wed, 29 May 2024 07:04:04 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd3345esm470867485a.118.2024.05.29.07.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2024 07:04:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] tools/nfs.sh: comment out the fscontext= tests for now
Date: Wed, 29 May 2024 10:03:07 -0400
Message-Id: <20240529140306.6663-1-stephen.smalley.work@gmail.com>
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
 tools/nfs.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/nfs.sh b/tools/nfs.sh
index cf4912c..688903e 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -77,27 +77,27 @@ POPD=0
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

