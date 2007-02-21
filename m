Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LI0qph020554
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:00:52 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1LI28Mh023041
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 18:02:09 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1LI286p030062
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:02:08 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1LI277B031396
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:02:07 -0500
Received: from [10.11.15.21] (vpn-15-21.rdu.redhat.com [10.11.15.21])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1LI26nY026579
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:02:07 -0500
Message-ID: <45DC891C.50701@mentalrootkit.com>
Date: Wed, 21 Feb 2007 13:02:04 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] sepolgen: leave generated files in current directory
Content-Type: multipart/mixed;
 boundary="------------000300010407090902090602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000300010407090902090602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes sepolgen so that the generated te files are left in 
the current directory when generating policy modules (with -M). This 
matches the behavior of the old audit2allow and allows review of the te 
file before inserting the module.

This patch also brings up the question of API stability for the sepolgen 
library (as it makes a minor change to the API). I suggest that it 
remain unstable for at least 1 release (i.e., the API can change in 
arbitrary ways). That should give sufficient time for it to stabilize 
and, hopefully, become general enough. Thoughts?

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--------------000300010407090902090602
Content-Type: text/x-patch;
 name="sepolgen-policygen-tmp-location.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepolgen-policygen-tmp-location.diff"

diff -r c0234c444da3 policycoreutils/audit2allow/audit2allow
--- a/policycoreutils/audit2allow/audit2allow	Tue Feb 06 13:21:26 2007 -0500
+++ b/policycoreutils/audit2allow/audit2allow	Mon Feb 19 11:07:20 2007 -0500
@@ -1,7 +1,7 @@
 #! /usr/bin/python -E
 # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
 #
-# Copyright (C) 2006 Red Hat 
+# Copyright (C) 2006-2007  Red Hat
 # see file 'COPYING' for use and warranty information
 #
 # This program is free software; you can redistribute it and/or
@@ -94,7 +94,6 @@ class AuditToPolicy:
             if not module.is_valid_name(name):
                 sys.stderr.write("only letters and numbers allowed in module names\n")
                 sys.exit(2)
-            
 
         # Make -M and -o conflict
         if options.module_package:
@@ -136,14 +135,14 @@ class AuditToPolicy:
             except IOError, e:
                 sys.stderr.write('could not open file %s - "%s"\n' % (filename, str(e)))
                 sys.exit(1)
-                
+
         if f is not None:
             parser.parse_file(f)
             f.close()
 
         if messages is not None:
             parser.parse_string(messages)
-        
+
         self.__parser = parser
 
     def __process_input(self):
@@ -182,16 +181,41 @@ class AuditToPolicy:
 
         perm_maps = objectmodel.PermMappings()
         perm_maps.from_file(fd)
-        
+
         return (ifs, perm_maps)
-        
-            
+
+    def __output_modulepackage(self, writer, generator):
+        generator.set_module_name(self.__options.module_package)
+        filename = self.__options.module_package + ".te"
+        packagename = self.__options.module_package + ".pp"
+
+        try:
+            fd = open(filename, "w")
+        except IOError, e:
+            sys.stderr.write("could not write output file: %s\n", str(e))
+            sys.exit(1)
+
+        writer.write(generator.get_module(), fd)
+        fd.close()
+
+        mc = module.ModuleCompiler()
+
+        try:
+            mc.create_module_package(filename, self.__options.refpolicy)
+        except RuntimeError, e:
+            print e
+            sys.exit(1)
+
+        sys.stdout.write(_("******************** IMPORTANT ***********************\n"))
+        sys.stdout.write((_("To make this policy package active, execute:" +\
+                                "\n\nsemodule -i %s\n\n") % packagename))
+
     def __output(self):
         g = policygen.PolicyGenerator()
-        
+
         if self.__options.module:
             g.set_module_name(self.__options.module)
-        
+
         # Interface generation
         if self.__options.refpolicy:
             ifs, perm_maps = self.__load_interface_info()
@@ -215,34 +239,7 @@ class AuditToPolicy:
 
         # Module package
         if self.__options.module_package:
-            g.set_module_name(self.__options.module_package)
-
-            fd = tempfile.NamedTemporaryFile()
-            writer.write(g.get_module(), fd)
-            fd.flush()
-            
-            mc = module.ModuleCompiler()
-            if self.__options.debug:
-                clean = False
-            else:
-                clean = True
-
-            if self.__options.refpolicy:
-                mc.refpolicy = True
-                
-            try:
-                mc.create_module_package(fd.name, self.__options.module_package + ".pp",
-                                         cleanup=clean)
-            except RuntimeError, e:
-                print e
-                sys.exit(1)
-
-            # This should unlink the temporary file
-            fd.close()
-            sys.stdout.write(_("******************** IMPORTANT ***********************\n"))
-            sys.stdout.write((_("To make this policy package active, execute:" +\
-                                "\n\nsemodule -i %s.pp\n\n") % self.__options.module_package))
-            
+            self.__output_modulepackage(writer, g)
         else:
             # File or stdout
             if self.__options.module:
@@ -253,7 +250,7 @@ class AuditToPolicy:
             else:
                 fd = sys.stdout
             writer.write(g.get_module(), fd)
-        
+
     def main(self):
         try:
             self.__parse_options()
diff -r c0234c444da3 sepolgen/src/sepolgen/module.py
--- a/sepolgen/src/sepolgen/module.py	Tue Feb 06 13:21:26 2007 -0500
+++ b/sepolgen/src/sepolgen/module.py	Mon Feb 19 10:46:49 2007 -0500
@@ -92,7 +92,8 @@ class ModuleCompiler:
     module compiler (checkmodule) and module packager (semodule_package).
     You are likely interested in the create_module_package method.
     
-    Several options are controlled via paramaters:
+    Several options are controlled via paramaters (only effects the 
+    non-refpol builds):
     
      .mls          [boolean] Generate an MLS module (by passed -M to
                    checkmodule). True to generate an MLS module, false
@@ -119,8 +120,8 @@ class ModuleCompiler:
         self.semodule_package = "/usr/bin/semodule_package"
         self.output = output
         self.last_output = ""
+        self.refpol_makefile = "/usr/share/selinux/devel/Makefile"
         self.make = "/usr/bin/make"
-        self.refpolicy = False
 
     def o(self, str):
         if self.output:
@@ -133,8 +134,25 @@ class ModuleCompiler:
         self.o(output)
         
         return rc
-
-    def create_module_package(self, sourcename, packagename, cleanup=True):
+    
+    def gen_filenames(self, sourcename):
+        """Generate the module and policy package filenames from
+        a source file name. The source file must be in the form
+        of "foo.te". This will generate "foo.mod" and "foo.pp".
+        
+        Returns a tuple with (modname, policypackage).
+        """
+        splitname = sourcename.split(".")
+        if len(splitname) < 2:
+            raise RuntimeError("invalid sourcefile name %s (must end in .te)", sourcename)
+        # Handle other periods in the filename correctly
+        basename = ".".join(splitname[0:-1])
+        modname = basename + ".mod"
+        packagename = basename + ".pp"
+        
+        return (modname, packagename)
+
+    def create_module_package(self, sourcename, refpolicy=True):
         """Create a module package saved in a packagename from a
         sourcename.
 
@@ -150,46 +168,22 @@ class ModuleCompiler:
         On error a RuntimeError will be raised with a descriptive
         error message.
         """
-        if self.refpolicy:
-            self.refpol_build(sourcename, packagename, cleanup)
+        if refpolicy:
+            self.refpol_build(sourcename)
         else:
-            modfile = tempfile.NamedTemporaryFile()
-            self.compile(sourcename, modfile.name)
-            self.package(modfile.name, packagename)
-            modfile.close()
-
-    def refpol_build(self, sourcename, packagename, cleanup):
-        # Create a fake directory tree
-        parent = tempfile.mkdtemp()
-        modname = modname_from_sourcename(packagename)
-        tree = ModuleTree(modname)
-        tree.create(parent)
-
-        # Copy the source
-        tefd = open(tree.te_name(), "w")
-        sourcefd = open(sourcename)
-        tefd.write(sourcefd.read())
-        tefd.close()
-
+            modname, packagename = self.gen_filenames(sourcename)
+            self.compile(sourcename, modname)
+            self.package(modname, packagename)
+            os.unlink(modname)
+            
+    def refpol_build(self, sourcename):
         # Compile
-        p = subprocess.Popen(self.make, stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE, cwd=tree.dir_name())
-        self.o("\n".join(p.communicate()))
-
-        # Copy the package
-        if p.returncode == 0:
-            shutil.copyfile(tree.package_name(), packagename)
-
-        # Remove the tree
-        if cleanup:
-            shutil.rmtree(parent)
-        else:
-            print "generated module at %s\n" % parent
+        command = self.make + " -f " + self.refpol_makefile
+        rc = self.run(command)
 
         # Raise an error if the process failed
-        if p.returncode != 0:
+        if rc != 0:
             raise RuntimeError("compilation failed:\n%s" % self.last_output)
-        
         
     def compile(self, sourcename, modname):
         s = [self.checkmodule]
diff -r c0234c444da3 sepolgen/tests/test_module.py
--- a/sepolgen/tests/test_module.py	Tue Feb 06 13:21:26 2007 -0500
+++ b/sepolgen/tests/test_module.py	Mon Feb 19 10:46:49 2007 -0500
@@ -25,11 +25,11 @@ class TestModuleCompiler(unittest.TestCa
     def test(self):
         package = "module_compile_test.pp"
         mc = module.ModuleCompiler()
-        mc.create_module_package("module_compile_test.te", package)
+        mc.create_module_package("module_compile_test.te", refpolicy=True)
         os.stat(package)
         os.unlink(package)
 
         mc.refpolicy = True
-        mc.create_module_package("module_compile_test.te", "module_compile_test.pp")
+        mc.create_module_package("module_compile_test.te", refpolicy=False)
         os.stat(package)
-        #os.unlink(package)
+        os.unlink(package)

--------------000300010407090902090602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
