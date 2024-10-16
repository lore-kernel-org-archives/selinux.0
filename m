Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011D290F
	for <selinux@vger.kernel.org>; Wed, 16 Oct 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104523; cv=none; b=b1J+Y3+vn3v/1ki+VDyE1n75Ixr5Zto/IKLshq4c17AeGFyEPhW4ZUCeiE/GHZGxFvnOdSq87IkW636+uhPGCcuHACDqwqh55c7LieKgCW9XIzFRR9u6ICmmvTKhSy+DdIhPg1HE3aloEhw4OpzRW59Rc/Vjdazt1ngkBGWIU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104523; c=relaxed/simple;
	bh=+CPmBcqQGmM+48XyPYhwnAKZt8U89XYg5VgaGwIRTTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXxrOpQA6vsVYnfK+I16I6CELrnQlK9pwDAqg8z9+GdrBa7813iIc+7AfTyuhRxxRpHd6tz/ap+2EZZLzpHakx5B6PHm2ryxdBEHVkwXKUa5iEOcXDSKWiQIRNU8Y4QiF8W+9VWcB6b2fKBflCZrxpRGZKqA7113+UkYhUKbYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONplgX0w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONplgX0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729104520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z8TLL8zRZGWTeEZmOm6IbNZIfL+a03iOu7JM/mfbzME=;
	b=ONplgX0wGZhX1kGuhmBZr3RQzLrHGZMr82C2mxaDTa3BiWdNsr7t1YSP3UfCHMe6bA9OFD
	Bk2wvsTxQcKQgi6Lt2mfSzimLzH8YdqNfTrW+38J8vddp7hN+7OIHQnt2xS+Cev8Maj6ZJ
	oSBfUKpfDhTUhP9BXGNIxzFb7q86AQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-wsJG35NvOAeMtNgKTqlOjw-1; Wed,
 16 Oct 2024 14:48:39 -0400
X-MC-Unique: wsJG35NvOAeMtNgKTqlOjw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD0AA1955F45
	for <selinux@vger.kernel.org>; Wed, 16 Oct 2024 18:48:38 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73D6619560AD;
	Wed, 16 Oct 2024 18:48:37 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Jitka Plesnikova <jplesnik@redhat.com>
Subject: [PATCH 1/2] libselinux: fix swig bindings for 4.3.0
Date: Wed, 16 Oct 2024 20:48:11 +0200
Message-ID: <20241016184825.200567-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

https://github.com/swig/swig/blob/master/CHANGES.current

"[Python] #2907 Fix returning null from functions with output
parameters.  Ensures OUTPUT and INOUT typemaps are handled
consistently wrt return type.

New declaration of SWIG_Python_AppendOutput is now:

  SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void);

The 3rd parameter is new and the new $isvoid special variable
should be passed to it, indicating whether or not the wrapped
function returns void.

Also consider replacing with:

  SWIG_AppendOutput(PyObject* result, PyObject* obj);

which calls SWIG_Python_AppendOutput with same parameters but adding $isvoid
for final parameter."

Fixes: https://github.com/SELinuxProject/selinux/issues/447

    selinuxswig_python_wrap.c: In function ‘_wrap_security_compute_user’:
    selinuxswig_python_wrap.c:11499:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
    11499 |     resultobj = SWIG_Python_AppendOutput(resultobj, plist);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
    selinuxswig_python_wrap.c:1248:1: note: declared here
     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void) {
          | ^~~~~~~~~~~~~~~~~~~~~~~~
    selinuxswig_python_wrap.c: In function ‘_wrap_security_compute_user_raw’:
    selinuxswig_python_wrap.c:11570:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
    11570 |     resultobj = SWIG_Python_AppendOutput(resultobj, plist);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
    selinuxswig_python_wrap.c:1248:1: note: declared here
     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void) {
          | ^~~~~~~~~~~~~~~~~~~~~~~~
    selinuxswig_python_wrap.c: In function ‘_wrap_security_get_boolean_names’:
    selinuxswig_python_wrap.c:12470:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
    12470 |     resultobj = SWIG_Python_AppendOutput(resultobj, list);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
    selinuxswig_python_wrap.c:1248:1: note: declared here
     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void) {
          | ^~~~~~~~~~~~~~~~~~~~~~~~
    error: command '/usr/bin/gcc' failed with exit code 1

Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libselinux/src/selinuxswig_python.i | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 17e03b9e36a5..03ed296d5b85 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -71,7 +71,7 @@ def install(src, dest):
 	for (i = 0; i < *$2; i++) {
 		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
 	}
-	$result = SWIG_Python_AppendOutput($result, list);
+	$result = SWIG_AppendOutput($result, list);
 }
 
 /* return a sid along with the result */
@@ -108,7 +108,7 @@ def install(src, dest):
 		plist = PyList_New(0);
 	}
 
-	$result = SWIG_Python_AppendOutput($result, plist);
+	$result = SWIG_AppendOutput($result, plist);
 }
 
 /* Makes functions in get_context_list.h return a Python list of contexts */
-- 
2.47.0

