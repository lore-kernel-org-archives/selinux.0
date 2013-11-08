From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 05/08] Add support to return sesitivities and cats for python bindings.
Date: Fri,  8 Nov 2013 08:17:32 -0500
Message-Id: <1383916655-9354-6-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/sepolicy/info.c | 300 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 290 insertions(+), 10 deletions(-)

diff --git a/policycoreutils/sepolicy/info.c b/policycoreutils/sepolicy/info.c
index cd1026a..b353f2c 100644
--- a/policycoreutils/sepolicy/info.c
+++ b/policycoreutils/sepolicy/info.c
@@ -54,13 +54,13 @@
 
 enum input
 {
-	TYPE, ATTRIBUTE, ROLE, USER, PORT, BOOLEAN, CLASS
+	TYPE, ATTRIBUTE, ROLE, USER, PORT, BOOLEAN, CLASS, SENS, CATS
 };
 
 static int py_insert_long(PyObject *dict, const char *name, int value)
 {
 	int rt;
-	PyObject *obj = PyInt_FromLong(value);
+	PyObject *obj = PyLong_FromLong(value);
 	if (!obj) return -1;
 	rt = PyDict_SetItemString(dict, name, obj);
 	Py_DECREF(obj);
@@ -78,9 +78,287 @@ static int py_insert_bool(PyObject *dict, const char *name, int value)
 }
 
 /**
+ * Get a policy's MLS sensitivities.
+ * If this function is given a name, it will attempt to
+ * get statistics about a particular sensitivity; otherwise
+ * the function gets statistics about all of the policy's
+ * sensitivities.
+ *
+ * @param name Reference to a sensitivity's name; if NULL,
+ * all sensitivities will be considered
+ * @param policydb Reference to a policy
+ *
+ * @return 0 on success, < 0 on error.
+ */
+static PyObject* get_sens(const char *name, const apol_policy_t * policydb)
+{
+	PyObject *dict = NULL;
+	int error = 0;
+	int rt = 0;
+	size_t i;
+	char *tmp = NULL;
+	const char *lvl_name = NULL;
+	apol_level_query_t *query = NULL;
+	apol_vector_t *v = NULL;
+	const qpol_level_t *level = NULL;
+	apol_mls_level_t *ap_mls_lvl = NULL;
+	qpol_policy_t *q = apol_policy_get_qpol(policydb);
+
+	query = apol_level_query_create();
+	if (!query)
+		goto cleanup;
+	if (apol_level_query_set_sens(policydb, query, name))
+		goto cleanup;
+	if (apol_level_get_by_query(policydb, query, &v))
+		goto cleanup;
+
+	dict = PyDict_New(); 
+	if (!dict) goto err;
+	for (i = 0; i < apol_vector_get_size(v); i++) {
+		level = apol_vector_get_element(v, i);
+		if (qpol_level_get_name(q, level, &lvl_name))
+			goto err;
+		ap_mls_lvl = (apol_mls_level_t *) apol_mls_level_create_from_qpol_level_datum(policydb, level);
+		tmp = apol_mls_level_render(policydb, ap_mls_lvl);
+		apol_mls_level_destroy(&ap_mls_lvl);
+		if (!tmp)
+			goto cleanup;
+		if (py_insert_string(dict, lvl_name, tmp))
+			goto err;
+		free(tmp); tmp = NULL;
+		if (rt) goto err;
+	}
+
+	if (name && !apol_vector_get_size(v)) {
+		goto cleanup;
+	}
+
+	goto cleanup;
+err:
+	error = errno;
+	PyErr_SetString(PyExc_RuntimeError,strerror(error));
+	py_decref(dict); dict = NULL;
+cleanup:
+	free(tmp);
+	apol_level_query_destroy(&query);
+	apol_vector_destroy(&v);
+	errno = error; 
+	return dict;
+}
+
+/**
+ * Compare two qpol_cat_datum_t objects.
+ * This function is meant to be passed to apol_vector_compare
+ * as the callback for performing comparisons.
+ *
+ * @param datum1 Reference to a qpol_type_datum_t object
+ * @param datum2 Reference to a qpol_type_datum_t object
+ * @param data Reference to a policy
+ * @return Greater than 0 if the first argument is less than the second argument,
+ * less than 0 if the first argument is greater than the second argument,
+ * 0 if the arguments are equal
+ */
+static int qpol_cat_datum_compare(const void *datum1, const void *datum2, void *data)
+{
+	const qpol_cat_t *cat_datum1 = NULL, *cat_datum2 = NULL;
+	apol_policy_t *policydb = NULL;
+	qpol_policy_t *q;
+	uint32_t val1, val2;
+
+	policydb = (apol_policy_t *) data;
+	q = apol_policy_get_qpol(policydb);
+	assert(policydb);
+
+	if (!datum1 || !datum2)
+		goto exit_err;
+	cat_datum1 = datum1;
+	cat_datum2 = datum2;
+
+	if (qpol_cat_get_value(q, cat_datum1, &val1))
+		goto exit_err;
+	if (qpol_cat_get_value(q, cat_datum2, &val2))
+		goto exit_err;
+
+	return (val1 > val2) ? 1 : ((val1 == val2) ? 0 : -1);
+
+      exit_err:
+	assert(0);
+	return 0;
+}
+
+/**
+ * Compare two qpol_level_datum_t objects.
+ * This function is meant to be passed to apol_vector_compare
+ * as the callback for performing comparisons.
+ *
+ * @param datum1 Reference to a qpol_level_datum_t object
+ * @param datum2 Reference to a qpol_level_datum_t object
+ * @param data Reference to a policy
+ * @return Greater than 0 if the first argument is less than the second argument,
+ * less than 0 if the first argument is greater than the second argument,
+ * 0 if the arguments are equal
+ */
+static int qpol_level_datum_compare(const void *datum1, const void *datum2, void *data)
+{
+	const qpol_level_t *lvl_datum1 = NULL, *lvl_datum2 = NULL;
+	apol_policy_t *policydb = NULL;
+	qpol_policy_t *q;
+	uint32_t val1, val2;
+
+	policydb = (apol_policy_t *) data;
+	assert(policydb);
+	q = apol_policy_get_qpol(policydb);
+
+	if (!datum1 || !datum2)
+		goto exit_err;
+	lvl_datum1 = datum1;
+	lvl_datum2 = datum2;
+
+	if (qpol_level_get_value(q, lvl_datum1, &val1))
+		goto exit_err;
+	if (qpol_level_get_value(q, lvl_datum2, &val2))
+		goto exit_err;
+
+	return (val1 > val2) ? 1 : ((val1 == val2) ? 0 : -1);
+
+      exit_err:
+	assert(0);
+	return 0;
+}
+
+/**
+ * Gets a textual representation of a MLS category and 
+ * all of that category's sensitivies.
+ *
+ * @param type_datum Reference to sepol type_datum
+ * @param policydb Reference to a policy
+ */
+static PyObject* get_cat_sens(const qpol_cat_t * cat_datum, const apol_policy_t * policydb)
+{
+	const char *cat_name, *lvl_name;
+	apol_level_query_t *query = NULL;
+	apol_vector_t *v = NULL;
+	const qpol_level_t *lvl_datum = NULL;
+	qpol_policy_t *q = apol_policy_get_qpol(policydb);
+	size_t i, n_sens = 0;
+	int error = 0;
+	PyObject *list = NULL;
+	PyObject *dict = PyDict_New(); 
+	if (!dict) goto err;
+	if (!cat_datum || !policydb)
+		goto err;
+
+	/* get category name for apol query */
+	if (qpol_cat_get_name(q, cat_datum, &cat_name))
+		goto cleanup;
+
+	query = apol_level_query_create();
+	if (!query)
+		goto err;
+	if (apol_level_query_set_cat(policydb, query, cat_name))
+		goto err;
+	if (apol_level_get_by_query(policydb, query, &v))
+		goto err;
+	apol_vector_sort(v, &qpol_level_datum_compare, (void *)policydb);
+	dict = PyDict_New(); 
+	if (!dict) goto err;
+	if (py_insert_string(dict, "name", cat_name))
+		goto err;
+	n_sens = apol_vector_get_size(v);
+	list = PyList_New(0);
+	if (!list) goto err;
+	for (i = 0; i < n_sens; i++) {
+		lvl_datum = (qpol_level_t *) apol_vector_get_element(v, i);
+		if (!lvl_datum)
+			goto err;
+		if (qpol_level_get_name(q, lvl_datum, &lvl_name))
+			goto err;
+		if (py_append_string(list, lvl_name))
+			goto err;
+	}
+	if (py_insert_obj(dict, "level", list))
+		goto err;
+	Py_DECREF(list);
+
+	goto cleanup;
+err:
+	error = errno;
+	PyErr_SetString(PyExc_RuntimeError,strerror(errno));
+	py_decref(list); list = NULL;
+	py_decref(dict); dict = NULL;
+cleanup:
+	apol_level_query_destroy(&query);
+	apol_vector_destroy(&v);
+	errno = error;
+	return dict;
+}
+
+/**
+ * Prints statistics regarding a policy's MLS categories.
+ * If this function is given a name, it will attempt to
+ * get statistics about a particular category; otherwise
+ * the function gets statistics about all of the policy's
+ * categories.
+ *
+ * @param name Reference to a MLS category's name; if NULL,
+ * all categories will be considered
+ * @param policydb Reference to a policy
+ *
+ * @return 0 on success, < 0 on error.
+ */
+static PyObject* get_cats(const char *name, const apol_policy_t * policydb)
+{
+	PyObject *obj = NULL;
+	apol_cat_query_t *query = NULL;
+	apol_vector_t *v = NULL;
+	const qpol_cat_t *cat_datum = NULL;
+	size_t i, n_cats;
+	int error = 0;
+	int rt;
+	PyObject *list = PyList_New(0);
+	if (!list) goto err;
+
+	query = apol_cat_query_create();
+	if (!query)
+		goto err;
+	if (apol_cat_query_set_cat(policydb, query, name))
+		goto err;
+	if (apol_cat_get_by_query(policydb, query, &v))
+		goto err;
+	n_cats = apol_vector_get_size(v);
+	apol_vector_sort(v, &qpol_cat_datum_compare, (void *)policydb);
+
+	for (i = 0; i < n_cats; i++) {
+		cat_datum = apol_vector_get_element(v, i);
+		if (!cat_datum)
+			goto err;
+		obj = get_cat_sens(cat_datum, policydb);
+		if (!obj) 
+			goto err;
+		rt = py_append_obj(list, obj);
+		Py_DECREF(obj);
+		if (rt) goto err;
+	}
+
+	if (name && !n_cats) {
+		goto err;
+	}
+
+	goto cleanup;
+err:
+	error = errno;
+	PyErr_SetString(PyExc_RuntimeError,strerror(errno));
+	py_decref(list); list = NULL;
+cleanup:
+	apol_cat_query_destroy(&query);
+	apol_vector_destroy(&v);
+	errno = error;
+	return list;
+}
+
+/**
  * Get the alias of a type.
  *
- * @param fp Reference to a file to which to get type information
  * @param type_datum Reference to sepol type_datum
  * @param policydb Reference to a policy
  * attributes
@@ -315,7 +593,7 @@ cleanup:
 	return list;
 }
 
-static PyObject* get_type( const qpol_type_t * type_datum, const apol_policy_t * policydb) {
+static PyObject* get_type(const qpol_type_t * type_datum, const apol_policy_t * policydb) {
 
 	PyObject *obj;
 	qpol_policy_t *q = apol_policy_get_qpol(policydb);
@@ -370,11 +648,8 @@ cleanup:
  * get statistics about a particular boolean; otherwise
  * the function gets statistics about all of the policy's booleans.
  *
- * @param fp Reference to a file to which to print statistics
  * @param name Reference to a boolean's name; if NULL,
  * all booleans will be considered
- * @param expand Flag indicating whether to print each
- * boolean's default state
  * @param policydb Reference to a policy
  *
  * @return new reference, or NULL (setting an exception)
@@ -536,11 +811,8 @@ cleanup:
  * Prints a textual representation of an object class and possibly
  * all of that object class' permissions.
  *
- * @param fp Reference to a file to which to print object class information
  * @param type_datum Reference to sepol type_datum
  * @param policydb Reference to a policy
- * @param expand Flag indicating whether to print each object class'
- * permissions
  */
 static PyObject* get_class(const qpol_class_t * class_datum, const apol_policy_t * policydb)
 {
@@ -1066,6 +1338,12 @@ PyObject* info( int type, const char *name)
 	case PORT:
 		output = get_ports(name, policy);
 		break;
+	case SENS:
+		output = get_sens(name, policy);
+		break;
+	case CATS:
+		output = get_cats(name, policy);
+		break;
 	default:
 		errno = EINVAL;
 		PyErr_SetString(PyExc_RuntimeError,strerror(errno));
@@ -1098,4 +1376,6 @@ void init_info (PyObject *m) {
     PyModule_AddIntConstant(m, "USER", USER);
     PyModule_AddIntConstant(m, "CLASS", CLASS);
     PyModule_AddIntConstant(m, "BOOLEAN", BOOLEAN);
+    PyModule_AddIntConstant(m, "SENS", SENS);
+    PyModule_AddIntConstant(m, "CATS", CATS);
 }
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
