Message-ID: <47834E2C.4070303@redhat.com>
Date: Tue, 08 Jan 2008 05:19:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to install selinux python with correct permissions.
Content-Type: multipart/mixed;
 boundary="------------090302040704080608000607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090302040704080608000607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090302040704080608000607
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-2.0.46/src/Makefile
--- nsalibselinux/src/Makefile	2007-09-26 19:37:45.000000000 -0400
+++ libselinux-2.0.46/src/Makefile	2008-01-05 08:19:27.000000000 -0500
@@ -77,14 +77,14 @@
 
 install: all 
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
 	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
-	install -m 755 $(SWIGFILES) $(PYTHONLIBDIR)/site-packages
+	install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages
+	install -m 644  selinux.py $(PYTHONLIBDIR)/site-packages
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)

--------------090302040704080608000607
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkeDTisACgkQrlYvE4MpobPwAACfdMg7/RxRFOFyQ7kbwneEK04O9P4Ani8N
3EKb0k5DCQgWfIkvSBLv8Om2
--------------090302040704080608000607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
