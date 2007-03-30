Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UHu5ld028370
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:56:05 -0400
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UHtrQO023762
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 17:55:53 GMT
Received: from [144.51.25.7] (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2UHtlPw010295
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:55:47 -0400
Message-ID: <460D4F23.2020202@tycho.nsa.gov>
Date: Fri, 30 Mar 2007 13:55:47 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libselinux: string and compute_create functions
References: <460D495B.3060000@tycho.nsa.gov>
In-Reply-To: <460D495B.3060000@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Man pages for new (and old string) functions.

--
 avc_compute_create.3         |   58 +++++++++++++++++++++++++++++++
 security_av_perm_to_string.3 |    1 
 security_av_string.3         |    1 
 security_class_to_string.3   |   80 +++++++++++++++++++++++++++++++++++++++++++
 string_to_av_perm.3          |    1 
 string_to_security_class.3   |    1 
 6 files changed, 142 insertions(+)

--
Index: security_av_string.3
===================================================================
--- security_av_string.3	(revision 0)
+++ security_av_string.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3
Index: avc_compute_create.3
===================================================================
--- avc_compute_create.3	(revision 0)
+++ avc_compute_create.3	(revision 0)
@@ -0,0 +1,58 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
+.TH "avc_compute_create" "3" "30 Mar 2007" "" "SE Linux API documentation"
+.SH "NAME"
+avc_compute_create \- obtain SELinux label for new object.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.br
+.B #include <selinux/avc.h>
+.sp
+.BI "int avc_compute_create(security_id_t " ssid ", security_id_t " tsid ,
+.in +\w'int avc_compute_create('u
+.BI "security_class_t " tclass ", security_id_t *" newsid ");"
+.in
+.SH "DESCRIPTION"
+.B avc_compute_create
+is used to compute a SID to use for labeling a new object in a particular class based on a SID pair.  This call is identical to
+.BR security_compute_create ,
+but does not require converting from userspace SID's to contexts and back again.
+
+.B avc_compute_create
+returns a SID for the computed context in the memory referenced by
+.IR sid ,
+incrementing its reference count by 1.
+
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+
+.SH "ERRORS"
+.TP
+.B EINVAL
+The
+.I tclass
+and/or the security contexts referenced by
+.I ssid
+and
+.I tsid
+are not recognized by the currently loaded policy, or 
+.I tsid
+or
+.I ssid
+has a zero reference count and is invalid.
+
+.TP
+.B ENOMEM
+An attempt to allocate memory failed.
+
+.SH "AUTHOR"
+Eamon Walsh <ewalsh@tycho.nsa.gov>
+
+.SH "SEE ALSO"
+.BR avc_init (3),
+.BR avc_context_to_sid (3),
+.BR security_compute_create (3),
+.BR selinux (8)
Index: security_av_perm_to_string.3
===================================================================
--- security_av_perm_to_string.3	(revision 0)
+++ security_av_perm_to_string.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3
Index: string_to_av_perm.3
===================================================================
--- string_to_av_perm.3	(revision 0)
+++ string_to_av_perm.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3
Index: security_class_to_string.3
===================================================================
--- security_class_to_string.3	(revision 0)
+++ security_class_to_string.3	(revision 0)
@@ -0,0 +1,80 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
+.TH "security_class_to_string" "3" "30 Mar 2007" "" "SE Linux API documentation"
+.SH "NAME"
+security_class_to_string, security_av_perm_to_string, string_to_security_class, string_to_av_perm, security_av_string \- convert
+between SELinux class and permission values and string names.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.br
+.B #include <selinux/flask.h>
+.sp
+.BI "const char * security_class_to_string(security_class_t " tclass ");"
+.sp
+.BI "const char * security_av_perm_to_string(security_class_t " tclass ", access_vector_t " av ");"
+.sp
+.BI "int security_av_string(security_class_t " tclass ", access_vector_t " av ", char **" result ");"
+.sp
+.BI "security_class_t string_to_security_class(const char *" name ");"
+.sp
+.BI "access_vector_t string_to_av_perm(security_class_t " tclass ", const char *" name ");"
+
+.SH "DESCRIPTION"
+.B security_class_to_string
+returns a string name for class
+.IR tclass ,
+or NULL if the class is invalid.  The returned string must not be modified or freed.
+
+.B security_av_perm_to_string
+returns a string name for the access vector bit
+.I av
+of class
+.IR tclass ,
+or NULL if either argument is invalid.  The returned string must not be modified or freed.
+
+.B security_av_string
+computes a full access vector string representation using
+.I tclass
+and
+.IR av ,
+which may have multiple bits set.  The string is returned in the memory pointed to by
+.IR result ,
+and should be freed by the caller using
+.BR free (3).
+
+.B string_to_security_class
+returns the class value corresponding to the string name
+.IR name ,
+or zero if no such class exists.
+
+.B string_to_av_perm
+returns the access vector bit corresponding to the string name
+.I name
+and security class
+.IR tclass ,
+or zero if no such value exists.
+
+.SH "RETURN VALUE"
+.B security_av_string
+returns returns zero on success or \-1 on error with
+.I errno
+set appropriately.  All other functions return zero or NULL on error.
+
+.SH "ERRORS"
+.TP
+.B EINVAL
+A class or access vector argument is not recognized by the currently loaded policy.
+
+.TP
+.B ENOMEM
+An attempt to allocate memory failed.
+
+.SH "AUTHOR"
+Eamon Walsh <ewalsh@tycho.nsa.gov>
+
+.SH "SEE ALSO"
+.BR selinux (8),
+.BR getcon (3),
+.BR getfilecon (3)
Index: string_to_security_class.3
===================================================================
--- string_to_security_class.3	(revision 0)
+++ string_to_security_class.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
