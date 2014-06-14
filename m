Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5EGwgxZ015329
 for <selinux@tycho.nsa.gov>; Sat, 14 Jun 2014 12:58:45 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so4003525wgh.16
 for <selinux@tycho.nsa.gov>; Sat, 14 Jun 2014 09:58:46 -0700 (PDT)
Received: from eversmanni.localdomain (183.222.74.86.rev.sfr.net.
 [86.74.222.183])
 by mx.google.com with ESMTPSA id r9sm3687567wia.17.2014.06.14.09.58.45
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Jun 2014 09:58:45 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsemanage: use semanage_bool_get_value to print a
 boolean
Date: Sat, 14 Jun 2014 18:58:26 +0200
Message-Id: <1402765106-7397-3-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
References: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

... and not semanage_bool_set_value.

This fixes "python2 pywrap-test.py -v -B -C"
---
 libsemanage/src/pywrap-test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/pywrap-test.py b/libsemanage/src/pywrap-test.py
index 5d8aad1..c00d2c7 100644
--- a/libsemanage/src/pywrap-test.py
+++ b/libsemanage/src/pywrap-test.py
@@ -829,7 +829,7 @@ class Tests:
 		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(pbool)
 
 		semanage.semanage_bool_set_value(pbool, 0)
-		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_set_value(pbool)
+		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_get_value(pbool)
 
 		(status,key) = semanage.semanage_bool_key_extract(sh, pbool)
 		if status < 0:
@@ -912,7 +912,7 @@ class Tests:
 		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(abool)
 
 		semanage.semanage_bool_set_value(abool, 0)
-		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_set_value(abool)
+		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_get_value(abool)
 
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
-- 
2.0.0
