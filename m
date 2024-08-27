Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E114D29C
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758327; cv=none; b=eNs+NYZ27UBx83Jpq9TSeis4fvB1211EeLoXVQ8EfMT+RcIM6YmvqM4Wl20ZJTX5V6X9z/w8C911vg5lT0a6gBvgiQ5pg8WLnpAPFHhmdEkykqv1EOYzhHE8hBxkd80pM00sVSzmE+AMy66sCUB4ScCk/XYl11OuwDtnlFe5plo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758327; c=relaxed/simple;
	bh=PySkRU+qGn60iMOeSytHBcmkATD4savJGG2ZVBDQGUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=fvkj/8OT28P7Se/aQKM8Hw+BCvgX/NB7p+ght9ROPm4pAQOJp7sIKyRzRsIIQgaZBFoaZUjS5ZzZpEvka5sf113P7nZBVV+5SiFjiQZvOAH18wV3x169T2hbigD+/0f7uHoAgujCibLIDd0A+pFfNEj8qgaTWnd+lWPpzUH/N/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ccylq+3d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ccylq+3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724758324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwcrgQwOHy9SUzsmtoz1OK2OrohTdyPda+yrjXkulSc=;
	b=Ccylq+3dmwUQMTe++L+fwtoUbtmjm80KqO4jsNMasUXsEdH/2mWPt9mHTwxE9w2HpD4/vg
	LyE56crKVCrBDGOW4R0P55dLXtfdogzZpkkZXruh1NMRCCBLq5mH9gT+gJI6oJU4hFbK6q
	Y5TO3reKm09DndJ14X2kd39THFX66+c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-4-xuBxcOMZOEoFltMzG9-Q-1; Tue,
 27 Aug 2024 07:32:03 -0400
X-MC-Unique: 4-xuBxcOMZOEoFltMzG9-Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25ADA1955BF6
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 11:32:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A5B31954AFF;
	Tue, 27 Aug 2024 11:32:00 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] sepolgen-ifgen: allow M4 escaped filenames
Date: Tue, 27 Aug 2024 13:28:13 +0200
Message-ID: <20240827113150.1843304-1-lautrbach@redhat.com>
In-Reply-To: <20240819182123.1037607-2-lautrbach@redhat.com>
References: <20240819182123.1037607-2-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When a file name in type transition rule used in an interface is same as
a keyword, it needs to be M4 escaped so that the keyword is not expanded
by M4, e.g.

-	filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, dir, "interface")
+	filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, dir, ``"interface"'')

But sepolgen-ifgen could not parse such string:

    # sepolgen-ifgen
    Illegal character '`'

This change allows M4 escaping inside quoted strings and fixed described
problem.

https://bugzilla.redhat.com/show_bug.cgi?id=2254206

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

change to v1:

- use ``"..."'' instead of "``..''" - sugested in https://github.com/SELinuxProject/selint/pull/291 by
  @cgzones

- controls right number of openning and closing quotes

 python/sepolgen/src/sepolgen/refparser.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index e261d3f78f87..c8a3eb54d679 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -486,7 +486,7 @@ def p_interface_call_param(p):
                             | nested_id_set
                             | TRUE
                             | FALSE
-                            | FILENAME
+                            | quoted_filename
     '''
     # Intentionally let single identifiers pass through
     # List means set, non-list identifier
@@ -1027,6 +1027,11 @@ def p_optional_semi(p):
                    | empty'''
     pass
 
+def p_quoted_filename(p):
+    '''quoted_filename : TICK quoted_filename SQUOTE
+                       | FILENAME
+    '''
+    p[0] = p[1]
 
 #
 # Interface to the parser
-- 
2.46.0

