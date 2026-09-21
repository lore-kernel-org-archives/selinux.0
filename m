Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AD3B774B
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020442; cv=none; b=GD1rDmRR2/wCT1fo6jjMF+3ALZQwgpKOQeqnpbLFdd6aNWjE4fgiezOLF1x04Pm6wC85ZU2NhW2XyFCAn7dQSqoyBbIncCIVwx/dmcOucubZ+KVj8KMf/ryWPhrnWcV1Pg0bixCU0ibxWcqg3Br5Scy7IBH25HhJwRIsiNBBLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020442; c=relaxed/simple;
	bh=k1Zfr0Yf9x/MUJJ41xLIOQHPBgKylPAhbgkM8C7J05Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1bE0DYtzYfDZJEG/WSvOe7w59cGmZQJ7YQRe9wKyoYJCFV9gcNrCbQZ1uD6aTrCglNWGwq39eh+ZL6Ad1XXcsQuTshCh9PdSoXtdETq64iX99ZpyN5w/z+yhxvOlLAcoxtv6IeOoOXef2N+vCX8wR7OMJbqM0oWWRG/hitcKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgXruYxX; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgXruYxX"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910531ea7feso32252026d6.0
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020440; x=1790625240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TfKuVsCU3m846hsf59kn5E332RJRGX8DvZ9ZY3UhDMA=;
        b=HgXruYxXC+EZbe4+Zwd7YPkmuXBuR1WSKn88Y5TmwlsgesRITR56xV5R4ao5uvXJH3
         i90Fth8qPNxSXt72rHT9imGaCXj25O0UKy0MIIAIIDtxKwL8vVb2s6bcFQN2O77o6K91
         fdwJtvnaYzo+9/xWVGhXNioexZkaJiMGA/UyM1s//ygevNBvVWcmJTY7z13F0szAgva6
         eWF00JFikATNb66Dmij/kVYj72RkAMyRMdqmbI9Zt7gcBFWhrDgFdaqi6ciH5teLJcqv
         d8tjDWXhmQAr8Jz/mx1jH6BJI/pksNGg+kCUlhBQJ9OTJfW0FLbJCJ3vBxjNDca4NAxd
         /RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020440; x=1790625240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TfKuVsCU3m846hsf59kn5E332RJRGX8DvZ9ZY3UhDMA=;
        b=Oa4yaTjlI9X2v336KMEnBHrvehttE3DJCWSlMQazXyRacTkquLAZ39558RpUMkOWlZ
         OprnoJBFsO1TI6JaRvcv3ZNKgPR2hUpI4pRz4vtqIHaCUrLmlRuyHhhFPc7olxoEIA35
         0oK2UExf25XIgD7alMJtXTSxx48i0vIX38EG5kvFtkkGPHf/uZvJQxrjg/aQ5eM4wyVe
         udhahrHwk7bLv2TdFwyFZqBfUC8kFmQ8U9JyF3FV1020uwX22rR79Hm88ejTMrvQJbKh
         T3xtoy5wJvavAK5GwIuiUfaLRlg3Ooi3zcZ8vaHYUMOeT/zYR4YFqe887I9dN59pVykM
         KJ4g==
X-Gm-Message-State: AFuF++mnsH9xEREEPq5g7jNAuVsgfKjsRQ143JpsjzGJpP4exf+xRlgz
	xm5suUXOpfZREaWVOAF/eeLoeKAoI4B6HfAGuWNjPJmM8G3rd5uhUv70HDihtg==
X-Gm-Gg: AYBFou31StoXPO1mpzd8uATZ1o3dAkVzzvSxhztqWWNendNhek13yR7yuanP7F2EyZr
	Cjnu3BwGW4Bdoq3W8guez0UF094PUJSL+x6zoy9d4D7mfdPBz2Vzxo/iNZ5jHuCgeMjF1kkncGd
	R6RWN6EeKyN5sSfWeWfWkO46SDIRycG0X9/bO3Ra/gQmJEDhHhmaAjgf7n35RZD53Bu2CzBanDh
	RVzHUHQfKBH/G5Rd3t7ZyCaI9nrhLhAYE1t3b4Ym7VhlISVYwiSUlqr/Qz0g5lRWmBsInCyNvvK
	6S5ahT79Aa66239/n5yr4PqnXXu/XqOE6Xc82C2lTsXhspC6DYN9I3qtx+hHBs5HhcNxvt8jeDq
	jdv1dlHD1Agbgrk+34FUmRYOMy1ruOXnJ1vBCwmmBLlc20yGtYfGbFd+8ajGTP8jZizIczUBwlE
	8NAO7vsh3Jp7Jj2Lrn2Fm+prILDdtBE/o/MExsXkL60viXYp5LxtRIkkNb1vkhrB7vCuWyRJQ7d
	RiIPNvJ1ZGzQKdTF0afqrIqlnQZ+pcLbqUECrgxtpE64fWwLcfnT8VvWgzzrWbHMRuvvS6kPFBB
	QBd6qjU78g==
X-Received: by 2002:ad4:5c44:0:b0:910:44f2:5ce3 with SMTP id 6a1803df08f44-913fc89c785mr22467996d6.8.1790020439733;
        Mon, 21 Sep 2026 12:53:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a8a0c0sm74709906d6.36.2026.09.21.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:53:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/5] checkpolicy: preserve policy type when reading a binary module
Date: Mon, 21 Sep 2026 15:53:39 -0400
Message-ID: <20260921195341.25227-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
References: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkmodule -b reads either a base or a non-base module, and
policydb_read() records which one in
p->policy_type. write_binary_policy() then overwrote that with the
getopt-derived policy_type, which defaults to POLICY_BASE and could
not be changed because -b -m was rejected. So checkmodule -b on a
non-base module silently wrote it back out with a base-module header,
and there was no way to round-trip a non-base module (e.g. to lower
its version with -c).

Drop the -b/-m incompatibility check, take policy_type from the parsed
policydb after a binary read so later code (link/expand for base only)
sees the right kind, and stop stamping it in write_binary_policy()
since both the source and binary paths now leave it correct. Skip the
module-name-vs-output-basename check on binary input; the name is
fixed by the input file rather than authored.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/checkmodule.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 2c0291e2..b1928621 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -109,12 +109,10 @@ static int read_binary_policy(policydb_t *p, const char *file,
 }
 
 static int write_binary_policy(policydb_t *p, FILE *outfp,
-			       unsigned int policy_type,
 			       unsigned int policyvers)
 {
 	struct policy_file pf;
 
-	p->policy_type = policy_type;
 	p->policyvers = policyvers;
 	p->handle_unknown = handle_unknown;
 
@@ -264,13 +262,6 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	if (binary && (policy_type != POLICY_BASE)) {
-		fprintf(stderr,
-			"%s:  -b and -m are incompatible with each other.\n",
-			argv[0]);
-		exit(1);
-	}
-
 	if (line_marker_for_allow && !cil) {
 		fprintf(stderr, "%s:  -L must be used along with -C.\n",
 			argv[0]);
@@ -293,6 +284,11 @@ int main(int argc, char **argv)
 		if (read_binary_policy(&modpolicydb, file, argv[0]) == -1) {
 			exit(1);
 		}
+		/*
+		 * Preserve the input's policy type instead of the getopt
+		 * default; -m is redundant with -b but harmless.
+		 */
+		policy_type = modpolicydb.policy_type;
 	} else {
 		if (policydb_init(&modpolicydb)) {
 			fprintf(stderr, "%s: out of memory!\n", argv[0]);
@@ -313,7 +309,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (policy_type != POLICY_BASE && outfile) {
+	if (policy_type != POLICY_BASE && outfile && !binary) {
 		char *out_name;
 		char *separator;
 		char *mod_name = modpolicydb.name;
@@ -372,7 +368,7 @@ int main(int argc, char **argv)
 
 		if (!cil) {
 			if (write_binary_policy(&modpolicydb, outfp,
-						policy_type, policyvers) != 0) {
+						policyvers) != 0) {
 				fprintf(stderr, "%s:  error writing %s\n",
 					argv[0], outfile);
 				exit(1);
-- 
2.55.0

