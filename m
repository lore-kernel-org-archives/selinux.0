Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BD3C1D78
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338814; cv=none; b=apAH+ytwHK10rlmC91yXlk3TlHn8FcqE21aiL3VCbOy0E2Wi4QEFYx13dwiiiYdxDyChZHXa9sP1D/cqXEIlItVySPu1WTlvwyEldD1+lTxwC7ARRhOSm975lUvUxdHBjbP41fPuxX9ROS+XhFemzTwwysfe3WFqDhuf44KYoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338814; c=relaxed/simple;
	bh=94AvwOA+YOximRU/eJKomgSo21aE34XrVUnD//SrSJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvaMVRQ5Mn/cZ1pIap0hFYIVKEKfWjS8b+3Q09QDV3SsfB876sv7MlE2JQvPjZHmVwEj5RM/7isiji+MoF7PZnX4wVoBKy6Gt92FTXIlYaVQQa3cD/XIZPz1XOUXc1QV2DYh6IOq8je+Nv6nNJaCRjIRl8BcbQt4aworqpbhg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ckBILzbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MLAY4uEk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bLDDWWyl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ex7Kt/kb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ckBILzbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MLAY4uEk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bLDDWWyl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ex7Kt/kb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D66C3E0F;
	Wed, 29 Jul 2026 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkPOIHaGsnPbBVAt27OteQidkPiy0peXEG5+/0a4DwM=;
	b=ckBILzbk2TStetv58+MXXPa3yc1KaNX+UcCxS5+X7r6TopWtU4kcu90QF36TEwMyORjObn
	x92TcbotYWsdqEJlbNaukxWJRDlMnT/oW5EacW7owUXnlPpqchE8rTcAdTi05B1t292mDo
	dCIvtc3z7W+4RXXcCOSVB2wvYOia4pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkPOIHaGsnPbBVAt27OteQidkPiy0peXEG5+/0a4DwM=;
	b=MLAY4uEk87uVPz2pUkZxfdMif7/INTI+qrri8Bb6A2mvR2jvhcE9EWAdWWPPk2RmA77tuy
	BqRn7fhV7dD8WeDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkPOIHaGsnPbBVAt27OteQidkPiy0peXEG5+/0a4DwM=;
	b=bLDDWWylasB8EsJOrP2pn9DZKd6gFr3X0USW1/ofeJHqR2slT5rP1l2eIILRyIZ5+jOJoZ
	gmHh8hTV14P0DrAXbG8CVnN+pzhsQhRTmXfB8DnRttQPJ4xdGw7ilWog13rUbCGh8P9/U7
	lJVDR/eme80mLFJfaVI2/m/UqRp/5Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkPOIHaGsnPbBVAt27OteQidkPiy0peXEG5+/0a4DwM=;
	b=Ex7Kt/kbj5I8fo8MxQkW4mtzhfau1wnyhs8nbOvC+FsL57FRk+9F7cMOTjpmFSQvUPbCGd
	4HaXMVKN8SHRJnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D50AA779A1;
	Wed, 29 Jul 2026 15:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Kp2M7IbamqfbwAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 29 Jul 2026 15:26:42 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 2/2] python/sepolicy: add a pyproject.toml file
Date: Wed, 29 Jul 2026 17:19:19 +0200
Message-ID: <20260729152415.1606580-4-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729152415.1606580-2-cahu@suse.de>
References: <20260729152415.1606580-2-cahu@suse.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Add a pyproject.toml file for the sepolicy python module.  This
required also updating setup.py to avoid defining author outside of
pyproject.toml, and I further updated the authors to refer to the list
like libselinux since Dan is enjoying retirement.

Fixes: https://github.com/SELinuxProject/selinux/issues/505
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
dropped scripts section
 python/sepolicy/pyproject.toml | 12 ++++++++++++
 python/sepolicy/setup.py       |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 python/sepolicy/pyproject.toml

diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject.toml
new file mode 100644
index 00000000..3dafd35f
--- /dev/null
+++ b/python/sepolicy/pyproject.toml
@@ -0,0 +1,12 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "sepolicy"
+version = "3.11"
+description = "Python tools for SELinux policy analysis (sepolicy, sepolgen)"
+license = "GPL-2.0-or-later"
+authors = [
+    { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
index ca0396b5..5c4f2e5d 100644
--- a/python/sepolicy/setup.py
+++ b/python/sepolicy/setup.py
@@ -8,8 +8,6 @@ setup(
     name="sepolicy",
     version="3.11",
     description="Python SELinux Policy Analyses bindings",
-    author="Daniel Walsh",
-    author_email="dwalsh@redhat.com",
     packages=[
         "sepolicy",
         "sepolicy.templates",
-- 
2.54.0

