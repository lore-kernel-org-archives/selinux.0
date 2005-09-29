Message-ID: <433BED90.50205@redhat.com>
Date: Thu, 29 Sep 2005 09:35:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: Fix to stop traversing nfs file systems in fixfiles
Content-Type: multipart/mixed;
 boundary="------------080100030002010304080302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080100030002010304080302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Did not know about the -prune qualifier on find.

Dan

-- 



--------------080100030002010304080302
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.27.2/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-09-20 21:21:07.000000000 -0400
+++ policycoreutils-1.27.2/scripts/fixfiles	2005-09-28 10:41:52.000000000 -0400
@@ -62,8 +62,8 @@
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
 	PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
-	sed -r -e 's,:s0[[:space:]], ,g' $PREFC > ${PREFCTEMPFILE}
-	sed -r -e 's,:s0[[:space:]], ,g' $FC | \
+	sed -r -e 's,:s0, ,g' $PREFC > ${PREFCTEMPFILE}
+	sed -r -e 's,:s0, ,g' $FC | \
 	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
 	    grep '^[<>]'|cut -c3-| grep ^/ | \
 	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
@@ -86,8 +86,10 @@
                   esac; \
                fi; \
             done | \
-	while read pattern ; do find $pattern \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -print; done 2> /dev/null | \
-	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
+	while read pattern ; do find $pattern \
+		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o \
+		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print; \
+		      done 2> /dev/null | \
 	 ${RESTORECON} $2 -v -f - 
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi

--------------080100030002010304080302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
