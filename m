Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QFwQCE005358
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 11:58:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97BF82B0A72
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 15:58:10 +0000 (UTC)
Subject: [PATCH 2/2] all: use ./tools/check-syntax to fix the existing code
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 26 May 2017 11:58:09 -0400
Message-ID: <149581428964.13714.3317522790537623046.stgit@sifl>
In-Reply-To: <149581413266.13714.10451742889870299166.stgit@sifl>
References: <149581413266.13714.10451742889870299166.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The results of running './tools/check-syntax -f' across the repo.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/cap_userns/userns_child_exec.c |  455 ++++++++++++++++++----------------
 tests/mmap/mprotect_stack_thread.c   |    3 
 tests/mmap/shmat.c                   |    2 
 tests/unix_socket/client.c           |   14 +
 tests/unix_socket/server.c           |    8 -
 5 files changed, 253 insertions(+), 229 deletions(-)

diff --git a/tests/cap_userns/userns_child_exec.c b/tests/cap_userns/userns_child_exec.c
index 78aa9aa..bfff944 100644
--- a/tests/cap_userns/userns_child_exec.c
+++ b/tests/cap_userns/userns_child_exec.c
@@ -28,11 +28,11 @@
    on the value in 'errno' and terminate the calling process */
 
 #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
-                        } while (0)
+	} while (0)
 
 struct child_args {
-    char **argv;        /* Command to be executed by child, with args */
-    int    pipe_fd[2];  /* Pipe used to synchronize parent and child */
+	char **argv;        /* Command to be executed by child, with args */
+	int    pipe_fd[2];  /* Pipe used to synchronize parent and child */
 };
 
 static int verbose;
@@ -40,38 +40,38 @@ static int verbose;
 static void
 usage(char *pname)
 {
-    fprintf(stderr, "Usage: %s [options] cmd [arg...]\n\n", pname);
-    fprintf(stderr, "Create a child process that executes a shell "
-            "command in a new user namespace,\n"
-            "and possibly also other new namespace(s).\n\n");
-    fprintf(stderr, "Options can be:\n\n");
+	fprintf(stderr, "Usage: %s [options] cmd [arg...]\n\n", pname);
+	fprintf(stderr, "Create a child process that executes a shell "
+		"command in a new user namespace,\n"
+		"and possibly also other new namespace(s).\n\n");
+	fprintf(stderr, "Options can be:\n\n");
 #define fpe(str) fprintf(stderr, "    %s", str);
-    fpe("-i          New IPC namespace\n");
-    fpe("-m          New mount namespace\n");
-    fpe("-n          New network namespace\n");
-    fpe("-p          New PID namespace\n");
-    fpe("-u          New UTS namespace\n");
-    fpe("-U          New user namespace\n");
-    fpe("-M uid_map  Specify UID map for user namespace\n");
-    fpe("-G gid_map  Specify GID map for user namespace\n");
-    fpe("-z          Map user's UID and GID to 0 in user namespace\n");
-    fpe("            (equivalent to: -M '0 <uid> 1' -G '0 <gid> 1'\n");
-    fpe("-v          Display verbose messages\n");
-    fpe("-t          Test clone flags combination is supported\n");
-    fpe("\n");
-    fpe("If -z, -M, or -G is specified, -U is required.\n");
-    fpe("It is not permitted to specify both -z and either -M or -G.\n");
-    fpe("\n");
-    fpe("Map strings for -M and -G consist of records of the form:\n");
-    fpe("\n");
-    fpe("    ID-inside-ns   ID-outside-ns   len\n");
-    fpe("\n");
-    fpe("A map string can contain multiple records, separated"
-        " by commas;\n");
-    fpe("the commas are replaced by newlines before writing"
-        " to map files.\n");
-
-    exit(EXIT_FAILURE);
+	fpe("-i          New IPC namespace\n");
+	fpe("-m          New mount namespace\n");
+	fpe("-n          New network namespace\n");
+	fpe("-p          New PID namespace\n");
+	fpe("-u          New UTS namespace\n");
+	fpe("-U          New user namespace\n");
+	fpe("-M uid_map  Specify UID map for user namespace\n");
+	fpe("-G gid_map  Specify GID map for user namespace\n");
+	fpe("-z          Map user's UID and GID to 0 in user namespace\n");
+	fpe("            (equivalent to: -M '0 <uid> 1' -G '0 <gid> 1'\n");
+	fpe("-v          Display verbose messages\n");
+	fpe("-t          Test clone flags combination is supported\n");
+	fpe("\n");
+	fpe("If -z, -M, or -G is specified, -U is required.\n");
+	fpe("It is not permitted to specify both -z and either -M or -G.\n");
+	fpe("\n");
+	fpe("Map strings for -M and -G consist of records of the form:\n");
+	fpe("\n");
+	fpe("    ID-inside-ns   ID-outside-ns   len\n");
+	fpe("\n");
+	fpe("A map string can contain multiple records, separated"
+	    " by commas;\n");
+	fpe("the commas are replaced by newlines before writing"
+	    " to map files.\n");
+
+	exit(EXIT_FAILURE);
 }
 
 /* Update the mapping file 'map_file', with the value provided in
@@ -89,30 +89,30 @@ usage(char *pname)
 static void
 update_map(char *mapping, char *map_file)
 {
-    int fd, j;
-    size_t map_len;     /* Length of 'mapping' */
-
-    /* Replace commas in mapping string with newlines */
-
-    map_len = strlen(mapping);
-    for (j = 0; j < map_len; j++)
-        if (mapping[j] == ',')
-            mapping[j] = '\n';
-
-    fd = open(map_file, O_RDWR);
-    if (fd == -1) {
-        fprintf(stderr, "ERROR: open %s: %s\n", map_file,
-                strerror(errno));
-        exit(EXIT_FAILURE);
-    }
-
-    if (write(fd, mapping, map_len) != map_len) {
-        fprintf(stderr, "ERROR: write %s: %s\n", map_file,
-                strerror(errno));
-        exit(EXIT_FAILURE);
-    }
-
-    close(fd);
+	int fd, j;
+	size_t map_len;     /* Length of 'mapping' */
+
+	/* Replace commas in mapping string with newlines */
+
+	map_len = strlen(mapping);
+	for (j = 0; j < map_len; j++)
+		if (mapping[j] == ',')
+			mapping[j] = '\n';
+
+	fd = open(map_file, O_RDWR);
+	if (fd == -1) {
+		fprintf(stderr, "ERROR: open %s: %s\n", map_file,
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	if (write(fd, mapping, map_len) != map_len) {
+		fprintf(stderr, "ERROR: write %s: %s\n", map_file,
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
 }
 
 /* Linux 3.19 made a change in the handling of setgroups(2) and the
@@ -127,68 +127,68 @@ update_map(char *mapping, char *map_file)
 static void
 proc_setgroups_write(pid_t child_pid, char *str)
 {
-    char setgroups_path[PATH_MAX];
-    int fd;
+	char setgroups_path[PATH_MAX];
+	int fd;
 
-    snprintf(setgroups_path, PATH_MAX, "/proc/%ld/setgroups",
-            (long) child_pid);
+	snprintf(setgroups_path, PATH_MAX, "/proc/%ld/setgroups",
+		 (long) child_pid);
 
-    fd = open(setgroups_path, O_RDWR);
-    if (fd == -1) {
+	fd = open(setgroups_path, O_RDWR);
+	if (fd == -1) {
 
-        /* We may be on a system that doesn't support
-           /proc/PID/setgroups. In that case, the file won't exist,
-           and the system won't impose the restrictions that Linux 3.19
-           added. That's fine: we don't need to do anything in order
-           to permit 'gid_map' to be updated.
+		/* We may be on a system that doesn't support
+		   /proc/PID/setgroups. In that case, the file won't exist,
+		   and the system won't impose the restrictions that Linux 3.19
+		   added. That's fine: we don't need to do anything in order
+		   to permit 'gid_map' to be updated.
 
-           However, if the error from open() was something other than
-           the ENOENT error that is expected for that case,  let the
-           user know. */
+		   However, if the error from open() was something other than
+		   the ENOENT error that is expected for that case,  let the
+		   user know. */
 
-        if (errno != ENOENT)
-            fprintf(stderr, "ERROR: open %s: %s\n", setgroups_path,
-                strerror(errno));
-        return;
-    }
+		if (errno != ENOENT)
+			fprintf(stderr, "ERROR: open %s: %s\n", setgroups_path,
+				strerror(errno));
+		return;
+	}
 
-    if (write(fd, str, strlen(str)) == -1)
-        fprintf(stderr, "ERROR: write %s: %s\n", setgroups_path,
-            strerror(errno));
+	if (write(fd, str, strlen(str)) == -1)
+		fprintf(stderr, "ERROR: write %s: %s\n", setgroups_path,
+			strerror(errno));
 
-    close(fd);
+	close(fd);
 }
 
 static int dummyFunc(void *arg)
 {
-    exit(0);
+	exit(0);
 }
 
 static int              /* Start function for cloned child */
 childFunc(void *arg)
 {
-    struct child_args *args = (struct child_args *) arg;
-    char ch;
+	struct child_args *args = (struct child_args *) arg;
+	char ch;
 
-    /* Wait until the parent has updated the UID and GID mappings.
-       See the comment in main(). We wait for end of file on a
-       pipe that will be closed by the parent process once it has
-       updated the mappings. */
+	/* Wait until the parent has updated the UID and GID mappings.
+	   See the comment in main(). We wait for end of file on a
+	   pipe that will be closed by the parent process once it has
+	   updated the mappings. */
 
-    close(args->pipe_fd[1]);    /* Close our descriptor for the write
+	close(args->pipe_fd[1]);    /* Close our descriptor for the write
                                    end of the pipe so that we see EOF
                                    when parent closes its descriptor */
-    if (read(args->pipe_fd[0], &ch, 1) != 0) {
-        fprintf(stderr,
-                "Failure in child: read from pipe returned != 0\n");
-        exit(EXIT_FAILURE);
-    }
+	if (read(args->pipe_fd[0], &ch, 1) != 0) {
+		fprintf(stderr,
+			"Failure in child: read from pipe returned != 0\n");
+		exit(EXIT_FAILURE);
+	}
 
-    /* Execute a shell command */
+	/* Execute a shell command */
 
-    printf("About to exec %s\n", args->argv[0]);
-    execvp(args->argv[0], args->argv);
-    errExit("execvp");
+	printf("About to exec %s\n", args->argv[0]);
+	execvp(args->argv[0], args->argv);
+	errExit("execvp");
 }
 
 #define STACK_SIZE (1024 * 1024)
@@ -198,122 +198,145 @@ static char child_stack[STACK_SIZE];    /* Space for child's stack */
 int
 main(int argc, char *argv[])
 {
-    int flags, opt, map_zero, test_clone = 0;
-    pid_t child_pid;
-    struct child_args args;
-    char *uid_map, *gid_map;
-    const int MAP_BUF_SIZE = 100;
-    char map_buf[MAP_BUF_SIZE];
-    char map_path[PATH_MAX];
-
-    /* Parse command-line options. The initial '+' character in
-       the final getopt() argument prevents GNU-style permutation
-       of command-line options. That's useful, since sometimes
-       the 'command' to be executed by this program itself
-       has command-line options. We don't want getopt() to treat
-       those as options to this program. */
-
-    flags = 0;
-    verbose = 0;
-    gid_map = NULL;
-    uid_map = NULL;
-    map_zero = 0;
-    while ((opt = getopt(argc, argv, "+imnpuUM:G:zvt")) != -1) {
-        switch (opt) {
-        case 'i': flags |= CLONE_NEWIPC;        break;
-        case 'm': flags |= CLONE_NEWNS;         break;
-        case 'n': flags |= CLONE_NEWNET;        break;
-        case 'p': flags |= CLONE_NEWPID;        break;
-        case 'u': flags |= CLONE_NEWUTS;        break;
-        case 'v': verbose = 1;                  break;
-        case 'z': map_zero = 1;                 break;
-        case 'M': uid_map = optarg;             break;
-        case 'G': gid_map = optarg;             break;
-        case 'U': flags |= CLONE_NEWUSER;       break;
-        case 't': test_clone = 1;               break;
-        default:  usage(argv[0]);
-        }
-    }
-
-    /* -M or -G without -U is nonsensical */
-
-    if (((uid_map != NULL || gid_map != NULL || map_zero) &&
-                !(flags & CLONE_NEWUSER)) ||
-            (map_zero && (uid_map != NULL || gid_map != NULL)))
-        usage(argv[0]);
-
-    args.argv = &argv[optind];
-
-    /* We use a pipe to synchronize the parent and child, in order to
-       ensure that the parent sets the UID and GID maps before the child
-       calls execve(). This ensures that the child maintains its
-       capabilities during the execve() in the common case where we
-       want to map the child's effective user ID to 0 in the new user
-       namespace. Without this synchronization, the child would lose
-       its capabilities if it performed an execve() with nonzero
-       user IDs (see the capabilities(7) man page for details of the
-       transformation of a process's capabilities during execve()). */
-
-    if (pipe(args.pipe_fd) == -1)
-        errExit("pipe");
-
-    /* Only test if clone flags combination is supported */
-    if (test_clone) {
-        if (clone(dummyFunc, child_stack + STACK_SIZE,
-            flags | SIGCHLD, &args) == -1) {
-            if (verbose)
-                printf("clone(0x%x): %s\n", flags, strerror(errno));
-            return errno;
-        }
-        return 0;
-    }
-
-    /* Create the child in new namespace(s) */
-    child_pid = clone(childFunc, child_stack + STACK_SIZE,
-                      flags | SIGCHLD, &args);
-    if (child_pid == -1)
-        errExit("clone");
-
-    /* Parent falls through to here */
-
-    if (verbose)
-        printf("%s: PID of child created by clone() is %ld\n",
-                argv[0], (long) child_pid);
-
-    /* Update the UID and GID maps in the child */
-
-    if (uid_map != NULL || map_zero) {
-        snprintf(map_path, PATH_MAX, "/proc/%ld/uid_map",
-                (long) child_pid);
-        if (map_zero) {
-            snprintf(map_buf, MAP_BUF_SIZE, "0 %ld 1", (long) getuid());
-            uid_map = map_buf;
-        }
-        update_map(uid_map, map_path);
-    }
-
-    if (gid_map != NULL || map_zero) {
-        proc_setgroups_write(child_pid, "deny");
-
-        snprintf(map_path, PATH_MAX, "/proc/%ld/gid_map",
-                (long) child_pid);
-        if (map_zero) {
-            snprintf(map_buf, MAP_BUF_SIZE, "0 %ld 1", (long) getgid());
-            gid_map = map_buf;
-        }
-        update_map(gid_map, map_path);
-    }
-
-    /* Close the write end of the pipe, to signal to the child that we
-       have updated the UID and GID maps */
-
-    close(args.pipe_fd[1]);
-
-    if (waitpid(child_pid, NULL, 0) == -1)      /* Wait for child */
-        errExit("waitpid");
-
-    if (verbose)
-        printf("%s: terminating\n", argv[0]);
-
-    exit(EXIT_SUCCESS);
+	int flags, opt, map_zero, test_clone = 0;
+	pid_t child_pid;
+	struct child_args args;
+	char *uid_map, *gid_map;
+	const int MAP_BUF_SIZE = 100;
+	char map_buf[MAP_BUF_SIZE];
+	char map_path[PATH_MAX];
+
+	/* Parse command-line options. The initial '+' character in
+	   the final getopt() argument prevents GNU-style permutation
+	   of command-line options. That's useful, since sometimes
+	   the 'command' to be executed by this program itself
+	   has command-line options. We don't want getopt() to treat
+	   those as options to this program. */
+
+	flags = 0;
+	verbose = 0;
+	gid_map = NULL;
+	uid_map = NULL;
+	map_zero = 0;
+	while ((opt = getopt(argc, argv, "+imnpuUM:G:zvt")) != -1) {
+		switch (opt) {
+		case 'i':
+			flags |= CLONE_NEWIPC;
+			break;
+		case 'm':
+			flags |= CLONE_NEWNS;
+			break;
+		case 'n':
+			flags |= CLONE_NEWNET;
+			break;
+		case 'p':
+			flags |= CLONE_NEWPID;
+			break;
+		case 'u':
+			flags |= CLONE_NEWUTS;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'z':
+			map_zero = 1;
+			break;
+		case 'M':
+			uid_map = optarg;
+			break;
+		case 'G':
+			gid_map = optarg;
+			break;
+		case 'U':
+			flags |= CLONE_NEWUSER;
+			break;
+		case 't':
+			test_clone = 1;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	/* -M or -G without -U is nonsensical */
+
+	if (((uid_map != NULL || gid_map != NULL || map_zero) &&
+	     !(flags & CLONE_NEWUSER)) ||
+	    (map_zero && (uid_map != NULL || gid_map != NULL)))
+		usage(argv[0]);
+
+	args.argv = &argv[optind];
+
+	/* We use a pipe to synchronize the parent and child, in order to
+	   ensure that the parent sets the UID and GID maps before the child
+	   calls execve(). This ensures that the child maintains its
+	   capabilities during the execve() in the common case where we
+	   want to map the child's effective user ID to 0 in the new user
+	   namespace. Without this synchronization, the child would lose
+	   its capabilities if it performed an execve() with nonzero
+	   user IDs (see the capabilities(7) man page for details of the
+	   transformation of a process's capabilities during execve()). */
+
+	if (pipe(args.pipe_fd) == -1)
+		errExit("pipe");
+
+	/* Only test if clone flags combination is supported */
+	if (test_clone) {
+		if (clone(dummyFunc, child_stack + STACK_SIZE,
+			  flags | SIGCHLD, &args) == -1) {
+			if (verbose)
+				printf("clone(0x%x): %s\n", flags, strerror(errno));
+			return errno;
+		}
+		return 0;
+	}
+
+	/* Create the child in new namespace(s) */
+	child_pid = clone(childFunc, child_stack + STACK_SIZE,
+			  flags | SIGCHLD, &args);
+	if (child_pid == -1)
+		errExit("clone");
+
+	/* Parent falls through to here */
+
+	if (verbose)
+		printf("%s: PID of child created by clone() is %ld\n",
+		       argv[0], (long) child_pid);
+
+	/* Update the UID and GID maps in the child */
+
+	if (uid_map != NULL || map_zero) {
+		snprintf(map_path, PATH_MAX, "/proc/%ld/uid_map",
+			 (long) child_pid);
+		if (map_zero) {
+			snprintf(map_buf, MAP_BUF_SIZE, "0 %ld 1", (long) getuid());
+			uid_map = map_buf;
+		}
+		update_map(uid_map, map_path);
+	}
+
+	if (gid_map != NULL || map_zero) {
+		proc_setgroups_write(child_pid, "deny");
+
+		snprintf(map_path, PATH_MAX, "/proc/%ld/gid_map",
+			 (long) child_pid);
+		if (map_zero) {
+			snprintf(map_buf, MAP_BUF_SIZE, "0 %ld 1", (long) getgid());
+			gid_map = map_buf;
+		}
+		update_map(gid_map, map_path);
+	}
+
+	/* Close the write end of the pipe, to signal to the child that we
+	   have updated the UID and GID maps */
+
+	close(args.pipe_fd[1]);
+
+	if (waitpid(child_pid, NULL, 0) == -1)      /* Wait for child */
+		errExit("waitpid");
+
+	if (verbose)
+		printf("%s: terminating\n", argv[0]);
+
+	exit(EXIT_SUCCESS);
 }
diff --git a/tests/mmap/mprotect_stack_thread.c b/tests/mmap/mprotect_stack_thread.c
index fed9969..fe16caf 100644
--- a/tests/mmap/mprotect_stack_thread.c
+++ b/tests/mmap/mprotect_stack_thread.c
@@ -46,7 +46,8 @@ int main(int argc, char **argv)
 	}
 
 	if (!strcmp(argv[1], "fail") && strverscmp(uts.release, "4.7") < 0) {
-		printf("%s: Kernels < 4.7 do not check execstack on thread stacks, skipping.\n", argv[0]);
+		printf("%s: Kernels < 4.7 do not check execstack on thread stacks, skipping.\n",
+		       argv[0]);
 		/* pass the test by failing as if it was denied */
 		exit(1);
 	}
diff --git a/tests/mmap/shmat.c b/tests/mmap/shmat.c
index 4467d64..56baaca 100644
--- a/tests/mmap/shmat.c
+++ b/tests/mmap/shmat.c
@@ -15,7 +15,7 @@ int main(void)
 		exit(1);
 	}
 	execmem = shmat(shmid, 0, SHM_EXEC);
-	if (execmem == ((void *) -1)) {
+	if (execmem == ((void *) - 1)) {
 		perror("shmat SHM_EXEC");
 		rc = 1;
 	} else {
diff --git a/tests/unix_socket/client.c b/tests/unix_socket/client.c
index e937bf9..093c319 100644
--- a/tests/unix_socket/client.c
+++ b/tests/unix_socket/client.c
@@ -63,14 +63,14 @@ main(int argc, char **argv)
 	sun.sun_family = AF_UNIX;
 	if (abstract) {
 		sun.sun_path[0] = 0;
-		strcpy(&sun.sun_path[1], argv[optind+1]);
+		strcpy(&sun.sun_path[1], argv[optind + 1]);
 		sunlen = offsetof(struct sockaddr_un, sun_path) +
-			strlen(&sun.sun_path[1]) + 1;
+			 strlen(&sun.sun_path[1]) + 1;
 	} else {
-		strcpy(sun.sun_path, argv[optind+1]);
+		strcpy(sun.sun_path, argv[optind + 1]);
 		unlink(sun.sun_path);
 		sunlen = offsetof(struct sockaddr_un, sun_path) +
-			strlen(sun.sun_path) + 1;
+			 strlen(sun.sun_path) + 1;
 	}
 
 	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
@@ -83,13 +83,13 @@ main(int argc, char **argv)
 	remotesun.sun_family = AF_UNIX;
 	if (abstract) {
 		remotesun.sun_path[0] = 0;
-		strcpy(&remotesun.sun_path[1], argv[optind+2]);
+		strcpy(&remotesun.sun_path[1], argv[optind + 2]);
 		remotesunlen = offsetof(struct sockaddr_un,
 					sun_path) + strlen(&remotesun.sun_path[1]) + 1;
 	} else {
-		strcpy(remotesun.sun_path, argv[optind+2]);
+		strcpy(remotesun.sun_path, argv[optind + 2]);
 		remotesunlen = offsetof(struct sockaddr_un, sun_path) +
-			strlen(remotesun.sun_path) + 1;
+			       strlen(remotesun.sun_path) + 1;
 	}
 
 	result = connect(sock, (struct sockaddr *) &remotesun, remotesunlen);
diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
index f882930..8f3e458 100644
--- a/tests/unix_socket/server.c
+++ b/tests/unix_socket/server.c
@@ -74,14 +74,14 @@ main(int argc, char **argv)
 	sun.sun_family = AF_UNIX;
 	if (abstract) {
 		sun.sun_path[0] = 0;
-		strcpy(&sun.sun_path[1], argv[optind+1]);
+		strcpy(&sun.sun_path[1], argv[optind + 1]);
 		sunlen = offsetof(struct sockaddr_un, sun_path) +
-			strlen(&sun.sun_path[1]) + 1;
+			 strlen(&sun.sun_path[1]) + 1;
 	} else {
-		strcpy(sun.sun_path, argv[optind+1]);
+		strcpy(sun.sun_path, argv[optind + 1]);
 		unlink(sun.sun_path);
 		sunlen = offsetof(struct sockaddr_un, sun_path) +
-			strlen(sun.sun_path) + 1;
+			 strlen(sun.sun_path) + 1;
 	}
 
 	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
