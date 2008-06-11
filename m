Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BGixWe007701
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 12:44:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BGiwQD019452
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 16:44:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5BGiwRk020743
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 12:44:58 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5BGiu7O021056
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 12:44:56 -0400
Received: from localhost.localdomain (vpn-14-189.rdu.redhat.com [10.11.14.189])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5BGitan019446
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 12:44:55 -0400
Message-ID: <485000A8.4090705@redhat.com>
Date: Wed, 11 Jun 2008 12:43:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux patch to add interfaces in avc.h to python bindings
Content-Type: multipart/mixed;
 boundary="------------020302080702020801070909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020302080702020801070909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020302080702020801070909
Content-Type: text/plain;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-2.0.64/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2008-05-06 14:33:15.000000000 -0400
+++ libselinux-2.0.64/src/selinuxswig.i	2008-05-07 13:08:06.000000000 -0400
@@ -5,6 +5,7 @@
 %module selinux
 %{
 	#include "selinux/selinux.h"
+	#include "../include/selinux/avc.h"
 	#include "../include/selinux/selinux.h"
 	#include "../include/selinux/get_default_type.h"
 	#include "../include/selinux/get_context_list.h"
@@ -47,6 +48,10 @@
 %ignore set_matchpathcon_invalidcon;
 %ignore set_matchpathcon_canoncon;
 
+%ignore avc_add_callback;
+
 %include "../include/selinux/selinux.h"
+%include "../include/selinux/avc.h"
 %include "../include/selinux/get_default_type.h"
 %include "../include/selinux/get_context_list.h"
+
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_python.i libselinux-2.0.64/src/selinuxswig_python.i
--- nsalibselinux/src/selinuxswig_python.i	2007-10-01 09:54:35.000000000 -0400
+++ libselinux-2.0.64/src/selinuxswig_python.i	2008-05-07 13:08:06.000000000 -0400
@@ -16,6 +16,20 @@
 	$result = SWIG_Python_AppendOutput($result, list);
 }
 
+/* return a sid along with the result */
+%typemap(argout) (security_id_t * sid) {
+	if (*$1) {
+                %append_output(SWIG_NewPointerObj(*$1, $descriptor(security_id_t), 0));
+	} else {
+		Py_INCREF(Py_None);
+		%append_output(Py_None);
+	}
+}
+
+%typemap(in,numinputs=0) security_id_t *(security_id_t temp) {
+  $1 = &temp;
+}
+
 /* Makes security_compute_user() return a Python list of contexts */
 %typemap(argout) (security_context_t **con) {
 	PyObject* plist;

--------------020302080702020801070909
Content-Type: application/pgp-signature;
 name="libselinux-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libselinux-rhat.patch.sig"

iEYEABECAAYFAkhQAKgACgkQrlYvE4MpobNLFgCgmPjwiz2raUOYZXDfQXSS4/bfrhMAn1ZT
lNOO/fReAVLYi7rZi16b16X2
--------------020302080702020801070909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
