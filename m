Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6RDQ4QC005955
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 09:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06364C0D7F01
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 13:11:18 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 27 Jul 2017 15:10:53 +0200
Message-Id: <20170727131053.7962-4-plautrba@redhat.com>
In-Reply-To: <20170727131053.7962-1-plautrba@redhat.com>
References: <20170727131053.7962-1-plautrba@redhat.com>
Subject: [PATCH 4/4] sepolicy: File labels used to be sorted in a
 man page
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 6df6f431..4d846364 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -807,6 +807,7 @@ Note: SELinux often uses regular expressions to specify labels that match multip
         self.fd.write(r"""
 .I The following file types are defined for %(domainname)s:
 """ % {'domainname': self.domainname})
+        flist.sort()
         for f in flist:
             self.fd.write("""
 
-- 
2.13.3
