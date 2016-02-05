Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u15Kuia2031596
 for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2016 15:56:45 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id EA9965647AE
 for <selinux@tycho.nsa.gov>; Fri,  5 Feb 2016 21:56:39 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] policycoreutils: sepolicy: rename policy global variable
Date: Fri,  5 Feb 2016 21:55:49 +0100
Message-Id: <1454705751-1448-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Variable policy is both a global variable and a parameter to some
functions in policycoreutils/sepolicy/search.c.  This makes the building
fail when using -Wshadow -Werror compilation flags.

Fix this by renaming the global variable global_policy.  This does not
change the API of the Python module.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/sepolicy/info.c   | 20 ++++++++++----------
 policycoreutils/sepolicy/policy.c | 10 +++++-----
 policycoreutils/sepolicy/policy.h |  2 +-
 policycoreutils/sepolicy/search.c | 26 +++++++++++++-------------
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/policycoreutils/sepolicy/info.c b/policycoreutils/sepolicy/info.c
index 17f5732f2d5c..bbb6844d0b5a 100644
--- a/policycoreutils/sepolicy/info.c
+++ b/policycoreutils/sepolicy/info.c
@@ -1318,31 +1318,31 @@ PyObject* info( int type, const char *name)
 	switch(type) {
 	/* display requested info */
 	case TYPE:
-		output = get_types(name, policy);
+		output = get_types(name, global_policy);
 		break;
 	case ATTRIBUTE:
-		output = get_attribs(name, policy);
+		output = get_attribs(name, global_policy);
 		break;
 	case ROLE:
-		output = get_roles(name, policy);
+		output = get_roles(name, global_policy);
 		break;
 	case USER:
-		output = get_users(name, policy);
+		output = get_users(name, global_policy);
 		break;
 	case CLASS:
-		output = get_classes(name, policy);
+		output = get_classes(name, global_policy);
 		break;
 	case BOOLEAN:
-		output = get_booleans(name, policy);
+		output = get_booleans(name, global_policy);
 		break;
 	case PORT:
-		output = get_ports(name, policy);
+		output = get_ports(name, global_policy);
 		break;
 	case SENS:
-		output = get_sens(name, policy);
+		output = get_sens(name, global_policy);
 		break;
 	case CATS:
-		output = get_cats(name, policy);
+		output = get_cats(name, global_policy);
 		break;
 	default:
 		errno = EINVAL;
@@ -1357,7 +1357,7 @@ PyObject *wrap_info(PyObject *UNUSED(self), PyObject *args){
     int type;
     const char *name;
     
-    if (!policy) {
+    if (!global_policy) {
 	    PyErr_SetString(PyExc_RuntimeError,"Policy not loaded");
 	    return NULL;
     }
diff --git a/policycoreutils/sepolicy/policy.c b/policycoreutils/sepolicy/policy.c
index 2a9e1c7cc7a8..b7e3536f7314 100644
--- a/policycoreutils/sepolicy/policy.c
+++ b/policycoreutils/sepolicy/policy.c
@@ -33,7 +33,7 @@
 #endif
 
 #include "policy.h"
-apol_policy_t *policy = NULL;
+apol_policy_t *global_policy = NULL;
 
 /* other */
 #include <errno.h>
@@ -53,8 +53,8 @@ PyObject *wrap_policy(PyObject *UNUSED(self), PyObject *args){
     if (!PyArg_ParseTuple(args, "z", &policy_file))
 	    return NULL;
 
-    if (policy) 
-	    apol_policy_destroy(&policy);
+    if (global_policy)
+	    apol_policy_destroy(&global_policy);
 
     int policy_load_options = 0;
 	    
@@ -66,9 +66,9 @@ PyObject *wrap_policy(PyObject *UNUSED(self), PyObject *args){
     }
     apol_vector_destroy(&mod_paths);
     
-    policy = apol_policy_create_from_policy_path(pol_path, policy_load_options, NULL, NULL);
+    global_policy = apol_policy_create_from_policy_path(pol_path, policy_load_options, NULL, NULL);
     apol_policy_path_destroy(&pol_path);
-    if (!policy) {
+    if (!global_policy) {
 	    PyErr_SetString(PyExc_RuntimeError,strerror(errno));
 	    return NULL;
     }
diff --git a/policycoreutils/sepolicy/policy.h b/policycoreutils/sepolicy/policy.h
index d59452a81485..ffac497dccd0 100644
--- a/policycoreutils/sepolicy/policy.h
+++ b/policycoreutils/sepolicy/policy.h
@@ -1,5 +1,5 @@
 #include <apol/policy.h>
-extern apol_policy_t *policy;
+extern apol_policy_t *global_policy;
 extern PyObject *wrap_info(PyObject *self, PyObject *args);
 extern void init_info (PyObject *m);
 extern PyObject *wrap_search(PyObject *self, PyObject *args);
diff --git a/policycoreutils/sepolicy/search.c b/policycoreutils/sepolicy/search.c
index d9a5aec60c89..d608006d4469 100644
--- a/policycoreutils/sepolicy/search.c
+++ b/policycoreutils/sepolicy/search.c
@@ -914,23 +914,23 @@ PyObject* search(bool allow,
 		cmd_opts.perm_vector = apol_vector_create(free);
 		cmd_opts.permlist = strdup(permlist);
 	}
-	if (!cmd_opts.semantic && qpol_policy_has_capability(apol_policy_get_qpol(policy), QPOL_CAP_SYN_RULES)) {
-		if (qpol_policy_build_syn_rule_table(apol_policy_get_qpol(policy))) {
+	if (!cmd_opts.semantic && qpol_policy_has_capability(apol_policy_get_qpol(global_policy), QPOL_CAP_SYN_RULES)) {
+		if (qpol_policy_build_syn_rule_table(apol_policy_get_qpol(global_policy))) {
 			PyErr_SetString(PyExc_RuntimeError,"Query failed");
 			goto cleanup;
 		}
 	}
 
 	/* if syntactic rules are not available always do semantic search */
-	if (!qpol_policy_has_capability(apol_policy_get_qpol(policy), QPOL_CAP_SYN_RULES)) {
+	if (!qpol_policy_has_capability(apol_policy_get_qpol(global_policy), QPOL_CAP_SYN_RULES)) {
 		cmd_opts.semantic = 1;
 	}
 
 	/* supress line numbers if doing semantic search or not available */
-	if (cmd_opts.semantic || !qpol_policy_has_capability(apol_policy_get_qpol(policy), QPOL_CAP_LINE_NUMBERS)) {
+	if (cmd_opts.semantic || !qpol_policy_has_capability(apol_policy_get_qpol(global_policy), QPOL_CAP_LINE_NUMBERS)) {
 		cmd_opts.lineno = 0;
 	}
-	if (perform_av_query(policy, &cmd_opts, &v)) {
+	if (perform_av_query(global_policy, &cmd_opts, &v)) {
 		goto cleanup;
 	}
 	output = PyList_New(0);
@@ -938,36 +938,36 @@ PyObject* search(bool allow,
 		goto cleanup;
 
 	if (v) {
-		get_av_results(policy, v, output);
+		get_av_results(global_policy, v, output);
 	}
 
 	apol_vector_destroy(&v);
-	if (perform_te_query(policy, &cmd_opts, &v)) {
+	if (perform_te_query(global_policy, &cmd_opts, &v)) {
 		goto cleanup;
 	}
 	if (v) {
-		get_te_results(policy, v, output);
+		get_te_results(global_policy, v, output);
 	}
 
 	if (cmd_opts.all || cmd_opts.type) {
 		apol_vector_destroy(&v);
-		if (perform_ft_query(policy, &cmd_opts, &v)) {
+		if (perform_ft_query(global_policy, &cmd_opts, &v)) {
 			goto cleanup;
 		}
 
 		if (v) {
-			get_ft_results(policy, v, output);
+			get_ft_results(global_policy, v, output);
 		}
 	}
 
 	if (cmd_opts.all || cmd_opts.role_allow) {
 		apol_vector_destroy(&v);
-		if (perform_ra_query(policy, &cmd_opts, &v)) {
+		if (perform_ra_query(global_policy, &cmd_opts, &v)) {
 			goto cleanup;
 		}
 
 		if (v) {
-			get_ra_results(policy, v, output);
+			get_ra_results(global_policy, v, output);
 		}
 	}
 
@@ -1016,7 +1016,7 @@ PyObject *wrap_search(PyObject *UNUSED(self), PyObject *args){
     int transition = Dict_ContainsInt(dict, "transition");
     int role_allow = Dict_ContainsInt(dict, "role_allow");
 
-    if (!policy) {
+    if (!global_policy) {
 	    PyErr_SetString(PyExc_RuntimeError,"Policy not loaded");
 	    return NULL;
     }
-- 
2.7.0
