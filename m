Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24KYw63012415
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:34:58 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24KVL30011230
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 20:31:21 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n24KYuMw009727
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:34:56 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n24KYu8f015142
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:34:57 -0500
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n24KYtkT014631
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:34:56 -0500
Message-ID: <49AEE5EF.6080103@redhat.com>
Date: Wed, 04 Mar 2009 15:34:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to python bindings
Content-Type: multipart/mixed;
 boundary="------------060005070703070206030608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060005070703070206030608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eliminate lots of avc calls that can not be done in scripting languages.

Throw an exception on error rather then just returning an error code.

setfilecon(x,y) will now throw exeptions.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmu5e4ACgkQrlYvE4MpobNyBwCg1hmyqzJw7HLf7nV9qokqOmwW
akwAnjKcWtv3EM84nZgDt6IYN9QQxZa3
=5lpv
-----END PGP SIGNATURE-----

--------------060005070703070206030608
Content-Type: text/plain;
 name="libselinux-swig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-swig.patch"

--- nsalibselinux/src/selinuxswig.i	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.78/src/selinuxswig.i	2009-03-04 15:23:52.000000000 -0500
@@ -47,8 +47,36 @@
 %ignore set_matchpathcon_printf;
 %ignore set_matchpathcon_invalidcon;
 %ignore set_matchpathcon_canoncon;
-
+%ignore set_selinuxmnt; 
+%ignore avc_entry_ref_init;
+%ignore avc_entry_ref;
+%ignore avc_memory_callback;
+%ignore avc_log_callback;
+%ignore avc_thread_callback;
+%ignore avc_lock_callback;
+%ignore avc_cache_stats;
+%ignore av_decision;
+%ignore selinux_opt;
+%ignore selinux_callback;
+%ignore selinux_get_callback;
+%ignore selinux_set_callback;
+%ignore SELboolean;
+%ignore security_class_mapping;
+%ignore print_access_vector;
+%ignore set_matchpathcon_flags;
+%ignore matchpathcon_fini;
+%ignore matchpathcon_filespec_destroy;
+%ignore matchpathcon_filespec_eval;
+%ignore matchpathcon_checkmatches;
 %ignore avc_add_callback;
+%ignore avc_sid_stats;
+%ignore avc_av_stats;
+%ignore avc_audit;
+%ignore avc_destroy;
+%ignore avc_cleanup;
+%ignore avc_computer_member;
+%ignore selinux_set_mapping;
+%ignore security_id;
 
 %include "../include/selinux/selinux.h"
 %include "../include/selinux/avc.h"
--- nsalibselinux/src/selinuxswig_python.i	2009-01-13 08:45:35.000000000 -0500
+++ libselinux-2.0.78/src/selinuxswig_python.i	2009-03-04 15:23:52.000000000 -0500
@@ -150,4 +159,12 @@
 	free($1);
 }
 
+%exception {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     return NULL;
+  }
+}
+
 %include "selinuxswig.i"

--------------060005070703070206030608
Content-Type: application/pgp-signature;
 name="libselinux-swig.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libselinux-swig.patch.sig"

iEYEABECAAYFAkmu5e4ACgkQrlYvE4MpobM28gCcDDms4WVVvf1GPV8c39O88A1tY2cAn0s/
1KR7XWfc6okOsIRdabH3n+LT
--------------060005070703070206030608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
