Message-ID: <41F5332C.3050604@redhat.com>
Date: Mon, 24 Jan 2005 12:41:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Change fixfiles to use file_context.local if it exists.
References: <41F521F0.7090108@redhat.com> <1106584190.19246.72.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106584190.19246.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090904070504090305000702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090904070504090305000702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Mon, 2005-01-24 at 11:27, Daniel J Walsh wrote:
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.1/scripts/fixfiles
>>--- nsapolicycoreutils/scripts/fixfiles	2005-01-24 11:19:10.103136000 -0500
>>+++ policycoreutils-1.21.1/scripts/fixfiles	2005-01-24 11:19:28.998223000 -0500
>>@@ -37,11 +37,19 @@
>> SELINUXTYPE="targeted"
>> if [ -e /etc/selinux/config ]; then
>>     . /etc/selinux/config
>>-    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
>>+    FC=`mktemp /var/tmp/file_contexts.XXXXXX`
>>+    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null
>>    
>>
>
>Rather than using a temporary file in /var/tmp, I'd recommend creating
>it in the same parent directory as the existing file_contexts
>configuration (i.e. /etc/selinux/${SELINUXTYPE}/contexts/files). 
>setfiles_t cannot read temporary files, and we don't especially want to
>allow it to do so (to protect against low integrity input).
>
>  
>
Ah good point, change to

/etc/selinux/${SELINUXTYPE}/contexts/files



--------------090904070504090305000702
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.1/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-01-24 11:19:10.103136000 -0500
+++ policycoreutils-1.21.1/scripts/fixfiles	2005-01-24 11:19:28.998223000 -0500
@@ -37,11 +37,19 @@
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
-    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
+    FC=`mktemp /etc/selinux/${SELINUXTYPE}/contexts/files/file_context.XXXXXX`
+    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null
 else
     FC=/etc/security/selinux/file_contexts
 fi
 
+cleanup() {
+    if [ -e /etc/selinux/config -a -f "$FC" ]; then
+	rm -f $FC
+    fi
+}
+trap "cleanup" 0 1 2 3 13 15
+
 #
 # Log to either syslog or a LOGFILE
 #

--------------090904070504090305000702--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
