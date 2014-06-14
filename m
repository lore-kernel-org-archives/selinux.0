Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5EGwgxY015329
 for <selinux@tycho.nsa.gov>; Sat, 14 Jun 2014 12:58:44 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so2227404wiv.14
 for <selinux@tycho.nsa.gov>; Sat, 14 Jun 2014 09:58:44 -0700 (PDT)
Received: from eversmanni.localdomain (183.222.74.86.rev.sfr.net.
 [86.74.222.183])
 by mx.google.com with ESMTPSA id r9sm3687567wia.17.2014.06.14.09.58.43
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Jun 2014 09:58:44 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsemanage: fix src/pywrap-test.py -v -F
Date: Sat, 14 Jun 2014 18:58:25 +0200
Message-Id: <1402765106-7397-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
References: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Running "libsemanage/src/pywrap-test.py -v -F" gives following error:

    Traceback (most recent call last):
      File "pywrap-test.py", line 1139, in <module>
        sys.exit(main())
      File "pywrap-test.py", line 1121, in main
        tests.run(sh)
      File "pywrap-test.py", line 107, in run
        self.test_writefcontext(handle)
      File "pywrap-test.py", line 622, in test_writefcontext
        if self.verbose: print "SEFContext type set: ", semanage.semanage_fcontext_get_type_str(fcon)
    TypeError: in method 'semanage_fcontext_get_type_str', argument 1 of type 'int'

The argument of semanage_fcontext_get_type_str is the type recorded in
fcon and not fcon itself.  This type can be retrieved with
semanage_fcontext_get_type.
---
 libsemanage/src/pywrap-test.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/pywrap-test.py b/libsemanage/src/pywrap-test.py
index d087e47..5d8aad1 100644
--- a/libsemanage/src/pywrap-test.py
+++ b/libsemanage/src/pywrap-test.py
@@ -619,7 +619,9 @@ class Tests:
 		if self.verbose: print "SEFContext expr set: ", semanage.semanage_fcontext_get_expr(fcon)
 
 		semanage.semanage_fcontext_set_type(fcon, semanage.SEMANAGE_FCONTEXT_REG)
-		if self.verbose: print "SEFContext type set: ", semanage.semanage_fcontext_get_type_str(fcon)
+		if self.verbose:
+			ftype = semanage.semanage_fcontext_get_type(fcon)
+			print "SEFContext type set: ", semanage.semanage_fcontext_get_type_str(ftype)
 
 		(status, con) = semanage.semanage_context_create(sh)
 		if status < 0:
-- 
2.0.0
