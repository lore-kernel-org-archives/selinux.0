Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3E6F305
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759721; cv=none; b=kj0a6wohOvVPgoCXWqoKrVVkhZhCrEg6u1/ijR4FQbpXWfZUwl5WZpK9hHkSYgg8/8rrQLn/veq/53+78YYUJgZmbHO1JMtXXqSMLM6KbHNju4+RzQIWp6Q+BJ5hcj9r91kHSOQ0DeZgLsXLXW0NH54GshH3/Q2Q9zmw3k+SbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759721; c=relaxed/simple;
	bh=SdPzySbwbFd8nIUO8XfJ1wo/eaAFVl/1lErfIUVOIHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/eWmEittFpYwsMobE4C/d3kg9hRA1Y3tXNtUXGiQJYPPtADQxza3/uyqNhk3eldzsOGd9r1xw4e+DJAP8yQyhlL25kc6R/IznUZTht1S8PwAezwggiTgz4hjPfopvwl97w27ctB/5QjDiEOgedCs6rFxEjgloBAsmv+0B6oRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBG2dl62; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TfB2FF/K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mAGkNWGb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=03ij0yKS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBG2dl62";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TfB2FF/K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mAGkNWGb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="03ij0yKS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0A9A1FE5D;
	Thu, 24 Oct 2024 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729759717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bt1zJvptCkWlrUs2RY9chWhLMdhGBe7FgHK3qkKCOpw=;
	b=MBG2dl62uW6w5zSSKFe4Xcl3ZGPdrlLPmEWKUbyQMbUlnENue3aU3td0VU9u8eVSqO/IGv
	uBJEjuk+/eIqH7PumoWcxBpS2VrHIg9rS5GqMUkK86Z1ACNYWt85JUYQig2FkQJnRnhd7n
	FD4cuyz+RfSrxm4RMpv1W7l9BMIS94w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729759717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bt1zJvptCkWlrUs2RY9chWhLMdhGBe7FgHK3qkKCOpw=;
	b=TfB2FF/KEhzJH/aiZwAEyBWWDWONQ/pPzCo5XjjzSk72U3emlHaNP+3jLMh3bjQYhYbSDB
	IpDKOcYKxP6kGUBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mAGkNWGb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=03ij0yKS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729759716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bt1zJvptCkWlrUs2RY9chWhLMdhGBe7FgHK3qkKCOpw=;
	b=mAGkNWGbU5P6fTL4vGECQKpv9NQB21Jz8rY0+jaxvWV7rDAh2N7pMMAajXJYKwegm8WHTu
	usTubTKpFtrqMKyVYGha+g4XRHhZkUMnDEZn0PZcDKdFekCHHVFPLr2gtB3HpDKEdnf95h
	xufmud0Q6TtJX3pnjC8TWgnNfY85kw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729759716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bt1zJvptCkWlrUs2RY9chWhLMdhGBe7FgHK3qkKCOpw=;
	b=03ij0yKStIQ/1zFA/WLXbIA1gN5RrckZdhZawe52hIvnRIl1AgcnoodrZSZVgvnJ5wMhMd
	8KpCCFBJFikw4SCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8D84136F5;
	Thu, 24 Oct 2024 08:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDx4NOQJGmdcPQAAD6G6ig
	(envelope-from <fvogt@suse.de>); Thu, 24 Oct 2024 08:48:36 +0000
From: Fabian Vogt <fvogt@suse.de>
To: SELinux List <selinux@vger.kernel.org>
Cc: Cathy Hu <cahu@suse.de>,
	Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 1/2] restorecond: Set GLib IO channels to binary mode
Date: Thu, 24 Oct 2024 10:48:15 +0200
Message-ID: <20241024084816.40872-2-fvogt@suse.de>
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
X-Rspamd-Queue-Id: F0A9A1FE5D
X-Spam-Level: 
X-Spamd-Result: default: False [-2.87 / 50.00];
	BAYES_HAM(-2.86)[99.42%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.87
X-Spam-Flag: NO

By default, GIO channels use UTF-8 as encoding, which causes issues when
reading binary data such as inotify events.

Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
 restorecond/user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/restorecond/user.c b/restorecond/user.c
index 3ae3ebbb7230..7188c22e3119 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -238,6 +238,7 @@ static int local_server(void) {
 	}
 	/* watch for stdin/terminal going away */
 	GIOChannel *in = g_io_channel_unix_new(0);
+	g_io_channel_set_encoding(in, NULL, NULL);
 	g_io_add_watch_full( in,
 			     G_PRIORITY_HIGH,
 			     G_IO_IN|G_IO_ERR|G_IO_HUP,
@@ -282,6 +283,7 @@ int server(int master_fd, const char *watch_file) {
 	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
 	GIOChannel *c = g_io_channel_unix_new(master_fd);
+	g_io_channel_set_encoding(c, NULL, NULL);
 
 	g_io_add_watch_full(c,
 			    G_PRIORITY_HIGH,
-- 
2.47.0

