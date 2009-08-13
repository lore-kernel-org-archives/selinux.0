Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7DIDoje019875
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 14:13:50 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7DIDKIS023089
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 18:13:21 GMT
Message-ID: <4A8457D9.60908@redhat.com>
Date: Thu, 13 Aug 2009 14:13:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: error: too many arguments to function 'security_getenforce'
References: <dd18b0c30908122030l3e950054r1f3907a6dcde8db0@mail.gmail.com> <4A844EFD.7030000@redhat.com> <4A845612.1070907@gmail.com>
In-Reply-To: <4A845612.1070907@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------090404050103010402030008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090404050103010402030008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/13/2009 02:06 PM, Justin P. Mattock wrote:
> Daniel J Walsh wrote:
>>
>> Does
>>
>> selinux_mkload_policy(1);
>>
>> Work for you?
>>
>>    
> I clipped part of the message to keep
> things clean.
> 
> I'm going to be honest, I'm not that yet skilled
> in fixing something like this.
> 
> with selinux_mkload_policy(1)
> were would I put this?
> 
> Justin P. Mattock
> 
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

Actually the function you probably want 
selinux_init_load_policy

I attached the patch we used to use for sysvinit, before we moved to loading policy in the initrd.




--------------090404050103010402030008
Content-Type: text/plain;
 name="sysvinit-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sysvinit-selinux.patch"

--- sysvinit-2.85/src/init.c.selinux	2005-10-14 14:16:24.000000000 -0400
+++ sysvinit-2.85/src/init.c	2005-10-14 14:16:24.000000000 -0400
@@ -48,6 +48,8 @@
 #include <stdarg.h>
 #include <sys/syslog.h>
 #include <sys/time.h>
+#include <selinux/selinux.h>
+
 
 #ifdef __i386__
 #  if (__GLIBC__ >= 2)
@@ -2513,6 +2515,7 @@
 	char			*p;
 	int			f;
 	int			isinit;
+	int			enforce = 0;
 
 	/* Get my own name */
 	if ((p = strrchr(argv[0], '/')) != NULL)
@@ -2576,6 +2579,20 @@
 		maxproclen += strlen(argv[f]) + 1;
 	}
 
+  	if (getenv("SELINUX_INIT") == NULL) {
+	  putenv("SELINUX_INIT=YES");
+	  if (selinux_init_load_policy(&enforce) == 0 ) {
+	    execv(myname, argv);
+	  } else {
+	    if (enforce > 0) {
+	      /* SELinux in enforcing mode but load_policy failed */
+	      /* At this point, we probably can't open /dev/console, so log() won't work */
+		    printf("Unable to load SELinux Policy. Machine is in enforcing mode. Halting now.\n");
+	      exit(1);
+	    }
+	  }
+	}
+  
 	/* Start booting. */
 	argv0 = argv[0];
 	argv[1] = NULL;
--- sysvinit-2.85/src/Makefile.selinux	2005-10-14 14:16:24.000000000 -0400
+++ sysvinit-2.85/src/Makefile	2005-10-14 14:16:24.000000000 -0400
@@ -32,7 +32,7 @@
 all:		$(PROGS)
 
 init:		init.o init_utmp.o
-		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o -lsepol -lselinux
 
 halt:		halt.o ifdown.o hddown.o utmp.o reboot.h
 		$(CC) $(LDFLAGS) -o $@ halt.o ifdown.o hddown.o utmp.o
@@ -50,7 +50,7 @@
 		$(CC) $(LDFLAGS) -o $@ runlevel.o
 
 sulogin:	sulogin.o md5_broken.o md5_crypt_broken.o
-		$(CC) $(LDFLAGS) $(STATIC) -o $@ $^ $(LCRYPT)
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ $^ $(LCRYPT) -lselinux
 
 wall:		dowall.o wall.o
 		$(CC) $(LDFLAGS) -o $@ dowall.o wall.o
--- sysvinit-2.85/src/sulogin.c.selinux	2005-10-14 14:16:24.000000000 -0400
+++ sysvinit-2.85/src/sulogin.c	2005-10-14 14:18:42.000000000 -0400
@@ -28,7 +28,9 @@
 #  include <crypt.h>
 #endif
 #include "md5.h"
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>

 #define CHECK_DES	1
 #define CHECK_MD5	1
 
@@ -332,6 +335,19 @@
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTSTP, SIG_DFL);
 	signal(SIGQUIT, SIG_DFL);
+	if (is_selinux_enabled > 0) {
+	  security_context_t scon=NULL;
+	  char *seuser=NULL;
+	  char *level=NULL;
+	  if (getseuserbyname("root", &seuser, &level) == 0)
+		  if (get_default_context_with_level(seuser, level, 0, &scon) > 0) {
+			  if (setexeccon(scon) != 0) 
+				  fprintf(stderr, "setexeccon faile\n");
+			  freecon(scon);
+		  }
+		free(seuser);
+		free(level);
+	}
 	execl(sushell, shell, NULL);
 	perror(sushell);
 

--------------090404050103010402030008--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
