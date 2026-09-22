Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46437372ECB
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093889; cv=none; b=IdCojYI6g8HmysAUeJNNg1r2bEEqM+170UMEut6NLxJoe7Eq1tjoGx0cJjV9gX4FFF97HFNcMQK/h1d/MtqHMIytCnBbkz5l75wGyzGsXfuZh7cQawpv28dHCH4ArE9JlqeZZ8+kbYp12cG20BLqBztfHu2wB0zyqmKDn08c51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093889; c=relaxed/simple;
	bh=zapWW/x2ABWg0EC/K+4wxaN43Go4miWIxPkoZyvZ/yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddXjqlwoHE+5n/73cebN96+s5HLezMGlG4wTGSkQebDH/6EiWnVNqIAemOVHOl3gcOk6zSiKxjS9rKTtf9Do8GKkAF4S5sP+p2TO7oc5j8K0XFYSafYSd/ch18b4YV8El8JfbBPQ7sswRkBpO8k+MmIEcrDnnTFWgfHvppbjHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOy3mmAN; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOy3mmAN"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76c9deeso722631cf.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093887; x=1790698687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rHeeQ/MVZXwCxym/6IhKXGSHO45EuKtkhOsSyDDNN5o=;
        b=iOy3mmANYwWQJ+IAebbAEGN1e0bEOlALa74HG0nEKqB3OfLOIUGOIEGf3zdKnpB1rn
         wPQhPcIBZmDVyT0ZiqEqitfTjHa2a52K3Q5lRW3xt2+RTI0JyGxi2XvpyLNlDa9Y1XOo
         uiFHvcbmzMLyyksVYhoCibMOVhCLtUnqndlKz+M1ETCSBCiwv5cTKGEJ12AUdx41Iky8
         F2Dvp3perzQ/9r/nZVjHeET4d3BtPsIIae5mK9ImVOf+THl69H/5iu0alRp0Dmu3hxMR
         eVh3o2VBZMp8R3AZo8pGQ+N75xsGOxDWqGjNV1xMdHltppRSfeMYzKT0nryFjD+iPTlZ
         P9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093887; x=1790698687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rHeeQ/MVZXwCxym/6IhKXGSHO45EuKtkhOsSyDDNN5o=;
        b=gW8TF/YiXhFH1D9f/FR0DpqYwVHS0mSQjp1TU5MH+O1FGb0yZKUYNK2Bkn3rcPAB20
         POcCkK7qXyQvULrYmbOvAo1F+Lvwac8mpdrd4VlxKl/SZD6/vBJiogdIqGQU2pdhrXPV
         zs8sHW/7w2oBP6FL18t21jLfu0L/jW+VsZITpCRKZL27SW1h3PdA/qHHWT35iIF8V+cG
         WISnlscSoGkQuMWYD5IHPvrRkbF2u6SrAnuywmfw4NAS58Wt3L1voTocNifV8dF9oH7G
         Gdx8Ed29oGjkAS2QH+bw9/wvmtZW6686gqkd8cjS2lAswkuCb2GSBlbE/Et/0CcHq1o1
         G56g==
X-Gm-Message-State: AFuF++ldLBbFCDiHpm8l2QJch5ExmdazZby1AdllT1aBR4NH/YWuHq1j
	oWhOx1HFreiFUzqmLquVg3vfonLGvZeBwORHjn1I5b1U9SxjKzKw8RvN1VgM8w==
X-Gm-Gg: AYBFou09UdCOsVX/ncm+iUoUkroDE7Vvya1TGNDcxCQm0TFL4Hu+/Kw/Kvn3ZXjxDyH
	vKLKnNiFYD4n9RnOTGF3UZAZaaq4hMIGSJukhj1+0s7ow0P8flZ6x1CUX7b5aTg9bi9pqLYUOMm
	yC6sTVIdtBwRJOZPwBc2Wgo9ODnwdUvQp+w3l3uV3/poIYijHLCOBl36XaFkzD4K4k8mB0omYYG
	R/N98xnAz0Uqs6tEyvSd/SlR+SP9zI9EAgp+FY6FKdXdZSsqk/ZvdPjRL1Xdy8H+GtariODEhmc
	YUhWrAJoddXhZjrMIo5W095dMYyAvFHV3UKNDajeOqVeB3FdytzKG5nVBBZOpRf8iZdZmmwQNYi
	PxYRD/SIBOL3t8XG9j+hikqEMM9LenfTsTp8I1lnYDHVrTwqh/9YjBRMX3UokH3jsrxZfrgx366
	Lq8Q17esat1AfsdKsfOErdKyN9DXsuq2bQ8r0zr5lDBSpg9msBgYSP8AHAuguL5yqxMjVXlBVqK
	lxzwTygRXiNZogtHSrUDBs+dUMHfvKWrooaL+M8Mt49a0P6UQkvHMztCrj46t+GK7QlDcfmU/lJ
	8sbvyOzCoA==
X-Received: by 2002:a05:622a:411a:b0:52f:f73c:3269 with SMTP id d75a77b69052e-532ead1e0c5mr1374181cf.36.1790093886869;
        Tue, 22 Sep 2026 09:18:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb1e01a1sm113461cf.9.2026.09.22.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:18:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] restorecond: search fallback configuration roots for the watch lists
Date: Tue, 22 Sep 2026 12:17:38 -0400
Message-ID: <20260922161738.47551-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Search the fallback configuration roots for the restorecond.conf and
restorecond_user.conf configuration files. Resolve both at startup so
the resolved path is used for both the initial read and the inotify
watch. A path given with -f is used as-is. If the primary location is
later created, restarting the daemon picks it up, matching the
resolve-once behavior of the other stateless consumers.

These files live directly under /etc/selinux/ rather than under the
active policy root, so the libselinux selinux_policy_open() search
does not apply and a local list is used, mirroring
semanage_conf_path() in libsemanage. The list can be overridden at
build time via RESTORECOND_CONFDIRS.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/restorecond.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 6548634d..495bf197 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -65,8 +65,32 @@
 const char *homedir;
 static int master_fd = -1;
 
-static const char *server_watch_file = "/etc/selinux/restorecond.conf";
-static const char *user_watch_file = "/etc/selinux/restorecond_user.conf";
+#ifndef RESTORECOND_CONFDIRS
+#define RESTORECOND_CONFDIRS "/etc/selinux/", "/usr/lib/selinux/"
+#endif
+
+static const char *resolve_watch_file(const char *name, char *out, size_t len)
+{
+	static const char *dirs[] = { RESTORECOND_CONFDIRS, NULL };
+	unsigned int i;
+
+	for (i = 0; dirs[i]; i++) {
+		snprintf(out, len, "%s%s", dirs[i], name);
+		if (access(out, R_OK) == 0)
+			return out;
+	}
+	/*
+	 * Nothing found: return the primary path so the eventual open()
+	 * error names the location an administrator would create.
+	 */
+	snprintf(out, len, "%s%s", dirs[0], name);
+	return out;
+}
+
+static char server_watch_path[PATH_MAX];
+static char user_watch_path[PATH_MAX];
+static const char *server_watch_file;
+static const char *user_watch_file;
 static const char *watch_file;
 struct restore_opts r_opts;
 
@@ -152,6 +176,13 @@ int main(int argc, char **argv)
 	if (is_selinux_enabled() != 1)
 		return 0;
 
+	server_watch_file = resolve_watch_file("restorecond.conf",
+					       server_watch_path,
+					       sizeof(server_watch_path));
+
+	user_watch_file = resolve_watch_file("restorecond_user.conf",
+					     user_watch_path,
+					     sizeof(user_watch_path));
 	watch_file = server_watch_file;
 
 	/* Set all options to zero/NULL except for ignore_noent, digest, and skip_multilink. */
-- 
2.55.0

