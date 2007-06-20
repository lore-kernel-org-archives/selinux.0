Message-ID: <46797B9C.5060800@tycho.nsa.gov>
Date: Wed, 20 Jun 2007 15:10:20 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: minor man page fixes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Converts occurrences of 'SE Linux' to SELinux, corrects my
e-mail address.

The patch has very long lines.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 man3/avc_add_callback.3                |    6 +++---
 man3/avc_cache_stats.3                 |    6 +++---
 man3/avc_compute_create.3              |    2 +-
 man3/avc_context_to_sid.3              |    6 +++---
 man3/avc_has_perm.3                    |    6 +++---
 man3/avc_init.3                        |    6 +++---
 man3/freecon.3                         |    2 +-
 man3/get_ordered_context_list.3        |    2 +-
 man3/getcon.3                          |    2 +-
 man3/getexeccon.3                      |    2 +-
 man3/getfilecon.3                      |    2 +-
 man3/getfscreatecon.3                  |    2 +-
 man3/getseuserbyname.3                 |    2 +-
 man3/is_selinux_enabled.3              |    4 ++--
 man3/matchmediacon.3                   |    2 +-
 man3/matchpathcon.3                    |    2 +-
 man3/security_check_context.3          |    4 ++--
 man3/security_class_to_string.3        |    2 +-
 man3/security_compute_av.3             |    2 +-
 man3/security_getenforce.3             |    6 +++---
 man3/security_load_policy.3            |    2 +-
 man3/security_policyvers.3             |    2 +-
 man3/selinux_check_securetty_context.3 |    2 +-
 man3/selinux_getenforcemode.3          |    2 +-
 man3/selinux_policy_root.3             |    2 +-
 man3/setfilecon.3                      |    2 +-
 man8/matchpathcon.8                    |    2 +-
 27 files changed, 41 insertions(+), 41 deletions(-)


Index: man8/matchpathcon.8
===================================================================
--- man8/matchpathcon.8    (revision 2487)
+++ man8/matchpathcon.8    (working copy)
@@ -1,4 +1,4 @@
-.TH "matchpathcon" "8" "21 April 2005" "dwalsh@redhat.com" "SE Linux 
Command Line documentation"
+.TH "matchpathcon" "8" "21 April 2005" "dwalsh@redhat.com" "SELinux 
Command Line documentation"
 .SH "NAME"
 matchpathcon \- get the default SELinux security context for the 
specified path from the file contexts configuration.
 
Index: man3/get_ordered_context_list.3
===================================================================
--- man3/get_ordered_context_list.3    (revision 2487)
+++ man3/get_ordered_context_list.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "get_ordered_context_list" "3" "1 January 2004" 
"russell@coker.com.au" "SE Linux"
+.TH "get_ordered_context_list" "3" "1 January 2004" 
"russell@coker.com.au" "SELinux"
 .SH "NAME"
 get_ordered_context_list, get_ordered_context_list_with_level, 
get_default_context, get_default_context_with_level, 
get_default_context_with_role, get_default_context_with_rolelevel, 
query_user_context, manual_user_enter_context, get_default_role \- 
determine SELinux context(s) for user sessions
 
Index: man3/matchmediacon.3
===================================================================
--- man3/matchmediacon.3    (revision 2487)
+++ man3/matchmediacon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "matchmediacon" "3" "15 November 2004" "dwalsh@redhat.com" "SE 
Linux API documentation"
+.TH "matchmediacon" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux 
API documentation"
 .SH "NAME"
 matchmediacon \- get the default SELinux security context for the 
specified mediatype from the policy.
 
Index: man3/getfscreatecon.3
===================================================================
--- man3/getfscreatecon.3    (revision 2487)
+++ man3/getfscreatecon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "getfscreatecon" "3" "1 January 2004" "russell@coker.com.au" "SE 
Linux API documentation"
+.TH "getfscreatecon" "3" "1 January 2004" "russell@coker.com.au" 
"SELinux API documentation"
 .SH "NAME"
 getfscreatecon, setfscreatecon \- get or set the SELinux security 
context used for creating a new file system object.
 
Index: man3/getcon.3
===================================================================
--- man3/getcon.3    (revision 2487)
+++ man3/getcon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "getcon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API 
documentation"
+.TH "getcon" "3" "1 January 2004" "russell@coker.com.au" "SELinux API 
documentation"
 .SH "NAME"
 getcon, getprevcon, getpidcon \- get SELinux security context of a process.
 .br
Index: man3/security_load_policy.3
===================================================================
--- man3/security_load_policy.3    (revision 2487)
+++ man3/security_load_policy.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "security_load_policy" "3" "1 January 2004" "russell@coker.com.au" 
"SE Linux API documentation"
+.TH "security_load_policy" "3" "1 January 2004" "russell@coker.com.au" 
"SELinux API documentation"
 .SH "NAME"
 security_load_policy \- load a new SELinux policy
 .SH "SYNOPSIS"
Index: man3/security_getenforce.3
===================================================================
--- man3/security_getenforce.3    (revision 2487)
+++ man3/security_getenforce.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" 
"SE Linux API documentation"
+.TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" 
"SELinux API documentation"
 .SH "NAME"
 security_getenforce, security_setenforce \- get or set the enforcing 
state of SELinux
 .SH "SYNOPSIS"
@@ -10,11 +10,11 @@
 
 .SH "DESCRIPTION"
 .B security_getenforce
-returns 0 if SE Linux is running in permissive mode, 1 if it is running in
+returns 0 if SELinux is running in permissive mode, 1 if it is running in
 enforcing mode, and -1 on error.
 
 .B security_setenforce
-sets SE Linux to enforcing mode if the value 1 is passed in, and sets it to
+sets SELinux to enforcing mode if the value 1 is passed in, and sets it to
 permissive mode if 0 is passed in.  On success 0 is returned, on error 
-1 is
 returned.
 
Index: man3/selinux_policy_root.3
===================================================================
--- man3/selinux_policy_root.3    (revision 2487)
+++ man3/selinux_policy_root.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "selinux_policy_root" "3" "25 May 2004" "dwalsh@redhat.com" "SE 
Linux API documentation"
+.TH "selinux_policy_root" "3" "25 May 2004" "dwalsh@redhat.com" 
"SELinux API documentation"
 .SH "NAME"
 selinux_policy_root \- return the path of the SELinux policy files for 
this machine.
 .SH "SYNOPSIS"
Index: man3/getfilecon.3
===================================================================
--- man3/getfilecon.3    (revision 2487)
+++ man3/getfilecon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "getfilecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux 
API documentation"
+.TH "getfilecon" "3" "1 January 2004" "russell@coker.com.au" "SELinux 
API documentation"
 .SH "NAME"
 getfilecon, fgetfilecon, lgetfilecon \- get SELinux security context of 
a file
 .SH "SYNOPSIS"
Index: man3/freecon.3
===================================================================
--- man3/freecon.3    (revision 2487)
+++ man3/freecon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "freecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API 
documentation"
+.TH "freecon" "3" "1 January 2004" "russell@coker.com.au" "SELinux API 
documentation"
 .SH "NAME"
 freecon, freeconary \- free memory associated with SELinux security 
contexts.
 .SH "SYNOPSIS"
Index: man3/avc_compute_create.3
===================================================================
--- man3/avc_compute_create.3    (revision 2487)
+++ man3/avc_compute_create.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
 .\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
-.TH "avc_compute_create" "3" "30 Mar 2007" "" "SE Linux API documentation"
+.TH "avc_compute_create" "3" "30 Mar 2007" "" "SELinux API documentation"
 .SH "NAME"
 avc_compute_create \- obtain SELinux label for new object.
 .SH "SYNOPSIS"
Index: man3/security_compute_av.3
===================================================================
--- man3/security_compute_av.3    (revision 2487)
+++ man3/security_compute_av.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" 
"SE Linux API documentation"
+.TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" 
"SELinux API documentation"
 .SH "NAME"
 security_compute_av, security_compute_create, security_compute_relabel,
 security_compute_user, security_get_initial_context \- query
Index: man3/setfilecon.3
===================================================================
--- man3/setfilecon.3    (revision 2487)
+++ man3/setfilecon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "setfilecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux 
API documentation"
+.TH "setfilecon" "3" "1 January 2004" "russell@coker.com.au" "SELinux 
API documentation"
 .SH "NAME"
 setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of 
a file
 
Index: man3/avc_add_callback.3
===================================================================
--- man3/avc_add_callback.3    (revision 2487)
+++ man3/avc_add_callback.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
-.\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
-.TH "avc_add_callback" "3" "9 June 2004" "" "SE Linux API documentation"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
+.TH "avc_add_callback" "3" "9 June 2004" "" "SELinux API documentation"
 .SH "NAME"
 avc_add_callback \- additional event notification for SELinux userspace 
object managers.
 .SH "SYNOPSIS"
@@ -173,7 +173,7 @@
 .BR AVC_CALLBACK_RESET .
 
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@epoch.ncsc.mil>
+Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR avc_init (3),
Index: man3/selinux_check_securetty_context.3
===================================================================
--- man3/selinux_check_securetty_context.3    (revision 2487)
+++ man3/selinux_check_securetty_context.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "selinux_check_securetty_context" "3" "1 January 2007" 
"dwalsh@redhat.com" "SE Linux API documentation"
+.TH "selinux_check_securetty_context" "3" "1 January 2007" 
"dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
 selinux_check_securetty_context \- check whether a SELinux tty security 
context is defined as a securetty context
 .SH "SYNOPSIS"
Index: man3/getseuserbyname.3
===================================================================
--- man3/getseuserbyname.3    (revision 2487)
+++ man3/getseuserbyname.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "getseuserbyname" "3" "29 September 2005" "dwalsh@redhat.com" "SE 
Linux API documentation"
+.TH "getseuserbyname" "3" "29 September 2005" "dwalsh@redhat.com" 
"SELinux API documentation"
 .SH "NAME"
 getseuserbyname \- get SELinux username and level for a given Linux 
username
 .SH "SYNOPSIS"
Index: man3/security_check_context.3
===================================================================
--- man3/security_check_context.3    (revision 2487)
+++ man3/security_check_context.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "security_check_context" "3" "1 January 2004" 
"russell@coker.com.au" "SE Linux API documentation"
+.TH "security_check_context" "3" "1 January 2004" 
"russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
 security_check_context \- check the validity of a SELinux context
 .SH "SYNOPSIS"
@@ -8,7 +8,7 @@
 
 .SH "DESCRIPTION"
 .B security_check_context
-returns 0 if SE Linux is running and the context is valid, otherwise it
+returns 0 if SELinux is running and the context is valid, otherwise it
 returns -1.
 
 .SH "SEE ALSO"
Index: man3/avc_cache_stats.3
===================================================================
--- man3/avc_cache_stats.3    (revision 2487)
+++ man3/avc_cache_stats.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
-.\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
-.TH "avc_cache_stats" "3" "27 May 2004" "" "SE Linux API documentation"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
+.TH "avc_cache_stats" "3" "27 May 2004" "" "SELinux API documentation"
 .SH "NAME"
 avc_cache_stats, avc_av_stats, avc_sid_stats \- obtain userspace 
SELinux AVC statistics.
 .SH "SYNOPSIS"
@@ -89,7 +89,7 @@
 is made before the cache is flushed.
 
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@epoch.ncsc.mil>
+Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR avc_init (3),
Index: man3/avc_context_to_sid.3
===================================================================
--- man3/avc_context_to_sid.3    (revision 2487)
+++ man3/avc_context_to_sid.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
-.\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
-.TH "avc_context_to_sid" "3" "27 May 2004" "" "SE Linux API documentation"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
+.TH "avc_context_to_sid" "3" "27 May 2004" "" "SELinux API documentation"
 .SH "NAME"
 avc_context_to_sid, avc_sid_to_context, sidput, sidget, 
avc_get_initial_sid \- obtain and manipulate SELinux security ID's.
 .SH "SYNOPSIS"
@@ -86,7 +86,7 @@
 will be called on a SID when its object is destroyed.  Proper reference 
counting is necessary to ensure that SID's and associated cache entries 
are reclaimed from memory when no longer needed.
 
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@epoch.ncsc.mil>
+Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR avc_init (3),
Index: man3/getexeccon.3
===================================================================
--- man3/getexeccon.3    (revision 2487)
+++ man3/getexeccon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "getexeccon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux 
API documentation"
+.TH "getexeccon" "3" "1 January 2004" "russell@coker.com.au" "SELinux 
API documentation"
 .SH "NAME"
 getexeccon, setexeccon \- get or set the SELinux security context used 
for executing a new process.
 .br
Index: man3/security_class_to_string.3
===================================================================
--- man3/security_class_to_string.3    (revision 2487)
+++ man3/security_class_to_string.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
 .\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
-.TH "security_class_to_string" "3" "30 Mar 2007" "" "SE Linux API 
documentation"
+.TH "security_class_to_string" "3" "30 Mar 2007" "" "SELinux API 
documentation"
 .SH "NAME"
 security_class_to_string, security_av_perm_to_string, 
string_to_security_class, string_to_av_perm, security_av_string \- convert
 between SELinux class and permission values and string names.
Index: man3/security_policyvers.3
===================================================================
--- man3/security_policyvers.3    (revision 2487)
+++ man3/security_policyvers.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "security_policyvers" "3" "1 January 2004" "russell@coker.com.au" 
"SE Linux API documentation"
+.TH "security_policyvers" "3" "1 January 2004" "russell@coker.com.au" 
"SELinux API documentation"
 .SH "NAME"
 security_policyvers \- get the version of the SELinux policy
 .SH "SYNOPSIS"
Index: man3/avc_has_perm.3
===================================================================
--- man3/avc_has_perm.3    (revision 2487)
+++ man3/avc_has_perm.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
-.\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
-.TH "avc_has_perm" "3" "27 May 2004" "" "SE Linux API documentation"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
+.TH "avc_has_perm" "3" "27 May 2004" "" "SELinux API documentation"
 .SH "NAME"
 avc_has_perm, avc_has_perm_noaudit, avc_audit, avc_entry_ref_init \- 
obtain and audit SELinux access decisions.
 .SH "SYNOPSIS"
@@ -144,7 +144,7 @@
 netlink by the policy.
 
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@epoch.ncsc.mil>
+Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR avc_init (3),
Index: man3/is_selinux_enabled.3
===================================================================
--- man3/is_selinux_enabled.3    (revision 2487)
+++ man3/is_selinux_enabled.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "is_selinux_enabled" "3" "1 January 2004" "russell@coker.com.au" 
"SE Linux API documentation"
+.TH "is_selinux_enabled" "3" "1 January 2004" "russell@coker.com.au" 
"SELinux API documentation"
 .SH "NAME"
 is_selinux_enabled \- check whether SELinux is enabled
 .SH "SYNOPSIS"
@@ -8,7 +8,7 @@
 
 .SH "DESCRIPTION"
 .B is_selinux_enabled
-returns 1 if SE Linux is running or 0 if it is not.  May change soon.
+returns 1 if SELinux is running or 0 if it is not.  May change soon.
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
Index: man3/avc_init.3
===================================================================
--- man3/avc_init.3    (revision 2487)
+++ man3/avc_init.3    (working copy)
@@ -1,7 +1,7 @@
 .\" Hey Emacs! This file is -*- nroff -*- source.
 .\"
-.\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
-.TH "avc_init" "3" "27 May 2004" "" "SE Linux API documentation"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
+.TH "avc_init" "3" "27 May 2004" "" "SELinux API documentation"
 .SH "NAME"
 avc_init, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC 
setup and teardown.
 .SH "SYNOPSIS"
@@ -201,7 +201,7 @@
 is called.
 
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@epoch.ncsc.mil>
+Eamon Walsh <ewalsh@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR avc_has_perm (3),
Index: man3/selinux_getenforcemode.3
===================================================================
--- man3/selinux_getenforcemode.3    (revision 2487)
+++ man3/selinux_getenforcemode.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "selinux_getenforcemode" "3" "25 May 2004" "dwalsh@redhat.com" "SE 
Linux API documentation"
+.TH "selinux_getenforcemode" "3" "25 May 2004" "dwalsh@redhat.com" 
"SELinux API documentation"
 .SH "NAME"
 selinux_getenforcemode \- get the enforcing state of SELinux
 .SH "SYNOPSIS"
Index: man3/matchpathcon.3
===================================================================
--- man3/matchpathcon.3    (revision 2487)
+++ man3/matchpathcon.3    (working copy)
@@ -1,4 +1,4 @@
-.TH "matchpathcon" "3" "16 March 2005" "sds@tycho.nsa.gov" "SE Linux 
API documentation"
+.TH "matchpathcon" "3" "16 March 2005" "sds@tycho.nsa.gov" "SELinux API 
documentation"
 .SH "NAME"
 matchpathcon \- get the default SELinux security context for the 
specified path from the file contexts configuration.
 

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
