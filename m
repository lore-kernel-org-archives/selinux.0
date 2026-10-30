Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388548;
	b=2dBmhnfGRENm7APCV4idiEUxaBdTTDdBc3kL0Lye/uV7f9ubTlQSkaaVqsBuNNWCPcNM
	 3hz3IeZGiKvE9TWVwMRlYL7eCa09DqiaRrn2XrrvcaPflI8dL9xEMMavNDNB6wSYDRhix
	 SPEsmuOvmDeReekiyOIykeDkYPrvYsuXWZitZdnm3uZPXQFadFXaIec0RAv1vlk5V9YHK
	 bQkw7hcGsEBIM+uhCjX3TmStUj5VA6jzqN8MKoBs6S10Whh9pGvRgBK3ZeOsUxNbHoBGw
	 Et/45AR4EpV1rhfawqztZnbkYzPD3eDhsTesAPal5jtzYNkmDDuhtBVwASNLTOkD9uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=16ELHOOFoIF+wy1g61rK4SXH6/asGPgwUP83txfg+Jc=;
	b=LkOcwQCXSNvcFLyye3wVIoUreirURqHqN9e7pTwpFC4GXzTnj+eI/AocyyE9k+32GwO7
	 c1r+fD1NOXxjR50Jr91c5Lv9BbLVkbZzDcAgaGMPZtSkPbVcgh2lZz+f8n8kobytJ5R8v
	 SY2CIn5RO8K+0ZxWxNTwMZ2LJyVFFNj68dH48KFZ1HVnkfcKyvmASeaDBmbxpaSdMndtl
	 wldmSgP43PwwNAC+6ir1E3zC2euD9eqn7JFDjBXXrvn4t4G+8N/rktFAaJQ8QRBAuQ+lI
	 rR3Wyw7qupHotvqGIdLOB5PuNmroFnxphAO8iLax6PK2nwF2z4gqsqNNrnJIBvpJ2kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rydlt7Cn;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFB606A31C
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54EFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rydlt7Cn
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53cd0c8614eso7657061cf.0
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388547; x=1793993347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16ELHOOFoIF+wy1g61rK4SXH6/asGPgwUP83txfg+Jc=;
        b=Rydlt7CnCT6PTMlFUumyMS4qc3WJzZltyBv9RqJvQZh5u4ngRP5pp/FmsvkAVAUhP8
         6+p1KOccKmP1rO1OchDF/+AyF1D24Y6Y8JD2q92t7Gpl7faCGf80SDlmlsi5arxMlKgP
         LtoMlgcVCi9QcaZs7HcPwEsQVs9ZyVmS0Pop+3WAkepiG2F7yrmyBUhUG+hKk4R01ork
         FI75q2Cnsu32EAZ8tfDu0UzQSl0dbUYym+Zlvcs9SWWoT6b07ibXHzSRifujNn/ZjclB
         RU/BFnkg6reIYTLKnNdUYL0xJGrwAd2vwULsdlprOAsF7F5RoJIy1LmvUOEhIsxA6cva
         Xc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388547; x=1793993347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=16ELHOOFoIF+wy1g61rK4SXH6/asGPgwUP83txfg+Jc=;
        b=pl0cywt8umiF1Nb6joyvCTJtP26c9XCvXq7LpJQwhjJPoVF2me81Yt5qIQC9D2E4qF
         0rhTdWCiPdN9ZBS0axixRHiAt1V21pGM+ViYlln6UP4XRha+g5jLdgdNj0gsIeyEHQ+O
         71PqKH3uVD8kWiJmAb+qmZE90uwWjYGKcgOu4uGcF8rR76y17SNtjT/vj/JSKx88XrC5
         cALgp201/9/O/cM8ctDt0mkPmepXOt0SVluR9St6ugZf8DtNjQt/tFVFWzI0pkjKxbKq
         huI6toKZOl/b56FlUi8WmzoY8SVOTgWaiioWlkm/KIGlMKu9WLcExO3wBuMn0EaheR8r
         Gu0g==
X-Gm-Message-State: AFq9FYKhiCGL76az75wIknff5kjSD8e0d/COZmQ8CzCYqE81QItW0BYG
	x3sOl0j2SxQFikZn+ScWmN1COMppcFrMqmK1UCW5EJpY0GmbNi40rmdh3fCbeUdv
X-Gm-Gg: AYBFou1qT2z9LGD/ZPnCYEu/AV0MGndRiEAc+cr0MJYYE0OELuxmpmI2StBFuWpGyVI
	T51sv09CdT4kaAExcMfWT01yRdvKALsBJqNWpUUWy2OHHsJkuHP1sbH3mFlfxya2B93KNT9Ln/W
	LECgVZuZs9s9V4p2n5uKJyNRbGJpIHwsoEYFUYxrqwWpyxH1CT6hsTo+ec8uIXpSzMbHN2ZHPIJ
	UuuE2nOOmJncn+wBzQ6oe6R2p4xNkrpq6xOr4ouYRc4XIOohIg1x/g8kNSPS70xU768BfHA5Cjh
	9PUt9LQiJkmgwgiKWFUBD4FmkgUCNLcbYYsO7833mtq/uzo1ds2HagGGCO/vYRL6rVRZbtphUR4
	n1le12m+5Gl3W/f1BDH+RcqxxbLB5QKqTPWUnrY9icz7+q0z1Cgkl5wDIuOsuGwr8cC7vOMdEQ8
	4eFRG+M+mZKEFOAS+6SUX1zegRYFS1lPzduk0d1N/fP0ggm0b9NCA1vDfqbcK5SHdXk/DLxn1W1
	45uLc00F1ydF19LiTzAKFFZNFzmA0DpZ5uRW1ovj+9aE4A7b7MR+muQmA5e0/99a1zX2VPFiRyU
	C7fnAh9xkCzyBZeEwtUDlqeEhL650amgilhBy37SX588q01CSqvsZrkqulIW5J3+Y+QBsIXK4Ub
	qKjKouF5EpCa2XjCbD4kH8kezE+sXbowGgbyUL6f1L1C5c6gNy6lvGILYrLx7fVX2vSP0I/8byn
	9k985BHqLDkXXHd7oGb0pj5hxGEiKPgTbCcQB7x3Vrt4Y8/qf6R4A=
X-Received: by 2002:a05:622a:4ce:b0:532:f0a2:ef4 with SMTP id d75a77b69052e-542b62a466dmr51951891cf.26.1793388547275;
        Fri, 30 Oct 2026 12:29:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 07/11] libsemanage/tests: exercise commits with complete isolated stores
Date: Fri, 30 Oct 2026 15:28:44 -0400
Message-ID: <20261030192849.151830-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
References: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the CIL fixture sources in the module store so commit tests rebuild
and persist changes instead of relying on the successful no-module early
exit and retained caches. Include the file contexts and types used by
successful mutations in the source fixtures.

Initialize process-global paths under an absolute test root, disable
unrelated homedir generation and relabeling, and allow a matching
setfiles binary to be selected with SEMANAGE_TEST_SETFILES. Document
diagnostics and verifier selection for testing against newer policy
versions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/tests/README                |  8 +++
 libsemanage/tests/test_fcontext.cil     |  4 ++
 libsemanage/tests/test_port.cil         |  2 +
 libsemanage/tests/test_semanage_store.c |  9 +++-
 libsemanage/tests/utilities.c           | 67 +++++++++++++++++++++++--
 5 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/libsemanage/tests/README b/libsemanage/tests/README
index 396591cb..6e8e9c44 100644
--- a/libsemanage/tests/README
+++ b/libsemanage/tests/README
@@ -1,5 +1,13 @@
 Notes on tests
 ============================
+Commit tests require the CIL fixture sources as well as their compiled
+policies. They install those sources into an isolated store so that commit
+and reconnect checks exercise persistent changes rather than cached records.
+
+When the system setfiles does not support the policy version of this tree,
+set SEMANAGE_TEST_SETFILES to the absolute path of a matching setfiles binary.
+SEMANAGE_TEST_VERBOSE=1 enables library diagnostics for troubleshooting.
+
 The semanage_access_check test in the semanage_store suite simulates a
 read-only filesystem by using DAC permissions. Consequently, these tests
 will fail if run as root, as root can override DAC permissions.
diff --git a/libsemanage/tests/test_fcontext.cil b/libsemanage/tests/test_fcontext.cil
index 1c62b893..4bf02dd5 100644
--- a/libsemanage/tests/test_fcontext.cil
+++ b/libsemanage/tests/test_fcontext.cil
@@ -19,7 +19,11 @@
 (type first_t)
 (type second_t)
 (type third_t)
+(type tmp_t)
 (sidcontext security (system_u object_r first_t ((s0) (s0))))
 (class test_class (test_perm))
 (classorder (test_class))
 (allow first_t self (test_class (test_perm)))
+(filecon "/etc/selinux(/.*)" socket (system_u object_r first_t ((s0) (s0))))
+(filecon "/etc/selinux/targeted" file (system_u object_r second_t ((s0) (s0))))
+(filecon "/etc/selinux(/.*)" block (system_u object_r third_t ((s0) (s0))))
diff --git a/libsemanage/tests/test_port.cil b/libsemanage/tests/test_port.cil
index 7e07a61c..56267b50 100644
--- a/libsemanage/tests/test_port.cil
+++ b/libsemanage/tests/test_port.cil
@@ -18,6 +18,8 @@
 (type first_port_t)
 (type second_port_t)
 (type third_port_t)
+(type user_home_t)
+(type user_tmp_t)
 (sidcontext security (system_u object_r first_port_t ((s0) (s0))))
 (class file (open))
 (classorder (file))
diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index 490e1eb0..6d1aab12 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -89,7 +89,14 @@ int semanage_store_test_init(void)
 	sh->conf->store_path = strdup("store");
 
 	/* initialize paths */
-	err = semanage_check_init(sh, rootpath);
+	char *root = realpath(rootpath, NULL);
+	if (!root)
+		return -1;
+	err = semanage_set_root(root);
+	free(root);
+	if (err != 0)
+		return -1;
+	err = semanage_check_init(sh, "");
 	if (err != 0)
 		return -1;
 
diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.c
index 48e8ee24..6b113ce1 100644
--- a/libsemanage/tests/utilities.c
+++ b/libsemanage/tests/utilities.c
@@ -23,6 +23,8 @@
  */
 
 #include "utilities.h"
+#include "handle.h"
+#include <limits.h>
 
 static int test_store_enabled = 0;
 
@@ -40,6 +42,7 @@ void test_msg_handler(__attribute__((unused)) void *varg,
 int create_test_store(void)
 {
 	FILE *fptr;
+	const char *setfiles = getenv("SEMANAGE_TEST_SETFILES");
 
 	if (mkdir("test-policy", 0700) < 0)
 		return -1;
@@ -64,6 +67,13 @@ int create_test_store(void)
 	if (!fptr)
 		return -1;
 
+	if (setfiles && fprintf(fptr,
+				"[setfiles]\npath = %s\n"
+				"args = -q -c $@ $<\n[end]\n",
+				setfiles) < 0) {
+		fclose(fptr);
+		return -1;
+	}
 	fclose(fptr);
 
 	enable_test_store();
@@ -103,6 +113,9 @@ static int write_test_policy(char *data, size_t data_len)
 int write_test_policy_from_file(const char *filename)
 {
 	char *buf = NULL;
+	char *source = NULL;
+	char *extension;
+	long source_len;
 	size_t len = 0;
 	FILE *fptr = fopen(filename, "rb");
 	int rc;
@@ -129,6 +142,47 @@ int write_test_policy_from_file(const char *filename)
 
 	rc = write_test_policy(buf, len);
 	free(buf);
+	if (rc < 0)
+		return rc;
+
+	/* Commits need module sources, not just a queryable binary policy. */
+	source = strdup(filename);
+	if (!source)
+		return -1;
+	extension = strrchr(source, '.');
+	if (!extension || strcmp(extension, ".policy")) {
+		free(source);
+		return -1;
+	}
+	strcpy(extension, ".cil");
+	fptr = fopen(source, "rb");
+	free(source);
+	if (!fptr)
+		return -1;
+	if (fseek(fptr, 0, SEEK_END) != 0) {
+		fclose(fptr);
+		return -1;
+	}
+	source_len = ftell(fptr);
+	if (source_len < 0 || (unsigned long)source_len > UINT_MAX ||
+	    fseek(fptr, 0, SEEK_SET) != 0) {
+		fclose(fptr);
+		return -1;
+	}
+	buf = malloc((size_t)source_len + 1);
+	if (!buf) {
+		fclose(fptr);
+		return -1;
+	}
+	if (fread(buf, 1, (size_t)source_len, fptr) != (size_t)source_len) {
+		free(buf);
+		fclose(fptr);
+		return -1;
+	}
+	fclose(fptr);
+	rc = write_test_policy_src((unsigned char *)buf,
+				   (unsigned int)source_len);
+	free(buf);
 	return rc;
 }
 
@@ -210,15 +264,22 @@ int destroy_test_store(void)
 
 void helper_handle_create(void)
 {
-	if (test_store_enabled)
-		semanage_set_root("test-policy");
+	if (test_store_enabled) {
+		char *root = realpath("test-policy", NULL);
+		CU_ASSERT_PTR_NOT_NULL_FATAL(root);
+		CU_ASSERT(semanage_set_root(root) == 0);
+		free(root);
+	}
 
 	sh = semanage_handle_create();
 	CU_ASSERT_PTR_NOT_NULL(sh);
 
-	semanage_msg_set_callback(sh, test_msg_handler, NULL);
+	if (!getenv("SEMANAGE_TEST_VERBOSE"))
+		semanage_msg_set_callback(sh, test_msg_handler, NULL);
 
 	if (test_store_enabled) {
+		sh->conf->disable_genhomedircon = 1;
+		sh->conf->relabel_store = 0;
 		semanage_set_create_store(sh, 1);
 		semanage_set_reload(sh, 0);
 		semanage_set_store_root(sh, "");
-- 
2.56.0

