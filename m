Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QK7EaG026523
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 16:07:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id AF1031A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 22:07:24 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05X-mTgeXBVh for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 22:07:24 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 441E61A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 22:07:24 +0200 (CEST)
Date: Mon, 26 Mar 2012 22:07:21 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 7/8] setools --  Missing function prototypes
Message-ID: <20120326220721.5aac107f@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Description: Missing function prototypes
 Missing function prototypes are likely to cause setools to segfault on
 architectures where the size of a pointer is greater than the size
 of an integer, such as ia64 and amd64. This patch adds the
 prototypes, and the doxygen comments to the header file.
Author: dann frazier <dannf@debian.org>
Date: Mon, 17 Aug 2009 11:11:16 -0500
Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=541862

--- a/seaudit/toplevel.h
+++ b/seaudit/toplevel.h
@@ -155,6 +155,30 @@ apol_vector_t *toplevel_get_log_roles(to
 apol_vector_t *toplevel_get_log_types(toplevel_t * top);
 
 /**
+ * Return a vector of strings corresponding to all mls levels
+ * found within currently opened log files.  The vector will be sorted
+ * alphabetically.
+ *
+ * @param top Toplevel containing seaudit log object.
+ *
+ * @return Vector of sorted types, or NULL if no log is loaded.  The
+ * caller must call apol_vector_destroy() upon the return value.
+ */
+apol_vector_t *toplevel_get_log_mls_lvl(toplevel_t * top);
+
+/**
+ * Return a vector of strings corresponding to all mls clearance
+ * found within currently opened log files.  The vector will be sorted
+ * alphabetically.
+ *
+ * @param top Toplevel containing seaudit log object.
+ *
+ * @return Vector of sorted types, or NULL if no log is loaded.  The
+ * caller must call apol_vector_destroy() upon the return value.
+ */
+apol_vector_t *toplevel_get_log_mls_clr(toplevel_t * top);
+
+/**
  * Return a vector of strings corresponding to all mls
  * levels found within the current log file.  
  * The vector will be sorted alphabetically.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
