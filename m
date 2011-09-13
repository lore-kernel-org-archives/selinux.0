Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8DNXTqQ001207
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2011 19:33:29 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8DNXRSm020210
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2011 23:33:28 GMT
Subject: [PATCH] Fix function arguments in libsemanage tests (was Re: [PATCH
 v4] Fix includes for userspace tools and libraries)
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>
Date: Wed, 14 Sep 2011 01:33:26 +0200
In-Reply-To: <1315951507.2218.91.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost> <1315951507.2218.91.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315956807.2218.98.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Another possible improvement could be as follows (libsemanag):

Fix a few calls to semanage_store_access_check() in the libsemanage
tests so that a void function is called.

--- selinux/libsemanage/tests/test_semanage_store.c	2011-09-09 20:12:56.017662440 +0200
+++ selinux-13092011-rebuild/libsemanage/tests/test_semanage_store.c	2011-09-14 01:19:05.547450022 +0200
@@ -163,7 +163,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(polpath, 0);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == -1);
 
 	/* check with permissions 500 */
@@ -174,7 +174,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(modpath, S_IRUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == SEMANAGE_CAN_READ);
 
 	/* check with permissions 700 */
@@ -185,7 +185,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == SEMANAGE_CAN_WRITE);
 
 	/* check with lock file 000 and others 500 */
@@ -196,7 +196,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(modpath, S_IRUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == 0);
 
 	/* check with lock file 000 and others 700 */
@@ -207,7 +207,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == 0);
 
 	/* remove lock file */
@@ -222,7 +222,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(polpath, 0);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == -1);
 
 	/* check with no lock file and 500 */
@@ -233,14 +233,14 @@ void test_semanage_store_access_check(vo
 	err = chmod(modpath, S_IRUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == 0);
 
 	/* check with no lock file but write in lockpath */
 	err = chmod(lockpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == SEMANAGE_CAN_READ);
 
 	/* check with no lock file and 700 */
@@ -249,7 +249,7 @@ void test_semanage_store_access_check(vo
 	err = chmod(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
-	err = semanage_store_access_check(sh);
+	err = semanage_store_access_check();
 	CU_ASSERT(err == SEMANAGE_CAN_WRITE);
 }
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
