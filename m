Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121C17DE0B
	for <selinux@vger.kernel.org>; Thu,  6 Jun 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667469; cv=none; b=LbN/bhNBTvxYwn9wR3CeyGhB/SlKqD2I1LLA+5siwsIg3Cf3Ykwznvl3twhSHV0gs9tanS5BOmbljXSm6Zhl9jd0u78QmDKth6IrKCD1zfpIxL7BgfWUz/nPdyv4PC9+pzHnQ8++hD7RPbxpJ9auua8ltP5F/mBiSnJEvROYiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667469; c=relaxed/simple;
	bh=j+bOLM/7ksiUc9hSiDaju8xHpBv8BUoR/wuLDm2TtFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Nxx74h+M7WMxBVv7uRQCNWCSK1CPLk1AaMvFo3wwbgbgfdxMlYato9+U09HNCk2PMePzhbDrk9NjT4poxbFh3Da77cWlwp6cxiy51tu4j3QTQOfsva+pQkdvhgSV+nGaQEDPmLG5SLeVlS+fTiBmb1lxCcrzobqPoiPxSMMYFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXMNht3l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXMNht3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717667464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWZzRHXwiD9UXrWBWkMS1Tvqjhpfq8N3kxS7P/ghNCU=;
	b=YXMNht3ldFFRh5A9f8SCszL3nFQHIzL+qONoeaJlfIjyhZuNwcuwuqT036LvCCSLj/5rX0
	dT4pQGCatVyrVkDODVfZy3UJbEkNnVZ/n/J/1dxTBvarcwQ7xGBjWuj8NY9uF4bfAfKJ8D
	hdRg5lRNuRFSU6QtMdw1La3e0K6op+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-iR9vyNM-MESLmXram3gy8g-1; Thu, 06 Jun 2024 05:51:03 -0400
X-MC-Unique: iR9vyNM-MESLmXram3gy8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07275800074
	for <selinux@vger.kernel.org>; Thu,  6 Jun 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.134])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46EBE492BF1;
	Thu,  6 Jun 2024 09:51:02 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] fixfiles: drop unnecessary \ line endings
Date: Thu,  6 Jun 2024 11:50:39 +0200
Message-ID: <20240606095039.50456-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

See https://github.com/koalaman/shellcheck/issues/2769

Fixes:
    $ shellcheck -S error fixfiles

    In fixfiles line 189:
            # These two sorts need to be separate commands \
                                                            ^-- SC1143 (error): This backslash is part of a comment and does not continue the line.

    For more information:
      https://www.shellcheck.net/wiki/SC1143 -- This backslash is part of a comme...

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 policycoreutils/scripts/fixfiles | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 166af6f360a2..cb50fef3ca65 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -173,10 +173,10 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	test -z "$TEMPFILE" && exit
 	PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
 	sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
-	sed -r -e 's,:s0, ,g' $FC | sort -u | \
-	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
-	    grep '^[<>]'|cut -c3-| grep ^/ | \
-	    grep -Ev '(^/home|^/root|^/tmp)' |\
+	sed -r -e 's,:s0, ,g' $FC | sort -u |
+	/usr/bin/diff -b ${PREFCTEMPFILE} - |
+	    grep '^[<>]'|cut -c3-| grep ^/ |
+	    grep -Ev '(^/home|^/root|^/tmp)' |
 	sed -r -e 's,[[:blank:]].*,,g' \
 	       -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
 	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
@@ -185,19 +185,19 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	       -e 's|\(.*|*|g' \
 	       -e 's|\[.*|*|g' \
 	       -e 's|\.\*.*|*|g' \
-	       -e 's|\.\+.*|*|g' | \
-	    # These two sorts need to be separate commands \
-	sort -u | \
-	sort -d | \
-	while read pattern ; \
-	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
-		  echo "$pattern"; \
-		  case "$pattern" in *"*") \
+	       -e 's|\.\+.*|*|g' |
+	    # These two sorts need to be separate commands
+	sort -u |
+	sort -d |
+	while read pattern ;
+	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then
+		  echo "$pattern";
+		  case "$pattern" in *"*")
 		       echo "$pattern" | sed -e 's,^,^,' -e 's,\*$,,g' >> ${TEMPFILE};;
-		  esac; \
-	       fi; \
-	    done | \
-	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -i -R -f -; \
+		  esac;
+	       fi;
+	    done |
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -i -R -f -;
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
-- 
2.45.2

