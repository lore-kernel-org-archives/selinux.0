Message-ID: <4B8839B3.7040801@redhat.com>
Date: Fri, 26 Feb 2010 16:14:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Joshua Brindle <method@manicmethod.com>,
        Eric Paris <eparis@parisplace.org>, Chad Sellers <csellers@tresys.com>
Subject: Re: Fixfiles using new setfiles/restorecon simplification
References: <4B85902B.70300@redhat.com>	 <1267206984.9997.38.camel@moss-pluto.epoch.ncsc.mil>	 <4B881A0C.5010607@redhat.com> <1267217340.9997.88.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267217340.9997.88.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060505030002040504050509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060505030002040504050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/26/2010 03:49 PM, Stephen Smalley wrote:
> On Fri, 2010-02-26 at 13:59 -0500, Daniel J Walsh wrote:
>    
>> On 02/26/2010 12:56 PM, Stephen Smalley wrote:
>>      
>>> Problems with the new fixfiles logic even with kernels>= 2.6.30:
>>>
>>> - Bind mounts are not excluded (and note that they aren't marked with
>>> bind as an option in /proc/mounts - only in /etc/mtab aka mount output):
>>> # mkdir /foo
>>> # mount -o bind /etc /foo
>>> # grep /foo /proc/mounts
>>> /dev/root /foo ext4 rw,seclabel,relatime,barrier=1,data=ordered 0 0
>>> # grep /foo /etc/mtab
>>> /etc /foo none rw,bind 0 0
>>>
>>> - You are assuming fixed option ordering and that no other options can
>>> appear between "rw" and "seclabel" in your grep pattern for
>>> FILESYSTEMSRW.  As a trivial counterexample, if the user mounts with a
>>> rootcontext= option (override the root directory context, but allow
>>> setting of individual file contexts), it won't match.  If we can assume
>>> that seclabel always follows rw, then you can use grep
>>> 'rw,.*seclabel' /proc/self/mounts.  If they used a regular context=
>>> mount option, then seclabel won't be displayed so that will get
>>> excluded.
>>>
>>> - The definition for FILESYSTEMSRO appears to be wrong.  I think
>>> possibly you want grep 'ro,.*seclabel' there (i.e. filesystems mounted
>>> read-only that support labeling).  Simple test case:
>>> # mount -o remount,ro /boot
>>> # grep 'ro,.*seclabel' /proc/mounts
>>> /dev/sda1 /boot ext3
>>> ro,seclabel,relatime,errors=continue,user_xattr,acl,data=ordered 0 0
>>>
>>>
>>>        
>>
>> How about this script,  It searches mount eliminating context and bind
>> mounts and then
>> searches /proc/self/mounts for seclabel.
>>
>> get_mounts() {
>> FS=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk
>> '/rw/{print $3}';`
>>      
> You can drop the grep -v "context=" if you are relying on seclabel
> in /proc/mounts, as it won't appear if they used a "context=" mount
> (disables setting of security contexts).  Whereas if they used a
> rootcontext= or defcontext= mount just to initialize the root directory
> context (as with /dev in some distributions and /dev/shm) or to define
> the default context if the file lacks an xattr on disk, you still want
> to relabel, so excluding anything with context= would exclude too much.
> That's a bug in the current fixfiles.
>
>    
Dropped
> Also, in the old fixfiles, you used \(rw rather than just rw in the
> pattern so that you would only match on the mount option, not on any
> occurrence of rw in e.g. the name of the device or the directory or the
> filesystem type.
>
>    
Fixed
> Interestingly /dev doesn't appear in mount output aka /etc/mtab but it
> does in /proc/self/mounts.  So at present this won't relabel /dev.
>
>    
Added /dev to list of file context,  Since this is added in 
initrc/dracut, it does not show up in /etc/mtab
>> for i in $FS; do
>>       grep --silent "$i ".*seclabel /proc/self/mounts&&  echo $i
>> done
>> }
>> FILESYSTEMRW=`get_mounts`
>> echo $FILESYSTEMRW
>>      
>    
Updated patch

--------------060505030002040504050509
Content-Type: text/plain;
 name="fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fixfiles.patch"

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index ae519fc..d694e3c 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -21,6 +21,17 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 #
+# Get all mounted rw file systems that support seclabel
+#
+get_labeled_mounts() {
+# /dev is not listed in the mountab
+FS="`mount | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/\(rw/{print $3}';` /dev"
+for i in $FS; do 
+    grep --silent "$i ".*seclabel /proc/self/mounts && echo $i
+done
+}
+
+#
 # Set global Variables
 #
 fullFlag=0
@@ -35,9 +46,7 @@ SYSLOGFLAG="-l"
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
-FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(rw/{print $3}';`
-FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(ro/{print $3}';`
-FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
+FILESYSTEMS=`get_labeled_mounts`
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
@@ -87,23 +96,10 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
                   esac; \
                fi; \
             done | \
-	while read pattern ; do sh -c "find $pattern \
-		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o \
-		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print0"; \
-		      done 2> /dev/null | \
-	 ${RESTORECON} $* -0 -f - 
+		      ${RESTORECON} -f - -R -p  -e /home -e /tmp -r /dev; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
-#
-# Log all Read Only file systems 
-#
-LogReadOnly() {
-if [ ! -z "$FILESYSTEMSRO" ]; then
-    logit "Warning: Skipping the following R/O filesystems:"
-    logit "$FILESYSTEMSRO"
-fi
-}
 
 rpmlist() {
 rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
@@ -126,18 +122,11 @@ if [ ! -z "$RPMFILES" ]; then
     exit $?
 fi
 if [ ! -z "$FILEPATH" ]; then
-    if [ -x /usr/bin/find ]; then
-	/usr/bin/find "$FILEPATH" \
-	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o -print0 | \
-	    ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
-    else
-	${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
-    fi
+    ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
     return
 fi
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
-LogReadOnly
-${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
+${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMS} 2>&1 >> $LOGFILE
 rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
 find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
 find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
@@ -146,8 +135,7 @@ exit $?
 
 fullrelabel() {
     logit "Cleaning out /tmp"
-    find /tmp/ -mindepth 1 -print0 | xargs -0 /bin/rm -f
-    LogReadOnly
+    find /tmp/ -mindepth 1 -delete
     restore
 }
 

--------------060505030002040504050509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
