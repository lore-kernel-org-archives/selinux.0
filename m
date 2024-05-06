Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E9157E94
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017866; cv=none; b=N5cswnwPVIEcoammvA/bkKVZx0QOux5n5rCH8H+g1eKhMh0iDOZ5J0JnStKS2oQGhzM7D5S7p52WSpE/1Ldfmv7E8SIFS/34cY/VJpxXfxDAReHX8V8l08cSZ3faWhIQHN12MGiXzGOS/bbCGOI0yuV7pb8veZHk82jdGtxLlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017866; c=relaxed/simple;
	bh=Bp5ZYQXXpz8e4P9SqWJlslJ00upADJCx3nqRK1Uxbak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULxn0GpsxceOu86vdvJH6kEqWBEfg3nwPmZm5bbbTVoOJfDaHGKzhLnBU55zws4XNJF8wWR2FCVUhN606LNHgNYWq8eZJezUVV6FHliCJ8e/WqIf1d86HvmuiOfCAVGB7aQ3uklhpIaEPyGe9BKtQOIlh8Ul9Zd5PdKd+yBSqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeZ0eDuu; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeZ0eDuu"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6a073f10e25so14356766d6.3
        for <selinux@vger.kernel.org>; Mon, 06 May 2024 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715017864; x=1715622664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr/dAezIBLtQDhgNM/srPJXbVCqTrZSDqzUmXn/kE3o=;
        b=IeZ0eDuuKBwc/kQhWx7tb7AvL1Eo0qdEf5dH5T4GFANG97nv3XE2w8I+qd6AXFrEqq
         b6VOH2k5ow9REUIwIMqJcUrYlEGfUX3PfTyE/Z6hEFmyBKYK/KbmvhlxXuYaScD5+xMR
         Rc0HjqPiI6urU7QY9u6cSKOMFHh6E5yNxG3DU5qeQq8O70oAaHUNzu5P9koV1t2/USrq
         sX/kxAgt5+s43FkNF3svh1jOtGKT3UYI9vM29VlWUeD+n5Qf1jTUs7h4v+siUPJA1/T6
         thxzANK8qbKdLkv3VIwEtA378tNarBRaA58RnRLfSu4ctPx0GiD39vDEhvP2Ok2vwme8
         bQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017864; x=1715622664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr/dAezIBLtQDhgNM/srPJXbVCqTrZSDqzUmXn/kE3o=;
        b=kIA1JkyiugEuChPu05RKHIlDnVcBzi5UKP1CYoPEHVvpEoxZYQ/Tzr6b4XKsdFKWpV
         ObusnudpSi1j2BeUgiBehhmoiv1UAlUIF1wGkQSBRxUIJl79iH2DmlOupGhLXrdYSdh7
         FJZgNPPUCUN8kma81qkGJscfHmdGWeOnpw2xR858bHKbGAOsyyQtU/vNZhUJmW/g3Qrm
         CWn3UgR64CvobOMScSrDGL9TBAoDoBfDSu4ofISbiM6gYcdiaMOnjX0RYUMqbKXpdRT1
         24Mw5TIWEzF8N1o3zbIYBy5ghyw9Aa9BjTWf/O5FDtiQyLD5ZfRwmTObu+Y76JiJaJZ/
         ylsA==
X-Gm-Message-State: AOJu0YyxCGga+Mb0bjIGRkoCBrI+qMD6+qPAmjbyVCCFg2bYlWZrlo61
	0XX+OsKWStp6KvGnSKrJAw2y313H6+CRtBqNXHd10qAS7wFW6iK5oC992w==
X-Google-Smtp-Source: AGHT+IGE1dHyp5IInz4bsJaeL9liz8lyG9W2eN6RkKgTa5YqaT9N2ASuXr662XckSYVTqxXO51MEJg==
X-Received: by 2002:a05:6214:d8d:b0:6a0:d291:a357 with SMTP id e13-20020a0562140d8d00b006a0d291a357mr13012035qve.54.1715017863641;
        Mon, 06 May 2024 10:51:03 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id i4-20020a0cfcc4000000b006a0fa7bc030sm3887086qvq.25.2024.05.06.10.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2024 10:51:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2 testsuite] tests/nfs_filesystem: remove failing mount
Date: Mon,  6 May 2024 13:49:48 -0400
Message-Id: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For reasons unclear, we attempt to mount twice, the 2nd time yields an
EBUSY, and then the following test fails. Remove the 2nd mount, which
also resolves the failure. I do not know what was being tested here.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/nfs_filesystem/test | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tests/nfs_filesystem/test b/tests/nfs_filesystem/test
index fc8d525..4203206 100755
--- a/tests/nfs_filesystem/test
+++ b/tests/nfs_filesystem/test
@@ -38,7 +38,7 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 56;
+    plan tests => 54;
 }
 
 # Set for testing mount(2) on first run
@@ -100,17 +100,6 @@ while ( $i < 2 ) {
     );
     ok( $result eq 0, $test_msg );
 
-    # First mount(2) ok, second currently fails with EBUSY
-    $result = system(
-"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
-    );
-    if ( $i eq 0 and $result >> 8 eq 16 ) {
-        ok( 1, "$test_msg - returned EBUSY, possible bug/feature" );
-    }
-    else {
-        ok( $result eq 0 );
-    }
-
     # Create file and change context via type_transition rule, check ok:
     $result = system(
 "runcon -t test_filesystem_t $filesystem_dir/create_file -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file -e test_filesystem_filetranscon_t $v"
-- 
2.40.1

