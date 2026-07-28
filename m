Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643B41A513
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230232; cv=none; b=mxxmMdwZNuUJ7D9i+8TzDrO6CWRnoEcdFaqCBKlz0g8OqEMLjrh7vPcLQT14mj6l51GP+K+koA+H4v4QuURfmm9WjsRrMI5h1nQOadHpoWlvSzrLV6Qjy07zS9v29dhuko0DcNJ6YeNeKGNzTS0HHpFM3q2WS+gSqLNiDgxkC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230232; c=relaxed/simple;
	bh=ZA32K3XXIQxauPfrSRjXXKrpbOoZdia6XMaYUvmAIGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuydfNO4X7pITHfAxVkMrW6QcElGXRjH62TC07Adsfs+weF8Rk5TDREtXdHBok6LZwoIRvRbYfECNNwuIL6QrKeFhAnonpItJPmelIqC6HXJd8hxlEth6ZDF6AozouxJ9Hpy++9mq6kqckKiwekIjabo70lSuXCjvy6OEx6aGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MAR6JK7w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PTSir/aL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KGJxSHce; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SnZ4eeom; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MAR6JK7w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PTSir/aL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KGJxSHce";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SnZ4eeom"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43A263DFE;
	Tue, 28 Jul 2026 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785230225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsosvRv6bfza9NITahbL/WJ97CzC8iAtYWLfaR3M7sM=;
	b=MAR6JK7wWRwuWqpn4jbpJAi5J9LHs7Iu/NLZeWlLo7j7PHdChn68oJmVVX7h3EFPwrQ8kS
	agj3Boh3bxFwOgGqhm/kgU4qDZ8z3tSkmumxRJCF3CMYAYJQBsc3k9l7JcFyFXcOSN5zIa
	VAWya8IFpeaFnMq79gGlUG20vVqVVrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785230225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsosvRv6bfza9NITahbL/WJ97CzC8iAtYWLfaR3M7sM=;
	b=PTSir/aLo9esosHwxmUA8U682MJPQq+SNWdJGLgOgTgJjE25RY6DMaro/wqFc52/KURPQQ
	l3aPbtPDfTAyqrAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785230221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsosvRv6bfza9NITahbL/WJ97CzC8iAtYWLfaR3M7sM=;
	b=KGJxSHcegFDTr2fI6eNjtraEBO/lDdGmzdsmrPfEp2aMCbyiH+Krzsr1iYhPWLZsO+eA7i
	W6mgbMHA1CP+D2RxqzjjqZp6d5Y1VwGU0DDn/Bq/d4RmXMwugrIsNW2Mz6IDGfAe0ShX89
	LmJ86Tt7Uy5B+qGOefo3pPJg1VYkL0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785230221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsosvRv6bfza9NITahbL/WJ97CzC8iAtYWLfaR3M7sM=;
	b=SnZ4eeom9X39rndN5Pz9CsJWLUSTc7r1B2pNBJb+8wzIJMmxOyzcT+pccE7cORmv61gYBd
	eEVyyyuNfY3KeiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 230C9779B3;
	Tue, 28 Jul 2026 09:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XU06B41zaGqqYgAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Tue, 28 Jul 2026 09:17:01 +0000
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Cc: Johannes Segitz <jsegitz@suse.de>,
	Stefan Schubert <schubi@suse.de>
Subject: [PATCH] policycoreutils: Using vendor defined directories for configuration files
Date: Tue, 28 Jul 2026 11:16:32 +0200
Message-ID: <20260728091632.1673214-1-jsegitz@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Besides user/admin defined configuration files. Useful for systems
that have config files in /usr/etc

Signed-off-by: Stefan Schubert <schubi@suse.de>
---
 policycoreutils/sestatus/Makefile        |  8 +++
 policycoreutils/sestatus/sestatus.c      | 78 +++++++++++++++++++++++-
 policycoreutils/sestatus/sestatus.conf.5 |  2 +-
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 70f46956..6f8db774 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -5,6 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 ETCDIR ?= /etc
+LIBECONFH ?= $(shell test -f /usr/include/libeconf.h && echo y)
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I../../libselinux/include -D_FILE_OFFSET_BITS=64
@@ -14,6 +15,13 @@ override LDLIBS += $(LIBSELINUX_LDLIBS)
 all: sestatus
 
 sestatus: sestatus.o
+ifdef VENDORDIR
+ifneq ($(LIBECONFH), y)
+	(echo "VENDORDIR defined but libeconf not available."; exit 1)
+endif
+override CFLAGS += -DVENDORDIR='"${VENDORDIR}"'
+override LDLIBS += -leconf
+endif
 
 install: all
 	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index a719f0b3..528a81ae 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -21,11 +21,16 @@
 
 #define PROC_BASE "/proc"
 #define MAX_CHECK 50
-#define CONF "/etc/sestatus.conf"
+#define CONFDIR "/etc"
+#define CONFNAME "sestatus"
+#define CONFPOST "conf"
+#define CONF CONFDIR "/" CONFNAME "." CONFPOST
 
 /* conf file sections */
-#define PROCS "[process]"
-#define FILES "[files]"
+#define SECTIONPROCS "process"
+#define SECTIONFILES "files"
+#define PROCS "[" SECTIONPROCS "]"
+#define FILES "[" SECTIONFILES "]"
 
 /* buffer size for cmp_cmdline */
 #define BUFSIZE 255
@@ -91,8 +96,75 @@ static int pidof(const char *command)
 	return ret;
 }
 
+#ifdef VENDORDIR
+#include <libeconf.h>
+
+static void load_checks_with_vendor_settings(char *pc[], int *npc, char *fc[], int *nfc)
+{
+	econf_file *key_file = NULL;
+	econf_err error;
+	char **keys;
+	size_t key_number;
+
+	error = econf_readDirs (&key_file,
+				VENDORDIR,
+				CONFDIR,
+				CONFNAME,
+				CONFPOST,
+				"", "#");
+	if (error != ECONF_SUCCESS) {
+		printf("\nCannot read settings %s.%s: %s\n",
+		       CONFNAME,
+		       CONFPOST,
+		       econf_errString( error ));
+		return;
+	}
+
+	error = econf_getKeys(key_file, SECTIONPROCS, &key_number, &keys);
+	if (error != ECONF_SUCCESS) {
+		printf("\nCannot read group %s: %s\n",
+		       SECTIONPROCS,
+		       econf_errString( error ));
+	} else {
+		for (size_t i = 0; i < key_number; i++) {
+			if (*npc >= MAX_CHECK)
+				break;
+			pc[*npc] = strdup(keys[i]);
+			if (!pc[*npc])
+				break;
+			(*npc)++;
+		}
+		econf_free (keys);
+	}
+
+	error = econf_getKeys(key_file, SECTIONFILES, &key_number, &keys);
+	if (error != ECONF_SUCCESS) {
+		printf("\nCannot read group %s: %s\n",
+		       SECTIONFILES,
+		       econf_errString( error ));
+	} else {
+		for (size_t i = 0; i < key_number; i++) {
+			if (*nfc >= MAX_CHECK)
+				break;
+			fc[*nfc] = strdup(keys[i]);
+			if (!fc[*nfc])
+				break;
+			(*nfc)++;
+		}
+		econf_free (keys);
+	}
+
+	econf_free (key_file);
+	return;
+}
+#endif
+
 static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 {
+#ifdef VENDORDIR
+	load_checks_with_vendor_settings(pc, npc, fc, nfc);
+	return;
+#endif
 	FILE *fp = fopen(CONF, "r");
 	char buf[255], *bufp;
 	int buf_len, section = -1;
diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils/sestatus/sestatus.conf.5
index acfedf6f..01f8051d 100644
--- a/policycoreutils/sestatus/sestatus.conf.5
+++ b/policycoreutils/sestatus/sestatus.conf.5
@@ -8,7 +8,7 @@ The \fIsestatus.conf\fR file is used by the \fBsestatus\fR(8) command with the \
 .sp
 The fully qualified path name of the configuration file is:
 .RS
-\fI/etc/sestatus.conf\fR
+\fI/etc/sestatus.conf\fR or \fI<vendordir>/sestatus.conf\fR if it is not available
 .RE
 .RE
 .sp
-- 
2.55.0

