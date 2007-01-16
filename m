Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GMYUGE027953
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 17:34:30 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0GMZMsN018081
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 22:35:22 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0GMZMV0002747
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 17:35:22 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0GMZM7F027115
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 17:35:22 -0500
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0GMZMDq022534
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 17:35:22 -0500
Message-ID: <45AD5328.8000105@redhat.com>
Date: Tue, 16 Jan 2007 17:35:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to make man -k selinux return all man pages.
Content-Type: multipart/mixed;
 boundary="------------010402090407070000000106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010402090407070000000106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010402090407070000000106
Content-Type: text/x-patch;
 name="libselinux-man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-man.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_add_callback.3 libselinux-1.33.4/man/man3/avc_add_callback.3
--- nsalibselinux/man/man3/avc_add_callback.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/avc_add_callback.3	2007-01-15 16:21:55.000000000 -0500
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
 .TH "avc_add_callback" "3" "9 June 2004" "" "SE Linux API documentation"
 .SH "NAME"
-avc_add_callback \- additional event notification for userspace object managers.
+avc_add_callback \- additional event notification for SELinux userspace object managers.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .br
@@ -181,3 +181,4 @@
 .BR avc_context_to_sid (3),
 .BR avc_cache_stats (3),
 .BR security_compute_av (3)
+.BR selinux (8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_cache_stats.3 libselinux-1.33.4/man/man3/avc_cache_stats.3
--- nsalibselinux/man/man3/avc_cache_stats.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/avc_cache_stats.3	2007-01-15 16:21:55.000000000 -0500
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
 .TH "avc_cache_stats" "3" "27 May 2004" "" "SE Linux API documentation"
 .SH "NAME"
-avc_cache_stats, avc_av_stats, avc_sid_stats \- obtain userspace AVC statistics.
+avc_cache_stats, avc_av_stats, avc_sid_stats \- obtain userspace SELinux AVC statistics.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .br
@@ -96,3 +96,4 @@
 .BR avc_has_perm (3),
 .BR avc_context_to_sid (3),
 .BR avc_add_callback (3)
+.BR selinux (8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_context_to_sid.3 libselinux-1.33.4/man/man3/avc_context_to_sid.3
--- nsalibselinux/man/man3/avc_context_to_sid.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/avc_context_to_sid.3	2007-01-15 16:21:55.000000000 -0500
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
 .TH "avc_context_to_sid" "3" "27 May 2004" "" "SE Linux API documentation"
 .SH "NAME"
-avc_context_to_sid, avc_sid_to_context, sidput, sidget \- obtain and manipulate security ID's.
+avc_context_to_sid, avc_sid_to_context, sidput, sidget \- obtain and manipulate SELinux security ID's.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .br
@@ -88,3 +88,4 @@
 .BR avc_add_callback (3),
 .BR getcon (3),
 .BR freecon (3)
+.BR selinux (8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_has_perm.3 libselinux-1.33.4/man/man3/avc_has_perm.3
--- nsalibselinux/man/man3/avc_has_perm.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/avc_has_perm.3	2007-01-15 16:21:55.000000000 -0500
@@ -152,3 +152,4 @@
 .BR avc_cache_stats (3),
 .BR avc_add_callback (3),
 .BR security_compute_av (3)
+.BR selinux(8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_init.3 libselinux-1.33.4/man/man3/avc_init.3
--- nsalibselinux/man/man3/avc_init.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/avc_init.3	2007-01-15 16:21:55.000000000 -0500
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
 .TH "avc_init" "3" "27 May 2004" "" "SE Linux API documentation"
 .SH "NAME"
-avc_init, avc_destroy, avc_reset, avc_cleanup \- userspace AVC setup and teardown.
+avc_init, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and teardown.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .br
@@ -209,3 +209,5 @@
 .BR avc_cache_stats (3),
 .BR avc_add_callback (3),
 .BR security_compute_av (3)
+.BR selinux (8)
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/context_new.3 libselinux-1.33.4/man/man3/context_new.3
--- nsalibselinux/man/man3/context_new.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/context_new.3	2007-01-15 16:21:55.000000000 -0500
@@ -56,3 +56,6 @@
 On success, zero is returned. On failure, -1 is returned and errno is
 set appropriately.
 
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/freecon.3 libselinux-1.33.4/man/man3/freecon.3
--- nsalibselinux/man/man3/freecon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/freecon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "freecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-freecon, freeconary \- free memory associated with SE Linux security contexts.
+freecon, freeconary \- free memory associated with SELinux security contexts.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -14,3 +14,7 @@
 
 .B freeconary
 frees the memory allocated for a context array.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getcon.3 libselinux-1.33.4/man/man3/getcon.3
--- nsalibselinux/man/man3/getcon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/getcon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "getcon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-getcon, getprevcon, getpidcon \- get SE Linux security context of a process.
+getcon, getprevcon, getpidcon \- get SELinux security context of a process.
 .br
 getpeercon - get security context of a peer socket.
 .br
@@ -59,4 +59,4 @@
 On error -1 is returned.  On success 0 is returned.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " setexeccon "(3)"
+.BR selinux "(8), " freecon "(3), " setexeccon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getexeccon.3 libselinux-1.33.4/man/man3/getexeccon.3
--- nsalibselinux/man/man3/getexeccon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/getexeccon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "getexeccon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-getexeccon, setexeccon \- get or set the SE Linux security context used for executing a new process.
+getexeccon, setexeccon \- get or set the SELinux security context used for executing a new process.
 .br
 rpm_execcon \- run a helper for rpm in an appropriate security context
 
@@ -55,6 +55,6 @@
 rpm_execcon only returns upon errors, as it calls execve(2).
 
 .SH "SEE ALSO"
-.BR freecon "(3), " getcon "(3)"
+.BR selinux "(8), " freecon "(3), " getcon "(3)"
 
 
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getfilecon.3 libselinux-1.33.4/man/man3/getfilecon.3
--- nsalibselinux/man/man3/getfilecon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/getfilecon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "getfilecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-getfilecon, fgetfilecon, lgetfilecon \- get SE Linux security context of a file
+getfilecon, fgetfilecon, lgetfilecon \- get SELinux security context of a file
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -40,4 +40,4 @@
 here.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
+.BR selinux "(8), " freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getfscreatecon.3 libselinux-1.33.4/man/man3/getfscreatecon.3
--- nsalibselinux/man/man3/getfscreatecon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/getfscreatecon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "getfscreatecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-getfscreatecon, setfscreatecon \- get or set the SE Linux security context used for creating a new file system object.
+getfscreatecon, setfscreatecon \- get or set the SELinux security context used for creating a new file system object.
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -35,4 +35,4 @@
 On success 0 is returned.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " getcon "(3), " getexeccon "(3)"
+.BR selinux "(8), " freecon "(3), " getcon "(3), " getexeccon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/get_ordered_context_list.3 libselinux-1.33.4/man/man3/get_ordered_context_list.3
--- nsalibselinux/man/man3/get_ordered_context_list.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/get_ordered_context_list.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "get_ordered_context_list" "3" "1 January 2004" "russell@coker.com.au" "SE Linux"
 .SH "NAME"
-get_ordered_context_list, get_ordered_context_list_with_level, get_default_context, get_default_context_with_level, get_default_context_with_role, get_default_context_with_rolelevel, query_user_context, manual_user_enter_context, get_default_role \- determine context(s) for user sessions
+get_ordered_context_list, get_ordered_context_list_with_level, get_default_context, get_default_context_with_level, get_default_context_with_role, get_default_context_with_rolelevel, query_user_context, manual_user_enter_context, get_default_role \- determine SELinux context(s) for user sessions
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -77,4 +77,4 @@
 The other functions return 0 for success or -1 for errors.
 
 .SH "SEE ALSO"
-.BR freeconary "(3), " freecon "(3), " security_compute_av "(3)", getseuserbyname"(3)"
+.BR selinux "(8), " freeconary "(3), " freecon "(3), " security_compute_av "(3)", getseuserbyname"(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getseuserbyname.3 libselinux-1.33.4/man/man3/getseuserbyname.3
--- nsalibselinux/man/man3/getseuserbyname.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/getseuserbyname.3	2007-01-15 16:21:55.000000000 -0500
@@ -23,3 +23,6 @@
 The errors documented for the stat(2) system call are also applicable
 here.
 
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_context_customizable.3 libselinux-1.33.4/man/man3/is_context_customizable.3
--- nsalibselinux/man/man3/is_context_customizable.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/is_context_customizable.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "is_context_customizable" "3" "10 January 2005" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-is_context_customizable \- check whether context type is customizable by the administrator.
+is_context_customizable \- check whether SELinux context type is customizable by the administrator.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -20,3 +20,6 @@
 .SH "FILE"
 /etc/selinux/SELINUXTYPE/context/customizable_types
 
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_selinux_enabled.3 libselinux-1.33.4/man/man3/is_selinux_enabled.3
--- nsalibselinux/man/man3/is_selinux_enabled.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/is_selinux_enabled.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "is_selinux_enabled" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-is_selinux_enabled \- check whether SE Linux is enabled
+is_selinux_enabled \- check whether SELinux is enabled
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -9,3 +9,7 @@
 .SH "DESCRIPTION"
 .B is_selinux_enabled
 returns 1 if SE Linux is running or 0 if it is not.  May change soon.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchmediacon.3 libselinux-1.33.4/man/man3/matchmediacon.3
--- nsalibselinux/man/man3/matchmediacon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/matchmediacon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "matchmediacon" "3" "15 November 2004" "dwalsh@redhat.com" "SE Linux API documentation"
 .SH "NAME"
-matchmediacon \- get the default security context for the specified mediatype from the policy.
+matchmediacon \- get the default SELinux security context for the specified mediatype from the policy.
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -23,4 +23,4 @@
 /etc/selinux/POLICYTYPE/contexts/files/media
 
 .SH "SEE ALSO"
-.BR freecon "(3)
+.BR selinux "(8), " freecon "(3)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchpathcon.3 libselinux-1.33.4/man/man3/matchpathcon.3
--- nsalibselinux/man/man3/matchpathcon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/matchpathcon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "matchpathcon" "3" "16 March 2005" "sds@tycho.nsa.gov" "SE Linux API documentation"
 .SH "NAME"
-matchpathcon \- get the default security context for the specified path from the file contexts configuration.
+matchpathcon \- get the default SELinux security context for the specified path from the file contexts configuration.
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -117,4 +117,4 @@
 Returns 0 on success or -1 otherwise.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
+.BR selinux "(8), " freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_check_context.3 libselinux-1.33.4/man/man3/security_check_context.3
--- nsalibselinux/man/man3/security_check_context.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/security_check_context.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "security_check_context" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-security_check_context \- check the validity of a context
+security_check_context \- check the validity of a SELinux context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -10,3 +10,7 @@
 .B security_check_context
 returns 0 if SE Linux is running and the context is valid, otherwise it
 returns -1.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_compute_av.3 libselinux-1.33.4/man/man3/security_compute_av.3
--- nsalibselinux/man/man3/security_compute_av.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/security_compute_av.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,7 +1,7 @@
 .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
 security_compute_av, security_compute_create, security_compute_relabel, security_compute_user \- query
-the SE Linux policy database in the kernel.
+the SELinux policy database in the kernel.
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -51,4 +51,4 @@
 0 for success and on error -1 is returned.
 
 .SH "SEE ALSO"
-.BR getcon "(3), " getfilecon "(3), " get_ordered_context_list "(3)"
+.BR selinux "(8), " getcon "(3), " getfilecon "(3), " get_ordered_context_list "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_getenforce.3 libselinux-1.33.4/man/man3/security_getenforce.3
--- nsalibselinux/man/man3/security_getenforce.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/security_getenforce.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-security_getenforce, security_setenforce \- get or set the enforcing state of SE Linux
+security_getenforce, security_setenforce \- get or set the enforcing state of SELinux
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -17,3 +17,7 @@
 sets SE Linux to enforcing mode if the value 1 is passed in, and sets it to
 permissive mode if 0 is passed in.  On success 0 is returned, on error -1 is
 returned.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_load_booleans.3 libselinux-1.33.4/man/man3/security_load_booleans.3
--- nsalibselinux/man/man3/security_load_booleans.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/security_load_booleans.3	2007-01-15 16:21:55.000000000 -0500
@@ -56,4 +56,4 @@
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
 .SH "SEE ALSO"
-getsebool(8), booleans(8), togglesebool(8)
+selinux(8), getsebool(8), booleans(8), togglesebool(8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_load_policy.3 libselinux-1.33.4/man/man3/security_load_policy.3
--- nsalibselinux/man/man3/security_load_policy.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/security_load_policy.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "security_load_policy" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-security_load_policy \- load a new policy
+security_load_policy \- load a new SELinux policy
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -9,3 +9,7 @@
 .SH "DESCRIPTION"
 .B security_load_policy
 loads a new policy, returns 0 for success and -1 for error.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_policyvers.3 libselinux-1.33.4/man/man3/security_policyvers.3
--- nsalibselinux/man/man3/security_policyvers.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/security_policyvers.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "security_policyvers" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-security_policyvers \- get the version of the SE Linux policy
+security_policyvers \- get the version of the SELinux policy
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -10,3 +10,7 @@
 .B security_policyvers
 returns the version of the policy (a positive integer) on success, or -1 on
 error.
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_binary_policy_path.3 libselinux-1.33.4/man/man3/selinux_binary_policy_path.3
--- nsalibselinux/man/man3/selinux_binary_policy_path.3	2007-01-11 14:01:22.000000000 -0500
+++ libselinux-1.33.4/man/man3/selinux_binary_policy_path.3	2007-01-15 16:21:55.000000000 -0500
@@ -4,7 +4,7 @@
 selinux_failsafe_context_path, selinux_removable_context_path,
 selinux_default_context_path, selinux_user_contexts_path,
 selinux_file_context_path, selinux_media_context_path,
-selinux_contexts_path, selinux_booleans_path \- These functions return the paths to the active policy configuration
+selinux_contexts_path, selinux_booleans_path \- These functions return the paths to the active SELinux policy configuration
 directories and files.
 
 .SH "SYNOPSIS"
@@ -65,3 +65,6 @@
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_check_securetty_context.3 libselinux-1.33.4/man/man3/selinux_check_securetty_context.3
--- nsalibselinux/man/man3/selinux_check_securetty_context.3	2007-01-11 14:01:22.000000000 -0500
+++ libselinux-1.33.4/man/man3/selinux_check_securetty_context.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "selinux_check_securetty_context" "3" "1 January 2007" "dwalsh@redhat.com" "SE Linux API documentation"
 .SH "NAME"
-selinux_check_securetty_context \- check whether a tty security context is defined as a securetty context
+selinux_check_securetty_context \- check whether a SELinux tty security context is defined as a securetty context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -10,3 +10,7 @@
 .B selinux_check_securetty_context
 returns 0 if tty_context is a securetty context
 returns < 0 otherwise. 
+
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_getenforcemode.3 libselinux-1.33.4/man/man3/selinux_getenforcemode.3
--- nsalibselinux/man/man3/selinux_getenforcemode.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/selinux_getenforcemode.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "selinux_getenforcemode" "3" "25 May 2004" "dwalsh@redhat.com" "SE Linux API documentation"
 .SH "NAME"
-selinux_getenforcemode \- get the enforcing state of SE Linux
+selinux_getenforcemode \- get the enforcing state of SELinux
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -19,4 +19,7 @@
 On success, zero is returned.
 On failure, -1 is returned.
 
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
 
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_policy_root.3 libselinux-1.33.4/man/man3/selinux_policy_root.3
--- nsalibselinux/man/man3/selinux_policy_root.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/selinux_policy_root.3	2007-01-15 16:21:55.000000000 -0500
@@ -14,4 +14,7 @@
 On success, returns a directory path containing the SELinux policy files.
 On failure, NULL is returned.
 
+.SH "SEE ALSO"
+.BR selinux "(8)"
+
 
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/setfilecon.3 libselinux-1.33.4/man/man3/setfilecon.3
--- nsalibselinux/man/man3/setfilecon.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.4/man/man3/setfilecon.3	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "setfilecon" "3" "1 January 2004" "russell@coker.com.au" "SE Linux API documentation"
 .SH "NAME"
-setfilecon, fsetfilecon, lsetfilecon \- set SE Linux security context of a file
+setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of a file
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -38,4 +38,4 @@
 here.
 
 .SH "SEE ALSO"
-.BR freecon "(3), " getfilecon "(3), " setfscreatecon "(3)"
+.BR selinux "(3), " freecon "(3), " getfilecon "(3), " setfscreatecon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/avcstat.8 libselinux-1.33.4/man/man8/avcstat.8
--- nsalibselinux/man/man8/avcstat.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/avcstat.8	2007-01-15 16:21:55.000000000 -0500
@@ -22,6 +22,9 @@
 .B \-f
 Specifies the location of the AVC statistics file, defaulting to '/selinux/avc/cache_stats'.
 
+.SH "SEE ALSO"
+selinux(8)
+
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 The program was written by James Morris <jmorris@redhat.com>.
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/getenforce.8 libselinux-1.33.4/man/man8/getenforce.8
--- nsalibselinux/man/man8/getenforce.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/getenforce.8	2007-01-15 16:21:55.000000000 -0500
@@ -12,4 +12,4 @@
 Dan Walsh, <dwalsh@redhat.com>
 
 .SH "SEE ALSO"
-setenforce(8), selinuxenabled(8)
+selinux(8), setenforce(8), selinuxenabled(8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/getsebool.8 libselinux-1.33.4/man/man8/getsebool.8
--- nsalibselinux/man/man8/getsebool.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/getsebool.8	2007-01-15 16:21:55.000000000 -0500
@@ -26,9 +26,10 @@
 .B \-a
 Show all SELinux booleans.
 
+.SH "SEE ALSO"
+selinux(8), setsebool(8), booleans(8)
+
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 The program was written by Tresys Technology.
 
-.SH "SEE ALSO"
-setsebool(8), booleans(8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-1.33.4/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/matchpathcon.8	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "matchpathcon" "8" "21 April 2005" "dwalsh@redhat.com" "SE Linux Command Line documentation"
 .SH "NAME"
-matchpathcon \- get the default security context for the specified path from the file contexts configuration.
+matchpathcon \- get the default SELinux security context for the specified path from the file contexts configuration.
 
 .SH "SYNOPSIS"
 .B matchpathcon [-V] [-N] [-n] [-f file_contexts_file ] [-p prefix ] filepath...
@@ -27,4 +27,5 @@
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
 .SH "SEE ALSO"
+.BR selinux "(8), "
 .BR mathpathcon "(3), " 
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/selinuxenabled.8 libselinux-1.33.4/man/man8/selinuxenabled.8
--- nsalibselinux/man/man8/selinuxenabled.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/selinuxenabled.8	2007-01-15 16:21:55.000000000 -0500
@@ -13,4 +13,4 @@
 Dan Walsh, <dwalsh@redhat.com>
 
 .SH "SEE ALSO"
-setenforce(8), getenforce(8)
+selinux(8), setenforce(8), getenforce(8)
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/setenforce.8 libselinux-1.33.4/man/man8/setenforce.8
--- nsalibselinux/man/man8/setenforce.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/setenforce.8	2007-01-15 16:21:55.000000000 -0500
@@ -17,7 +17,7 @@
 Dan Walsh, <dwalsh@redhat.com>
 
 .SH "SEE ALSO"
-getenforce(8), selinuxenabled(8)
+selinux(8), getenforce(8), selinuxenabled(8)
 
 .SH FILES
 /etc/grub.conf, /etc/selinux/config
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/togglesebool.8 libselinux-1.33.4/man/man8/togglesebool.8
--- nsalibselinux/man/man8/togglesebool.8	2006-11-16 17:15:26.000000000 -0500
+++ libselinux-1.33.4/man/man8/togglesebool.8	2007-01-15 16:21:55.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "togglesebool" "1" "26 Oct 2004" "sgrubb@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
-togglesebool \- flip the current value of a boolean
+togglesebool \- flip the current value of a SELinux boolean
 .SH "SYNOPSIS"
 .B togglesebool boolean...
 
@@ -14,4 +14,4 @@
 This man page was written by Steve Grubb <sgrubb@redhat.com>
 
 .SH "SEE ALSO"
-booleans(8), getsebool(8), setsebool(8)
+selinux(8), booleans(8), getsebool(8), setsebool(8)

--------------010402090407070000000106
Content-Type: text/x-patch;
 name="policycoreutils-man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-man.patch"

--- nsapolicycoreutils/audit2allow/audit2allow.1	2006-11-16 17:14:29.000000000 -0500
+++ policycoreutils-1.33.14/audit2allow/audit2allow.1	2007-01-16 15:13:02.000000000 -0500
@@ -24,7 +24,7 @@
 .\"
 .TH AUDIT2ALLOW "1" "January 2005" "Security Enhanced Linux" NSA
 .SH NAME
-audit2allow \- generate policy allow rules from logs of denied operations
+audit2allow \- generate SELinux policy allow rules from logs of denied operations
 .SH SYNOPSIS
 .B audit2allow
 .RI [ options "] "
--- nsapolicycoreutils/load_policy/load_policy.8	2006-11-16 17:14:31.000000000 -0500
+++ policycoreutils-1.33.14/load_policy/load_policy.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux" NSA
 .SH NAME
-load_policy \- load a new policy into the kernel
+load_policy \- load a new SELinux policy into the kernel
 
 .SH SYNOPSIS
 .B load_policy 
--- nsapolicycoreutils/newrole/newrole.1	2007-01-16 15:08:21.000000000 -0500
+++ policycoreutils-1.33.14/newrole/newrole.1	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH NEWROLE "1" "October 2000" "Security Enhanced Linux" NSA
 .SH NAME
-newrole \- run a shell with a new role
+newrole \- run a shell with a new SELinux role
 .SH SYNOPSIS
 .B newrole
 [\fB-r\fR|\fB--role\fR]
--- nsapolicycoreutils/restorecon/restorecon.8	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-1.33.14/restorecon/restorecon.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "restorecon" "8" "2002031409" "" ""
 .SH "NAME"
-restorecon \- set file security contexts.
+restorecon \- restore file(s) default SELinux security contexts.
 
 .SH "SYNOPSIS"
 .B restorecon
--- nsapolicycoreutils/restorecond/restorecond.8	2006-11-16 17:14:28.000000000 -0500
+++ policycoreutils-1.33.14/restorecond/restorecond.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "restorecond" "8" "2002031409" "" ""
 .SH "NAME"
-restorecond \- daemon that watches for file creation and then corrects file context
+restorecond \- daemon that watches for file creation and then sets the default SELinux file context
 
 .SH "SYNOPSIS"
 .B restorecond  [\-d]
--- nsapolicycoreutils/run_init/run_init.8	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.14/run_init/run_init.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH RUN_INIT "8" "May 2003" "Security Enhanced Linux" NSA
 .SH NAME
-run_init \- run an init script in the proper context
+run_init \- run an init script in the proper SELinux context
 .SH SYNOPSIS
 .B run_init 
 \fISCRIPT\fR [[\fIARGS\fR]...] 
--- nsapolicycoreutils/scripts/chcat.8	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.14/scripts/chcat.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH CHCAT "8" "September 2005" "chcat" "User Commands"
 .SH NAME
-chcat \- change file security category
+chcat \- change file SELinux security category
 .SH SYNOPSIS
 .B chcat
 \fICATEGORY FILE\fR...
--- nsapolicycoreutils/scripts/fixfiles.8	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.14/scripts/fixfiles.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "fixfiles" "8" "2002031409" "" ""
 .SH "NAME"
-fixfiles \- fix file security contexts.
+fixfiles \- fix file SELinux security contexts.
 
 .SH "SYNOPSIS"
 .B fixfiles [-F] [ -R rpmpackagename[,rpmpackagename...] ] [ -C PREVIOUS_FILECONTEXT ] [-l logfile ] [-o outputfile ] { check | restore | [-F] relabel | verify }"
--- nsapolicycoreutils/scripts/genhomedircon.8	2006-11-20 12:19:55.000000000 -0500
+++ policycoreutils-1.33.14/scripts/genhomedircon.8	2007-01-16 15:13:02.000000000 -0500
@@ -24,7 +24,7 @@
 .\"
 .TH GENHOMEDIRCON "8" "January 2005" "Security Enhanced Linux" ""
 .SH NAME
-genhomedircon \- generate file context configuration entries for user home directories 
+genhomedircon \- generate SELinux file context configuration entries for user home directories 
 .SH SYNOPSIS
 .B genhomedircon [ -d selinuxdir ] [-n | --nopasswd] [-t selinuxtype ] [-h]
 
--- nsapolicycoreutils/secon/secon.1	2006-11-16 17:14:31.000000000 -0500
+++ policycoreutils-1.33.14/secon/secon.1	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH SECON "1" "April 2006" "Security Enhanced Linux" NSA
 .SH NAME
-secon \- See a context, from a file, program or user input.
+secon \- See an SELinux context, from a file, program or user input.
 .SH SYNOPSIS
 .B secon
 [\fB-hVurtscmPRfLp\fR]
--- nsapolicycoreutils/semodule_deps/semodule_deps.8	2006-11-16 17:14:31.000000000 -0500
+++ policycoreutils-1.33.14/semodule_deps/semodule_deps.8	2007-01-16 15:13:02.000000000 -0500
@@ -1,6 +1,6 @@
 .TH SEMODULE_DEPS "8" "June 2006" "Security Enhanced Linux" NSA
 .SH NAME 
-semodule_deps \- show the dependencies between policy packages.
+semodule_deps \- show the dependencies between SELinux policy packages.
 
 .SH SYNOPSIS
 .B semodule_deps [-v -g -b] basemodpkg modpkg1 [modpkg2 ... ]
--- nsapolicycoreutils/setfiles/setfiles.8	2006-11-16 17:15:00.000000000 -0500
+++ policycoreutils-1.33.14/setfiles/setfiles.8	2007-01-16 15:13:03.000000000 -0500
@@ -1,6 +1,6 @@
 .TH "setfiles" "8" "2002031409" "" ""
 .SH "NAME"
-setfiles \- set file security contexts.
+setfiles \- set file SELinux security contexts.
 
 .SH "SYNOPSIS"
 .B setfiles

--------------010402090407070000000106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
