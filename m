Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LI7TWt028654
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:07:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LI7RIG010049
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:07:28 GMT
Message-ID: <3F9575DE.3010802@redhat.com>
Date: Tue, 21 Oct 2003 14:07:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
References: <200310200148.15852.russell@coker.com.au>	 <200310211052.28494.russell@coker.com.au>	 <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>	 <200310220043.09925.russell@coker.com.au> <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040604030003080703010507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040604030003080703010507
Content-Type: multipart/alternative;
 boundary="------------040906040606020204060805"


--------------040906040606020204060805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2003-10-21 at 10:43, Russell Coker wrote: 
>  
>
>>The results I have so far indicate that this approach has significant 
>>problems.
>>
>>Diverting /sbin/init with a shell script works better than this.
>>    
>>
>
>Ok, thanks for looking into it.  So what exactly is the problem with
>diverting /sbin/init again?  
>  
>

Here is my patch to init to load initial policy.



--------------040906040606020204060805
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Tue, 2003-10-21 at 10:43, Russell Coker wrote: 
  </pre>
  <blockquote type="cite">
    <pre wrap="">The results I have so far indicate that this approach has significant 
problems.

Diverting /sbin/init with a shell script works better than this.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ok, thanks for looking into it.  So what exactly is the problem with
diverting /sbin/init again?  
  </pre>
</blockquote>
<br>
Here is my patch to init to load initial policy.<br>
<br>
<br>
</body>
</html>

--------------040906040606020204060805--

--------------040604030003080703010507
Content-Type: text/plain;
 name="sysvinit-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysvinit-selinux.patch"

--- sysvinit-2.85/src/init.c.selinux	2003-10-21 11:01:52.000000000 -0400
+++ sysvinit-2.85/src/init.c	2003-10-21 11:18:20.000000000 -0400
@@ -78,6 +78,87 @@
 			sigemptyset(&sa.sa_mask); \
 			sigaction(sig, &sa, NULL); \
 		} while(0)
+#ifdef WITH_SELINUX
+#include <sys/mman.h>
+#include <selinux/selinux.h>
+#include <sys/mount.h>
+
+#define POLICY_FILE "/etc/security/selinux/policy"
+#define DEFAULT_POLICY_VERSION 15
+#define SELINUXMNT "/selinux"
+#define POLICY_VERSION_FILE "/selinux/policyvers"
+#define SELINUX_ENFORCE_FILE "/selinux/enforce"
+static int load_policy(int *enforce) 
+{
+  int fd,ret=-1;
+  struct stat sb;
+  void *map;
+  char policy_file[PATH_MAX];
+  int policy_version=DEFAULT_POLICY_VERSION;
+  FILE *fp;
+
+  log(L_VB, "Loading security policy\n");
+  if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0) {
+    if (errno == ENODEV) {
+      log(L_VB, "SELinux not supported by kernel: %s\n",SELINUXMNT,strerror(errno));
+    } 
+    else {
+      log(L_VB, "Failed to mount %s: %s\n",SELINUXMNT,strerror(errno));
+      exit(1);
+    }
+    return ret; /* Never gets here */
+  }
+
+  /* Check policy version file.  For now this will default to 15.  When all 
+     kernel supports POLICY_VERSION_FILE, this should become an error */
+  fp = fopen(POLICY_VERSION_FILE, "r");
+  if(fp)
+    {
+      fscanf(fp,"%d",&policy_version);
+      fclose(fp); 
+    }
+  
+  fp = fopen(SELINUX_ENFORCE_FILE, "r");
+  if(fp)
+    {
+      fscanf(fp,"%d",enforce);
+      fclose(fp); 
+    }
+  else {
+    log(L_VB,  "Can't open '%s':  %s\n",
+	    SELINUX_ENFORCE_FILE, strerror(errno));
+    goto UMOUNT;
+  }
+  snprintf(policy_file,sizeof(policy_file),"%s.%d",POLICY_FILE,policy_version);
+  fd = open(policy_file, O_RDONLY);
+  if (fd < 0) {
+    log(L_VB,  "Can't open '%s':  %s\n",
+	    policy_file, strerror(errno));
+    goto UMOUNT;
+  }
+  
+  if (fstat(fd, &sb) < 0) {
+    log(L_VB, "Can't stat '%s':  %s\n",
+	    policy_file, strerror(errno));
+    goto UMOUNT;
+  }
+  
+  map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+  if (map == MAP_FAILED) {
+    log(L_VB,  "Can't map '%s':  %s\n",
+	    policy_file, strerror(errno));
+    goto UMOUNT;
+  }
+  ret=security_load_policy(map, sb.st_size);
+  if (ret < 0) {
+    log(L_VB, "security_load_policy failed\n");
+  }
+
+ UMOUNT:
+  umount(SELINUXMNT); 
+  return(ret);
+}
+#endif
 
 /* Version information */
 char *Version = "@(#) init " VERSION "  " DATE "  miquels@cistron.nl";
@@ -2576,6 +2657,20 @@
 		maxproclen += strlen(argv[f]) + 1;
 	}
 
+#ifdef WITH_SELINUX
+  	if (getenv("SELINUX_INIT") == NULL) {
+	  putenv("SELINUX_INIT=YES");
+	  int enforce=0;
+	  if (load_policy(&enforce) == 0 ) {
+	    execv(myname, argv);
+	  } else {
+	    if (enforce) 
+	      /* SELinux in enforcing mode but load_policy failed */
+	      exit(1);
+	  }
+	}
+#endif
+  
 	/* Start booting. */
 	argv0 = argv[0];
 	argv[1] = NULL;
--- sysvinit-2.85/src/Makefile.selinux	2003-10-21 11:01:52.000000000 -0400
+++ sysvinit-2.85/src/Makefile	2003-10-21 11:01:52.000000000 -0400
@@ -32,7 +32,7 @@
 all:		$(PROGS)
 
 init:		init.o init_utmp.o
-		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o -lselinux
 
 halt:		halt.o ifdown.o hddown.o utmp.o reboot.h
 		$(CC) $(LDFLAGS) -o $@ halt.o ifdown.o hddown.o utmp.o
@@ -62,7 +62,7 @@
 		$(CC) $(LDFLAGS) -o $@ bootlogd.o
 
 init.o:		init.c init.h set.h reboot.h
-		$(CC) -c $(CFLAGS) init.c
+		$(CC) -c $(CFLAGS) -DWITH_SELINUX init.c
 
 utmp.o:		utmp.c init.h
 		$(CC) -c $(CFLAGS) utmp.c

--------------040604030003080703010507--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
