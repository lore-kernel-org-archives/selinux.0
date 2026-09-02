Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABC4A8417
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362129; cv=none; b=BH5PXGQfubJ+zNqKoAqpCtm5fvmKeEQ5d4PWiMAu7VXJ0muN9x9RKJCe11sP3MdngQA0PTJla8AHfaQtbD6kAffQjvzwIhhcvGiltXMrr2uPB2JICIISc9p56H61qJ9GYOOuBcmLM/1M9iD3AUOz+LPOvew7w9mDS5HBjyRkZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362129; c=relaxed/simple;
	bh=VBluen8PTH9OI3TOhMnqdJPGM6k79/txMfe1pQgJLXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFvNbkrQozES0z55dJynNHDVuSCaFGCdEhRPFZgvuKVlQvRU/AbQ63OcTE9QBxvXlVzzioDWjQiWHz6DseLJnQ4vaREG7OSeAOl/CWqo884qT4lmor1E8ew/T3QQuYYHOj2Bi8+ERjxN0bClGHC4oWWxa11lA5sQTXagjtE2g4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR2q3WM2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR2q3WM2"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e85499ffbso112533685a.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362126; x=1788966926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xto/F87EUdIquy3X2DDuJ/tQwiZNjeUFhwI+goVREYk=;
        b=CR2q3WM268LamC893SUg5Tt3rScHUqDgLw5qpG76qoB3agJyEdqh1qg1uuZt4Lritb
         EokAl94GhC39zHsay+zZSqQ7Rk4hd3a3UJIyA54EC6fXLWQ0Kg/p6G+uXl2Oxc8gF8JF
         +1LQhkb/2SxM2FMb+UfdVQ6LQpL0oFo8YrA5y+GTPGcYX8RI084hg76EL0BUPscyvA22
         3ahsnHo97wS14plTx6Db+aU+7t3Mm9OwyVCSGqu8JcK/BBjGO3yAW0tF2xnAUYN6tpNG
         h7q7zc81KTQZMRGWEnUc/iNjxpWJ3m0wnqNA780K7uYdElevaWTbP0/EOSY3OHAjky3m
         l5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362126; x=1788966926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xto/F87EUdIquy3X2DDuJ/tQwiZNjeUFhwI+goVREYk=;
        b=j9Q+uywO0Gn48xL6NFdfIXmimWd6pR2TMbWhHzvliqNiLD5r+FJ18Lh9tLPnzr2fce
         HIMblue+qjYBfpPfwm/jK3OlwjpvxJOwVT7zIk9sf8CJlWH9wlFeEsttBvS5Tr7g7I4J
         27APshEDkEl18kLYeKB7k1TEqEvCrEu3x8PHqUY2cZ1bBNAUoS+2XIa0j+DXZNuCzPpT
         aIl5cpItLqGhGKGZ8Kbu3MrnD0EL3FXkqvCKtTvoSh+pFvm4fJaPfBlCwshEkzBRIzGx
         Wakl3/2m1n7LkEywvaaYpyoEYqVERfCXy0g4/9QauDHkJVkYXPAgomxYqxOEKhYJpZVU
         XUvQ==
X-Gm-Message-State: AFuF++kTxEeHPOj8eQoBbWR0EvEaHOmEnbsISDydpeiQ5TcPlKP17G0U
	0GwLLIYqhMK2ICDFzrCsS7mxWrIWF+hDCkr2A12RSKoGDEltWdiNYdMLaf7SBw==
X-Gm-Gg: AR+sD11lt2UQ+eFpDbR5P9VVjSjX3JqfHvu3am196Aqn4NDP4iVuJ1h3v4+zkV7iKNC
	5owUlitrNtILlLY5G4Sk5Dk24WTMJnnKnx/RujDWjE9mKWiqJ98VmDi8M7zG2gLIWGUFyxsyPLQ
	xEEvFtn8R2SGG7MXbZutwxAKz98Cm2aa6OD1aXetANn7IYdgI/WUvRolJGjesnTvHeopM7+XHRq
	YPluLaVbOyjq1lb483wfbYRAXFCzTVS0xS7UY6oybj48KsF6sNZLYBhU9MOTzBfeNz7U/NJFaq0
	6CG+qJcJ7eBNem761mjrGuRfZ57NWMRtr245iH8C25pPxgBTMZvuT+Jp+ggNJlgJe8HEVUtaBID
	UpoJu9Ux3OoDUIJYzFifo9JEpR3iXDi2/RGK1VlGr9yu7Azc4jL5we4S7JjJaYjnWElFJK/qBsY
	Loz6yfOSnDfpzufpBo05gNyhv+j+OMBK5Jv9sURscjjayPDzkYwMKHpmqIOTaH7Q9bo5LBnuN06
	SU+5blTNaF7FSvj1fTJqfX6luP+hgmmFgWdK39HO34a2StwuqaA8aCv/JOl5V3C
X-Received: by 2002:a05:620a:2a0c:b0:916:10f6:780f with SMTP id af79cd13be357-93960f2b4cemr678605185a.27.1788362126600;
        Wed, 02 Sep 2026 08:15:26 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 7/9] libsemanage: refuse to remove or enable a module owned by a RO store
Date: Wed,  2 Sep 2026 11:14:04 -0400
Message-ID: <20260902151406.54168-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule -r <name> on a module that exists only in a read-only store
has nothing to unlink in the writable one. Detect that case in
semanage_direct_remove_key(), notify the user, and suggest using -d to
disable it instead. Removing a writable-store copy that shadows a
read-only one is still allowed and simply un-shadows the vendor
module.

semodule -e <name> when a read-only store carries the disabled marker
has no effect since get_module_info() reads the marker via
semanage_module_find_path(). After removing any writable marker,
re-probe; if a read-only marker remains, fail with an error message
pointing to its path as the cause.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 5646d451..3d203bd7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2276,6 +2276,23 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 			}
 		}
 
+		/*
+		 * A read-only store may still carry a disabled marker for
+		 * this module; the writable store cannot override it.
+		 */
+		if (semanage_ro_root_count() > 0 &&
+		    semanage_module_find_path(sh, modinfo,
+					      SEMANAGE_MODULE_PATH_DISABLED, fn,
+					      sizeof(fn)) == 0 &&
+		    access(fn, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s is disabled by the read-only store at %s and cannot be enabled here.",
+			    modkey->name, fn);
+			status = -1;
+			goto cleanup;
+		}
+
 		break;
 	case -1: /* warn about ignored setting to default */
 		WARN(sh, "Setting module %s to 'default' state has no effect",
@@ -3058,6 +3075,29 @@ static int semanage_direct_remove_key(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
+	/*
+	 * A module that lives only in a read-only store has nothing to
+	 * remove in the writable one; disabling is the closest equivalent.
+	 * Removing a writable-store copy that shadows a read-only one is
+	 * still allowed and simply un-shadows the vendor module.
+	 */
+	if (semanage_ro_root_count() > 0 && access(path, F_OK) != 0) {
+		char ro_path[PATH_MAX];
+
+		if (semanage_module_find_path(
+			    sh, (const semanage_module_info_t *)modkey,
+			    SEMANAGE_MODULE_PATH_NAME, ro_path,
+			    sizeof(ro_path)) == 0 &&
+		    access(ro_path, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s at priority %d is provided by the read-only store at %s and cannot be removed; use -d to disable it.",
+			    modkey->name, modkey->priority, ro_path);
+			status = -2;
+			goto cleanup;
+		}
+	}
+
 	/* remove directory */
 	ret = semanage_remove_directory(path);
 	if (ret != 0) {
-- 
2.55.0

