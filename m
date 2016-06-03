Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u530JLxL029374
 for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2016 20:19:21 -0400
Received: by mail-qg0-f48.google.com with SMTP id q32so4618793qgq.3
 for <selinux@tycho.nsa.gov>; Thu, 02 Jun 2016 17:19:20 -0700 (PDT)
From: Joshua Brindle <brindle@quarksecurity.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH] Modify audit2why analyze function to use loaded policy
Date: Thu,  2 Jun 2016 20:19:12 -0400
Message-Id: <1464913152-28265-1-git-send-email-brindle@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Class and perms should come from the policy being used for analysis,
not the system policy so use sepol_ interfaces

Change-Id: Ia0590ed2514249fd98810a8d4fe87f8bf5280561
---
 libselinux/src/audit2why.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 12745b3..abe1701 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -343,8 +343,8 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 	if (rc < 0)
 		RETURN(BADTCON)
 
-	tclass = string_to_security_class(tclassstr);
-	if (!tclass)
+	rc = sepol_string_to_security_class(tclassstr, &tclass);
+	if (rc < 0)
 		RETURN(BADTCLASS)
 
 	/* Convert the permission list to an AV. */
@@ -365,8 +365,8 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 		permstr = PyString_AsString( strObj );
 #endif
 		
-		perm = string_to_av_perm(tclass, permstr);
-		if (!perm)
+		rc = sepol_string_to_av_perm(tclass, permstr, &perm);
+		if (rc < 0)
 			RETURN(BADPERM)
 
 		av |= perm;
-- 
2.1.0
