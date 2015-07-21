Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6L0cScT011402
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 20:38:32 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 63EB1AB99B
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 00:38:29 +0000 (UTC)
From: Michal Srb <msrb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] policycoreutils/audit2allow: improve compatibility with
 Python 3
Date: Tue, 21 Jul 2015 02:38:19 +0200
Message-Id: <1437439102-9911-2-git-send-email-msrb@redhat.com>
In-Reply-To: <1437439102-9911-1-git-send-email-msrb@redhat.com>
References: <1437439102-9911-1-git-send-email-msrb@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- replace print statement with print function
- use reserved word `as` in try-except
- replace deprecated assert_() method with assertTrue() in unit tests

Signed-off-by: Michal Srb <msrb@redhat.com>
---
 policycoreutils/audit2allow/audit2allow         | 66 ++++++++++++-------------
 policycoreutils/audit2allow/audit2why           | 64 ++++++++++++------------
 policycoreutils/audit2allow/sepolgen-ifgen      | 12 ++---
 policycoreutils/audit2allow/test_audit2allow.py |  8 +--
 4 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index c9713a2..0688b63 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -135,13 +135,13 @@ class AuditToPolicy:
         elif self.__options.audit:
             try:
                 messages = audit.get_audit_msgs()
-            except OSError, e:
+            except OSError as e:
                 sys.stderr.write('could not run ausearch - "%s"\n' % str(e))
                 sys.exit(1)
         elif self.__options.boot:
             try:
                 messages = audit.get_audit_boot_msgs()
-            except OSError, e:
+            except OSError as e:
                 sys.stderr.write('could not run ausearch - "%s"\n' % str(e))
                 sys.exit(1)
         else:
@@ -152,7 +152,7 @@ class AuditToPolicy:
         if filename is not None:
             try:
                 f = open(filename)
-            except IOError, e:
+            except IOError as e:
                 sys.stderr.write('could not open file %s - "%s"\n' % (filename, str(e)))
                 sys.exit(1)
 
@@ -214,7 +214,7 @@ class AuditToPolicy:
 
         try:
             fd = open(filename, "w")
-        except IOError, e:
+        except IOError as e:
             sys.stderr.write("could not write output file: %s\n" % str(e))
             sys.exit(1)
 
@@ -225,8 +225,8 @@ class AuditToPolicy:
 
         try:
             mc.create_module_package(filename, self.__options.refpolicy)
-        except RuntimeError, e:
-            print e
+        except RuntimeError as e:
+            print(e)
             sys.exit(1)
 
         sys.stdout.write(_("******************** IMPORTANT ***********************\n"))
@@ -240,44 +240,44 @@ class AuditToPolicy:
                 rc = i.type
                 data = i.data
                 if rc >= 0:
-                    print "%s\n\tWas caused by:" % i.message
+                    print("%s\n\tWas caused by:" % i.message)
                 if rc == audit2why.ALLOW:
-                    print "\t\tUnknown - would be allowed by active policy\n",
-                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
-                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
+                    print("\t\tUnknown - would be allowed by active policy")
+                    print("\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n")
+                    print("\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n")
                     continue
                 if rc == audit2why.DONTAUDIT:
-                    print "\t\tUnknown - should be dontaudit'd by active policy\n",
-                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
-                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
+                    print("\t\tUnknown - should be dontaudit'd by active policy")
+                    print("\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n")
+                    print("\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n")
                     continue
                 if rc == audit2why.BOOLEAN:
                     if len(data) > 1:
-                        print "\tOne of the following booleans was set incorrectly."
+                        print("\tOne of the following booleans was set incorrectly.")
                         for b in data:
-                            print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(b[0])
-                            print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (b[0], b[1])
+                            print("\tDescription:\n\t%s\n"  % seobject.boolean_desc(b[0]))
+                            print("\tAllow access by executing:\n\t# setsebool -P %s %d"  % (b[0], b[1]))
                     else:
-                        print "\tThe boolean %s was set incorrectly. " % (data[0][0])
-                        print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(data[0][0])
-                        print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (data[0][0], data[0][1])
+                        print("\tThe boolean %s was set incorrectly. " % (data[0][0]))
+                        print("\tDescription:\n\t%s\n"  % seobject.boolean_desc(data[0][0]))
+                        print("\tAllow access by executing:\n\t# setsebool -P %s %d"  % (data[0][0], data[0][1]))
                     continue
 
                 if rc == audit2why.TERULE:
-                    print "\t\tMissing type enforcement (TE) allow rule.\n"
-                    print "\t\tYou can use audit2allow to generate a loadable module to allow this access.\n"
+                    print("\t\tMissing type enforcement (TE) allow rule.\n")
+                    print("\t\tYou can use audit2allow to generate a loadable module to allow this access.\n")
                     continue
 
                 if rc == audit2why.CONSTRAINT:
-                    print #!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.\n"
-                    print "#Constraint rule:"
-                    print "\n\t" + data[0]
+                    print() #!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.\n"
+                    print("#Constraint rule:")
+                    print("\n\t" + data[0])
                     for reason in data[1:]:
-                        print "#\tPossible cause is the source %s and target %s are different.\n" % reason
+                        print("#\tPossible cause is the source %s and target %s are different.\n" % reason)
 
                 if rc == audit2why.RBAC:
-                    print "\t\tMissing role allow rule.\n"
-                    print "\t\tAdd an allow rule for the role pair.\n"
+                    print("\t\tMissing role allow rule.\n")
+                    print("\t\tAdd an allow rule for the role pair.\n")
                     continue
 
             audit2why.finish()
@@ -288,8 +288,8 @@ class AuditToPolicy:
         if self.__options.audit2why:
             try:
                 return self.__output_audit2why()
-            except RuntimeError, e:
-                print e
+            except RuntimeError as e:
+                print(e)
                 sys.exit(1)
 
         g = policygen.PolicyGenerator()
@@ -348,11 +348,11 @@ class AuditToPolicy:
             self.__output()
         except KeyboardInterrupt:
             sys.exit(0)
-        except ValueError, e:
-            print e
+        except ValueError as e:
+            print(e)
             sys.exit(1)
-        except IOError, e:
-            print e
+        except IOError as e:
+            print(e)
             sys.exit(1)
 
 if __name__ == "__main__":
diff --git a/policycoreutils/audit2allow/audit2why b/policycoreutils/audit2allow/audit2why
index 323eddd..09422a2 100644
--- a/policycoreutils/audit2allow/audit2why
+++ b/policycoreutils/audit2allow/audit2why
@@ -135,13 +135,13 @@ class AuditToPolicy:
         elif self.__options.audit:
             try:
                 messages = audit.get_audit_msgs()
-            except OSError, e:
+            except OSError as e:
                 sys.stderr.write('could not run ausearch - "%s"\n' % str(e))
                 sys.exit(1)
         elif self.__options.boot:
             try:
                 messages = audit.get_audit_boot_msgs()
-            except OSError, e:
+            except OSError as e:
                 sys.stderr.write('could not run ausearch - "%s"\n' % str(e))
                 sys.exit(1)
         else:
@@ -152,7 +152,7 @@ class AuditToPolicy:
         if filename is not None:
             try:
                 f = open(filename)
-            except IOError, e:
+            except IOError as e:
                 sys.stderr.write('could not open file %s - "%s"\n' % (filename, str(e)))
                 sys.exit(1)
 
@@ -214,7 +214,7 @@ class AuditToPolicy:
 
         try:
             fd = open(filename, "w")
-        except IOError, e:
+        except IOError as e:
             sys.stderr.write("could not write output file: %s\n" % str(e))
             sys.exit(1)
 
@@ -225,8 +225,8 @@ class AuditToPolicy:
 
         try:
             mc.create_module_package(filename, self.__options.refpolicy)
-        except RuntimeError, e:
-            print e
+        except RuntimeError as e:
+            print(e)
             sys.exit(1)
 
         sys.stdout.write(_("******************** IMPORTANT ***********************\n"))
@@ -240,43 +240,43 @@ class AuditToPolicy:
                 rc = i.type
                 data = i.data
                 if rc >= 0:
-                    print "%s\n\tWas caused by:" % i.message
+                    print("%s\n\tWas caused by:" % i.message)
                 if rc == audit2why.ALLOW:
-                    print "\t\tUnknown - would be allowed by active policy\n",
-                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
-                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
+                    print("\t\tUnknown - would be allowed by active policy")
+                    print("\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n")
+                    print("\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n")
                     continue
                 if rc == audit2why.DONTAUDIT:
-                    print "\t\tUnknown - should be dontaudit'd by active policy\n",
-                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
-                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
+                    print("\t\tUnknown - should be dontaudit'd by active policy")
+                    print("\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n")
+                    print("\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n")
                     continue
                 if rc == audit2why.BOOLEAN:
                     if len(data) > 1:
-                        print "\tOne of the following booleans was set incorrectly."
+                        print("\tOne of the following booleans was set incorrectly.")
                         for b in data:
-                            print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(b[0])
-                            print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (b[0], b[1])
+                            print("\tDescription:\n\t%s\n"  % seobject.boolean_desc(b[0]))
+                            print("\tAllow access by executing:\n\t# setsebool -P %s %d"  % (b[0], b[1]))
                     else:
-                        print "\tThe boolean %s was set incorrectly. " % (data[0][0])
-                        print "\tDescription:\n\t%s\n"  % seobject.boolean_desc(data[0][0])
-                        print "\tAllow access by executing:\n\t# setsebool -P %s %d"  % (data[0][0], data[0][1])
+                        print("\tThe boolean %s was set incorrectly. " % (data[0][0]))
+                        print("\tDescription:\n\t%s\n"  % seobject.boolean_desc(data[0][0]))
+                        print("\tAllow access by executing:\n\t# setsebool -P %s %d"  % (data[0][0], data[0][1]))
                     continue
 
                 if rc == audit2why.TERULE:
-                    print "\t\tMissing type enforcement (TE) allow rule.\n"
-                    print "\t\tYou can use audit2allow to generate a loadable module to allow this access.\n"
+                    print("\t\tMissing type enforcement (TE) allow rule.\n")
+                    print("\t\tYou can use audit2allow to generate a loadable module to allow this access.\n")
                     continue
 
                 if rc == audit2why.CONSTRAINT:
-                    print #!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.\n"
-                    print "#Constraint rule: \n\t" + data[0]
+                    print() #!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.\n"
+                    print("#Constraint rule: \n\t" + data[0])
                     for reason in data[1:]:
-                        print "#\tPossible cause is the source %s and target %s are different.\n\b" % reason
+                        print("#\tPossible cause is the source %s and target %s are different.\n\b" % reason)
 
                 if rc == audit2why.RBAC:
-                    print "\t\tMissing role allow rule.\n"
-                    print "\t\tAdd an allow rule for the role pair.\n"
+                    print("\t\tMissing role allow rule.\n")
+                    print("\t\tAdd an allow rule for the role pair.\n")
                     continue
 
             audit2why.finish()
@@ -287,8 +287,8 @@ class AuditToPolicy:
         if self.__options.audit2why:
             try:
                 return self.__output_audit2why()
-            except RuntimeError, e:
-                print e
+            except RuntimeError as e:
+                print(e)
                 sys.exit(1)
 
         g = policygen.PolicyGenerator()
@@ -347,11 +347,11 @@ class AuditToPolicy:
             self.__output()
         except KeyboardInterrupt:
             sys.exit(0)
-        except ValueError, e:
-            print e
+        except ValueError as e:
+            print(e)
             sys.exit(1)
-        except IOError, e:
-            print e
+        except IOError as e:
+            print(e)
             sys.exit(1)
 
 if __name__ == "__main__":
diff --git a/policycoreutils/audit2allow/sepolgen-ifgen b/policycoreutils/audit2allow/sepolgen-ifgen
index 83c7ecf..7f8caaf 100644
--- a/policycoreutils/audit2allow/sepolgen-ifgen
+++ b/policycoreutils/audit2allow/sepolgen-ifgen
@@ -82,7 +82,7 @@ def get_attrs(policy_path):
             sys.stderr.write("No installed policy to check\n")
             return None
         outfile = tempfile.NamedTemporaryFile()
-    except IOError, e:
+    except IOError as e:
         sys.stderr.write("could not open attribute output file\n")
         return None
     except OSError:
@@ -100,7 +100,7 @@ def get_attrs(policy_path):
     try:
         attrs.from_file(outfile)
     except:
-        print "error parsing attribute info"
+        print("error parsing attribute info")
         return None
 
     return attrs
@@ -111,7 +111,7 @@ def main():
     # Open the output first to generate errors before parsing
     try:
         f = open(options.output, "w")
-    except IOError, e:
+    except IOError as e:
         sys.stderr.write("could not open output file [%s]\n" % options.output)
         return 1
 
@@ -130,9 +130,9 @@ def main():
     # Parse the headers
     try:
         headers = refparser.parse_headers(options.headers, output=log, debug=options.debug)
-    except ValueError, e:
-        print "error parsing headers"
-        print str(e)
+    except ValueError as e:
+        print("error parsing headers")
+        print(str(e))
         return 1
 
     if_set = interfaces.InterfaceSet(output=log)
diff --git a/policycoreutils/audit2allow/test_audit2allow.py b/policycoreutils/audit2allow/test_audit2allow.py
index 794673e..d6bd60b 100644
--- a/policycoreutils/audit2allow/test_audit2allow.py
+++ b/policycoreutils/audit2allow/test_audit2allow.py
@@ -4,18 +4,18 @@ from subprocess import Popen, PIPE
 
 class Audit2allowTests(unittest.TestCase):
     def assertDenied(self, err):
-        self.assert_('Permission denied' in err,
+        self.assertTrue('Permission denied' in err,
                      '"Permission denied" not found in %r' % err)
     def assertNotFound(self, err):
-        self.assert_('not found' in err,
+        self.assertTrue('not found' in err,
                      '"not found" not found in %r' % err)
 
     def assertFailure(self, status):
-        self.assert_(status != 0,
+        self.assertTrue(status != 0,
                      '"Succeeded when it should have failed')
 
     def assertSuccess(self, cmd, status, err):
-        self.assert_(status == 0,
+        self.assertTrue(status == 0,
                      '"%s should have succeeded for this test %r' %  (cmd, err))
 
     def test_sepolgen_ifgen(self):
-- 
2.4.3
