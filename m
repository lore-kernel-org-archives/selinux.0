Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8FN94sU012675
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 19:09:04 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8FN8Ai1015433
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 23:08:11 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <67358AB2-DB43-4555-9E0A-77180679B0FC@nall.com>
Cc: John Wiseman <john.wiseman@L-3Com.com>
From: Joe Nall <joe@nall.com>
Subject: C++ reserved word 'class' used in selinux/avc.h with patch
Date: Fri, 15 Sep 2006 18:08:24 -0500
To: SELinux List <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

John Wiseman noticed that 'class', a reserved word in C++, is used  
in /usr/include/selinux/avc.h.

Save the following code as test.cc and compile

#include <selinux/avc.h>

int
main (int, char **)
     {
     }

results are

cc test.cc
/usr/include/selinux/avc.h:123: error: expected identifier before ‘,’  
token
/usr/include/selinux/avc.h:124: error: two or more data types in  
declaration of ‘parameter’

Fix:

--- avc.h.orig  2006-09-15 12:48:44.000000000 -0500
+++ avc.h       2006-09-15 12:49:02.000000000 -0500
@@ -120,7 +120,7 @@ extern "C" {
                 void (*func_log) (const char *fmt, ...);
                 /* store a string representation of auditdata  
(corresponding
                    to the given security class) into msgbuf. */
-               void (*func_audit) (void *auditdata, security_class_t  
class,
+               void (*func_audit) (void *auditdata, security_class_t  
cls,
                                     char *msgbuf, size_t msgbufsize);
         };



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
