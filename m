Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31C6F305
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759717; cv=none; b=rvWFjBGcy3yYfW+05cj2Nzmv3KYRoROJWxNotuK0YicdBIFhOOhk6xR5wV4l/Xq6J/YS2IObh2nXP4DWp2JuhEO/HKXt3PdvafpsRxvUOXKXaIP7LbBh5VvqSIU0LX35MFG2M/h1JnjE/H/8NGeAFHN7LxHTCn9IekD9WOR2VY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759717; c=relaxed/simple;
	bh=KypG1W260AkdpwfY1T/v5w3Cu+x4usPXGuGm32n0TNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZOtIE+4LefYCSVV2ROjEay03XAmj84go2P327L90C03vmeF4t/cfU407LGq1SZw0lHE4jJM87htIExAkMuLAlIn3zh4UH10tkIb8eBoDeb9i/7Tytb+XZayKWSqRIAeikU50J+T73X0HtcL4y4LGLXy+oVa8r2AkgWFMSNMbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eWgh+G4s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RWilu+RW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ABT5di2v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VGj/gSFl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eWgh+G4s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RWilu+RW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ABT5di2v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VGj/gSFl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF3641FE6C;
	Thu, 24 Oct 2024 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729759714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5v3ZAaFrb5+Eoe61+jrzFU1sdg43W2svFo/Rv4M0nWE=;
	b=eWgh+G4sGG7fQEKVYCWVmlEZQwiDRlSYepVf3MtD/IS8XaktZpYma0m52clz6ZzQafYYyq
	VHp9b4oD2KK6EtyXdxAqL1XkLC3eR8YCu/bfyQFyFAGKdVqi+Td33VdZvk5vMoJCtGh+Gs
	C3fcn1KYE45pRDMm+7adbEnXPpm5VVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729759714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5v3ZAaFrb5+Eoe61+jrzFU1sdg43W2svFo/Rv4M0nWE=;
	b=RWilu+RWCmVivkLvfcx7koAtUpYLEUsVmEO2Ye8hioTzQrcJkkVL8l4I4Niq3WyM801WGy
	EvkCGxAh6jrRjkCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ABT5di2v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VGj/gSFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729759713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5v3ZAaFrb5+Eoe61+jrzFU1sdg43W2svFo/Rv4M0nWE=;
	b=ABT5di2v4cVaNJVN6nTeCpg0SJ8IfqHTrDb5dby0vvk56Eo9Qsqa7HmoTlPkWOvXx7tDny
	bcOihLYZmaNVElI5MOIpu8apgjBHN6yM8GBql4FkEyzOyYR9EeJWuzlTTSHcKr+19VUruN
	gM9kz/GRd0K/xiPvpRtZ+Y8DJ5n6Z2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729759713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5v3ZAaFrb5+Eoe61+jrzFU1sdg43W2svFo/Rv4M0nWE=;
	b=VGj/gSFlCjC12/h1C81gco4tA4Clca7cfPBoKsAyQkAFS2WgmVbVpq33SoKDbw4daJ+wtN
	BricCU3Bvof+JHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6285136F5;
	Thu, 24 Oct 2024 08:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qHTHM+EJGmdcPQAAD6G6ig
	(envelope-from <fvogt@suse.de>); Thu, 24 Oct 2024 08:48:33 +0000
From: Fabian Vogt <fvogt@suse.de>
To: SELinux List <selinux@vger.kernel.org>
Cc: Cathy Hu <cahu@suse.de>,
	Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 0/2] restorecond: GLib IO channel fixes
Date: Thu, 24 Oct 2024 10:48:14 +0200
Message-ID: <20241024084816.40872-1-fvogt@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF3641FE6C
X-Spam-Score: -2.82
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.82 / 50.00];
	BAYES_HAM(-2.81)[99.17%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,opensuse.org:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Downstream we hit a bug that "restorecond -u" kept running even after the user
logged out (https://bugzilla.opensuse.org/show_bug.cgi?id=1231512). The cause
for that was that SIGTERM was handled, but had no effect. While testing the fix
(PATCH 2), I found that the inotify events weren't actually read properly.
That's addressed by PATCH 1.

Fabian Vogt (2):
  restorecond: Set GLib IO channels to binary mode
  restorecond: Set GLib IO channels to nonblocking

 restorecond/user.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.47.0

