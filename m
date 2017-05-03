Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfS029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F13580C06
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:12 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 13/19] sepolicy/generate.py: Fix string formatting
Date: Wed,  3 May 2017 12:30:30 +0200
Message-Id: <20170503103036.17514-14-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes python3 problem:

>>> print("Failed to retrieve rpm info for %s") % package
Failed to retrieve rpm info for %s
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for %: 'NoneType' and 'str'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/generate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 596891a4..d68f96ef 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -92,7 +92,7 @@ def get_rpm_nvr_list(package):
             nvr = get_rpm_nvr_from_header(h)
             break
     except:
-        print("Failed to retrieve rpm info for %s") % package
+        print(("Failed to retrieve rpm info for %s") % package)
         nvr = None
 
     return nvr
-- 
2.12.2
