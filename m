Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m16Fo2BR018377
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 10:50:02 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m16Fo1o8024659
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 15:50:02 GMT
Received: from ns.i.cz (brana.i.cz [193.179.36.134])
	by vidle.i.cz (Postfix) with ESMTP id AFE011CCD0
	for <selinux@tycho.nsa.gov>; Wed,  6 Feb 2008 16:49:57 +0100 (CET)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 80A305C05
	for <selinux@tycho.nsa.gov>; Wed,  6 Feb 2008 16:49:57 +0100 (CET)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1JMmX7-0008DK-6e
	for selinux@tycho.nsa.gov; Wed, 06 Feb 2008 16:49:57 +0100
Date: Wed, 6 Feb 2008 16:49:57 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: fixfiles: broken option processing?
Message-ID: <20080206154957.GA28647@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I'm fighting with current fixfiles script. This script is called on
Debian from init scripts (/etc/init.d/selinux-basics) when
autorelabeling is requested in the following shape:

    /sbin/fixfiles -f -F relabel > /dev/null || true

With current version r2760, this never succeed at least on Debian. It
seems to me, that getopts is used with shifting arguments improperly.
Help for getopts says, that successive calls to getopts sets OPTIND on
next option. When arguments are shifted without reasigning OPTIND to 1,
bad argument is processed.

Please consider my patch. I distiled this code from some autoconf
output. This supports long options and leaves only non option arguments.
No bashism. Code needs review. I'm not certain how effective code should
be for very long argument list.

If this patch is not usable, original code can be fixed by removing
shift commands from processing or reasigning 1 to OPTIND, but man page
should be fixed, so that options must precede command.

Cheers.
-- 
Zito

--azLHFNyN32YCQGCU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fixfiles.optproc.patch"

Index: fixfiles
===================================================================
--- fixfiles	(revision 2790)
+++ fixfiles	(working copy)
@@ -20,6 +20,8 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
+progname=$(basename $0)
+
 #
 # Set global Variables
 #
@@ -186,60 +188,61 @@
 esac
 }
 usage() {
-      	echo $"Usage: $0 [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
+      	echo $"Usage: $progname [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
 	echo or
-      	echo $"Usage: $0 -R rpmpackage[,rpmpackage...] -C PREVIOUS_FILECONTEXT [-l logfile ] [-o outputfile ] { check | restore }"
+      	echo $"Usage: $progname -R rpmpackage[,rpmpackage...] -C PREVIOUS_FILECONTEXT [-l logfile ] [-o outputfile ] { check | restore }"
 }
 
-if [ $# = 0 ]; then
-	usage
-	exit 1
-fi
 
 # See how we were called.
-while getopts "C:Ffo:R:l:" i; do
-    case "$i" in
-	f)
-		fullFlag=1
-		shift 1
-		;;
-        R)
-		RPMFILES=$OPTARG
-		shift 2
-		;;
-        o)
-		OUTFILES=$OPTARG
-		shift 2
-		;;
-        l)
-		LOGFILE=$OPTARG
-		shift 2
-		;;
-        C)
-		PREFC=$OPTARG
-		shift 2
-		;;
-	F)
-		FORCEFLAG="-F"
-		shift 1
-		;;
-	*)
-	    usage
-	    exit 1
-esac
+opt_prev=
+i=0
+for arg
+do
+    let i=i+1
+    if test -n "$opt_prev"
+    then
+        eval "$opt_prev=\$arg"
+        opt_prev=
+        continue
+    fi
+    case $arg in
+	-f|--full) fullFlag=1 ;;
+	-R|--rpm-files) opt_prev=RPMFILES ;;
+	-o|--out-file) opt_prev=OUTFILES ;;
+	-l|--log-file) opt_prev=LOGFILE ;;
+	-C|--prev-fc) opt_prev=PREFC ;;
+	-F|--force) FORCEFLAG="-F" ;;
+        -h|--help) usage; exit 0 ;;
+        -*)
+            echo "$progname: error: unrecognized option: $arg
+Try \`$progname --help' for more information." >&2
+            exit 1
+            ;;
+        *) noa="$noa \${$i}" ;;
+    esac
 done
 
+eval set -- $noa
+
+if test $# -lt 1
+then
+    usage
+    exit 1
+fi
+
 # Check for the command
-command=$1
-if [ -z $command ]; then
+command="$1"
+if [ -z "$command" ]; then
     usage
+    exit 1
 fi
+shift 1
 
 #
 # check if they specified both DIRS and RPMFILES
 #
 
-shift 1
 if [ ! -z "$RPMFILES" ]; then
     process $command
     if [ $# -gt 0 ]; then

--azLHFNyN32YCQGCU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
