Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA3FV4UZ025008
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:31:05 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nA3FWx3X000489
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 15:33:00 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nA3FV3ei009327
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:31:03 -0500
Received: from localhost.localdomain (vpn-8-158.rdu.redhat.com [10.11.8.158])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nA3FV2j6013956
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:31:02 -0500
Message-ID: <4AF04CB6.6020806@redhat.com>
Date: Tue, 03 Nov 2009 10:31:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Small fixes for chcat in policycoreutils
Content-Type: multipart/mixed;
 boundary="------------050004030702010408010308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050004030702010408010308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

chcat can generate oserror exception so need to catch and add chcat to the Makefile.

--------------050004030702010408010308
Content-Type: text/plain;
 name="policoreutils-chcat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policoreutils-chcat.patch"

diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index d6d9069..53b65b6 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -5,7 +5,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
-all: fixfiles genhomedircon
+all: fixfiles genhomedircon chcat
 
 install: all
 	-mkdir -p $(BINDIR)
diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
index 235ad82..4038a99 100755
--- a/policycoreutils/scripts/chcat
+++ b/policycoreutils/scripts/chcat
@@ -435,6 +435,8 @@ if __name__ == '__main__':
                     continue
     except ValueError, e:
         error(e)
+    except OSError, e:
+        error(e)
     
     sys.exit(errors)
     

--------------050004030702010408010308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
