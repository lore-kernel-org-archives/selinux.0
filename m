Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97ATlWt010494
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 06:29:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97ATk7d020136
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 10:29:46 GMT
Received: from johanna5.ux.his.no (johanna5.ux.his.no [152.94.1.25])
        by jazzband.ncsc.mil  with ESMTP id h97ATjRn020133 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 10:29:45 GMT
Received: from me (badne3.ux.his.no [152.94.1.63])
	by johanna5.ux.his.no (8.12.10/8.12.10) with SMTP id h97AThQ7006682
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 12:29:43 +0200 (MET DST)
Date: Tue, 7 Oct 2003 12:29:43 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Problems applying SELinux patch to util-linux-2.11y
Message-ID: <20031007102943.GA12671@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've just downloaded the SELinux patches for kernel 2.4, but when
patching the userland utilities, I've encountered some problems. The
patch for util-linux-2.11y _failes_ to apply clean. The rejected piece
of code is from login-utils/login.c

--- 1253,1272 ----
         sigaction(SIGINT, &sa, NULL);
       while(wait(NULL) == -1 && errno == EINTR) /**/ ;
       openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
+ #ifdef WITH_SELINUX
+        if (selinux_enabled)
+        {
+          /* We need to change the contexts of the terminal devices
back to
+             the system when the user's session ends.  */
+          security_restorelabel_tty(ttyn,ttyn_context);
+ #ifdef CHOWNVCS
+          if (consoletty(0)) {
+            security_restorelabel_tty(vcsn,vcsn_context);
+            security_restorelabel_tty(vcsan.vcsan_context);
+          }
+  #endif

Is this a known problem? Should I apply the patch against a different
version of util-linux? (I got the util-linux-2.11y source from
www.kernel.org). I tried to manually apply the rejected code, and I
placed the it ca. around line 1250:

if (childPid) {
	...
	signal();
	signal();
	signal();
	wait();
->	<the rejected code>
	PAM_EXIT;
	exit();
}

Is that correct?


Regards,
	Erlend Aasland

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
