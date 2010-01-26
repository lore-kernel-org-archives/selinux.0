From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 05/15] [src-policy] language.d and language.conf parser
Date: Tue, 26 Jan 2010 17:08:11 -0500
Message-Id: <1264543701-20638-6-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-5-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch provides support for language.conf. The language
configuration files indicate which compiler a high level language needs
for compilation to the intermediate language (e.g., corenet to refpol).
Each language.conf consists of the following:

NAME="Reference Policy"		# Human readable compiler name.
COMPILER="/usr/bin/refpolc"	# Path to the compiler.
EXTENSION="ref"			# Extension for this language (no dot).
FLAGS=""			# Any additional flags for the compiler.

Each compiler is expected to accept the high level language on stdin,
output the intermediate language on stdout, compilation log to stderr,
and the module version to fd 3. A non-zero exit status indicates an
error occured during compilation.

The language of a module is identified by matching its file extension to
one of the language configuration files. Each language.conf must specify
a _unique_ language extension for the language.
---
 libsemanage/src/Makefile             |   16 ++-
 libsemanage/src/handle.c             |   40 +++++-
 libsemanage/src/handle.h             |    7 +-
 libsemanage/src/lang-parse.y         |  271 ++++++++++++++++++++++++++++++++++
 libsemanage/src/lang-scan.l          |   84 +++++++++++
 libsemanage/src/semanage_lang_conf.h |   39 +++++
 libsemanage/src/semanage_store.c     |   11 ++-
 libsemanage/src/semanage_store.h     |    3 +-
 8 files changed, 463 insertions(+), 8 deletions(-)
 create mode 100644 libsemanage/src/lang-parse.y
 create mode 100644 libsemanage/src/lang-scan.l
 create mode 100644 libsemanage/src/semanage_lang_conf.h

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 67afc60..42ee9d6 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -43,8 +43,8 @@ LIBSO=$(TARGET).$(LIBVERSION)
 SWIGGEN=$(SWIGCOUT) $(SWIGRUBYCOUT)
 SRCS= $(filter-out $(SWIGGEN),$(wildcard *.c))
 
-OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
-LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
+OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o lang-scan.o lang-parse.o
+LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo lang-scan.lo lang-parse.lo
 CFLAGS ?= -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
@@ -53,7 +53,7 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
-GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(wildcard conf-*.[ch])
+GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(wildcard conf-*.[ch]) $(wildcard lang-*.[ch])
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
@@ -92,6 +92,14 @@ conf-parse.c: conf-parse.y
 
 conf-parse.h: conf-parse.c
 
+lang-scan.c: lang-scan.l lang-parse.h
+	$(LEX) $(LFLAGS) -t $< > $@
+
+lang-parse.c: lang-parse.y
+	$(YACC) $(YFLAGS) -o $@ $<
+
+lang-parse.h: lang-parse.c
+
 %.o:  %.c 
 	$(CC) $(CFLAGS) -c -o $@ $<
 
@@ -141,7 +149,7 @@ relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c
+	rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c lang-parse.c lang-parse.h lang-scan.c
 
 distclean: clean
 	rm -f $(SWIGCOUT) $(SWIGFILES)
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 8300cae..71c3165 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -1,7 +1,7 @@
 /* Author: Joshua Brindle <jbrindle@tresys.co
  *	   Jason Tang	  <jtang@tresys.com>
  *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2004-2005,2010 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
  * 
  *  This library is free software; you can redistribute it and/or
@@ -42,6 +42,7 @@ semanage_handle_t *semanage_handle_create(void)
 {
 	semanage_handle_t *sh = NULL;
 	const char *conf_name = NULL;
+	const char *lang_conf_path = NULL;
 
 	/* Allocate handle */
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
@@ -53,6 +54,13 @@ semanage_handle_t *semanage_handle_create(void)
 	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
 		goto err;
 
+	if ((lang_conf_path = semanage_lang_conf_path()) == NULL)
+		goto err;
+
+	sh->lang_conf_list = semanage_lang_conf_parse(lang_conf_path);
+	if (sh->lang_conf_list == NULL)
+		goto err;
+
 	/* Link to sepol handle */
 	sh->sepolh = sepol_handle_create();
 	if (!sh->sepolh)
@@ -160,6 +168,26 @@ int semanage_set_default_priority(semanage_handle_t *sh, uint16_t priority)
 	return 0;
 }
 
+const semanage_lang_conf_t *semanage_get_lang_conf(semanage_handle_t *sh,
+						   const char *lang_ext)
+{
+	assert(sh != NULL);
+	assert(lang_ext != NULL);
+
+	semanage_lang_conf_t *conf = NULL;
+
+	semanage_lang_conf_list_t *item = sh->lang_conf_list;
+	while (item != NULL) {
+		if (strcmp(item->data->ext, lang_ext) == 0) {
+			conf = item->data;
+			break;
+		}
+		item = item->next;
+	}
+	
+	return conf;
+}
+
 int semanage_is_connected(semanage_handle_t * sh)
 {
 	assert(sh != NULL);
@@ -271,6 +299,16 @@ void semanage_handle_destroy(semanage_handle_t * sh)
 
 	if (sh->funcs != NULL && sh->funcs->destroy != NULL)
 		sh->funcs->destroy(sh);
+
+	semanage_lang_conf_list_t *head = sh->lang_conf_list;
+	semanage_lang_conf_list_t *next = NULL;
+	while (head != NULL) {
+		next = head->next;
+		semanage_lang_conf_destroy(head->data);
+		free(head);
+		head = next;
+	}
+
 	semanage_conf_destroy(sh->conf);
 	sepol_handle_destroy(sh->sepolh);
 	free(sh);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 64175c4..0f8794a 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -2,7 +2,7 @@
  *         Jason Tang     <jtang@tresys.com>
  *         Ivan Gyurdiev  <ivg2@cornell.edu>
  *           
- * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005,2010 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat Inc.
  *
  *  This library is free software; you can redistribute it and/or
@@ -29,6 +29,7 @@
 #include <sepol/handle.h>
 #include "modules.h"
 #include "semanage_conf.h"
+#include "semanage_lang_conf.h"
 #include "database.h"
 #include "direct_api.h"
 #include "policy.h"
@@ -56,6 +57,7 @@ struct semanage_handle {
 	sepol_handle_t *sepolh;
 
 	semanage_conf_t *conf;
+	semanage_lang_conf_list_t *lang_conf_list;
 
 	uint16_t priority;
 	int is_connected;
@@ -226,4 +228,7 @@ static inline
 	return &handle->dbase[DBASE_ACTIVE_BOOLEANS];
 }
 
+const semanage_lang_conf_t *semanage_get_lang_conf(semanage_handle_t *sh,
+						   const char *lang_ext);
+
 #endif
diff --git a/libsemanage/src/lang-parse.y b/libsemanage/src/lang-parse.y
new file mode 100644
index 0000000..12a1090
--- /dev/null
+++ b/libsemanage/src/lang-parse.y
@@ -0,0 +1,271 @@
+/* Authors: Mark Goldman   <mgoldman@tresys.com>
+ *          Caleb Case     <ccase@tresys.com>
+ *
+ * Copyright (C) 2009-2010 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+%{
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <dirent.h>
+
+#include "semanage_lang_conf.h"
+#include "debug.h"
+
+extern int semanage_lang_lex();                /* defined in lang-scan.c */
+int semanage_lang_error(char *msg);
+
+extern FILE *semanage_lang_in;
+extern char *semanage_lang_text;
+
+static semanage_lang_conf_t *lang_conf;
+static int parse_errors;
+
+%}
+
+%name-prefix="semanage_lang_"
+
+%union {
+        char *s;
+}
+
+%token NAME EXTENSION COMPILER FLAGS
+%token <s> ARG
+
+%%
+
+config_file:    config_line config_file
+        |       /* empty */
+        ;
+
+config_line: name_line
+	   | ext_line
+	   | comp_line
+	   | flags_line
+        ;
+
+name_line: NAME '=' ARG {
+		if ($3 == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+		lang_conf->name = $3;
+		if (lang_conf->name == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+	 }
+	 ;
+
+ext_line: EXTENSION '=' ARG {
+		if ($3 == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+		lang_conf->ext = $3;
+		if (lang_conf->ext == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+	}
+	;
+
+comp_line: COMPILER '=' ARG {
+		if ($3 == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+		lang_conf->compiler = $3;
+		if (lang_conf->compiler == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+	 }
+	 ;
+
+flags_line: FLAGS '=' ARG {
+		if ($3 == NULL) {
+			$3 = strdup("");
+		}
+		lang_conf->flags = $3;
+		if (lang_conf->flags == NULL) {
+			parse_errors++;
+			YYABORT;
+		}
+	  }
+	  ;
+
+%%
+
+static int semanage_lang_conf_init(semanage_lang_conf_t *conf)
+{
+	conf->name = NULL;
+	conf->ext = NULL;
+	conf->compiler = NULL;
+	conf->flags = NULL;
+
+	return STATUS_SUCCESS;
+}
+
+void semanage_lang_conf_destroy(semanage_lang_conf_t *conf)
+{
+	if (conf != NULL) {
+		free(conf->name);
+		free(conf->ext);
+		free(conf->compiler);
+		free(conf->flags);
+		free(conf);
+	}
+}
+
+int semanage_lang_conf_check(semanage_lang_conf_t *conf)
+{
+	if (	conf->name != NULL &&
+		conf->ext != NULL &&
+		conf->compiler != NULL &&
+		conf->flags != NULL) {
+
+		return STATUS_SUCCESS;
+	}
+	return STATUS_ERR;
+}
+
+int semanage_lang_error(char *msg)
+{
+	fprintf(stderr, "error parsing semanage language configuration file: %s\n", msg);
+	parse_errors++;
+	return 0;
+}
+
+static semanage_lang_conf_t *semanage_lang_conf_parse_file(const char *fullpath)
+{
+	int status = 0;
+
+	lang_conf = malloc(sizeof(*lang_conf));
+	if (lang_conf == NULL) goto err;
+
+	status = semanage_lang_conf_init(lang_conf);
+	if (status != 0) goto err;
+
+	semanage_lang_in = fopen(fullpath, "r");
+	if (semanage_lang_in == NULL) goto err;
+
+	parse_errors = 0;
+	semanage_lang_parse();
+
+	fclose(semanage_lang_in);
+
+	if (parse_errors != 0) {
+		goto err;
+	}
+
+	status = semanage_lang_conf_check(lang_conf);
+	if (status != 0) goto err;
+
+	return lang_conf;
+err:
+	semanage_lang_conf_destroy(lang_conf);
+
+	return NULL;
+}
+
+static int ignore_hidden(const struct dirent *dent)
+{
+	if (dent->d_name[0] == '.') return 0;
+	return 1;
+}
+
+/* Parse a libsemanage language configuration file.  THIS FUNCTION IS NOT
+ * THREAD-SAFE!	 Return a newly allocated semanage_lang_conf_t *.
+ * If the file could not be parsed correctly or if out of memory return NULL.
+ */
+semanage_lang_conf_list_t *semanage_lang_conf_parse(const char *path)
+{
+	int status = 0;
+	int cnt = 0;
+	int i = 0;
+	semanage_lang_conf_list_t *head = NULL;
+	semanage_lang_conf_list_t *tail = NULL;
+	semanage_lang_conf_list_t *next = NULL;
+	char fullpath[PATH_MAX];
+	struct stat sb;
+	struct dirent **names = NULL;
+	semanage_lang_conf_t *conf = NULL;
+
+	/* get directory entries */
+	status = scandir(path, &names, ignore_hidden, alphasort);
+	if (status < 0) goto err;
+	cnt = status;
+
+	/* parse each of the langauge confs */
+	for (i = cnt - 1; i >= 0; i--) {
+
+		/* get the full path */
+		snprintf(fullpath, sizeof(fullpath), "%s/%s", path, names[i]->d_name);
+		if (stat(fullpath, &sb)) goto err;
+
+		/* only look at regular files */
+		if (!S_ISREG(sb.st_mode)) continue;
+
+		/* parse the file */
+		conf = semanage_lang_conf_parse_file(fullpath);
+		if (conf == NULL) goto err;
+
+		/* create the list entry */
+		next = malloc(sizeof(semanage_lang_conf_list_t));
+		if (next == NULL) {
+			semanage_lang_conf_destroy(conf);
+			goto err;
+		}
+
+		if (head == NULL) {
+			head = next;
+		}
+
+		/* append */
+		next->data = conf;
+		next->next = NULL;
+
+		if (tail != NULL) {
+			tail->next = next;
+		}
+		tail = next;
+        }
+
+	goto ok;
+err:
+	while (head != NULL) {
+		next = head->next;
+		semanage_lang_conf_destroy(head->data);
+		free(head);
+		head = next;
+	}
+
+ok:
+	if (names != NULL) {
+		for (i = cnt - 1; i >= 0; i--) {
+			free(names[i]);
+		}
+	}
+	free(names);
+
+	return head;
+}
+
diff --git a/libsemanage/src/lang-scan.l b/libsemanage/src/lang-scan.l
new file mode 100644
index 0000000..085ceae
--- /dev/null
+++ b/libsemanage/src/lang-scan.l
@@ -0,0 +1,84 @@
+/* Authors: Jason Tang     <jtang@tresys.com>
+ *          James Athey    <jathey@tresys.com>
+ *          Mark Goldman   <mgoldman@tresys.com>
+ *          Caleb Case     <ccase@tresys.com>
+ *
+ * Copyright (C) 2004-2006,2009-2010 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+%{
+#include "lang-parse.h"
+
+#include <ctype.h>
+#include <string.h>
+
+static char *my_strdup (char * s);
+static char *my_qstrdup (char * s);
+
+int yywrap(void);
+ 
+%}
+
+%option stack prefix="semanage_lang_"
+%option noinput nounput noyy_push_state noyy_pop_state noyy_top_state
+
+%x arg
+
+%%
+
+#.*               /* ignore comments */
+NAME		return NAME;
+COMPILER	return COMPILER;
+EXTENSION	return EXTENSION;
+FLAGS		return FLAGS;
+[ \t]*=[ \t]*     BEGIN arg; return '=';
+[ \t\n]+          /* ignore */
+.                 return semanage_lang_text[0];
+<arg>\"\"         BEGIN INITIAL; semanage_lang_lval.s = NULL; return ARG;
+<arg>\".+\"       BEGIN INITIAL; semanage_lang_lval.s = my_qstrdup(semanage_lang_text); return ARG;
+<arg>.*[^\"\n]    BEGIN INITIAL; semanage_lang_lval.s = my_strdup(semanage_lang_text); return ARG;
+<arg>.|\n         BEGIN INITIAL; semanage_lang_lval.s = NULL; return ARG;
+
+%%
+
+int yywrap(void) {
+	return 1;
+}
+
+/* Like strdup(), but also trim leading and trailing whitespace.
+ * Returns NULL on error. */
+static char *my_strdup(char *s) {
+	char *t;
+	while (isspace(*s)) {
+		s++;
+	}
+	t = s + strlen(s) - 1;
+	while (t >= s && isspace(*t)) {
+		*t = '\0';
+		t--;
+	}
+	return strdup(s);
+}
+
+/* strdup() a string sans initial and trailing characters.  Does /not/
+ * trim any whitespace.	 Returns NULL on error. */
+static char *my_qstrdup(char *s) {
+	s++;
+	s[strlen(s) - 1] = '\0';
+	return strdup(s);
+}
+
diff --git a/libsemanage/src/semanage_lang_conf.h b/libsemanage/src/semanage_lang_conf.h
new file mode 100644
index 0000000..9af1d54
--- /dev/null
+++ b/libsemanage/src/semanage_lang_conf.h
@@ -0,0 +1,39 @@
+/* Authors: Mark Goldman <mgoldman@tresys.com>
+ *          Caleb Case   <ccase@tresys.com>
+ *
+ * Copyright (C) 2009-2010 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef SEMANAGE_LANG_CONF_H
+#define SEMANAGE_LANG_CONF_H
+
+typedef struct semanage_lang_conf {
+	char *name;
+	char *ext;
+	char *compiler;
+	char *flags;
+} semanage_lang_conf_t;
+
+typedef struct semanage_lang_conf_list {
+	semanage_lang_conf_t *data;
+	struct semanage_lang_conf_list *next;
+} semanage_lang_conf_list_t;
+
+semanage_lang_conf_list_t *semanage_lang_conf_parse(const char *config_filename);
+void semanage_lang_conf_destroy(semanage_lang_conf_t *conf);
+
+#endif
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f077ac3..2bda1e2 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -5,7 +5,7 @@
  *          Chris PeBenito <cpebenito@tresys.com>
  *	    Caleb Case <ccase@tresys.com>
  *
- * Copyright (C) 2004-2006,2009 Tresys Technology, LLC
+ * Copyright (C) 2004-2006,2009-2010 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
@@ -492,6 +492,15 @@ const char *semanage_conf_path(void)
 	return "/etc/selinux/semanage.conf";
 }
 
+/* Return a fully-qualified path + filename to the semanage language
+ * configuration files.  The caller must not alter the string returned
+ * (and hence why this function return type is const).
+ */
+const char *semanage_lang_conf_path(void)
+{
+	return "/etc/selinux/language.d";
+}
+
 /* Locates the highest priority enabled base module
  * and fills @path in with that value. @path must be
  * pre-allocated with size @len.
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 16148ef..4ad0b21 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -3,7 +3,7 @@
  *	    Jason Tang <jtang@tresys.com>
  *	    Christopher Ashworth <cashworth@tresys.com>
  *
- * Copyright (C) 2004-2006 Tresys Technology, LLC
+ * Copyright (C) 2004-2006,2010 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
@@ -79,6 +79,7 @@ const char *semanage_root_path(void);
  * global configuration moved to another file.
  */
 const char *semanage_conf_path(void);
+const char *semanage_lang_conf_path(void);
 
 int semanage_check_init(semanage_handle_t *sh, const char *prefix);
 
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
