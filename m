Message-ID: <44D0B287.1040500@redhat.com>
Date: Wed, 02 Aug 2006 10:11:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to fix segfault in libselinux
Content-Type: multipart/mixed;
 boundary="------------080101030601000807030705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080101030601000807030705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

* Tue Aug  1 2006 Jeremy Katz <katzj@redhat.com> - 1.30.19-5
- only build non-fpic objects with -mno-tls-direct-seg-refs

* Tue Aug  1 2006 Jeremy Katz <katzj@redhat.com> - 1.30.19-4
- build with -mno-tls-direct-seg-refs on x86 to avoid triggering
  segfaults with xen (#200783)  


--------------080101030601000807030705
Content-Type: text/x-patch;
 name="libselinux-tlssegneg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-tlssegneg.patch"

--- libselinux-1.30.19/src/Makefile.notls	2006-08-01 14:16:38.000000000 -0400
+++ libselinux-1.30.19/src/Makefile	2006-08-01 14:37:15.000000000 -0400
@@ -24,6 +24,11 @@
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 RANLIB=ranlib
 
+ARCH := $(patsubst i%86,i386,$(shell uname -m))
+ifneq (,$(filter i386,$(ARCH)))
+TLSFLAGS += -mno-tls-direct-seg-refs
+endif
+
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 all: $(LIBA) $(LIBSO) 
@@ -45,7 +50,7 @@
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
-	$(CC) $(CFLAGS) -c -o $@ $<
+	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
 
 %.lo:  %.c policy.h
 	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<

--------------080101030601000807030705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
