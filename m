Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EC230BDB
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221981; cv=none; b=qt5HC8/xo3QZlPOg1a6kRGReVwJGrZI2a9Nqro2cdshbvwip8DJyX0XD8vnMTeH7PMjwqbDFVHX+Fl6WPbYva7nC/8IvneXyY0wubYwDwLOTwP8Z3u0Ni1i7oLIqy9vehujS5YjsTzutog3jduNAD+iuQw+28RY1qU+22Zve0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221981; c=relaxed/simple;
	bh=VCb6Yj/6v1udT3mnsBM8+CmZn9BrslvCRSSwot1sav4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+VbV7krcYT+MC3dtB5uDu0GZQTAYBEmbH4aZgTGQfv2xYTrY2s+54dYjiI0XjRctXH+BH7oFB7zJO8aiqDAp7xvcRUm0toV9p8gR1njtQqL1WfZUcXd3DGntC3+UssUM3bPG0HQrr0nOjWL/d4ezztPenBvdoKu+FcAer+/08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D68BB3E3D;
	Tue, 28 Jul 2026 06:59:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCA6A779B3;
	Tue, 28 Jul 2026 06:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBOJLFlTaGqFWwAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Tue, 28 Jul 2026 06:59:37 +0000
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Cc: Johannes Segitz <jsegitz@suse.de>
Subject: [PATCH v4 2/2] man: Document directory cycle handling of selinux_restorecon
Date: Tue, 28 Jul 2026 08:59:17 +0200
Message-ID: <20260728065917.1343947-2-jsegitz@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728065917.1343947-1-jsegitz@suse.de>
References: <20260728065917.1343947-1-jsegitz@suse.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: D68BB3E3D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action

Skipping directory cycles instead of aborting the file tree walk is a
user visible behavior change: restorecon -R over a tree containing e.g.
a bind mount of an ancestor directory now logs a warning, skips the
cycle and completes successfully, instead of failing with ELOOP.

Document the new behavior for the flag SELINUX_RESTORECON_RECURSE,
including that a cycle is not an error and therefore is neither
affected by SELINUX_RESTORECON_ABORT_ON_ERROR nor counted by
SELINUX_RESTORECON_COUNT_ERRORS, and note the previous behavior in the
selinux_restorecon(3), restorecon(8) and setfiles(8) man pages.

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/man/man3/selinux_restorecon.3 | 28 ++++++++++++++++++++++++
 policycoreutils/setfiles/restorecon.8    | 20 +++++++++++++++++
 policycoreutils/setfiles/setfiles.8      | 14 ++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 9bcd3d42..bafa86a2 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -99,6 +99,21 @@ and if successful write an SHA1 digest of the specfile entries to an
 extended attribute as described in the
 .B NOTES
 section.
+.RS
+Note that directory cycles encountered while descending, for example a bind
+mount of an ancestor directory or nested BTRFS subvolumes, are not followed.
+A warning is logged, the offending directory is not descended into and the
+file tree walk continues with the remaining entries. Such cycles are not
+treated as errors, therefore they neither abort the file tree walk when
+.B SELINUX_RESTORECON_ABORT_ON_ERROR
+is set, nor are they included in the count returned by
+.BR selinux_restorecon_get_skipped_errors (3)
+when
+.B SELINUX_RESTORECON_COUNT_ERRORS
+is set. See the
+.B NOTES
+section for details of the previous behavior.
+.RE
 .sp
 .B SELINUX_RESTORECON_VERBOSE
 log file label changes.
@@ -302,6 +317,19 @@ with the
 .B SELINUX_CB_LOG
 .I type
 option.
+.IP "6." 4
+Up to and including libselinux 3.11 a directory cycle was fatal:
+.BR selinux_restorecon ()
+logged an error, stopped the file tree walk and returned \-1 with
+.I errno
+set to
+.BR ELOOP ,
+regardless of the
+.B SELINUX_RESTORECON_ABORT_ON_ERROR
+and
+.B SELINUX_RESTORECON_COUNT_ERRORS
+flags. Since then the cycle is skipped as described above, so a file tree
+walk over a directory tree containing a cycle can complete successfully.
 .
 .SH "SEE ALSO"
 .BR selabel_get_digests_all_partial_matches (3),
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 982701c2..443f29ab 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -145,6 +145,9 @@ options are mutually exclusive.
 .TP
 .B \-R, \-r
 change files and directories file labels recursively (descend directories).
+Directory cycles are skipped, see the
+.B NOTES
+section for details.
 .br
 .TP
 .B \-v
@@ -240,6 +243,23 @@ and provided the
 .B \-n
 option is NOT set and recursive mode is set, files will be relabeled as
 required with the digests then being updated provided there are no errors.
+.IP "4." 4
+When descending directories (i.e. the
+.B \-R
+or
+.B \-r
+option is set)
+.B restorecon
+detects directory cycles, for example a bind mount of an ancestor directory or
+nested BTRFS subvolumes. A cycle is reported as a warning and the offending
+directory is not descended into, the remaining entries are still relabeled.
+A directory cycle is not counted as a relabeling error, so it does not affect
+the exit status and does not stop the file tree walk. Up to and including
+version 3.11 a directory cycle was instead treated as a fatal
+.B ELOOP
+error, terminating
+.B restorecon
+with a non-zero exit status.
 
 .SH EXAMPLE
 .nf
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index d55b42db..17cabe37 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -307,6 +307,20 @@ and provided the
 .B \-n
 option is NOT set, files will be relabeled as required with the digests then
 being updated provided there are no errors.
+.IP "4." 4
+.B setfiles
+detects directory cycles while descending directories, for example a bind
+mount of an ancestor directory or nested BTRFS subvolumes. A cycle is reported
+as a warning and the offending directory is not descended into, the remaining
+entries are still relabeled. A directory cycle is not counted as a relabeling
+error, so it does not affect the exit status and does not stop the file tree
+walk. Up to and including version 3.11 a directory cycle was instead treated
+as a fatal
+.B ELOOP
+error, terminating
+.B setfiles
+with exit status
+.BR 255 .
 
 .SH EXAMPLE
 .nf
-- 
2.55.0

