Subject: Re: fixfiles: broken option processing?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Marshall Miller <mmiller@tresys.com>,
        "Todd C. Miller" <tmiller@tresys.com>
In-Reply-To: <20080206154957.GA28647@bobek.pm.i.cz>
References: <20080206154957.GA28647@bobek.pm.i.cz>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Feb 2008 16:28:03 -0500
Message-Id: <1202419683.27371.306.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-06 at 16:49 +0100, Václav Ovsík wrote:
> Hi,
> I'm fighting with current fixfiles script. This script is called on
> Debian from init scripts (/etc/init.d/selinux-basics) when
> autorelabeling is requested in the following shape:
> 
>     /sbin/fixfiles -f -F relabel > /dev/null || true
> 
> With current version r2760, this never succeed at least on Debian. It
> seems to me, that getopts is used with shifting arguments improperly.
> Help for getopts says, that successive calls to getopts sets OPTIND on
> next option. When arguments are shifted without reasigning OPTIND to 1,
> bad argument is processed.
> 
> Please consider my patch. I distiled this code from some autoconf
> output. This supports long options and leaves only non option arguments.
> No bashism. Code needs review. I'm not certain how effective code should
> be for very long argument list.
> 
> If this patch is not usable, original code can be fixed by removing
> shift commands from processing or reasigning 1 to OPTIND, but man page
> should be fixed, so that options must precede command.

Hmm..the shifting of arguments was introduced in r2699 from Dan Walsh
(cc'd), diff is below.  Also relevant are r2736, r2750 and r2760.

I'd agree that we don't want to break existing usage, but I'm not sure
what the least intrusive and cleanest fix is.

$ svn diff -c2699 fixfiles
Index: fixfiles
===================================================================
--- fixfiles	(revision 2698)
+++ fixfiles	(revision 2699)
@@ -92,7 +92,7 @@
 		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o \
 		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print; \
 		      done 2> /dev/null | \
-	 ${RESTORECON} $2 -v -f - 
+	 ${RESTORECON} $2 -f - 
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -189,21 +189,27 @@
     case "$i" in
 	f)
 		fullFlag=1
+		shift 1
 		;;
         R)
 		RPMFILES=$OPTARG
+		shift 2
 		;;
         o)
 		OUTFILES=$OPTARG
+		shift 2
 		;;
         l)
 		LOGFILE=$OPTARG
+		shift 2
 		;;
         C)
 		PREFC=$OPTARG
+		shift 2
 		;;
 	F)
 		FORCEFLAG="-F"
+		shift 1
 		;;
 	*)
 	    usage
@@ -211,10 +217,8 @@
 esac
 done
 
-
 # Check for the command
-eval command=\$${OPTIND}
-let OPTIND=$OPTIND+1
+command=$1
 if [ -z $command ]; then
     usage
 fi
@@ -223,17 +227,15 @@
 # check if they specified both DIRS and RPMFILES
 #
 
+shift 1
 if [ ! -z "$RPMFILES" ]; then
-    if [ $OPTIND -le $# ]; then
+    if [ $# -gt 0 ]; then
 	    usage
     fi
 else
-    while [ $OPTIND -le $# ]; do
-	eval DIR=\$${OPTIND}
-	DIRS="$DIRS $DIR"
-	let OPTIND=$OPTIND+1
-    done
+    DIRS=$*
 fi
+
 #
 # Make sure they specified one of the three valid commands
 #

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
