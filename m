Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388551;
	b=IIqsLRHCbfPMM0c4MikoBJ1/qD06f1ERNWsYtW5HUVE8YcsLheXaD99qY1982x0YDUJg
	 QYJm2vLbJelyVvsZEO0INH5eyQ1gNVsyJViKDwS7Z3gLC7DRvuXe/gYzNZAiyb+z9os5D
	 Z9nRwUP1GZ2yoPg6GfFYL+PuAbOss/y0rl7IPK6HokfdOttyQposGn439bixuFTifB7Hz
	 KaZTUvZTpPWVcaPKAgHcbpnzCp5zli2jhDZIkQ+xfbincVPs+/ajVlPfQ7iSYe5BJu8X2
	 T5b++S/GJc70/KTUXbTD9qZA6M1LzK5Nj+lYD1+H0XkjRYeaMWcMNJRy0FTOP2uKfGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g6LIer2qnO6VAQrR4H13Y2Veot9ToJLbEmiI/sMxx/8=;
	b=dVt8Z6fglQCIgTZXJNCxWekaFIOTYcR6kyfx2k0+PV4H7X5WAGLmN9Sv1ObSy/OQyiUO
	 LyUkbNokhUQ4NA04S0qFT09mqqy0yvh9RU3i64W/XqQLjOhxjlxE8bUMaB/RtnAWy9wA8
	 fsWQdEQ7jKW3rvIpQInANpIvvaGWcJ1aWLmj0otwisYc2y0SNwlnf+MS4t1ELXeu6vOXf
	 9MII3EuhP/vUOVoHP18gvn8HkZY4jwQDeNud1XL0YyMPVWy3k/c2oG+wq3Z0Fwh7njIJD
	 mmK/SGXnyp8oqK4SWOIuTW1KKmfr6HQ2VRiC5E7ey+7h7PiZ373igqAeByXBfR+1n2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOPpdXYo;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA92606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA92606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOPpdXYo
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-537548b811aso8426931cf.3
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388550; x=1793993350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6LIer2qnO6VAQrR4H13Y2Veot9ToJLbEmiI/sMxx/8=;
        b=bOPpdXYoXKo9lsxgXf7Swi8Jr57eS7fEKBDWIgJn9qL798VLpwCpAUMTYFEHMqq/Bq
         FVWfpZpcc/X44odHIJkso7EwCC06ed4xYdOU9gaXFwbJNOmvwmuVgUCKSQQEsrXGj2O8
         PZ8NiwUxd55a/t+96HsUGmRUNmJmNVozAAeHMkI5s+pXXOJ2k3dF6Tt/o7XBsQZzqf/F
         5rZQBcCjiGC0jwqRibKn/NmXP/TVhtjC8b1bJwQVxU3faG5vnW/GOCuvDbiTHivWylMK
         kq/UDf4wgrSnDw09WwOBGlVfGXNoi7B6CUJw1FS8eeGP/oW29fg7oOtoBW4RQgnXnZP2
         D/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388550; x=1793993350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6LIer2qnO6VAQrR4H13Y2Veot9ToJLbEmiI/sMxx/8=;
        b=p2K4NWMrKtbLbtHMoBxyUgJ5vVPezH05M1Dq/7FomFPL2iI2NfZCGe6oLlv6lIHz0I
         yGVXK5WeT6tuSWegZLMYc/dFlmfxGCdqOTrhSASfNMOZE5TRoVXrPvgSMTi+yN+HiAVx
         /6L+WOt7Aq8oMZ9gWKNJO3bdYnonO4vMv6CKO7W9n9gB6wFl4I1Zp8uakGmS5f6qxnc4
         +c9KRhURZbkCrIXkWCvUKMCym4tPtJy3MtvfhZ0fpIzETzIQ/hcZMuzgN0iO8Kf7Aq+7
         CihPufX+623yaEJ8UptLLVcgyIgEb6XYcFsB1kiiEnWs0V9df3iUTiwgZpnTKtAAH0d4
         zDCw==
X-Gm-Message-State: AFq9FYKL6LoaDNzUyUwSYpgG6p5R97QDbuybUyA0nkrsWVTVyB//pVrj
	oE15+YfG36gGWvxCwfVbcG2u17iE1I7nXfgmQ4VQoXns30Tyk3R1UhzVQgP8PGpY
X-Gm-Gg: AYBFou0Md12isvOUaZN0lHbIIkM+j4kUuktE9xtNHiw72Rd5ZqZ4pflv4lnxA76xYt3
	02xdARbqumbDXxJTTAYbNCwOQQjMDnpUiOn8tb0PoWD/2G6DCH+PbmbVhO6DVQVEQ2/CH2O5zHf
	xnVXjBjUSuGztgRU1Uza7vD6Yg1YcLSQeq7CPe154kC1D6mBkBt7NN0Avu9VLbCp+4tB3PmlRtY
	LhdNJvCm7NZHs/UF99CHE00aAiKxWPhNszZZRNMdlrc1VuPelZtFz6S+4neumiQnIaOe25Qxbn6
	uaRJzBa7Rd0DDMwlDoZYaoReDZ9GoJe52L5vpMgBlPFk0o2BjP9oolQx0X8I9UGD35fqvm6bQNg
	0OvjcsiQsJHjFvQe84xLTqDgS9iGzsEYL+BQm3FxE+oOr1HK5qbTskCIxkdIj1VbWm/bpOVWctr
	VyNMEurBnZYrnaFtcyoa+AB+KQrHuKL9Cf+bT2N0pkAjMjR3pvdCJTFjwYk+DsY2Zzn8EV3H4v4
	BwIFZSsN59XyofgPCWlTfxneNaDZOs/viUCKT5Eq9PyZLEZ313IsOBgYasfVh6bpgUhe9FJKGDn
	BjQpLs499mejflLDrDKrWAvBJnuIw9SWAArdp8tUdqLqbgJHOrOTRO6BxEn9Uo0auv/Sjgr+xFS
	NPBG7B661mA+7Q7BHLELNvsq6phJ7sGDHsz/4342x1weMd5DpZ4BGEyRSYN1AQb33DbwHzbODTG
	k6riGyzp5kRqnOJB92rDBWHeCEyPuil308KbvhqqmH2VxGjNCIKu8=
X-Received: by 2002:a05:622a:1247:b0:535:a5fa:ee02 with SMTP id d75a77b69052e-542b7dfcaa1mr52755301cf.66.1793388549956;
        Fri, 30 Oct 2026 12:29:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:09 -0700 (PDT)
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
Subject: [PATCH 11/11] libsemanage: reject missing scalar configuration arguments
Date: Fri, 30 Oct 2026 15:28:48 -0400
Message-ID: <20261030192849.151830-11-stephen.smalley.work@gmail.com>
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

The configuration scanner returns a NULL ARG for empty and quoted-empty
values, as well as on token allocation failure. Scalar actions pass this
pointer to strcasecmp, strtol or strdup. In particular, the recently added
sort-local-fcontexts option crashes instead of rejecting an empty value.

Add a shared scalar argument production that rejects NULL before entering
these actions. Preserve empty external-program arguments, which have a
different contract. This also covers older scalar options with the same
problem.

Add 114 regression checks for scalar rejection, valid values, parser reuse,
empty external arguments and token allocation failure.

Fixes: ee7e4e1e4e97 ("libsemanage: optionally sort file_contexts.local by specificity")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/conf-parse.y                  |  54 ++++----
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   8 +-
 .../tests/regression/test_config_empty.c      | 124 ++++++++++++++++++
 4 files changed, 163 insertions(+), 24 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_config_empty.c

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 1611f4a6..61b07310 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -69,6 +69,7 @@ static int parse_errors;
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
+%type <s> scalar_arg
 %type <d> verify_start_tok
 
 %%
@@ -106,7 +107,16 @@ single_opt:     module_store
         |       sort_local_fcontexts
         ;
 
-module_store:   MODULE_STORE '=' ARG {
+scalar_arg: ARG {
+                        if ($1 == NULL) {
+                                yyerror("missing option value or out of memory");
+                                YYABORT;
+                        }
+                        $$ = $1;
+                }
+        ;
+
+module_store:   MODULE_STORE '=' scalar_arg {
                         if (parse_module_store($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -116,7 +126,7 @@ module_store:   MODULE_STORE '=' ARG {
 
         ;
 
-store_root:     STORE_ROOT '=' ARG  {
+store_root:     STORE_ROOT '=' scalar_arg  {
                         if (parse_store_root_path($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -125,7 +135,7 @@ store_root:     STORE_ROOT '=' ARG  {
                 }
         ;
 
-ro_store_root:  RO_STORE_ROOT '=' ARG  {
+ro_store_root:  RO_STORE_ROOT '=' scalar_arg  {
                         if (parse_ro_store_root_paths($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -134,7 +144,7 @@ ro_store_root:  RO_STORE_ROOT '=' ARG  {
                 }
         ;
 
-compiler_dir:       COMPILER_DIR '=' ARG  {
+compiler_dir:       COMPILER_DIR '=' scalar_arg  {
                         if (parse_compiler_path($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -143,7 +153,7 @@ compiler_dir:       COMPILER_DIR '=' ARG  {
                 }
         ;
 
-ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
+ignore_module_cache:	IGNORE_MODULE_CACHE '=' scalar_arg  {
 							if (strcasecmp($3, "true") == 0)
 								current_conf->ignore_module_cache = true;
 							else if (strcasecmp($3, "false") == 0)
@@ -155,7 +165,7 @@ ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
 						}
         ;
 
-version:        VERSION '=' ARG  {
+version:        VERSION '=' scalar_arg  {
                         char *endptr;
                         long value;
                         errno = 0;
@@ -168,7 +178,7 @@ version:        VERSION '=' ARG  {
                 }
         ;
 
-target_platform: TARGET_PLATFORM '=' ARG  {
+target_platform: TARGET_PLATFORM '=' scalar_arg  {
                         if (strcasecmp($3, "selinux") == 0)
                                 current_conf->target_platform = SEPOL_TARGET_SELINUX;
                         else if (strcasecmp($3, "xen") == 0)
@@ -180,7 +190,7 @@ target_platform: TARGET_PLATFORM '=' ARG  {
                 }
         ;
 
-expand_check:   EXPAND_CHECK '=' ARG  {
+expand_check:   EXPAND_CHECK '=' scalar_arg  {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->expand_check = true;
 			else if (strcmp($3, "1") == 0)
@@ -196,7 +206,7 @@ expand_check:   EXPAND_CHECK '=' ARG  {
                 }
         ;
 
-file_mode:   FILE_MODE '=' ARG  {
+file_mode:   FILE_MODE '=' scalar_arg  {
                         char *endptr;
                         long value;
                         errno = 0;
@@ -209,7 +219,7 @@ file_mode:   FILE_MODE '=' ARG  {
                 }
         ;
 
-save_previous:    SAVE_PREVIOUS '=' ARG {
+save_previous:    SAVE_PREVIOUS '=' scalar_arg {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->save_previous = true;
 			else if (strcasecmp($3, "false") == 0)
@@ -222,7 +232,7 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
         ;
 
 
-save_linked:    SAVE_LINKED '=' ARG {
+save_linked:    SAVE_LINKED '=' scalar_arg {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->save_linked = true;
 			else if (strcasecmp($3, "false") == 0)
@@ -234,7 +244,7 @@ save_linked:    SAVE_LINKED '=' ARG {
                 }
         ;
 
-disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
+disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->disable_genhomedircon = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -245,7 +255,7 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
 	free($3);
  }
 
-usepasswd: USEPASSWD '=' ARG {
+usepasswd: USEPASSWD '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->usepasswd = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -256,12 +266,12 @@ usepasswd: USEPASSWD '=' ARG {
 	free($3);
  }
 
-ignoredirs: IGNOREDIRS '=' ARG {
+ignoredirs: IGNOREDIRS '=' scalar_arg {
 	current_conf->ignoredirs = strdup($3);
 	free($3);
  }
 
-handle_unknown: HANDLE_UNKNOWN '=' ARG {
+handle_unknown: HANDLE_UNKNOWN '=' scalar_arg {
 	if (strcasecmp($3, "deny") == 0) {
 		current_conf->handle_unknown = SEPOL_DENY_UNKNOWN;
 	} else if (strcasecmp($3, "reject") == 0) {
@@ -274,7 +284,7 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
 	free($3);
  }
 
-bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
+bzip_blocksize:  BZIP_BLOCKSIZE '=' scalar_arg {
 	char *endptr;
 	long value;
 	errno = 0;
@@ -286,7 +296,7 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
 	free($3);
 }
 
-bzip_small:  BZIP_SMALL '=' ARG {
+bzip_small:  BZIP_SMALL '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->bzip_small = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -297,7 +307,7 @@ bzip_small:  BZIP_SMALL '=' ARG {
 	free($3);
 }
 
-remove_hll:  REMOVE_HLL'=' ARG {
+remove_hll:  REMOVE_HLL'=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->remove_hll = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -308,7 +318,7 @@ remove_hll:  REMOVE_HLL'=' ARG {
 	free($3);
 }
 
-relabel_store:  RELABEL_STORE'=' ARG {
+relabel_store:  RELABEL_STORE'=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->relabel_store = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -319,7 +329,7 @@ relabel_store:  RELABEL_STORE'=' ARG {
 	free($3);
 }
 
-optimize_policy:  OPTIMIZE_POLICY '=' ARG {
+optimize_policy:  OPTIMIZE_POLICY '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->optimize_policy = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -330,7 +340,7 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 	free($3);
 }
 
-multiple_decls:  MULTIPLE_DECLS '=' ARG {
+multiple_decls:  MULTIPLE_DECLS '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->multiple_decls = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -341,7 +351,7 @@ multiple_decls:  MULTIPLE_DECLS '=' ARG {
 	free($3);
 }
 
-sort_local_fcontexts: SORT_LOCAL_FCONTEXTS '=' ARG {
+sort_local_fcontexts: SORT_LOCAL_FCONTEXTS '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->sort_local_fcontexts = false;
 	} else if (strcasecmp($3, "true") == 0) {
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 484d0853..54991e1e 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -11,3 +11,4 @@ test-cache-serial-join
 test-cache-serial-active
 test-cache-serial-policydb
 *.policy
+/test-config-empty
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 8800fb73..2b000a7a 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -18,7 +18,10 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST) test-config-empty
+
+test-config-empty: regression/test_config_empty.c ../src/libsemanage.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=strdup $(LDLIBS)
 
 $(RESTART_TEST): regression/test_transaction_restart.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,--wrap=scandir -o $@ $^ $(LDLIBS)
@@ -59,10 +62,11 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST) test-config-empty
 
 test: all test-ibpkey-validation
 	./$(EXECUTABLE)
+	./test-config-empty
 	./$(USER_JOIN_TEST)
 	./$(LIFECYCLE_TEST)
 	./test-parse-read-error
diff --git a/libsemanage/tests/regression/test_config_empty.c b/libsemanage/tests/regression/test_config_empty.c
new file mode 100644
index 00000000..9936f37d
--- /dev/null
+++ b/libsemanage/tests/regression/test_config_empty.c
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sepol/policydb.h>
+#include "semanage_conf.h"
+
+static bool fail_token;
+static unsigned failures;
+
+char *__real_strdup(const char *s);
+char *__wrap_strdup(const char *s);
+
+char *__wrap_strdup(const char *s)
+{
+	if (fail_token && !strcmp(s, "true")) {
+		failures++;
+		errno = ENOMEM;
+		return NULL;
+	}
+	return __real_strdup(s);
+}
+
+static semanage_conf_t *parse(const char *text)
+{
+	char path[] = "/tmp/semanage-config-XXXXXX";
+	int fd = mkstemp(path);
+	assert(fd >= 0);
+	FILE *fp = fdopen(fd, "w");
+	assert(fp);
+	assert(fputs(text, fp) >= 0);
+	assert(fclose(fp) == 0);
+	semanage_conf_t *conf = semanage_conf_parse(path);
+	assert(unlink(path) == 0);
+	return conf;
+}
+
+int main(void)
+{
+	const char *keys[] = { "module-store",	      "store-root",
+			       "ro-store-root",	      "compiler-directory",
+			       "ignore-module-cache", "policy-version",
+			       "target-platform",     "expand-check",
+			       "file-mode",	      "save-previous",
+			       "save-linked",	      "disable-genhomedircon",
+			       "usepasswd",	      "ignoredirs",
+			       "handle-unknown",      "bzip-blocksize",
+			       "bzip-small",	      "remove-hll",
+			       "relabel_store",	      "optimize-policy",
+			       "multiple-decls",      "sort-local-fcontexts" };
+	const char *values[] = { "", "\"\"" };
+	char version[32];
+	snprintf(version, sizeof(version), "%d", sepol_policy_kern_vers_max());
+	const char *valid[] = { "direct",
+				"/var/lib/selinux",
+				"/usr/lib/selinux",
+				"/usr/libexec/selinux/hll",
+				"true",
+				version,
+				"selinux",
+				"true",
+				"0644",
+				"true",
+				"true",
+				"true",
+				"true",
+				"/home",
+				"deny",
+				"9",
+				"true",
+				"true",
+				"true",
+				"true",
+				"true",
+				"true" };
+	assert(sizeof(valid) / sizeof(valid[0]) ==
+	       sizeof(keys) / sizeof(keys[0]));
+	unsigned cases = 0;
+	for (size_t i = 0; i < sizeof(keys) / sizeof(keys[0]); i++) {
+		for (size_t j = 0; j < sizeof(values) / sizeof(values[0]);
+		     j++) {
+			char text[256];
+			snprintf(text, sizeof(text), "%s = %s\n", keys[i],
+				 values[j]);
+			assert(parse(text) == NULL);
+			semanage_conf_t *conf =
+				parse("sort-local-fcontexts = true\n");
+			assert(conf && conf->sort_local_fcontexts);
+			semanage_conf_destroy(conf);
+			cases += 2;
+		}
+		char text[256];
+		snprintf(text, sizeof(text), "%s = %s\n", keys[i], valid[i]);
+		semanage_conf_t *conf = parse(text);
+		assert(conf);
+		semanage_conf_destroy(conf);
+		cases++;
+	}
+	for (size_t j = 0; j < sizeof(values) / sizeof(values[0]); j++) {
+		char text[256];
+		snprintf(text, sizeof(text),
+			 "[load_policy]\npath = /bin/true\nargs = %s\n[end]\n",
+			 values[j]);
+		semanage_conf_t *conf = parse(text);
+		assert(conf && conf->load_policy &&
+		       conf->load_policy->args == NULL);
+		semanage_conf_destroy(conf);
+		cases++;
+	}
+	fail_token = true;
+	assert(parse("sort-local-fcontexts = true\n") == NULL);
+	assert(failures == 1);
+	fail_token = false;
+	semanage_conf_t *conf = parse("sort-local-fcontexts = false\n");
+	assert(conf && !conf->sort_local_fcontexts);
+	semanage_conf_destroy(conf);
+	printf("Configuration scalar arguments: %u cases passed.\n", cases + 2);
+	return 0;
+}
-- 
2.56.0

