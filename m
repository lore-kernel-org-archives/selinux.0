Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v299AxO5013022
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 04:10:59 -0500
Received: by mail-lf0-f68.google.com with SMTP id g70so4111060lfh.3
 for <selinux@tycho.nsa.gov>; Thu, 09 Mar 2017 01:10:57 -0800 (PST)
Received: from viper.dy.fi (dtcfm0ydyvkl2pr288xtt-3.rev.dnainternet.fi.
 [2001:14ba:8088:af00:608a:1366:3adc:e4e1])
 by smtp.gmail.com with ESMTPSA id v21sm1110290ljd.9.2017.03.09.01.10.55
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Mar 2017 01:10:55 -0800 (PST)
Sender: =?UTF-8?Q?Ville_Skytt=C3=A4?= <vskytta@gmail.com>
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Python 3.6 invalid escape sequence deprecation fixes
Date: Thu,  9 Mar 2017 11:09:35 +0200
Message-Id: <20170309090935.22458-1-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://docs.python.org/3/whatsnew/3.6.html#deprecated-python-behavior

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 python/semanage/seobject.py            | 4 ++--
 python/sepolgen/src/sepolgen/module.py | 2 +-
 python/sepolicy/sepolicy/generate.py   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index c836cc5..94bd368 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -192,8 +192,8 @@ class nulllogger:
 def validate_level(raw):
     sensitivity = "s[0-9]*"
     category = "c[0-9]*"
-    cat_range = category + "(\." + category + ")?"
-    categories = cat_range + "(\," + cat_range + ")*"
+    cat_range = category + r"(\." + category + ")?"
+    categories = cat_range + r"(\," + cat_range + ")*"
     reg = sensitivity + "(-" + sensitivity + ")?" + "(:" + categories + ")?"
     return re.search("^" + reg + "$", raw)
 
diff --git a/python/sepolgen/src/sepolgen/module.py b/python/sepolgen/src/sepolgen/module.py
index c09676a..8766dd9 100644
--- a/python/sepolgen/src/sepolgen/module.py
+++ b/python/sepolgen/src/sepolgen/module.py
@@ -40,7 +40,7 @@ from . import defaults
 def is_valid_name(modname):
     """Check that a module name is valid.
     """
-    m = re.findall("[^a-zA-Z0-9_\-\.]", modname)
+    m = re.findall(r"[^a-zA-Z0-9_\-\.]", modname)
     if len(m) == 0 and modname[0].isalpha():
         return True
     else:
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 5696110..596891a 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1329,7 +1329,7 @@ allow %s_t %s_t:%s_socket name_%s;
             self.add_dir("/var/lib/%s" % self.name)
 
         if os.path.isfile("/etc/rc.d/init.d/%s" % self.name):
-            self.set_init_script("/etc/rc\.d/init\.d/%s" % self.name)
+            self.set_init_script(r"/etc/rc\.d/init\.d/%s" % self.name)
 
         # we don't want to have subdir in the .fc policy file
         # if we already specify labeling for parent dir
-- 
2.9.3
