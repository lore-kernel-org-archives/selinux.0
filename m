Date: Fri, 12 Apr 2002 11:33:39 -0700 (PDT)
From: Sung Kim <hunkim@cse.ucsc.edu>
To: SELinux@tycho.nsa.gov
Subject: Stat compile error.
Message-ID: <Pine.GSO.4.44.0204121131350.9478-100000@sundance.cse.ucsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

When I compile /usr/src/selinux/utils/stat-2.5, I've got the error:

[root@hunkim stat-2.5]# make
gcc -O2 -g -Wall -DFLASK_LINUX -D_FILE_OFFSET_BITS=64 -I/usr/local/selinux/include   -c -o stat.o stat.c
stat.c:29:1: directives may not be used inside a macro argument
stat.c:29:1: unterminated argument list invoking macro "printf"
stat.c: In function `do_statfs':
stat.c:32: parse error before "filename"
stat.c:49: warning: long int format, int arg (arg 5)
stat.c:122: warning: long unsigned int format, int arg (arg 3)
stat.c:128: warning: long int format, int arg (arg 6)
stat.c: In function `usage':
stat.c:293: warning: implicit declaration of function `exit'
make: *** [stat.o] Error 1

[root@hunkim stat-2.5]# gcc --version
3.0.2

The patch is that :

--- stat.org.c  Fri Apr 12 11:13:52 2002
+++ stat.c      Fri Apr 12 11:14:21 2002
@@ -26,9 +26,19 @@
        if (terse != 0) {
 #ifdef __USE_FILE_OFFSET64
                printf("%s %x %x %lu %lx %lld %lld %lld %ld %lld %lld\n",
+                       filename,
+                       statfsbuf.f_fsid.__val[0],
+                       statfsbuf.f_fsid.__val[1],
+                       statfsbuf.f_namelen,
+                       statfsbuf.f_type,
+                       statfsbuf.f_blocks,
+                       statfsbuf.f_bfree,
+                       statfsbuf.f_bavail,
+                       statfsbuf.f_bsize,
+                       statfsbuf.f_files,
+                       statfsbuf.f_ffree);
 #else
                printf("%s %x %x %d %x %ld %ld %ld %d %ld %ld\n",
-#endif
                        filename,
                        statfsbuf.f_fsid.__val[0],
                        statfsbuf.f_fsid.__val[1],
@@ -40,6 +50,7 @@
                        statfsbuf.f_bsize,
                        statfsbuf.f_files,
                        statfsbuf.f_ffree);
+#endif

                return;
        }

--
Sung Kim <hunkim@cse.ucsc.edu>
http://www.cse.ucsc.edu/~hunkim

 "Dreams become reality!"


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
