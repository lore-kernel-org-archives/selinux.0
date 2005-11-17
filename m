Message-ID: <437CAA27.30302@redhat.com>
Date: Thu, 17 Nov 2005 11:04:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Please tell semodule to shut up????
References: <437A7AD5.6040500@cornell.edu> <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070307060301050703080203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070307060301050703080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



-- 



--------------070307060301050703080203
Content-Type: text/x-patch;
 name="policycoreutils-verbose.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-verbose.patch"

--- policycoreutils-1.27.28/audit2allow/audit2allow~	2005-11-16 22:51:28.000000000 -0500
+++ policycoreutils-1.27.28/audit2allow/audit2allow	2005-11-17 10:26:24.000000000 -0500
@@ -65,6 +65,7 @@
 						ret=ret+"NAME=%s  " % x[2]
 					ret=ret + " : " + i 
 		return ret
+		
 	def gettarget(self):
 		if self.source == self.target:
 			return "self"
@@ -75,12 +76,15 @@
 	def __init__(self, input, last_reload=0, verbose=0):
 		self.last_reload=last_reload
 		self.allowRules={}
-		line = input.readline()
-		avc=[]
-		found=0
 		self.seclasses={}
 		self.types=[]
 		self.roles=[]
+		self.load(input)
+		
+	def load(self, input):
+		avc=[]
+		found=0
+		line = input.readline()
 		while line:
 			rec=line.split()
 			for i in rec:
@@ -94,6 +98,7 @@
 				avc=[]
 			line = input.readline()
 				
+
 	def add(self,avc):
 		scon=""
 		tcon=""
@@ -172,23 +177,25 @@
 		if type not in self.types:
 				self.types.append(type)
 
-	def module_out(self, module):
+	def gen_module(self, module):
+		return "module %s 1.0;" % module
+
+	def gen_requires(self):
 		self.roles.sort()
 		self.types.sort()
 		keys=self.seclasses.keys()
 		keys.sort()
-		rec="module %s 1.0;" % module
-		rec+="\n\nrequire {\n"
+		rec="\n\nrequire {\n"
 		for i in self.roles:
 			rec += "\trole %s; \n" % i
 		rec += "\n\n" 
 		for i in keys:
 			access=self.seclasses[i]
 			access.sort()
-			rec+="\tclass %s { " % i
+			rec += "\tclass %s { " % i
 			for a in access:
-				rec+=" %s" % a
-			rec+=" }; \n"
+				rec += " %s" % a
+			rec += " }; \n"
 		rec += "\n\n" 
 			
 		for i in self.types:
@@ -196,65 +203,135 @@
 		rec += " };\n\n\n"
 		return rec
 	
-	def out(self, module):
+	def out(self, require=0, module=""):
 		rec=""
+		if len(self.allowRules.keys())==0:
+		       raise(ValueError("No AVC messages found."))
 		if module!="":
-			rec+=self.module_out(module)
+			rec += self.gen_module(module)
+			rec += self.gen_requires()
+		else:
+			if requires:
+				rec+=self.gen_requires()
+			
 		for i in self.allowRules.keys():
 			rec += self.allowRules[i].out(verbose)+"\n"
 		return rec
 
-def usage():
-	print 'audit2allow [-d] [-v] [-l] [-i <inputfile> ] [-o <outputfile>]\n\
-        -d      read input from output of /bin/dmesg\n\
-        -v      verbose output\n\
-        -l      read input only after last \"load_policy\"\n\
-        -i      read input from <inputfile>\n\
-        -m      module output <modulename>\n\
-        -o      append output to <outputfile>\n'
-	sys.exit(1)
-
-def errorExit(error):
-	sys.stderr.write("%s exiting for: " % sys.argv[0])
-	sys.stderr.write("%s\n" % error)
-	sys.stderr.flush()
-	sys.exit(1)
-
-#
-# This script will generate home dir file context
-# based off the homedir_template file, entries in the password file, and
-#
-try:
-	last_reload=0
-	input=sys.stdin
-	output=sys.stdout
-	module=""
-	verbose=0
-	gopts, cmds = getopt.getopt(sys.argv[1:], 'vdo:hli:m:', ['help',
-						'last_reload='])
-	for o,a in gopts:
-		if o == '--last_reload' or o == "-l":
-			last_reload=1
-		if o == "-v":
-			verbose=1
-		if o == "-i":
-			input=open(a, "r")
-		if o == "-m":
-			module=a
-		if o == '--help':
-			usage()
-		if o == "-d":
-			input=os.popen("/bin/dmesg", "r")
-		if o == "-o":
-			output=open(a, "a")
-	if len(cmds) != 0:
-		usage()
-	out=allowRecords(input, last_reload, verbose)
-	output.write(out.out(module))
-
-except getopt.error, error:
-	errorExit(string.join("Options Error ", error))
-except ValueError, error:
-	errorExit(string.join("ValueError ", error))
-except KeyboardInterrupt, error:
-	sys.exit(0)
+if __name__ == '__main__':
+
+	def usage():
+		print 'audit2allow [-adhilrv] [-i <inputfile> ] [[-m|-M] <modulename> ] [-o <outputfile>]\n\
+		-a, --all        read input from audit and message log, conflicts with -i\n\
+		-d, --dmesg      read input from output of /bin/dmesg\n\
+		-h, --help       display this message\n\
+		-i, --input      read input from <inputfile> conflicts with -a\n\
+		-l, --lastreload read input only after last \"load_policy\"\n\
+		-m, --module     generate module/require output <modulename> \n\
+		-M               generate loadable module package, conflicts with -o\n\
+		-o, --output     append output to <outputfile>, conflicts with -M\n\
+		-r, --requires   generate require output \n\
+		-v, --verbose    verbose output\n\
+		'
+		sys.exit(1)
+		
+	def errorExit(error):
+		sys.stderr.write("%s: " % sys.argv[0])
+		sys.stderr.write("%s\n" % error)
+		sys.stderr.flush()
+		sys.exit(1)
+
+	#
+	# 
+	#
+	try:
+		last_reload=0
+		input=sys.stdin
+		output=sys.stdout
+		module=""
+		requires=0
+		verbose=0
+		auditlogs=0
+		buildPP=0
+		input_ind=0
+		output_ind=0
+		gopts, cmds = getopt.getopt(sys.argv[1:],
+					    'adhi:lm:M:o:rv',
+					    ['all',
+					     'dmesg',
+					     'help',
+					     'input=',
+					     'lastreload',
+					     'module=',
+					     'output=',
+					     'requires'
+					     'verbose'
+					     ])
+		for o,a in gopts:
+			if o == "-a" or o == "--all":
+				if input_ind:
+					usage()
+				input=open("/var/log/messages", "r")
+				auditlogs=1
+			if o == "-d"  or o == "--dmesg":
+				input=os.popen("/bin/dmesg", "r")
+			if o == "-h" or o == "--help":
+				usage()
+			if o == "-i"or o == "--input":
+				if auditlogs:
+					usage()
+				input_ind=1
+				input=open(a, "r")
+			if o == '--lastreload' or o == "-l":
+				last_reload=1
+			if o == "-m" or o == "--module":
+				if module != "":
+					usage()
+				module=a
+			if o == "-M":
+				if module != "" or output_ind:
+					usage()
+				module=a
+				outfile=a+".te"
+				buildPP=1
+				output=open(outfile, "w")
+			if o == "-r" or o == "--requires":
+				requires=1
+			if o == "-o" or o == "--output":
+				if module != "":
+					usage()
+				output=open(a, "a")
+				output_ind=1
+			if o == "-v" or o == "--verbose":
+				verbose=1
+			if len(cmds) != 0:
+				usage()
+		out=allowRecords(input, last_reload, verbose)
+		if auditlogs:
+			input=open("/var/log/audit/audit.log", "r")
+		out.load(input)
+		if buildPP:
+			print ("Generating type enforcment file: %s.te" % module)
+		output.write(out.out(requires, module))
+		if buildPP:
+			print ("Compiling policy: checkmodule -M -m -o %s.mod %s.te" % (module, module))
+			rc=commands.getstatusoutput("checkmodule -M -m -o %s.mod %s.te" % (module, module))
+			if rc[0]==0:
+				print ("Building package: semodule_package -o %s.pp -m %s.mod" % (module, module))
+				rc=commands.getstatusoutput("semodule_package -o %s.pp -m %s.mod" % (module, module))
+				if rc[0]==0:
+					print ("\n*************** IMPORTANT ***********************\n")
+					print ("In order to load this newly created policy package,\nyou are required to execute \n\n\"semodule -i %s.pp\"\n\nto load the policy\n" % module)
+				else:
+					errorExit(rc[1])
+			else:
+				errorExit(rc[1])
+
+	except getopt.error, error:
+		errorExit("Options Error " + error.msg)
+	except ValueError, error:
+		errorExit(error.args[0])
+	except IOError, error:
+		errorExit(error.args[1])
+	except KeyboardInterrupt, error:
+		sys.exit(0)
--- policycoreutils-1.27.28/semodule/semodule.c~	2005-11-16 15:39:03.000000000 -0500
+++ policycoreutils-1.27.28/semodule/semodule.c	2005-11-17 11:02:35.000000000 -0500
@@ -38,7 +38,7 @@
 static int num_commands = 0;
 
 /* options given on command line */
-static int quiet;
+static int verbose;
 static int reload;
 static int no_reload;
 static int build;
@@ -122,7 +122,7 @@
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -n,--noreload	   do not reload policy after commit\n");
         printf("  -h,--help        print this message and quit\n");
-        printf("  -q,--quiet       be quiet\n");
+        printf("  -v,--verbose     be verbose\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -157,7 +157,7 @@
                 {"help", 0, NULL, 'h'},
                 {"install", required_argument, NULL, 'i'},
                 {"list-modules", 0, NULL, 'l'},
-                {"quiet", 0, NULL, 'q'},
+                {"verbose", 0, NULL, 'v'},
                 {"remove", required_argument, NULL, 'r'},
                 {"upgrade", required_argument, NULL, 'u'},
 		{"reload", 0, NULL, 'R'},
@@ -166,7 +166,7 @@
                 {NULL, 0, NULL, 0}
         };
         int i;
-        quiet = 0;
+        verbose = 0;
 	reload = 0;
 	no_reload = 0;
         while ((i = getopt_long(argc, argv, "s:b:hi:lqr:u:RnB", opts, NULL)) != -1) {
@@ -175,7 +175,7 @@
                 case 'h': usage(argv[0]); exit(0);
                 case 'i': set_mode(INSTALL_M, optarg); break;
                 case 'l': set_mode(LIST_M, NULL); break;
-                case 'q': quiet = 1; break;
+                case 'v': verbose = 1; break;
                 case 'r': set_mode(REMOVE_M, optarg); break;
                 case 'u': set_mode(UPGRADE_M,optarg); break;
 		case 's': set_store(optarg); break;
@@ -266,28 +266,28 @@
                 }
                 switch (mode) {
                 case INSTALL_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to install module '%s':\n", mode_arg);
                         }
                         result = semanage_module_install(sh, data, data_len);
                         break;
                 }
                 case UPGRADE_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to upgrade module '%s':\n", mode_arg);
                         }
                         result = semanage_module_upgrade(sh, data, data_len);
                         break;
                 }
                 case BASE_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to install base module '%s':\n", mode_arg);
                         }
                         result = semanage_module_install_base(sh, data, data_len);
                         break;
                 }
                 case REMOVE_M: {
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to remove module '%s':\n", mode_arg);
                         }
                         result = semanage_module_remove(sh, mode_arg);
@@ -296,7 +296,7 @@
                 case LIST_M: {
                         semanage_module_info_t *modinfo;
                         int num_modules;
-                        if (!quiet) {
+                        if (verbose) {
                                 printf("Attempting to list active modules:\n");
                         }
                         if ((result = semanage_module_list(sh, &modinfo, &num_modules)) >= 0) {
@@ -328,13 +328,13 @@
                         fprintf(stderr, "Failed!\n");
                         goto cleanup;
                 }
-                else if (!quiet) {
+                else if (verbose) {
                         printf("Ok: return value of %d.\n", result);
                 }
         }
         
         if (commit) {
-                if (!quiet) {
+                if (verbose) {
                         printf("Committing changes:\n");
                 }
 		if (no_reload) {
@@ -347,7 +347,7 @@
                 fprintf(stderr, "Failed!\n");
                 goto cleanup;
         }
-        else if (commit && !quiet) {
+        else if (commit && verbose) {
                 printf("Ok: transaction number %d.\n", result);
         }
 
--- policycoreutils-1.27.28/scripts/genhomedircon~	2005-11-16 22:33:25.000000000 -0500
+++ policycoreutils-1.27.28/scripts/genhomedircon	2005-11-16 23:21:23.000000000 -0500
@@ -65,12 +65,7 @@
 		homedir = homedir.strip()
 		if not homedir in ret:
 			ret.append(homedir)
-	else:
-		#rc[0] == 256 means the file was there, we read it, but the grep didn't match
-		if rc[0] != 256:
-			sys.stderr.write("%s\n" % rc[1])
-			sys.stderr.write("You do not have access to /etc/default/useradd HOME=\n")
-			sys.stderr.flush()
+
 	rc=commands.getstatusoutput("grep -h '^LU_HOMEDIRECTORY' /etc/libuser.conf")
 	if rc[0] == 0:
 		homedir = rc[1].split("=")[1]
@@ -78,12 +73,7 @@
 		homedir = homedir.strip()
 		if not homedir in ret:
 			ret.append(homedir)
-	else:
-		#rc[0] == 256 means the file was there, we read it, but the grep didn't match
-		if rc[0] != 256:
-			sys.stderr.write("%s\n" % rc[1])
-			sys.stderr.write("You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=\n")
-			sys.stderr.flush()
+
 	if ret == []:
 		ret.append("/home")
 	return ret
@@ -242,9 +232,8 @@
 		if rc[0] == 0:
 			prefix_regex = rc[1].split("\n")
 		else:
-			sys.stderr.write("%s\n" % rc[1])
-			sys.stderr.write("You do not have access to grep/cut/the file contexts\n")
-			sys.stderr.flush()
+			warning("%s\nYou do not have access to read %s\n" % (rc[1], self.getFileContectFile()))
+
 		exists=1
 		for regex in prefix_regex:
 			#match a trailing (/*)? which is actually a bug in rpc_pipefs

--------------070307060301050703080203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
