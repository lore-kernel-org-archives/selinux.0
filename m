From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 03/15] [src-policy] Reference Policy to refpol conversion tool
Date: Tue, 26 Jan 2010 17:08:09 -0500
Message-Id: <1264543701-20638-4-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-3-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The refpolicy2refpol tool automates the conversion from the upstream
reference policy modules into refpol modules. It also automates the
process of creating the refpol_ilc[1] build environment from the
upstream reference policy tree.

   Usage: refpolicy2refpol [OPTIONS] SOURCE TARGET

   Options:
     --version    show program's version number and exit
     -h, --help   show this help message and exit
     -b, --build  create the Refpol ILC build environment (default: False)
     -f, --force  force overwriting existing files

Examples:

Converting Reference Policy modules to refpol modules:

# refpolicy2refpol refpolicy refpol
# find refpol
refpol/policy/_rolemap.ref
<snip>
refpol/policy/modules/services/cyrus.ref
refpol/policy/modules/services/metadata.xml
refpol/policy/modules/services/pxe.ref
<snip>

Creating the refpol_ilc build environment:

# refpolicy2refpol -b refpolicy /usr/share/selinux/refpol_ilc/build

[1] See next patch for the refpol_ilc.
---
 refpol/Makefile                   |    1 +
 refpol/refpol/refpolicy2refpol.py |  185 +++++++++++++++++++++++++++++++++++++
 refpol/refpolicy2refpol.py        |   17 ++++
 3 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 refpol/refpol/refpolicy2refpol.py
 create mode 100755 refpol/refpolicy2refpol.py

diff --git a/refpol/Makefile b/refpol/Makefile
index f081eda..00c81b8 100644
--- a/refpol/Makefile
+++ b/refpol/Makefile
@@ -17,6 +17,7 @@ install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 refpol.py $(BINDIR)/refpol
 	install -m 755 refpolc.py $(BINDIR)/refpolc
+	install -m 755 refpolicy2refpol.py $(BINDIR)/refpolicy2refpol
 	-mkdir -p $(LANGUAGEDIR)
 	install -m 644 refpol.conf $(LANGUAGEDIR)
 
diff --git a/refpol/refpol/refpolicy2refpol.py b/refpol/refpol/refpolicy2refpol.py
new file mode 100644
index 0000000..c6b290a
--- /dev/null
+++ b/refpol/refpol/refpolicy2refpol.py
@@ -0,0 +1,185 @@
+#!/usr/bin/python
+
+# Authors:	Caleb Case <ccase@tresys.com>
+#
+# Copyright (C) 2009-2010 Tresys Technology, LLC
+#      This program is free software; you can redistribute it and/or modify
+#      it under the terms of the Lesser GNU General Public License as 
+#      published by the Free Software Foundation, version 2.
+
+from corenet import corenet
+import glob
+from optparse import OptionParser
+import os
+import refpol
+from shutil import copytree, ignore_patterns, rmtree, copyfileobj
+import sys
+
+force = False
+
+def modules(source):
+	return [item.rsplit('.', 1)[0] for item in glob.glob(source + "/policy/modules/*/*.te")]
+
+def specials(source):
+	return [source + item for item in [
+		"/policy/constraints",
+		"/policy/global_booleans",
+		"/policy/global_tunables",
+		"/policy/mcs",
+		"/policy/mls",
+		"/policy/policy_capabilities",
+		"/policy/rolemap",
+		"/policy/users",
+		"/policy/flask/access_vectors",
+		"/policy/flask/initial_sids",
+		"/policy/flask/security_classes",
+		"/policy/support/file_patterns.spt",
+		"/policy/support/ipc_patterns.spt",
+		"/policy/support/loadable_module.spt",
+		"/policy/support/misc_macros.spt",
+		"/policy/support/misc_patterns.spt",
+		"/policy/support/mls_mcs_macros.spt",
+		"/policy/support/obj_perm_sets.spt",
+		]]
+
+def discards(source):
+	return [source + item for item in [
+		"/policy/modules/admin",
+		"/policy/modules/apps",
+		"/policy/modules/roles",
+		"/policy/modules/services",
+		"/policy/modules/system",
+		]]
+
+def corenets(source):
+	return [source + item.rsplit('.', 1)[0] for item in [
+		"/policy/modules/kernel/corenetwork"
+		]]
+
+def build_conf_to_defines(source, target, version):
+	defines_table = ["OUTPUT_POLICY",
+			 "NAME",
+			 "DISTRO",
+			 "UNK_PERMS",
+			 "DIRECT_INITRC",
+			 "UBAC",
+			 "MLS_SENS",
+			 "MLS_CATS",
+			 "MCS_CATS",
+			 "QUIET",
+			 ]
+
+	with open(source, "r") as build_conf:
+		with open(target, "w") as defines:
+			defines.write("policy_module(_defines, %s)\n" % version)
+
+			buffer = []
+			for line in build_conf:
+				sline = line.strip()
+				if sline.startswith("#") or sline.strip() == "":
+					   buffer[len(buffer):] = [line]
+				elif sline.split('=')[0].strip() in defines_table:
+					defines.writelines(buffer)
+					defines.write(line)
+					buffer = []
+				else:
+					buffer = []
+
+def refpolicy2refpol(source, target):
+	if force:
+		rmtree(target, ignore_errors = True)
+
+	copytree(source, target)
+
+	# extract version for use with special modules
+	version = "0"
+	with open(target + "/VERSION") as f:
+		version = f.readline().strip()
+
+	for module in modules(target):
+		# convert to ref
+		refpol.itf_to_ref(module + ".if", module + ".te", module + ".fc", module + ".ref")
+
+		# remove old files
+		os.remove(module + ".if")
+		os.remove(module + ".te")
+		os.remove(module + ".fc")
+	
+	for special in specials(target):
+		name = os.path.basename(special).rsplit('.', 1)[0]
+		path = os.path.dirname(special) + "/_" + name + ".ref"
+		with open(path, "w") as new:
+			new.write("policy_module(%s, %s)\n\n" % (name, version))
+
+			with open(special, "r") as old:
+				copyfileobj(old, new)
+		os.remove(special)
+
+	for cnet in corenets(target):
+		corenet.itf_to_corenet(cnet + ".if.in",
+				       cnet + ".if.m4",
+				       cnet + ".te.in",
+				       cnet + ".te.m4",
+				       cnet + ".fc",
+				       cnet + ".corenet")
+
+		# remove old files
+		os.remove(cnet + ".if.in")
+		os.remove(cnet + ".if.m4")
+		os.remove(cnet + ".te.in")
+		os.remove(cnet + ".te.m4")
+		os.remove(cnet + ".fc")
+
+	# create _defines.ref
+	build_conf_to_defines(target + "/build.conf", target + "/_defines.ref", version)
+
+	# remove build.conf (will be created as part of build)
+	os.remove(target + "/build.conf")
+
+def create_ilc_environment(source, target):
+	if force:
+		rmtree(target, ignore_errors = True)
+
+	copytree(source, target, ignore = ignore_patterns("*.if", "*.te", "*.fc", "*.if.m4", "*.if.in", "*.te.m4", "*.te.in"))
+	for item in specials(target):
+		os.remove(item)
+	for item in discards(target):
+		rmtree(item, ignore_errors = True)
+	os.remove(target + "/build.conf")
+
+	# Create blank mls and mcs specials so that the build process
+	# does not complain when they are missing (i.e., _mls is disabled).
+	# These will get over written if the _mls/_mcs modules are installed.
+	open(target + "/policy/mls", "w").close()
+	open(target + "/policy/mcs", "w").close()
+
+usage = "%prog [OPTIONS] SOURCE TARGET"
+version = "%prog 1.0"
+
+def main():
+	# build cmdline parser
+	parser = OptionParser(usage = usage, version = version)
+	parser.add_option("-b", "--build", action = "store_true", default = False, dest = "build", help = "create the Refpol ILC build environment (default: False)")
+	parser.add_option("-f", "--force", action = "store_true", default = False, dest = "force", help = "force overwriting existing files")
+
+	# parse cmdline
+	(options, args) = parser.parse_args()
+
+	if len(args) != 2:
+		parser.error("Invalid number of arguments %d." % len(args))
+
+	force = options.force
+	source = args[0]
+	target = args[1]
+
+	if options.build:
+		create_ilc_environment(source, target)
+	else:
+		refpolicy2refpol(source, target)
+
+if __name__ == "__main__":
+	try:
+		main()
+	except Exception as e:
+		sys.stderr.write(sys.argv[0] + ": Error: " + str(e) + "\n")
+		sys.exit(1)
diff --git a/refpol/refpolicy2refpol.py b/refpol/refpolicy2refpol.py
new file mode 100755
index 0000000..bc908c3
--- /dev/null
+++ b/refpol/refpolicy2refpol.py
@@ -0,0 +1,17 @@
+#!/usr/bin/python
+
+# Authors:	Caleb Case <ccase@tresys.com>
+#
+# Copyright (C) 2009-2010 Tresys Technology, LLC
+#      This program is free software; you can redistribute it and/or modify
+#      it under the terms of the Lesser GNU General Public License as 
+#      published by the Free Software Foundation, version 2.
+
+import refpol.refpolicy2refpol
+import sys
+
+try:
+	refpol.refpolicy2refpol.main()
+except Exception as e:
+	sys.stderr.write(sys.argv[0] + ": Error: " + str(e) + "\n")
+	sys.exit(1)
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
