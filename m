Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1KJBts030224
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 15:19:12 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB1KH6Qx018043
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 20:17:07 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mB1KJBoG025483
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 15:19:11 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mB1KJAhU008766
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 15:19:10 -0500
Received: from localhost.localdomain (vpn-10-109.bos.redhat.com [10.16.10.109])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mB1KJ9lq001123
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 15:19:09 -0500
Message-ID: <493446BD.8000401@redhat.com>
Date: Mon, 01 Dec 2008 15:19:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Small fixes for audit2allow 
Content-Type: multipart/mixed;
 boundary="------------040001090100060907010002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040001090100060907010002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040001090100060907010002
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.14 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-2.0.60/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2008-11-10 08:53:49.000000000 -0500
+++ policycoreutils-2.0.60/audit2allow/audit2allow	2008-12-01 15:16:31.000000000 -0500
@@ -42,10 +42,10 @@
         from optparse import OptionParser
 
         parser = OptionParser(version=self.VERSION)
-        parser.add_option("-a", "--audit", action="store_true", dest="audit", default=False,
+        parser.add_option("-a", "--all", action="store_true", dest="audit", default=False,
                           help="read input from audit log - conflicts with -i")
         parser.add_option("-d", "--dmesg", action="store_true", dest="dmesg", default=False,
-                          help="read input from dmesg - conflicts with --audit and --input")
+                          help="read input from dmesg - conflicts with --all and --input")
         parser.add_option("-i", "--input", dest="input",
                           help="read input from <input> - conflicts with -a")
         parser.add_option("-l", "--lastreload", action="store_true", dest="lastreload", default=False,
@@ -82,9 +82,9 @@
         # Make -d, -a, and -i conflict
         if options.audit is True:
             if options.input is not None:
-                sys.stderr.write("error: --audit conflicts with --input\n")
+                sys.stderr.write("error: --all conflicts with --input\n")
             if options.dmesg is True:
-                sys.stderr.write("error: --audit conflicts with --dmesg\n")
+                sys.stderr.write("error: --all conflicts with --dmesg\n")
         if options.input is not None and options.dmesg is True:
             sys.stderr.write("error: --input conflicts with --dmesg\n")
 
@@ -200,7 +200,7 @@
         try:
             fd = open(filename, "w")
         except IOError, e:
-            sys.stderr.write("could not write output file: %s\n", str(e))
+            sys.stderr.write("could not write output file: %s\n" % str(e))
             sys.exit(1)
 
         writer.write(generator.get_module(), fd)
diff --exclude-from=exclude --exclude=sepolgen-1.0.14 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/audit2allow.1 policycoreutils-2.0.60/audit2allow/audit2allow.1
--- nsapolicycoreutils/audit2allow/audit2allow.1	2008-11-10 08:53:49.000000000 -0500
+++ policycoreutils-2.0.60/audit2allow/audit2allow.1	2008-12-01 15:10:13.000000000 -0500
@@ -44,9 +44,6 @@
 Note that all audit messages are not available via dmesg when
 auditd is running; use "ausearch -m avc | audit2allow"  or "-a" instead.
 .TP
-.B "\-f" | "\-\-fcfile" <File Context File>
-Add File Context File to generated Module Package. Requires -M option.
-.TP
 .B "\-h" | "\-\-help"
 Print a short usage message
 .TP

--------------040001090100060907010002
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkk0Rr0ACgkQrlYvE4MpobMBbwCcCAs1XXBbiOEmy4RAH3vpBy5Rhy0An18m
xAHaSX0gn8M0El0Gtg7J6NTy
--------------040001090100060907010002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
