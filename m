From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 12/13] semodule: add priority, enabled, and extended listing
Date: Wed, 23 Dec 2009 18:25:59 -0500
Message-Id: <1261610760-4724-13-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-12-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
 <1261610760-4724-7-git-send-email-ccase@tresys.com>
 <1261610760-4724-8-git-send-email-ccase@tresys.com>
 <1261610760-4724-9-git-send-email-ccase@tresys.com>
 <1261610760-4724-10-git-send-email-ccase@tresys.com>
 <1261610760-4724-11-git-send-email-ccase@tresys.com>
 <1261610760-4724-12-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This updates the semodule tool with the ability to set the priority for
commands, to enable/disable modules, and extended module listing options
for displaying extra module information (e.g., priority, enabled status,
and language extension).

[semodule priority]

-p --priority set the priority for following operations

Notes:

* This sets the priority for the following operations.

* It can be used any number of times with its effect continuing until
  the next priority is specified.

* The default priority is used if no priority has yet been specified.

Impact on current operations:

* Install module

  * Without priority - Install at default priority.

  * With priority - Install at specified priority.

  * New warning when overriding (issued by libsemanage).

* Upgrade module

  * Without priority - Upgrade at default priority (current upgrade
    semantics apply).

  * With priority - Upgrade at specified priority (current upgrade
    semantics apply).

  * New warning when overriding (issued by libsemanage).

* Remove module

  * Without priority - Remove a module at the default if exists.

  * With priority - Remove at that priority.

  * New info messages (issued by libsemanage):

    * If no modules exist at the given priority but do exist at other
      priorities, give an info message listing the modules and priority.

    * If a new module at a lower priority will become active print a
      message.

    * If the last module with this name is being removed print a
      message.

* Base

  * The name of base module on install is fixed to "_base" (performed by
    libsemanage).

  * Without priority - Install at default priority.

  * With priority - Install at specified priority.

  * New warning when overriding (issued by libsemanage).

* List modules

  * See listing changes below.

Examples:

# install a module at default - this will install the module at priority 400
semodule -i foo.pp

# Install a module at a specific priority
semodule -p 500 -i foo.pp

[semodule enable/disable]

Add enable/disable status:

-e   --enable   enable the module (at all priorities)
-d   --disable  disable the module (at all priorities)

Notes:

* Base modules are always enabled and cannot have their enabled/disabled
  status changed.

* New error when disabling a base module (from libsemanage).

* New warning when enabling a base module (from libsemanage).

Impact on current operations:

* Install module

  * If a module with that name is already installed, then the enabled
    status will remain the same after installing the new module.

  * New warning when installing a module which will be disabled by
    existing enabled status (from libsemanage).

* Upgrade module

  * If a module with that name is already installed, then the enabled
    status will remain the same after installing the new module.

  * New warning when installing a module which will be disabled by
    existing enabled status (from libsemanage).

* Remove module

  * When the last module with a given name is removed (no more exist at
    other priorities) then the enabled status is forgotten.

* Base

  * Base modules are always installed enabled and remain so (can't be
    disabled).

* List modules

  * See listing changes below.

Examples:

# enable module
semodule -e foo

# disable module
semodule -d foo

[semodule list]

-l		--list		list modules as if by -lstandard

-lstandard	--list=standard	list name and version of highest priority,
				enabled, non-base modules sorted alphabetical
				by name

-lfull		--list=full	list all fields of all modules columnated
				sorted high priority to low, within priority
				alphabetical by name

Impact on current operations:

* List modules

  * Default listing stays the same.

  * New long options for 'standard' and 'full'.

Examples:

# list modules using standard method
semodule -l
semodule -lstandard
semodule --list=standard

alsa 1.7.1
apm 1.9.1
apt 1.5.2
authlogin 2.0.0
avahi 1.10.3
bluetooth 3.1.3
...

# list modules using full method
semodule -lfull
semodule --list=full

600 alsa      1.7.1 disabled pp
400 _base     1.0.0          pp
400 alsa      1.7.1 disabled pp
400 apm       1.9.1          pp
400 apt       1.5.2          pp
400 authlogin 2.0.0          pp
...
100 alsa      1.7.1 disabled pp
---
 policycoreutils/semodule/semodule.8 |   25 ++++-
 policycoreutils/semodule/semodule.c |  242 +++++++++++++++++++++++++++++++----
 2 files changed, 239 insertions(+), 28 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 1c1d206..4b52a63 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -38,9 +38,26 @@ install/replace base module package
 .B  \-r,\-\-remove=MODULE_NAME
 remove existing module
 .TP
-.B  \-l,\-\-list-modules      
+.B  \-l,\-\-list-modules=[KIND]
 display list of installed modules (other than base)
 .TP
+.B  KIND:
+.TP
+standard
+list highest priority, enabled, non-base modules
+.TP
+full
+list all modules
+.TP
+.B  \-p,\-\-priority=PRIORITY
+set priority for following operations (1-999)
+.TP
+.B  \-e,\-\-enabled=MODULE_NAME
+enable module
+.TP
+.B  \-d,\-\-disable=MODULE_NAME
+disable module
+.TP
 .B  \-s,\-\-store	   
 name of the store to operate on
 .TP
@@ -69,6 +86,12 @@ $ semodule -B
 $ semodule -i *.pp
 # Install or replace all modules in the current directory.
 $ ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule -b base.pp -i
+# Disable a module.
+$ semodule -d alsa
+# Install a module at a specific priority.
+$ semodule -p 100 -i alsa.pp
+# List all modules.
+$ semodule -l full
 .fi
 
 .SH SEE ALSO
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ad6adca..569b808 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -22,13 +22,16 @@
 
 #include <semanage/modules.h>
 
-enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
-	LIST_M, RELOAD
+#include <semanage/private/semanage.h>
+
+enum client_modes {
+	NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
+	LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M
 };
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
 	0, 1, 1, 1, 1,
-	0, 0
+	0, 0, 0, 1, 1,
 };
 
 struct command {
@@ -45,6 +48,7 @@ static int no_reload;
 static int create_store;
 static int build;
 static int disable_dontaudit;
+static uint16_t priority;
 
 static semanage_handle_t *sh = NULL;
 static char *store;
@@ -107,8 +111,12 @@ static void usage(char *progname)
 	printf("  -u,--upgrade=MODULE_PKG   upgrades or install module to a newer version\n");
 	printf("  -b,--base=MODULE_PKG      install new base module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
-	printf
-	    ("  -l,--list-modules         display list of installed modules\n");
+	printf("  -l,--list-modules=[KIND]  display list of installed modules\n");
+	printf("     KIND:  standard  list highest priority, enabled, non-base modules\n");
+	printf("            full      list all modules\n");
+	printf("  -p,--priority=PRIORITY    set priority for following operations (1-999)\n");
+	printf("  -e,--enable=MODULE_NAME   enable module\n");
+	printf("  -d,--disable=MODULE_NAME  disable module\n");
 	printf("Other options:\n");
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -n,--noreload	   do not reload policy after commit\n");
@@ -150,7 +158,7 @@ static void parse_command_line(int argc, char **argv)
 		{"base", required_argument, NULL, 'b'},
 		{"help", 0, NULL, 'h'},
 		{"install", required_argument, NULL, 'i'},
-		{"list-modules", 0, NULL, 'l'},
+		{"list-modules", optional_argument, NULL, 'l'},
 		{"verbose", 0, NULL, 'v'},
 		{"remove", required_argument, NULL, 'r'},
 		{"upgrade", required_argument, NULL, 'u'},
@@ -158,6 +166,9 @@ static void parse_command_line(int argc, char **argv)
 		{"noreload", 0, NULL, 'n'},
 		{"build", 0, NULL, 'B'},
 		{"disable_dontaudit", 0, NULL, 'D'},
+		{"priority", required_argument, NULL, 'p'},
+		{"enable", required_argument, NULL, 'e'},
+		{"disable", required_argument, NULL, 'd'},
 		{NULL, 0, NULL, 0}
 	};
 	int i;
@@ -165,8 +176,9 @@ static void parse_command_line(int argc, char **argv)
 	reload = 0;
 	no_reload = 0;
 	create_store = 0;
+	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:lvqr:u:RnBD", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -180,7 +192,7 @@ static void parse_command_line(int argc, char **argv)
 			set_mode(INSTALL_M, optarg);
 			break;
 		case 'l':
-			set_mode(LIST_M, NULL);
+			set_mode(LIST_M, optarg);
 			break;
 		case 'v':
 			verbose = 1;
@@ -206,6 +218,15 @@ static void parse_command_line(int argc, char **argv)
 		case 'D':
 			disable_dontaudit = 1;
 			break;
+		case 'p':
+			set_mode(PRIORITY_M, optarg);
+			break;
+		case 'e':
+			set_mode(ENABLE_M, optarg);
+			break;
+		case 'd':
+			set_mode(DISABLE_M, optarg);
+			break;
 		case '?':
 		default:{
 				usage(argv[0]);
@@ -318,9 +339,18 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if ((result = semanage_set_default_priority(sh, priority)) != 0) {
+		fprintf(stderr,
+			"%s: Invalid priority %d (needs to be between 1 and 999)\n",
+			argv[0],
+			priority);
+		goto cleanup;
+	}
+
 	for (i = 0; i < num_commands; i++) {
 		enum client_modes mode = commands[i].mode;
 		char *mode_arg = commands[i].arg;
+
 		switch (mode) {
 		case INSTALL_M:{
 				if (verbose) {
@@ -365,33 +395,191 @@ int main(int argc, char *argv[])
 				break;
 			}
 		case LIST_M:{
-				semanage_module_info_t *modinfo;
-				int num_modules;
+				semanage_module_info_t *modinfos = NULL;
+				int modinfos_len = 0;
+				semanage_module_info_t *m = NULL;
+				int j = 0;
+
 				if (verbose) {
 					printf
 					    ("Attempting to list active modules:\n");
 				}
-				if ((result =
-				     semanage_module_list(sh, &modinfo,
-							  &num_modules)) >= 0) {
-					int j;
-					if (num_modules == 0) {
+
+				if (mode_arg == NULL || strcmp(mode_arg, "standard") == 0) {
+					result = semanage_module_list(sh,
+								      &modinfos,
+								      &modinfos_len);
+					if (result < 0) goto cleanup_list;
+
+					if (modinfos_len == 0) {
+						printf("No modules.\n");
+					}
+
+					const char *name = NULL;
+					const char *version = NULL;
+
+					for (j = 0; j < modinfos_len; j++) {
+						m = semanage_module_list_nth(modinfos, j);
+
+						result = semanage_module_info_get_name(sh, m, &name);
+						if (result != 0) goto cleanup_list;
+
+						result = semanage_module_info_get_version(sh, m, &version);
+						if (result != 0) goto cleanup_list;
+
+						printf("%s\t%s\n", name, version);
+					}
+				}
+				else if (strcmp(mode_arg, "full") == 0) {
+					/* get the modules */
+					result = semanage_module_list_all(sh,
+									  &modinfos,
+									  &modinfos_len);
+					if (result != 0) goto cleanup_list;
+
+					if (modinfos_len == 0) {
 						printf("No modules.\n");
 					}
-					for (j = 0; j < num_modules; j++) {
-						semanage_module_info_t *m =
-						    semanage_module_list_nth
-						    (modinfo, j);
-						printf("%s\t%s\n",
-						       semanage_module_get_name
-						       (m),
-						       semanage_module_get_version
-						       (m));
-						semanage_module_info_datum_destroy
-						    (m);
+
+					/* calculate column widths */
+					size_t column[5] = { 0, 0, 0, 0, 0 };
+
+					/* fixed width columns */
+					column[0] = sizeof("000") - 1;
+					column[3] = sizeof("disabled") - 1;
+
+					/* variable width columns */
+					const char *tmp = NULL;
+					size_t size;
+					for (j = 0; j < modinfos_len; j++) {
+						m = semanage_module_list_nth(modinfos, j);
+
+						result = semanage_module_info_get_name(sh, m, &tmp);
+						if (result != 0) goto cleanup_list;
+
+						size = strlen(tmp);
+						if (size > column[1]) column[1] = size;
+
+						result = semanage_module_info_get_version(sh, m, &tmp);
+						if (result != 0) goto cleanup_list;
+
+						size = strlen(tmp);
+						if (size > column[2]) column[2] = size;
+
+						result = semanage_module_info_get_lang_ext(sh, m, &tmp);
+						if (result != 0) goto cleanup_list;
+
+						size = strlen(tmp);
+						if (size > column[4]) column[4] = size;
+					}
+
+					/* print out each module */
+					for (j = 0; j < modinfos_len; j++) {
+						uint16_t pri = 0;
+						const char *name = NULL;
+						const char *version = NULL;
+						int enabled = 0;
+						const char *lang_ext = NULL;
+
+						m = semanage_module_list_nth(modinfos, j);
+
+						result = semanage_module_info_get_priority(sh, m, &pri);
+						if (result != 0) goto cleanup_list;
+
+						result = semanage_module_info_get_name(sh, m, &name);
+						if (result != 0) goto cleanup_list;
+
+						result = semanage_module_info_get_version(sh, m, &version);
+						if (result != 0) goto cleanup_list;
+
+						result = semanage_module_info_get_enabled(sh, m, &enabled);
+						if (result != 0) goto cleanup_list;
+
+						result = semanage_module_info_get_lang_ext(sh, m, &lang_ext);
+						if (result != 0) goto cleanup_list;
+
+						printf("%0*u %-*s %-*s %*s %-*s\n",
+							(int)column[0], pri,
+							(int)column[1], name,
+							(int)column[2], version,
+							(int)column[3], enabled ? "" : "disabled",
+							(int)column[4], lang_ext);
 					}
-					free(modinfo);
 				}
+				else {
+					result = -1;
+				}
+
+cleanup_list:
+				for (j = 0; j < modinfos_len; j++) {
+					m = semanage_module_list_nth(modinfos, j);
+					semanage_module_info_destroy(sh, m);
+				}
+
+				free(modinfos);
+
+				break;
+			}
+		case PRIORITY_M:{
+				char *endptr = NULL;
+				priority = (uint16_t)strtoul(mode_arg, &endptr, 10);
+
+				if ((result = semanage_set_default_priority(sh, priority)) != 0) {
+					fprintf(stderr,
+						"%s: Invalid priority %d (needs to be between 1 and 999)\n",
+						argv[0],
+						priority);
+					goto cleanup;
+				}
+
+				break;
+			}
+		case ENABLE_M:{
+				if (verbose) {
+					printf
+					    ("Attempting to enable module '%s':\n",
+					     mode_arg);
+				}
+
+				semanage_module_key_t *modkey = NULL;
+
+				result = semanage_module_key_create(sh, &modkey);
+				if (result != 0) goto cleanup_enable;
+
+				result = semanage_module_key_set_name(sh, modkey, mode_arg);
+				if (result != 0) goto cleanup_enable;
+
+				result = semanage_module_set_enabled(sh, modkey, 1);
+				if (result != 0) goto cleanup_enable;
+
+cleanup_enable:
+				semanage_module_key_destroy(sh, modkey);
+				free(modkey);
+
+				break;
+			}
+		case DISABLE_M:{
+				if (verbose) {
+					printf
+					    ("Attempting to disable module '%s':\n",
+					     mode_arg);
+				}
+
+				semanage_module_key_t *modkey = NULL;
+
+				result = semanage_module_key_create(sh, &modkey);
+				if (result != 0) goto cleanup_disable;
+
+				result = semanage_module_key_set_name(sh, modkey, mode_arg);
+				if (result != 0) goto cleanup_disable;
+
+				result = semanage_module_set_enabled(sh, modkey, 0);
+				if (result != 0) goto cleanup_disable;
+
+cleanup_disable:
+				semanage_module_key_destroy(sh, modkey);
+				free(modkey);
+
 				break;
 			}
 		default:{
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
