Subject: Re: Patch to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41FA9FA8.7010008@redhat.com>
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA6861.6080505@redhat.com>
	 <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9FA8.7010008@redhat.com>
Content-Type: text/plain
Message-Id: <1106944244.32737.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 28 Jan 2005 15:30:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-28 at 15:25, Daniel J Walsh wrote:
> I have attached an updated fixfiles.   TEMP FILE will now be in the 
> /etc/selinux/${SELINUXTYPE}/contexts/files directory.
> Also changed it to have restorecon to do the recursing instead of find.

Patch below removes the temporary file for file_contexts and
file_contexts.local, as that will no longer be needed with the new
setfiles.

--- policycoreutils/scripts/fixfiles.dan	2005-01-28 15:33:11.269307680 -0500
+++ policycoreutils/scripts/fixfiles	2005-01-28 15:29:54.606205016 -0500
@@ -37,21 +37,11 @@
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
-    FILE_CONTEXT=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
-    FC=`mktemp /etc/selinux/${SELINUXTYPE}/contexts/files/file_context.XXXXXX`
-    cat ${FILE_CONTEXT} ${FILE_CONTEXT}.local > $FC 2> /dev/null
+    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
 else
-    FILE_CONTEXT=/etc/security/selinux/file_contexts
-    FC=${FILE_CONTEXT}
+    FC=/etc/security/selinux/file_contexts
 fi
 
-cleanup() {
-    if [ -e /etc/selinux/config -a -f "$FC" ]; then
-	rm -f $FC
-    fi
-}
-trap "cleanup" 0 1 2 3 13 15
-
 #
 # Log to either syslog or a LOGFILE
 #
@@ -68,9 +58,9 @@
 #
 diff_filecontext() {
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
-	TEMPFILE=`mktemp ${FILE_CONTEXT}.XXXXXXXXXX`
+	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
-	/usr/bin/diff $PREFC $FILE_CONTEXT | egrep '^[<>]'|cut -c3-| grep ^/ | \
+	/usr/bin/diff $PREFC $FC | egrep '^[<>]'|cut -c3-| grep ^/ | \
         sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
             -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
         while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
