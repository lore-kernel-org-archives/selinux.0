Message-ID: <41A4B35B.3050902@redhat.com>
Date: Wed, 24 Nov 2004 11:14:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Still getting random execute permissions on shared libraries.
References: <41A3EC21.1090200@comcast.net> <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2004-11-23 at 21:04, Daniel J Walsh wrote:
>  
>
>>Trying to run java from within firefox is a disaster, Mozilla crashes.
>>
>>allow user_mozilla_t ld_so_cache_t:file execute;
>>allow user_mozilla_t lib_t:file execute; (Jar files)
>>allow user_mozilla_t user_tmp_t:file execute;
>>allow user_t ld_so_cache_t:file execute;
>>allow user_t locale_t:file execute;
>>    
>>
>
>They aren't random.  As discussed previously here and on
>fedora-selinux-list, execution of a legacy binary causes the
>read_implies_exec behavior to be enabled for the process, so that
>subsequent read requests are transparently mapped to read|execute.  This
>was a change in the upstream kernel, not SELinux, and was to allow
>introduction of NX support without breaking compatibility with legacy
>binaries.  SELinux is merely checking permissions based on the
>information supplied by the core kernel.
>
>Your options are:
>- get java rebuilt with a PT_GNU_STACK header so the kernel doesn't
>treat it as a legacy binary (assuming that it doesn't assume that read
>implies exec),
>- change policy to allow execute permission in these cases (although it
>would be preferable here to move java into its own domain in that case,
>so that you only have to allow it these permissions and not the entire
>user domain or mozilla domain).
>  
>
I can't do either.  We do not ship java jre.  It comes from Sun.  If 
someone out there could
ask them to build it with PT_GNU_STACK it would be helpful.

This is using java runtime environment so I don't believe there is any 
execing going on,  So my only
choice would be to allow mozilla these privs.  I added the following 
changes to make it work.

diff --exclude-from=exclude -N -u -r 
nsapolicy/macros/program/mozilla_macros.te 
policy-1.19.5/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te    2004-11-24 
07:00:51.000000000 -0500
+++ policy-1.19.5/macros/program/mozilla_macros.te    2004-11-24 
10:57:51.332334406 -0500
@@ -29,7 +29,8 @@
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
-allow $1_mozilla_t urandom_device_t:chr_file { getattr ioctl read };
+allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { 
getattr ioctl read append };
+
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
 
@@ -117,8 +118,20 @@
 dontaudit $1_mozilla_t file_type:dir getattr;
 allow $1_mozilla_t self:sem create_sem_perms;
 
+ifdef(`userhelper.te', `
+domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
+')
 dontaudit $1_mozilla_t selinux_config_t:dir search;
 
+#
+# Rules needed to run java apps
+#
+allow $1_mozilla_t ld_so_cache_t:file execute;
+allow $1_mozilla_t locale_t:file execute;
+dontaudit $1_mozilla_t *:{ chr_file file } execute;
+dontaudit $1_t ld_so_cache_t:file execute;
+dontaudit $1_t locale_t:file execute;
+
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
 allow $1_mozilla_t xdm_tmp_t:dir search;

diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc 
policy-1.19.5/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc    2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.5/file_contexts/types.fc    2004-11-24 
10:57:51.324335309 -0500
@@ -334,6 +334,9 @@
 /usr(/.*)?            system_u:object_r:usr_t
 /usr(/.*)?/lib(64)?(/.*)?    system_u:object_r:lib_t
 /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*    --    system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.so(\.[^/]*)*    --    system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.jar    --    system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.jsa    --    system_u:object_r:shlib_t
 /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
 /usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
 /usr(/.*)?/Bin(/.*)?        system_u:object_r:bin_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
