Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6UDE8gR020884
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 09:14:08 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6UDE09f016810
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 13:14:01 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8EB6261B0F
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 23:13:58 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 00960-02 for <selinux@tycho.nsa.gov>;
	Sun, 30 Jul 2006 23:13:57 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2E9F361B0D
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 23:13:57 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id DD8C2A7F8D
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 23:14:00 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: SMP enabled restorecon
Date: Sun, 30 Jul 2006 23:13:59 +1000
References: <200607300117.23329.russell@coker.com.au>
In-Reply-To: <200607300117.23329.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YCLzEho+v9jD2DG"
Message-Id: <200607302314.00725.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_YCLzEho+v9jD2DG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 30 July 2006 01:17, Russell Coker <russell@coker.com.au> wrote:
> Below are the results of running the FC5+updates version of restorecon vs
> my patched version with SMP support on a PentiumD-2.8GHz model 920. =C2=
=A0The
> elapsed time is cut by 40%! =C2=A0The user time reported appears to be a =
bug in
> the time command, when I observe the run via the "top" command I see two
> restorecon processes each taking about 26 seconds of CPU time before they
> complete.

I've attached a similar patch for setfiles, this patch adds a "-a" option t=
o=20
setfiles to skip the association check because it's really difficult to=20
preserve that check while supporting SMP and giving good performance, and=20
also because checking for associations isn't as useful when the results go=
=20
to /dev/null anyway.

On my Pentium-D system with a 160G S-ATA disk the regular setfiles causes a=
n=20
autorelabel to take the following amount of time:
real    1m23.697s
user    0m59.916s
sys     0m4.892s

While my modified version takes the following:
real    1m19.236s
user    0m37.498s
sys     0m4.352s

Surprisingly it only saves 4.4s (5.5% performance increase).  This isn't=20
great, but we have to keep in mind the fact that my test machine has a very=
=20
fast CPU and only a single disk so having IO being the bottleneck is expect=
ed=20
(in fact it's desired but I didn't expect to hit it so soon).

I have a suspicion that if I was to perform the same test on a machine with=
 a=20
root filesystem on an EMC SAN (I currently run a couple of dozen such=20
machines at the moment) then I would find that IO isn't the bottleneck and=
=20
that my modified version of setfiles would probably double the performance.=
 =20
I don't plan to perform such tests as the EMC connected machines in questio=
n=20
only run RHEL3 and RHEL4 and I am not going to back-port the code (no-one=20
would be prepared to run such modified code on RHEL4 in a production machin=
e=20
so it's a bit pointless).

I also suspect that if I installed the four S-ATA disks and three ATA-133=20
disks that my Pentium-D machine supports and ran Linux software RAID-5 then=
=20
again I could get significantly better than a 5.5% performance boost from t=
he=20
SMP aware version of setfiles.

I hope that no-one will reject my patch because I don't have suitable test=
=20
hardware to demonstrate it's benefits.  It seems quite obvious to me that=20
there is a need to get the best possible performance from SMP machines that=
=20
have CPUs that are slower than a new Pentium-D and which also have better I=
O=20
performance than a single S-ATA disk - I expect that most SMP machines that=
=20
are in production satisfy at least one of these criteria and a large portio=
n=20
of them satisfy both.

=2D-=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_YCLzEho+v9jD2DG
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

Only in policycoreutils-1.30.10/restorecon: restorecon
diff -ru policycoreutils-1.30.10.orig/restorecon/restorecon.c policycoreutils-1.30.10/restorecon/restorecon.c
--- policycoreutils-1.30.10.orig/restorecon/restorecon.c	2006-05-23 20:20:02.000000000 +1000
+++ policycoreutils-1.30.10/restorecon/restorecon.c	2006-07-30 01:05:36.000000000 +1000
@@ -50,6 +50,15 @@
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
@@ -241,32 +250,244 @@
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
@@ -276,10 +497,22 @@
 	if(rc > 0)
 	  close(pipe_fds[1]);
 	if(rc == -1 || rc > 0) {
+          start_workers();
 	  if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
 	    fprintf(stderr, "%s:  error while labeling files under %s\n",
 		  progname, buf);
 	    errors++;
+            if(num_workers)
+            {
+              int i;
+              for(i = 0; i < num_workers; i++)
+              {
+                while(worker_use_count[i])
+                  get_worker_data(1);
+                close(worker_send_fds[i]);
+                close(worker_recv_fds[i]);
+              }
+            }
 	  }
 	}
       }
Only in policycoreutils-1.30.10/restorecon: restorecon.o
Only in policycoreutils-1.30.10/setfiles: setfiles
diff -ru policycoreutils-1.30.10.orig/setfiles/setfiles.c policycoreutils-1.30.10/setfiles/setfiles.c
--- policycoreutils-1.30.10.orig/setfiles/setfiles.c	2006-05-23 20:20:03.000000000 +1000
+++ policycoreutils-1.30.10/setfiles/setfiles.c	2006-07-30 22:19:35.000000000 +1000
@@ -82,6 +82,15 @@
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
@@ -232,27 +241,57 @@
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
@@ -260,12 +299,6 @@
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
@@ -382,6 +415,198 @@
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
@@ -454,7 +679,7 @@
 	set_matchpathcon_flags(MATCHPATHCON_VALIDATE);
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "aFc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -529,6 +754,7 @@
 			break;
 		case 's':
 			use_stdin = 1;
+		case 'a':
 			add_assoc = 0;
 			break;
 		case 'v':
@@ -641,6 +867,7 @@
 			close(pipe_fds[1]);
 		if(rc == -1 || rc > 0) {
 
+			start_workers();
 		/* Walk the file tree, calling apply_spec on each file. */
 			if (nftw
 			    (argv[optind], apply_spec, 1024,
@@ -650,6 +877,17 @@
 				argv[0], argv[optind]);
 				exit(1);
 			}
+			if(num_workers)
+			{
+				int i;
+				for(i = 0; i < num_workers; i++)
+				{
+					while(worker_use_count[i])
+						get_worker_data(1);
+					close(worker_send_fds[i]);
+					close(worker_recv_fds[i]);
+				}
+			}
 		}
 
 		/*
Only in policycoreutils-1.30.10/setfiles: setfiles.o

--Boundary-00=_YCLzEho+v9jD2DG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
