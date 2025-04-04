Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E71EA7DD
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773660; cv=none; b=XH6Mwb6VMP+zgUFZ4JcmP823YyySiMAwwCxNzK67nnVcEdoTumJ3lxCrvlhmo9/etR+9t5YB9HFliU3TOSd8r8rnyss/QMjOU/+QHqbKUjqlpLinh94zhJGtzBubxgx4bVE0mOIvQYa2IE55pDjLdvuRapcJ/Ac+OJUN0s0O4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773660; c=relaxed/simple;
	bh=3/xa8SDSk0dnqP8q16NXy467O388vVGcUet9TgGKrwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQCRxWgz74LqPjiSQSKtDOVwcHOvCnvxAtQ1NwOwOYY6TublLIdD/G49oVgOMlUvhJotPUsceH8I/jDpYiOzGftlPFyYU46qO1xQpZrqp6rO3+VuVg13G0FnZ+h4QxnQl60h9GnDxw+LMsv+iI1H9zTVwq6bdv+jFUcgrjnHW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5XTjAEa; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5XTjAEa"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6eb16dfa988so20388926d6.2
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743773658; x=1744378458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z/VqN71KcRdE7ktnTsemr7YaQdPKpIwK7c4pn0lHyk=;
        b=b5XTjAEaR2vdP15rUJ1U4rL5ChzXkTDqUVJAisabK2PLZJWAhjZHnin9wpHwkPEGTC
         W4ipPZBQ/3LcJlTsmYHlMomNM8sFGIS/x/t1dwFV8th2uBxN+q7WXueTWvv2JU5MZbsz
         XiR9DMwr6JNI/NKd/nD6zf95fUqxf64L3S0R//NshxPnp6EiQS3ZXFQtSVWs2E5yzK+J
         XcsO/E3nykP12+v8KZmksFGawUL/vjXzpJJ55dGV41bqcPJEpmXYBHBieTIt4vTb6gj0
         DWoECA81Q2R21yCnF12T25wgH7o3QxcOQeZSGASJLiEY9bRug5ecnBIEh13WXy4lS/K2
         S2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743773658; x=1744378458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z/VqN71KcRdE7ktnTsemr7YaQdPKpIwK7c4pn0lHyk=;
        b=AGbBfJkfNJyjyhR1tPleI5WOeLFwNvt+EJxRF2salA5YiF36YlQghjtmn6voCf3SVX
         76MkXvrf/I7OL3l6+Bj3/JtF5oJZMxOEx4rkpIoeomp0O7jbjBsS5bEppoM7MtfEniaf
         Sc/NTxsmif6o3R+lrybQmM0A7eqRKhb6vULxIva8NiHQHQ0G1YaJGHMYDVRs++CyBGXK
         ZQKXQ0sIkhTcOLpytbQaiN9ba/bhLfFurQ5hM/TdXKPlZltTFRRTjPcxtUgc/mEhnWzX
         Y7jfhIfTwaJ+fMvlIqnpGNDBUVhp/feWrDsnYRQ9uaEQMqXXGQl5dWX0kFA7mcbxRB/V
         p6xg==
X-Gm-Message-State: AOJu0Yw1AZHR0NB7MWatjJ/nPzxTSeaPln4KjiaMQrmCwOSF5Pkczm5D
	jNgbYM6TitE7A+Sm99BrpUpkeKbStQvf7O2WmcX2T/oGHvdtCvR+0eZd5lWo
X-Gm-Gg: ASbGncu1WmiB444T/MMev20wDWfjTb8ZITTJ0t/IkOJmFBYMyXNlH+UAsZM6Mp/Q8Ge
	pEu4QwT8HBykGHJi2TfZdpJmC6cs7pak9ngLhc5iccG5gqbVecGrecznhHV0QS7JxPMwSCFEKu6
	T3xu4ItQL1ObbDxE7fubbiSZJtqZGiP8z7OBRJXO0bAQnHb+uoHlSRFs+4AflaqQkcqOfm+reQ7
	pFzpkHJ1/Ilt0fRMhTNvd2XvsRrqHS52GB/OTjGM3z7hTnatsN/aWaHSKfMzMvU9r7eSCnFduJq
	IV+AIlA57VrETF96vUxKutEcjNruXderYNvREpiahe+//1vrQZeLkqJwQrWR7l88u5BqN02EPT9
	uiT3pf1ddB/GAhqNBN39V8AR26KJaSFBVvvb83/AZk3wORC9iBbkS6Dl54g==
X-Google-Smtp-Source: AGHT+IFnTOj7FBvSBGeSO5rF7KrqwqhMi0Kp0MB5J0vCsIctHWlXoQ6j+aUFMaPGAJb8VsX91VxYjA==
X-Received: by 2002:a05:6214:2602:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6f05848bcddmr51222366d6.25.1743773657855;
        Fri, 04 Apr 2025 06:34:17 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14e9f2sm21385126d6.111.2025.04.04.06.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Apr 2025 06:34:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/capable_file: fix fsetid test
Date: Fri,  4 Apr 2025 09:33:19 -0400
Message-ID: <20250404133318.9589-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current test for the SELinux fsetid capability check tries to
set the setgid bit on a file with a different group ownership and
compares the file mode before and after to determine success/failure.
However, for reasons unknown, the current test runs chmod g+rs
which tries to set both the read bit and setgid bit, and will change
the read bit if not already set, causing the test to fail if the umask
doesn't allow group read by default. Fix the test to only run chmod g+s.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/capable_file/test | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/capable_file/test b/tests/capable_file/test
index 8d0acc9..1b2d1d0 100755
--- a/tests/capable_file/test
+++ b/tests/capable_file/test
@@ -40,7 +40,7 @@ ok( $result eq 0 );
 # CAP_FSETID
 $fn   = "$basedir/temp_file";
 $mode = ( stat($fn) )[2];
-system "runcon -t test_fcap_t -- chmod g+rs $basedir/temp_file 2>&1";
+system "runcon -t test_fcap_t -- chmod g+s $basedir/temp_file 2>&1";
 $result = 1;
 if ( $mode eq ( stat($fn) )[2] ) {
     $result = 0;
@@ -82,7 +82,7 @@ ok($result);
 $fn   = "$basedir/temp_file";
 $mode = ( stat($fn) )[2];
 $result =
-  system "runcon -t test_resfcap_t -- chmod g+rs $basedir/temp_file 2>&1";
+  system "runcon -t test_resfcap_t -- chmod g+s $basedir/temp_file 2>&1";
 $result = 1;
 if ( $mode eq ( stat($fn) )[2] ) {
     $result = 0;
-- 
2.47.1

