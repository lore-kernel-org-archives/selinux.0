Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6D187872
	for <selinux@vger.kernel.org>; Wed, 16 Oct 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104526; cv=none; b=UuKDNSJA2faW5nb6umMqlxUZm08T5zrBAbePOCek3O8VtspZ2raeAPrCsx+yMRcSW8McojPaUQ7+H9t9kcXGLqITPjZW7Y5bzkmSPZX5QkJn0RCE0SbwK9rGBJ3brG+GV4fptJoycFRbDcubuZD/UuwoUrJOyLsTuHLCVXAiDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104526; c=relaxed/simple;
	bh=xdpSFjk54tgTBJPf/PNla8kkJ9+Q4yjeqCszbrFS0Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=DkRA96B5gGthtpJ4Zz9jrEJ1LMPVNrybf6IwjzGmzf/Fxc3bjK3nCiPuGoZ3v155tdaaC0MdVQpfw3IzHik29ftLunlTPzwVhcOOmporzP5kubkL8j7wmZRelRO/9K5m6zcEk86hIk6QQ4xjsz+Haa+73AhZ5E9yef/Zm837bgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiApt9g3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiApt9g3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729104522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNicAhGIzvw5XHzJMfud5kPOE8zN3ockJUcTQDZo7x4=;
	b=MiApt9g3q/tXz1GBf7sIRLmV65sTijaB0q1oX5EhvITzqpV4RkGMg+Ri7tmPbpdErLPWKd
	XOxRbjIPp1+PLBrVwf+BmHMtQWzt+jK7gopdqxuYcd/GLTLvjKTEC4tvX6Bao/UYzzCfKR
	gKjDgGre38T9HR7RbYSJTc4eaithRVo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-VQIWGyXAPP6ucwDi0E6k7g-1; Wed,
 16 Oct 2024 14:48:41 -0400
X-MC-Unique: VQIWGyXAPP6ucwDi0E6k7g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5128D1955EAC
	for <selinux@vger.kernel.org>; Wed, 16 Oct 2024 18:48:40 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2197C1956054;
	Wed, 16 Oct 2024 18:48:38 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Jitka Plesnikova <jplesnik@redhat.com>
Subject: [PATCH 2/2] libsemanage: fix swig bindings for 4.3.0
Date: Wed, 16 Oct 2024 20:48:12 +0200
Message-ID: <20241016184825.200567-2-lautrbach@redhat.com>
In-Reply-To: <20241016184825.200567-1-lautrbach@redhat.com>
References: <20241016184825.200567-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
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

Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsemanage/src/semanageswig_python.i | 64 +++++++++++++--------------
 libsemanage/src/semanageswig_ruby.i   | 32 +++++++-------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 5f0113966962..0e27424f4dec 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -111,7 +111,7 @@
 }
 
 %typemap(argout) char** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_FromCharPtr(*$1));
+	$result = SWIG_AppendOutput($result, SWIG_FromCharPtr(*$1));
 	free(*$1);
 }
 
@@ -134,7 +134,7 @@
                         	NULL, NULL, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -148,7 +148,7 @@
 }
 
 %typemap(argout) semanage_module_info_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** module key typemaps **/
@@ -160,7 +160,7 @@
 }
 
 %typemap(argout) semanage_module_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** context typemaps **/
@@ -172,7 +172,7 @@
 }
 
 %typemap(argout) semanage_context_t** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** boolean typemaps **/
@@ -197,7 +197,7 @@
 				(void (*) (void*)) &semanage_bool_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-		   	        $result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -207,11 +207,11 @@
 }
 
 %typemap(argout) semanage_bool_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_bool_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp=NULL) {
@@ -240,7 +240,7 @@
 				(void (*) (void*)) &semanage_fcontext_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -250,11 +250,11 @@
 }
 
 %typemap(argout) semanage_fcontext_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_fcontext_key_t ** {
-        $result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp=NULL) {
@@ -284,7 +284,7 @@
 				(void (*) (void*)) &semanage_iface_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -294,11 +294,11 @@
 }
 
 %typemap(argout) semanage_iface_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_iface_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp=NULL) {
@@ -328,7 +328,7 @@
 				(void (*) (void*)) &semanage_seuser_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -338,11 +338,11 @@
 }
 
 %typemap(argout) semanage_seuser_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_seuser_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp=NULL) {
@@ -371,7 +371,7 @@
 				(void (*) (void*)) &semanage_user_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -381,11 +381,11 @@
 }
 
 %typemap(argout) semanage_user_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_user_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp=NULL) {
@@ -414,7 +414,7 @@
 				(void (*) (void*)) &semanage_port_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -424,11 +424,11 @@
 }
 
 %typemap(argout) semanage_port_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_port_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp=NULL) {
@@ -457,7 +457,7 @@
 				(void (*) (void*)) &semanage_ibpkey_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -467,11 +467,11 @@
 }
 
 %typemap(argout) semanage_ibpkey_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_ibpkey_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_ibpkey_key_t **(semanage_ibpkey_key_t *temp=NULL) {
@@ -500,7 +500,7 @@
 				(void (*) (void*)) &semanage_ibendport_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -510,11 +510,11 @@
 }
 
 %typemap(argout) semanage_ibendport_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_ibendport_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_ibendport_key_t **(semanage_ibendport_key_t *temp=NULL) {
@@ -543,7 +543,7 @@
 				(void (*) (void*)) &semanage_node_free, &plist) < 0)
 				$result = SWIG_From_int(STATUS_ERR);
 			else
-				$result = SWIG_Python_AppendOutput($result, plist);
+				$result = SWIG_AppendOutput($result, plist);
 		}
 	}
 }
@@ -553,12 +553,12 @@
 }
 
 %typemap(argout) semanage_node_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 
 %typemap(argout) semanage_node_key_t ** {
-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp=NULL) {
diff --git a/libsemanage/src/semanageswig_ruby.i b/libsemanage/src/semanageswig_ruby.i
index e030e4aea7ba..9010b5456b1a 100644
--- a/libsemanage/src/semanageswig_ruby.i
+++ b/libsemanage/src/semanageswig_ruby.i
@@ -38,7 +38,7 @@
 }
 
 %typemap(argout) semanage_module_info_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** context typemaps **/
@@ -50,7 +50,7 @@
 }
 
 %typemap(argout) semanage_context_t** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** boolean typemaps **/
@@ -66,11 +66,11 @@
 }
 
 %typemap(argout) semanage_bool_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_bool_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp=NULL) {
@@ -90,11 +90,11 @@
 }
 
 %typemap(argout) semanage_fcontext_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_fcontext_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp=NULL) {
@@ -114,11 +114,11 @@
 }
 
 %typemap(argout) semanage_iface_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_iface_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp=NULL) {
@@ -138,11 +138,11 @@
 }
 
 %typemap(argout) semanage_seuser_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_seuser_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp=NULL) {
@@ -162,11 +162,11 @@
 }
 
 %typemap(argout) semanage_user_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_user_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp=NULL) {
@@ -186,11 +186,11 @@
 }
 
 %typemap(argout) semanage_port_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_port_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp=NULL) {
@@ -210,12 +210,12 @@
 }
 
 %typemap(argout) semanage_node_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 
 %typemap(argout) semanage_node_key_t ** {
-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp=NULL) {
-- 
2.47.0

