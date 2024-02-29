Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD616063C
	for <selinux@vger.kernel.org>; Thu, 29 Feb 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225137; cv=none; b=LRYYT+GZdz/ifg5TgqbTDozV75R5Nal1d5iURcbC56u6Rgf8Ue5vxRduUP63pXfUYGan1WfskYNDhJ838+Dd5H/wgHitDsaWn9e5WuY1OdZHcdurHKVpnlcl+o50b/ohAxBfhSTwr7MDCy59GLkge+sg+d1uN524oX3t89xCuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225137; c=relaxed/simple;
	bh=cadlPRjXvxMDSTEJ7/wFbOrpqGtkjmuryluV/9Op6pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WaWFm9nFAAYFqJSrR5H2kiMFh7OeKhkFd8o/9cieol5v8V15EhKFP+P/vas61mlddpLTU5rAa46bEQOI6ibeoTlYpmKD161LA7f6fVVCbODYKJXGTKHJLZqTgQdYbB1Mq/TuGu5AFgMYTiyhg1zeZP4uSt93SomndMYlbAY/GCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmsnet.nl; spf=pass smtp.mailfrom=xmsnet.nl; dkim=pass (1024-bit key) header.d=xmsnet.nl header.i=@xmsnet.nl header.b=E7Gv1Bdm; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmsnet.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmsnet.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmsnet.nl header.i=@xmsnet.nl header.b="E7Gv1Bdm"
X-KPN-MessageId: e92b03be-d721-11ee-bbc7-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e92b03be-d721-11ee-bbc7-005056abad63;
	Thu, 29 Feb 2024 17:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xmsnet.nl; s=xmsnet01;
	h=mime-version:message-id:date:subject:to:from;
	bh=dpbyU/EffK12vuSAsG4sTgF/Jtb4hEOn7gqC2frGFaU=;
	b=E7Gv1BdmSYuQZzgzYLR0UQqEvdbjIlo6m9Hbi0Vq5yVxDiazhDJnuE5qhy6iO1uWzZKlrBkguOSoL
	 RZfGFJakj699eMLX2VML9bq2FYkdDerzdTfFZKzImewH/yJl1boV7leINHGbzWWbQuGAp+ItwQUAA9
	 l5ULUpjFbl7nGqyY=
X-KPN-MID: 33|gqrXZhrj2fzQrItuUmHs2T4GVzZKIWK/cULWR8XfJBa3YIAcnYaBBoQcsIg7Rk8
 cQlFW4HXQAaooGtmqHWTH08t3J2+1hyyjKYsmc6gW4Ck=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pI3GA1hc34WeLtNvD8H29dM6C9G31SP18FBvYaVQPoTp6b9OG0/D7Elp1nMPRSf
 zEzIIJ9fdMIPu3Ezj0c+Y8w==
Received: from linux-wdobbe.kpn (82-168-100-176.fixed.kpn.net [82.168.100.176])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e64b040f-d721-11ee-a456-005056abf0db;
	Thu, 29 Feb 2024 17:45:25 +0100 (CET)
From: Winfried Dobbe <winfried_mb2@xmsnet.nl>
To: selinux@vger.kernel.org
Cc: Winfried Dobbe <winfried_mb2@xmsnet.nl>
Subject: [PATCH] libsepoll/src/Makefile: Fix reallocarray detection when cross-compiling
Date: Thu, 29 Feb 2024 17:44:39 +0100
Message-Id: <20240229164439.20521-1-winfried_mb2@xmsnet.nl>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to commit 3e3661f602fe7d7dc972bf695fd178370bbd7e54, CFLAGS
are also needed for the reallocarray detection when cross-compiling
libsepoll.

For example when cross-compiling for Arm Cortex-A9 the compiler finds
stdlib.h (after the addition of LDFLAGS in above mentioned 3e3661f).
But then tries to include soft-float stubs because gcc options
-mfpu=neon -mfloat-abi=hard are missing. See output of detection:

In file included from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysroots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/gnu/stubs.h:40,
                 from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysroots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/features.h:474,
                 from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysroots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/bits/libc-header-start.h:33,
                 from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysroots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/stdlib.h:25,
                 from <stdin>:2:
/home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysroots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/gnu/stubs-32.h:7:11: fatal error: gnu/stubs-soft.h: No such file or directory
    7 | # include <gnu/stubs-soft.h>
      |           ^~~~~~~~~~~~~~~~~~
compilation terminated.

Signed-off-by: Winfried Dobbe <winfried_mb2@xmsnet.nl>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 16b9bd5e..fd6329d4 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -31,7 +31,7 @@ endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-- 
2.35.3

