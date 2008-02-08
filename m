Date: Fri, 8 Feb 2008 09:29:22 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Marshall Miller <mmiller@tresys.com>,
        "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: fixfiles: broken option processing?
Message-ID: <20080208082922.GA26640@bobek.pm.i.cz>
References: <20080206154957.GA28647@bobek.pm.i.cz> <1202419683.27371.306.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
In-Reply-To: <1202419683.27371.306.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2008 at 04:28:03PM -0500, Stephen Smalley wrote:
> Hmm..the shifting of arguments was introduced in r2699 from Dan Walsh
> (cc'd), diff is below.  Also relevant are r2736, r2750 and r2760.
> 
> I'd agree that we don't want to break existing usage, but I'm not sure
> what the least intrusive and cleanest fix is.

Ok. What about this patch :)

The interpreter is changed to /bin/bash.  There are bashisms (getopts,
PIPESTATUS...), so this can't be interpreted by /bin/sh.

Regards
-- 
Zito

--mYCpIKhGyMATD0i+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fixfiles.optproc2.patch"

Index: fixfiles
===================================================================
--- fixfiles	(revision 2793)
+++ fixfiles	(working copy)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # fixfiles
 #
 # Script to restore labels on a SELinux box
@@ -201,27 +201,21 @@
     case "$i" in
 	f)
 		fullFlag=1
-		shift 1
 		;;
         R)
 		RPMFILES=$OPTARG
-		shift 2
 		;;
         o)
 		OUTFILES=$OPTARG
-		shift 2
 		;;
         l)
 		LOGFILE=$OPTARG
-		shift 2
 		;;
         C)
 		PREFC=$OPTARG
-		shift 2
 		;;
 	F)
 		FORCEFLAG="-F"
-		shift 1
 		;;
 	*)
 	    usage
@@ -229,17 +223,22 @@
 esac
 done
 
+# Move out processed options from arguments
+shift $(( OPTIND - 1 ))
+
 # Check for the command
 command=$1
 if [ -z $command ]; then
     usage
 fi
 
+# Move out command from arguments
+shift
+
 #
 # check if they specified both DIRS and RPMFILES
 #
 
-shift 1
 if [ ! -z "$RPMFILES" ]; then
     process $command
     if [ $# -gt 0 ]; then

--mYCpIKhGyMATD0i+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
