Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6L0cScU011402
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 20:38:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 85026B6F52
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 00:38:31 +0000 (UTC)
From: Michal Srb <msrb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] policycoreutils/sandbox: improve compatibility with
 Python 3
Date: Tue, 21 Jul 2015 02:38:20 +0200
Message-Id: <1437439102-9911-3-git-send-email-msrb@redhat.com>
In-Reply-To: <1437439102-9911-1-git-send-email-msrb@redhat.com>
References: <1437439102-9911-1-git-send-email-msrb@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- gettext.install() only takes optional "unicode" keyword argument in
  Python 2, and its default value is "False". This keyword argument
  doesn't exist in Python 3
- __builtin__ module has been renamed to "builtins" in Python 3
- raw_input() has been renamed to input() in Python 3
- specify octal literals in form compatible with both Python 2 and 3
- migrate from commands to subprocess
- replace print statement with print function
- use reserved word `as` in try-except
- replace deprecated assert_() method with assertTrue() in unit tests

Signed-off-by: Michal Srb <msrb@redhat.com>
---
 policycoreutils/sandbox/sandbox         | 38 +++++++++++++++++++--------------
 policycoreutils/sandbox/start           |  6 +++---
 policycoreutils/sandbox/test_sandbox.py | 12 +++++------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 3678c5d..fb64464 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -25,7 +25,6 @@ import selinux
 import signal
 from tempfile import mkdtemp
 import pwd
-import commands
 import sepolicy
 
 PROGNAME = "policycoreutils"
@@ -36,13 +35,16 @@ gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
 
 try:
-       gettext.install(PROGNAME,
-                       localedir = "/usr/share/locale",
-                       unicode=False,
-                       codeset = 'utf-8')
+   gettext.install(PROGNAME,
+                   localedir = "/usr/share/locale",
+                   codeset = 'utf-8')
 except IOError:
-       import __builtin__
-       __builtin__.__dict__['_'] = unicode
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 DEFAULT_WINDOWSIZE = "1000x700"
 DEFAULT_TYPE = "sandbox_t"
@@ -86,7 +88,7 @@ def copyfile(file, srcdir, dest):
                      else:
                             shutil.copy2(file, dest)
 
-              except shutil.Error, elist:
+              except shutil.Error as elist:
                      for e in elist.message:
                             sys.stderr.write(e[2])
                      
@@ -107,7 +109,11 @@ def savefile(new, orig, X_ind):
               if rc == gtk.RESPONSE_YES:
                      copy = True
        else:
-              ans = raw_input(_("Do you want to save changes to '%s' (y/N): ") % orig)
+              try:
+                  input = raw_input
+              except NameError:
+                  pass
+              ans = input(_("Do you want to save changes to '%s' (y/N): ") % orig)
               if(re.match(_("[yY]"),ans)):
                      copy = True
        if(copy):
@@ -228,9 +234,9 @@ class Sandbox:
            for i in fd.readlines():
                   try:
                          self.__include(option, opt, i[:-1], parser)
-                  except IOError, e:
+                  except IOError as e:
                          sys.stderr.write(str(e))
-                  except TypeError, e:
+                  except TypeError as e:
                          sys.stderr.write(str(e))
            fd.close()
 
@@ -263,7 +269,7 @@ dbus-launch --exit-with-session %s
 kill -TERM $WM_PID  2> /dev/null
 """ % (command, wm, command))
            fd.close()
-           os.chmod(execfile, 0700)
+           os.chmod(execfile, 0o700)
 
     def usage(self, message = ""):
            error_exit("%s\n%s" % (self.__parser.usage, message))
@@ -492,13 +498,13 @@ if __name__ == '__main__':
     try:
            sandbox = Sandbox()
            rc = sandbox.main()
-    except OSError, error:
+    except OSError as error:
            error_exit(error)
-    except ValueError, error:
+    except ValueError as error:
            error_exit(error.args[0])
-    except KeyError, error:
+    except KeyError as error:
            error_exit(_("Invalid value %s") % error.args[0])
-    except IOError, error:
+    except IOError as error:
            error_exit(error)
     except KeyboardInterrupt:
            rc = 0
diff --git a/policycoreutils/sandbox/start b/policycoreutils/sandbox/start
index 52950d7..d895ba2 100644
--- a/policycoreutils/sandbox/start
+++ b/policycoreutils/sandbox/start
@@ -1,9 +1,9 @@
 #! /usr/bin/python -Es
-import gtk, commands, sys
+import gtk, subprocess, sys
 rc = [-1,'']
 try:
-    rc=commands.getstatusoutput(sys.argv[1])
+    rc=subprocess.getstatusoutput(sys.argv[1])
 except:
     pass
 if rc[0] == 0:
-    print rc[1]
+    print(rc[1])
diff --git a/policycoreutils/sandbox/test_sandbox.py b/policycoreutils/sandbox/test_sandbox.py
index b3b7f64..d765cb4 100644
--- a/policycoreutils/sandbox/test_sandbox.py
+++ b/policycoreutils/sandbox/test_sandbox.py
@@ -4,18 +4,18 @@ from subprocess import Popen, PIPE
 
 class SandboxTests(unittest.TestCase):
     def assertDenied(self, err):
-        self.assert_('Permission denied' in err,
+        self.assertTrue(b'Permission denied' in err,
                      '"Permission denied" not found in %r' % err)
     def assertNotFound(self, err):
-        self.assert_('not found' in err,
+        self.assertTrue(b'not found' in err,
                      '"not found" not found in %r' % err)
 
     def assertFailure(self, status):
-        self.assert_(status != 0,
+        self.assertTrue(status != 0,
                      '"Succeeded when it should have failed')
 
     def assertSuccess(self, status, err):
-        self.assert_(status == 0,
+        self.assertTrue(status == 0,
                      '"Sandbox should have succeeded for this test %r' %  err)
 
     def test_simple_success(self):
@@ -23,7 +23,7 @@ class SandboxTests(unittest.TestCase):
         p1 = Popen(['cat', '/etc/passwd'], stdout = PIPE)
         p2 = Popen(['sandbox', 'grep', 'root'], stdin = p1.stdout, stdout=PIPE)
         out, err = p2.communicate()
-        self.assert_('root' in out)
+        self.assertTrue(b'root' in out)
 
     def test_cant_kill(self):
         "Verify that we cannot send kill signal in the sandbox"
@@ -95,4 +95,4 @@ if __name__ == "__main__":
     if selinux.security_getenforce() == 1:
         unittest.main()
     else:
-        print "SELinux must be in enforcing mode for this test"
+        print("SELinux must be in enforcing mode for this test")
-- 
2.4.3
