Subject: [PATCH] libsepol: compile archive with -fpic
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, selinux-dev@tresys.com
Content-Type: text/plain
Date: Tue, 26 Sep 2006 13:54:51 -0400
Message-Id: <1159293291.2723.14.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The libsepol archive is compiled normally without the -fpic flag.  This
causes problems with other things that use libsepol.a with dynamic
relocation on 64-bit machines.  The setools project uses libsepol.a in a
shared object library; checkpolicy is prevented from being built as a
position independent executable.  The following patch modifies
libsepol's Makefile to build the archive using position independent
code.

--- libsepol/src/Makefile-orig  2006-09-19 10:03:54.000000000 -0400
+++ libsepol/src/Makefile       2006-09-19 10:06:21.000000000 -0400
@@ -24,7 +24,7 @@ $(LIBSO): $(LOBJS)
        ln -sf $@ $(TARGET)

 %.o:  %.c
-       $(CC) $(CFLAGS) -c -o $@ $<
+       $(CC) $(CFLAGS) -fpic -c -o $@ $<

 %.lo:  %.c
        $(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
