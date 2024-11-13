Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537A1FF7A4
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502940; cv=none; b=Cez/y28x2mRw8M7ze8OFuzO+L3H9l9pJ4HhrRZci+VFjQdFnYe3vKs+OtmF3BaTGIm1Ah4kz558DON/4hZoXBxnZGS0kpN2tKMZVLwbJsOoor9KdUeOcFmkF36TPI7pHFUa4bL/k19UgpiSCms2geMeN2htOCf0xW+WPZYxvfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502940; c=relaxed/simple;
	bh=BOgdHe/ABVS/3AzDyOUIxUy5fiMkBQu5HySNuTwJCeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=S4KBt3ZejTwoPZ1QzwerR3jhtQUxBwo+ckbf375AJih8Ff3zcVaWezVJOofr7DbTnnedY8NR5aQQ2Ptggxq09z7y/qBqO/SNyDLl3BkqFwnHAd3OfESt/Wt/K0ED2UbH9rNt2L0nzRyV9F9GxGh1o5YCzRIYWpzS1nbvbhnOT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acNqNKi7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acNqNKi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kshp3Gv8ZgSj9ZRWDNGVXzH5Uq+QUcK12mr0TUKyySY=;
	b=acNqNKi7wTOIaoAz2PPY9KYO6OmhGTNL0is5KW8XFjXv76gHeareeMU7SkTiNJLyYJLHOv
	wiXUqQb+7Hqmv5TXLXONZg13aFwaX9yKtYQd1cScYMiOD9i4GJ9tZP7Ilwzmiofnu2+imD
	ff9OchiPlUQ61SNahCQ+OWnEFKvIODk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-Vh9Qm_VKPTGMhd_kC4VbaA-1; Wed,
 13 Nov 2024 08:02:14 -0500
X-MC-Unique: Vh9Qm_VKPTGMhd_kC4VbaA-1
X-Mimecast-MFC-AGG-ID: Vh9Qm_VKPTGMhd_kC4VbaA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10FF519540F1;
	Wed, 13 Nov 2024 13:02:14 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97AE219560A3;
	Wed, 13 Nov 2024 13:02:12 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Christopher Tubbs <ctubbsii@fedoraproject.org>
Subject: [PATCH] fixfiles: use `grep -F` when search in mounts
Date: Wed, 13 Nov 2024 14:02:00 +0100
Message-ID: <20241113130206.1417824-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

systemd escapes luks uid so that mount points contain '\' and grep
should not consider this as regexp
Fixes:
    $ cat /proc/self/mounts | sort | uniq | awk '{print $2}'
    /run/credentials/systemd-cryptsetup@luks\134x2d6d1f41e6\134x2d5538\134x2d41a0\134x2db383\134x2cd41c2ddcacaa.service

    $ sudo fixfiles -B onboot
    grep: Invalid back reference
    grep: Invalid back reference
    System will relabel on next boot

Suggested-by: Christopher Tubbs <ctubbsii@fedoraproject.org>
Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 policycoreutils/scripts/fixfiles | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index cb50fef3ca65..b7cd765c15e4 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -45,9 +45,9 @@ FS="`cat /proc/self/mounts | sort | uniq | awk '{print $2}'`"
 for i in $FS; do
 	if [ `useseclabel` -ge 0 ]
 	then
-		grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)seclabel(,|$)' && echo $i
+		grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)seclabel(,|$)' && echo $i
 	else
-		grep " $i " /proc/self/mounts | grep -v "context=" | grep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
+		grep -F " $i " /proc/self/mounts | grep -v "context=" | grep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
 	fi
 done
 }
@@ -55,14 +55,14 @@ done
 get_rw_labeled_mounts() {
 FS=`get_all_labeled_mounts | sort | uniq`
 for i in $FS; do
-	grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)rw(,|$)' && echo $i
+	grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)rw(,|$)' && echo $i
 done
 }
 
 get_ro_labeled_mounts() {
 FS=`get_all_labeled_mounts | sort | uniq`
 for i in $FS; do
-	grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)ro(,|$)' && echo $i
+	grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)ro(,|$)' && echo $i
 done
 }
 
-- 
2.47.0

