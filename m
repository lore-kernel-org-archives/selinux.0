Message-ID: <41FE7DB2.1000101@redhat.com>
Date: Mon, 31 Jan 2005 13:49:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to policycoreutils
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>	 <41FA6861.6080505@redhat.com>	 <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>	 <41FA9FA8.7010008@redhat.com>	 <1107180899.24654.67.camel@moss-spartans.epoch.ncsc.mil>	 <41FE4B16.1050206@redhat.com> <1107185236.24654.97.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107185236.24654.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040107010807030509030701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040107010807030509030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040107010807030509030701
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.9/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-01-31 09:49:15.000000000 -0500
+++ policycoreutils-1.21.9/scripts/fixfiles	2005-01-31 13:39:27.000000000 -0500
@@ -60,12 +60,20 @@
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
-	/usr/bin/diff $PREFC $FC | egrep '^[<>]'|cut -c3-| grep ^/ | \
-        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
-            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
+	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
+	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
+	sed -r -e 's|\(([/?[:alnum:]]+)\)\?|{\1,}|g' \
+	       -e 's|([[:alnum:]])\?|{\1,}|g' \
+	       -e 's,\(.*,*,g' -e 's,\[.*,*,g' \
+	       -e 's,[[:blank:]].*,,g' \
+               -e 's,\?.*,*,g' \
+               -e 's,\.\*,*,g' \
+	       -e 's,\(.*,*,g' \
+	       -e 's,\[.*,*,g' | \
+	sort -u | \
         while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
-	${RESTORECON} $2 -v -f -R - 
+	${RESTORECON} -R $2 -v -f - 
 	rm -f ${TEMPFILE}
 fi
 }

--------------040107010807030509030701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
