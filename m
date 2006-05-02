Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42G5OH2004704
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:05:24 -0400
Received: from mailgw3.br.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42G5K4f015891
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:05:22 GMT
Received: from mailhub1.br.ibm.com (mailhub1 [9.18.232.109])
	by mailgw3.br.ibm.com (8.13.1/8.13.1) with ESMTP id k42G8PN42551870
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:08:25 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k42G5Amk014040
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:05:10 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11/8.13.3) with ESMTP id k42G5Agg025504
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:05:10 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: SE Linux <selinux@tycho.nsa.gov>, dwalsh@redhat.com,
        Ivan Gyurdiev <ivg2@cornell.edu>
Subject: [PATCH] Fix set* functions parameter
Date: Tue, 2 May 2006 13:04:31 -0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PM4VExsEis27MLR"
Message-Id: <200605021304.31517.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_PM4VExsEis27MLR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In general, functions in the set* family (like setcon and setfilecon) receives 
a security_context_t as a parameter. This patch includes the correspondent 
typemap for it, allowing those functions to be sucessfully called. 

--Boundary-00=_PM4VExsEis27MLR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="type_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="type_fix"

Index: selinuxswig.i
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/libselinux/src/selinuxswig.i,v
retrieving revision 1.3
diff -u -p -r1.3 selinuxswig.i
--- selinuxswig.i	4 Jan 2006 15:32:42 -0000	1.3
+++ selinuxswig.i	2 May 2006 15:22:22 -0000
@@ -30,6 +30,10 @@
 }
 %typemap(argout) security_context_t * {
 	$result = t_output_helper($result, PyString_FromString(*$1));
+} 
+
+%typemap(in) security_context_t {
+	$1 = (security_context_t)PyString_AsString($input);
 }
 
 extern int is_selinux_enabled(void);

--Boundary-00=_PM4VExsEis27MLR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
