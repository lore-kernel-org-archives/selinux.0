Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06F132122
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334639; cv=none; b=sWLdoaz4AcyvjuTjaN9Rd86rGiIu+9SYgP+Pk3S3xlbmWCri28HCjXSrlgU8/ycCSxB9HUyol9dggIyLHjK1ZIo6w5x5K4p8g+s7yxZnZcVetSpTTXy783LP56DfG0qAEZUP6U/4DwVwiL0i9gJyzIkydcjH9wMQQDua3I0su8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334639; c=relaxed/simple;
	bh=4Pmu3OL7SA+E5vaYHKPd4LO8e50Jcxi6GZG1oUJ5rTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoXwMP2ELN3jqVBaaLPJs9pvouG0i6wMRdIuyBcL8oLyTysqnoIeMrTEmWqYmIz+wIVApb3Fipy+lS1x2dFvoMQWPQ9V8Kpb2zvnu7dSowkBBY5AQdNFMqjg4UK9hWdyirS7D/Q7XpmBpyRnlZw9GPFydurfDm7TKvvIbsQQmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Lc0pMHli; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Lc0pMHli"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334633;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTc6ZjtaLYYGLTKVIne/dWpoTnZPwsq/+R10hwdE4T8=;
	b=Lc0pMHlikToIHZFAmWGuLIwZ6jk6PU8J6fInATOWH4TWItus0N5dARxD5PwVdBSVzkQWxB
	A6Pty7gcnE7AMqPr118fwOfUUaK1XMhYrFbVvV7OhGWpUU2Fc4J0Q3Por9I3IijBbOaO/v
	82xZZ4Mej78DrhpL3Hab3dU9sjl6EDWUmkPNiZmv3Tbh9kgjUHTiDXdJIL4VwqFwJfJvtu
	E6oBun/m6uFXk+pdfXixZTGW0MXV0DYFegzP4QcJdGl2eTFAudJa5cKTsRUkAxleyxcAi6
	YJqqfc4y8h0HadkJcDA6zxeXmTIgPOcs8pBpK/V/MXcth8NCg/DKwhg874QXog==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 06/47] libsemanage: drop unnecessary declarations
Date: Mon, 11 Nov 2024 15:16:25 +0100
Message-ID: <20241111141706.38039-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

semanage_remove_directory() is declared in "semanage_store.h" and
semanage_rename() is defined before usage.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 57295482..08e6fc1b 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -696,8 +696,6 @@ int semanage_store_access_check(void)
 
 /********************* other I/O functions *********************/
 
-static int semanage_rename(semanage_handle_t * sh, const char *tmp, const char *dst);
-int semanage_remove_directory(const char *path);
 static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
 
 /* Callback used by scandir() to select files. */
-- 
2.45.2

