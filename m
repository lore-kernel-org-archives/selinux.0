Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7JInVO0023215
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 14:49:33 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D8E18561296
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 20:49:22 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 19 Aug 2018 20:48:59 +0200
Message-Id: <20180819184901.6395-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/3] libselinux: add a const to suppress a build
 warning with Python 3.7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On systems using Python 3.7, when compiling libselinux Python wrappers
(with "make install-pywrap"), the following warning is reported by gcc:

    audit2why.c: In function ‘analyze’:
    audit2why.c:364:11: warning: assignment discards ‘const’ qualifier
    from pointer target type [-Wdiscarded-qualifiers]
       permstr = _PyUnicode_AsString( strObj );
               ^

Make permstr "const char *" in order to suppress this warning.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/audit2why.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 0331fdfd8df9..5a1e69a8269b 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -354,7 +354,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 	/* iterate over items of the list, grabbing strings, and parsing
 	   for numbers */
 	for (i=0; i<numlines; i++){
-		char *permstr;
+		const char *permstr;
 
 		/* grab the string object from the next element of the list */
 		strObj = PyList_GetItem(listObj, i); /* Can't fail */
-- 
2.18.0
