Message-ID: <430B6AE9.6010505@redhat.com>
Date: Tue, 23 Aug 2005 14:28:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: Policycoreutils fixes for fixfiles
Content-Type: multipart/mixed;
 boundary="------------050108010509040100080505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050108010509040100080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Basically a couple of fixes for rpm updates.

-- 



--------------050108010509040100080505
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.25.5/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-05-20 13:15:12.000000000 -0400
+++ policycoreutils-1.25.5/scripts/fixfiles	2005-08-22 17:25:15.000000000 -0400
@@ -62,6 +62,7 @@
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
 	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
+	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
 	sed -r -e 's,[[:blank:]].*,,g' \
                -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
 	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
@@ -70,7 +71,9 @@
 	       -e 's|\[.*|*|g' \
                -e 's|\.\*.*|*|g' \
                -e 's|\.\+.*|*|g' | \
-	sort -d -u | \
+	    # These two sorts need to be separate commands \
+	sort -u | \
+	sort -d | \
         while read pattern ; \
 	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
                   echo "$pattern"; \
@@ -80,7 +83,7 @@
                fi; \
             done | \
 	while read pattern ; do find $pattern \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -print; done 2> /dev/null | \
-	 ${RESTORECON} $2 -v -e /root -e /home -e /tmp -e /var/tmp -e /dev -f - 
+	 ${RESTORECON} $2 -v -f - 
 	rm -f ${TEMPFILE}
 fi
 }

--------------050108010509040100080505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
