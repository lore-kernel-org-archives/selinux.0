Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CD320CCC
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856358; cv=none; b=UrcaQf/EyZVjpAxhxEuM77mJIJj2XuKGZq/rwbssT1VatZ+gsVuFvE5heUI3I134ND81PTR7KOKrXat5sxi9kqUUD1yldd69ic2C9bkFRTFt4obJEi4g2oVlDzYTOyGJhlUuo/kY9JobR7fBWQI7J8HdU2ddUQVUk6SWVAWtH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856358; c=relaxed/simple;
	bh=9ouuRwvYI/G4SUeAzX6gXJLS/QQIcswfdSGez6D/34A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpZYq//NEqC2b20tomuCPzdwBraeR0aOSuyjy7KJxWqCdctE7ZpIiJZA/LsvHHO3cYAVbBtmuiEpXtHV1SlhxlrmoG48dR1jhGH7TcDhKEt7hxBKu4oL4QVsXQJAo8kJu0248e7gEEd1GTcutlkrc7FlI7egem7njb2caOlOE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5sSjxCN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5sSjxCN"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso91978611cf.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778856356; x=1779461156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBs9jLGSXjgevqX7q9f/uJoctp1j7IqcUFxlQj06fBk=;
        b=W5sSjxCN1/RMpviT8VUKb4yP4bT4+vmdbRmnw+Gh9vrfVEerXKi4RxKee7PQpxlzC5
         T856zCizUAa/lDPhEsIdyC/I0hIv5S86YrclDsYmsPr4E+Nf2We+WWDhKJ5OXwf6Va/F
         4DTHACRK0pMRYuDOpB+o2RkQMcFeYGPnCvASwahGAj4/h6hiXeuc2YW70O0tw2ADmRS9
         i/eamVvwl2eSZQCtnRhJe5lWJ1X8TTqWhVfcQIt3mYlimAigI9nVkxTdZ4MVhmr1vVyx
         7we4haaiEuIwQ5uqgAvlmp1d2d880RREBtsuijxbFMXDx2/KIW3LLbv/huAEGIU5btFK
         RcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778856356; x=1779461156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBs9jLGSXjgevqX7q9f/uJoctp1j7IqcUFxlQj06fBk=;
        b=F2U70a96HUTTYMpM6wSRk1a5ELR3l0xspuHJKXY13TdwLP8GlmP627O/4PyzvA0K64
         rFet3G9i1l/wMKyNWXZAjssuxulFlVvC6pWqq6m6tzk3qMBUT8usEfwznVvtMDp66neq
         /cC45hGrLqctBYgTaAvwrKm7lei+gUJ3T053CdsIPbBQm6HSzvHSL1GcsBz5KqiWBN9U
         5nzTniBaf5C4DhKgdfkM2b2MtVxwTDB834q6bVJ5u44a0EyCfhUTrHTMBpkTHCowcRK4
         phIVKEnOdii+f/K2xeGcsQBOKBbtCUKCx4ksvW2uB1SZABA09qpM3AVvKB528fn3NHr8
         GN2A==
X-Gm-Message-State: AOJu0YyPco3RDXPGsNx9rLxXOePWDpSXDeeeqJtfCKhVf30gO1dq1CON
	Wvyocbj0ZFViDd7ms7Ir1ZOSI848ay6uw6u7lvvU5iJVlum5vN8ZTyMBWS00gw==
X-Gm-Gg: Acq92OHFTGsFlWQUFszKYQg7Uilldeqmj/WebZkU6FYMglW31erIE9DqpYfRtkXjLFc
	DJ5hMYcAcG8Dal5p8EV6xNtpzg/N8QIiZOc24L+ED0bxvxVFKQw4L3yZH9bEDA/tZmgq65HKZBQ
	HBglK1YHSIo3ZCIJ/AFYnQpNYO+nnUPlCijy0lULA/J+w1rfPqPXzpYSzF5wLNiXbaOgwRaSVGf
	LHDcVJbi6Aq6JRbwto2QTQR41g4dqSX0rMU9bM9twQ0K3GIEEGj/2Wb9mF/12+ihKXP01XEZHva
	F9HmR1zLqLOKVQNfL5+2QBS6xmVZOXvcPgWcpw6dbseHyi+VKHUvm4y1ybev0IcF+bSrI15BUjM
	BE4rhPKOIBG8G1sGgRw1t1V2sVNbZDhn7pQdxD+JXWYgDYcyb5YcYUse2l0yX/XfTo4XDroPNu5
	qEbLXLQMHRQF5Oc6u5eyoQUtgD5P0byNf3KqrrWKMBpCYyDjnawRL41EpnR44eztsxkM77QaT6M
	SDH+4/fQteUvqcvR7Asa7kB8nSsdcO23WiN7P/Dx1eiecOIl21yFSQ=
X-Received: by 2002:a05:622a:5147:b0:50d:6baa:9e8c with SMTP id d75a77b69052e-51659fbc903mr61952041cf.12.1778856355543;
        Fri, 15 May 2026 07:45:55 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456889dcsm48628271cf.2.2026.05.15.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:45:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] gui: do not load from cwd and properly quote inputs
Date: Fri, 15 May 2026 10:45:48 -0400
Message-ID: <20260515144548.13795-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gui can be called via pkexec and therefore should never trust
its cwd. The initial arguments and file names can be
user-supplied so ensure they are properly quoted.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 gui/modulesPage.py           | 5 ++++-
 gui/polgengui.py             | 6 +-----
 gui/sepolgen                 | 2 +-
 gui/system-config-selinux.py | 5 +----
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index 02b79f15..7ae5a80a 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -194,7 +194,10 @@ class modulesPage(semanagePage):
     def add(self, file):
         try:
             self.wait()
-            status, output = getstatusoutput("semodule -i %s" % file)
+            p = Popen(["semodule", "-i", file], stdout=PIPE, stderr=PIPE,
+                      universal_newlines=True)
+            out, err = p.communicate()
+            status, output = p.returncode, (out or "") + (err or "")
             self.ready()
             if status != 0:
                 self.error(output)
diff --git a/gui/polgengui.py b/gui/polgengui.py
index 9c151a11..76751e02 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -85,7 +85,6 @@ except:
 version = "1.0"
 
 sys.path.append('/usr/share/system-config-selinux')
-sys.path.append('.')
 
 # From John Hunter http://www.daa.com.au/pipermail/pygtk/2003-February/004454.html
 
@@ -98,10 +97,7 @@ def foreach(model, path, iter, selected):
 ##
 xml = Gtk.Builder()
 xml.set_translation_domain(PROGNAME)
-if os.access("polgen.ui", os.F_OK):
-    xml.add_from_file("polgen.ui")
-else:
-    xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
+xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
 
 FILE = 1
 DIR = 2
diff --git a/gui/sepolgen b/gui/sepolgen
index 2f0c1cc7..f99fd01c 100644
--- a/gui/sepolgen
+++ b/gui/sepolgen
@@ -1,2 +1,2 @@
 #!/bin/sh
-sepolicy generate $*
+exec sepolicy generate "$@"
diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
index 0b6ba4b5..694a791c 100644
--- a/gui/system-config-selinux.py
+++ b/gui/system-config-selinux.py
@@ -74,10 +74,7 @@ version = "1.0"
 ##
 xml = Gtk.Builder()
 xml.set_translation_domain(PROGNAME)
-if os.access("system-config-selinux.ui", os.F_OK):
-    xml.add_from_file("system-config-selinux.ui")
-else:
-    xml.add_from_file("/usr/share/system-config-selinux/system-config-selinux.ui")
+xml.add_from_file("/usr/share/system-config-selinux/system-config-selinux.ui")
 
 
 class childWindow:
-- 
2.54.0

