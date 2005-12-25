Message-ID: <43AF074E.6040301@cornell.edu>
Date: Sun, 25 Dec 2005 15:55:42 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Swig update: typemaps
Content-Type: multipart/mixed;
 boundary="------------080009060103040804080203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080009060103040804080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Merry Christmas everyone!

This patch updates the typemaps to add booleans, interfaces, context, 
and char** (for context_to_string). I really don't know what I'm doing 
here with those typemaps, so I would appreciate if someone (Joshua?) can 
look over. I was just following the pattern, with minor changes, and it 
seems to work for a port list function that I wrote for the semanage tool.



--------------080009060103040804080203
Content-Type: text/x-patch;
 name="libsemanage10.swig_update_typemaps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage10.swig_update_typemaps.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2005-12-25 15:50:26.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2005-12-25 15:48:13.000000000 -0500
@@ -51,7 +51,13 @@
 	}	
 	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n) {
 		return list[n];
-	}	
+	}
+	semanage_iface_t *semanage_iface_by_idx(semanage_iface_t **list, int n) {
+		return list[n];
+	}
+	semanage_bool_t *semanage_bool_by_idx(semanage_bool_t **list, int n) {
+		return list[n];
+	}
 	char *char_by_idx(char **list, int n) {
 		return list[n];
 	}
@@ -67,6 +73,14 @@
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
 
+%typemap(in, numinputs=0) char **(char *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) char** {
+	$result = t_output_helper($result, SWIG_FromCharPtr(*$1));
+}
+
 %typemap(in, numinputs=0) char ***(char **temp) {
 	$1 = &temp;
 }
@@ -87,6 +101,74 @@
 	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_module_info, 0));
 }
 
+/** context typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_context_t ** parameter */
+%typemap(in, numinputs=0) semanage_context_t **(semanage_context_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_context_t** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_context, 0));
+}
+
+/** boolean typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_bool_t *** parameter */
+%typemap(in, numinputs=0) semanage_bool_t ***(semanage_bool_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_bool_t *** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_bool, 0));
+}
+
+%typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_bool_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool, 0));
+}
+
+%typemap(argout) semanage_bool_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp) {
+	$1 = &temp;
+}
+
+/** interface typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_iface_t *** parameter */
+%typemap(in, numinputs=0) semanage_iface_t ***(semanage_iface_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_iface_t *** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_iface, 0));
+}
+
+%typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_iface_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface, 0));
+}
+
+%typemap(argout) semanage_iface_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp) {
+	$1 = &temp;
+}
+
 /** seuser typemaps **/
 
 /* the wrapper will setup this parameter for passing... the resulting python functions

--------------080009060103040804080203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
