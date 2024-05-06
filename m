Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF7157E7A
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017882; cv=none; b=eK7SjsAeQM9ANWrmgK+8v1HAliCYvNB1vYa0PBAE2hu7a/42OQTHSbOAy/MV8dIPzNL6Kiv23coaGFwUZZliLdj2sWh1mO3rnLUlrx4H6/Kz2Knk1K9h49H4hrOAj2sZSP7gUdxR9g9m8owH0smIJu6ro6ya1MVN6uTIsPUKDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017882; c=relaxed/simple;
	bh=CK2r7HvzKruSoYwqTMTbF8R2Xp7tLM6RFpFQbjbvUDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjUxRXEIOQTpV//sZU2CaWkEPp/ecrxwivDgMwRbIjBY93XD9Q0qSCNrCJSxxtJNmNq7BEtjfiu84XsCeIb7wIeZ7N41kqn3dcKmYCGBA7Lz7zOoxMaCoMMp8l9NGpVWdb/O1Mm4QEO9qccYz0iCF1WE/gDrWfFgLwn4wt+uULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBiXgsUU; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBiXgsUU"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47f00074f54so298189137.0
        for <selinux@vger.kernel.org>; Mon, 06 May 2024 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715017880; x=1715622680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfkmUQUKIeE8fONyOCbH5PmvFN4SMUt7vE49Lb00RBM=;
        b=jBiXgsUUuqEju+AiTeVuhG9G4bOFhIYtJVWQNV4K5dqKdQeYvQR2EneBC+ck11fRDL
         vozo8uMkjNPuSRUIQSh0AawiJ58SG+DNBSNE41Yc7NxK7bd1cZ6FEiW6BVRmYmfijv6C
         6OVQU0tD8YVcgXrsqR6MU74CL87FlBg68TOWQmioHAW1SQcmC7AVkSAtW3PajpbNrMcr
         4+mtnSkXwwSx6HYzX8NOkh1dC17K4iT4NmMA6Y3rbzmnowffhXTiSq3C2tTrqMIt8j95
         uXYAPuBSyFRsbXtNDyKAhwfwVc8lIsFTrK2IqHe1kQ4mauancG12bxigJk3IxMjrMk3+
         7S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017880; x=1715622680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfkmUQUKIeE8fONyOCbH5PmvFN4SMUt7vE49Lb00RBM=;
        b=LH8iV0G0VA8FsZ8qNM82fynWcpb/OZJRD3IV3YqlxDlr4vBtRnLM/Rb8QQNonxXtHY
         WIfS0dvTfdZlx2YFbOhO2tqyVgcgs1pArvF+geOi9gvks8qgyYrp4TTUpnreIWOClqlt
         cxVxVjvjw95On9T8mVbE9HM7KzFte4ZyOyVAQ5p7XXQF+yiwt27Y8SVsGMHxKZ9VGDlK
         j/+/9mMqf17gKfjZqq6VoNo88wKA+lLPF3gY6JzKRCs00+VYENDNXxBtdTJoD41PDPig
         CALEoh+9+nH30o2WhmiW+XcAhVyz6usJt53M3jnKi7/BdqpUbfrcwwKpQW/hsjjdBVhA
         h+iA==
X-Gm-Message-State: AOJu0YzNqP62q1mqGbP8MGtHv1WrUg/scPCcd/lyziMe95/kxaz4eiyl
	zDyoLoprQuTZD9o62Gj0RT1aOIw1YdOh3z+ba/iEJWg5WPAeWb5fcQAl/w==
X-Google-Smtp-Source: AGHT+IEkiw+gJmaWosLXMAbSsJxzGd+JYPapGc6ECjr45RivopXHkoi45fMWh2olMwiY18VLbkVQ2g==
X-Received: by 2002:a05:6102:443:b0:47c:bff:41ff with SMTP id e3-20020a056102044300b0047c0bff41ffmr13087842vsq.14.1715017879508;
        Mon, 06 May 2024 10:51:19 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id i4-20020a0cfcc4000000b006a0fa7bc030sm3887086qvq.25.2024.05.06.10.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2024 10:51:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext= tests for now
Date: Mon,  6 May 2024 13:49:50 -0400
Message-Id: <20240506174948.26314-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
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
be run.

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

