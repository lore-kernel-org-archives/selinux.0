From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: patch libsecure
Date: Wed, 23 Apr 2003 20:48:16 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_G88T81GP59MH80XCVKVD"
Message-Id: <200304232048.16402.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_G88T81GP59MH80XCVKVD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I missing some free calls in the libsecure test files. The attached patch=
=20
insert this calls.

Carsten
--------------Boundary-00=_G88T81GP59MH80XCVKVD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch.libsecure"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.libsecure"

? patch.libsecure
Index: test/getsecsid.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/libsecure/test/getsecsid.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getsecsid.c
--- test/getsecsid.c	20 Dec 2001 23:24:58 -0000	1.1.1.1
+++ test/getsecsid.c	23 Apr 2003 18:43:19 -0000
@@ -51,6 +51,6 @@
 	}
 
 	printf("Context:  %s\n", scontext);
-
+	free(scontext);
 	exit(0);
 }
Index: test/lstat_s.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/libsecure/test/lstat_s.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 lstat_s.c
--- test/lstat_s.c	20 Dec 2001 23:24:58 -0000	1.1.1.1
+++ test/lstat_s.c	23 Apr 2003 18:43:19 -0000
@@ -48,6 +48,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);
Index: test/sid_to_context.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/libsecure/test/sid_to_context.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sid_to_context.c
--- test/sid_to_context.c	20 Dec 2001 23:24:58 -0000	1.1.1.1
+++ test/sid_to_context.c	23 Apr 2003 18:43:19 -0000
@@ -43,5 +43,6 @@
 	}
 
 	printf("%s\n", buf);
+	free(buf);
 	exit(0);
 }
Index: test/stat_s.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/libsecure/test/stat_s.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 stat_s.c
--- test/stat_s.c	20 Dec 2001 23:24:58 -0000	1.1.1.1
+++ test/stat_s.c	23 Apr 2003 18:43:19 -0000
@@ -48,6 +48,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);
Index: test/statfs_s.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/libsecure/test/statfs_s.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 statfs_s.c
--- test/statfs_s.c	20 Dec 2001 23:24:58 -0000	1.1.1.1
+++ test/statfs_s.c	23 Apr 2003 18:43:19 -0000
@@ -48,6 +48,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);
Index: test/arch/i386/stat64_s.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux/libsecure/test/arch/i386/stat64_s.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 stat64_s.c
--- test/arch/i386/stat64_s.c	15 Mar 2002 13:01:17 -0000	1.1.1.1
+++ test/arch/i386/stat64_s.c	23 Apr 2003 18:43:19 -0000
@@ -49,6 +49,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);

--------------Boundary-00=_G88T81GP59MH80XCVKVD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
