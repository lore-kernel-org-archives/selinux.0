Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8UHuM4S012197
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 13:56:22 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8UHvsWi004533
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 17:57:54 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UHuKrP017323
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 13:56:20 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UHuJqw010162
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 13:56:19 -0400
Message-ID: <4AC39BC4.8020804@redhat.com>
Date: Wed, 30 Sep 2009 13:56:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: load_policy has to be moved to /sbin from /usr/sbin to handle initrd
 executing load_policy
Content-Type: multipart/mixed;
 boundary="------------000804010404050802080209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000804010404050802080209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ubunto and Fedora have moved to a model where the initrd executes load_policy -i.

This means load_policy has to be in /sbin since /usr might not be mounted.

--------------000804010404050802080209
Content-Type: text/plain;
 name="load_policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="load_policy.patch"

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 23661bf..16e3c30 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -263,7 +263,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	     calloc(1, sizeof(*(current_conf->load_policy)))) == NULL) {
 		return -1;
 	}
-	if ((conf->load_policy->path = strdup("/usr/sbin/load_policy")) == NULL) {
+	if ((conf->load_policy->path = strdup("/sbin/load_policy")) == NULL) {
 		return -1;
 	}
 	conf->load_policy->args = NULL;
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index 2dd2943..91dc6c8 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-SBINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(DESTDIR)/sbin
+USRSBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
@@ -17,6 +18,8 @@ install: all
 	install -m 755 $(TARGETS) $(SBINDIR)
 	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
 	install -m 644 load_policy.8 $(MANDIR)/man8/
+	-mkdir -p $(USRSBINDIR)
+	ln -s /sbin/load_policy $(USRSBINDIR)/load_policy
 
 clean:
 	-rm -f $(TARGETS) *.o 

--------------000804010404050802080209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
