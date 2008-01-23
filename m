Message-ID: <4797BE33.1070504@redhat.com>
Date: Wed, 23 Jan 2008 17:22:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: audit2allow patch
Content-Type: multipart/mixed;
 boundary="------------010000050309050605040500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010000050309050605040500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fan through pychecker and cleaned up some bugs.

Also added booleans description from policy.xml file

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeXvjMACgkQrlYvE4MpobOsgwCfbTTJxThRmfUw5LHQGhsG99vj
rtwAoMTo1ms2h6dOQXmrtLpHrwB1Ec5Z
=mNcO
-----END PGP SIGNATURE-----

--------------010000050309050605040500
Content-Type: text/plain;
 name="audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2allow.patch"

--- nsapolicycoreutils/audit2allow/audit2allow	2008-01-23 16:47:07.000000000 -0500
+++ policycoreutils-2.0.37/audit2allow/audit2allow	2008-01-23 17:15:21.000000000 -0500
@@ -19,7 +19,6 @@
 #
 
 import sys
-import tempfile
 
 import sepolgen.audit as audit
 import sepolgen.policygen as policygen
@@ -153,9 +152,9 @@
 
     def __process_input(self):
         if self.__options.type:
-            filter = audit.TypeFilter(self.__options.type)
-            self.__avs = self.__parser.to_access(filter)
-            self.__selinux_errs = self.__parser.to_role(filter)
+            avcfilter = audit.TypeFilter(self.__options.type)
+            self.__avs = self.__parser.to_access(avcfilter)
+            self.__selinux_errs = self.__parser.to_role(avcfilter)
         else:
             self.__avs = self.__parser.to_access()
             self.__selinux_errs = self.__parser.to_role()
@@ -221,13 +220,14 @@
     def __output_audit2why(self):
             import selinux
             import selinux.audit2why as audit2why
+            import seobject
             audit2why.init("%s.%s" % (selinux.selinux_binary_policy_path(), selinux.security_policyvers()))
             for i in self.__parser.avc_msgs:
                 rc, bools = audit2why.analyze(i.scontext.to_string(), i.tcontext.to_string(), i.tclass, i.accesses)
                 if rc >= 0:
                     print "%s\n\tWas caused by:" % i.message
                 if rc == audit2why.NOPOLICY:
-                    raise "Must call policy_init first"
+                    raise RuntimeError("Must call policy_init first")
                 if rc == audit2why.BADTCON:
                     print "Invalid Target Context %s\n" % i.tcontext
                     continue
@@ -241,7 +241,7 @@
                     print "Invalid permission %s\n" % i.accesses
                     continue
                 if rc == audit2why. BADCOMPUTE:
-                    raise "Error during access vector computation"
+                    raise RuntimeError("Error during access vector computation")
                 if rc == audit2why.ALLOW:
                     print "\t\tUnknown - would be allowed by active policy\n",
                     print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
@@ -251,12 +251,14 @@
                     if len(bools) > 1:
                         print "\tOne of the following booleans was set incorrectly."
                         for b in bools:
-                            print "\n\tBoolean %s is %d. Allow access by executing:" % (b[0], not b[1])
-                            print "\t# setsebool -P %s %d"  % (b[0], b[1])
+                            print "\n\tBoolean %s is %d." % (b[0], not b[1])
+                            print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(b[0])
+                            print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (b[0], b[1])
                     else:
-                        print "\tThe boolean %s was set incorrectly.  Allow access by executing:" % bools[0][0]
-                        print "\t# setsebool -P %s %d\n"  % (bools[0][0], bools[0][1])
-
+                        print "\tThe boolean %s set incorrectly. " % (bools[0][0])
+                        print "\n\tBoolean %s is %d." % (bools[0][0], bools[0][1])
+                        print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(bools[0][0])
+                        print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (bools[0][0], bools[0][1])
                     continue
 
                 if rc == audit2why.TERULE:
--- nsapolicycoreutils/semanage/seobject.py	2007-12-10 21:42:27.000000000 -0500
+++ policycoreutils-2.0.37/semanage/seobject.py	2008-01-23 17:13:45.000000000 -0500
@@ -117,6 +117,12 @@
        #print _("Failed to translate booleans.\n%s") % e
        pass
 
+def boolean_desc(boolean):
+       if boolean in booleans_dict:
+              return _(booleans_dict[boolean][2])
+       else:
+              return boolean
+
 def validate_level(raw):
 	sensitivity = "s[0-9]*"
 	category = "c[0-9]*"
@@ -1456,10 +1462,7 @@
 		return ddict
 			
         def get_desc(self, boolean):
-               if boolean in booleans_dict:
-                      return _(booleans_dict[boolean][2])
-               else:
-                      return boolean
+               return boolean_desc(boolean)
 
         def get_category(self, boolean):
                if boolean in booleans_dict:

--------------010000050309050605040500
Content-Type: application/octet-stream;
 name="audit2allow.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="audit2allow.patch.sig"

iEYEABECAAYFAkeXvjMACgkQrlYvE4MpobNuWQCg38VFEBxPuHTVQj1IDn2fh13CJugAoNw4
BDKNJBfnw+SPO6r9qs0cJG0+
--------------010000050309050605040500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
