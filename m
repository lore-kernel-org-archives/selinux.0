Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD449B06
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524171; cv=none; b=Aj709+PgipShnrPNjQ1xHdFBQ+iMidwmd5e8/vE7DuvmTMVZ/xoNnC1ZqiblKzUz5OEy6ZNkOKrjtIgR9POnSFxQ+eeuS8avDQluvnPWMBOwpac/kCIZkUxNIGE+kcmfFG6s8D0V0iRRZEunDYDQ+6ypGGoHPm6PDOTaQkg6gXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524171; c=relaxed/simple;
	bh=t2uxulMchyxEPBhnXrsK7aMC+iV7ZBmP6D7KHXoUUok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4Mi1Cs8uilqtx1gAI+J9qihUeqpxrxPU26Ql6OqBphWYoQltr4ZJh0qOGT1p8WVynE9ZrVmvrbTMCzTHvzQH+E1WeLvXXPVVXFxJ1BHxgLN6syjwa2PUIPuwXFlS+oWnT9qlkfaXQdG84o1MFMmBQcrYW4uxGSRc4r46pCtzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/xyy9Wv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/xyy9Wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788524168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=soFKhDEvYZOZ6Wk0WYGws50eZoTm8h6iVPYNVvoEhMI=;
	b=V/xyy9WvbJV9XCmPnWdGN1HxjhEWXCjtpt2W6PxTNpEixdZC1jQSAsI/9AiAr+3n/2NJKd
	OvfUO0I26tKgK0hrstKdsTKJ592gCpqIHXEuANejqGCeWKz3VJI0QScBj1V3HFyj+H5SED
	GGYpbPma5rgDFf5Q8T/HwTlofU+soUg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-6vn_ccgjOoyBgn5WL1gtQg-1; Fri,
 04 Sep 2026 08:16:07 -0400
X-MC-Unique: 6vn_ccgjOoyBgn5WL1gtQg-1
X-Mimecast-MFC-AGG-ID: 6vn_ccgjOoyBgn5WL1gtQg_1788524166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A19B19560BB
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:16:06 +0000 (UTC)
Received: from p16v.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 314513001D81;
	Fri,  4 Sep 2026 12:16:04 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v4] Add support for UTF-8 in file context specifications
Date: Fri,  4 Sep 2026 14:11:30 +0200
Message-ID: <20260904121559.1658789-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement support for UTF-8 symbols in file specifications. Strings
representing paths are processed as bytes so if users need to use
wildcards on non-ascii symbols, they need to put them in pcre groups,
e.g. "/opt/žluťou(č)+"

This brings some overhead and so it's possible to disable UTF-8 support
build time using DISABLE_UTF=y environment variable.

Fixes:
    # cat unicode.cil
    (filecon "/opt/žluťoučký(/.*)?" any (system_u object_r user_home_t ((s0) (s0))))

    # semodule -i unicode.cil
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts:  line 2145 error due to: Non-ASCII characters found
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts:  line 2145 error due to: Non-ASCII characters found
    /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid argument
    libsemanage.semanage_validate_and_compile_fcontexts: setfiles returned error code 1.
    semodule:  Failed!

    # semanage fcontext --add -t user_home_t "/opt/žluťoučký(/.*)?"
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts.local:  line 4 error due to: Non-ASCII characters found
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts.local:  line 4 error due to: Non-ASCII characters found
    /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid argument
    libsemanage.semanage_validate_and_compile_fcontexts: setfiles returned error code 1.
    OSError: Error

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
v4 changes

- droped all setlocate()
- droped PCRE2_UTF flag

Tested with `semanage fcontext`, cil module and with a filename with invalid utf8 symbol:

    # semanage fcontext -a -t user_home_t '/opt/invalid-utf8(/.*)?'
    # restorecon -R -v /opt/invalid-utf8/
    Relabeled /opt/invalid-utf8 from system_u:object_r:usr_t:s0 to system_u:object_r:user_home_t:s0
    Relabeled /opt/invalid-utf8/subdir from system_u:object_r:usr_t:s0 to system_u:object_r:user_home_t:s0
    Relabeled /opt/invalid-utf8/subdir/invalid_�_dir/a from system_u:object_r:usr_t:s0 to system_u:object_r:user_home_t:s0
    Relabeled /opt/invalid-utf8/subdir/�_dir from system_u:object_r:usr_t:s0 to system_u:object_r:user_home_t:s0
    Relabeled /opt/invalid-utf8/subdir/invalid_�_dir from system_u:object_r:usr_t:s0 to system_u:object_r:user_home_t:s0


 libselinux/Makefile                 |  4 ++
 libselinux/src/label_support.c      | 83 +++++++++++++++++++++++++++++
 python/semanage/semanage-fcontext.8 |  1 +
 3 files changed, 88 insertions(+)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 48c0206a0a4b..aa8d053e359f 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -3,6 +3,7 @@ SUBDIRS = include src utils man
 PKG_CONFIG ?= pkg-config
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
+DISABLE_UTF ?= n
 ANDROID_HOST ?= n
 LABEL_BACKEND_ANDROID ?= n
 ifeq ($(ANDROID_HOST),y)
@@ -21,6 +22,9 @@ endif
 ifeq ($(DISABLE_X11),y)
 	DISABLE_FLAGS+= -DNO_X_BACKEND
 endif
+ifeq ($(DISABLE_UTF),y)
+	DISABLE_FLAGS+= -DNO_UTF
+endif
 export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X11 LABEL_BACKEND_ANDROID
 
 USE_PCRE2 ?= y
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index cc5c279e88fa..5112c59cdd5c 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -13,6 +13,76 @@
 #include <errno.h>
 #include "label_internal.h"
 
+#ifndef NO_UTF
+
+#define UTF8tail(x) ((x) >= 0x80 && (x) <= 0xBF)
+
+static size_t utf8_char_len(const unsigned char *s)
+{
+	/* rfc3629
+	 *  UTF8-octets = *( UTF8-char )
+	 *  UTF8-char   = UTF8-1 / UTF8-2 / UTF8-3 / UTF8-4
+	 *  UTF8-1      = %x00-7F
+	 *  UTF8-2      = %xC2-DF UTF8-tail
+	 *  UTF8-3      = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
+	 *                %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
+	 *  UTF8-4      = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
+	 *                %xF4 %x80-8F 2( UTF8-tail )
+	 *  UTF8-tail   = %x80-BF
+	 */
+	if (s[0] == '\0')
+		return 0;
+
+	if (s[0] < 0x80)
+		return 1;
+
+	if (s[0] < 0xC2 || s[1] == '\0')
+		return 0;
+
+	if (s[0] <= 0xDF && UTF8tail(s[1]))
+		return 2;
+
+	if (s[2] == '\0')
+		return 0;
+
+	/* %xE0 %xA0-BF UTF8-tail */
+	if (s[0] == 0xE0 && s[1] >= 0xA0 && s[1] <= 0xBF && UTF8tail(s[2]))
+		return 3;
+
+	/* %xE1-EC 2( UTF8-tail ) */
+	if (s[0] >= 0xE1 && s[0] <= 0xEC && UTF8tail(s[1]) && UTF8tail(s[2]))
+		return 3;
+
+	/* %xED %x80-9F UTF8-tail */
+	if (s[0] == 0xED && s[1] >= 0x80 && s[1] <= 0x9F && UTF8tail(s[2]))
+		return 3;
+
+	/* %xEE-EF 2( UTF8-tail ) */
+	if (s[0] >= 0xEE && s[0] <= 0xEF && UTF8tail(s[1]) && UTF8tail(s[2]))
+		return 3;
+
+	if (s[3] == '\0')
+		return 0;
+
+	/* %xF0 %x90-BF 2( UTF8-tail ) */
+	if (s[0] == 0xF0 && s[1] >= 0x90 && s[1] <= 0xBF && UTF8tail(s[2]) &&
+	    UTF8tail(s[3]))
+		return 4;
+
+	/* %xF1-F3 3( UTF8-tail ) */
+	if (s[0] >= 0xF1 && s[0] <= 0xF3 && UTF8tail(s[1]) && UTF8tail(s[2]) &&
+	    UTF8tail(s[3]))
+		return 4;
+
+	/* %xF4 %x80-8F 2( UTF8-tail ) */
+	if (s[0] == 0xF4 && s[1] >= 0x80 && s[1] <= 0x8F && UTF8tail(s[2]) &&
+	    UTF8tail(s[3]))
+		return 4;
+
+	return 0;
+}
+#endif
+
 /*
  * Read an entry from a spec file (e.g. file_contexts)
  * entry - Buffer to allocate for the entry.
@@ -36,6 +106,7 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len,
 	*len = 0;
 
 	while (!isspace((unsigned char)**ptr) && **ptr != '\0') {
+#ifdef NO_UTF
 		if (!isascii((unsigned char)**ptr)) {
 			errno = EINVAL;
 			*errbuf = "Non-ASCII characters found";
@@ -43,6 +114,18 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len,
 		}
 		(*ptr)++;
 		(*len)++;
+#else
+		size_t char_len = utf8_char_len((const unsigned char *)*ptr);
+
+		if (char_len == 0) {
+			errno = EINVAL;
+			*errbuf = "Invalid UTF-8 encoding";
+			return -1;
+		}
+
+		*ptr += char_len;
+		*len += char_len;
+#endif
 	}
 
 	if (*len) {
diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index b037491e3394..66956440c5c5 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -19,6 +19,7 @@ describing fully qualified path(s). The only PCRE flag in use is PCRE2_DOTALL,
 which causes a wildcard '.' to match anything, including a new line.
 Strings representing paths are processed as bytes (as opposed to Unicode),
 meaning that non-ASCII characters are not matched by a single wildcard.
+If you need to match a non-ASCII character with a wildcard, put it in a group, e.g. '(č)*'
 
 Note, that file context definitions specified using 'semanage fcontext'
 (i.e. local file context modifications stored in file_contexts.local)
-- 
2.55.0

