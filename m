Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12DwO53022358
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 08:58:25 -0500 (EST)
Message-ID: <4200DC75.1070009@redhat.com>
Date: Wed, 02 Feb 2005 08:58:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: New patch for fixfiles sed script
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>	 <41FA9717.2000609@redhat.com>	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil> <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070900090906030504040804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070900090906030504040804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070900090906030504040804
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.9/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-01-31 09:49:15.000000000 -0500
+++ policycoreutils-1.21.9/scripts/fixfiles	2005-02-01 14:06:56.000000000 -0500
@@ -60,12 +60,26 @@
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
-	/usr/bin/diff $PREFC $FC | egrep '^[<>]'|cut -c3-| grep ^/ | \
-        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
-            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
-        while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
+	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
+	sed -r -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
+	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
+               -e 's|\?.*|*|g' \
+	       -e 's|\(.*|*|g' \
+	       -e 's|\[.*|*|g' \
+               -e 's|\.\*|*|g' \
+               -e 's|\.\+|*|g' \
+	sort -u | \
+        while read pattern ; \
+	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
+                  echo "$pattern"; \
+                  case "$pattern" in *"*") \
+	               echo "$pattern" | sed 's,\*$,,g' >> ${TEMPFILE};;  
+                  esac; \
+               fi; \
+            done | \
+	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
-	${RESTORECON} $2 -v -f -R - 
+	${RESTORECON} -R $2 -v -f - 
 	rm -f ${TEMPFILE}
 fi
 }

--------------070900090906030504040804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
