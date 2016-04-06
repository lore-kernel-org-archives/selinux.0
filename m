Message-ID: <1459959117.7680.12.camel@gmail.com>
Subject: Re: [RFC][PATCH] selinux-testsuite: Add tests for non-init userns
 capability checks
From: Stephen Smalley <stephen.smalley@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Daniel J Walsh <dwalsh@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 06 Apr 2016 09:11:57 -0700
In-Reply-To: <1459958572.7680.6.camel@gmail.com>
References: <1459958221.7680.2.camel@gmail.com>
 <1459958572.7680.6.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-89yKmhAp1jrMKZKusYFU"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-89yKmhAp1jrMKZKusYFU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Attached is a patch for refpolicy to define the new
security classes and allow them for unconfined domains.
Also attached is a sample patch for selinux-policy.spec to add the
patch.  So, to rebuild and install policy with this cange, I did
something like:
	yumdownloader --source selinux-policy-targeted
	rpm -ivh selinux-policy*.src.rpm
	cp refpolicy-define-cap-userns.patch rpmbuild/SOURCES
	cd rpmbuild/SPECS
	patch -p1 < ~/selinux-policy.spec.patch
	rpmbuild -bb selinux-policy.spec
	rpm -Uvh ../RPMS/noarch/selinux-policy*.rpm

I can also send the actual .src.rpm and/or binary rpms separately if
desired/needed, but not on the list.
	
On Wed, 2016-04-06 at 09:02 -0700, Stephen Smalley wrote:
> Add tests for the non-init user namespace capability checks.
> The tests depend on the previously posted kernel patch and on
> a patch for refpolicy to define the new security class.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policy/Makefile                      |   2 +-
>  policy/test_cap_userns.te            |  27 ++++
>  tests/Makefile                       |   2 +-
>  tests/cap_userns/Makefile            |   5 +
>  tests/cap_userns/test                |  17 ++
>  tests/cap_userns/userns_child_exec.c | 298
> +++++++++++++++++++++++++++++++++++
>  6 files changed, 349 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_cap_userns.te
>  create mode 100644 tests/cap_userns/Makefile
>  create mode 100755 tests/cap_userns/test
>  create mode 100644 tests/cap_userns/userns_child_exec.c
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 98fccbc..33f3458 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -20,7 +20,7 @@ TARGETS = \
>  	test_task_create.te test_task_getpgid.te
> test_task_getsched.te \
>  	test_task_getsid.te test_task_setpgid.te
> test_task_setsched.te \
>  	test_transition.te test_inet_socket.te test_unix_socket.te \
> -	test_wait.te test_mmap.te
> +	test_wait.te test_mmap.te test_cap_userns.te
>  
>  ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>  TARGETS += test_bounds.te
> diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> new file mode 100644
> index 0000000..ab74325
> --- /dev/null
> +++ b/policy/test_cap_userns.te
> @@ -0,0 +1,27 @@
> +#################################
> +#
> +# Policy for testing non-init userns capability checking.
> +#
> +
> +attribute capusernsdomain;
> +
> +# Domain for process that is allowed non-init userns capabilities
> +type test_cap_userns_t;
> +domain_type(test_cap_userns_t)
> +unconfined_runs_test(test_cap_userns_t)
> +typeattribute test_cap_userns_t testdomain;
> +typeattribute test_cap_userns_t capusernsdomain;
> +
> +# This domain is allowed sys_admin on non-init userns for mount.
> +allow test_cap_userns_t self:cap_userns sys_admin;
> +
> +# Domain for process that is not allowed non-init userns
> capabilities
> +type test_no_cap_userns_t;
> +domain_type(test_no_cap_userns_t)
> +unconfined_runs_test(test_no_cap_userns_t)
> +typeattribute test_no_cap_userns_t testdomain;
> +typeattribute test_no_cap_userns_t capusernsdomain;
> +
> +# Rules common to both domains.
> +miscfiles_domain_entry_test_files(capusernsdomain)
> +corecmd_exec_bin(capusernsdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 7a9b39c..bf3f946 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -5,7 +5,7 @@ DISTRO=$(shell ./os_detect)
>  
>  SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace
> execute_no_trans fdreceive inherit link mkdir msg open ptrace
> readlink relabel rename rxdir sem setattr setnice shm sigkill stat
> sysctl task_create task_setnice task_setscheduler task_getscheduler
> task_getsid task_getpgid task_setpgid wait file ioctl capable_file
> capable_net capable_sys
>  
> -SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp mmap
> unix_socket inet_socket
> +SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp mmap
> unix_socket inet_socket cap_userns
>  
>  ifeq ($(DISTRO),RHEL4)
>      SUBDIRS:=$(SUBDIRS_COMMON)
> diff --git a/tests/cap_userns/Makefile b/tests/cap_userns/Makefile
> new file mode 100644
> index 0000000..27b4676
> --- /dev/null
> +++ b/tests/cap_userns/Makefile
> @@ -0,0 +1,5 @@
> +TARGETS=userns_child_exec
> +
> +all: $(TARGETS)
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/cap_userns/test b/tests/cap_userns/test
> new file mode 100755
> index 0000000..5842ebd
> --- /dev/null
> +++ b/tests/cap_userns/test
> @@ -0,0 +1,17 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests => 2}
> +
> +$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +# Verify that test_cap_userns_t can mount proc within its own mount
> namespace.
> +
> +$result = system ("runcon -t test_cap_userns_t --
> $basedir/userns_child_exec -p -m -U -M '0 0 1' -G '0 0 1' -- true
> 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_cap_userns_t cannot mount proc within its own
> mount namespace.
> +
> +$result = system ("runcon -t test_no_cap_userns_t --
> $basedir/userns_child_exec -p -m -U -M '0 0 1' -G '0 0 1' -- true
> 2>&1");
> +ok($result);
> +
> diff --git a/tests/cap_userns/userns_child_exec.c
> b/tests/cap_userns/userns_child_exec.c
> new file mode 100644
> index 0000000..26ea357
> --- /dev/null
> +++ b/tests/cap_userns/userns_child_exec.c
> @@ -0,0 +1,298 @@
> +/* Taken from the user_namespaces.7 man page */
> +
> +/* userns_child_exec.c
> +
> +   Licensed under GNU General Public License v2 or later
> +
> +   Create a child process that executes a shell command in new
> +   namespace(s); allow UID and GID mappings to be specified when
> +   creating a user namespace.
> +*/
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <signal.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <limits.h>
> +#include <errno.h>
> +
> +/* A simple error-handling function: print an error message based
> +   on the value in 'errno' and terminate the calling process */
> +
> +#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
> +                        } while (0)
> +
> +struct child_args {
> +    char **argv;        /* Command to be executed by child, with
> args */
> +    int    pipe_fd[2];  /* Pipe used to synchronize parent and child
> */
> +};
> +
> +static int verbose;
> +
> +static void
> +usage(char *pname)
> +{
> +    fprintf(stderr, "Usage: %s [options] cmd [arg...]\n\n", pname);
> +    fprintf(stderr, "Create a child process that executes a shell "
> +            "command in a new user namespace,\n"
> +            "and possibly also other new namespace(s).\n\n");
> +    fprintf(stderr, "Options can be:\n\n");
> +#define fpe(str) fprintf(stderr, "    %s", str);
> +    fpe("-i          New IPC namespace\n");
> +    fpe("-m          New mount namespace\n");
> +    fpe("-n          New network namespace\n");
> +    fpe("-p          New PID namespace\n");
> +    fpe("-u          New UTS namespace\n");
> +    fpe("-U          New user namespace\n");
> +    fpe("-M uid_map  Specify UID map for user namespace\n");
> +    fpe("-G gid_map  Specify GID map for user namespace\n");
> +    fpe("-z          Map user's UID and GID to 0 in user
> namespace\n");
> +    fpe("            (equivalent to: -M '0 <uid> 1' -G '0 <gid>
> 1'\n");
> +    fpe("-v          Display verbose messages\n");
> +    fpe("\n");
> +    fpe("If -z, -M, or -G is specified, -U is required.\n");
> +    fpe("It is not permitted to specify both -z and either -M or
> -G.\n");
> +    fpe("\n");
> +    fpe("Map strings for -M and -G consist of records of the
> form:\n");
> +    fpe("\n");
> +    fpe("    ID-inside-ns   ID-outside-ns   len\n");
> +    fpe("\n");
> +    fpe("A map string can contain multiple records, separated"
> +        " by commas;\n");
> +    fpe("the commas are replaced by newlines before writing"
> +        " to map files.\n");
> +
> +    exit(EXIT_FAILURE);
> +}
> +
> +/* Update the mapping file 'map_file', with the value provided in
> +   'mapping', a string that defines a UID or GID mapping. A UID or
> +   GID mapping consists of one or more newline-delimited records
> +   of the form:
> +
> +       ID_inside-ns    ID-outside-ns   length
> +
> +   Requiring the user to supply a string that contains newlines is
> +   of course inconvenient for command-line use. Thus, we permit the
> +   use of commas to delimit records in this string, and replace them
> +   with newlines before writing the string to the file. */
> +
> +static void
> +update_map(char *mapping, char *map_file)
> +{
> +    int fd, j;
> +    size_t map_len;     /* Length of 'mapping' */
> +
> +    /* Replace commas in mapping string with newlines */
> +
> +    map_len = strlen(mapping);
> +    for (j = 0; j < map_len; j++)
> +        if (mapping[j] == ',')
> +            mapping[j] = '\n';
> +
> +    fd = open(map_file, O_RDWR);
> +    if (fd == -1) {
> +        fprintf(stderr, "ERROR: open %s: %s\n", map_file,
> +                strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (write(fd, mapping, map_len) != map_len) {
> +        fprintf(stderr, "ERROR: write %s: %s\n", map_file,
> +                strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    close(fd);
> +}
> +
> +/* Linux 3.19 made a change in the handling of setgroups(2) and the
> +   'gid_map' file to address a security issue. The issue allowed
> +   *unprivileged* users to employ user namespaces in order to drop
> +   The upshot of the 3.19 changes is that in order to update the
> +   'gid_maps' file, use of the setgroups() system call in this
> +   user namespace must first be disabled by writing "deny" to one of
> +   the /proc/PID/setgroups files for this namespace.  That is the
> +   purpose of the following function. */
> +
> +static void
> +proc_setgroups_write(pid_t child_pid, char *str)
> +{
> +    char setgroups_path[PATH_MAX];
> +    int fd;
> +
> +    snprintf(setgroups_path, PATH_MAX, "/proc/%ld/setgroups",
> +            (long) child_pid);
> +
> +    fd = open(setgroups_path, O_RDWR);
> +    if (fd == -1) {
> +
> +        /* We may be on a system that doesn't support
> +           /proc/PID/setgroups. In that case, the file won't exist,
> +           and the system won't impose the restrictions that Linux
> 3.19
> +           added. That's fine: we don't need to do anything in order
> +           to permit 'gid_map' to be updated.
> +
> +           However, if the error from open() was something other
> than
> +           the ENOENT error that is expected for that case,  let the
> +           user know. */
> +
> +        if (errno != ENOENT)
> +            fprintf(stderr, "ERROR: open %s: %s\n", setgroups_path,
> +                strerror(errno));
> +        return;
> +    }
> +
> +    if (write(fd, str, strlen(str)) == -1)
> +        fprintf(stderr, "ERROR: write %s: %s\n", setgroups_path,
> +            strerror(errno));
> +
> +    close(fd);
> +}
> +
> +static int              /* Start function for cloned child */
> +childFunc(void *arg)
> +{
> +    struct child_args *args = (struct child_args *) arg;
> +    char ch;
> +
> +    /* Wait until the parent has updated the UID and GID mappings.
> +       See the comment in main(). We wait for end of file on a
> +       pipe that will be closed by the parent process once it has
> +       updated the mappings. */
> +
> +    close(args->pipe_fd[1]);    /* Close our descriptor for the
> write
> +                                   end of the pipe so that we see
> EOF
> +                                   when parent closes its descriptor
> */
> +    if (read(args->pipe_fd[0], &ch, 1) != 0) {
> +        fprintf(stderr,
> +                "Failure in child: read from pipe returned != 0\n");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Execute a shell command */
> +
> +    printf("About to exec %s\n", args->argv[0]);
> +    execvp(args->argv[0], args->argv);
> +    errExit("execvp");
> +}
> +
> +#define STACK_SIZE (1024 * 1024)
> +
> +static char child_stack[STACK_SIZE];    /* Space for child's stack
> */
> +
> +int
> +main(int argc, char *argv[])
> +{
> +    int flags, opt, map_zero;
> +    pid_t child_pid;
> +    struct child_args args;
> +    char *uid_map, *gid_map;
> +    const int MAP_BUF_SIZE = 100;
> +    char map_buf[MAP_BUF_SIZE];
> +    char map_path[PATH_MAX];
> +
> +    /* Parse command-line options. The initial '+' character in
> +       the final getopt() argument prevents GNU-style permutation
> +       of command-line options. That's useful, since sometimes
> +       the 'command' to be executed by this program itself
> +       has command-line options. We don't want getopt() to treat
> +       those as options to this program. */
> +
> +    flags = 0;
> +    verbose = 0;
> +    gid_map = NULL;
> +    uid_map = NULL;
> +    map_zero = 0;
> +    while ((opt = getopt(argc, argv, "+imnpuUM:G:zv")) != -1) {
> +        switch (opt) {
> +        case 'i': flags |= CLONE_NEWIPC;        break;
> +        case 'm': flags |= CLONE_NEWNS;         break;
> +        case 'n': flags |= CLONE_NEWNET;        break;
> +        case 'p': flags |= CLONE_NEWPID;        break;
> +        case 'u': flags |= CLONE_NEWUTS;        break;
> +        case 'v': verbose = 1;                  break;
> +        case 'z': map_zero = 1;                 break;
> +        case 'M': uid_map = optarg;             break;
> +        case 'G': gid_map = optarg;             break;
> +        case 'U': flags |= CLONE_NEWUSER;       break;
> +        default:  usage(argv[0]);
> +        }
> +    }
> +
> +    /* -M or -G without -U is nonsensical */
> +
> +    if (((uid_map != NULL || gid_map != NULL || map_zero) &&
> +                !(flags & CLONE_NEWUSER)) ||
> +            (map_zero && (uid_map != NULL || gid_map != NULL)))
> +        usage(argv[0]);
> +
> +    args.argv = &argv[optind];
> +
> +    /* We use a pipe to synchronize the parent and child, in order
> to
> +       ensure that the parent sets the UID and GID maps before the
> child
> +       calls execve(). This ensures that the child maintains its
> +       capabilities during the execve() in the common case where we
> +       want to map the child's effective user ID to 0 in the new
> user
> +       namespace. Without this synchronization, the child would lose
> +       its capabilities if it performed an execve() with nonzero
> +       user IDs (see the capabilities(7) man page for details of the
> +       transformation of a process's capabilities during execve()).
> */
> +
> +    if (pipe(args.pipe_fd) == -1)
> +        errExit("pipe");
> +
> +    /* Create the child in new namespace(s) */
> +
> +    child_pid = clone(childFunc, child_stack + STACK_SIZE,
> +                      flags | SIGCHLD, &args);
> +    if (child_pid == -1)
> +        errExit("clone");
> +
> +    /* Parent falls through to here */
> +
> +    if (verbose)
> +        printf("%s: PID of child created by clone() is %ld\n",
> +                argv[0], (long) child_pid);
> +
> +    /* Update the UID and GID maps in the child */
> +
> +    if (uid_map != NULL || map_zero) {
> +        snprintf(map_path, PATH_MAX, "/proc/%ld/uid_map",
> +                (long) child_pid);
> +        if (map_zero) {
> +            snprintf(map_buf, MAP_BUF_SIZE, "0 %ld 1", (long)
> getuid());
> +            uid_map = map_buf;
> +        }
> +        update_map(uid_map, map_path);
> +    }
> +
> +    if (gid_map != NULL || map_zero) {
> +        proc_setgroups_write(child_pid, "deny");
> +
> +        snprintf(map_path, PATH_MAX, "/proc/%ld/gid_map",
> +                (long) child_pid);
> +        if (map_zero) {
> +            snprintf(map_buf, MAP_BUF_SIZE, "0 %ld 1", (long)
> getgid());
> +            gid_map = map_buf;
> +        }
> +        update_map(gid_map, map_path);
> +    }
> +
> +    /* Close the write end of the pipe, to signal to the child that
> we
> +       have updated the UID and GID maps */
> +
> +    close(args.pipe_fd[1]);
> +
> +    if (waitpid(child_pid, NULL, 0) == -1)      /* Wait for child */
> +        errExit("waitpid");
> +
> +    if (verbose)
> +        printf("%s: terminating\n", argv[0]);
> +
> +    exit(EXIT_SUCCESS);
> +}
> -- 
> 2.8.0
> 
--=-89yKmhAp1jrMKZKusYFU
Content-Disposition: attachment; filename="refpolicy-define-cap-userns.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="refpolicy-define-cap-userns.patch"; charset="UTF-8"

ZGlmZiAtcnUgc2VyZWZwb2xpY3ktMy4xMy4xLm9yaWcvcG9saWN5L2ZsYXNrL2FjY2Vzc192ZWN0
b3JzIHNlcmVmcG9saWN5LTMuMTMuMS9wb2xpY3kvZmxhc2svYWNjZXNzX3ZlY3RvcnMKLS0tIHNl
cmVmcG9saWN5LTMuMTMuMS5vcmlnL3BvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkyMDE2LTA0
LTA1IDE0OjU5OjU2LjU0ODcxMjA4OCAtMDcwMAorKysgc2VyZWZwb2xpY3ktMy4xMy4xL3BvbGlj
eS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkyMDE2LTA0LTA1IDIwOjI5OjU3Ljk4MTEzOTcyNyAtMDcw
MApAQCAtOTI1LDMgKzkyNSw1NiBAQAogewogCXJlYWQKIH0KKworY2xhc3MgY2FwX3VzZXJucwor
eworCSMgVGhlIGNhcGFiaWxpdGllcyBhcmUgZGVmaW5lZCBpbiBpbmNsdWRlL2xpbnV4L2NhcGFi
aWxpdHkuaAorCSMgQ2FwYWJpbGl0aWVzID49IDMyIGFyZSBkZWZpbmVkIGluIHRoZSBjYXBhYmls
aXR5MiBjbGFzcy4KKwkjIENhcmUgc2hvdWxkIGJlIHRha2VuIHRvIGVuc3VyZSB0aGF0IHRoZXNl
IGFyZSBjb25zaXN0ZW50IHdpdGgKKwkjIHRob3NlIGRlZmluaXRpb25zLiAoT3JkZXIgbWF0dGVy
cykKKworCWNob3duICAgICAgICAgICAKKwlkYWNfb3ZlcnJpZGUgICAgCisJZGFjX3JlYWRfc2Vh
cmNoIAorCWZvd25lciAgICAgICAgICAKKwlmc2V0aWQgICAgICAgICAgCisJa2lsbCAgICAgICAg
ICAgIAorCXNldGdpZCAgICAgICAgICAgCisJc2V0dWlkICAgICAgICAgICAKKwlzZXRwY2FwICAg
ICAgICAgIAorCWxpbnV4X2ltbXV0YWJsZSAgCisJbmV0X2JpbmRfc2VydmljZSAKKwluZXRfYnJv
YWRjYXN0ICAgIAorCW5ldF9hZG1pbiAgICAgICAgCisJbmV0X3JhdyAgICAgICAgICAKKwlpcGNf
bG9jayAgICAgICAgIAorCWlwY19vd25lciAgICAgICAgCisJc3lzX21vZHVsZSAgICAgICAKKwlz
eXNfcmF3aW8gICAgICAgIAorCXN5c19jaHJvb3QgICAgICAgCisJc3lzX3B0cmFjZSAgICAgICAK
KwlzeXNfcGFjY3QgICAgICAgIAorCXN5c19hZG1pbiAgICAgICAgCisJc3lzX2Jvb3QgICAgICAg
ICAKKwlzeXNfbmljZSAgICAgICAgIAorCXN5c19yZXNvdXJjZSAgICAgCisJc3lzX3RpbWUgICAg
ICAgICAKKwlzeXNfdHR5X2NvbmZpZyAgCisJbWtub2QKKwlsZWFzZQorCWF1ZGl0X3dyaXRlCisJ
YXVkaXRfY29udHJvbAorCXNldGZjYXAKK30KKworY2xhc3MgY2FwMl91c2VybnMKK3sKKwltYWNf
b3ZlcnJpZGUJIyB1bnVzZWQgYnkgU0VMaW51eAorCW1hY19hZG1pbgorCXN5c2xvZworCXdha2Vf
YWxhcm0KKwllcG9sd2FrZXVwCisJYmxvY2tfc3VzcGVuZAorCWNvbXByb21pc2Vfa2VybmVsCisJ
YXVkaXRfcmVhZAorfQpkaWZmIC1ydSBzZXJlZnBvbGljeS0zLjEzLjEub3JpZy9wb2xpY3kvZmxh
c2svc2VjdXJpdHlfY2xhc3NlcyBzZXJlZnBvbGljeS0zLjEzLjEvcG9saWN5L2ZsYXNrL3NlY3Vy
aXR5X2NsYXNzZXMKLS0tIHNlcmVmcG9saWN5LTMuMTMuMS5vcmlnL3BvbGljeS9mbGFzay9zZWN1
cml0eV9jbGFzc2VzCTIwMTYtMDQtMDUgMTQ6NTk6NTYuNTQ4NzEyMDg4IC0wNzAwCisrKyBzZXJl
ZnBvbGljeS0zLjEzLjEvcG9saWN5L2ZsYXNrL3NlY3VyaXR5X2NsYXNzZXMJMjAxNi0wNC0wNSAy
MDoyOTo1Ny45ODExMzk3MjcgLTA3MDAKQEAgLTE0OSw1ICsxNDksOCBAQAogIyBnc3NkIHNlcnZp
Y2VzIAogY2xhc3MgcHJveHkKIAorIyBDYXBhYmlsaXR5IGNoZWNrcyB3aGVuIG9uIGEgbm9uLWlu
aXQgdXNlciBuYW1lc3BhY2UKK2NsYXNzIGNhcF91c2VybnMKK2NsYXNzIGNhcDJfdXNlcm5zCiAK
ICMgRkxBU0sKZGlmZiAtcnUgc2VyZWZwb2xpY3ktMy4xMy4xLm9yaWcvcG9saWN5L21vZHVsZXMv
a2VybmVsL2tlcm5lbC50ZSBzZXJlZnBvbGljeS0zLjEzLjEvcG9saWN5L21vZHVsZXMva2VybmVs
L2tlcm5lbC50ZQotLS0gc2VyZWZwb2xpY3ktMy4xMy4xLm9yaWcvcG9saWN5L21vZHVsZXMva2Vy
bmVsL2tlcm5lbC50ZQkyMDE2LTA0LTA1IDE0OjU5OjU2LjU2NzcxMjQ3OSAtMDcwMAorKysgc2Vy
ZWZwb2xpY3ktMy4xMy4xL3BvbGljeS9tb2R1bGVzL2tlcm5lbC9rZXJuZWwudGUJMjAxNi0wNC0w
NSAyMTo1Nzo0NC42MzQyMTgyNDEgLTA3MDAKQEAgLTQ5MSw2ICs0OTEsOSBAQAogIyBSdWxlcyBm
b3IgdW5jb25maW5lZCBhY2NjZXNzIHRvIHRoaXMgbW9kdWxlCiAjCiAKK2FsbG93IGtlcm5fdW5j
b25maW5lZCBzZWxmOmNhcF91c2VybnMgYWxsX2NhcF91c2VybnNfcGVybXM7CithbGxvdyBrZXJu
X3VuY29uZmluZWQgc2VsZjpjYXAyX3VzZXJucyBhbGxfY2FwMl91c2VybnNfcGVybXM7CisKIGFs
bG93IGtlcm5fdW5jb25maW5lZCBwcm9jX3R5cGU6eyBmaWxlIH0gfmVudHJ5cG9pbnQ7CiBhbGxv
dyBrZXJuX3VuY29uZmluZWQgcHJvY190eXBlOnsgZGlyIGxua19maWxlIH0gKjsKIAo=


--=-89yKmhAp1jrMKZKusYFU
Content-Disposition: attachment; filename="selinux-policy.spec.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="selinux-policy.spec.patch"; charset="UTF-8"

LS0tIHNlbGludXgtcG9saWN5LnNwZWMub3JpZwkyMDE2LTA0LTA1IDE1OjExOjAxLjM0NTM4MjQ0
OCAtMDcwMAorKysgc2VsaW51eC1wb2xpY3kuc3BlYwkyMDE2LTA0LTA1IDIwOjI4OjU0LjkxMjg5
ODg3OCAtMDcwMApAQCAtMTksNyArMTksNyBAQAogU3VtbWFyeTogU0VMaW51eCBwb2xpY3kgY29u
ZmlndXJhdGlvbgogTmFtZTogc2VsaW51eC1wb2xpY3kKIFZlcnNpb246IDMuMTMuMQotUmVsZWFz
ZTogMTgwJXs/ZGlzdH0KK1JlbGVhc2U6IDE4MCV7P2Rpc3R9LnVzZXJucy4xCiBMaWNlbnNlOiBH
UEx2MisKIEdyb3VwOiBTeXN0ZW0gRW52aXJvbm1lbnQvQmFzZQogU291cmNlOiBzZXJlZnBvbGlj
eS0le3ZlcnNpb259LnRnegpAQCAtMjksNiArMjksNyBAQAogcGF0Y2g6IHBvbGljeS1yYXdoaWRl
LWJhc2UucGF0Y2gKIHBhdGNoMTogcG9saWN5LXJhd2hpZGUtY29udHJpYi5wYXRjaAogcGF0Y2gy
OiBwb2xpY3ktcmF3aGlkZS1iYXNlLWNvY2twaXQucGF0Y2gKK3BhdGNoMzogcmVmcG9saWN5LWRl
ZmluZS1jYXAtdXNlcm5zLnBhdGNoCiBTb3VyY2UxOiBtb2R1bGVzLXRhcmdldGVkLWJhc2UuY29u
ZiAKIFNvdXJjZTMxOiBtb2R1bGVzLXRhcmdldGVkLWNvbnRyaWIuY29uZgogU291cmNlMjogYm9v
bGVhbnMtdGFyZ2V0ZWQuY29uZgpAQCAtMzI0LDYgKzMyNSw3IEBACiAlc2V0dXAgLW4gc2VyZWZw
b2xpY3ktJXt2ZXJzaW9ufSAtcQogJXBhdGNoIC1wMQogJXBhdGNoMiAtcDEKKyVwYXRjaDMgLXAx
CiByZWZwb2xpY3lfcGF0aD1gcHdkYAogY3AgJGNvbnRyaWJfcGF0aC8qICRyZWZwb2xpY3lfcGF0
aC9wb2xpY3kvbW9kdWxlcy9jb250cmliCiAK


--=-89yKmhAp1jrMKZKusYFU--
