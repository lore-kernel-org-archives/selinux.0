Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75Gc1vW006997
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 12:38:01 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2009C56497D
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 18:37:54 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 18:37:47 +0200
Message-Id: <20170805163750.1920-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170805163750.1920-1-nicolas.iooss@m4x.org>
References: <20170805163750.1920-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/6] sepolicy: fix misspelling of _ra_content_t
 suffix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When "sepolicy manpage" generates descriptions for file type, it uses a
mispelled _ra_content_t suffix for prettyprinting, which results in an
unwanted double-space on the line.

For example sepolicy manpage -d httpd_t produces:

    .EX
    .P
    .B httpd_apcupsd_cgi_ra_content_t
    .EE

    - Set files with the httpd_apcupsd_cgi_ra_content_t type, if you
    want to treat the files as httpd apcupsd cgi  read/append content.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 62158864b7cd..2d8e9ef6e862 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -956,7 +956,7 @@ def get_description(f, markup=markup):
     if f.endswith("_db_t"):
         return txt + "treat the files as %s database content." % prettyprint(f, "_db_t")
     if f.endswith("_ra_content_t"):
-        return txt + "treat the files as %s read/append content." % prettyprint(f, "_ra_conten_t")
+        return txt + "treat the files as %s read/append content." % prettyprint(f, "_ra_content_t")
     if f.endswith("_cert_t"):
         return txt + "treat the files as %s certificate data." % prettyprint(f, "_cert_t")
     if f.endswith("_key_t"):
-- 
2.13.3
