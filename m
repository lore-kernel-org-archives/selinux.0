Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792017E470
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010055; cv=none; b=IiAWxhf8RAItDbWZq5gEbCal2/fQ6tsB48rllSGJxJnSY8aPvuddFnO9UMMpyxJZGStd4AV2qOeZp6hwgt+9SGRxLTdaZcBdxhCHTU/OnYOrGE1KJXpymc9bwAein1G8JONjw9IQ+u6rrPyXCY6LZP+3GechemhX8eCQ/Kq7LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010055; c=relaxed/simple;
	bh=lwf2hdzBFoW3WShj1TwW/6UR7VnTpdjBUrMJtXZM+XA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVVrZM5D0w76yijwe70ks4MvNn1tsBBKPC7ESVGl9LblbPC+WMyMHeiZjmksCsMny5FNtuDi8xNlUjrdLDdHW7AP7D/kk5F5ToMG34cqFGkfXm1rgh0VUYtMc7oe2T31WAgFjK0iGjKqNVrIjghRGwrOkq4ylGFui5K5LuesAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8xzdPTM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8xzdPTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722010052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOJLcjieES+tB4tRofO+chFavHGd/KQUGWhzuHYgx20=;
	b=E8xzdPTMVov0RcagVsyQ9DTY8cwMplpOlH+Xv2tt3tLjTVP26sdy8XF9phRqrAPyUKgir1
	CwZ8dm4OjZyi2a9qtd64U9+A56GjZN3JP5vbJuvXa3YJa4J0QCBtRauJ6cmgxtvabjqKYB
	2vvtYP2CwJc4n9pVS6kEcoTGzfM8v58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-qpoqsPuAPiyzuXNF34IA3Q-1; Fri,
 26 Jul 2024 12:07:30 -0400
X-MC-Unique: qpoqsPuAPiyzuXNF34IA3Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AEF61955D58
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 16:07:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.161])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 471971955D45
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 16:07:29 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libselinux/restorecon: Include <selinux/label.h>
Date: Fri, 26 Jul 2024 17:59:15 +0200
Message-ID: <20240726160725.1598159-1-vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ4hUc67Ra7vE7z1znGfx=8UqCSFY_OouJ0_mOQW4-qx1Q@mail.gmail.com>
References: <CAEjxPJ4hUc67Ra7vE7z1znGfx=8UqCSFY_OouJ0_mOQW4-qx1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

restorecon.h uses types defined in label.h, so it needs to include
label.h (or code using restorecon.h also needs to include label.h,
which is not practical).

Fixes:
  $ make DESTDIR=~/obj install > make.out
In file included from semanage_store.c:39:
/home/sdsmall/obj/usr/include/selinux/restorecon.h:137:52: error:
‘struct selabel_handle’ declared inside parameter list will not be
visible outside of this definition or declaration [-Werror]
  137 | extern void selinux_restorecon_set_sehandle(struct
selabel_handle *hndl);
      |                                                    ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [Makefile:111: semanage_store.o] Error 1
make[1]: *** [Makefile:15: install] Error 2
make: *** [Makefile:40: install] Error 1

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
Sorry, did not notice the error since for some reason fedora-rawhide
build with the patch was successful:
https://copr.fedorainfracloud.org/coprs/vmojzis/userspace_test/build/7789598/
But I managed to reporoduce it on a fresh system with the command you
provided.
I assume you meant label.h instead of handle.h.

 libselinux/include/selinux/restorecon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index b10fe684..5be6542c 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -1,6 +1,8 @@
 #ifndef _RESTORECON_H_
 #define _RESTORECON_H_
 
+#include <selinux/label.h>
+
 #include <sys/types.h>
 #include <stddef.h>
 #include <stdarg.h>
-- 
2.43.0

