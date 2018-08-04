Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w749CH8f017436
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 05:12:18 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 53BE056064D
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 11:12:06 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 11:11:47 +0200
Message-Id: <20180804091147.19092-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] python/semanage: fix Python syntax of catching
 several exceptions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"except OSError, ImportError:" does not perform what it says: it is the
Python 2 syntax of catching OSError exceptions as "ImportError" (like
"except OSError, e:"), and this is indeed caught by Python3:

      File "./python/semanage/seobject.py", line 143
        except OSError, ImportError:
                      ^
    SyntaxError: invalid syntax

The correct syntax consists in using parentheses.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
For the record, I found this while playing with flake8 Python's linter.
I am currently working on upstreaming a script which would run this on
our Travis-CI environment in order to catch Python syntax errors before
they are introduced.

 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 78ffb091ad2f..c14671855049 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -140,7 +140,7 @@ try:
 
             self.log_list = []
             self.log_change_list = []
-except OSError, ImportError:
+except (OSError, ImportError):
     class logger:
 
         def __init__(self):
-- 
2.18.0
