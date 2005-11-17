Message-ID: <437CA2F6.4070603@redhat.com>
Date: Thu, 17 Nov 2005 10:34:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Audit2allow in python generates module code.
References: <437C0256.509@redhat.com>	 <1132235886.17726.13.camel@moss-spartans.epoch.ncsc.mil> <1132236399.17726.22.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132236399.17726.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000105040908050405020005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000105040908050405020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Thu, 2005-11-17 at 08:58 -0500, Stephen Smalley wrote:
>   
>> On Wed, 2005-11-16 at 23:08 -0500, Daniel J Walsh wrote:
>>     
>>> Added -m <modulename> to output module syntax.
>>>       
>> Ok, so I tried:
>> 	audit2allow -a -m local -o local.te
>> 	checkmodule -M -m -o local.mod local.te
>> 	semodule_package -o local.pp -m local.mod
>> 	semodule -i local.pp
>>     
Added -M which does

audit2allow -a -m local -o local.te
checkmodule -M -m -o local.mod local.te
semodule_package -o local.pp -m local.mod

And tells the user to do:
semodule -i local.pp



>> which appears to have worked, although I think we want a shorthand way
>> of doing the latter steps after the audit2allow.
>>
>> A couple of questions/suggestions:
>> - What if I want to append further rules later to my local.te file and
>> rebuild that module?  That still needs to turn on the generation of
>> require statements, but not add another module statement.  That is why I
>> suggested having two separate options, one to turn on require statements
>> and one to turn on module statements (the latter could imply the former
>> as well).  Possibly a -r option to just generate require statements w/o
>> adding another module statement?
>>
>>     
Added -r
>> - What about versioning of local.te (or do we not care)?  Should
>> audit2allow check whether the output file already exists and if so, read
>> the current module statement from it and increment the version?  Or
>> leave that to the user to do manually if they want versioning? 
>>
>>     
User will need to do this.
>> Minor nit:  There is a cut-and-paste leftover in the audit2allow python
>> script from genhomedircon (a comment about home dir file context,
>> homedir_template, etc).
>>     
>
>   
Removed
> BTW, error handling seems broken, e.g.:
> 	audit2allow -m # forgot to include a module name
> yields:
> Traceback (most recent call last):
>   File "./audit2allow", line 268, in ?
>     errorExit(string.join("Options Error ", error))
>   File "/usr/lib/python2.4/string.py", line 318, in join
>     return sep.join(words)
> AttributeError: GetoptError instance has no attribute 'join'
>
>   
Added more error checking and fixed some bugs.

-- 



--------------000105040908050405020005
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.27.28/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.28/audit2allow/audit2allow	2005-11-17 10:26:24.000000000 -0500
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
@@ -17,148 +22,316 @@
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
+	def gen_module(self, module):
+		return "module %s 1.0;" % module
+
+	def gen_requires(self):
+		self.roles.sort()
+		self.types.sort()
+		keys=self.seclasses.keys()
+		keys.sort()
+		rec="\n\nrequire {\n"
+		for i in self.roles:
+			rec += "\trole %s; \n" % i
+		rec += "\n\n" 
+		for i in keys:
+			access=self.seclasses[i]
+			access.sort()
+			rec += "\tclass %s { " % i
+			for a in access:
+				rec += " %s" % a
+			rec += " }; \n"
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
-
+	def out(self, require=0, module=""):
+		rec=""
+		if len(self.allowRules.keys())==0:
+		       raise(ValueError("No AVC messages found."))
+		if module!="":
+			rec += self.gen_module(module)
+			rec += self.gen_requires()
+		else:
+			if requires:
+				rec+=self.gen_requires()
+			
+		for i in self.allowRules.keys():
+			rec += self.allowRules[i].out(verbose)+"\n"
+		return rec
+
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
+++ policycoreutils-1.27.28/scripts/genhomedircon	2005-11-16 23:21:23.000000000 -0500
@@ -29,7 +29,9 @@
 import commands, sys, os, pwd, string, getopt, re
 from semanage import *;
 
-EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
+fd=open("/etc/shells", 'r')
+VALID_SHELLS=fd.read().split('\n')
+fd.close()
 
 def getStartingUID():
 	starting_uid = sys.maxint
@@ -63,12 +65,7 @@
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
@@ -76,12 +73,7 @@
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
@@ -240,9 +232,8 @@
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
@@ -272,7 +263,7 @@
 		ulist = pwd.getpwall()
 		for u in ulist:
 			if u[2] >= starting_uid and \
-					not u[6] in EXCLUDE_LOGINS and \
+					u[6] in VALID_SHELLS and \
 					u[5] != "/" and \
 					string.count(u[5], "/") > 1:
 				homedir = u[5][:string.rfind(u[5], "/")]

--------------000105040908050405020005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
