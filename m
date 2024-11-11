Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDB1A0711
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334643; cv=none; b=XgWcJgtPew77CoyHEui/dlMCK4PuUZG6SN4fckmv3+rkERS2y3/5aNWVIFy3Zc5W7UFu96r2e9yrsSRXLDRb3Y6UDPSMT/3vAta4iyr3ntecu8TzdcJWHm9C3KW0xCY2kE0Tr26rD1Y2X+GPsfjfGiEtqG4HHwtB5JG+eOFV5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334643; c=relaxed/simple;
	bh=Hmm1SLGNV2jt8QBZ6erdSbVG6BulDJZVJWIB0HGeFN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0HJStg/AzU3uLkTdmnQksv+MNZPaDDOPzh4/pCwK1vzb6nrOPpBBz+9HSbI2mDJZEiHvHMFGh3gGsNOPY8jXuiYa61mbwGAcJpvQ4h01c3jJfNVfKcXetORrEtwkEFzdUfNzRAzMwosvPYp7dm/I1BlntFK7MWULz2NRBqbkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=h13jupHR; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="h13jupHR"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C52vXDtb/i1K8dnwT0SVVTwgGruXJ6nrdy2IKOZ6nLg=;
	b=h13jupHRGdLSKOmqLpBzD6x8ikunuqhoRLfK2L3mJWM//YOTnQAtjqtsdtEAv1aeDb47HK
	EurhMlAQ62rWoUwUmLeqMIDbuWQKkah48z+hBUK6yYLhAUZ/wCWkxFxhLdWOUZRaNAIxGY
	L0cMSKmQ08x72ItK32KhLTD9OqTfEVGrOW7tDoXzoIKjQ1l9c7DiybfEFSFvfClkT6AUKi
	aoPx3gVoRmHc8pswQKtog8NcRB875Etfq2CgZluPOsxwYiKnpRMVFr9hY8nmoeL8RpjRk6
	G3kSwMqeqBBjX0rpjx7gGORSlizeTkI7qwOhuQHu0cEvdg/Kmc6JHlvdUhSVMQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 19/47] libsemanage: avoid leak on realloc failure
Date: Mon, 11 Nov 2024 15:16:38 +0100
Message-ID: <20241111141706.38039-19-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 83addbee..66a6fa66 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -599,12 +599,16 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int
 	while ((read_len = read(fd, data_read + data_read_len, max_len - data_read_len)) > 0) {
 		data_read_len += read_len;
 		if (data_read_len == max_len) {
+			char *tmp;
+
 			max_len *= 2;
-			data_read = realloc(data_read, max_len);
-			if (data_read == NULL) {
+			tmp = realloc(data_read, max_len);
+			if (tmp == NULL) {
 				ERR(sh, "Failed to realloc, out of memory.\n");
+				free(data_read);
 				return -1;
 			}
+			data_read = tmp;
 		}
 	}
 
-- 
2.45.2

