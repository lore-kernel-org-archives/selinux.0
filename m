Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106D1B86C9
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553039; cv=none; b=Xjya9g0q9L6sE2LFmJ0tA475yAySLlb3r5YIF5XNsNfdIeiLqS/ChMNviuft9xgMiC1YUnutBA9irk6cNJGQJCNMfVMxZhlP5TNRMUmivqwLSQKhgOtCsLIP/qxGmw66Hpd2RaNUXkjoVKHm3Lwx3OPs8Otxwyhmg6VQmO2rtp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553039; c=relaxed/simple;
	bh=6+VL6jhjUbtbFm6v9yi31EkaOxIKI1HgajhiCpmYvp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=HLqA+2pzoWeGt+rOIks8l/9gmc9f2/IWqE4r9P3GhpKMf2or+wR8cDmlURkmfM8WmPHV1q4Ns/3DJVdNq2gWgh3lfCTub+hsLs6fS4MZiO5ni7MvAbhJ5haXpq+uHD0qhwGoqPkT8TIi514c2uxQpDiQvI6VpHGRNY3a3KpmhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpdgOuJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpdgOuJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720553037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yYrNv0qpKFkI+HcpsqAD0lqt8Jm2n8TFDgFQc6f0ky0=;
	b=JpdgOuJwyex+4l24x/QY/XdihA0GSf6QXJXotUab+Kqwz1TofgZcikAlSf+hEHcQt6oZpK
	QYsTxP/n3hamgkXw7/Q5fYAIJoTivX57s3Pq4w/HTkYA/1bh/KLIfpPrJqa6sIfq6LfmOj
	ZzTQJHl5UYGGsl6SbHWt0hEMNjyj8Ds=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-T9mpayamOp-YU78fft9TWA-1; Tue,
 09 Jul 2024 15:23:55 -0400
X-MC-Unique: T9mpayamOp-YU78fft9TWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE84C195394F
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 19:23:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A9651955F3B;
	Tue,  9 Jul 2024 19:23:53 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] libselinux: set free'd data to NULL
Date: Tue,  9 Jul 2024 21:23:46 +0200
Message-ID: <20240709192346.913107-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fixes segfault in selabel_open() on systems with SELinux disabled and without any
SELinux policy installed introduced by commit 5876aca0484f ("libselinux: free
data on selabel open failure"):

    $ sestatus
    SELinux status:                 disabled

    $ cat /etc/selinux/config
    cat: /etc/selinux/config: No such file or directory

    $ matchpathcon /abc
    [1]    907999 segmentation fault (core dumped)  matchpathcon /abc

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libselinux/src/label_backends_android.c | 1 +
 libselinux/src/label_file.c             | 1 +
 libselinux/src/label_media.c            | 1 +
 libselinux/src/label_x.c                | 1 +
 4 files changed, 4 insertions(+)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 49a87686de4c..5bad24f20d73 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -260,6 +260,7 @@ static void closef(struct selabel_handle *rec)
 		free(data->spec_arr);
 
 	free(data);
+	rec->data = NULL;
 }
 
 static struct selabel_lookup_rec *property_lookup(struct selabel_handle *rec,
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 2732972e61cf..59c9f2ef3442 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -942,6 +942,7 @@ static void closef(struct selabel_handle *rec)
 		free(last_area);
 	}
 	free(data);
+	rec->data = NULL;
 }
 
 // Finds all the matches of |key| in the given context. Returns the result in
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 852aeada8ff4..bae065c12a55 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -183,6 +183,7 @@ static void close(struct selabel_handle *rec)
 	    free(spec_arr);
 
 	free(data);
+	rec->data = NULL;
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index a8decc7a0093..ddae4f6c22b6 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -210,6 +210,7 @@ static void close(struct selabel_handle *rec)
 	    free(spec_arr);
 
 	free(data);
+	rec->data = NULL;
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
-- 
2.45.2

