Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBPKjTRb003753
	for <selinux@tycho.nsa.gov>; Thu, 25 Dec 2003 15:45:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBPKiY74018025
	for <selinux@tycho.nsa.gov>; Thu, 25 Dec 2003 20:44:34 GMT
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id hBPKiXC6017929
	for <selinux@tycho.nsa.gov>; Thu, 25 Dec 2003 20:44:33 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: audit2allow script name
Date: Thu, 25 Dec 2003 21:03:27 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PK06/bpfRbVUCOF"
Message-Id: <200312252103.27414.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_PK06/bpfRbVUCOF
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the attached patch replace the old script name in the function 
printUsage with the new

Greetings

Carsten
--Boundary-00=_PK06/bpfRbVUCOF
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="audit2allow.patch"

--- audit2allow.orig	2003-10-17 19:38:03.000000000 +0200
+++ audit2allow	2003-12-25 20:59:07.000000000 +0100
@@ -147,7 +147,7 @@
 }
 
 sub printUsage {
-	print "newrules [-d] [-v] [-l] [-i <inputfile> ] [-o <outputfile>]
+	print "audit2allow [-d] [-v] [-l] [-i <inputfile> ] [-o <outputfile>]
         -d      read input from output of /bin/dmesg
         -v      verbose output
         -l      read input only after last \"load_policy\"

--Boundary-00=_PK06/bpfRbVUCOF--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
