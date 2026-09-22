Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137837E5C3
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087644; cv=none; b=W5zQskdGTn+WuMDNXyjFe1UYpNS7qXmn+SODBoB+TL5Jon7i8+rd7l0j0cV7ou5rAgT9a/hiTm6kj0INbGdulT2A7jslNuh4LFfkQKfLs5XGz4DgcrrpmvjtWSO8DE3GeD33ZRvNGnSOr77NqIWBTI2Vgm1lmzQ36E1prBsl2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087644; c=relaxed/simple;
	bh=Wp2PZLyZQGojYT4m8q4HCZdhRWNDJpbEY/FOn3vzRGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li+1h1P0sVPIi0vNeUT2DAJteENJOD0ZzlH2C/lkkcb80V//vZ4BrMKhmeVNeeObPvgjozKHPCUIVK02JJ45qwgWwyPWC9FC+gnbdqZpVa/f3/U/ooK0xfatysNQhTt7Wg36PuctGKsggd6tnyD0SG/NhObtC1RdtFBPr/aFTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4NkxdLL; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4NkxdLL"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43f9b119so40554937b3.2
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087642; x=1790692442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pp52nelnor8g3amn0cOkjJDwsNKLEjOVoyaQIbCsaA8=;
        b=H4NkxdLLTwbyZZOXMrOeGTKJVwy2kMljIv5tQZNqA5wGDyQhP+H8r7q3Kf6qmq+y8J
         9aKpr0cPUqr73WJSU+0hZMIQcww7TAv/kCDzdr8c5OU9hWNsNcZO27hSzRmBWS2W07M2
         7u63UQ+Uv6ZrJ3a+EZaSaoH0zISO801EsS0ODQyofh7KCPsLSqfg07jqw7BgF2TpQHDb
         lwBOx3MbI/xZf91PALhXTmTsfsxiGr2uscwBhSOw4wRUIroWDwwGeJi1Oc6Wt7qCcN8o
         q+zdZjL3EbfHmUipH7MtusE0LXdx5xXw3qWpzrp1ldauUOlYNJySWnBns985/7qUf07D
         GQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087642; x=1790692442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pp52nelnor8g3amn0cOkjJDwsNKLEjOVoyaQIbCsaA8=;
        b=UkxhJuvpiVmqdQ9X84UGFKdrSsoVHuOftklaC+b1WB0vBd7pAqGwsXoT1csu1J+ki4
         nht6d+HP2Odrxq1xrxWXI1GsWFoEOzG6pwdlOoRTU+zoOaG3NpUyN5nqMKOkmFPMqSDO
         DjOF1F+1VNyc1yKzJhLrs71o3Vb4rPbJMMyosQM8Fgnn6iZ5n9cXnJ71OaVxePd5wxzr
         fo/fRcfh9Ni+Lndtm3Hz6u66ntuDQPhqt2eAiHDlLTQ5MyrXvykpbxlV45dEE/L3bYg8
         vlfHKGZbvJDX0afg7nbu9c5UPA+vFkih3jG8vR/D/P6cePlUrL2qkGSC9pref1ko/0Wp
         h3mg==
X-Gm-Message-State: AFuF++lanmhhzB/akX55gafKuQGE/llMm0mXcV4YEZYNYnbd15lIDU44
	0xLLkiVpN99hBkJx62pti82Kh6VEBz674tpGp5k/5zY0s1YwVjhwwu1DTfewYQ==
X-Gm-Gg: AYBFou1YBjZMMKzM47EY99fb4HM0OPhZg6kSB326ky74w3rsE68aX87QK729bxh9itd
	VZKHTKZLJ778S38CKpMCGRG+NEiLySCTuS461AShZmtaIZyPzfhgSImMrGmROjJjmpjVPGwRN7L
	4RsY+373L0LKeeBObtoGka+nP7GUArIurYHTVIFzGsiIK7WjUezatqREX8/Ysg4sfikyZnJ7idl
	fOSixiBRNAlY5aEERJM3jVPdPBccJzf/vY79Cz7KjIq/SjKFFKe67Ynt0lLiJi43fc1/Ea36KUN
	uMOXVEy1FhXquwgct+rhmWbxDgBwt9oHY+CvcOL/duNfWSI3AIQVDDd4cKs6Nfll5pwB85zfejE
	Uo7D6Qxu2fRxcz/Ok52iTRcOkeeKyjfhFSTg6Ug/cmoNgJZEmJ6hw5m3mNbs7XASd7UnKGdg/a/
	nCtWo3qFwEigTvzqIMnC5hp+ymPigDR3/ufmvWbqQ6zOwPDMDk2BzEPaZ/1HOUVkTevzD96cBbm
	Qtb3HuMMX7GjCz6XF+vnlH7tIqbwL94wN5GBeEb/dR59oEFfSUevWPUc6ANzRgiOQCrf0h+6SCe
	i4xqPCV913k=
X-Received: by 2002:a05:690c:a689:b0:89a:63da:faaa with SMTP id 00721157ae682-89a63db0561mr28299337b3.101.1790087641640;
        Tue, 22 Sep 2026 07:34:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e1716786sm14227871cf.4.2026.09.22.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:34:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] policycoreutils/run_init: search fallback configuration roots for initrc_context
Date: Tue, 22 Sep 2026 10:33:45 -0400
Message-ID: <20260922143345.46093-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922143345.46093-1-stephen.smalley.work@gmail.com>
References: <20260922143345.46093-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly exported selinux_policy_open() so a stateless install
that ships the contexts tree under /usr/lib/selinux is found the same
way libselinux itself finds default_contexts and friends.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/run_init/run_init.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 89921b23..6c427dc5 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -302,12 +302,20 @@ static int get_init_context(char **context)
 {
 	FILE *fp;
 	char buf[255], *bufp;
-	int buf_len;
+	int buf_len, fd;
 	char context_file[PATH_MAX];
+
 	snprintf(context_file, sizeof(context_file) - 1, "%s/%s",
 		 selinux_contexts_path(), CONTEXT_FILE);
-	fp = fopen(context_file, "r");
+	fd = selinux_policy_open(context_file, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, _("Could not open file %s\n"), context_file);
+		return -1;
+	}
+
+	fp = fdopen(fd, "r");
 	if (!fp) {
+		close(fd);
 		fprintf(stderr, _("Could not open file %s\n"), context_file);
 		return -1;
 	}
-- 
2.55.0

