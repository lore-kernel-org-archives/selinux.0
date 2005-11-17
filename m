Message-ID: <437C0256.509@redhat.com>
Date: Wed, 16 Nov 2005 23:08:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Audit2allow in python generates module code.
Content-Type: multipart/mixed;
 boundary="------------010301040709050602040109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010301040709050602040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added -m <modulename> to output module syntax.

Dan

-- 



--------------010301040709050602040109
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.27.28/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.28/audit2allow/audit2allow	2005-11-16 23:07:04.000000000 -0500
@@ -1,7 +1,12 @@
-#!/usr/bin/perl
-
-#    Adapted from:
+#! /usr/bin/env python
+# Copyright (C) 2005 Red Hat 
+# see file 'COPYING' for use and warranty information
+#
+# Audit2allow is a rewrite of prior perl script.
+#
+# Based off original audit2allow perl script: which credits
 #    newrules.pl, Copyright (C) 2001 Justin R. Smith (jsmith@mcs.drexel.edu)
+#    2003 Oct 11: Add -l option by Yuichi Nakamura(ynakam@users.sourceforge.jp)
 #
 #    This program is free software; you can redistribute it and/or
 #    modify it under the terms of the GNU General Public License as
@@ -17,148 +22,255 @@
 #    along with this program; if not, write to the Free Software
 #    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA     
 #                                        02111-1307  USA
-#    2003 Oct 11: Add -l option by Yuichi Nakamura(ynakam@users.sourceforge.jp)
-
-
-$load_policy_pattern="avc:.*granted.*{.*load_policy.*}";
-
-while ($opt = shift @ARGV) {
-        if ($opt eq "-d") { $read_dmesg++; }
-        elsif ($opt eq "-v") { $verbose++; }
-        elsif ($opt eq "-i") { $input = shift @ARGV; }
-        elsif ($opt eq "-o") { $output= shift @ARGV; }
-	elsif ($opt eq "-l") { $load_policy++; }
-	elsif ($opt eq "--help") { &printUsage; }
-		else  { print "unknown option, '$opt'\n\n"; &printUsage; }
-}
-
-if ($read_dmesg && $input) {
-	print "Error, can't read from both dmesg and $input\n\n";
-	&printUsage;
-}
-
-if ($read_dmesg) { open (IN, "/bin/dmesg|"); } 
-elsif ($input)   { open (IN, "$input");      }
-else             { open (IN, "-");           }  # STDIN
-
-if ($output)     { open (OUT, ">>$output");   }
-else             { open (OUT, ">-");         }  # STDOUT
-
-if($load_policy){ #store logs after last "load_policy" in @log_buf
-    while ($line = <IN>) {
-	if($line=~/$load_policy_pattern/) {
-	     #stored logs are unnecessary
-	     undef @log_buf;
-	}
-	else
-	{
-	    push @log_buf,$line;
-	}
-    }
-}
-
-while ($line=&readNewline) {
-    next unless ($line =~ m/avc:\s*denied\s*\{((\w|\s)*)\}/);
-    @types=split /\ /,$line;
-    $info="";
-    $group="";
-    $command="";
-    foreach $i(0..$#types){
-	next if($types[$i]!~/[=\{]/);
-       if($types[$i]=~/^\{/){
-	    $j=$i+1;
-	    while($types[$j]!~/\}/){
-		$command.=" $types[$j]";
-		$j++;
-	    }
-	    next;
-	}
-	my($a,$b) = split /=/,$types[$i];
-	
-	next if($a eq "pid");
-	next if($a eq "dev");
-	next if($a eq "ino");
+#
+#  
+import commands, sys, os, pwd, string, getopt, re
+class allow:
+	def __init__(self, source, target, seclass):
+		self.source=source
+		self.target=target
+		self.seclass=seclass
+		self.avcinfo={}
+	def add(self, avc):
+		for a in avc[0]:
+			if a not in self.avcinfo.keys():
+				self.avcinfo[a]=[]
+
+			self.avcinfo[a].append(avc[1:])
+
+	def getAccess(self):
+		if len(self.avcinfo.keys()) == 1:
+			for i in self.avcinfo.keys():
+				return i
+		else:
+			keys=self.avcinfo.keys()
+			keys.sort()
+			ret="{"
+			for i in keys:
+				ret=ret + " " + i				
+			ret=ret+" }"
+			return ret
+	def out(self, verbose=0):
+		ret=""
+		ret=ret+"allow %s %s:%s %s;" % (self.source, self.gettarget(), self.seclass, self.getAccess())
+		if verbose:
+			keys=self.avcinfo.keys()
+			keys.sort()
+			for i in keys:
+				for x in self.avcinfo[i]:
+					ret=ret+"\n\t#TYPE=AVC  MSG=%s  " % x[0]
+					if len(x[1]):
+						ret=ret+"COMM=%s  " % x[1]
+					if len(x[2]):
+						ret=ret+"NAME=%s  " % x[2]
+					ret=ret + " : " + i 
+		return ret
+		
+	def gettarget(self):
+		if self.source == self.target:
+			return "self"
+		else:
+			return self.target
 	
-	if(($a eq "scontext")||($a eq "tcontext")||($a eq "tclass")){
-	    if($a ne "tclass"){
-		my($c,$c,$c) = split /:/, $b;
-		$b=$c;
-	    }
-	    $b=~s/\n//;
-	    $group.="|$b";
-	    next;
-	}
-	$b=~s/:\[\d+\]//;
-	$a=uc $a;
-	$info.="$a=$b  "; 
-    }
-    
-    my($c,$c,$c,$c) = split /\|/, $group;
-    $info=~s/\ $c=\S+\ //gi;
-    # escape regexp patterns --<g>
-    $info=~s/([^\w])/\\$1/g;
-   
-    @atypes=split /\ /,$command;
-    foreach $i(0..$#atypes){
-	$rules{$group}{$atypes[$i]}++;
-    }
-    
-    $info.=" ";
-    if($occur{$group}!~$info){
-	$occur{$group}.="\t#$info: $command\n";
-    }
-    else{	
-	my ($a,$b) = split /$info:\ /, $occur{$group};
-	my ($temp) = split /\n/, $b;
+class allowRecords:
+	def __init__(self, input, last_reload=0, verbose=0):
+		self.last_reload=last_reload
+		self.allowRules={}
+		self.seclasses={}
+		self.types=[]
+		self.roles=[]
+		self.load(input)
+		
+	def load(self, input):
+		avc=[]
+		found=0
+		line = input.readline()
+		while line:
+			rec=line.split()
+			for i in rec:
+				if i=="avc:" or i=="message=avc:":
+					found=1
+				else:
+					avc.append(i)
+			if found:
+				self.add(avc)
+				found=0
+				avc=[]
+			line = input.readline()
+				
+
+	def add(self,avc):
+		scon=""
+		tcon=""
+		seclass=""
+		comm=""
+		name=""
+		msg=""
+		access=[]
+		if "security_compute_sid" in avc:
+			return
+		
+		if "granted" in avc:
+			if "load_policy" in avc and self.last_reload:
+				self.allowRules={}
+			return
+		for i in range (0, len(avc)):
+			if avc[i]=="{":
+				i=i+1
+				while i<len(avc) and avc[i] != "}":
+					access.append(avc[i])
+					i=i+1
+				continue
+			
+			t=avc[i].split('=')
+			if len(t) < 2:
+				continue
+			if t[0]=="scontext":
+				context=t[1].split(":")
+				scon=context[2]
+				srole=context[1]
+				continue
+			if t[0]=="tcontext":
+				context=t[1].split(":")
+				tcon=context[2]
+				trole=context[1]
+				continue
+			if t[0]=="tclass":
+				seclass=t[1]
+				continue
+			if t[0]=="comm":
+				comm=t[1]
+				continue
+			if t[0]=="name":
+				name=t[1]
+				continue
+			if t[0]=="msg":
+				msg=t[1]
+				continue
+
+		if scon=="" or tcon =="" or seclass=="":
+			return
+
+		self.add_seclass(seclass, access)
+		self.add_type(tcon)
+		self.add_type(scon)
+		self.add_role(srole)
+		self.add_role(trole)
+		
+		if (scon, tcon, seclass) not in self.allowRules.keys():
+			self.allowRules[(scon, tcon, seclass)]=allow(scon, tcon, seclass)
+				
+		self.allowRules[(scon, tcon, seclass)].add((access, msg, comm, name ))
+
+	def add_seclass(self,seclass, access):
+		if seclass not in self.seclasses.keys():
+				self.seclasses[seclass]=[]
+		for a in access:
+			if a not in self.seclasses[seclass]:
+				self.seclasses[seclass].append(a)
+				
+	def add_role(self,role):
+		if role not in self.roles:
+				self.roles.append(role)
+
+	def add_type(self,type):
+		if type not in self.types:
+				self.types.append(type)
+
+	def module_out(self, module):
+		self.roles.sort()
+		self.types.sort()
+		keys=self.seclasses.keys()
+		keys.sort()
+		rec="module %s 1.0;" % module
+		rec+="\n\nrequire {\n"
+		for i in self.roles:
+			rec += "\trole %s; \n" % i
+		rec += "\n\n" 
+		for i in keys:
+			access=self.seclasses[i]
+			access.sort()
+			rec+="\tclass %s { " % i
+			for a in access:
+				rec+=" %s" % a
+			rec+=" }; \n"
+		rec += "\n\n" 
+			
+		for i in self.types:
+			rec += "\ttype %s; \n" % i
+		rec += " };\n\n\n"
+		return rec
 	
-	@com=split /\ /, $command;
-	foreach $i(1..$#com){
-	    $b=" $com[$i]$b" if($temp!~$com[$i]);
-	}
-	$occur{$group}="$a$info: $b";
-    }
-}
-
-# done  with the input file
-# now generate the rules
-foreach $k (sort keys %rules)
-{ 
-    my ($a,$scontext,$tcontext,$tclass) = split /\|/, $k;
-    if ($scontext eq $tcontext) {
-        $tcontext = 'self';
-    }
-    print OUT  "allow $scontext $tcontext:$tclass";
-    
-    my $access_types = $rules{$k};
-    $len=(keys %$access_types);
-    if ($len gt 2 ) { print OUT  " {"; }
-    foreach $t (sort keys %$access_types) {
-      if ($t ne "") {print OUT  " $t";}
-    }
-    if ($len gt 2 ) { print OUT " }"; }
-    print OUT ";\n";
-    $occur{$k} =~ s/\\(.)/$1/g;  # de-escape string
-    print OUT "$occur{$k}\n" if ($verbose);
-}
-
-exit;
-
-sub readNewline {
-    if($load_policy){
-	$newline=shift @log_buf;
-    }else{
-	$newline=<IN>;
-    }
-    return $newline;
-}
-
-sub printUsage {
-	print "audit2allow [-d] [-v] [-l] [-i <inputfile> ] [-o <outputfile>]
-        -d      read input from output of /bin/dmesg
-        -v      verbose output
-        -l      read input only after last \"load_policy\"
-        -i      read input from <inputfile>
-        -o      append output to <outputfile>\n";
-	exit;
-}
+	def out(self, module):
+		rec=""
+		if module!="":
+			rec+=self.module_out(module)
+		for i in self.allowRules.keys():
+			rec += self.allowRules[i].out(verbose)+"\n"
+		return rec
+
+def usage():
+	print 'audit2allow [-a] [-d] [-l] [-v] [-i <inputfile> ] [-m <modulename> ] [-o <outputfile>]\n\
+        -a      read input from audit and message log\n\
+        -d      read input from output of /bin/dmesg\n\
+        -i      read input from <inputfile> conflicts with -a\n\
+        -l      read input only after last \"load_policy\"\n\
+        -m      module output <modulename> \n\
+        -o      append output to <outputfile>\n\
+        -v      verbose output\n\
+	'
+	sys.exit(1)
+
+def errorExit(error):
+	sys.stderr.write("%s exiting for: " % sys.argv[0])
+	sys.stderr.write("%s\n" % error)
+	sys.stderr.flush()
+	sys.exit(1)
 
+#
+# This script will generate home dir file context
+# based off the homedir_template file, entries in the password file, and
+#
+try:
+	last_reload=0
+	input=sys.stdin
+	output=sys.stdout
+	module=""
+	verbose=0
+	auditlogs=0
+	gopts, cmds = getopt.getopt(sys.argv[1:], 'avdo:hli:m:', ['help',
+						'last_reload='])
+	for o,a in gopts:
+		if o == '--last_reload' or o == "-l":
+			last_reload=1
+		if o == "-v":
+			verbose=1
+		if o == "-a":
+			input=open("/var/log/messages", "r")
+			auditlogs=1
+		if o == "-i":
+			if auditlogs:
+				usage()
+			input=open(a, "r")
+		if o == "-m":
+			module=a
+		if o == '--help':
+			usage()
+		if o == "-d":
+			input=os.popen("/bin/dmesg", "r")
+		if o == "-o":
+			output=open(a, "a")
+	if len(cmds) != 0:
+		usage()
+	out=allowRecords(input, last_reload, verbose)
+	if auditlogs:
+		input=open("/var/log/audit/audit.log", "r")
+	out.load(input)
+	output.write(out.out(module))
+
+except getopt.error, error:
+	errorExit(string.join("Options Error ", error))
+except ValueError, error:
+	errorExit(string.join("ValueError ", error))
+except KeyboardInterrupt, error:
+	sys.exit(0)
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow.perl policycoreutils-1.27.28/audit2allow/audit2allow.perl
--- nsapolicycoreutils/audit2allow/audit2allow.perl	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.28/audit2allow/audit2allow.perl	2005-11-16 22:33:25.000000000 -0500
@@ -0,0 +1,164 @@
+#!/usr/bin/perl
+
+#    Adapted from:
+#    newrules.pl, Copyright (C) 2001 Justin R. Smith (jsmith@mcs.drexel.edu)
+#
+#    This program is free software; you can redistribute it and/or
+#    modify it under the terms of the GNU General Public License as
+#    published by the Free Software Foundation; either version 2 of
+#    the License, or (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License
+#    along with this program; if not, write to the Free Software
+#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA     
+#                                        02111-1307  USA
+#    2003 Oct 11: Add -l option by Yuichi Nakamura(ynakam@users.sourceforge.jp)
+
+
+$load_policy_pattern="avc:.*granted.*{.*load_policy.*}";
+
+while ($opt = shift @ARGV) {
+        if ($opt eq "-d") { $read_dmesg++; }
+        elsif ($opt eq "-v") { $verbose++; }
+        elsif ($opt eq "-i") { $input = shift @ARGV; }
+        elsif ($opt eq "-o") { $output= shift @ARGV; }
+	elsif ($opt eq "-l") { $load_policy++; }
+	elsif ($opt eq "--help") { &printUsage; }
+		else  { print "unknown option, '$opt'\n\n"; &printUsage; }
+}
+
+if ($read_dmesg && $input) {
+	print "Error, can't read from both dmesg and $input\n\n";
+	&printUsage;
+}
+
+if ($read_dmesg) { open (IN, "/bin/dmesg|"); } 
+elsif ($input)   { open (IN, "$input");      }
+else             { open (IN, "-");           }  # STDIN
+
+if ($output)     { open (OUT, ">>$output");   }
+else             { open (OUT, ">-");         }  # STDOUT
+
+if($load_policy){ #store logs after last "load_policy" in @log_buf
+    while ($line = <IN>) {
+	if($line=~/$load_policy_pattern/) {
+	     #stored logs are unnecessary
+	     undef @log_buf;
+	}
+	else
+	{
+	    push @log_buf,$line;
+	}
+    }
+}
+
+while ($line=&readNewline) {
+    next unless ($line =~ m/avc:\s*denied\s*\{((\w|\s)*)\}/);
+    @types=split /\ /,$line;
+    $info="";
+    $group="";
+    $command="";
+    foreach $i(0..$#types){
+	next if($types[$i]!~/[=\{]/);
+       if($types[$i]=~/^\{/){
+	    $j=$i+1;
+	    while($types[$j]!~/\}/){
+		$command.=" $types[$j]";
+		$j++;
+	    }
+	    next;
+	}
+	my($a,$b) = split /=/,$types[$i];
+	
+	next if($a eq "pid");
+	next if($a eq "dev");
+	next if($a eq "ino");
+	
+	if(($a eq "scontext")||($a eq "tcontext")||($a eq "tclass")){
+	    if($a ne "tclass"){
+		my($c,$c,$c) = split /:/, $b;
+		$b=$c;
+	    }
+	    $b=~s/\n//;
+	    $group.="|$b";
+	    next;
+	}
+	$b=~s/:\[\d+\]//;
+	$a=uc $a;
+	$info.="$a=$b  "; 
+    }
+    
+    my($c,$c,$c,$c) = split /\|/, $group;
+    $info=~s/\ $c=\S+\ //gi;
+    # escape regexp patterns --<g>
+    $info=~s/([^\w])/\\$1/g;
+   
+    @atypes=split /\ /,$command;
+    foreach $i(0..$#atypes){
+	$rules{$group}{$atypes[$i]}++;
+    }
+    
+    $info.=" ";
+    if($occur{$group}!~$info){
+	$occur{$group}.="\t#$info: $command\n";
+    }
+    else{	
+	my ($a,$b) = split /$info:\ /, $occur{$group};
+	my ($temp) = split /\n/, $b;
+	
+	@com=split /\ /, $command;
+	foreach $i(1..$#com){
+	    $b=" $com[$i]$b" if($temp!~$com[$i]);
+	}
+	$occur{$group}="$a$info: $b";
+    }
+}
+
+# done  with the input file
+# now generate the rules
+foreach $k (sort keys %rules)
+{ 
+    my ($a,$scontext,$tcontext,$tclass) = split /\|/, $k;
+    if ($scontext eq $tcontext) {
+        $tcontext = 'self';
+    }
+    print OUT  "allow $scontext $tcontext:$tclass";
+    
+    my $access_types = $rules{$k};
+    $len=(keys %$access_types);
+    if ($len gt 2 ) { print OUT  " {"; }
+    foreach $t (sort keys %$access_types) {
+      if ($t ne "") {print OUT  " $t";}
+    }
+    if ($len gt 2 ) { print OUT " }"; }
+    print OUT ";\n";
+    $occur{$k} =~ s/\\(.)/$1/g;  # de-escape string
+    print OUT "$occur{$k}\n" if ($verbose);
+}
+
+exit;
+
+sub readNewline {
+    if($load_policy){
+	$newline=shift @log_buf;
+    }else{
+	$newline=<IN>;
+    }
+    return $newline;
+}
+
+sub printUsage {
+	print "audit2allow [-d] [-v] [-l] [-i <inputfile> ] [-o <outputfile>]
+        -d      read input from output of /bin/dmesg
+        -v      verbose output
+        -l      read input only after last \"load_policy\"
+        -i      read input from <inputfile>
+        -o      append output to <outputfile>\n";
+	exit;
+}
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.27.28/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-11-16 15:27:46.000000000 -0500
+++ policycoreutils-1.27.28/scripts/genhomedircon	2005-11-16 22:33:25.000000000 -0500
@@ -29,7 +29,9 @@
 import commands, sys, os, pwd, string, getopt, re
 from semanage import *;
 
-EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
+fd=open("/etc/shells", 'r')
+VALID_SHELLS=fd.read().split('\n')
+fd.close()
 
 def getStartingUID():
 	starting_uid = sys.maxint
@@ -272,7 +274,7 @@
 		ulist = pwd.getpwall()
 		for u in ulist:
 			if u[2] >= starting_uid and \
-					not u[6] in EXCLUDE_LOGINS and \
+					u[6] in VALID_SHELLS and \
 					u[5] != "/" and \
 					string.count(u[5], "/") > 1:
 				homedir = u[5][:string.rfind(u[5], "/")]

--------------010301040709050602040109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
