Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QKCVSi026919
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 16:12:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id CAC1D1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 22:12:30 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNaOjOYpN2qS for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 22:12:27 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 6BC7A1A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 22:12:27 +0200 (CEST)
Date: Mon, 26 Mar 2012 22:12:24 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 8/8] setools --  Preserve ABI between GCC 4.3 and GCC 4.4
Message-ID: <20120326221224.6c47d40e@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm really not sure about that one.

It seems that the ABI has changed between 4.3 and GCC 4.4, this patch
is creating a compatibility alias for libsefs functions.

Cheers,
Laurent Bigonville

Description: libsefs built with GCC 4.3 is not binary-compatible with itself built with GCC 4.4
 That's because mangling of va_list has changed in GCC 4.4.
 To cope with this situation, provide compatibility aliases for the affected symbols
 and update symbol files accordingly.
Author: Jakub Wilk <jwilk@debian.org>
Date: Thu, 13 May 2010 17:40:33 +0200
Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=577061

--- a/libsefs/src/fcfile.cc
+++ b/libsefs/src/fcfile.cc
@@ -689,3 +689,16 @@ const apol_vector_t *sefs_fcfile_get_fil
 	}
 	return fcfile->fileList();
 }
+
+#if defined(__ARM_EABI__) && defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+// va_list mangling has been changed in g++ 4.4.
+// Add ABI <= g++-4.3 compatibility aliases.
+__asm__(".globl _ZN11sefs_fcfileC1EPFvPvPK11sefs_fclistiPKcS0_ES0_\n.set _ZN11sefs_fcfileC1EPFvPvPK11sefs_fclistiPKcS0_ES0_,_ZN11sefs_fcfileC1EPFvPvPK11sefs_fclistiPKcSt9__va_listES0_");
+__asm__(".globl _ZN11sefs_fcfileC1EPK11apol_vectorPFvPvPK11sefs_fclistiPKcS3_ES3_\n.set _ZN11sefs_fcfileC1EPK11apol_vectorPFvPvPK11sefs_fclistiPKcS3_ES3_,_ZN11sefs_fcfileC1EPK11apol_vectorPFvPvPK11sefs_fclistiPKcSt9__va_listES3_");
+__asm__(".globl _ZN11sefs_fcfileC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN11sefs_fcfileC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN11sefs_fcfileC1EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+__asm__(".globl _ZN11sefs_fcfileC2EPFvPvPK11sefs_fclistiPKcS0_ES0_\n.set _ZN11sefs_fcfileC2EPFvPvPK11sefs_fclistiPKcS0_ES0_,_ZN11sefs_fcfileC2EPFvPvPK11sefs_fclistiPKcSt9__va_listES0_");
+__asm__(".globl _ZN11sefs_fcfileC2EPK11apol_vectorPFvPvPK11sefs_fclistiPKcS3_ES3_\n.set _ZN11sefs_fcfileC2EPK11apol_vectorPFvPvPK11sefs_fclistiPKcS3_ES3_,_ZN11sefs_fcfileC2EPK11apol_vectorPFvPvPK11sefs_fclistiPKcSt9__va_listES3_");
+__asm__(".globl _ZN11sefs_fcfileC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN11sefs_fcfileC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN11sefs_fcfileC2EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+__asm__(".globl _ZN15sefs_filesystemC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN15sefs_filesystemC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN15sefs_filesystemC1EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+__asm__(".globl _ZN15sefs_filesystemC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN15sefs_filesystemC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN15sefs_filesystemC2EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+#endif
--- a/libsefs/src/fclist.cc
+++ b/libsefs/src/fclist.cc
@@ -764,3 +764,11 @@ bool query_str_compare(const char *targe
 		return false;
 	}
 }
+
+#if defined(__ARM_EABI__) && defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+// va_list mangling has been changed in g++ 4.4.
+// Add ABI <= g++-4.3 compatibility aliases.
+__asm__(".globl _ZN11sefs_fclistC1E16sefs_fclist_typePFvPvPKS_iPKcS1_ES1_\n.set _ZN11sefs_fclistC1E16sefs_fclist_typePFvPvPKS_iPKcS1_ES1_,_ZN11sefs_fclistC1E16sefs_fclist_typePFvPvPKS_iPKcSt9__va_listES1_");
+__asm__(".globl _ZN11sefs_fclistC2E16sefs_fclist_typePFvPvPKS_iPKcS1_ES1_\n.set _ZN11sefs_fclistC2E16sefs_fclist_typePFvPvPKS_iPKcS1_ES1_,_ZN11sefs_fclistC2E16sefs_fclist_typePFvPvPKS_iPKcSt9__va_listES1_");
+__asm__(".globl _ZNK11sefs_fclist9handleMsgEiPKcPv\n.set _ZNK11sefs_fclist9handleMsgEiPKcPv,_ZNK11sefs_fclist9handleMsgEiPKcSt9__va_list");
+#endif
--- a/libsefs/src/db.cc
+++ b/libsefs/src/db.cc
@@ -1302,3 +1302,12 @@ bool sefs_db_is_db(const char *filename)
 {
 	return sefs_db::isDB(filename);
 }
+
+#if defined(__ARM_EABI__) && defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+// va_list mangling has been changed in g++ 4.4.
+// Add ABI <= g++-4.3 compatibility aliases.
+__asm__(".globl _ZN7sefs_dbC1EP15sefs_filesystemPFvPvPK11sefs_fclistiPKcS2_ES2_\n.set _ZN7sefs_dbC1EP15sefs_filesystemPFvPvPK11sefs_fclistiPKcS2_ES2_,_ZN7sefs_dbC1EP15sefs_filesystemPFvPvPK11sefs_fclistiPKcSt9__va_listES2_");
+__asm__(".globl _ZN7sefs_dbC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN7sefs_dbC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN7sefs_dbC1EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+__asm__(".globl _ZN7sefs_dbC2EP15sefs_filesystemPFvPvPK11sefs_fclistiPKcS2_ES2_\n.set _ZN7sefs_dbC2EP15sefs_filesystemPFvPvPK11sefs_fclistiPKcS2_ES2_,_ZN7sefs_dbC2EP15sefs_filesystemPFvPvPK11sefs_fclistiPKcSt9__va_listES2_");
+__asm__(".globl _ZN7sefs_dbC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN7sefs_dbC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN7sefs_dbC2EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+#endif
--- a/libsefs/src/filesystem.cc
+++ b/libsefs/src/filesystem.cc
@@ -731,3 +731,10 @@ extern const char *sefs_filesystem_get_d
 	}
 	return dev_name;
 }
+
+#if defined(__ARM_EABI__) && defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+// va_list mangling has been changed in g++ 4.4.
+// Add ABI <= g++-4.3 compatibility aliases.
+__asm__(".globl _ZN15sefs_filesystemC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN15sefs_filesystemC1EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN15sefs_filesystemC1EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+__asm__(".globl _ZN15sefs_filesystemC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_\n.set _ZN15sefs_filesystemC2EPKcPFvPvPK11sefs_fclistiS1_S2_ES2_,_ZN15sefs_filesystemC2EPKcPFvPvPK11sefs_fclistiS1_St9__va_listES2_");
+#endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
