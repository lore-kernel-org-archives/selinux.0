Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0L6CGIi010452
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 01:12:16 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0L6CG5L011968
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 06:12:17 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0L637gW013704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 00:03:07 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: run_init and interactive scripts
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	<1106247919.26753.207.camel@moss-spartans.epoch.ncsc.mil>
Date: Fri, 21 Jan 2005 00:02:37 -0600
In-Reply-To: <1106247919.26753.207.camel@moss-spartans.epoch.ncsc.mil>
	(Stephen Smalley's message of "Thu, 20 Jan 2005 14:05:19 -0500")
Message-ID: <877jm7e2v6.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

On Thu, 20 Jan 2005 14:05:19 -0500, Stephen Smalley <sds@tycho.nsa.gov> said: 

> Need to flush stderr in open_init_pty?

	Done. I have now inserted flush statements along all the exit
 points in the function. Tested with /etc/init.d/mimedefand,
 /etc/init.d/bind9, emacs, and aptitude.

>> ______________________________________________________________________
> -- Stephen Smalley <sds@epoch.ncsc.mil> National Security Agency
On Thu, 20 Jan 2005 15:05:02 -0500, Stephen Smalley <sds@tycho.nsa.gov> said: 

> On Thu, 2005-01-20 at 02:38, Manoj Srivastava wrote:
>> Here is the man page for the other script without a man page in
>> policycoreutils.

> Thanks.  Two suggested changes:
> - Update both the script comment and the man page to use 500 rather
>   than 100 for the default STARTING_UID, as that is what the code
>   uses presently (in the absence of a UID_MIN definition in
>   /etc/login.defs),

	Done.

> - Start with an abstract description of the purpose, e.g. this
>   script is to generate file context configuration entries for user
>   home directories based on their default roles and is run when
>   building the policy.

	Done.
> ________________________________________________________________________


	What follows is an incremental patch relative to the changes
 already accepted.

	manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=changes.patch
Content-Description: Changes to policycoreutils bits.

--- orig/run_init/open_init_pty.c
+++ mod/run_init/open_init_pty.c
@@ -4,9 +4,9 @@
  * Created On       : Fri Jan 14 10:48:28 2005
  * Created On Node  : glaurung.internal.golden-gryphon.com
  * Last Modified By : Manoj Srivastava
- * Last Modified On : Fri Jan 14 19:06:19 2005
+ * Last Modified On : Thu Jan 20 23:50:04 2005
  * Last Machine Used: glaurung.internal.golden-gryphon.com
- * Update Count     : 85
+ * Update Count     : 89
  * Status           : Unknown, Use with caution!
  * HISTORY          : 
  * Description      : 
@@ -168,13 +168,13 @@
      /* get terminal parameters associated with stdout */
      if(tcgetattr(fileno(stdout), &tty_attr) < 0)
       {
-        perror("Error determining terminal characteristics");
+        perror("tcgetattr:");
         exit(EX_OSERR);
       } /* end of if(tcsetattr(&tty_attr)) */
 
      /* get window size */
      if( ioctl(fileno(stdout), TIOCGWINSZ, &window_size) < 0 ) {
-       perror("Error determining window size: ioctl stdout TIOCGWINSZ");
+       perror("ioctl stdout:");
        exit(1);
      }
 
@@ -187,7 +187,9 @@
 
   if(child_pid < 0)
    {
-     perror("Error forking process");
+     perror("Fork:");
+     fflush(stdout);
+     fflush(stderr);
      exit(EX_OSERR);
    } /* end of if(child_pid < 0) */
   if(child_pid == 0)
@@ -197,6 +199,8 @@
      if(tcgetattr(fileno(stdin), &s_tty_attr))
       {
         perror("Child:");
+        fflush(stdout);
+        fflush(stderr);
         exit(EXIT_FAILURE);
       }
      /* Turn off echo */
@@ -210,14 +214,16 @@
       }
 
      if ( execvp(argv[1], argv + 1) ) {
-       perror("Error executing child");
+       perror("Exec:");
+       fflush(stdout);
+       fflush(stderr);
        exit(EXIT_FAILURE);
      }
    } /* end of if(child_pid == 0) */
 
   /* 
    * OK. Prepare to handle IO from the child. We need to transfer
-   * everything from the shilds stdout to ours.
+   * everything from the child's stdout to ours.
    */
 
   FD_ZERO(&readfds);
@@ -230,12 +236,16 @@
   retval=fcntl(pty_master,F_GETFL);
   if(retval<0) {
     perror("fcntl_get");
+    fflush(stdout);
+    fflush(stderr);
     exit(EX_IOERR);
   }
 
   /* Set the connection to be non-blocking */
   if(fcntl(pty_master,F_SETFL, retval | O_NONBLOCK) < 0) {
     perror("fcnt_setFlag_nonblock:");
+    fflush(stdout);
+    fflush(stderr);
     exit(1);
   }
 
@@ -247,10 +257,14 @@
      if(tty_raw(fileno(stdin)) < 0)
       {
         perror("Error: settingraw mode:");
+        fflush(stdout);
+        fflush(stderr);
       } /* end of if(tty_raw(fileno(stdin)) < 0) */
      if(atexit(tty_atexit) < 0)
       {
         perror("Atexit setup:");
+        fflush(stdout);
+        fflush(stderr);
       } /* end of if(atexit(tty_atexit) < 0) */
    }
 
@@ -280,6 +294,8 @@
        if( retval < 0 ) {
          if(errno != EAGAIN) {
            perror("sigtimedwait");
+           fflush(stdout);
+           fflush(stderr);
            exit(EX_IOERR);
          }
          else
@@ -293,6 +309,8 @@
                &interval) < 0)
      {
        perror("Select:");
+       fflush(stdout);
+       fflush(stderr);
        exit (EX_IOERR);
      }
 
@@ -302,9 +320,10 @@
        if(retval < 0)
         {
           if(errno != EINTR && errno != EAGAIN) 
-           {
-             perror("Done?");
-             exit (EX_IOERR);
+           {                    /* Nothing left to read?  */
+             fflush(stdout);
+             fflush(stderr);
+             exit (EXIT_SUCCESS);
            } /* end of else */
         } /* end of if(retval < 0) */
        else
@@ -313,6 +332,8 @@
            {
              if(++err_count > 5)
               {                 /* child closed connection */
+                fflush(stdout);
+                fflush(stderr);
                 exit (EXIT_SUCCESS);
               }
            } /* end of if(retval == 0) */
@@ -331,9 +352,10 @@
           if(retval < 0)
            {
              if(errno != EINTR && errno != EAGAIN)
-              {
-                perror("Done?");
-                exit (EX_IOERR);
+              {                 /* Nothing left to read?  */
+                fflush(stdout);
+                fflush(stderr);
+                exit (EXIT_SUCCESS);
               } /* end of else */
            } /* end of if(retval < 0) */
           else
@@ -342,6 +364,8 @@
               {
                 if(++err_count > 5)
                  {              /* lost controlling tty */
+                   fflush(stdout);
+                   fflush(stderr);
                    exit (EXIT_SUCCESS);
                  }
               } /* end of if(retval == 0) */
@@ -356,6 +380,7 @@
   } /* Loop */
 
   fflush(stdout);
+  fflush(stderr);
 
   exit(EXIT_SUCCESS);
 } /* end of main() */


--- orig/scripts/genhomedircon
+++ mod/scripts/genhomedircon
@@ -3,8 +3,11 @@
 # see file 'COPYING' for use and warranty information
 
 #
-# genhomedircon - Replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
-#  with generic and user-specific values.
+# genhomedircon - this script is used to generate file context
+# configuration entries for user home directories based on their
+# default roles and is run when building the policy. Specifically, we
+# replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files with
+# generic and user-specific values.
 #
 # Based off original script by Dan Walsh, <dwalsh@redhat.com>
 #
@@ -17,7 +20,7 @@
 #  the user's home dir will be found in one of the HOME_ROOTs.
 #
 # "Real" users (as opposed to system users) are those whose UID is greater than
-#  or equal STARTING_UID (usually 100) and whose login is not a member of
+#  or equal STARTING_UID (usually 500) and whose login is not a member of
 #  EXCLUDE_LOGINS.  Users who are explicitly defined in FILECONTEXTDIR/users
 #  are always "real" (including root, in the default configuration).
 #


--- orig/scripts/genhomedircon.8
+++ mod/scripts/genhomedircon.8
@@ -24,7 +24,7 @@
 .\"
 .TH GENHOMEDIRCON "8" "January 2005" "Security Enhanced Linux" NSA
 .SH NAME
-genhomedircon \- expand HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
+genhomedircon \- generate file context configuration entries for user home directories 
 .SH SYNOPSIS
 .B genhomedircon
 .RI POLICYSOURCEDIR FILE_CONTEXTS 
@@ -34,7 +34,9 @@
 Print a short usage message
 .SH DESCRIPTION
 .PP
-This utility replaces the
+This utility is used to generate file context configuration entries
+for user home directories based on their default roles and is run when
+building the policy.  Specifically, it replaces the
 .B HOME_ROOT, HOME_DIR,
 and 
 .B ROLE
@@ -55,7 +57,7 @@
 only considers real users. "Real" users (as opposed
 to system users) are those whose UID is greater than or equal 
 .I STARTING_UID
-(usually 100) and whose login shell is not "/sbin/nologin", or
+(default 500) and whose login shell is not "/sbin/nologin", or
 "/bin/false". Users who are explicitly defined in 
 .I <<FILECONTEXTDIR>>/users
 are always "real" (including root, in the default configuration).




--=-=-=



-- 
So little time, so little to do. Oscar Levant
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
