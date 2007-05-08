Subject: [PATCH -trunk] newrole: enable use of alternate pam configurations
	for running applications in a different context (Was: Re: launching apps at
	level (MLS) and polyinstantiation)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <463B9448.40007@gmail.com>
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
	 <1178200148.3443.166.camel@moss-spartans.epoch.ncsc.mil>
	 <1178219938.3443.209.camel@moss-spartans.epoch.ncsc.mil>
	 <463B81F3.7030802@gmail.com>
	 <1178306629.677.17.camel@moss-spartans.epoch.ncsc.mil>
	 <463B9448.40007@gmail.com>
Content-Type: text/plain
Date: Tue, 08 May 2007 15:11:13 -0400
Message-Id: <1178651473.6056.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: 	Ted X Toth <txtoth@gmail.com>

With some modifications by Stephen Smalley <sds@tycho.nsa.gov>.

Extend newrole to enable use of alternate pam configurations when
running an application in a different context.  Introduces
/etc/selinux/newrole_pam.conf as a config file mapping application
pathnames to pam service names when the application is invoked via
newrole.  In the absence of the config file or the absence of a
matching entry, falls back to the standard newrole pam configuration.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 policycoreutils/newrole/Makefile  |    7 
 policycoreutils/newrole/hashtab.c |  292 ++++++++++++++++++++++++++++++++++++++
 policycoreutils/newrole/hashtab.h |  142 ++++++++++++++++++
 policycoreutils/newrole/newrole.1 |   14 +
 policycoreutils/newrole/newrole.c |  149 +++++++++++++++++++
 5 files changed, 599 insertions(+), 5 deletions(-)

Index: trunk/policycoreutils/newrole/hashtab.h
===================================================================
--- trunk/policycoreutils/newrole/hashtab.h	(revision 0)
+++ trunk/policycoreutils/newrole/hashtab.h	(revision 0)
@@ -0,0 +1,142 @@
+
+/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+
+/* FLASK */
+
+/*
+ * A hash table (hashtab) maintains associations between
+ * key values and datum values.  The type of the key values 
+ * and the type of the datum values is arbitrary.  The
+ * functions for hash computation and key comparison are
+ * provided by the creator of the table.
+ */
+
+#ifndef _NEWROLE_HASHTAB_H_
+#define _NEWROLE_HASHTAB_H_
+
+#include <stdint.h>
+#include <errno.h>
+#include <stdio.h>
+
+typedef char *hashtab_key_t;	/* generic key type */
+typedef void *hashtab_datum_t;	/* generic datum type */
+
+typedef struct hashtab_node *hashtab_ptr_t;
+
+typedef struct hashtab_node {
+	hashtab_key_t key;
+	hashtab_datum_t datum;
+	hashtab_ptr_t next;
+} hashtab_node_t;
+
+typedef struct hashtab_val {
+	hashtab_ptr_t *htable;	/* hash table */
+	unsigned int size;	/* number of slots in hash table */
+	uint32_t nel;		/* number of elements in hash table */
+	unsigned int (*hash_value) (struct hashtab_val * h, hashtab_key_t key);	/* hash function */
+	int (*keycmp) (struct hashtab_val * h, hashtab_key_t key1, hashtab_key_t key2);	/* key comparison function */
+} hashtab_val_t;
+
+typedef hashtab_val_t *hashtab_t;
+
+/* Define status codes for hash table functions */
+#define HASHTAB_SUCCESS     0
+#define HASHTAB_OVERFLOW    -ENOMEM
+#define HASHTAB_PRESENT     -EEXIST
+#define HASHTAB_MISSING     -ENOENT
+
+/*
+   Creates a new hash table with the specified characteristics.
+
+   Returns NULL if insufficent space is available or
+   the new hash table otherwise.
+ */
+extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
+							    const hashtab_key_t
+							    key),
+				int (*keycmp) (hashtab_t h,
+					       const hashtab_key_t key1,
+					       const hashtab_key_t key2),
+				unsigned int size);
+/*
+   Inserts the specified (key, datum) pair into the specified hash table.
+
+   Returns HASHTAB_OVERFLOW if insufficient space is available or
+   HASHTAB_PRESENT  if there is already an entry with the same key or
+   HASHTAB_SUCCESS otherwise.
+ */
+extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
+
+/*
+   Removes the entry with the specified key from the hash table.
+   Applies the specified destroy function to (key,datum,args) for
+   the entry.
+
+   Returns HASHTAB_MISSING if no entry has the specified key or
+   HASHTAB_SUCCESS otherwise.
+ */
+extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
+			  void (*destroy) (hashtab_key_t k,
+					   hashtab_datum_t d,
+					   void *args), void *args);
+
+/*
+   Insert or replace the specified (key, datum) pair in the specified
+   hash table.  If an entry for the specified key already exists,
+   then the specified destroy function is applied to (key,datum,args)
+   for the entry prior to replacing the entry's contents.
+
+   Returns HASHTAB_OVERFLOW if insufficient space is available or
+   HASHTAB_SUCCESS otherwise.
+ */
+extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
+			   void (*destroy) (hashtab_key_t k,
+					    hashtab_datum_t d,
+					    void *args), void *args);
+
+/*
+   Searches for the entry with the specified key in the hash table.
+
+   Returns NULL if no entry has the specified key or
+   the datum of the entry otherwise.
+ */
+extern hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t k);
+
+/*
+   Destroys the specified hash table.
+ */
+extern void hashtab_destroy(hashtab_t h);
+
+/*
+   Applies the specified apply function to (key,datum,args)
+   for each entry in the specified hash table.
+
+   The order in which the function is applied to the entries
+   is dependent upon the internal structure of the hash table.
+
+   If apply returns a non-zero status, then hashtab_map will cease
+   iterating through the hash table and will propagate the error
+   return to its caller.
+ */
+extern int hashtab_map(hashtab_t h,
+		       int (*apply) (hashtab_key_t k,
+				     hashtab_datum_t d,
+				     void *args), void *args);
+
+/*
+   Same as hashtab_map, except that if apply returns a non-zero status,
+   then the (key,datum) pair will be removed from the hashtab and the
+   destroy function will be applied to (key,datum,args).
+ */
+extern void hashtab_map_remove_on_error(hashtab_t h,
+					int (*apply) (hashtab_key_t k,
+						      hashtab_datum_t d,
+						      void *args),
+					void (*destroy) (hashtab_key_t k,
+							 hashtab_datum_t d,
+							 void *args),
+					void *args);
+
+extern void hashtab_hash_eval(hashtab_t h, char *tag);
+
+#endif
Index: trunk/policycoreutils/newrole/newrole.1
===================================================================
--- trunk/policycoreutils/newrole/newrole.1	(revision 2422)
+++ trunk/policycoreutils/newrole/newrole.1	(working copy)
@@ -47,6 +47,12 @@
 In particular, an argument of -- -c will cause the next argument to be
 treated as a command by most command interpreters.
 .PP
+If a command argument is specified to newrole and the command name is found
+in /etc/selinux/newrole_pam.conf, then the pam service name listed in that
+file for the command will be used rather than the normal newrole pam
+configuration.  This allows for per-command pam configuration when
+invoked via newrole, e.g. to skip the interactive re-authentication phase.
+.PP
 The new shell will be the shell specified in the user's entry in the 
 .I /etc/passwd
 file.
@@ -81,14 +87,22 @@
    # id -Z
    staff_u:sysadm_r:sysadm_t:Secret
 
+.PP
+Running a program in a given role or level:
+   # newrole -r sysadm_r -- -c "/path/to/app arg1 arg2..."
+   # newrole -l Secret -- -c "/path/to/app arg1 arg2..."
+
 .SH FILES
 /etc/passwd - user account information
 .br
 /etc/shadow - encrypted passwords and age information
 .br
 /etc/selinux/<policy>/contexts/default_type - default types for roles
+.br
 /etc/selinux/<policy>/contexts/securetty_types - securetty types for level changes
 .br
+/etc/selinux/newrole_pam.conf - optional mapping of commands to separate pam service names
+.br
 .SH SEE ALSO
 .B runcon
 (1)
Index: trunk/policycoreutils/newrole/hashtab.c
===================================================================
--- trunk/policycoreutils/newrole/hashtab.c	(revision 0)
+++ trunk/policycoreutils/newrole/hashtab.c	(revision 0)
@@ -0,0 +1,292 @@
+
+/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+
+/* FLASK */
+
+/*
+ * Implementation of the hash table type.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include "hashtab.h"
+
+hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
+						     const hashtab_key_t key),
+			 int (*keycmp) (hashtab_t h,
+					const hashtab_key_t key1,
+					const hashtab_key_t key2),
+			 unsigned int size)
+{
+
+	hashtab_t p;
+	unsigned int i;
+
+	p = (hashtab_t) malloc(sizeof(hashtab_val_t));
+	if (p == NULL)
+		return p;
+
+	memset(p, 0, sizeof(hashtab_val_t));
+	p->size = size;
+	p->nel = 0;
+	p->hash_value = hash_value;
+	p->keycmp = keycmp;
+	p->htable = (hashtab_ptr_t *) malloc(sizeof(hashtab_ptr_t) * size);
+	if (p->htable == NULL) {
+		free(p);
+		return NULL;
+	}
+	for (i = 0; i < size; i++)
+		p->htable[i] = (hashtab_ptr_t) NULL;
+
+	return p;
+}
+
+int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+{
+	int hvalue;
+	hashtab_ptr_t prev, cur, newnode;
+
+	if (!h)
+		return HASHTAB_OVERFLOW;
+
+	hvalue = h->hash_value(h, key);
+	prev = NULL;
+	cur = h->htable[hvalue];
+	while (cur && h->keycmp(h, key, cur->key) > 0) {
+		prev = cur;
+		cur = cur->next;
+	}
+
+	if (cur && (h->keycmp(h, key, cur->key) == 0))
+		return HASHTAB_PRESENT;
+
+	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
+	if (newnode == NULL)
+		return HASHTAB_OVERFLOW;
+	memset(newnode, 0, sizeof(struct hashtab_node));
+	newnode->key = key;
+	newnode->datum = datum;
+	if (prev) {
+		newnode->next = prev->next;
+		prev->next = newnode;
+	} else {
+		newnode->next = h->htable[hvalue];
+		h->htable[hvalue] = newnode;
+	}
+
+	h->nel++;
+	return HASHTAB_SUCCESS;
+}
+
+int hashtab_remove(hashtab_t h, hashtab_key_t key,
+		   void (*destroy) (hashtab_key_t k,
+				    hashtab_datum_t d, void *args), void *args)
+{
+	int hvalue;
+	hashtab_ptr_t cur, last;
+
+	if (!h)
+		return HASHTAB_MISSING;
+
+	hvalue = h->hash_value(h, key);
+	last = NULL;
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
+		last = cur;
+		cur = cur->next;
+	}
+
+	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+		return HASHTAB_MISSING;
+
+	if (last == NULL)
+		h->htable[hvalue] = cur->next;
+	else
+		last->next = cur->next;
+
+	if (destroy)
+		destroy(cur->key, cur->datum, args);
+	free(cur);
+	h->nel--;
+	return HASHTAB_SUCCESS;
+}
+
+int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
+		    void (*destroy) (hashtab_key_t k,
+				     hashtab_datum_t d, void *args), void *args)
+{
+	int hvalue;
+	hashtab_ptr_t prev, cur, newnode;
+
+	if (!h)
+		return HASHTAB_OVERFLOW;
+
+	hvalue = h->hash_value(h, key);
+	prev = NULL;
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
+		prev = cur;
+		cur = cur->next;
+	}
+
+	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
+		if (destroy)
+			destroy(cur->key, cur->datum, args);
+		cur->key = key;
+		cur->datum = datum;
+	} else {
+		newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
+		if (newnode == NULL)
+			return HASHTAB_OVERFLOW;
+		memset(newnode, 0, sizeof(struct hashtab_node));
+		newnode->key = key;
+		newnode->datum = datum;
+		if (prev) {
+			newnode->next = prev->next;
+			prev->next = newnode;
+		} else {
+			newnode->next = h->htable[hvalue];
+			h->htable[hvalue] = newnode;
+		}
+	}
+
+	return HASHTAB_SUCCESS;
+}
+
+hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t key)
+{
+
+	int hvalue;
+	hashtab_ptr_t cur;
+
+	if (!h)
+		return NULL;
+
+	hvalue = h->hash_value(h, key);
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
+		cur = cur->next;
+
+	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+		return NULL;
+
+	return cur->datum;
+}
+
+void hashtab_destroy(hashtab_t h)
+{
+	unsigned int i;
+	hashtab_ptr_t cur, temp;
+
+	if (!h)
+		return;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			temp = cur;
+			cur = cur->next;
+			free(temp);
+		}
+		h->htable[i] = NULL;
+	}
+
+	free(h->htable);
+	h->htable = NULL;
+
+	free(h);
+}
+
+int hashtab_map(hashtab_t h,
+		int (*apply) (hashtab_key_t k,
+			      hashtab_datum_t d, void *args), void *args)
+{
+	unsigned int i, ret;
+	hashtab_ptr_t cur;
+
+	if (!h)
+		return HASHTAB_SUCCESS;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			ret = apply(cur->key, cur->datum, args);
+			if (ret)
+				return ret;
+			cur = cur->next;
+		}
+	}
+	return HASHTAB_SUCCESS;
+}
+
+void hashtab_map_remove_on_error(hashtab_t h,
+				 int (*apply) (hashtab_key_t k,
+					       hashtab_datum_t d,
+					       void *args),
+				 void (*destroy) (hashtab_key_t k,
+						  hashtab_datum_t d,
+						  void *args), void *args)
+{
+	unsigned int i;
+	int ret;
+	hashtab_ptr_t last, cur, temp;
+
+	if (!h)
+		return;
+
+	for (i = 0; i < h->size; i++) {
+		last = NULL;
+		cur = h->htable[i];
+		while (cur != NULL) {
+			ret = apply(cur->key, cur->datum, args);
+			if (ret) {
+				if (last) {
+					last->next = cur->next;
+				} else {
+					h->htable[i] = cur->next;
+				}
+
+				temp = cur;
+				cur = cur->next;
+				if (destroy)
+					destroy(temp->key, temp->datum, args);
+				free(temp);
+				h->nel--;
+			} else {
+				last = cur;
+				cur = cur->next;
+			}
+		}
+	}
+
+	return;
+}
+
+void hashtab_hash_eval(hashtab_t h, char *tag)
+{
+	unsigned int i;
+	int chain_len, slots_used, max_chain_len;
+	hashtab_ptr_t cur;
+
+	slots_used = 0;
+	max_chain_len = 0;
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		if (cur) {
+			slots_used++;
+			chain_len = 0;
+			while (cur) {
+				chain_len++;
+				cur = cur->next;
+			}
+
+			if (chain_len > max_chain_len)
+				max_chain_len = chain_len;
+		}
+	}
+
+	printf
+	    ("%s:  %d entries and %d/%d buckets used, longest chain length %d\n",
+	     tag, h->nel, slots_used, h->size, max_chain_len);
+}
Index: trunk/policycoreutils/newrole/newrole.c
===================================================================
--- trunk/policycoreutils/newrole/newrole.c	(revision 2422)
+++ trunk/policycoreutils/newrole/newrole.c	(working copy)
@@ -58,6 +58,7 @@
 #include <stdio.h>
 #include <stdlib.h>		/* for malloc(), realloc(), free() */
 #include <pwd.h>		/* for getpwuid() */
+#include <ctype.h>
 #include <sys/types.h>		/* to make getuid() and getpwuid() happy */
 #include <sys/wait.h>		/* for wait() */
 #include <getopt.h>		/* for getopt_long() form of getopt() */
@@ -92,6 +93,10 @@
 /* USAGE_STRING describes the command-line args of this program. */
 #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -p ] [ -V ] [ -- args ]"
 
+#ifdef USE_PAM
+#define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf";
+#endif
+
 #define DEFAULT_PATH "/usr/bin:/bin"
 #define DEFAULT_CONTEXT_SIZE 255	/* first guess at context size */
 
@@ -159,7 +164,7 @@
 #include <security/pam_appl.h>	/* for PAM functions */
 #include <security/pam_misc.h>	/* for misc_conv PAM utility function */
 
-#define SERVICE_NAME "newrole"	/* the name of this program for PAM */
+char *service_name = "newrole";
 
 /* authenticate_via_pam()
  *
@@ -209,6 +214,113 @@
 	return result;
 }				/* authenticate_via_pam() */
 
+#include "hashtab.h"
+
+static int free_hashtab_entry(hashtab_key_t key, hashtab_datum_t d, 
+			      void *args __attribute__ ((unused)) )
+{
+	free(key);
+	free(d);
+	return 0;
+}
+
+static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
+{
+	char *p, *keyp;
+	size_t size;
+	unsigned int val;
+
+	val = 0;
+	keyp = (char *)key;
+	size = strlen(keyp);
+	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
+		val =
+		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
+	return val & (h->size - 1);
+}
+
+static int reqsymcmp(hashtab_t h
+		     __attribute__ ((unused)), hashtab_key_t key1,
+		     hashtab_key_t key2)
+{
+	char *keyp1, *keyp2;
+
+	keyp1 = (char *)key1;
+	keyp2 = (char *)key2;
+	return strcmp(keyp1, keyp2);
+}
+
+static hashtab_t app_service_names = NULL;
+#define PAM_SERVICE_SLOTS 64
+
+static int process_pam_config(FILE * cfg)
+{
+	const char *config_file_path = PAM_SERVICE_CONFIG;
+	char *line_buf = NULL;
+	unsigned long lineno = 0;
+	size_t len = 0;
+	char *app = NULL;
+	char *service = NULL;
+	int ret;
+
+	while (getline(&line_buf, &len, cfg) > 0) {
+		char *buffer = line_buf;
+		lineno++;
+		while (isspace(*buffer))
+			buffer++;
+		if (buffer[0] == '#')
+			continue;
+		if (buffer[0] == '\n' || buffer[0] == '\0')
+			continue;
+
+		app = service = NULL;
+		ret = sscanf(buffer, "%as %as\n", &app, &service);
+		if (ret < 2 || !app || !service)
+			goto err;
+
+		ret = hashtab_insert(app_service_names, app, service);
+		if (ret == HASHTAB_OVERFLOW) {
+			fprintf(stderr,
+				_("newrole: service name configuration hashtable overflow\n"));
+			goto err;
+		}
+	}
+
+	free(line_buf);
+	return 0;
+      err:
+	free(app);
+	free(service);
+	fprintf(stderr,	_("newrole:  %s:  error on line %lu.\n"), config_file_path, lineno);
+	free(line_buf);
+	return -1;
+}
+
+/* 
+ *  Read config file ignoring comment lines.
+ *  Files specified one per line executable with a corresponding
+ *  pam service name.
+ */
+static int read_pam_config()
+{
+	const char *config_file_path = PAM_SERVICE_CONFIG;
+	FILE *cfg = NULL;
+	cfg = fopen(config_file_path, "r");
+	if (!cfg)
+		return 0;	/* This configuration is optional. */
+	app_service_names =
+	    hashtab_create(reqsymhash, reqsymcmp, PAM_SERVICE_SLOTS);
+	if (!app_service_names)
+		goto err;
+	if (process_pam_config(cfg))
+		goto err;
+	fclose(cfg);
+	return 0;
+      err:
+	fclose(cfg);
+	return -1;
+}
+
 #else				/* else !USE_PAM */
 
 /************************************************************************
@@ -1027,9 +1139,32 @@
 	if (extract_pw_data(&pw))
 		goto err_free;
 
-	printf(_("Authenticating %s.\n"), pw.pw_name);
 #ifdef USE_PAM
-	pam_status = pam_start(SERVICE_NAME, pw.pw_name, &pam_conversation,
+	if (read_pam_config()) {
+		fprintf(stderr, _("error on reading PAM service configuration.\n"));
+		goto err_free;
+	}
+
+	if (app_service_names != NULL && optind < argc) {
+		if (strcmp(argv[optind], "-c") == 0 && optind < (argc - 1)) {
+			/*
+			 * Check for a separate pam service name for the 
+			 * command when invoked by newrole.
+			 */
+			char *cmd = NULL;
+			rc = sscanf(argv[optind + 1], "%as", &cmd);
+			if (rc != EOF && cmd) {
+				char *app_service_name =
+				    (char *)hashtab_search(app_service_names,
+							   cmd);
+				free(cmd);
+				if (app_service_name != NULL)
+					service_name = app_service_name;
+			}
+		}
+	}
+
+	pam_status = pam_start(service_name, pw.pw_name, &pam_conversation,
 			       &pam_handle);
 	if (pam_status != PAM_SUCCESS) {
 		fprintf(stderr, _("failed to initialize PAM\n"));
@@ -1118,6 +1253,8 @@
 				pam_strerror(pam_handle, rc));
 			exit_code = -1;
 		}
+		hashtab_map(app_service_names, free_hashtab_entry, NULL);
+		hashtab_destroy(app_service_names);
 #endif
 		free(pw.pw_name);
 		free(pw.pw_dir);
@@ -1223,5 +1360,11 @@
 	free(pw.pw_dir);
 	free(pw.pw_shell);
 	free(shell_argv0);
+#ifdef USE_PAM
+	if (app_service_names) {
+		hashtab_map(app_service_names, free_hashtab_entry, NULL);
+		hashtab_destroy(app_service_names);
+	}
+#endif
 	return -1;
 }				/* main() */
Index: trunk/policycoreutils/newrole/Makefile
===================================================================
--- trunk/policycoreutils/newrole/Makefile	(revision 2422)
+++ trunk/policycoreutils/newrole/Makefile	(working copy)
@@ -21,10 +21,12 @@
 VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
+EXTRA_OBJS =
 override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
+	EXTRA_OBJS += hashtab.o
 	LDLIBS += -lpam -lpam_misc
 else
 	override CFLAGS += -D_XOPEN_SOURCE=500
@@ -53,9 +55,10 @@
 	MODE := 0555
 endif
 
-TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+all: newrole
 
-all: $(TARGETS)
+newrole: newrole.o $(EXTRA_OBJS)
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
 	test -d $(BINDIR)      || install -m 755 -d $(BINDIR)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
