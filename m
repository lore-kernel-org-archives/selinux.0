Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA4MAVSf008649
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 17:10:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA4MA91W015226
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 22:10:09 GMT
Received: from ics09.uncc.edu (ics09.uncc.edu [152.15.42.137])
	by jazzswing.ncsc.mil  with ESMTP id hA4MA95e015223
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 22:10:09 GMT
Received: from ics09.uncc.edu (localhost [127.0.0.1])
	by localhost.uncc.edu (Postfix) with ESMTP id E88DE359BE
	for <selinux@tycho.nsa.gov>; Tue,  4 Nov 2003 17:10:23 -0500 (EST)
Received: from uncc.edu (aragorn-pc.uncc.edu [152.15.25.56])
	by ics09.uncc.edu (Postfix) with ESMTP id 3F52E359BB
	for <selinux@tycho.nsa.gov>; Tue,  4 Nov 2003 17:10:23 -0500 (EST)
Message-ID: <3FA7CF76.3080408@uncc.edu>
Date: Tue, 04 Nov 2003 17:10:30 +0100
From: Dhruv Gami <dgami@uncc.edu>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: util-linux patching
Content-Type: multipart/mixed;
 boundary="------------040803030502000207060000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040803030502000207060000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hello everyone,

thanks for the quick and helpful responses regarding libattr.  i managed 
to get that up and running. now im stuck at another problem, and need 
help with that.

i downloaded the util-linux source, and applied the patch to it using

patch -p1 < util-linux-selinux.patch

*******************
patching file login-utils/Makefile
patching file login-utils/login.c
Hunk #4 succeeded at 881 (offset -16 lines).
Hunk #5 succeeded at 1072 (offset -15 lines).
Hunk #6 succeeded at 1086 (offset -15 lines).
Hunk #7 succeeded at 1168 (offset -15 lines).
Hunk #8 FAILED at 1253.
Hunk #9 succeeded at 1285 (offset -28 lines).
1 out of 9 hunks FAILED -- saving rejects to file login-utils/login.c.rej
patching file login-utils/chfn.c
patching file login-utils/vipw.c
patching file login-utils/chsh.c
patching file login-utils/selinux_utils.h
patching file login-utils/selinux_utils.c
patching file MCONFIG
Hunk #1 succeeded at 18 with fuzz 2.
*******************


but the patch gives an error on login.c and creates a login.c.rej file 
(i'm attaching it). I tried compiling inspite of this patch error, and 
everything compiles fine without complaints, but the login program has 
not been updated. 

im trying to do this on a debian woody, for kernel selinux2.4.21. Im new 
to patching, so i might be doing something wrong at a very basic level. :)

Thanks in advance,

regards,
Gami

--------------040803030502000207060000
Content-Type: text/plain;
 name="login.c.rej"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="login.c.rej"

***************
*** 1132,1137 ****
         sigaction(SIGINT, &sa, NULL);
         while(wait(NULL) == -1 && errno == EINTR) /**/ ;
         openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
         PAM_END;
         exit(0);
      }
--- 1253,1272 ----
         sigaction(SIGINT, &sa, NULL);
         while(wait(NULL) == -1 && errno == EINTR) /**/ ;
         openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
+ #ifdef WITH_SELINUX
+        if (selinux_enabled)
+ 	 {	
+ 	   /* We need to change the contexts of the terminal devices back to
+ 	      the system when the user's session ends.  */
+ 	   security_restorelabel_tty(ttyn,ttyn_context);
+ #ifdef CHOWNVCS
+ 	   if (consoletty(0)) {
+ 	     security_restorelabel_tty(vcsn,vcsn_context);
+ 	     security_restorelabel_tty(vcsan.vcsan_context);
+ 	   }
+  #endif
+ 	 }
+  #endif
         PAM_END;
         exit(0);
      }

--------------040803030502000207060000--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
