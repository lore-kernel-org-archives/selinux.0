Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7KM3ALv023034
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2008 18:03:10 -0400
Subject: Re: Make Dummy Policy
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov, "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <48AC9124.1000109@schaufler-ca.com>
References: <1219262296.2609.148.camel@moss-terrapins.epoch.ncsc.mil>
	 <48AC9124.1000109@schaufler-ca.com>
Content-Type: multipart/mixed; boundary="=-so4Q/6E0snxht2w1/Yfm"
Date: Wed, 20 Aug 2008 17:45:28 -0400
Message-Id: <1219268728.13542.5.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-so4Q/6E0snxht2w1/Yfm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2008-08-20 at 14:48 -0700, Casey Schaufler wrote:
> David P. Quigley wrote:
> > Back in August of 2006 Serge posted a patch to this list which generates
> > a bare minimum policy based on the flask definition headers in the Linux
> > kernel tree. While I was at OLS someone had mentioned that they wanted
> > an easy way to generate a bare minimum policy that they could then carve
> > up as they wanted. I have taken Serge's patch and have updated it to
> > work with the latest Linux Kernel. 
> >
> > For those interested in the changes there were only two significant
> > changes. The first is that the iteration through the list of classes
> > used NULL as a sentinel value. The problem with this is that the
> > class_to_string array actually has NULL entries in its table as place
> > holders for the user space object classes.
> >
> > The second change was that it would seem at some point the initial sids
> > table was NULL terminated. This is no longer the case so that iteration
> > has to be done on array length instead of looking for NULL.
> >
> > Some statistics on the policy that it generates:
> >
> > The policy consists of 523 lines which contain no blank lines. Of those
> > 523 lines 453 of them are class, permission, and initial sid
> > definitions. These lines are usually little to no concern to the policy
> > developer since they will not be adding object classes or permissions.
> > Of the remaining 70 lines there is one type, one role, and one user
> > statement. The remaining lines are broken into three portions. The first
> > group are TE allow rules which make up 29 of the remaining lines, the
> > second is assignment of labels to the initial sids which consist of 27
> > lines, and file system labeling statements which are the remaining 11.
> >
> > In addition to the policy.conf generated there is a single file_contexts
> > file containing two lines which labels the entire system with base_t.
> >
> > This policy generates a policy.23 binary that is 7920 bytes.
> >
> > Dave
> >   
> 
> Thank you. I noticed that class "capability2" is defined but
> never used. Is this intentional?

Ok here is a fixed version of the program. It increases the TE allow
rules to 47 from 29 so it isn't much larger and increases the policy.23
file to 8136 bytes.

Dave

--=-so4Q/6E0snxht2w1/Yfm
Content-Disposition: attachment; filename=mdp.patch
Content-Type: text/x-patch; name=mdp.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/Makefile b/Makefile
index 53bf6ec..2a23083 100644
--- a/Makefile
+++ b/Makefile
@@ -1655,6 +1655,13 @@ clean := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.clean obj
 
 endif	# skip-makefile
 
+selinux_policy:
+	cd $(srctree)/scripts/selinux; sh ./compile_policy.sh
+
+selinux_install: selinux_policy
+	cd $(srctree)/scripts/selinux; sh ./install_policy.sh
+
+
 PHONY += FORCE
 FORCE:
 
diff --git a/scripts/selinux/compile_policy.sh b/scripts/selinux/compile_policy.sh
new file mode 100644
index 0000000..ab385cb
--- /dev/null
+++ b/scripts/selinux/compile_policy.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+CP=`which checkpolicy`
+POLICYVERS=`cat /selinux/policyvers`
+if [ $? -eq 1 ]; then
+	echo "no selinux tools installed"
+	exit 1
+fi
+
+cd mdp
+sh ./build.sh -k ../../..
+if [ $? -ne 0 ]; then
+	echo "Failure building dummy policy."
+	exit 1
+fi
+$CP -o policy.`checkpolicy -V | awk '{print $1}'` policy.conf
diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
new file mode 100644
index 0000000..abbd10e
--- /dev/null
+++ b/scripts/selinux/install_policy.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+if [ `id -u` -ne 0 ]; then
+	echo "$0: must be root to install the selinux policy"
+	exit 1
+fi
+SF=`which setfiles`
+if [ $? -eq 1 ]; then
+	if [ -f /usr/sbin/setfiles ]; then
+		SF="/usr/sbin/setfiles"
+	else
+		echo "no selinux tools installed: setfiles"
+		exit 1
+	fi
+fi
+
+cd mdp
+
+mkdir -p /etc/selinux/dummy/policy
+mkdir -p /etc/selinux/dummy/contexts/files
+
+cp file_contexts /etc/selinux/dummy/contexts/files
+cp policy.20 /etc/selinux/dummy/policy
+FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
+if [ ! -f $FC_FILE ]; then
+	echo "no file contests file.  Please run"
+	echo "make selinux_policy_install"
+	exit 1
+fi
+
+cd /etc/selinux/dummy/contexts/files
+$SF file_contexts /
+
+mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs" | awk '{ print $2 '}`
+for line in $mounts; do
+	$SF file_contexts $line
+done
+
+dodev=`cat /proc/$$/mounts | grep "/dev "`
+if [ "eq$dodev" != "eq" ]; then
+	mount --move /dev /mnt
+	$SF file_contexts /dev
+	mount --move /mnt /dev
+fi
+
diff --git a/scripts/selinux/mdp/build.sh b/scripts/selinux/mdp/build.sh
new file mode 100644
index 0000000..8c82961
--- /dev/null
+++ b/scripts/selinux/mdp/build.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+usage() {
+	echo "Usage: mdp -k <kernel_dir> [-m]"
+	exit 1
+}
+
+polf="policy.conf"
+ctxf="file_contexts"
+mls=0
+kerneldir=""
+while [ 1 ]; do
+	getopts k:m name
+	if [ $? -gt 0 ]; then
+		break 2
+	fi
+	if [ $name == "m" ]; then
+		mls=1;
+		echo "Making mls policy"
+	elif [ $name == "k" ]; then
+		kerneldir=$OPTARG
+		echo "Using kernel under $kerneldir"
+	else
+		echo "bogus argument \"$name\""
+		usage
+	fi
+done
+
+if [ -z $kerneldir ]; then
+	if [ ! -d "../linux" ]; then
+		echo "No kernel directory specified and ../linux does not exist."
+		usage
+	fi
+	$kerneldir="../linux"
+fi
+
+secd="$kerneldir/security"
+seld="$secd/selinux"
+incd="$seld/include"
+if [ ! -d "$kerneldir" -o ! -d "$secd" -o ! -d "$seld" -o ! -d "$incd" ]; then
+	echo "$incd does not exist"
+	usage
+fi
+
+#echo "char *classlist[] = {" > classlist.h
+#cat $incd/class_to_string.h | sed -e 's/S_(//g' | sed -e 's/)/,/g' >> classlist.h
+#echo "};" >> classlist.h
+
+gcc -I$incd -o mdp mdp.c > makeout 2>&1
+if [ $? -ne 0 ]; then
+	echo "Error compiling mdp.  Please see file \"makeout\" for errors"
+	usage
+fi
+
+if [ $mls -eq 1 ]; then
+	./mdp -m $polf $ctxf > mdpout 2>&1
+else
+	./mdp $polf $ctxf > mdpout 2>&1
+fi
+
+if [ $? -ne 0 ]; then
+	echo "Error running mdp.  Please see \"mdpout\" for errors"
+	usage
+fi
+
+echo "Policy is in $polf and file contexts are in $ctxf."
+echo "Have a nice day."
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
new file mode 100644
index 0000000..6ec6696
--- /dev/null
+++ b/scripts/selinux/mdp/mdp.c
@@ -0,0 +1,236 @@
+/*
+ *
+ * mdp - make dummy policy
+ *
+ * When pointed at a kernel tree, builds a dummy policy for that kernel
+ * with exactly one type with full rights to itself.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Authors: Serge E. Hallyn <serue@us.ibm.com>
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+#include "flask.h"
+
+void usage(char *name)
+{
+	printf("usage: %s [-m] policy_file context_file\n", name);
+	exit(1);
+}
+
+void find_common_name(char *cname, char *dest, int len)
+{
+	char *start, *end;
+	
+	start = strchr(cname, '_')+1;
+	end = strchr(start, '_');
+	if (!start || !end || start-cname > len || end-start > len) {
+		printf("Error with commons defines\n");
+		exit(1);
+	}
+	strncpy(dest, start, end-start);
+	dest[end-start] = '\0';
+}
+
+#define S_(x) x,
+static char *classlist[] = {
+#include "class_to_string.h"
+	NULL
+};
+#undef S_
+
+#include "initial_sid_to_string.h"
+
+#define TB_(x) char *x[] = {
+#define TE_(x) NULL };
+#define S_(x) x,
+#include "common_perm_to_string.h"
+#undef TB_
+#undef TE_
+#undef S_
+
+struct common {
+	char *cname;
+	char **perms;
+};
+struct common common[] = {
+#define TB_(x) { #x, x },
+#define S_(x) 
+#define TE_(x)
+#include "common_perm_to_string.h"
+#undef TB_
+#undef TE_
+#undef S_
+};
+
+#define S_(x, y, z) {x, #y},
+struct av_inherit {
+	int class;
+	char *common;
+};
+struct av_inherit av_inherit[] = {
+#include "av_inherit.h"
+};
+#undef S_
+
+#include "av_permissions.h"
+#define S_(x, y, z) {x, y, z},
+struct av_perms {
+	int class;
+	int perm_i;
+	char *perm_s;
+};
+struct av_perms av_perms[] = {
+#include "av_perm_to_string.h"
+};
+#undef S_
+
+int main(int argc, char *argv[])
+{
+	int i, j, mls = 0;
+	char **arg, *polout, *ctxout;
+	int classlist_len, initial_sid_to_string_len;
+	FILE *fout;
+
+	if (argc < 3)
+		usage(argv[0]);
+	arg = argv+1;
+	if (argc==4 && strcmp(argv[1], "-m") == 0) {
+		mls = 1;
+		arg++;
+	}
+	polout = *arg++;
+	ctxout = *arg;
+
+	fout = fopen(polout, "w");
+	if (!fout) {
+		printf("Could not open %s for writing\n", polout);
+		usage(argv[0]);
+	}
+
+	classlist_len = sizeof(classlist) / sizeof(char *);
+	/* print out the classes */
+	for (i=0; i < classlist_len; i++) {
+		if(classlist[i])
+			fprintf(fout, "class %s\n", classlist[i]);
+	}
+	fprintf(fout, "\n");
+
+	initial_sid_to_string_len = sizeof(initial_sid_to_string) / sizeof (char *);
+	/* print out the sids */
+	for (i=1; i < initial_sid_to_string_len; i++) 
+		fprintf(fout, "sid %s\n", initial_sid_to_string[i]);
+	fprintf(fout, "\n");
+
+	/* print out the commons */
+	for (i=0; i< sizeof(common)/sizeof(struct common); i++) {
+		char cname[101];
+		find_common_name(common[i].cname, cname, 100);
+		cname[100] = '\0';
+		fprintf(fout, "common %s\n{\n", cname);
+		for (j=0; common[i].perms[j]; j++)
+			fprintf(fout, "\t%s\n", common[i].perms[j]);
+		fprintf(fout, "}\n\n");
+	}
+	fprintf(fout, "\n");
+
+	/* print out the class permissions */
+	for (i=1; i < classlist_len; i++) {
+		if (classlist[i]) {
+			int firstperm = -1, numperms = 0;
+
+			fprintf(fout, "class %s\n", classlist[i]);
+			/* does it inherit from a common? */
+			for (j=0; j < sizeof(av_inherit)/sizeof(struct av_inherit); j++)
+				if (av_inherit[j].class == i)
+					fprintf(fout, "inherits %s\n", av_inherit[j].common);
+
+			for (j=0; j < sizeof(av_perms)/sizeof(struct av_perms); j++) {
+				if (av_perms[j].class == i) {
+					if (firstperm == -1)
+						firstperm = j;
+					numperms++;
+				}
+			}
+			if (!numperms) {
+				fprintf(fout, "\n");
+				continue;
+			}
+
+			fprintf(fout, "{\n");
+			/* print out the av_perms */
+			for (j=0; j < numperms; j++) {
+				fprintf(fout, "\t%s\n", av_perms[firstperm+j].perm_s);
+			}
+			fprintf(fout, "}\n\n");
+		}
+	}
+	fprintf(fout, "\n");
+
+	/* NOW PRINT OUT MLS STUFF */
+	if (mls) {
+		printf("MLS not yet implemented\n");
+		exit(1);
+	}
+
+	/* types, roles, and allows */
+	fprintf(fout, "type base_t;\n");
+	fprintf(fout, "role base_r types { base_t };\n");
+	for (i=1; i < classlist_len; i++) {
+		if (classlist[i])
+			fprintf(fout, "allow base_t base_t:%s *;\n", classlist[i]);
+	}
+	fprintf(fout, "user user_u roles { base_r };\n");
+	fprintf(fout, "\n");
+
+	/* default sids */
+	for (i=1; i < initial_sid_to_string_len; i++)
+		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
+	fprintf(fout, "\n");
+
+
+	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
+
+	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
+
+	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
+
+	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
+
+	fclose(fout);
+
+	fout = fopen(ctxout, "w");
+	if (!fout) {
+		printf("Wrote policy, but cannot open %s for writing\n");
+		usage(argv[0]);
+	}
+	fprintf(fout, "/ user_u:base_r:base_t\n");
+	fprintf(fout, "/.* user_u:base_r:base_t\n");
+	fclose(fout);
+
+	return 0;
+}

--=-so4Q/6E0snxht2w1/Yfm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
