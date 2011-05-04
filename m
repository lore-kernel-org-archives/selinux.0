Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p44CCXnS021622
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 08:12:33 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p44CCW65001551
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 12:12:32 GMT
In-Reply-To: <20110428200218.GB9186@hallyn.com>
References: <20110428200218.GB9186@hallyn.com> <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
To: Serge Hallyn <serge.hallyn@canonical.com>
Cc: dhowells@redhat.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during exec
Date: Wed, 04 May 2011 13:12:26 +0100
Message-ID: <2560.1304511146@redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge Hallyn <serge.hallyn@canonical.com> wrote:

> Have you run LTP

Okay...  I've now run LTP with the patched (1st May) and unpatched (4th May)
kernel (attached is the diff between the logs).

Note that I forgot to load all the modules for the unpatched test, so that may
affect things.

I added fork13 to the skipfile for the second test as it doesn't seem to test
anything relevant to the matter at hand, but takes hours to complete.

Some tests failed with the patches removed but succeeded with the patches
applied, so I think I need to rerun LTP against the patched kernel with no
modules loaded for consistency.

So:

 (*) fstatfs02 and fstatfs02_64 failed in the unpatched kernel.

 (*) sched_getaffinity01 and proc01 failed in the patched kernel.

 (*) su01 failed in both kernels, but differently.

 (*) fork13 takes ages so is now skipped.

 (*) pidns05 appears to be a broken test.

David
---
--- results/LTP_RUN_ON-2011_May_01-12h_13m_07s.log	2011-05-02 20:10:58.000000000 +0100
+++ results/LTP_RUN_ON-2011_May_04-00h_50m_25s.log	2011-05-04 10:45:58.000000000 +0100
@@ -1,4 +1,4 @@
-Test Start Time: Sun May  1 12:13:07 2011
+Test Start Time: Wed May  4 00:50:27 2011
 -----------------------------------------
 Testcase                       Result     Exit Value
 --------                       ------     ----------
@@ -226,7 +226,6 @@
 fork09                         PASS       0    
 fork10                         PASS       0    
 fork11                         PASS       0    
-fork13                         PASS       0    
 fpathconf01                    PASS       0    
 fstat01                        PASS       0    
 fstat01_64                     PASS       0    
@@ -242,8 +241,8 @@
 fstatat01_64                   PASS       0    
 fstatfs01                      PASS       0    
 fstatfs01_64                   PASS       0    
-fstatfs02                      PASS       0    
-fstatfs02_64                   PASS       0    
+fstatfs02                      FAIL       1    
+fstatfs02_64                   FAIL       1    
 fsync01                        PASS       0    
 fsync02                        PASS       0    
 fsync03                        PASS       0    
@@ -639,7 +638,7 @@
 sched_setscheduler01           PASS       0    
 sched_setscheduler02           PASS       0    
 sched_yield01                  PASS       0    
-sched_getaffinity01            FAIL       1    
+sched_getaffinity01            PASS       0    
 select01                       PASS       0    
 select02                       PASS       0    
 select03                       PASS       0    
@@ -1025,7 +1024,7 @@
 lftest01                       PASS       0    
 writetest01                    PASS       0    
 fs_di                          PASS       0    
-proc01                         FAIL       2    
+proc01                         PASS       0    
 fs_racer                       PASS       0    
 quota_remount_test01           FAIL       2    
 fs_perms01                     PASS       0    
@@ -1204,7 +1203,7 @@
 Cap_bounds                     PASS       0    
 FCNTL_LOCKTESTS                PASS       0    
 Connectors                     PASS       0    
-su01                           FAIL       126  
+su01                           FAIL       1    
 cron02                         PASS       0    
 cron_deny01                    PASS       0    
 cron_allow01                   PASS       0    
@@ -1273,7 +1272,7 @@
 ht_interrupt                   PASS       0    
 
 -----------------------------------------------
-Total Tests: 1272
+Total Tests: 1271
 Total Failures: 51
 Kernel Version: 2.6.39-rc5-fsdevel+
 Machine Architecture: x86_64

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
