Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A734CFD6
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855676; cv=none; b=Amh63xxLnf7lUVyldNjYOyZ7P+lLYpGWXD9u5CjiGtEwOHwpKsbLvxE9ymUi8VNkdj9wC3uL9Ca39MogILIqSDE4xNLFS6VbBa3mMkhRywOBYUhlkB0y6pZbop2ne2rES3AZbhWUlGIY9+0a8MmoN+re9rkMXSh4wIQYwWJ4uxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855676; c=relaxed/simple;
	bh=Y8/nEu5eyaUhBhh84mq/EV2rVi3SwZP4ejUheLHA3KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwZO2prcdNBualD1qF9CjnFPCvqdXyOtFAevxRisrmvcytbSYIHPJdn+7zf0l1pvc6g+t0zQliZ6MUi2jyjNnzeoeRx3QBHugir0QzdBYr4nxSbleVkqZ956GMN2AhxcslVS77jAON8k4f6NxdZSxxo/yslhfAhjWCI71kgSJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLFZ6GtE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLFZ6GtE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so101766196d6.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855669; x=1779460469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rODEsTD+l60EwVRkfs3QbBLWRaLaq4LaNv1J6W0Vwnk=;
        b=OLFZ6GtEcp69lsl7fZ+EE+MUANUECMCvHuf7p0nRnpyyOPmqYztETVMKPch2ArtVA3
         rDvVKTkU/yeG50CZogEIdCl1//ffqX3lPk8vUuG5Yr0r8yYxjQQP+FYJxgORoadlxurD
         vkr4ADuH1vR6XODZd1mE6Y53gNb+3iDDV0seYWJExnTMADfW+yi4FqEyjVNX9NdVcEm3
         lPfUKsBxfVCNhVJrdX+WCJVk4g7Zv8zoUSGIUoApw4gP4bI5bpcnWrtJPuIQkB42/SBs
         uGmq9oc6NI1/Qw4n+o2QrXFMhrtmGYYGyIej5TH6cL1yooymr/0U5jiaeYDeNFxGGAp7
         3vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855669; x=1779460469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rODEsTD+l60EwVRkfs3QbBLWRaLaq4LaNv1J6W0Vwnk=;
        b=aXMnetnFzu70uh7CEsQiWdJhKc/QS9GK37xgXIsQoOsKoiWpyUldUlELgXE8c64JEC
         fowMKaYLf7wqiMOvXiUFuud8wh5AW0UaOo0O7+dz2NugMJDE0CE9j7jpE8RZPpvSZDaz
         Fw0YrIc2eldEnxaTElVG7mRfMBV/X4VXn3btzhYGjVWmLmbN86jPbSlE8/4wWXPtigSx
         WK+M7yodjt0QJcxpJCHUNkWHGijzY+ZmYCDC1y205r7qUBDNOJUSxsKoLXc8Nfgo9vqD
         vMdcjrqVmmfIGRugZAxUPZQ+C2gbnSv87ILo9+lezoZmZ7N7Px+fASB8WcBQvwSxNz1q
         WvLg==
X-Gm-Message-State: AOJu0Ywz2IpitTVvWNALdo6sHFd/nfGdZw5sE9Zt8zSlwfNZAN73fgTJ
	iTG4QzoDT7iyHqC0RnxSwcgEb/BsFXHtdm/ETMNLzaGclubR8OD0aRt/GZu9pw==
X-Gm-Gg: Acq92OHIHquBXZUxyG4CnImCOAPtdoCof34CdkciLiFx2EDt9iY4Z7ht34nUiu/2fcA
	TJfo3JLBjJFNN4eJicsasml+T1Yn1pEh5/qNO4ybxi1Cwc7YIKkfHgCsg5E0wywkbNFe6SGzrVe
	W1lFtN9Hg9+73zRUK2c2qrybaWOwdH86tpIfDiOFIc0By9uujaUFfhrYqP/pjjK+Cs9YZqzThlf
	eXDw3i7+q7+kEzDeKWj0m2ihAl7Vf4W4Kmxa45VVNjTAMJI6V8i2dbKc3FEAmaE8rdS6KxcYdNH
	P5GHe3iTIiT3/2+wRW1ol/gitxU2Vp+z7NFWi2aOf3mfcKtH9wgMWeHtHn5gTKUX1z6e1fxzVxn
	C703j5uonTdezuN7mrzOZVLKZWEBv373Zsh7Umjwoxq/WlzKkGJqf4MsZJYo7J2/1Ea9W+6naur
	ZXxgr7QdAlEK9icF7rjNKnfBuE8fnEtwKeeO5oXs//7w8FLCnSLmrfp2vi48XFhlv4Y5K8TDz8U
	JpHW5p/diqp6BxP/XYkNk7fEXlXNt6PtEdknlbM9UFbdq4JEAoSq50=
X-Received: by 2002:a0c:f014:0:b0:8c7:2c4e:ec3c with SMTP id 6a1803df08f44-8ca0f6a09d0mr66239996d6.29.1778855669362;
        Fri, 15 May 2026 07:34:29 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e4besm53034566d6.2.2026.05.15.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:34:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] dbus/selinux_server.py: validate policy config value
Date: Fri, 15 May 2026 10:34:10 -0400
Message-ID: <20260515143410.13166-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perform basic validation of the policy config value; we could
further limit it to only existing subdirectories of /etc/selinux.
Also, fix up usage of p.communicate() to avoid potential pipe
deadlock issues and distinguish error messages.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 dbus/selinux_server.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index 469c526f..3da2ef30 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -6,6 +6,7 @@ from dbus.mainloop.glib import DBusGMainLoop
 from gi.repository import GObject
 from gi.repository import GLib
 import os
+import re
 import selinux
 from subprocess import Popen, PIPE, STDOUT
 
@@ -33,8 +34,7 @@ class selinux_server(dbus.service.Object):
         if not self.is_authorized(sender, "org.selinux.semanage"):
             raise dbus.exceptions.DBusException("Not authorized")
         p = Popen(["/usr/sbin/semanage", "import"], stdout=PIPE, stderr=PIPE, stdin=PIPE, universal_newlines=True)
-        p.stdin.write(buf)
-        output = p.communicate()
+        output = p.communicate(input=buf)
         if p.returncode and p.returncode != 0:
             raise dbus.exceptions.DBusException(output[1])
 
@@ -48,10 +48,9 @@ class selinux_server(dbus.service.Object):
         if not self.is_authorized(sender, "org.selinux.customized"):
             raise dbus.exceptions.DBusException("Not authorized")
         p = Popen(["/usr/sbin/semanage", "export"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
-        buf = p.stdout.read()
-        output = p.communicate()
+        buf, err = p.communicate()
         if p.returncode and p.returncode != 0:
-            raise OSError("Failed to read SELinux configuration: %s", output)
+            raise OSError("Failed to read SELinux configuration: %s" % err)
         return buf
 
     #
@@ -63,10 +62,9 @@ class selinux_server(dbus.service.Object):
         if not self.is_authorized(sender, "org.selinux.semodule_list"):
             raise dbus.exceptions.DBusException("Not authorized")
         p = Popen(["/usr/sbin/semodule", "--list=full"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
-        buf = p.stdout.read()
-        output = p.communicate()
+        buf, err = p.communicate()
         if p.returncode and p.returncode != 0:
-            raise OSError("Failed to list SELinux modules: %s", output)
+            raise OSError("Failed to list SELinux modules: %s" % err)
         return buf
 
     #
@@ -140,6 +138,8 @@ class selinux_server(dbus.service.Object):
     def change_default_policy(self, value, sender):
         if not self.is_authorized(sender, "org.selinux.change_default_policy"):
             raise dbus.exceptions.DBusException("Not authorized")
+        if not re.fullmatch(r'[A-Za-z0-9_.]+', str(value)):
+            raise ValueError("Invalid policy name: %s" % value)
         path = selinux.selinux_path() + value
         if os.path.isdir(path):
             return self.write_selinux_config(policy=value)
-- 
2.54.0

