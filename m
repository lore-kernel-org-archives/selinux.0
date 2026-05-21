Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3863F6C53
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370855; cv=none; b=Z1/sxRaR9vg1J8Xkyd0UKLLdnlPsGU+8Rx0y+pZsZupt+ZSFwbMKsoNQ2/trgwcidEHc4jBxKf6zSbrLT0NM8UVaSbvJMe9XofJB9uSdAAETTkDwB3zduBYxBErZfHEuIvi5rqMYndc/RbbVIwfgIulFFVa19d8OQkHm+B5SU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370855; c=relaxed/simple;
	bh=GzQ0X5LIcrDFxqwVsSUa70mWIENU49FZj0Tz1LpIWgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjF65L3XYHPkakayIFTPCjwmK1YZClRO1GzcqhdSIfZTEE1Z3lmec4coSYMWkseCVPgLnt+7RKtYb5tk8ERK1l1G/H2+LCnNyLXG0FXa1Az4C9VXMGTKwobNiEQM4QyFWPGBPMtNe2ZwJ9wEwKv8XRrltYEFABqInzSqBN6L/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmxhycPz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmxhycPz"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ca12973e15so83424076d6.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779370853; x=1779975653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndmegSTdqjtESW/ThYcUsBXIk9ZZK5cU0naq+7CPbDw=;
        b=NmxhycPzI2YF4Y5xStSosvsvSUmYGDCxF5AwQyGVFf/Nf5txSlGHhp2XVYaMqVZWm7
         3uDKKB4HjoY995B+6Vs10cjb6vOaXJwvU+U4NwVZ9uL3Q6AO0CP5iao16Y2AWXDrWVCW
         1z+Zfb1lsKMDy32QVtg4ljuO/LvlG8qtopDBWKeDQ7CRXAv/iKnFkpCP7IKeEs2SkbNW
         OZBBWdFHovDlRUyiqWxI6cGXH4D7BWcTaAbP6Y+6DhafHwzEF1ANIEAERzOFK0z3TLH5
         ethdncJR1z4yF/kSCCD0joxF6mgotjmQKn9hAT2FEs2tGc5nXNzJPDONlHN/ENiFcfcU
         N5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370853; x=1779975653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndmegSTdqjtESW/ThYcUsBXIk9ZZK5cU0naq+7CPbDw=;
        b=p6MPDic4p2xUOXCYs0BdvlTCHlhNgCiHNYFfPcm51U6G5gUPvDFC+oMIpWWrqR9peB
         lL+mzs6w6A5v5XQusEUIJ7aefZL/p5gRXo59f/1x2JpAQJIUgoY7RhrmBpL4MXBhwByB
         nF3+KGrxLobTDo5qZUP37qsZEe1ikfhO0FsTUuH8JWwNJF9K2A93RbEfEgb2GPbHpfuF
         4S8HSsMqoZLv5XCaA4tTYuOTVD0kX+3S/JJz+jxfxjvA0AnPObzcPt/eRiphVr1EM6ht
         Kyn2pXwDZh2LNLv8dLbc8vin5bItxDSbghZgx/yMwYgURGSFdv7/5TrynRORnL/sMoFh
         ExRA==
X-Gm-Message-State: AOJu0YynmCqYxbR5QsRZ/vombAZGsUa0GyrWZSTUTMfV0Bp5SY5otLyy
	Z7a6boPp4Oir9reX5TphJdTLnuSa9icMcMpme781ssXEgWrwizvvvYaGtRB90A==
X-Gm-Gg: Acq92OEf+itvMyTNmQntr+LDikTtdio/E0iwgaRVeRpoWv5Y5jfzJ+16JSwh+49Za/4
	yJxRqzeZBbgxjjEi2KpaQnCwcg4wIsDJEeM9tFMj+BJSmG/6OGFSxnGFCVoaxoLOUt6Virg06Vh
	XZ/egvGkNK0IZ9U98lRbd1fXGVTm2vx0SYmrgnYl4u2HNFT/Dp01TScwQMQrMe/OHQhuPs+3YVh
	LQlpeg20XGv3UbYV2o7Mt79fUClmmIWL7zezDqP2f7al6gv8r6Mty8nvjYsYsLr+w9ZFJi+42VP
	UN1ug8bT9Y56wtY8Eqea9fFLewWmPOit+n8Im938yvWKYHi1Yy5go3zbj9MuDCcL3oiVU9USW5v
	7A+4pGhwHy9YbW1zxRcWBiCWo50F6TMOD/JmGCe2WR25CjPDiBidtVqkSKtaWEDwa3c5pje1eGH
	7MwI6wXIeOEHWQ//jXR9V2LvVxtotnFT9P+VlrDlItnOF5J9BO1gR2RkS6bLF4G4QSdd/c7Q3v0
	B0adDmqImNh9FfUgXVJnTX7GLBUIzWYBimb7ETtcGKdKQaLiPpf+5A=
X-Received: by 2002:a05:6214:4987:b0:8cc:6a81:9ec5 with SMTP id 6a1803df08f44-8cc6e21fe3fmr46937096d6.0.1779370853128;
        Thu, 21 May 2026 06:40:53 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781b428csm5027756d6.23.2026.05.21.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:40:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] restorecond: create a separate io channel callback for stdin
Date: Thu, 21 May 2026 09:40:24 -0400
Message-ID: <20260521134024.11581-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521134024.11581-1-stephen.smalley.work@gmail.com>
References: <20260521134024.11581-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

restorecond registers a single io channel callback that handles
both inotify events and stdin. This can erroneously end up
trying to interpret stdin input as an inotify event. Create
a separate callback for stdin.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/user.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/restorecond/user.c b/restorecond/user.c
index 25e70ae1..3191829f 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -169,6 +169,32 @@ io_channel_callback
   return TRUE;
 }
 
+static gboolean
+stdin_callback
+ (GIOChannel *source,
+  GIOCondition condition,
+  gpointer data __attribute__((__unused__)))
+{
+
+  char buffer[256];
+  gsize bytes_read;
+
+  if (condition & G_IO_IN) {
+    /* Data is available. */
+    while (g_io_channel_read_chars(source, buffer, sizeof (buffer),
+				    &bytes_read, NULL) == G_IO_STATUS_NORMAL
+	    && bytes_read > 0)
+	    ;
+    if (bytes_read == 0)
+	    exit(0);
+  }
+
+  if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+	  exit(0);
+
+  return TRUE;
+}
+
 int start(void) {
 #ifdef HAVE_DBUS
 	GDBusConnection *bus;
@@ -243,7 +269,7 @@ static int local_server(void) {
 	g_io_add_watch_full( in,
 			     G_PRIORITY_HIGH,
 			     G_IO_IN|G_IO_ERR|G_IO_HUP,
-			     io_channel_callback, NULL, NULL);
+			     stdin_callback, NULL, NULL);
 
 	return 0;
 }
-- 
2.54.0

