Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E783A6417
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548873; cv=none; b=VrVg9vh6vJ+ehY6vm7kUrXSoYzxMYNWsiSZlLK/NeXaLV+hLmTzAM08Qb1m8GRih21mkIADFt5vG3igOmPLReOs4txGYmggwYjK0YostvhzV0/Osufu1Ce60XAgNtNWRagWr8LntlgJre/q9OwXK16csPO8U1NQ/r41IiqXvYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548873; c=relaxed/simple;
	bh=doxA2VtI3OEEMZwjrd8EX8i4emZjwEmRCDLGMVkjTSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoZnme8WFypFwKCtNEFkp7Qt8rV43647zYWMehNNVewm2YuorM2vfPWQBHExmG5WjZPwJhms0UyzgpJdtEcIV/EfYZty5yD3rkhr91wfwC/JuKrxP0ZiQW6jktGMuAj6gktBvj1X5GKF3njC8BS86D5lmlzM7LniHYzMUc/Vo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Otqv74L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=caT8PONZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=omCpFnCE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Skyz/hLT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Otqv74L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="caT8PONZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="omCpFnCE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Skyz/hLT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDBE86A803;
	Thu, 30 Apr 2026 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777548869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/LWDnJEq5phILeVke1TT+m/gUSJFn3AuIALbnd8YtAc=;
	b=0Otqv74LcrAdJaTd0YAM5vawMdHVFAZ7REMlkal7Kh1Kd3TaQFdqZN0pWBkjv4e6oxx2Cs
	K6IturJQu1Ul58ted0jqibzgVLoffnL/2BYWmCOk+v8ko18dl5s9imzB/BcktPjDafNrfD
	+P5XoRTxRErS6BohuMrApF1RRKWqNCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777548869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/LWDnJEq5phILeVke1TT+m/gUSJFn3AuIALbnd8YtAc=;
	b=caT8PONZFgaWGzKrhhV4z+egqL5pgg7h6t1u3/XWdArZgdW0spc8nK6yMDocteyeJ0VJeV
	gXEs7aA3fXcszrBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777548868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/LWDnJEq5phILeVke1TT+m/gUSJFn3AuIALbnd8YtAc=;
	b=omCpFnCEMV9TFSSuTlTtE7ycDgwxpcyF0XzFA5HxF0Wtgy0BJaLMxnFj5/Ii3f6NJSmvKV
	/Xw6dT7fHBmNBMJia/2u5adPi/Gr2vDu7mreqS2GcvHvlBxcCyDb1mwKYCaK1MSRUrD9uX
	NzfU94t42VMI3KTc0/N29xSLwV6xqR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777548868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/LWDnJEq5phILeVke1TT+m/gUSJFn3AuIALbnd8YtAc=;
	b=Skyz/hLTHPhzMYNxBc2QU4L5DyIvRooU9DfRexf04MKKn0AAO2CzNVLbOPNObSUWletb7h
	5+RB7sbCQVssrTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA7EF593B0;
	Thu, 30 Apr 2026 11:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5i5PMEQ+82msQgAAD6G6ig
	(envelope-from <cahu@suse.de>); Thu, 30 Apr 2026 11:34:28 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org,
	lautrbach@redhat.com,
	fvogt@suse.com
Cc: Cathy Hu <cahu@suse.de>
Subject: [PATCH v2] restorecon: Only log error on readonly fs (bsc#1232226)
Date: Thu, 30 Apr 2026 13:29:45 +0200
Message-ID: <20260430113302.2841721-2-cahu@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Problem:

Before this change, when restorecon encountered a read-only filesystem,
it would set the error code to 255, not continue traversing, but
continue with other paths:
"restorecon: Could not set context for <path>:  Read-only file system"

For callers there is no way to distinguish from that error code if it
encountered a serious error, or a read-only fs was not relabelled, or
both. However, not failing when a read-only fs is traversed is
acceptable in most if not all cases.

This caused issues when e.g. restorecon was used in autorelabel
mechanisms during boot to relabel the file system. When it encountered
a read-only BTRFS subvolume, the return code would be set to 255 and
we had to fail the relabel service, as it might be a more severe issue.

Behaviour change in this commit:

With this change, restorecon logs the encounter of a ro file system, continues and finishes with return code 0:
"Read only filesystem, relabel not possible: <path>"

Other mechanims that were considered to fix this issue and why they were
not used:

- -x skip all subvolumes: break cases of subvolumes which aren't mounted explicitly but still need to be relabelled
- caller generates skippable locations and these get automatically fed
  into restorecon: error prone and needs to be manually maintained in
certain scenarios
- caller ignores non-zero return code: not good idea, it would cover up
  issues that would be hard to debug in the future
- skip only ro btrfs subvolumes: I started writing a poc and discovered it is not easily
  possible without either pulling libbtrfs in as dependency or having
  a lot of ioctl calls which likely will lead to performance degradation
  or tracking the btrfs status inside of restorecon, which would be a
  big code change for a problem that might be also there on other file
  systems

Discussion and context:

- "Question regarding restorecon and btrfs read-only snapshots" Thread:
https://lore.kernel.org/selinux/98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de/

- (open)SUSE bug: https://bugzilla.suse.com/show_bug.cgi?id=1232226

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 libselinux/src/selinux_restorecon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8fadf4d2..e8545e27 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -774,10 +774,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		if (!flags->nochange) {
 			if (lsetfilecon(pathname, newcon) < 0) {
 				/* Ignore files removed during relabeling if ignore_noent is set */
-				if (flags->ignore_noent && errno == ENOENT)
+				if (flags->ignore_noent && errno == ENOENT) {
 					goto out;
-				else
+				} else if (errno == EROFS) {
+					selinux_log(SELINUX_INFO, "Read only filesystem, relabel not possible: %s\n", pathname);
+					goto out;
+				} else {
 					goto err;
+				}
 			}
 
 			updated = true;
-- 
2.53.0

