From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux@tycho.nsa.gov
Subject: bug fix for devfsd makefile
Date: Mon, 14 Apr 2003 14:48:58 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304141448.58184.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please include the following in the next release.  It is needed for 
cross-compiling.

diff -ruN /tmp/selinux-small-2003011510/devfsd/Makefile ./devfsd/Makefile
--- /tmp/selinux-small-2003011510/devfsd/Makefile       2003-03-24 
15:53:30.0000
00000 +1100
+++ ./devfsd/Makefile   2002-04-20 06:32:37.000000000 +1000
@@ -3,7 +3,7 @@
 LDFLAGS= -L/usr/local/selinux/lib

 devfsd-se.so: devfsd-se.c
-       gcc -O2 -fPIC $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -lsecure
+       $(CC) -O2 -fPIC $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -lsecure

 clean:
        rm -f $(LIB)


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
