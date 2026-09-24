Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A04C77A0
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271286; cv=none; b=ldQGmdvBo80BzMo1XiuRr0F+FffoIzCfuIhEgLGK+RhSgGFqYEQm9xfiUwH6SogCvTTaBFGh+/z7Ulj42YdsIZiWI6f2kzJ5IGyO3VQJ3KlWMDM5T8qKHww4QVUSnxDODYdjei9Az19EIAV43y3Erf5ZluaDznbEpu89O1EUaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271286; c=relaxed/simple;
	bh=dqAPbAu5YYXnxDGbJPj44ExmiJL39OCHoQwqIn177ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amo6OdvKRmZm3zt8DmluJjsohPBQPNJJ9QldWZgOQoLqajKljSlzFVQv0km60FQBfNrY5JoDSmHQQbmtII9+uX54oeperMfGwTRnKlTfgWTeQOIUm2STq7FuZLG5kb3exV5CLm/UGeD0V42symG0RGvWU2oKiWyLLel8vNJQ9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSVC3/Zm; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSVC3/Zm"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe57a3bso1059606d6.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271283; x=1790876083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+vB+w0xaNKDi4gqp3lJrF3iMSxDyWrAGstqUBereUk=;
        b=eSVC3/Zm7NcTQYo5cY7frkZ7WLDeYc4wptfp85S/l8fPl6yQ2gi7q/N03Xh0MULfTR
         SjW69v7NjayQz3wUNBnNPZzMycve1Wype3Cj9GIXMXUSvsquArA+8FKMlcrSCE6NkWqG
         zvg9oLqUOeB6+miLm8sn40mL3nx4FXEhrWas5kix79tMHCb9qEPqcqbrerA0C4GKbOxA
         P973vJ43gPfB96KWRG0h0AD9fAJKX2FSSfNlGWfKqmV1TLb0ZKX8ySWAL3CaiPJ+1HJE
         lbeewvq8+bfQY6TyYoLD2yHCB7CbBJcA0zG9aIBBajHBP4V8rv8dDstps0/HyYJwShLW
         K7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271283; x=1790876083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+vB+w0xaNKDi4gqp3lJrF3iMSxDyWrAGstqUBereUk=;
        b=TxMMC7kcD6DuormFX+U0jChrny9W7eym3HmGqqobJgq10iu/B6ewjqlhqbt3SZ6yrZ
         KDYSDM99J7Agxhhnwfh8NvyZHtDvCDf4ZYBvaq/VHl0xbXHGmOh7hcA/PF7B2E6uS0hB
         uF301IMou3nGFvJOJcbzA6IIa+hMb7y/4AvXgKTTChOemt/2aOXuai7k746l0pi+tr54
         asDKqzjGAK/Ac2NdJieES/ZBGsVzgnanbVBzGFZVZOxG3iiMROvrYzpKFCZbrc8XLebQ
         FuNrg8lXWXswCz0FTNT72VQZvVJzUx49wmhUrv1Bs323BehtR4XiqS9FEoGkB3uQbTEQ
         w0Lw==
X-Gm-Message-State: AFuF++mCz35GPFhutP/t0gIkIuIY7Ec1DdSzBSL4F8xSOB2lnFm+coKO
	/+McXU71nhXswNhnifiEXfmdK8DT7vtwdLZjjRl6WqakPpaMXAa5fQrVUOTV4g==
X-Gm-Gg: AYBFou2WKX0ukP5OKimK9scsJ52RjfM2zRr6ePCPK0PPJW1MtumSRXLXARsmAJPcFpw
	EFdmhxP8louozcKWYxamo5fzJg/ohUtcwHfscIoLjDIgBfQAa3jfkgRm23BmVOP8SSgGVp/40JS
	bA4+m4K9npcQ9L3Cqx86ULz2JeGUBJO6GDhiY90wpNS/TYxdLZ6MLRP9fXcy6sK/5TYXaHVcGxM
	xoKeyP57cBBv3GUgbMaLSSAf1zEUnaKYCQVkZ0EX2Zb/vVW2J6sxLVid1sGnbn782ztErKIHWij
	VS8eiD14cWu0Wk+6c+ReuxH5tc++01nsO/R69H6MFF0bdAFqhEbRYoKW/rHeIDkaDjCpRSTvd3V
	4WDcMJS5vrQxcoZ80IYNhiKvPc/Vnhu4Zn5sz6J/7Nbbao4mIP3wtF5QlQ+e/03BE10w67320Du
	3jBTpvzWhNN9+TzQiz6WJVGYlCq089aEjd3p2IjTNoyE1SEO7Gyrl/BXh/d4lhhnqahOFSvdG4D
	mXI67KElY9NvUDU3/XORLVLZV/PPimQ3MRQ6s3s0Sa8HNcsk7IqjBbmMe6tEso+oFiKLLzTK88X
	204nIqfEMqc=
X-Received: by 2002:a05:6214:4282:b0:910:3453:8f28 with SMTP id 6a1803df08f44-91421dcac4dmr32083666d6.36.1790271282986;
        Thu, 24 Sep 2026 10:34:42 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e21995fsm21511576d6.10.2026.09.24.10.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:34:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] python: read policy configuration files via selinux.policy_open()
Date: Thu, 24 Sep 2026 13:34:22 -0400
Message-ID: <20260924173422.65885-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924173422.65885-1-stephen.smalley.work@gmail.com>
References: <20260924173422.65885-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the direct open() reads of files under selinux_policy_root() in
chcat, semanage, and sepolicy over to selinux.policy_open(), so that a
distribution shipping policy configuration under a fallback root such
as /usr/lib/selinux/<type> (with only local overrides in
/etc/selinux/<type>) is handled the same way as by the C users of
selinux_policy_open()/selinux_policy_fopen().

policy_open() raises the same OSError subclasses as open() on failure,
so the existing except IOError/OSError handlers are unchanged. The
file_contexts.subs write path in seobject.commit is left as-is; writes
always go to the primary root.

/etc/selinux/sepolgen.conf and the /etc/selinux/ directory listing in
gui/statusPage.py are top-level (not under the policy root) and so are
not covered by selinux_policy_open(); they are left for a separate
change.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/chcat/chcat                   |  2 +-
 python/semanage/seobject.py          |  4 ++--
 python/sepolicy/sepolicy/__init__.py | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/python/chcat/chcat b/python/chcat/chcat
index c4f59229..5a9e94fb 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -365,7 +365,7 @@ def usage():
 
 
 def listcats():
-    fd = open(selinux.selinux_translations_path())
+    fd = selinux.policy_open(selinux.selinux_translations_path())
     for l in fd.read().split("\n"):
         if l.startswith("#"):
             continue
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index b790597d..61a1a501 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2373,7 +2373,7 @@ class fcontextRecords(semanageRecords):
         self.equiv_dist = {}
         self.equal_ind = False
         try:
-            fd = open(selinux.selinux_file_context_subs_path(), "r")
+            fd = selinux.policy_open(selinux.selinux_file_context_subs_path())
             for i in fd.readlines():
                 i = i.strip()
                 if len(i) == 0:
@@ -2386,7 +2386,7 @@ class fcontextRecords(semanageRecords):
         except IOError:
             pass
         try:
-            fd = open(selinux.selinux_file_context_subs_dist_path(), "r")
+            fd = selinux.policy_open(selinux.selinux_file_context_subs_dist_path())
             for i in fd.readlines():
                 i = i.strip()
                 if len(i) == 0:
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 3b87a869..bb241121 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -589,7 +589,7 @@ def find_entrypoint_path(exe, exclude_list=[]):
 
 def read_file_equiv(edict, fc_path, modify):
     try:
-        with open(fc_path, "r") as fd:
+        with selinux.policy_open(fc_path) as fd:
             for e in fd:
                 f = e.split()
                 if f and not f[0].startswith('#'):
@@ -624,7 +624,7 @@ def get_local_file_paths(fc_path=selinux.selinux_file_context_path()):
         return local_files
     local_files = []
     try:
-        with open(fc_path + ".local", "r") as fd:
+        with selinux.policy_open(fc_path + ".local") as fd:
             fc = fd.readlines()
     except OSError as e:
         if e.errno != errno.ENOENT:
@@ -650,15 +650,15 @@ def get_fcdict(fc_path=selinux.selinux_file_context_path()):
     global fcdict
     if fcdict:
         return fcdict
-    fd = open(fc_path, "r")
+    fd = selinux.policy_open(fc_path)
     fc = fd.readlines()
     fd.close()
-    fd = open(fc_path + ".homedirs", "r")
+    fd = selinux.policy_open(fc_path + ".homedirs")
     fc += fd.readlines()
     fd.close()
     fcdict = {}
     try:
-        with open(fc_path + ".local", "r") as fd:
+        with selinux.policy_open(fc_path + ".local") as fd:
             fc += fd.readlines()
     except OSError as e:
         if e.errno != errno.ENOENT:
@@ -957,7 +957,7 @@ def get_login_mappings():
     if login_mappings:
         return login_mappings
 
-    fd = open(selinux.selinux_usersconf_path(), "r")
+    fd = selinux.policy_open(selinux.selinux_usersconf_path())
     buf = fd.read()
     fd.close()
     login_mappings = []
-- 
2.55.0

