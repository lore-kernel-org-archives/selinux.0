Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA26C433EF
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiBVNzN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBVNzK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:55:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E5117C9B
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a23so43025647eju.3
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZSfKa5NJAUkB5EtruIW01DZgJkOUsDe1CXpXfBfFkzc=;
        b=AtBsgIt3+lM7r/51w8qiEA0AMl+1wtIywnt8NND+xQip0Gd3k15NJbiWc7TWVaJtXs
         3HtFYkutnnJjZJ1tE/heCfY/uDptqo2QcuxVRIvQBVQJg8E3cLZ19jRIm4l03yfxf1DR
         TsvxQ3kcigG1ja6OtuDfQTYXr5JksKjF5ey88zknhaQELjWai8Z/6iknrJk1jhKIh7lx
         telQi2uNX6t3WklYrfL4cfqWzArbUJna/AcR/lV5JiahpnjJ+mhbfnHZ+DbtH8G1to0H
         72AQYXxQFGk5FT15GTMKMj/mwqsrLqRMC/VEDeMQfAART3dPdmVdIoDjQYhACsFVKjyM
         pMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSfKa5NJAUkB5EtruIW01DZgJkOUsDe1CXpXfBfFkzc=;
        b=TxPRvEzhjREWuRT+idqWGzvItUI/reaq0pCDfWXVX9rWv3VdtWmAWnWuu7wPvTHfJl
         OFfJv9EeHYUljUx0llOXs6x2rpokJXZ1BusfKMW3WIASxf88ag8P9vw7IzkRBTDwjFlU
         SKVg0cB0j6F0k9nqF3N7x44DvyN4+q0p2aNSNKSTtY4Qxq5GYl60p3vGEuPEQ+t0CsDk
         zakVoRFdoPTzvAuaIoTA0gJ7CzccXzKM1mCp6Ah9mFNYtkZILVuH9+xP1dde1k2jJ3nc
         gHH2IOWf9Lyu6Bg6hwimRDeuOr/hM1JQZxh/AYiomUFyIaKmWvh5yt5W4Tx7+WgxLKke
         pHpw==
X-Gm-Message-State: AOAM530rorkaSedujtEW1K9QcJAKmWYgZAd5RwrVu+PtKedvvTSWlqfB
        FkDOQtik0HUCMSB5d6rv/QsZ2PVL+qw=
X-Google-Smtp-Source: ABdhPJy2LB+r86u8y/oJu25Cyso7xtSHodIp+zzIsOhkMKDUU/1/xFpjqcfk5paD4fonygy3EYWFow==
X-Received: by 2002:a17:906:a213:b0:6b5:b0f9:7567 with SMTP id r19-20020a170906a21300b006b5b0f97567mr19902930ejy.129.1645538083441;
        Tue, 22 Feb 2022 05:54:43 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id l13sm4688424edr.61.2022.02.22.05.54.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:54:42 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 4/4] libsepol: add policy utilities
Date:   Tue, 22 Feb 2022 14:54:35 +0100
Message-Id: <20220222135435.31216-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135435.31216-1-cgzones@googlemail.com>
References: <20220204133507.26977-1-cgzones@googlemail.com>
 <20220222135435.31216-1-cgzones@googlemail.com>
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

sepol_validate_transition:
  (similar to validatetrans)
  Compute a validatetrans decision:

  $ sepol_validate_transition policy.bin system_u:object_r:user_tmp_t:s0 system_u:object_r:shadow_t:s0 file staff_u:staff_r:staff_t:s0
  allowed

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
    link dynamically after exporting all the necessary functions
---
 libsepol/.gitignore                        |   5 +
 libsepol/utils/sepol_check_access.c        | 130 +++++++++++++++++++++
 libsepol/utils/sepol_compute_av.c          |  66 +++++++++++
 libsepol/utils/sepol_compute_member.c      |  64 ++++++++++
 libsepol/utils/sepol_compute_relabel.c     |  64 ++++++++++
 libsepol/utils/sepol_validate_transition.c |  74 ++++++++++++
 6 files changed, 403 insertions(+)
 create mode 100644 libsepol/utils/sepol_check_access.c
 create mode 100644 libsepol/utils/sepol_compute_av.c
 create mode 100644 libsepol/utils/sepol_compute_member.c
 create mode 100644 libsepol/utils/sepol_compute_relabel.c
 create mode 100644 libsepol/utils/sepol_validate_transition.c

diff --git a/libsepol/.gitignore b/libsepol/.gitignore
index 77bb5911..abfb603b 100644
--- a/libsepol/.gitignore
+++ b/libsepol/.gitignore
@@ -1,2 +1,7 @@
 utils/chkcon
+utils/sepol_check_access
+utils/sepol_compute_av
+utils/sepol_compute_member
+utils/sepol_compute_relabel
+utils/sepol_validate_transition
 libsepol.map
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
diff --git a/libsepol/utils/sepol_validate_transition.c b/libsepol/utils/sepol_validate_transition.c
new file mode 100644
index 00000000..8243c37d
--- /dev/null
+++ b/libsepol/utils/sepol_validate_transition.c
@@ -0,0 +1,74 @@
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
+	sepol_security_id_t oldsid, newsid, tasksid;
+	sepol_security_class_t tclass;
+	char *reason = NULL;
+	int ret;
+	
+	if (argc != 6) {
+		printf("usage:  %s policy oldcontext newcontext tclass taskcontext\n", argv[0]);
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
+	if (sepol_context_to_sid(argv[2], strlen(argv[2]), &oldsid) < 0) {
+		fprintf(stderr, "Invalid old context %s\n", argv[2]);
+		return 1;
+	}
+
+	if (sepol_context_to_sid(argv[3], strlen(argv[3]), &newsid) < 0) {
+		fprintf(stderr, "Invalid new context %s\n", argv[3]);
+		return 1;
+	}
+
+	if (sepol_string_to_security_class(argv[4], &tclass) < 0) {
+		fprintf(stderr, "Invalid security class %s\n", argv[4]);
+		return 1;
+	}
+
+	if (sepol_context_to_sid(argv[5], strlen(argv[5]), &tasksid) < 0) {
+		fprintf(stderr, "Invalid task context %s\n", argv[5]);
+		return 1;
+	}
+
+	ret = sepol_validate_transition_reason_buffer(oldsid, newsid, tasksid, tclass, &reason, SHOW_GRANTED);
+	switch (ret) {
+	case 0:
+		printf("allowed\n");
+		ret = 0;
+		break;
+	case -EPERM:
+		printf("denied\n");
+		printf("%s\n", reason ? reason : "unknown - possible BUG()");
+		ret = 7;
+		break;
+	default:
+		printf("sepol_validate_transition_reason_buffer returned %d errno: %s\n", ret, strerror(errno));
+		ret = 1;
+	}
+
+	free(reason);
+
+	return ret;
+}
-- 
2.35.1

