Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8F6EUNs012505
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 02:14:33 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8F6BIBs026523
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 06:11:18 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.4/8.13.4/Debian-4) with ESMTP id j8F62hW3005219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 01:02:43 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: policycoreutils: run_init blocks sigCHLD but doesn't unblock it before exec
Date: Thu, 15 Sep 2005 01:02:42 -0500
Message-ID: <87aciekgvx.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        This was reported by a Debian user trying to run munin. Since
 I forgot to unblock SIGCHLD, his causes weird errors e.g. in perl
 which apparently assumes that CHLD is not blocked on startup. (and
 thus breaks libnet-server-perl, used by munin or lrrd).

        The following patch is a simple fix.

        manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=unblock.patch
Content-Description: Patch to unblock signals in the shild process

--- orig/run_init/open_init_pty.c
+++ mod/run_init/open_init_pty.c
@@ -4,9 +4,9 @@
  * Created On       : Fri Jan 14 10:48:28 2005
  * Created On Node  : glaurung.internal.golden-gryphon.com
  * Last Modified By : Manoj Srivastava
- * Last Modified On : Thu Jan 20 23:50:04 2005
+ * Last Modified On : Thu Sep 15 00:57:00 2005
  * Last Machine Used: glaurung.internal.golden-gryphon.com
- * Update Count     : 89
+ * Update Count     : 92
  * Status           : Unknown, Use with caution!
  * HISTORY          : 
  * Description      : 
@@ -192,6 +192,14 @@
         perror("Child:");
         exit(EXIT_FAILURE);
       }
+     { /* There is no reason to block sigchild for the process we
+          shall exec here */
+       sigset_t  chld_signal_set;
+       /* release SIGCHLD */
+       sigemptyset(&chld_signal_set);        /* no signals */
+       sigaddset(&chld_signal_set, SIGCHLD); /* Add sig child  */
+       sigprocmask(SIG_UNBLOCK, &chld_signal_set, NULL); /* Unblock the signal */
+     }
 
      if ( execvp(argv[1], argv + 1) ) {
        perror("Exec:");




--=-=-=


-- 
Prediction is very difficult, especially of the future. Niels Bohr
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
