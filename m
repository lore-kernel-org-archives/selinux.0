Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6V1ncHa000627
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 21:49:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6V1mRFB024792
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 01:48:27 GMT
Received: from mvmail1.mv.cougaarsoftware.com (h-68-165-169-235.SNVACAID.covad.net [68.165.169.235])
	by jazzswing.ncsc.mil  with ESMTP id h6V1mQGD024789
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 01:48:26 GMT
From: "Michael Luu" <mluu@cougaarsoftware.com>
To: <selinux@tycho.nsa.gov>
Subject: writing a java policy file
Date: Wed, 30 Jul 2003 19:02:10 -0700
Message-ID: <003e01c35707$c0cf6230$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi all,

i'm trying set up a simple java policy whereby i only allow a specific
user (in java_r role) to run a java (type java_t)application that
communicates with a server (e.g., www.yahoo.com).  i'm making some
progress, but can't set up the te and dependent files correctly.  when i
test the policy using sepcut, i get name conflict for type java_t.  i'm
not sure what else i need to do or if these policy files are correct.
this is what i have done so far:

1. added the java_r to a user that should only have access to run java
(in the users file)

2. added the java_r in the user domain files (user.te and
user_macros.te)
   based on
http://sourceforge.net/docman/display_doc.php?docid=15285&group_id=21266
#gs8AddUserDom

3. i created a java.te file:

#DESC jvm policy
#
# File: java.te
# Author(s):
#
type java_port_t, port_type;
type java_t, domain, privowner;
allow java_t user_home_dir_type:file { read };
allow java_t user_home_dir_type:dir { getattr search };
allow java_t { java_port_t }:tcp_socket name_bind; 

4. i created a java.fc file:

#DESC jvm policy
#
# File: java.fc
# Author(s):
#
/usr/java/j2sdk.*/include       system_u:object_r:java_modules_t
/usr/java/j2sdk.*/lib           system_u:object_r:java_modules_t
/usr/java/j2sdk.*/jre           system_u:object_r:java_modules_t
/usr/java/j2sdk.*/bin           system_u:object_r:java_exec_t

thanks for you help!

mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
