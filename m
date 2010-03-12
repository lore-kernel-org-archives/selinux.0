Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2CHw5Of004414
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 12:58:05 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2CHwXjN025429
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 17:58:34 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2CHw3RX017680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 12:58:03 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2CHw2wK001264
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 12:58:03 -0500
Message-ID: <4B9A80AA.1070407@redhat.com>
Date: Fri, 12 Mar 2010 12:58:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This patch allows audit2allow to look at all avc's since the last
 time the machine booted.
Content-Type: multipart/mixed;
 boundary="------------060409030701030104090807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060409030701030104090807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060409030701030104090807
Content-Type: text/plain;
 name="audit2allow_boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audit2allow_boot.patch"

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 5ad9fdb..5435e9d 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -42,6 +42,8 @@ class AuditToPolicy:
         from optparse import OptionParser
 
         parser = OptionParser(version=self.VERSION)
+        parser.add_option("-b", "--boot", action="store_true", dest="boot", default=False,
+                          help="audit messages since last boot conflicts with -i")
         parser.add_option("-a", "--all", action="store_true", dest="audit", default=False,
                           help="read input from audit log - conflicts with -i")
         parser.add_option("-d", "--dmesg", action="store_true", dest="dmesg", default=False,
@@ -83,11 +85,11 @@ class AuditToPolicy:
         options, args = parser.parse_args()
 
         # Make -d, -a, and -i conflict
-        if options.audit is True:
+        if options.audit is True or options.boot:
             if options.input is not None:
-                sys.stderr.write("error: --all conflicts with --input\n")
+                sys.stderr.write("error: --all/--boot conflicts with --input\n")
             if options.dmesg is True:
-                sys.stderr.write("error: --all conflicts with --dmesg\n")
+                sys.stderr.write("error: --all/--boot conflicts with --dmesg\n")
         if options.input is not None and options.dmesg is True:
             sys.stderr.write("error: --input conflicts with --dmesg\n")
 
@@ -132,6 +134,12 @@ class AuditToPolicy:
             except OSError, e:
                 sys.stderr.write('could not run ausearch - "%s"\n' % str(e))
                 sys.exit(1)
+        elif self.__options.boot:
+            try:
+                messages = audit.get_audit_boot_msgs()
+            except OSError, e:
+                sys.stderr.write('could not run ausearch - "%s"\n' % str(e))
+                sys.exit(1)
         else:
             # This is the default if no input is specified
             f = sys.stdin
diff --git a/policycoreutils/audit2allow/audit2allow.1 b/policycoreutils/audit2allow/audit2allow.1
index d9635c2..6178cc8 100644
--- a/policycoreutils/audit2allow/audit2allow.1
+++ b/policycoreutils/audit2allow/audit2allow.1
@@ -38,6 +38,9 @@
 .B "\-a" | "\-\-all"
 Read input from audit and message log, conflicts with -i
 .TP
+.B "\-b" | "\-\-boot"
+Read input from audit messages since last boot conflicts with -i
+.TP
 .B "\-d" | "\-\-dmesg"
 Read input from output of 
 .I /bin/dmesg.
diff --git a/sepolgen/src/sepolgen/audit.py b/sepolgen/src/sepolgen/audit.py
index efcc40d..24e308e 100644
--- a/sepolgen/src/sepolgen/audit.py
+++ b/sepolgen/src/sepolgen/audit.py
@@ -23,6 +23,27 @@ import re
 
 # Convenience functions
 
+def get_audit_boot_msgs():
+    """Obtain all of the avc and policy load messages from the audit
+    log. This function uses ausearch and requires that the current
+    process have sufficient rights to run ausearch.
+
+    Returns:
+       string contain all of the audit messages returned by ausearch.
+    """
+    import subprocess
+    import time
+    fd=open("/proc/uptime", "r")
+    off=float(fd.read().split()[0])
+    fd.close
+    s = time.localtime(time.time() - off)
+    date = time.strftime("%D/%Y", s).split("/")
+    bootdate="%s/%s/%s" % (date[0], date[1], date[3])
+    boottime = time.strftime("%X", s)
+    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START,SELINUX_ERR", "-ts", bootdate, boottime],
+                              stdout=subprocess.PIPE).communicate()[0]
+    return output
+
 def get_audit_msgs():
     """Obtain all of the avc and policy load messages from the audit
     log. This function uses ausearch and requires that the current

--------------060409030701030104090807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
