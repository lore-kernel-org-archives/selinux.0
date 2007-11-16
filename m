Message-ID: <473DBE35.7050206@redhat.com>
Date: Fri, 16 Nov 2007 10:58:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fix fixfiles handling of arguments
Content-Type: multipart/mixed;
 boundary="------------010603040308010408050107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010603040308010408050107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fixfiles restore /usr/bin/g*

goes nuts.

This patch fixes this.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHPb40rlYvE4MpobMRAqrJAKDO8b27pYWdCpBhQfPOes6L6u8/MwCgtYH8
94OG2eQJUWJhXD5Hkpus9yo=
=cnGp
-----END PGP SIGNATURE-----

--------------010603040308010408050107
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-2.0.31/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2007-08-23 16:52:26.000000000 -0400
+++ policycoreutils-2.0.31/scripts/fixfiles	2007-11-16 10:54:53.000000000 -0500
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
@@ -223,17 +227,16 @@
 # check if they specified both DIRS and RPMFILES
 #
 
+shift 1
 if [ ! -z "$RPMFILES" ]; then
-    if [ $OPTIND -le $# ]; then
+    if [ $# -gt 0 ]; then
+	echo broken
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

--------------010603040308010408050107
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHPb40rlYvE4MpobMRAgmCAKCdWR3v1vEGvwXvAVzW4DY92CIy2QCfSGNJh3htbST3
FeG6eEcJfHBNc6M=
--------------010603040308010408050107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
