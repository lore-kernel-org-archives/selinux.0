Message-Id: <200509270008.j8R08sYs019022@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] semanage-functionality 2/17
Date: Mon, 26 Sep 2005 20:08:53 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B9_01C5C2D6.1E86AE60"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00B9_01C5C2D6.1E86AE60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch renames functions in the config file parser and adds
functionality.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00B9_01C5C2D6.1E86AE60
Content-Type: application/octet-stream;
	name="libsemanage_src_conf-parse.y.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_conf-parse.y.diff"

diff -purN -x .svn libsemanage/src/conf-parse.y =
libsemanage/src/conf-parse.y=0A=
--- libsemanage/src/conf-parse.y	2005-09-26 14:02:40.000000000 -0400=0A=
+++ libsemanage/src/conf-parse.y	2005-09-26 11:36:20.000000000 -0400=0A=
@@ -19,7 +19,7 @@=0A=
 =0A=
 %{=0A=
 =0A=
-#include "semanage/semod_conf.h"=0A=
+#include "semanage_conf.h"=0A=
 =0A=
 #include <sepol/policydb.h>=0A=
 =0A=
@@ -27,25 +27,26 @@=0A=
 #include <stdlib.h>=0A=
 #include <string.h>=0A=
 =0A=
-extern int semod_lex ();                     /* defined in conf-scan.c =
*/=0A=
-int semod_error (char *msg);=0A=
+extern int semanage_lex();                /* defined in conf-scan.c */=0A=
+int semanage_error(char *msg);=0A=
+hidden_proto(semanage_error) ;=0A=
+=0A=
+extern FILE *semanage_in;=0A=
+extern char *semanage_text;=0A=
+=0A=
+static int parse_module_store(char *arg);=0A=
+static void semanage_conf_external_prog_destroy(external_prog_t *ep);=0A=
+static int new_external_prog(external_prog_t **chain);=0A=
 =0A=
-extern FILE *semod_in;=0A=
-extern char *semod_text;=0A=
-=0A=
-static int semod_init_conf (semod_conf_t *conf);=0A=
-static int parse_module_store (char *arg);=0A=
-static int new_external_prog (external_prog_t **chain);=0A=
-=0A=
-static semod_conf_t semod_conf, *current_conf;=0A=
+static semanage_conf_t *current_conf;=0A=
 static external_prog_t *new_external;=0A=
 static int parse_errors;=0A=
 =0A=
-#define PASSIGN(p1,p2) { free (p1); p1 =3D p2; }=0A=
+#define PASSIGN(p1,p2) { free(p1); p1 =3D p2; }=0A=
 =0A=
 %}=0A=
 =0A=
-%name-prefix=3D"semod_"=0A=
+%name-prefix=3D"semanage_"=0A=
 =0A=
 %union {=0A=
         int d;=0A=
@@ -53,7 +54,7 @@ static int parse_errors;=0A=
 }=0A=
 =0A=
 %token MODULE_STORE VERSION=0A=
-%token LOAD_POLICY_START=0A=
+%token LOAD_POLICY_START SETFILES_START=0A=
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START =
BLOCK_END=0A=
 %token PROG_PATH PROG_ARGS=0A=
 %token <s> ARG=0A=
@@ -66,7 +67,7 @@ config_file:    config_line config_file=0A=
         ;=0A=
 =0A=
 config_line:    single_opt=0A=
-        |       load_policy_block=0A=
+        |       command_block=0A=
         |       verify_block=0A=
         ;=0A=
 =0A=
@@ -75,7 +76,7 @@ single_opt:     module_store=0A=
         ;=0A=
 =0A=
 module_store:   MODULE_STORE '=3D' ARG {=0A=
-                        if (parse_module_store ($3) !=3D 0) {=0A=
+                        if (parse_module_store($3) !=3D 0) {=0A=
                                 parse_errors++;=0A=
                                 YYABORT;=0A=
                         }=0A=
@@ -84,8 +85,8 @@ module_store:   MODULE_STORE '=3D' ARG {=0A=
         ;=0A=
 =0A=
 version:        VERSION '=3D' ARG  {=0A=
-                        current_conf->policyvers =3D atoi ($3);=0A=
-                        free ($3);=0A=
+                        current_conf->policyvers =3D atoi($3);=0A=
+                        free($3);=0A=
                         if (current_conf->policyvers < =
POLICYDB_VERSION_MIN ||=0A=
                             current_conf->policyvers > =
POLICYDB_VERSION_MAX) {=0A=
                                 parse_errors++;=0A=
@@ -94,8 +95,8 @@ version:        VERSION '=3D' ARG  {=0A=
                 }=0A=
         ;=0A=
 =0A=
-load_policy_block: =0A=
-                load_policy_start external_opts BLOCK_END  {=0A=
+command_block: =0A=
+                command_start external_opts BLOCK_END  {=0A=
                         if (new_external->path =3D=3D NULL) {=0A=
                                 parse_errors++;=0A=
                                 YYABORT;=0A=
@@ -103,13 +104,19 @@ load_policy_block: =0A=
                 }=0A=
         ;=0A=
 =0A=
-load_policy_start:=0A=
+command_start:=0A=
                 LOAD_POLICY_START {=0A=
-                        free (current_conf->load_policy->path);=0A=
-                        free (current_conf->load_policy->args);=0A=
-                        free (current_conf->load_policy);=0A=
+                        =
semanage_conf_external_prog_destroy(current_conf->load_policy);=0A=
                         current_conf->load_policy =3D NULL;=0A=
-                        if (new_external_prog =
(&current_conf->load_policy) =3D=3D -1) {=0A=
+                        if =
(new_external_prog(&current_conf->load_policy) =3D=3D -1) {=0A=
+                                parse_errors++;=0A=
+                                YYABORT;=0A=
+                        }=0A=
+                }=0A=
+        |       SETFILES_START {=0A=
+                        =
semanage_conf_external_prog_destroy(current_conf->setfiles);=0A=
+                        current_conf->setfiles =3D NULL;=0A=
+                        if (new_external_prog(&current_conf->setfiles) =
=3D=3D -1) {=0A=
                                 parse_errors++;=0A=
                                 YYABORT;=0A=
                         }=0A=
@@ -132,146 +139,178 @@ verify_start:   verify_start_tok {=0A=
                 }=0A=
         ;=0A=
 =0A=
-verify_start_tok: VERIFY_MOD_START  {$$ =3D new_external_prog =
(&current_conf->mod_prog);}=0A=
-        |       VERIFY_LINKED_START {$$ =3D new_external_prog =
(&current_conf->linked_prog);}=0A=
-        |       VERIFY_KERNEL_START {$$ =3D new_external_prog =
(&current_conf->kernel_prog);}=0A=
+verify_start_tok: VERIFY_MOD_START  {$$ =3D =
new_external_prog(&current_conf->mod_prog);}=0A=
+        |       VERIFY_LINKED_START {$$ =3D =
new_external_prog(&current_conf->linked_prog);}=0A=
+        |       VERIFY_KERNEL_START {$$ =3D =
new_external_prog(&current_conf->kernel_prog);}=0A=
         ;=0A=
 =0A=
-external_opts:    external_opt external_opts=0A=
-        |         /* empty */=0A=
+external_opts:  external_opt external_opts=0A=
+        |       /* empty */=0A=
         ;=0A=
 =0A=
-external_opt:   PROG_PATH '=3D' ARG  { PASSIGN (new_external->path, =
$3); }=0A=
-        |       PROG_ARGS '=3D' ARG  { PASSIGN (new_external->args, =
$3); }=0A=
+external_opt:   PROG_PATH '=3D' ARG  { PASSIGN(new_external->path, $3); =
}=0A=
+        |       PROG_ARGS '=3D' ARG  { PASSIGN(new_external->args, $3); =
}=0A=
         ;=0A=
 =0A=
 %%=0A=
 =0A=
-/* Parse a libsemod configuration file.  THIS FUNCTION IS NOT=0A=
- * THREAD-SAFE!  Returns 0 if file parsed correctly, -1 if=0A=
- * config_filename could not be read, or otherwise the number of parse=0A=
- * errors encountered.=0A=
- */=0A=
-int semod_config_parse (char *config_filename) {=0A=
-        current_conf =3D &semod_conf;=0A=
-        (void) memset (current_conf, 0, sizeof (*current_conf));=0A=
-        if (semod_init_conf (current_conf) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((semod_in =3D fopen (config_filename, "r")) =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        parse_errors =3D 0;=0A=
-        (void) semod_parse ();=0A=
-        (void) fclose (semod_in);=0A=
-        return parse_errors;=0A=
+static int semanage_conf_init(semanage_conf_t *conf) {=0A=
+	conf->store_type =3D SEMANAGE_CON_DIRECT;=0A=
+	conf->policyvers =3D POLICYDB_VERSION_MAX;=0A=
+=0A=
+	if ((conf->load_policy =3D calloc(1, =
sizeof(*(current_conf->load_policy)))) =3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	if ((conf->load_policy->path =3D strdup("/usr/sbin/load_policy")) =
=3D=3D NULL ||=0A=
+	    (conf->load_policy->args =3D strdup("-b $@")) =3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	=0A=
+	if ((conf->setfiles =3D calloc(1, sizeof(*(current_conf->setfiles)))) =
=3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	if ((conf->setfiles->path =3D strdup("/usr/sbin/setfiles")) =3D=3D =
NULL ||=0A=
+	    (conf->setfiles->args =3D strdup("-q -c $@ $<")) =3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-/* Returns a pointer to the current configuration structure. */=0A=
-semod_conf_t *semod_get_current_conf (void) {=0A=
-        return current_conf;=0A=
+/* Parse a libsemanage configuration file.  THIS FUNCTION IS NOT=0A=
+ * THREAD-SAFE!	 Return a newly allocated semanage_conf_t *.  If the=0A=
+ * configuration file could be read, parse it; otherwise rely upon=0A=
+ * default values.  If the file could not be parsed correctly or if=0A=
+ * out of memory return NULL.=0A=
+ */=0A=
+semanage_conf_t *semanage_conf_parse(const char *config_filename) {=0A=
+	if ((current_conf =3D calloc(1, sizeof(*current_conf))) =3D=3D NULL) {=0A=
+		return NULL;=0A=
+	}=0A=
+	if (semanage_conf_init(current_conf) =3D=3D -1) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((semanage_in =3D fopen(config_filename, "r")) =3D=3D NULL) {=0A=
+		/* configuration file does not exist or could not be=0A=
+		 * read.  THIS IS NOT AN ERROR.	 just rely on the=0A=
+		 * defaults. */=0A=
+		return current_conf;=0A=
+	}=0A=
+	parse_errors =3D 0;=0A=
+	semanage_parse();=0A=
+	fclose(semanage_in);=0A=
+	if (parse_errors !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	return current_conf;=0A=
+ cleanup:=0A=
+	semanage_conf_destroy(current_conf);=0A=
+	return NULL;=0A=
 }=0A=
 =0A=
-/* Returns 1 if the configuration file says to use the module store=0A=
- * directly, otherwise return 0. */=0A=
-int semod_is_store_direct (void) {=0A=
-        if (current_conf->module_store.store_type =3D=3D =
SEMOD_STORE_DIRECT) {=0A=
-                return 1;=0A=
-        }=0A=
-        return 0;=0A=
+static void semanage_conf_external_prog_destroy(external_prog_t *ep) {=0A=
+	while (ep !=3D NULL) {=0A=
+		external_prog_t *next =3D ep->next;=0A=
+		free(ep->path);=0A=
+		free(ep->args);=0A=
+		free(ep);=0A=
+		ep =3D next;=0A=
+	}=0A=
 }=0A=
 =0A=
-int semod_error (char *msg __attribute__ ((unused))) {=0A=
-        parse_errors++;=0A=
-        return 0;=0A=
+/* Deallocates all space associated with a configuration struct,=0A=
+ * including the pointer itself. */=0A=
+void semanage_conf_destroy(semanage_conf_t *conf) {=0A=
+	if (conf !=3D NULL) {=0A=
+		free(conf->server_path);=0A=
+		semanage_conf_external_prog_destroy(conf->load_policy);=0A=
+		semanage_conf_external_prog_destroy(conf->setfiles);=0A=
+		semanage_conf_external_prog_destroy(conf->mod_prog);=0A=
+		semanage_conf_external_prog_destroy(conf->linked_prog);=0A=
+		semanage_conf_external_prog_destroy(conf->kernel_prog);=0A=
+		free(conf);=0A=
+	}=0A=
 }=0A=
 =0A=
-static int semod_init_conf (semod_conf_t *conf) {=0A=
-        conf->module_store.store_type =3D SEMOD_STORE_DIRECT;=0A=
-        conf->policyvers =3D POLICYDB_VERSION_MAX;=0A=
-        =0A=
-        if ((conf->load_policy =3D calloc (1, sizeof =
(*(current_conf->load_policy)))) =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((conf->load_policy->path =3D strdup =
("/usr/sbin/load_policy")) =3D=3D NULL ||=0A=
-            (conf->load_policy->args =3D strdup ("-b $@")) =3D=3D NULL) =
{=0A=
-                return -1;=0A=
-        }=0A=
-        =0A=
-        if ((conf->setfiles =3D calloc (1, sizeof =
(*(current_conf->setfiles)))) =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((conf->setfiles->path =3D strdup ("/usr/sbin/setfiles")) =
=3D=3D NULL ||=0A=
-            (conf->setfiles->args =3D strdup ("-q -c $@ $<")) =3D=3D =
NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        return 0;=0A=
+int semanage_error(char *msg) {=0A=
+	parse_errors++;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-/* Take the string argument for a module store.  If it is exactly the=0A=
- * word "direct" then have libsemod directly manipulate the module=0A=
+/* Take the string argument for a module store.	 If it is exactly the=0A=
+ * word "direct" then have libsemanage directly manipulate the module=0A=
  * store.  Otherwise if it begins with a forward slash interpret it as=0A=
  * an absolute path to a named socket, to which a policy server is=0A=
- * listening on the other end.  Otherwise treat it as the host name to=0A=
+ * listening on the other end.	Otherwise treat it as the host name to=0A=
  * an external server; if there is a colon in the name then everything=0A=
  * after gives a port number.  The default port number is 4242.=0A=
  * Returns 0 on success, -1 if out of memory, -2 if a port number is=0A=
  * illegal.=0A=
  */=0A=
-static int parse_module_store (char *arg) {=0A=
-        /* arg is already a strdup()ed copy of yytext */=0A=
-        if (arg =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        free (current_conf->module_store.server_path);=0A=
-        if (strcmp (arg, "direct") =3D=3D 0) {=0A=
-                current_conf->module_store.store_type =3D =
SEMOD_STORE_DIRECT;=0A=
-                current_conf->module_store.server_path =3D NULL;=0A=
-                current_conf->module_store.server_port =3D -1;=0A=
-        }=0A=
-        else if (*arg =3D=3D '/') {=0A=
-                current_conf->module_store.store_type =3D =
SEMOD_STORE_NAMED_SOCKET;=0A=
-                current_conf->module_store.server_path =3D arg;=0A=
-                current_conf->module_store.server_port =3D -1;=0A=
-        }=0A=
-        else {=0A=
-                char *s;=0A=
-                current_conf->module_store.store_type =3D =
SEMOD_STORE_REMOTE_SOCKET;=0A=
-                if ((s =3D strchr (arg, ':')) =3D=3D NULL) {=0A=
-                        current_conf->module_store.server_path =3D arg;=0A=
-                        current_conf->module_store.server_port =3D 4242;=0A=
-                }=0A=
-                else {=0A=
-                        char *endptr;=0A=
-                        *s =3D '\0';=0A=
-                        current_conf->module_store.server_path =3D arg;=0A=
-                        current_conf->module_store.server_port =3D =
strtol (s + 1, &endptr, 10);=0A=
-                        if (*(s + 1) =3D=3D '\0' || *endptr !=3D '\0') {=0A=
-                                return -2;=0A=
-                        }=0A=
-                }=0A=
-        }=0A=
-        return 0;=0A=
+static int parse_module_store(char *arg) {=0A=
+	/* arg is already a strdup()ed copy of yytext */=0A=
+	if (arg =3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	free(current_conf->server_path);=0A=
+	if (strcmp(arg, "source") =3D=3D 0) {=0A=
+		current_conf->store_type =3D SEMANAGE_CON_SOURCE;=0A=
+		current_conf->server_path =3D NULL;=0A=
+		current_conf->server_port =3D -1;=0A=
+		free(arg);=0A=
+	}=0A=
+	if (strcmp(arg, "direct") =3D=3D 0) {=0A=
+		current_conf->store_type =3D SEMANAGE_CON_DIRECT;=0A=
+		current_conf->server_path =3D NULL;=0A=
+		current_conf->server_port =3D -1;=0A=
+		free(arg);=0A=
+	}=0A=
+	else if(*arg =3D=3D '/') {=0A=
+		current_conf->store_type =3D SEMANAGE_CON_POLSERV_LOCAL;=0A=
+		current_conf->server_path =3D arg;=0A=
+		current_conf->server_port =3D -1;=0A=
+	}=0A=
+	else {=0A=
+		char *s;=0A=
+		current_conf->store_type =3D SEMANAGE_CON_POLSERV_REMOTE;=0A=
+		if ((s =3D strchr(arg, ':')) =3D=3D NULL) {=0A=
+			current_conf->server_path =3D arg;=0A=
+			current_conf->server_port =3D 4242;=0A=
+		}=0A=
+		else {=0A=
+			char *endptr;=0A=
+			*s =3D '\0';=0A=
+			current_conf->server_path =3D arg;=0A=
+			current_conf->server_port =3D strtol(s + 1, &endptr, 10);=0A=
+			if (*(s + 1) =3D=3D '\0' || *endptr !=3D '\0') {=0A=
+				return -2;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 /* Helper function; called whenever configuration file specifies=0A=
  * another external program.  Returns 0 on success, -1 if out of=0A=
  * memory.=0A=
  */=0A=
-static int new_external_prog (external_prog_t **chain) {=0A=
-        if ((new_external =3D calloc (1, sizeof (*new_external))) =
=3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        /* hook this new external program to the end of the chain */=0A=
-        if (*chain =3D=3D NULL) {=0A=
-                *chain =3D new_external;=0A=
-        }=0A=
-        else {=0A=
-                external_prog_t *prog =3D *chain;=0A=
-                while (prog->next !=3D NULL) {=0A=
-                        prog =3D prog->next;=0A=
-                }=0A=
-                prog->next =3D new_external;=0A=
-        }=0A=
-        return 0;=0A=
+static int new_external_prog(external_prog_t **chain) {=0A=
+	if ((new_external =3D calloc(1, sizeof(*new_external))) =3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	/* hook this new external program to the end of the chain */=0A=
+	if (*chain =3D=3D NULL) {=0A=
+		*chain =3D new_external;=0A=
+	}=0A=
+	else {=0A=
+		external_prog_t *prog =3D *chain;=0A=
+		while (prog->next !=3D NULL) {=0A=
+			prog =3D prog->next;=0A=
+		}=0A=
+		prog->next =3D new_external;=0A=
+	}=0A=
+	return 0;=0A=
 }=0A=
+=0A=
+hidden_def(semanage_conf_parse)=0A=
+hidden_def(semanage_conf_destroy)=0A=
+hidden_def(semanage_error)=0A=

------=_NextPart_000_00B9_01C5C2D6.1E86AE60--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
