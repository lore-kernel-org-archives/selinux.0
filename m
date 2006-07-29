Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6TFHs6S028218
	for <selinux@tycho.nsa.gov>; Sat, 29 Jul 2006 11:17:54 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6TFHM9n012729
	for <selinux@tycho.nsa.gov>; Sat, 29 Jul 2006 15:17:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B854261B0D
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 01:17:21 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26749-06 for <selinux@tycho.nsa.gov>;
	Sun, 30 Jul 2006 01:17:21 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D949661B04
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 01:17:20 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 4812CA8668
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 01:17:24 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: SMP enabled restorecon
Date: Sun, 30 Jul 2006 01:17:22 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Dw3yEZEu/7OaEJi"
Message-Id: <200607300117.23329.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Dw3yEZEu/7OaEJi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Below are the results of running the FC5+updates version of restorecon vs my 
patched version with SMP support on a PentiumD-2.8GHz model 920.  The elapsed 
time is cut by 40%!  The user time reported appears to be a bug in the time 
command, when I observe the run via the "top" command I see two restorecon 
processes each taking about 26 seconds of CPU time before they complete.

The theoretical benefit of the SMP change should be a factor of two 
performance boost minus the overhead of the process that stats files to get 
the cache hot.  What I am seeing in my tests is quite a bit less than that, 
I'm not sure how much of this is due to my coding not being as efficient as 
it might and how much is due to inherent overheads of SMP operation.

orig:
time restorecon -R -v /usr/share
real    0m50.859s
user    0m44.743s
sys     0m5.704s

smp:
time ./restorecon -R -v /usr/share
real    0m31.275s
user    0m26.690s
sys     0m4.108s


With this patch a fairly default install of FC5 on a Pentium-D system should 
be able to perform an autorelabel operation in less than one minute.

Please test this out and let me know how it goes.  Also note that setfiles 
needs the same work done (but it's easier to test it out on restorecon 
first).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Dw3yEZEu/7OaEJi
Content-Type: text/x-diff;
  charset="us-ascii";
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

--Boundary-00=_Dw3yEZEu/7OaEJi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
