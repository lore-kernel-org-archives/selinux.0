Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342508;
	b=t/Wi3S8fuJwbQHnRSQRbDWhZb5yMQUzsIDq5KDF10+ZRGSJor94JR66AtpBhid5eplS3
	 qzz/dF6D7I4O/U3xySNMrE/ukNbW5Uqb3JWEvTQ6bJ2M1BBERGO7h4h6RamToKTzRJFrS
	 VAm9oVyufeoRfmBvsgePnlxtXJRRYZ4Y+SbdUVSJQS97HtQOO7hTo7Uh8thppK1XZNQ7A
	 ho+tJQu4U0q8B06LrhzfmNzJ/pT5UQaX+w6Q7tlF6myy8QAvtpteF7PvUVkeWvW7LcPCU
	 FPVIfYOT4SF7kb5Ul5o4yKoVJMLgZi78ZO6k5vDRtHOt/LozVARbpRmJNpL9qWTtjxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342508;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=VC/yA8LuQFAXhdzNtcFAIsxI36LebW6JYbNmaan7FZU=;
	b=d/HiaiDDx7AHO2LgUMNJezHu+fQm0Qcv1TW+u2usr7YxThh/MCDOASKCDvAAxHii2Bzw
	 sNOeIHCJ8xb2LYyd7JGLIOqxtr5eb5pk50+fD1GALLuxwgul0lk5sP6RvXSanVvLGdrnf
	 0W269nwyaSJ6aKRt2m8ZdOI9R09YfMZwZ/gWqaTysM+3yThTEfxuZntuIeyWlg5KuYqy0
	 LNYknaaveHSpyOeDrvHi6FATRTzezo82v4KC89aJ8ipFVy64AeD9oNHdAc6gBYXMaLfRg
	 +t7PqFHJ+8bLUwCFNeRlWjkahgPubFmE9GxSuLJHnyrj3S2b9f8FgZqTv8X7doqyX9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=A+Ugosja;
	arc=none smtp.remote-ip=185.125.25.8
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D7606BA50
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 20:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 572D7606BA50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=A+Ugosja
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJBX2l52zH03;
	Tue, 10 Nov 2026 21:28:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342500;
	bh=VC/yA8LuQFAXhdzNtcFAIsxI36LebW6JYbNmaan7FZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+Ugosja4GAF8/VgKl3H3LDZlGbWeNoudrRHsjeiE9gDTWy69vSexuBLIv8X8hiZ7
	 k8y9O4Sz26di+XVdJWTBgNM4j0XYTcxAnQGTOhR0xF4/eCGqUKMXfzHvsQg01t9Yw7
	 4evPLA+RC2a344MuyHazXj8/Wasra9MhUHYco9Ig=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJBW05gvzxdn;
	Tue, 10 Nov 2026 21:28:18 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 2/2] selftests/landlock: Test PR_SET_SECUREBITS mediation
Date: Tue, 10 Nov 2026 21:28:07 +0100
Message-ID: <20261110202811.2409395-3-mic@digikod.net>
In-Reply-To: <20261110202811.2409395-1-mic@digikod.net>
References: <20261110202811.2409395-1-mic@digikod.net>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The preceding commoncap fix routes the CAP_SETPCAP check for privileged
PR_SET_SECUREBITS requests through the ordinary capable hooks.  Add a
focused Landlock regression test for this path.

Keep CAP_SETPCAP effective to isolate Landlock mediation and run the
audit case in a child domain.  A privileged change returns EPERM and
emits an exact CAP_SETPCAP record, then an unprivileged-only change
succeeds.  After the child exits, require the domain deallocation record
to report exactly one denial; this proves that the second operation did
not create a hidden denial without relying on an asynchronous no-record
timeout.

The existing check-exec securebits fixture already covers commoncap's
privileged, unprivileged, locked, and user-namespace semantics.  Without
the preceding fix, this Landlock audit test fails.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/cap_test.c | 69 +++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index c79bb42c6282..741567c5ab41 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -1275,6 +1275,75 @@ TEST_F(cap_audit, denied)
 	EXPECT_EQ(0, records.domain);
 }
 
+/*
+ * A privileged denial allocates the domain ID.  The following unprivileged-only
+ * change must not create a hidden Landlock denial, so the domain's deallocation
+ * record must report exactly one denial.
+ */
+TEST_F(cap_audit, securebits)
+{
+	const unsigned long unpriv = SECBIT_EXEC_RESTRICT_FILE |
+				     SECBIT_EXEC_RESTRICT_FILE_LOCKED;
+	__u64 *domain_id, deallocated_dom = 0;
+	unsigned long bits;
+	int err, ruleset_fd, status;
+	pid_t child;
+
+	domain_id = mmap(NULL, sizeof(*domain_id), PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, domain_id);
+	*domain_id = 0;
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow the child to replace the audit filter before exiting. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+
+		set_cap(_metadata, CAP_SETPCAP);
+		bits = prctl(PR_GET_SECUREBITS);
+		EXPECT_EQ(-1, prctl(PR_SET_SECUREBITS,
+				    bits | SECBIT_NO_CAP_AMBIENT_RAISE));
+		EXPECT_EQ(EPERM, errno);
+
+		EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SETPCAP));
+		EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd,
+							  getpid(), domain_id));
+
+		EXPECT_EQ(0, prctl(PR_SET_SECUREBITS, bits | unpriv));
+		clear_cap(_metadata, CAP_SETPCAP);
+
+		/* Receive the asynchronous domain deallocation record. */
+		set_cap(_metadata, CAP_AUDIT_CONTROL);
+		EXPECT_EQ(0, audit_filter_drop(self->audit_fd, AUDIT_ADD_RULE));
+		EXPECT_EQ(0,
+			  audit_filter_exe(self->audit_fd, &self->audit_filter,
+					   AUDIT_DEL_RULE));
+		clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+
+	EXPECT_NE(0, *domain_id);
+	err = matches_log_domain_deallocated(self->audit_fd, 1, *domain_id,
+					     &deallocated_dom);
+	EXPECT_EQ(0, err);
+	EXPECT_EQ(*domain_id, deallocated_dom);
+	EXPECT_EQ(0, munmap(domain_id, sizeof(*domain_id)));
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 /*
  * Denials in the capset and mmap_addr paths are audited like capable hook
  * denials.  The vm_enough_memory hook only withholds the admin reserve, with
-- 
2.56.0

