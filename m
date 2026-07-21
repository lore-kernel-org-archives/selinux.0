Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7F432BD8
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619308; cv=none; b=C9SwWxkp5chMPKi+xB9twgmQQvQjQthzVcWIJNRBDVGhaN2dWBMi03mUGtVtjzc9mF+gMkDicjp5CaRgqnX2+Zv1mKFHwb/7VasBtsqpBXk8CCgGuzPPYmPQILI6KWfuovtW7DZ/icABxZRkf1J4Wg1XQbJvqtqTqjPM3ucEP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619308; c=relaxed/simple;
	bh=wVfi3Ri4qiLyI8fmCYiKF3l2tRWyZU4GxnYJUDDmbDE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oUDlUt20ySiRLvlQCVymYxYJlxHCzLd56kzUZdSqRldiZf2Bd2rJsdnf0wBrtw3/IP8XbCNpMj+yPtU2EKf+RX5IN9wXJAFGP4EjiosqZXooG04z7g8Yx+xbB8tPW7p7YmF6Soy8n+Iwf3GV/zFg7rbSFDNK16mgMFj6vRemAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wi0PBIVo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sjzaCTDw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wi0PBIVo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sjzaCTDw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wi0PBIVo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sjzaCTDw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wi0PBIVo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sjzaCTDw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FC5A3E21
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784619304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=cR0VPRaFS41XluI4/WII6P1BAMZR8RNyj+JPNeaxGxc=;
	b=wi0PBIVoeeUyeSUxjyq4EIhp6gkIRxrObSBNgpjWVQvGdTbB1caLBqkAsI2+V3d2G0pa59
	LT9jEIEYjTCpmJyXPkizZzRwg+EpGoudUiu+DXGXAuG7YKlFhf7/Y0Ml2pqwDJWsv4ISMi
	DztLs2u1SCfFig0noxOH5ct6XvOeeF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784619304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=cR0VPRaFS41XluI4/WII6P1BAMZR8RNyj+JPNeaxGxc=;
	b=sjzaCTDwEvjgvtDmZrZeplEc147VWFyvmk7SwRlLj/WhhvIuAlXYpbFRTjN/AkSnrhwzMc
	dg0d/AL2eXkhgHDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wi0PBIVo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sjzaCTDw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784619304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=cR0VPRaFS41XluI4/WII6P1BAMZR8RNyj+JPNeaxGxc=;
	b=wi0PBIVoeeUyeSUxjyq4EIhp6gkIRxrObSBNgpjWVQvGdTbB1caLBqkAsI2+V3d2G0pa59
	LT9jEIEYjTCpmJyXPkizZzRwg+EpGoudUiu+DXGXAuG7YKlFhf7/Y0Ml2pqwDJWsv4ISMi
	DztLs2u1SCfFig0noxOH5ct6XvOeeF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784619304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=cR0VPRaFS41XluI4/WII6P1BAMZR8RNyj+JPNeaxGxc=;
	b=sjzaCTDwEvjgvtDmZrZeplEc147VWFyvmk7SwRlLj/WhhvIuAlXYpbFRTjN/AkSnrhwzMc
	dg0d/AL2eXkhgHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39970779AB
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Go+5DCghX2qBJQAAD6G6ig
	(envelope-from <jsegitz@suse.de>)
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:35:04 +0000
Date: Tue, 21 Jul 2026 09:35:02 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Subject: [PATCH] policycoreutils: Using vendor defined directories for
 configuration files
Message-ID: <al8hJpiJe7Oj4Pph@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybbvV9b2pbpaiktH"
Content-Disposition: inline
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[selinux@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4FC5A3E21
X-Spam-Score: -6.61


--ybbvV9b2pbpaiktH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Besides user/admin defined configuration files. Useful for systems
that have config files in /usr/etc

Signed-off-by: Stefan Schubert <schubi@suse.de>
---
 policycoreutils/sestatus/Makefile        |  8 +++
 policycoreutils/sestatus/sestatus.c      | 78 +++++++++++++++++++++++-
 policycoreutils/sestatus/sestatus.conf.5 |  2 +-
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/M=
akefile
index 3dbb792b..935fd6dc 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -5,6 +5,7 @@ BINDIR ?=3D $(PREFIX)/bin
 SBINDIR ?=3D $(PREFIX)/sbin
 MANDIR =3D $(PREFIX)/share/man
 ETCDIR ?=3D /etc
+LIBECONFH ?=3D $(shell test -f /usr/include/libeconf.h && echo y)
=20
 CFLAGS ?=3D -Werror -Wall -W
 override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
@@ -13,6 +14,13 @@ override LDLIBS +=3D -lselinux
 all: sestatus
=20
 sestatus: sestatus.o
+ifdef VENDORDIR
+ifneq ($(LIBECONFH), y)
+	(echo "VENDORDIR defined but libeconf not available."; exit 1)
+endif
+override CFLAGS +=3D -DVENDORDIR=3D'"${VENDORDIR}"'
+override LDLIBS +=3D -leconf
+endif
=20
 install: all
 	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus=
/sestatus.c
index 6c95828e..a0b9b0f1 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -21,11 +21,16 @@
=20
 #define PROC_BASE "/proc"
 #define MAX_CHECK 50
-#define CONF "/etc/sestatus.conf"
+#define CONFDIR "/etc"
+#define CONFNAME "sestatus"
+#define CONFPOST "conf"
+#define CONF CONFDIR "/" CONFNAME "." CONFPOST
=20
 /* conf file sections */
-#define PROCS "[process]"
-#define FILES "[files]"
+#define SECTIONPROCS "process"
+#define SECTIONFILES "files"
+#define PROCS "[" SECTIONPROCS "]"
+#define FILES "[" SECTIONFILES "]"
=20
 /* buffer size for cmp_cmdline */
 #define BUFSIZE 255
@@ -92,9 +97,76 @@ static int pidof(const char *command)
 	return ret;
 }
=20
+#ifdef VENDORDIR
+#include <libeconf.h>
+
+static void load_checks_with_vendor_settings(char *pc[], int *npc, char *f=
c[], int *nfc)
+{
+	econf_file *key_file =3D NULL;
+	econf_err error;
+	char **keys;
+	size_t key_number;
+
+	error =3D econf_readDirs (&key_file,
+				VENDORDIR,
+				CONFDIR,
+				CONFNAME,
+				CONFPOST,
+				"", "#");
+	if (error !=3D ECONF_SUCCESS) {
+		printf("\nCannot read settings %s.%s: %s\n",
+		       CONFNAME,
+		       CONFPOST,
+		       econf_errString( error ));
+		return;
+	}
+
+	error =3D econf_getKeys(key_file, SECTIONPROCS, &key_number, &keys);
+	if (error !=3D ECONF_SUCCESS) {
+		printf("\nCannot read group %s: %s\n",
+		       SECTIONPROCS,
+		       econf_errString( error ));
+	} else {
+		for (size_t i =3D 0; i < key_number; i++) {
+			if (*npc >=3D MAX_CHECK)
+				break;
+			pc[*npc] =3D strdup(keys[i]);
+			if (!pc[*npc])
+				break;
+			(*npc)++;
+		}
+		econf_free (keys);
+	}
+
+	error =3D econf_getKeys(key_file, SECTIONFILES, &key_number, &keys);
+	if (error !=3D ECONF_SUCCESS) {
+		printf("\nCannot read group %s: %s\n",
+		       SECTIONFILES,
+		       econf_errString( error ));
+	} else {
+		for (size_t i =3D 0; i < key_number; i++) {
+			if (*nfc >=3D MAX_CHECK)
+				break;
+			fc[*nfc] =3D strdup(keys[i]);
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
=20
+#ifdef VENDORDIR
+	load_checks_with_vendor_settings(pc, npc, fc, nfc);
+	return;
+#endif
 	FILE *fp =3D fopen(CONF, "r");
 	char buf[255], *bufp;
 	int buf_len, section =3D -1;
diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils/ses=
tatus/sestatus.conf.5
index acfedf6f..01f8051d 100644
--- a/policycoreutils/sestatus/sestatus.conf.5
+++ b/policycoreutils/sestatus/sestatus.conf.5
@@ -8,7 +8,7 @@ The \fIsestatus.conf\fR file is used by the \fBsestatus\fR(=
8) command with the \
 .sp
 The fully qualified path name of the configuration file is:
 .RS
-\fI/etc/sestatus.conf\fR
+\fI/etc/sestatus.conf\fR or \fI<vendordir>/sestatus.conf\fR if it is not a=
vailable
 .RE
 .RE
 .sp
--=20
2.55.0

--ybbvV9b2pbpaiktH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpfISYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1m1loP/3UQ4Rr1sLmBFKASQybR
3fmcZz/UatWS2TYrmMJ3ILJda6wvB0EKP8QbBjmC4QJ05HT04uX59K/6uZ0SEPa7
6IM8olAgS/nAnV4uKuxHjTXcfg6EAQVDQ7H42t9LpfwQgISQ9o1+JYKZVuMSipFu
C1Jnxx+JKbgebbTXLo9GT/P7c3lSeq2Q5OkDBlyCAcwU1qM62/kZUhO3WGeLbzZA
zaagmioj+t/oQBhjb8MNKz8dyh9Gz8cQ0I53/N9WzTOpH9Q5oSWlQodNqE1eo6aV
HZ5moyHXyK01DllReunQEULK68wJbVkkbDuP9qMImRYZC36POGkDX2xO993BgKRT
ER/P+Cu41dkUotm1KxPiPFnGC3aC6T1hirog7EeoU0qspPgv7sRFpl9/knaZvJrO
SJ2+5vUDzbBupwEzEnDe3mt0QOJPzO92ZUnrLpFZ4pUDr7X93znc5lF3tZA09xro
HC29YzL1O39OwyihFlLVCfr8FPXMyjlTisUPJSn8gxLh1l1hE/NhJhJx0qnqZN1o
MS51rqypbFnU/jXF3TUKHjSjKpylM3CewMb1mUvSjaYvww8WQ6uHYn1B5wZf8xRI
fTcEadX/rismXzg59DHgJP54FSTwpB14QavAT2T+ERGNW+8PKnO1F8gqk3DrdTUq
PXO9r7mOktW4F+diTdUNqzii
=FdCN
-----END PGP SIGNATURE-----

--ybbvV9b2pbpaiktH--
