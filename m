Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6UEC60e022010
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 10:12:06 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6UEBuPx002721
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 14:11:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DEB3661B0E
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 00:12:00 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02795-01 for <selinux@tycho.nsa.gov>;
	Mon, 31 Jul 2006 00:11:59 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8308661B0D
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 00:11:59 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 23392A7F8E
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 00:12:03 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: SMP enabled restorecon
Date: Mon, 31 Jul 2006 00:12:01 +1000
References: <200607300117.23329.russell@coker.com.au> <200607302314.00725.russell@coker.com.au>
In-Reply-To: <200607302314.00725.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y4LzEVvE8Uu/09z"
Message-Id: <200607310012.02943.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_y4LzEVvE8Uu/09z
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 30 July 2006 23:13, Russell Coker <russell@coker.com.au> wrote:
> On Sunday 30 July 2006 01:17, Russell Coker <russell@coker.com.au> wrote:
> > Below are the results of running the FC5+updates version of restorecon =
vs
> > my patched version with SMP support on a PentiumD-2.8GHz model 920. =C2=
=A0The
> > elapsed time is cut by 40%! =C2=A0The user time reported appears to be =
a bug
> > in the time command, when I observe the run via the "top" command I see
> > two restorecon processes each taking about 26 seconds of CPU time before
> > they complete.
>
> I've attached a similar patch for setfiles, this patch adds a "-a" option
> to setfiles to skip the association check because it's really difficult to
> preserve that check while supporting SMP and giving good performance, and
> also because checking for associations isn't as useful when the results go
> to /dev/null anyway.

Sorry for replying to my own mail so much, I've been involved in discussion=
 on=20
IRC and other lists.

I've attached a new patch which calls wait() for each child process.  This=
=20
causes CPU time use to be correctly billed to parent processes, the results=
=20
are as follows:

Modified setfiles:
real    1m22.689s
user    1m13.181s
sys     0m12.641s

Orig setfiles:
real    1m23.697s
user    0m59.916s
sys     0m4.892s

Modified restorecon on /usr/share:
real    0m31.142s
user    0m52.671s
sys     0m7.728s

Orig restorecon:
real    0m51.429s
user    0m45.467s
sys     0m5.568s

It seems that in both cases the amount of CPU time used is significantly=20
increased, and that the variance between test runs of setfiles is great=20
enough that there can be little performance difference between my version a=
nd=20
the stock one.

I think that I need to find a more CPU efficient method of IPC for the file=
=20
names.  One possibility might be to use shared memory regions for the data.=
 =20
Another one might be to make the programs threaded.

A final possibility is that the current design of setfiles and restorecon m=
ay=20
be a dead-end as far as SMP is concerned.  Having one process to stat the=20
files and another to check the contexts when the cache is hot is efficient=
=20
for UP systems.  For SMP systems it might be better to have one process fin=
d=20
the files and then pass the names to worker processes that do the regex=20
stuff.  Currently processing a file involves two processes calling nftw()=20
(doing readdir() and stat()), the seeker writes a byte to a pipe and then t=
he=20
master will either pipe the file name to a child or process it directly=20
before reading the byte from the seek process.  As I have the worker=20
acknowledging each file the average number of pipe writes to process a file=
=20
on a 2P system is two.

If the parent process was to be the only process calling nftw() and it then=
=20
passed the file names via shared memory with specified minimum and maximum=
=20
sizes for the shared memory we could probably get an average of considerabl=
y=20
less than one IPC operation per file that is processes.

=2D-=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_y4LzEVvE8Uu/09z
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policycoreutils-1.30.10.orig/restorecon/restorecon.c policycoreutils-1.30.10/restorecon/restorecon.c
--- policycoreutils-1.30.10.orig/restorecon/restorecon.c	2006-05-23 20:20:02.000000000 +1000
+++ policycoreutils-1.30.10/restorecon/restorecon.c	2006-07-30 23:26:21.000000000 +1000
@@ -34,6 +34,7 @@
 #include <selinux/selinux.h>
 #include <getopt.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -50,6 +51,15 @@
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
 
+#define WORKER_SUCCESS 'g'
+#define WORKER_FAILURE 'b'
+int *worker_send_fds = NULL;
+int *worker_recv_fds = NULL;
+int num_workers = 0;
+int max_worker_handle = 0;
+int *worker_use_count = NULL;
+#define MAX(XA, XB) ((XA) > (XB)) ? (XA) : (XB)
+
 #define MAX_EXCLUDES 100
 static int excludeCtr=0;
 struct edir {
@@ -241,32 +251,244 @@
   return 0;
 }
 
+void get_worker_data(int finishing)
+{
+  int i, count;
+  fd_set read_set;
+  struct timeval tv;
+  tv.tv_sec = finishing ? 1 : 0;
+  tv.tv_usec = 0;
+
+  FD_ZERO(&read_set);
+  for(i = 0; i < num_workers; i++)
+    FD_SET(worker_recv_fds[i], &read_set);
+
+  count = select(max_worker_handle, &read_set, NULL, NULL, &tv);
+  if(count == 0)
+    return;
+  if(count == -1)
+  {
+    perror("Worker select error");
+    exit(1);
+  }
+  for(i = 0; i < num_workers; i++)
+  {
+    if(FD_ISSET(worker_recv_fds[i], &read_set))
+    {
+      char c;
+      int rc = read(worker_recv_fds[i], &c, 1);
+      if(rc != 1)
+      {
+        fprintf(stderr, "Error reading result from worker %d, aborting.\n", i);
+        exit(1);
+      }
+      if(c != WORKER_SUCCESS)
+        errors++;
+      worker_use_count[i]--;
+      count--;
+    }
+  }
+  if(count != 0)
+  {
+    fprintf(stderr, "Count should be 0!\n");
+    exit(1);
+  }
+}
+
 static int apply_spec(const char *file,
 		      const struct stat *sb_unused __attribute__((unused)),
 		      int flag,
 		      struct FTW *s_unused __attribute__((unused)))
 {
-	char buf[STAT_BLOCK_SIZE];
-	if(pipe_fds[0] != -1 && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
-	{
-		fprintf(stderr, "Read error on pipe.\n");
-		pipe_fds[0] = -1;
-	}
-	if (flag == FTW_DNR) {
-		fprintf(stderr, "%s:  unable to read directory %s\n",
-			progname, file);
-		return 0;
-	}
-	errors=errors+restore(file);
-	return 0;
+  char buf[STAT_BLOCK_SIZE];
+
+  if(pipe_fds[0] != -1 && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
+  {
+    fprintf(stderr, "Read error on pipe.\n");
+    pipe_fds[0] = -1;
+  }
+  if (flag == FTW_DNR) {
+    fprintf(stderr, "%s:  unable to read directory %s\n",
+    progname, file);
+    return 0;
+  }
+  if(num_workers)
+  {
+    int i, rc;
+    get_worker_data(0);
+    for(i = 0; i < num_workers; i++)
+    {
+      /* Have two entries in the queue for each worker so that if the master
+         starts doing some regex work the workers don't starve */
+      if(worker_use_count[i] < 2)
+      {
+        int offset = 0, len = strlen(file) + 1;
+
+        worker_use_count[i]++;
+        /* Could hurt performance if FILE_MAX*2 > the max pipe buffer */
+        while(1)
+        {
+          rc = write(worker_send_fds[i], &file[offset], len - offset);
+          if(rc == -1)
+          {
+            fprintf(stderr, "Can't write to worker %d\n", i);
+            exit(1);
+          }
+          offset += rc;
+          if(offset == len)
+            return 0;
+        }
+      }
+    }
+  }
+  errors=errors+restore(file);
+  return 0;
 }
+
+int num_cpus()
+{
+  FILE *fp = fopen("/proc/cpuinfo", "r");
+  char buf[1024];
+  int num = 0;
+
+  if(!fp)
+    return 1;
+  while(fgets(buf, sizeof(buf), fp))
+  {
+    if(!strncmp(buf, "processor", 9))
+      num++;
+  }
+  fclose(fp);
+  if(num < 1)
+    return 1;
+  return num;
+}
+
+void worker_restore(int id, const char * const file, int fd_out)
+{
+  char res = WORKER_SUCCESS;
+  if(restore(file))
+  {
+    res = WORKER_FAILURE;
+  }
+  if(write(fd_out, &res, 1) != 1)
+  {
+    fprintf(stderr, "Worker %d can't write to result pipe, aborting.\n", id);
+    exit(1);
+  }
+}
+
+void worker(int id, int fd_in, int fd_out)
+{
+  char buf[PATH_MAX+1];
+  int len = 0;
+
+  while(1)
+  {
+    while(len == 0 || buf[len - 1] != '\0')
+    {
+      int string_len;
+      int rc = read(fd_in, buf + len, PATH_MAX - len);
+      if(rc == -1)
+      {
+        fprintf(stderr, "Worker %d exiting on read error.\n", id);
+        exit(1);
+      }
+      if(rc == 0)
+        exit(0); /* parent has exited */
+      len += rc;
+      buf[len] = '\0';
+      string_len = strlen(buf);
+      while(string_len != len)
+      {
+        worker_restore(id, buf, fd_out);
+        len = len - string_len - 1;
+        memmove(buf, buf + string_len + 1, len + 1);
+        string_len = strlen(buf);
+      }
+      if(len >= PATH_MAX)
+      {
+        fprintf(stderr, "Worker %d received excess data from parent.\n", id);
+        exit(1);
+      }
+    }
+    worker_restore(id, buf, fd_out);
+    len = 0;
+  }
+  if(len != 0)
+  {
+    fprintf(stderr, "Worker %d can't read from pipe, aborting.\n", id);
+    exit(1);
+  }
+  exit(0);
+}
+
+void start_workers()
+{
+  int send_fds[2], recv_fds[2], i;
+
+  num_workers = num_cpus() - 1;
+  if(!num_workers)
+    return;
+  worker_send_fds = malloc(sizeof(int) * num_workers);
+  worker_recv_fds = malloc(sizeof(int) * num_workers);
+  worker_use_count = malloc(sizeof(int) * num_workers);
+  if(!worker_send_fds || !worker_recv_fds || !worker_use_count)
+  {
+    fprintf(stderr, "Malloc failure.\n");
+    exit(1);
+  }
+
+  matchpathcon_init(NULL);
+
+  for(i = 0; i < num_workers; i++)
+  {
+    int rc;
+
+    if(pipe(send_fds) || pipe(recv_fds))
+    {
+      fprintf(stderr, "Can't create pipe.\n");
+      exit(1);
+    }
+    worker_send_fds[i] = send_fds[1];
+    worker_recv_fds[i] = recv_fds[0];
+    worker_use_count[i] = 0;
+    max_worker_handle = MAX(max_worker_handle, MAX(worker_send_fds[i], worker_recv_fds[i]));
+    rc = fork();
+    if(rc == -1)
+    {
+      fprintf(stderr, "fork error\n");
+      exit(1);
+    }
+    if(!rc)
+    {
+      int j;
+      for(j = i - 1; j >= 0; j--)
+      {
+        close(worker_send_fds[j]);
+        close(worker_recv_fds[j]);
+      }
+      close(send_fds[1]);
+      close(recv_fds[0]);
+      worker(i, send_fds[0], recv_fds[1]);
+      exit(2); /* should never reach this code */
+    }
+    close(send_fds[0]);
+    close(recv_fds[1]);
+  }
+  max_worker_handle++;
+}
+
 void process(char *buf) {
       int rc;
+
       if (recurse) {
 	if(pipe(pipe_fds) == -1)
-	  rc = -1;
-	else
-	  rc = fork();
+        {
+          fprintf(stderr, "Can't create pipe.\n");
+          exit(1);
+        }
+	rc = fork();
 	if(rc == 0)
 	{
 	  close(pipe_fds[0]);
@@ -276,10 +498,25 @@
 	if(rc > 0)
 	  close(pipe_fds[1]);
 	if(rc == -1 || rc > 0) {
+          start_workers();
 	  if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
 	    fprintf(stderr, "%s:  error while labeling files under %s\n",
 		  progname, buf);
 	    errors++;
+          }
+          if(rc > 0)
+            wait(&rc);
+          if(num_workers)
+          {
+            int i;
+            for(i = 0; i < num_workers; i++)
+            {
+              while(worker_use_count[i])
+                get_worker_data(1);
+              close(worker_send_fds[i]);
+              close(worker_recv_fds[i]);
+              wait(&rc);
+            }
 	  }
 	}
       }
diff -ru policycoreutils-1.30.10.orig/setfiles/setfiles.c policycoreutils-1.30.10/setfiles/setfiles.c
--- policycoreutils-1.30.10.orig/setfiles/setfiles.c	2006-05-23 20:20:03.000000000 +1000
+++ policycoreutils-1.30.10/setfiles/setfiles.c	2006-07-30 23:29:07.000000000 +1000
@@ -75,6 +75,7 @@
 #include <selinux/selinux.h>
 #include <syslog.h> 
 #include <libgen.h>
+#include <sys/wait.h>
 
 static int add_assoc = 1;
 static FILE *outfile=NULL;
@@ -82,6 +83,15 @@
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
 
+#define WORKER_SUCCESS 'g'
+#define WORKER_FAILURE 'b'
+int *worker_send_fds = NULL;
+int *worker_recv_fds = NULL;
+int num_workers = 0;
+int max_worker_handle = 0;
+int *worker_use_count = NULL;
+#define MAX(XA, XB) ((XA) > (XB)) ? (XA) : (XB)
+
 #define MAX_EXCLUDES 100
 static int excludeCtr=0;
 struct edir {
@@ -232,27 +242,57 @@
 	return  (strcmp(rest_a, rest_b) == 0);
 }
 
-/*
- * Apply the last matching specification to a file.
- * This function is called by nftw on each file during
- * the directory traversal.
- */
-static int apply_spec(const char *file,
-		      const struct stat *sb_unused __attribute__((unused)),
-		      int flag,
-		      struct FTW *s_unused __attribute__((unused)))
+void get_worker_data(int finishing)
+{
+  int i, count;
+  fd_set read_set;
+  struct timeval tv;
+  tv.tv_sec = finishing ? 1 : 0;
+  tv.tv_usec = 0;
+
+  FD_ZERO(&read_set);
+  for(i = 0; i < num_workers; i++)
+    FD_SET(worker_recv_fds[i], &read_set);
+
+  count = select(max_worker_handle, &read_set, NULL, NULL, &tv);
+  if(count == 0)
+    return;
+  if(count == -1)
+  {
+    perror("Worker select error");
+    exit(1);
+  }
+  for(i = 0; i < num_workers; i++)
+  {
+    if(FD_ISSET(worker_recv_fds[i], &read_set))
+    {
+      char c;
+      int rc = read(worker_recv_fds[i], &c, 1);
+      if(rc != 1)
+      {
+        fprintf(stderr, "Error reading result from worker %d, aborting.\n", i);
+        exit(1);
+      }
+/*      if(c != WORKER_SUCCESS)
+        errors++;*/
+      worker_use_count[i]--;
+      count--;
+    }
+  }
+  if(count != 0)
+  {
+    fprintf(stderr, "Count should be 0!\n");
+    exit(1);
+  }
+}
+
+static int set_context(const char *file)
 {
 	const char *my_file;
 	struct stat my_sb;
 	int i, j, ret;
 	char *context, *newcon; 
 	int user_only_changed=0;
-	char buf[STAT_BLOCK_SIZE];
-	if(pipe_fds[0] != -1 && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
-	{
-		fprintf(stderr, "Read error on pipe.\n");
-		pipe_fds[0] = -1;
-	}
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -260,12 +300,6 @@
 	else
 		my_file = file;
 
-	if (flag == FTW_DNR) {
-		fprintf(stderr, "%s:  unable to read directory %s\n",
-			progname, my_file);
-		return 0;
-	}
-
 	i = match(my_file, &my_sb, &newcon);
 	if (i < 0)
 		/* No matching specification. */
@@ -382,6 +416,198 @@
 	return -1;
 }
 
+/*
+ * Apply the last matching specification to a file.
+ * This function is called by nftw on each file during
+ * the directory traversal.
+ */
+static int apply_spec(const char *file,
+		      const struct stat *sb_unused __attribute__((unused)),
+		      int flag,
+		      struct FTW *s_unused __attribute__((unused)))
+{
+  char buf[STAT_BLOCK_SIZE];
+  if(pipe_fds[0] != -1 && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
+  {
+    fprintf(stderr, "Read error on pipe.\n");
+    pipe_fds[0] = -1;
+  }
+
+  if (flag == FTW_DNR)
+  {
+    fprintf(stderr, "%s:  unable to read directory %s\n",
+    progname, file);
+    return 0;
+  }
+
+  if(num_workers)
+  {
+    int i, rc;
+    get_worker_data(0);
+    for(i = 0; i < num_workers; i++)
+    {
+      /* Have two entries in the queue for each worker so that if the master
+         starts doing some regex work the workers don't starve */
+      if(worker_use_count[i] < 2)
+      {
+        int offset = 0, len = strlen(file) + 1;
+
+        worker_use_count[i]++;
+        /* Could hurt performance if FILE_MAX*2 > the max pipe buffer */
+        while(1)
+        {
+          rc = write(worker_send_fds[i], &file[offset], len - offset);
+          if(rc == -1)
+          {
+            fprintf(stderr, "Can't write to worker %d\n", i);
+            exit(1);
+          }
+          offset += rc;
+          if(offset == len)
+            return 0;
+        }
+      }
+    }
+  }
+  return set_context(file);
+}
+
+int num_cpus()
+{
+  FILE *fp = fopen("/proc/cpuinfo", "r");
+  char buf[1024];
+  int num = 0;
+
+  if(!fp)
+    return 1;
+  while(fgets(buf, sizeof(buf), fp))
+  {
+    if(!strncmp(buf, "processor", 9))
+      num++;
+  }
+  fclose(fp);
+  if(num < 1)
+    return 1;
+  return num;
+}
+
+void worker_restore(int id, const char * const file, int fd_out)
+{
+  char res = WORKER_SUCCESS;
+  if(set_context(file))
+  {
+    res = WORKER_FAILURE;
+  }
+  if(write(fd_out, &res, 1) != 1)
+  {
+    fprintf(stderr, "Worker %d can't write to result pipe, aborting.\n", id);
+    exit(1);
+  }
+}
+
+void worker(int id, int fd_in, int fd_out)
+{
+  char buf[PATH_MAX+1];
+  int len = 0;
+
+  while(1)
+  {
+    while(len == 0 || buf[len - 1] != '\0')
+    {
+      int string_len;
+      int rc = read(fd_in, buf + len, PATH_MAX - len);
+      if(rc == -1)
+      {
+        fprintf(stderr, "Worker %d exiting on read error.\n", id);
+        exit(1);
+      }
+      if(rc == 0)
+        exit(0); /* parent has exited */
+      len += rc;
+      buf[len] = '\0';
+      string_len = strlen(buf);
+      while(string_len != len)
+      {
+        worker_restore(id, buf, fd_out);
+        len = len - string_len - 1;
+        memmove(buf, buf + string_len + 1, len + 1);
+        string_len = strlen(buf);
+      }
+      if(len >= PATH_MAX)
+      {
+        fprintf(stderr, "Worker %d received excess data from parent.\n", id);
+        exit(1);
+      }
+    }
+    worker_restore(id, buf, fd_out);
+    len = 0;
+  }
+  if(len != 0)
+  {
+    fprintf(stderr, "Worker %d can't read from pipe, aborting.\n", id);
+    exit(1);
+  }
+  exit(0);
+}
+
+void start_workers()
+{
+  int send_fds[2], recv_fds[2], i;
+
+  if(add_assoc)
+    return;
+  num_workers = num_cpus() - 1;
+  if(!num_workers)
+    return;
+  worker_send_fds = malloc(sizeof(int) * num_workers);
+  worker_recv_fds = malloc(sizeof(int) * num_workers);
+  worker_use_count = malloc(sizeof(int) * num_workers);
+  if(!worker_send_fds || !worker_recv_fds || !worker_use_count)
+  {
+    fprintf(stderr, "Malloc failure.\n");
+    exit(1);
+  }
+
+  matchpathcon_init(NULL);
+
+  for(i = 0; i < num_workers; i++)
+  {
+    int rc;
+
+    if(pipe(send_fds) || pipe(recv_fds))
+    {
+      fprintf(stderr, "Can't create pipe.\n");
+      exit(1);
+    }
+    worker_send_fds[i] = send_fds[1];
+    worker_recv_fds[i] = recv_fds[0];
+    worker_use_count[i] = 0;
+    max_worker_handle = MAX(max_worker_handle, MAX(worker_send_fds[i], worker_recv_fds[i]));
+    rc = fork();
+    if(rc == -1)
+    {
+      fprintf(stderr, "fork error\n");
+      exit(1);
+    }
+    if(!rc)
+    {
+      int j;
+      for(j = i - 1; j >= 0; j--)
+      {
+        close(worker_send_fds[j]);
+        close(worker_recv_fds[j]);
+      }
+      close(send_fds[1]);
+      close(recv_fds[0]);
+      worker(i, send_fds[0], recv_fds[1]);
+      exit(2); /* should never reach this code */
+    }
+    close(send_fds[0]);
+    close(recv_fds[1]);
+  }
+  max_worker_handle++;
+}
+
 void set_rootpath(const char *arg)
 {
 	int len;
@@ -454,7 +680,7 @@
 	set_matchpathcon_flags(MATCHPATHCON_VALIDATE);
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "aFc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -529,6 +755,7 @@
 			break;
 		case 's':
 			use_stdin = 1;
+		case 'a':
 			add_assoc = 0;
 			break;
 		case 'v':
@@ -641,6 +868,7 @@
 			close(pipe_fds[1]);
 		if(rc == -1 || rc > 0) {
 
+			start_workers();
 		/* Walk the file tree, calling apply_spec on each file. */
 			if (nftw
 			    (argv[optind], apply_spec, 1024,
@@ -650,6 +878,20 @@
 				argv[0], argv[optind]);
 				exit(1);
 			}
+			if(rc > 0)
+				wait(&rc);
+			if(num_workers)
+			{
+				int i;
+				for(i = 0; i < num_workers; i++)
+				{
+					while(worker_use_count[i])
+						get_worker_data(1);
+					close(worker_send_fds[i]);
+					close(worker_recv_fds[i]);
+					wait(&rc);
+				}
+			}
 		}
 
 		/*

--Boundary-00=_y4LzEVvE8Uu/09z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
