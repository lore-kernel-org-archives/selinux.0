Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5668C433EF
	for <selinux@archiver.kernel.org>; Fri,  4 Feb 2022 13:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiBDNfR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBDNfQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Feb 2022 08:35:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48383C06173D
        for <selinux@vger.kernel.org>; Fri,  4 Feb 2022 05:35:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p15so19485234ejc.7
        for <selinux@vger.kernel.org>; Fri, 04 Feb 2022 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H4cxYrxUnYaUi7iHxIm3IBPA0e+9w3XJGkFijtA0XpU=;
        b=MhBohA8d6VCoEFSgCScYFIK2EpWo5Blaey1ngvJV5vQ+WXVptzrumSKH98QK40YCly
         e58PT+pMFurBr6S2eJhunBAj/3j+PSIyDYlmvrgNz/M2VlGDAUVlTpJuDQurccQpWufG
         WDndl0ZXPWMEwkeZOgd4nx7/wCqAxPv79AbV8ZKIlCPX/u43phsxbFC8keJGMVMvHoXB
         jnBzYTdY+nUjh2vGLGjA0QPfknP78yF6WAMzaaWd+ed4+iGBHyooEOCz+cyZxOZDLtcv
         xdP+g+B9kfSj1oUJOzIUrrQFjyJj8xq75FLoGhgkbaSmJj31XJ7HXOnUPmznT0zIcI/w
         A85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4cxYrxUnYaUi7iHxIm3IBPA0e+9w3XJGkFijtA0XpU=;
        b=c5+jfx0O/HjcxgQ9pxLwOy5G1ByYUF28EvcBjpEj5Uv8LUGcrFqi/2yeVgtPrl7++d
         itPftGZy4IuNsQCRE1H/8w5C4VgWE8Pt+gR5qDeaFxJ/+r6LpEtilgbYSa11Du3wBnTy
         w+ioQXyPLrjuY8HwkwPlTXzE2ZwQ1wxR5R8JkaNFWOpPOT2POBxrnL8aSINcLIWIHEDE
         r0iaWz9oTtwldpkkVPSgOhwId8FK4gy9Z3mXUxb0JJkT8FI/07BqdQmNSjFKvcfpfDR3
         EvDoSPaKt2eoYEuZZatuiV/2BGscoxRyruvIVNvd+lmTr1bR1sGpEbExT4zOvGaY2FgB
         K+ig==
X-Gm-Message-State: AOAM531W/8SYKHDfYRIjs0vw3cQWFiMKjNbaR2AqyM8OJl+/GuQ53gud
        vXhTxQ5vszJjsGRtXlQhy4EI2hOgtrk=
X-Google-Smtp-Source: ABdhPJzj3+Donu6TDCj45nhUXaTVMCdDGjkqPx8bSVYXxAyd/nLLjZtdfLqIej5+h7iPNAmeGZkHWQ==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr2515832ejc.13.1643981714769;
        Fri, 04 Feb 2022 05:35:14 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-249-090.77.8.pool.telefonica.de. [77.8.249.90])
        by smtp.gmail.com with ESMTPSA id m13sm664662eja.160.2022.02.04.05.35.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:35:14 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: add policy utilities
Date:   Fri,  4 Feb 2022 14:35:07 +0100
Message-Id: <20220204133507.26977-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204133507.26977-1-cgzones@googlemail.com>
References: <20220204133507.26977-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These are similar to the libselinux utilities but operate on a binary
policy instead of the running kernel.  This allows to run them on
SELinux disabled or even non Linux systems, e.g. for development or
continuous integration.

Link the utilities statically with libsepol due to usages of non public
exported interfaces.

sepol_check_access:
  (similar to selinux_check_access)
  Check access:

    $ sepol_check_access policy.bin staff_u:staff_r:gpg_t:s0 sysadm_u:sysadm_r:gpg_t:s0 process fork
    requested permission fork denied by constraint; reason:
    constrain process { fork setexec setfscreate setcurrent execmem execstack execheap setkeycreate setsockcreate } ((r1 == r2 -Fail-) ); Constraint DENIED
    constrain process { signull getsched getsession getpgid getcap getattr getrlimit } ((r1 == r2 -Fail-)  or (r1 != { staff_r user_r logadm_r apache2adm_r } -Fail-)  and (t1 == rbacproc_read -Fail-)  or (t1 == rbacproc_full -Fail-)  or (t1 == systemd_user_instance_domain -Fail-)  and (u2 == system_u -Fail-)  and (r2 == system_r -Fail-)  and (t2 == systemd_t -Fail-) ); Constraint DENIED
    constrain process { sigchld sigkill sigstop signal ptrace setsched setpgid setcap share setrlimit } ((r1 == r2 -Fail-)  or (r1 != { staff_r user_r logadm_r apache2adm_r } -Fail-)  and (t1 == rbacproc_full -Fail-)  or (t1 == systemd_user_instance_domain -Fail-)  and (u2 == system_u -Fail-)  and (r2 == system_r -Fail-)  and (t2 == systemd_t -Fail-) ); Constraint DENIED

sepol_compute_av:
  (similar to compute_av)
  Compute access vectors:

    $ sepol_compute_av policy.bin staff_u:staff_r:gpg_t:s0 staff_u:staff_r:gpg_t:s0 process
    allowed:     fork sigchld signull signal getsched setsched setpgid getcap setcap setrlimit
    decided:     fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit
    auditallow:
    auditdeny:   fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit

sepol_compute_member:
  (similar to compute_member)
  Compute a SID to use when selecting a member of a polyinstantiated object:

    $ sepol_compute_member policy.bin staff_u:staff_r:staff_t:s0 system_u:object_r:tmp_t:s0 dir
    system_u:object_r:user_tmp_t:s0

sepol_compute_relabel:
  (similar to compute_relabel)
  Compute a SID to use for relabeling an object:

    $ sepol_compute_relabel policy.bin staff_u:staff_r:staff_t:s0 system_u:object_r:tty_device_t:s0 chr_file
    staff_u:object_r:user_tty_device_t:s0

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/.gitignore                    |   4 +
 libsepol/utils/Makefile                |   2 +-
 libsepol/utils/sepol_check_access.c    | 130 +++++++++++++++++++++++++
 libsepol/utils/sepol_compute_av.c      |  66 +++++++++++++
 libsepol/utils/sepol_compute_member.c  |  64 ++++++++++++
 libsepol/utils/sepol_compute_relabel.c |  64 ++++++++++++
 6 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/utils/sepol_check_access.c
 create mode 100644 libsepol/utils/sepol_compute_av.c
 create mode 100644 libsepol/utils/sepol_compute_member.c
 create mode 100644 libsepol/utils/sepol_compute_relabel.c

diff --git a/libsepol/.gitignore b/libsepol/.gitignore
index 77bb5911..68cbe9b0 100644
--- a/libsepol/.gitignore
+++ b/libsepol/.gitignore
@@ -1,2 +1,6 @@
 utils/chkcon
+utils/sepol_check_access
+utils/sepol_compute_av
+utils/sepol_compute_member
+utils/sepol_compute_relabel
 libsepol.map
diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index 31932c11..8e89bc96 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 CFLAGS ?= -Wall -Werror
 override CFLAGS += -I../include
 override LDFLAGS += -L../src
-override LDLIBS += -lsepol
+override LDLIBS += ../src/libsepol.a
 
 TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_check_access.c
new file mode 100644
index 00000000..d0470156
--- /dev/null
+++ b/libsepol/utils/sepol_check_access.c
@@ -0,0 +1,130 @@
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb/services.h>
+#include <sepol/sepol.h>
+
+
+int main(int argc, char *argv[])
+{
+	FILE *fp;
+	sepol_security_id_t ssid, tsid;
+	sepol_security_class_t tclass;
+	const char *permlist;
+	sepol_access_vector_t av;
+	struct sepol_av_decision avd;
+	unsigned int reason;
+	char *reason_buf;
+	int i;
+
+	if (argc != 6) {
+		printf("usage:  %s policy source_context target_context class permission[,permission2[,...]]\n", argv[0]);
+		return 1;
+	}
+
+	fp = fopen(argv[1], "r");
+	if (!fp) {
+		fprintf(stderr, "Can't open policy %s:  %s\n", argv[1], strerror(errno));
+		return 1;
+	}
+	if (sepol_set_policydb_from_file(fp) < 0) {
+		fprintf(stderr, "Error while processing policy %s:  %s\n", argv[1], strerror(errno));
+		fclose(fp);
+		return 1;
+	}
+	fclose(fp);
+
+	if (sepol_context_to_sid(argv[2], strlen(argv[2]), &ssid) < 0) {
+		fprintf(stderr, "Invalid source context %s\n", argv[2]);
+		return 1;
+	}
+
+	if (sepol_context_to_sid(argv[3], strlen(argv[3]), &tsid) < 0) {
+		fprintf(stderr, "Invalid target context %s\n", argv[3]);
+		return 1;
+	}
+
+	if (sepol_string_to_security_class(argv[4], &tclass) < 0) {
+		fprintf(stderr, "Invalid security class %s\n", argv[4]);
+		return 1;
+	}
+
+	permlist = argv[5];
+	do {
+		char *tmp = NULL;
+		const char *perm;
+		const char *delim = strchr(permlist, ',');
+
+		if (delim) {
+			tmp = strndup(permlist, delim - permlist);
+			if (!tmp) {
+				fprintf(stderr, "Failed to allocate memory:  %s\n", strerror(errno));
+				return 1;
+			}
+		}
+
+		perm = tmp ? tmp : permlist;
+
+		if (sepol_string_to_av_perm(tclass, perm, &av) < 0) {
+			fprintf(stderr, "Invalid permission %s for security class %s:  %s\n", perm, argv[4], strerror(errno));
+			free(tmp);
+			return 1;
+		}
+
+		free(tmp);
+
+		permlist = strchr(permlist, ',');
+	} while (permlist++);
+
+	if (av == 0) {
+		fprintf(stderr, "Empty permission set computed from %s\n", argv[5]);
+		return 1;
+	}
+	
+	if (sepol_compute_av_reason_buffer(ssid, tsid, tclass, av, &avd, &reason, &reason_buf, 0) < 0) {
+		fprintf(stderr, "Failed to compute av decision:  %s\n", strerror(errno));
+		return 1;
+	}
+
+	if ((avd.allowed & av) == av) {
+		printf("requested permission %s allowed\n", argv[5]);
+		free(reason_buf);
+		return 0;
+	}
+
+	printf("requested permission %s denied by ", argv[5]);
+	i = 0;
+	if (reason & SEPOL_COMPUTEAV_TE) {
+		printf("te-rule");
+		i++;
+	}
+	if (reason & SEPOL_COMPUTEAV_CONS) {
+		if (i > 0)
+			printf(", ");
+		printf("constraint");
+		i++;
+	}
+	if (reason & SEPOL_COMPUTEAV_RBAC) {
+		if (i > 0)
+			printf(", ");
+		printf("transition-constraint");
+		i++;
+	}
+	if (reason & SEPOL_COMPUTEAV_BOUNDS) {
+		if (i > 0)
+			printf(", ");
+		printf("type-bound");
+		//i++;
+	}
+
+	if ((reason & SEPOL_COMPUTEAV_CONS) && reason_buf)
+		printf("; reason:\n%s", reason_buf);
+
+	free(reason_buf);
+
+	printf("\n");
+
+	return 7;		
+}
diff --git a/libsepol/utils/sepol_compute_av.c b/libsepol/utils/sepol_compute_av.c
new file mode 100644
index 00000000..d64dc31d
--- /dev/null
+++ b/libsepol/utils/sepol_compute_av.c
@@ -0,0 +1,66 @@
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb/services.h>
+#include <sepol/sepol.h>
+
+
+int main(int argc, char *argv[])
+{
+	FILE *fp;
+	sepol_security_id_t ssid, tsid;
+	sepol_security_class_t tclass;
+	struct sepol_av_decision avd;
+	int rc;
+
+	if (argc != 5) {
+		printf("usage:  %s policy scontext tcontext tclass\n", argv[0]);
+		return 1;
+	}
+
+	fp = fopen(argv[1], "r");
+	if (!fp) {
+		fprintf(stderr, "Can't open policy %s:  %s\n", argv[1], strerror(errno));
+		return 1;
+	}
+	if (sepol_set_policydb_from_file(fp) < 0) {
+		fprintf(stderr, "Error while processing policy %s:  %s\n", argv[1], strerror(errno));
+		fclose(fp);
+		return 1;
+	}
+	fclose(fp);
+
+	if (sepol_context_to_sid(argv[2], strlen(argv[2]), &ssid) < 0) {
+		fprintf(stderr, "Invalid source context %s\n", argv[2]);
+		return 1;
+	}
+
+	if (sepol_context_to_sid(argv[3], strlen(argv[3]), &tsid) < 0) {
+		fprintf(stderr, "Invalid target context %s\n", argv[3]);
+		return 1;
+	}
+
+	if (sepol_string_to_security_class(argv[4], &tclass) < 0) {
+		fprintf(stderr, "Invalid security class %s\n", argv[4]);
+		return 1;
+	}
+
+	rc = sepol_compute_av(ssid, tsid, tclass, 0, &avd);
+	switch (rc) {
+	case 0:
+		printf("allowed:    %s\n", sepol_av_perm_to_string(tclass, avd.allowed));
+		printf("decided:    %s\n", sepol_av_perm_to_string(tclass, avd.decided));
+		printf("auditallow: %s\n", sepol_av_perm_to_string(tclass, avd.auditallow));
+		printf("auditdeny:  %s\n", sepol_av_perm_to_string(tclass, avd.auditdeny));
+		break;
+	case -EINVAL:
+		printf("Invalid request\n");
+		break;
+	default:
+		printf("Failed to compute av decision: %d\n", rc);
+	}
+
+	return rc != 0;
+}
diff --git a/libsepol/utils/sepol_compute_member.c b/libsepol/utils/sepol_compute_member.c
new file mode 100644
index 00000000..3d67335d
--- /dev/null
+++ b/libsepol/utils/sepol_compute_member.c
@@ -0,0 +1,64 @@
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb/services.h>
+#include <sepol/sepol.h>
+
+
+int main(int argc, char *argv[])
+{
+	FILE *fp;
+	sepol_security_id_t ssid, tsid, out_sid;
+	sepol_security_class_t tclass;
+	char *context;
+	size_t context_len;
+	
+	if (argc != 5) {
+		printf("usage:  %s policy scontext tcontext tclass\n", argv[0]);
+		return 1;
+	}
+
+	fp = fopen(argv[1], "r");
+	if (!fp) {
+		fprintf(stderr, "Can't open policy %s:  %s\n", argv[1], strerror(errno));
+		return 1;
+	}
+	if (sepol_set_policydb_from_file(fp) < 0) {
+		fprintf(stderr, "Error while processing policy %s:  %s\n", argv[1], strerror(errno));
+		fclose(fp);
+		return 1;
+	}
+	fclose(fp);
+
+	if (sepol_context_to_sid(argv[2], strlen(argv[2]), &ssid) < 0) {
+		fprintf(stderr, "Invalid source context %s\n", argv[2]);
+		return 1;
+	}
+
+	if (sepol_context_to_sid(argv[3], strlen(argv[3]), &tsid) < 0) {
+		fprintf(stderr, "Invalid target context %s\n", argv[3]);
+		return 1;
+	}
+
+	if (sepol_string_to_security_class(argv[4], &tclass) < 0) {
+		fprintf(stderr, "Invalid security class %s\n", argv[4]);
+		return 1;
+	}
+
+	if (sepol_member_sid(ssid, tsid, tclass, &out_sid) < 0) {
+		fprintf(stderr, "Failed to compute member sid:  %s\n", strerror(errno));
+		return 1;
+	}
+	
+	if (sepol_sid_to_context(out_sid, &context, &context_len) < 0) {
+		fprintf(stderr, "Failed to convert sid %u:  %s\n", out_sid, strerror(errno));
+		return 1;
+	}
+
+	printf("%s\n", context);
+	free(context);
+
+	return 0;
+}
diff --git a/libsepol/utils/sepol_compute_relabel.c b/libsepol/utils/sepol_compute_relabel.c
new file mode 100644
index 00000000..db664ce8
--- /dev/null
+++ b/libsepol/utils/sepol_compute_relabel.c
@@ -0,0 +1,64 @@
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/policydb/services.h>
+#include <sepol/sepol.h>
+
+
+int main(int argc, char *argv[])
+{
+	FILE *fp;
+	sepol_security_id_t ssid, tsid, out_sid;
+	sepol_security_class_t tclass;
+	char *context;
+	size_t context_len;
+	
+	if (argc != 5) {
+		printf("usage:  %s policy scontext tcontext tclass\n", argv[0]);
+		return 1;
+	}
+
+	fp = fopen(argv[1], "r");
+	if (!fp) {
+		fprintf(stderr, "Can't open policy %s:  %s\n", argv[1], strerror(errno));
+		return 1;
+	}
+	if (sepol_set_policydb_from_file(fp) < 0) {
+		fprintf(stderr, "Error while processing policy %s:  %s\n", argv[1], strerror(errno));
+		fclose(fp);
+		return 1;
+	}
+	fclose(fp);
+
+	if (sepol_context_to_sid(argv[2], strlen(argv[2]), &ssid) < 0) {
+		fprintf(stderr, "Invalid source context %s\n", argv[2]);
+		return 1;
+	}
+
+	if (sepol_context_to_sid(argv[3], strlen(argv[3]), &tsid) < 0) {
+		fprintf(stderr, "Invalid target context %s\n", argv[3]);
+		return 1;
+	}
+
+	if (sepol_string_to_security_class(argv[4], &tclass) < 0) {
+		fprintf(stderr, "Invalid security class %s\n", argv[4]);
+		return 1;
+	}
+
+	if (sepol_change_sid(ssid, tsid, tclass, &out_sid) < 0) {
+		fprintf(stderr, "Failed to compute changed sid:  %s\n", strerror(errno));
+		return 1;
+	}
+	
+	if (sepol_sid_to_context(out_sid, &context, &context_len) < 0) {
+		fprintf(stderr, "Failed to convert sid %u:  %s\n", out_sid, strerror(errno));
+		return 1;
+	}
+
+	printf("%s\n", context);
+	free(context);
+
+	return 0;
+}
-- 
2.34.1

