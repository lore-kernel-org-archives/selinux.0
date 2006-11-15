Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAF6mpR1012912
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 01:48:51 -0500
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAF6lDcB020528
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 06:47:14 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.8/8.13.8/Debian-2) with ESMTP id kAF6kSjo005744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 00:46:36 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Compiling libsepol with -fPIC instead of -fpic
Date: Wed, 15 Nov 2006 00:45:25 -0600
Message-ID: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        I've had reports of packages filing to compile on SPARC
 hardware when linked with  libsepol1 which was compiled with
 -fpic. We seem to be hitting the global offset table size limit;
,----[ GCC manual ]
| `-fpic'
|      Generate position-independent code (PIC) suitable for use in a
|      shared library, if supported for the target machine.  Such code
|      accesses all constant addresses through a global offset table
|      (GOT).  The dynamic loader resolves the GOT entries when the
|      program starts (the dynamic loader is not part of GCC; it is part
|      of the operating system).  If the GOT size for the linked
|      executable exceeds a machine-specific maximum size, you get an
|      error message from the linker indicating that `-fpic' does not
|      work; in that case, recompile with `-fPIC' instead.  (These
|      maximums are 8k on the SPARC and 32k on the m68k and RS/6000.  The
|      386 has no such limit.)
`----

        Simply recompiling with -fPIC corrects the problem.

        manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline

--- orig/src/Makefile
+++ mod/src/Makefile
@@ -24,10 +24,10 @@
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -fpic -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
 
 %.lo:  %.c
-	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 install: all
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)


-- 
You can always pick up your needle and move to another groove. Tim
Leary
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
