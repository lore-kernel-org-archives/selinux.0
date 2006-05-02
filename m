Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42G2JHl004608
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:02:19 -0400
Received: from mailgw3.br.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42G2FUP000361
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:02:17 GMT
Received: from mailhub3.br.ibm.com (mailhub3 [9.18.232.110])
	by mailgw3.br.ibm.com (8.13.1/8.13.1) with ESMTP id k42G5Ntu2715738
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:05:27 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub3.br.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k42G2724067256
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:02:08 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11/8.13.3) with ESMTP id k42G263N019879
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:02:07 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Ivan Gyurdiev <ivg2@cornell.edu>
Subject: [PATCH] Check return value of getexeccon()
Date: Tue, 2 May 2006 13:01:22 -0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TJ4VEmItm0tjTxE"
Message-Id: <200605021301.23810.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_TJ4VEmItm0tjTxE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

getexeccon() , (and probably some other), may return NULL in it's return 
argument. Currently, this is causing the interpreter to abort due to a failed 
assertion. This patch adds a test in the argout typemap to fix this.


--Boundary-00=_TJ4VEmItm0tjTxE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="value_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="value_fix"

Index: selinuxswig.i
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/libselinux/src/selinuxswig.i,v
retrieving revision 1.3
diff -u -p -r1.3 selinuxswig.i
--- selinuxswig.i	4 Jan 2006 15:32:42 -0000	1.3
+++ selinuxswig.i	2 May 2006 15:23:24 -0000
@@ -28,9 +28,14 @@
 %typemap(in, numinputs=0) security_context_t *(security_context_t temp) {
 	$1 = &temp;
 }
-%typemap(argout) security_context_t * {
-	$result = t_output_helper($result, PyString_FromString(*$1));
-}
+%typemap(argout) security_context_t * (char * temp) {
+	if (*$1)
+		temp = *$1;
+	else
+		temp = "";
+	$result = t_output_helper($result, PyString_FromString(temp));
+
+} 
 
 extern int is_selinux_enabled(void);
 extern int is_selinux_mls_enabled(void);

--Boundary-00=_TJ4VEmItm0tjTxE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
