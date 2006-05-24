Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4OF5iYS009853
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 11:05:44 -0400
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4OF5hkk014139
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 15:05:44 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4OF5gUI024850
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 11:05:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4OF5cGa178022
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 09:05:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4OF5cME031181
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 09:05:38 -0600
Received: from sergelap.hallyn.com (sig-9-49-163-249.mts.ibm.com [9.49.163.249])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4OF5c64031134
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 09:05:38 -0600
Date: Wed, 24 May 2006 10:05:37 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: libsetrans: ___tls_get_addr
Message-ID: <20060524150537.GB16189@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

compiling libselinux/src/libsetrans.c was failing on my gentoo laptop,
with a few warnings about ___tls_get_addr being undefined.  The
following patch lets it compile, though I suspect it messes something
up :)

What would be the right way to fix this?  Am I just supposed to
'emerge tls'?

thanks,
-serge

--- libselinux/src/setrans_client.c.orig2	2006-05-24 09:54:22.000000000 -0500
+++ libselinux/src/setrans_client.c	2006-05-24 09:54:34.000000000 -0500
@@ -17,10 +17,10 @@
 #include "setrans_internal.h"
 
 // Simple cache
-static	__thread security_context_t prev_t2r_trans=NULL;
-static	__thread security_context_t prev_t2r_raw=NULL;
-static	__thread security_context_t prev_r2t_trans=NULL;
-static	__thread security_context_t prev_r2t_raw=NULL;
+static	security_context_t prev_t2r_trans=NULL;
+static	security_context_t prev_t2r_raw=NULL;
+static	security_context_t prev_r2t_trans=NULL;
+static	security_context_t prev_r2t_raw=NULL;
 
 int cache_trans hidden = 1;
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
