Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34B3ED3C7
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200377; cv=none; b=DKF6BOM7/IcL/V6ywk96Erd1pkGdPhDIwlIz/oSBC2u3F7VSImsf4WT0tZ4SQ3fPkKhx/MLvcBs4BEXkniqqiSot8+DvCCYIRbrThA4/vg2wmNMoIbIxEksm+tBpcX76DpiSgZKe4yux5v3mOAdUAnrzfyFbN7XZt7cSXK5OPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200377; c=relaxed/simple;
	bh=8skD0gd3932gTUVAi3nTfHM1LKYaVGypjAjqe8D6lSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oitAoE/BAOnvMwF3sVMF9QCh33LMFm6a5elTpf6JWh8LUahiB7n92PKMxvWNB8miAHxv28i62y4xI6eQoLbUY+bBiVKh9Hqtsv72CqMGRiPuEleAfW5j8x5E5//H2p3tKKnAEqvZLzDo585+Xd5sVPy7Z6cczBfe/su9S+SbCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAFveqXu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAFveqXu"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50fbd79350dso41484091cf.3
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779200375; x=1779805175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46ylBb54zSOQ2BougNbauv9xOX+w1WiEu6nKJxyuZOs=;
        b=OAFveqXuepS+zXDAHYkdOuEPYiQ+iGVezXqO0XzZNaI6e2RBUTOXx+EqVZzGkP2pA7
         fWi22lOzMc/BDng4IGR5LgWqWEGElZem6fNAI/CHIDBY1lotQABDZ5pviQVQWSnfqc2H
         xquiIcGWpDvKrAPHeCbbfvvzFweVWOYg7xf8NhFmJpl9Jj9UY9ngxANN2PG80PhAPe7o
         GXjGmYRsedRXEF69aCWg3cSrj9uLYLUzKzipjSuPNP6G+im0wgO5VtLP4miR8l51W0iP
         9FQpn/pLZBx1una2brTPSBzxS0TcpesIwcz6bnwNUx33jZp0InAQ7Au+QJZbMuYbzF52
         CBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200375; x=1779805175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46ylBb54zSOQ2BougNbauv9xOX+w1WiEu6nKJxyuZOs=;
        b=mdqWoXKYhI6bbfCNnJjFOi6i9kvviqj1GsZ3Q7VP+leAdiVln7w2yVNyTe34QMp5aa
         1mfV9v0UhNSUNd0jJIwmMSYCIQbvxrg5B4dNZxniSFVHoPH5R16MTjef7YxG4+ZYqDzJ
         q5Fi8pGtj9J2j0aE6slHiVwFEN4IePN0QD/Ix/pxRDTUdJAV66KfAyPTpBsp5a5nz+am
         vSGN9S/BNf56mtuYgn063SYI3Jg0t6IGGwCl0wU+BnySVwykT3br/O0JhsKRuoj6aUWb
         ZdutLr6auC+P2ebq2BAjBLaAMcWaXT8Z7yu+eOH5rX3S/wb8rLKdC2F9bDGx0Zm+T4oj
         4yqg==
X-Gm-Message-State: AOJu0Yzq3G4W8GYtaehTtp/M9BSSZC19fYX+QDDnvaaykHAZIWTDFkWq
	c/BkNBnzDGjmgvpq/0EI8wO7MOzmsW1aTCk8bG/arL68f3CSkaoGi+UQUbvATg==
X-Gm-Gg: Acq92OEt9cbmI4+r1ftchEKl2Szh4VuUXhlyKTPneVOBnm0PG3ohANluHR0SdNBrqNe
	W4pYv3oLqs0NL6OFaP4oeWBWqt4St4a1Dabe5haXe3JHF7rgOB85oP4IAgIu/qhuDLZhsgfGgDZ
	BUw/OcwF1SV7VTEgegXs8TfyHz9PWA1GJcvHNW68rv+UKn4KQ5DhB7N8aYIJC5F2vNDz631AG6Y
	7/TGNAsawONNMkls7VNkNAuMvB+mbnGZh+o7zd6jtLRYctMCQBs9MyvXvSH2CaZ971Dne/UIdjc
	WMOqoRgyV1x3ft6n2PB5vPmg6TqRyEX0iE5iok8wmCuZb9vSl4fm/em3ztGWOQ/oXySGRv0qKLk
	4PEsJqYiHrjweg6dYkBkJBY6em9GkACz5OnqBD4EallfvTmIBpfvHUoAcjZuRz+Y4+fFNhM1V9V
	aASkVb8USuvLaXDEPeOfoqzNnzKpMfs5j6tOy7kkk3qOaC9SQxHLqksT3SlOsprXRac1DtrwSVf
	AJzyUzuESCM8Xza8FGXg2Ue67s3mdnwEqS9ehOOVJsj2yVlfYsBsU8=
X-Received: by 2002:a05:622a:430f:b0:50f:c67e:d52c with SMTP id d75a77b69052e-5165a26bda4mr214332691cf.55.1779200374508;
        Tue, 19 May 2026 07:19:34 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm153317151cf.15.2026.05.19.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:19:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix selinux_restorecon() error handling
Date: Tue, 19 May 2026 10:18:58 -0400
Message-ID: <20260519141858.378997-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that we handle and count errors during the tree walk consistent
with the selinux_restorecon() flags.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 60 +++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8b6eba0c..cb22cab4 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1040,6 +1040,20 @@ static bool walk_is_cycle(const struct rest_state *st, dev_t dev, ino_t ino)
 	return false;
 }
 
+static bool note_walk_error(struct rest_state *state)
+{
+	if (state->flags.abort_on_error) {
+		state->error = -1;
+		state->abort = true;
+		return true;
+	}
+	if (state->flags.count_errors)
+		state->skipped_errors++;
+	else
+		state->error = -1;
+	return false;
+}
+
 static int open_final(int dfd, const char *name, struct stat *sb)
 {
 	int fd;
@@ -1143,10 +1157,12 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 			*rd_fd = openat(fd, ".", O_RDONLY | O_DIRECTORY |
 					O_NOFOLLOW | O_CLOEXEC);
 			if (*rd_fd < 0 &&
-			    (!state->flags.ignore_noent || errno != ENOENT))
+			    (!state->flags.ignore_noent || errno != ENOENT)) {
 				selinux_log(SELINUX_ERROR,
 					"Could not read %s: %m\n",
 					state->pathbuf);
+				note_walk_error(state);
+			}
 		}
 		return 1;
 	}
@@ -1159,8 +1175,15 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		errno = 0;
 		de = readdir(top->dirp);
 		if (!de) {
-			if (errno)
-				return -1;
+			if (errno) {
+				selinux_log(SELINUX_ERROR,
+					"Could not read directory %s: %m.\n",
+					state->pathbuf);
+				walk_pop(state);
+				if (note_walk_error(state))
+					return -1;
+				continue;
+			}
 			walk_pop(state);
 			continue;
 		}
@@ -1173,19 +1196,26 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		size_t plen = walk_path_append(state, de->d_name);
 		if (plen == (size_t)-1) {
 			selinux_log(SELINUX_ERROR,
-				"Path name too long under %.*s.\n",
+				"Path name too long under %.*s, skipping.\n",
 				(int)top->pathlen, state->pathbuf);
 			errno = ENAMETOOLONG;
-			return -1;
+			if (note_walk_error(state))
+				return -1;
+			continue;
 		}
 
 		int fd = openat(pdfd, de->d_name,
 				O_PATH | O_NOFOLLOW | O_CLOEXEC);
 		if (fd < 0) {
-			if (!state->flags.ignore_noent || errno != ENOENT)
+			if (!state->flags.ignore_noent || errno != ENOENT) {
 				selinux_log(SELINUX_ERROR,
 					    "Could not open %s: %m.\n",
 					    state->pathbuf);
+				state->pathbuf[top->pathlen] = '\0';
+				if (note_walk_error(state))
+					return -1;
+				continue;
+			}
 			state->pathbuf[top->pathlen] = '\0';
 			continue;
 		}
@@ -1195,6 +1225,8 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 				    state->pathbuf);
 			close(fd);
 			state->pathbuf[top->pathlen] = '\0';
+			if (note_walk_error(state))
+				return -1;
 			continue;
 		}
 
@@ -1203,11 +1235,17 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 			rdfd = openat(fd, ".",
 				      O_RDONLY | O_DIRECTORY |
 				      O_NOFOLLOW | O_CLOEXEC);
-			if (rdfd < 0) {
-				if (!state->flags.ignore_noent || errno != ENOENT)
-					selinux_log(SELINUX_ERROR,
-						"Could not open %s: %m.\n",
-						state->pathbuf);
+			if (rdfd < 0 &&
+			    (!state->flags.ignore_noent || errno != ENOENT)) {
+				selinux_log(SELINUX_ERROR,
+					"Could not open %s: %m.\n",
+					state->pathbuf);
+				/*
+				 * Even if we cannot open the directory for
+				 * reading, we want to relabel the directory
+				 * itself.
+				 */
+				(void) note_walk_error(state);
 			}
 		}
 
-- 
2.54.0

