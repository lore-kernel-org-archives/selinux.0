From: Dan Walsh <dwalsh@redhat.com>
To: SELinux@tycho.nsa.gov
Subject: [PATCH 3/4] Remove handling of cgroups from sandbox
Date: Mon, 12 May 2014 13:19:20 -0400
Message-Id: <1399915161-31072-3-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1399915161-31072-1-git-send-email-dwalsh@redhat.com>
References: <1399915161-31072-1-git-send-email-dwalsh@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It never worked correctly and this should be handled with an
API to systemd going forward.
---
 policycoreutils/sandbox/Makefile    |   2 +-
 policycoreutils/sandbox/sandbox     |  10 +-
 policycoreutils/sandbox/seunshare.8 |   5 +-
 policycoreutils/sandbox/seunshare.c | 218 +-----------------------------------
 4 files changed, 5 insertions(+), 230 deletions(-)

diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
index 981c56c..5671170 100644
--- a/policycoreutils/sandbox/Makefile
+++ b/policycoreutils/sandbox/Makefile
@@ -8,7 +8,7 @@ MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
-LDLIBS += -lcgroup -lselinux -lcap-ng -L$(LIBDIR)
+LDLIBS += -lselinux -lcap-ng -L$(LIBDIR)
 SEUNSHARE_OBJS = seunshare.o
 
 all: sandbox seunshare sandboxX.sh start
diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 3668abe..3678c5d 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -280,9 +280,9 @@ Policy defines the following types for use with the -t:
                pass
 
         usage = _("""
-sandbox [-h] [-c] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [ -w windowsize ] [[-i file ] ...] [ -t type ] command
+sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [ -w windowsize ] [[-i file ] ...] [ -t type ] command
 
-sandbox [-h] [-c] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [ -w windowsize ] [[-i file ] ...] [ -t type ] -S
+sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [ -w windowsize ] [[-i file ] ...] [ -t type ] -S
 %s
 """) % types
 
@@ -338,10 +338,6 @@ sandbox [-h] [-c] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile
         parser.add_option("-l", "--level", dest="level", 
                           help=_("MCS/MLS level for the sandbox"))
 
-        parser.add_option("-c", "--cgroups",
-                          action="store_true", dest="usecgroup", default=False,
-                          help=_("Use cgroups to limit this sandbox."))
-
         parser.add_option("-C", "--capabilities",
                          action="store_true", dest="usecaps", default=False,
                          help="Allow apps requiring capabilities to run within the sandbox.")
@@ -426,8 +422,6 @@ sandbox [-h] [-c] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile
     def __execute(self):
            try:
                   cmds = [ SEUNSHARE,  "-Z", self.__execcon ]
-                  if self.__options.usecgroup:
-                         cmds.append('-c')
                   if self.__options.usecaps:
                          cmds.append('-C')
                   if self.__mount:
diff --git a/policycoreutils/sandbox/seunshare.8 b/policycoreutils/sandbox/seunshare.8
index 06610c0..76b75c8 100644
--- a/policycoreutils/sandbox/seunshare.8
+++ b/policycoreutils/sandbox/seunshare.8
@@ -3,7 +3,7 @@
 seunshare \- Run cmd with alternate homedir, tmpdir and/or SELinux context
 .SH SYNOPSIS
 .B seunshare
-[ -v ] [ -c ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -Z context ] -- executable [args]
+[ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -Z context ] -- executable [args]
 .br
 .SH DESCRIPTION
 .PP
@@ -18,9 +18,6 @@ Alternate homedir to be used by the application.  Homedir must be owned by the u
 \fB\-t\ tmpdir
 Use alternate tempory directory to mount on /tmp.  tmpdir must be owned by the user.
 .TP
-\fB\-c --cgroups\fR
-Use cgroups to control this copy of seunshare.  Specify parameters in /etc/sysconfig/sandbox.  Max memory usage and cpu usage are to be specified in percent.  You can specify which CPUs to use by numbering them 0,1,2... etc.
-.TP
 \fB\-C --capabilities\fR
 Allow apps executed within the namespace to use capabilities.  Default is no capabilities.
 .TP
diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index 596a43e..a221920 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -14,7 +14,6 @@
 #include <glob.h>
 #include <pwd.h>
 #include <sched.h>
-#include <libcgroup.h>
 #include <string.h>
 #include <stdio.h>
 #include <regex.h>
@@ -53,7 +52,7 @@
 
 #define BUF_SIZE 1024
 #define DEFAULT_PATH "/usr/bin:/bin"
-#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -c ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -Z CONTEXT ] -- executable [args] ")
+#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -Z CONTEXT ] -- executable [args] ")
 
 static int verbose = 0;
 static int child = 0;
@@ -290,213 +289,6 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
 
 }
 
-/**
- * Error logging used by cgroups code.
- */
-static int sandbox_error(const char *string)
-{
-	fprintf(stderr, "%s", string);
-	syslog(LOG_AUTHPRIV | LOG_ALERT, "%s", string);
-	exit(-1);
-}
-
-/**
- * Regular expression match.
- */
-static int match(const char *string, char *pattern)
-{
-	int status;
-	regex_t re;
-	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB) != 0) {
-		return 0;
-	}
-	status = regexec(&re, string, (size_t)0, NULL, 0);
-	regfree(&re);
-	if (status != 0) {
-		return 0;
-	}
-	return 1;
-}
-
-/**
- * Apply cgroups settings from the /etc/sysconfig/sandbox config file.
- */
-static int setup_cgroups()
-{
-	char *cpus = NULL;	/* which CPUs to use */
-	char *cgroupname = NULL;/* name for the cgroup */
-	char *mem = NULL;	/* string for memory amount to pass to cgroup */
-	int64_t memusage = 0;	/* amount of memory to use max (percent) */
-	int cpupercentage = 0;  /* what percentage of cpu to allow usage */
-	FILE* fp;
-	char buf[BUF_SIZE];
-	char *tok = NULL;
-	int rc = -1;
-	char *str = NULL;
-	const char* fname = "/etc/sysconfig/sandbox";
-
-	if ((fp = fopen(fname, "rt")) == NULL) {
-		fprintf(stderr, "Error opening sandbox config file.");
-		return rc;
-	}
-	while(fgets(buf, BUF_SIZE, fp) != NULL) {
-		/* Skip comments */
-		if (buf[0] == '#') continue;
-
-		/* Copy the string, ignoring whitespace */
-		int len = strlen(buf);
-		free(str);
-		str = malloc((len + 1) * sizeof(char));
-		if (!str)
-			goto err;
-
-		int ind = 0;
-		int i;
-		for (i = 0; i < len; i++) {
-			char cur = buf[i];
-			if (cur != ' ' && cur != '\t') {
-				str[ind] = cur;
-				ind++;
-			}
-		}
-		str[ind] = '\0';
-
-		tok = strtok(str, "=\n");
-		if (tok != NULL) {
-			if (!strcmp(tok, "CPUAFFINITY")) {
-				tok = strtok(NULL, "=\n");
-				cpus = strdup(tok);
-				if (!strcmp(cpus, "ALL")) {
-					free(cpus);
-					cpus = NULL;
-				}
-			} else if (!strcmp(tok, "MEMUSAGE")) {
-				tok = strtok(NULL, "=\n");
-				if (match(tok, "^[0-9]+[kKmMgG%]")) {
-					char *ind = strchr(tok, '%');
-					if (ind != NULL) {
-						*ind = '\0';;
-						memusage = atoi(tok);
-					} else {
-						mem = strdup(tok);
-					}
-				} else {
-					fprintf(stderr, "Error parsing config file.");
-					goto err;
-				}
-
-			} else if (!strcmp(tok, "CPUUSAGE")) {
-				tok = strtok(NULL, "=\n");
-				if (match(tok, "^[0-9]+\%")) {
-					char* ind = strchr(tok, '%');
-					*ind = '\0';
-					cpupercentage = atoi(tok);
-				} else {
-					fprintf(stderr, "Error parsing config file.");
-					goto err;
-				}
-			} else if (!strcmp(tok, "NAME")) {
-				tok = strtok(NULL, "=\n");
-				cgroupname = strdup(tok);
-			} else {
-				continue;
-			}
-		}
-
-	}
-	if (mem == NULL) {
-		long phypz = sysconf(_SC_PHYS_PAGES);
-		long psize = sysconf(_SC_PAGE_SIZE);
-		memusage = phypz * psize * (float) memusage / 100.0;
-	}
-
-	cgroup_init();
-
-	int64_t current_runtime = 0;
-	int64_t current_period = 0 ;
-	int64_t current_mem = 0;
-	char *curr_cpu_path = NULL;
-	char *curr_mem_path = NULL;
-	int ret  = cgroup_get_current_controller_path(getpid(), "cpu", &curr_cpu_path);
-	if (ret) {
-		sandbox_error("Error while trying to get current controller path.\n");
-	} else {
-		struct cgroup *curr = cgroup_new_cgroup(curr_cpu_path);
-		cgroup_get_cgroup(curr);
-		cgroup_get_value_int64(cgroup_get_controller(curr, "cpu"), "cpu.rt_runtime_us", &current_runtime);
-		cgroup_get_value_int64(cgroup_get_controller(curr, "cpu"), "cpu.rt_period_us", &current_period);
-	}
-
-	ret  = cgroup_get_current_controller_path(getpid(), "memory", &curr_mem_path);
-	if (ret) {
-		sandbox_error("Error while trying to get current controller path.\n");
-	} else {
-		struct cgroup *curr = cgroup_new_cgroup(curr_mem_path);
-		cgroup_get_cgroup(curr);
-		cgroup_get_value_int64(cgroup_get_controller(curr, "memory"), "memory.limit_in_bytes", &current_mem);
-	}
-
-	if (((float) cpupercentage)  / 100.0> (float)current_runtime / (float) current_period) {
-		sandbox_error("CPU usage restricted!\n");
-		goto err;
-	}
-
-	if (mem == NULL) {
-		if (memusage > current_mem) {
-			sandbox_error("Attempting to use more memory than allowed!");
-			goto err;
-		}
-	}
-
-	long nprocs = sysconf(_SC_NPROCESSORS_ONLN);
-
-	struct sched_param sp;
-	sp.sched_priority = sched_get_priority_min(SCHED_FIFO);
-	sched_setscheduler(getpid(), SCHED_FIFO, &sp);
-	struct cgroup *sandbox_group = cgroup_new_cgroup(cgroupname);
-	cgroup_add_controller(sandbox_group, "memory");
-	cgroup_add_controller(sandbox_group, "cpu");
-
-	if (mem == NULL) {
-		if (memusage > 0) {
-			cgroup_set_value_uint64(cgroup_get_controller(sandbox_group, "memory"), "memory.limit_in_bytes", memusage);
-		}
-	} else {
-		cgroup_set_value_string(cgroup_get_controller(sandbox_group, "memory"), "memory.limit_in_bytes", mem);
-	}
-	if (cpupercentage > 0) {
-		cgroup_set_value_uint64(cgroup_get_controller(sandbox_group, "cpu"), "cpu.rt_runtime_us",
-					(float) cpupercentage / 100.0 * 60000);
-		cgroup_set_value_uint64(cgroup_get_controller(sandbox_group, "cpu"), "cpu.rt_period_us",60000 * nprocs);
-	}
-	if (cpus != NULL) {
-		cgroup_set_value_string(cgroup_get_controller(sandbox_group, "cpu"), "cgroup.procs",cpus);
-	}
-
-	uint64_t allocated_mem;
-	if (cgroup_get_value_uint64(cgroup_get_controller(sandbox_group, "memory"), "memory.limit_in_bytes", &allocated_mem) > current_mem) {
-		sandbox_error("Attempting to use more memory than allowed!\n");
-		goto err;
-	}
-
-	rc = cgroup_create_cgroup(sandbox_group, 1);
-	if (rc != 0) {
-		sandbox_error("Failed to create group.  Ensure that cgconfig service is running. \n");
-		goto err;
-	}
-
-	cgroup_attach_task(sandbox_group);
-
-	rc = 0;
-err:
-	fclose(fp);
-	free(str);
-	free(mem);
-	free(cgroupname);
-	free(cpus);
-	return rc;
-}
-
 /*
    If path is empy or ends with  "/." or "/.. return -1 else return 0;
  */
@@ -826,7 +618,6 @@ int main(int argc, char **argv) {
 	security_context_t execcon = NULL;
 
 	int clflag;		/* holds codes for command line flags */
-	int usecgroups = 0;
 	int kill_all = 0;
 
 	char *homedir_s = NULL;	/* homedir spec'd by user in argv[] */
@@ -843,7 +634,6 @@ int main(int argc, char **argv) {
 		{"tmpdir", 1, 0, 't'},
 		{"kill", 1, 0, 'k'},
 		{"verbose", 1, 0, 'v'},
-		{"cgroups", 1, 0, 'c'},
 		{"context", 1, 0, 'Z'},
 		{"capabilities", 1, 0, 'C'},
 		{NULL, 0, 0, 0}
@@ -892,9 +682,6 @@ int main(int argc, char **argv) {
 		case 'v':
 			verbose++;
 			break;
-		case 'c':
-			usecgroups = 1;
-			break;
 		case 'C':
 			cap_set = CAPNG_SELECT_CAPS;
 			break;
@@ -925,9 +712,6 @@ int main(int argc, char **argv) {
 	if (set_signal_handles())
 		return -1;
 
-	if (usecgroups && setup_cgroups() < 0)
-		return  -1;
-
 	/* set fsuid to ruid */
 	/* Changing fsuid is usually required when user-specified directory is
 	 * on an NFS mount.  It's also desired to avoid leaking info about
-- 
1.9.0
