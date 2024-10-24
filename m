Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B51AE001
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759722; cv=none; b=DNl1/j827NT/F2WTTRoTNwvB+tdE6T8VBmfEasIy5Cuu0wzczh0DhGMf2ZkWWVk973QcHUe/tyNAlFiY1fgC+UQBm3rzB6uXQLzEMryTLwq9u/kTSEWDmm+VUX2xV+83lT9k6Ezt20QDJt3jVCLMXcfAZo5Mh1Nzm/aff8/Likg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759722; c=relaxed/simple;
	bh=m8i+9hL94duXg/DOCsG7BDozVm1oq+IQ8PBBORAMMZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqgvDfMUbmx4m5wuPg90K7HubBfZTqTt/e9kOWEPjXzuDAZW/4pqkr5hKyATqXHFxK0T1P0qLlFTeU6GICzt7kGu0sza544GX6ggp9AF6QaZjDbA3RyChxom5gQkwWl8qKskA01e4alqCtqaY8ejx2tzPgqbRZWoERqU0DUz2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L7AoAuCQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cX5YSkjy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L7AoAuCQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cX5YSkjy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L7AoAuCQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cX5YSkjy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L7AoAuCQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cX5YSkjy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC14621ADD;
	Thu, 24 Oct 2024 08:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729759718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg1Bxv7BAmdfWYPjMjN3C0EVMOwX3P59m4WghfX8RsA=;
	b=L7AoAuCQpKMXCe45folncnfUE8NyIFFViRZ7qtzoKmcGUJFZXK/rwnX8J9ccyrf5IYu2bi
	0NuTiX7+FN0m+/TLwlMFeap2r7qWp2NA/JGMF+f6DBwvdV8VOquJ7sv8QBqlERn/QM/TYo
	ZaMQ3le0F+2qudMtCcwuC6l9v0sL3rY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729759718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg1Bxv7BAmdfWYPjMjN3C0EVMOwX3P59m4WghfX8RsA=;
	b=cX5YSkjynopPv6UvX7tV2OkKDxzO1ziLFeadzJ8Nu+gaww25OSuLaG+6FlZ/evnvkTcGrl
	cSU0X4IIo+jrd4BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729759718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg1Bxv7BAmdfWYPjMjN3C0EVMOwX3P59m4WghfX8RsA=;
	b=L7AoAuCQpKMXCe45folncnfUE8NyIFFViRZ7qtzoKmcGUJFZXK/rwnX8J9ccyrf5IYu2bi
	0NuTiX7+FN0m+/TLwlMFeap2r7qWp2NA/JGMF+f6DBwvdV8VOquJ7sv8QBqlERn/QM/TYo
	ZaMQ3le0F+2qudMtCcwuC6l9v0sL3rY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729759718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg1Bxv7BAmdfWYPjMjN3C0EVMOwX3P59m4WghfX8RsA=;
	b=cX5YSkjynopPv6UvX7tV2OkKDxzO1ziLFeadzJ8Nu+gaww25OSuLaG+6FlZ/evnvkTcGrl
	cSU0X4IIo+jrd4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD70E136F5;
	Thu, 24 Oct 2024 08:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wCPGLeYJGmdcPQAAD6G6ig
	(envelope-from <fvogt@suse.de>); Thu, 24 Oct 2024 08:48:38 +0000
From: Fabian Vogt <fvogt@suse.de>
To: SELinux List <selinux@vger.kernel.org>
Cc: Cathy Hu <cahu@suse.de>,
	Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 2/2] restorecond: Set GLib IO channels to nonblocking
Date: Thu, 24 Oct 2024 10:48:16 +0200
Message-ID: <20241024084816.40872-3-fvogt@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024084816.40872-1-fvogt@suse.de>
References: <20241024084816.40872-1-fvogt@suse.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Without nonblocking IO, g_io_channel_read_chars waits indefinitely for more
data without ever returning control to the event loop.

Set the IO channels to nonblocking to fix SIGTERM handling.

Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
 restorecond/user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/restorecond/user.c b/restorecond/user.c
index 7188c22e3119..25e70ae15b94 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -239,6 +239,7 @@ static int local_server(void) {
 	/* watch for stdin/terminal going away */
 	GIOChannel *in = g_io_channel_unix_new(0);
 	g_io_channel_set_encoding(in, NULL, NULL);
+	g_io_channel_set_flags(in, g_io_channel_get_flags(in) | G_IO_FLAG_NONBLOCK, NULL);
 	g_io_add_watch_full( in,
 			     G_PRIORITY_HIGH,
 			     G_IO_IN|G_IO_ERR|G_IO_HUP,
@@ -284,6 +285,7 @@ int server(int master_fd, const char *watch_file) {
 
 	GIOChannel *c = g_io_channel_unix_new(master_fd);
 	g_io_channel_set_encoding(c, NULL, NULL);
+	g_io_channel_set_flags(c, g_io_channel_get_flags(c) | G_IO_FLAG_NONBLOCK, NULL);
 
 	g_io_add_watch_full(c,
 			    G_PRIORITY_HIGH,
-- 
2.47.0

