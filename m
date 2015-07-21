Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6L0cScV011402
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 20:38:36 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id A5A5ABBF56
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 00:38:33 +0000 (UTC)
From: Michal Srb <msrb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] policycoreutils/semanage: improve compatibility with
 Python 3
Date: Tue, 21 Jul 2015 02:38:21 +0200
Message-Id: <1437439102-9911-4-git-send-email-msrb@redhat.com>
In-Reply-To: <1437439102-9911-1-git-send-email-msrb@redhat.com>
References: <1437439102-9911-1-git-send-email-msrb@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- gettext.install() only takes "unicode" keyword argument in Python 2
- __builtin__ module has been renamed to "builtins" in Python 3
- use reserved word `as` in try-except
- replace print statement with print function

Signed-off-by: Michal Srb <msrb@redhat.com>
---
 policycoreutils/semanage/semanage         | 59 +++++++++++++++++--------------
 policycoreutils/semanage/test-semanage.py |  4 +--
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index dd1010a..515cef3 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -29,13 +29,20 @@ import sys
 import gettext
 PROGNAME="policycoreutils"
 try:
-       gettext.install(PROGNAME,
-                       localedir="/usr/share/locale",
-                       unicode=True,
-                       codeset = 'utf-8')
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
+    gettext.install(PROGNAME,
+                    localedir="/usr/share/locale",
+                    codeset = 'utf-8',
+                    **kwarg)
 except IOError:
-       import __builtin__
-       __builtin__.__dict__['_'] = unicode
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 # define custom usages for selected main actions
 usage_login = "semanage login [-h] [-n] [-N] [-s STORE] ["
@@ -103,7 +110,7 @@ class SetImportFile(argparse.Action):
         if values and values is not "-":
                try:
                       sys.stdin = open(values, 'r')
-               except IOError,e:
+               except IOError as e:
                       sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
                       sys.exit(1)
         setattr(namespace, self.dest, values)
@@ -207,7 +214,7 @@ def handleLogin(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "login %s" % (str(i))
+            print("login %s" % (str(i)))
 
 def parser_add_store(parser, name):
     parser.add_argument('-S', '--store', action=SetStore, help=_("Select an alternate SELinux Policy Store to manage"))
@@ -323,7 +330,7 @@ def handleFcontext(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "fcontext %s" % str(i)
+            print("fcontext %s" % str(i))
 
 def setupFcontextParser(subparsers):
     ftype_help = '''
@@ -381,7 +388,7 @@ def handleUser(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "user %s" % str(i)
+            print("user %s" % str(i))
 
 def setupUserParser(subparsers):
     generated_usage = generate_custom_usage(usage_user, usage_user_dict)
@@ -430,7 +437,7 @@ def handlePort(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "port %s" % str(i)
+            print("port %s" % str(i))
 
 def setupPortParser(subparsers):
     generated_usage = generate_custom_usage(usage_port, usage_port_dict)
@@ -473,7 +480,7 @@ def handleInterface(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "interface %s" % str(i)
+            print("interface %s" % str(i))
 
 def setupInterfaceParser(subparsers):
     generated_usage = generate_custom_usage(usage_interface, usage_interface_dict)
@@ -512,7 +519,7 @@ def handleModule(args):
         OBJECT.list(args.noheading, args.locallist)
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "module %s" % str(i)
+            print("module %s" % str(i))
 
 def setupModuleParser(subparsers):
     moduleParser = subparsers.add_parser('module', help=_('Manage SELinux policy modules'))
@@ -552,7 +559,7 @@ def handleNode(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "node %s" % str(i)
+            print("node %s" % str(i))
 
 def setupNodeParser(subparsers):
     generated_usage = generate_custom_usage(usage_node, usage_node_dict)
@@ -584,10 +591,10 @@ def handleBoolean(args):
         sys.exit(2)
     # TODO: should be added to handle_opts logic
     elif args.action is "modify" and not args.boolean:
-        print "boolean name required "
+        print("boolean name required ")
         sys.exit(1)
     elif args.action is "modify" and args.boolean and not args.state:
-        print "state option is needed"
+        print("state option is needed")
         sys.exit(1)
     else:
         handle_opts(args,boolean_args,args.action)
@@ -604,7 +611,7 @@ def handleBoolean(args):
         OBJECT.deleteall()
     if args.action is "extract":
         for i in OBJECT.customized():
-            print "boolean %s" % str(i)
+            print("boolean %s" % str(i))
 
 def setupBooleanParser(subparsers):
     generated_usage = generate_custom_usage(usage_boolean, usage_boolean_dict)
@@ -670,11 +677,11 @@ def setupDontauditParser(subparsers):
 def handleExport(args):
     manageditems=[ "boolean", "login", "interface", "user", "port", "node", "fcontext", "module"]
     for i in manageditems:
-        print "%s -D" % i
+        print("%s -D" % i)
     for i in manageditems:
         OBJECT = object_dict[i]()
         for c in OBJECT.customized():
-            print "%s %s" % (i, str(c))
+            print("%s %s" % (i, str(c)))
 
     sys.exit(0)
 
@@ -743,10 +750,10 @@ def handleImport(args):
             commandParser = createCommandParser()
             args = commandParser.parse_args(mkargv(l))
             args.func(args)
-        except ValueError,e:
+        except ValueError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
-        except IOError,e:
+        except IOError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
         except KeyboardInterrupt:
@@ -822,21 +829,21 @@ def do_parser():
         args = commandParser.parse_args(make_args(sys.argv))
         args.func(args)
         sys.exit(0)
-    except IOError,e:
+    except IOError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
         sys.exit(1)
     except KeyboardInterrupt:
         sys.exit(0)
-    except ValueError, e:
+    except ValueError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[0]))
         sys.exit(1)
-    except KeyError, e:
+    except KeyError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[0]))
         sys.exit(1)
-    except OSError, e:
+    except OSError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[1]))
         sys.exit(1)
-    except RuntimeError, e:
+    except RuntimeError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[0]))
         sys.exit(1)
 
diff --git a/policycoreutils/semanage/test-semanage.py b/policycoreutils/semanage/test-semanage.py
index d39013e..fc8368e 100644
--- a/policycoreutils/semanage/test-semanage.py
+++ b/policycoreutils/semanage/test-semanage.py
@@ -273,10 +273,10 @@ if __name__ == "__main__":
             args = parser.parse_args()
             args.func(args)
             sys.exit(0)
-        except ValueError,e:
+        except ValueError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
-        except IOError,e:
+        except IOError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
         except KeyboardInterrupt:
-- 
2.4.3
