Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49ERiAJ016863
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:27:44 -0400
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49ERha2023961
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 14:27:43 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k49ERfBW026101
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:27:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k49ERfUi268850
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 08:27:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k49ERePM020901
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 08:27:40 -0600
Received: from [9.12.235.9] ([9.12.235.9])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k49ERdlw020860
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 08:27:40 -0600
Message-ID: <4460A6DA.1040407@us.ibm.com>
Date: Tue, 09 May 2006 10:27:38 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [PATCH 1/1] mount: shared-subtree support for mount]
Content-Type: multipart/mixed;
 boundary="------------080608090203050108020406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080608090203050108020406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As per Russell's request, I am posting this patch here as well, so 
broader selinux
community can also play with the shared tree feature.

-Janak

--------------080608090203050108020406
Content-Type: message/rfc822;
 name="[PATCH 1/1] mount: shared-subtree support for mount"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 1/1] mount: shared-subtree support for mount"

Return-Path: <linuxram@us.ibm.com>
Received: from imap.linux.ibm.com ([unix socket])
	 by imap.linux.ibm.com (Cyrus v2.3.1-Invoca-RPM-2.3.1-2.1) with LMTPA;
	 Wed, 19 Apr 2006 15:51:48 -0400
X-Sieve: CMU Sieve 2.3
Received: by imap.linux.ibm.com (Postfix, from userid 101)
	id 8C77045C02F; Wed, 19 Apr 2006 15:51:48 -0400 (EDT)
X-Spam-TestScore: TW_UU=0.077
X-Spam-TokenSummary: Bayes not run.
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on imap.linux.ibm.com
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=TW_UU autolearn=disabled
	version=3.1.1
X-Spam-Relay-Country: 
Received: from smtp.linux.ibm.com (smtp.linux.ibm.com [9.26.4.197])
	by imap.linux.ibm.com (Postfix) with ESMTP id 1523945C02E;
	Wed, 19 Apr 2006 15:51:46 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.linux.ibm.com (Postfix) with ESMTP id 5746598045;
	Wed, 19 Apr 2006 15:51:45 -0400 (EDT)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by smtp.linux.ibm.com (Postfix) with ESMTP id D1BA598034;
	Wed, 19 Apr 2006 15:51:44 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3JJpiw1176984;
	Wed, 19 Apr 2006 15:51:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3JJpiG9019724;
	Wed, 19 Apr 2006 15:51:44 -0400
Received: from localhost (dyn9047021196.beaverton.ibm.com [9.47.21.196])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k3JJphMd019684;
	Wed, 19 Apr 2006 15:51:44 -0400
Received: by localhost (Postfix, from userid 1000)
	id 19A08470030; Wed, 19 Apr 2006 12:51:43 -0700 (PDT)
To: janak@us.ibm.com
Subject: [PATCH 1/1] mount: shared-subtree support for mount
Cc: linuxram@us.ibm.com
Message-Id: <20060419195143.19A08470030@localhost>
Date: Wed, 19 Apr 2006 12:51:43 -0700 (PDT)
From: linuxram@us.ibm.com (Ram Pai)
X-Virus-Scanned: amavisd-new at linux.ibm.com

 This patch builds shared-subtree semantics awareness into the mount command.  
 Updates the man page for mount too.

 Signed-off-by: Ram Pai <linuxram@us.ibm.com>

 mount/mount.8           |   35 ++++++++++++++++++++++++++
 mount/mount.c           |   64 ++++++++++++++++++++++++++++++++++++++++++++++--
 mount/mount_constants.h |   12 +++++++++
 3 files changed, 109 insertions(+), 2 deletions(-)

Index: util-linux-2.13-pre6/mount/mount.c
===================================================================
--- util-linux-2.13-pre6.orig/mount/mount.c
+++ util-linux-2.13-pre6/mount/mount.c
@@ -72,11 +72,13 @@ int mount_all = 0;
 static int optfork = 0;
 
 /* Add volumelabel in a listing of mounted devices (-l). */
 static int list_with_volumelabel = 0;
 
-/* Nonzero for mount {--bind|--replace|--before|--after|--over|--move} */
+/* Nonzero for mount {--bind|--replace|--before|--after|--over|--move|
+ * 		       make-shared|make-private|make-unbindable|make-slave}
+ */
 static int mounttype = 0;
 
 /* True if ruid != euid.  */
 static int suid = 0;
 
@@ -104,10 +106,11 @@ struct opt_map {
 /* Options that we keep the mount system call from seeing.  */
 #define MS_NOSYS	(MS_NOAUTO|MS_USERS|MS_USER|MS_COMMENT|MS_LOOP)
 
 /* Options that we keep from appearing in the options field in the mtab.  */
 #define MS_NOMTAB	(MS_REMOUNT|MS_NOAUTO|MS_USERS|MS_USER)
+#define MS_PROPAGATION  (MS_SHARED|MS_SLAVE|MS_UNBINDABLE|MS_PRIVATE)
 
 /* Options that we make ordinary users have by default.  */
 #define MS_SECURE	(MS_NOEXEC|MS_NOSUID|MS_NODEV)
 
 /* Options that we make owner-mounted devices have by default */
@@ -338,10 +341,13 @@ parse_opts (const char *options, int *fl
 
 	if (readonly)
 		*flags |= MS_RDONLY;
 	if (readwrite)
 		*flags &= ~MS_RDONLY;
+
+	if (mounttype & MS_PROPAGATION)
+		*flags &= ~MS_BIND;
 	*flags |= mounttype;
 }
 
 /* Try to build a canonical options string.  */
 static char *
@@ -857,17 +863,19 @@ retry_nfs:
   if (fake || mnt5_res == 0) {
       /* Mount succeeded, report this (if verbose) and write mtab entry.  */
       if (loop)
 	  opt_loopdev = loopdev;
 
-      update_mtab_entry(loop ? loopfile : spec,
+      if (!(mounttype & MS_PROPAGATION)) {
+	      update_mtab_entry(loop ? loopfile : spec,
 			node,
 			types ? types : "unknown",
 			fix_opts_string (flags & ~MS_NOMTAB, extra_opts, user),
 			flags,
 			freq,
 			pass);
+      }
 
       block_signals (SIG_UNBLOCK);
       res = 0;
       goto out;
   }
@@ -1402,10 +1410,18 @@ static struct option longopts[] = {
 	{ "before", 0, 0, 131 },
 	{ "over", 0, 0, 132 },
 	{ "move", 0, 0, 133 },
 	{ "guess-fstype", 1, 0, 134 },
 	{ "rbind", 0, 0, 135 },
+	{ "make-shared", 0, 0, 136 },
+	{ "make-slave", 0, 0, 137 },
+	{ "make-private", 0, 0, 138 },
+	{ "make-unbindable", 0, 0, 139 },
+	{ "make-rshared", 0, 0, 140 },
+	{ "make-rslave", 0, 0, 141 },
+	{ "make-rprivate", 0, 0, 142 },
+	{ "make-runbindable", 0, 0, 143 },
 	{ "internal-only", 0, 0, 'i' },
 	{ NULL, 0, 0, 0 }
 };
 
 /* Keep the usage message at max 22 lines, each at most 70 chars long.
@@ -1428,10 +1444,21 @@ usage (FILE *fp, int n) {
 	  "a filesystem (of the given type) found on the device.\n"
 	  "One can also mount an already visible directory tree elsewhere:\n"
 	  "       mount --bind olddir newdir\n"
 	  "or move a subtree:\n"
 	  "       mount --move olddir newdir\n"
+	  "One can change the type of mount containing the directory dir:\n"
+	  "       mount --make-shared dir\n"
+	  "       mount --make-slave dir\n"
+	  "       mount --make-private dir\n"
+	  "       mount --make-unbindable dir\n"
+	  "One can change the type of all the mounts in a mount subtree\n"
+	  "containing the directory dir:\n"
+	  "       mount --make-rshared dir\n"
+	  "       mount --make-rslave dir\n"
+	  "       mount --make-rprivate dir\n"
+	  "       mount --make-runbindable dir\n"
 	  "A device can be given by name, say /dev/hda1 or /dev/cdrom,\n"
 	  "or by label, using  -L label  or by uuid, using  -U uuid .\n"
 	  "Other options: [-nfFrsvw] [-o options] [-p passwdfd].\n"
 	  "For many more details, say  man 8 mount .\n"
 	));
@@ -1579,10 +1606,43 @@ main(int argc, char *argv[]) {
 			exit(fstype ? 0 : EX_FAIL);
 		    }
 		case 135:
 			mounttype = (MS_BIND | MS_REC);
 			break;
+
+		case 136:
+			mounttype = MS_SHARED;
+			break;
+
+		case 137:
+			mounttype = MS_SLAVE;
+			break;
+
+		case 138:
+			mounttype = MS_PRIVATE;
+			break;
+
+		case 139:
+			mounttype = MS_UNBINDABLE;
+			break;
+
+		case 140:
+			mounttype = (MS_SHARED | MS_REC);
+			break;
+
+		case 141:
+			mounttype = (MS_SLAVE | MS_REC);
+			break;
+
+		case 142:
+			mounttype = (MS_PRIVATE | MS_REC);
+			break;
+
+		case 143:
+			mounttype = (MS_UNBINDABLE | MS_REC);
+			break;
+
 		case '?':
 		default:
 			usage (stderr, EX_USAGE);
 		}
 	}
Index: util-linux-2.13-pre6/mount/mount_constants.h
===================================================================
--- util-linux-2.13-pre6.orig/mount/mount_constants.h
+++ util-linux-2.13-pre6/mount/mount_constants.h
@@ -55,10 +55,22 @@ if we have a stack or plain mount - moun
 #define MS_REC		0x4000	/* 16384: Recursive loopback */
 #endif
 #ifndef MS_VERBOSE
 #define MS_VERBOSE	0x8000	/* 32768 */
 #endif
+#ifndef MS_UNBINDABLE
+#define MS_UNBINDABLE	(1<<17)	/* 131072 unbindable*/
+#endif
+#ifndef MS_PRIVATE
+#define MS_PRIVATE	(1<<18)	/* 262144 Private*/
+#endif
+#ifndef MS_SLAVE
+#define MS_SLAVE	(1<<19)	/* 524288 Slave*/
+#endif
+#ifndef MS_SHARED
+#define MS_SHARED	(1<<20)	/* 1048576 Shared*/
+#endif
 /*
  * Magic mount flag number. Had to be or-ed to the flag values.
  */
 #ifndef MS_MGC_VAL
 #define MS_MGC_VAL 0xC0ED0000	/* magic flag number to indicate "new" flags */
Index: util-linux-2.13-pre6/mount/mount.8
===================================================================
--- util-linux-2.13-pre6.orig/mount/mount.8
+++ util-linux-2.13-pre6/mount/mount.8
@@ -129,10 +129,45 @@ to another place. The call is
 .RS
 .br
 .B "mount --move olddir newdir"
 .RE
 
+Since Linux 2.6.15 it is possible to mark a mount and its submounts as shared,
+private, slave or unbindable. A shared mount provides ability to create mirrors
+of that mount such that mounts and umounts within any of the mirrors propagate
+to the other mirror. A slave mount receives propagation from its master, but
+any not vice-versa.  A private mount carries no propagation abilities.  A
+unbindable mount is a private mount which cannot cloned through a bind
+operation. Detailed semantics is documented in Documentation/sharedsubtree.txt
+file in the kernel source tree.
+.RS
+.br
+.B "mount --make-shared mountpoint"
+.br
+.B "mount --make-slave mountpoint"
+.br
+.B "mount --make-private mountpoint"
+.br
+.B "mount --make-unbindable mountpoint"
+.br
+.RE
+
+The following commands allows one to recursively change the type of all the
+mounts under a given mountpoint.
+.RS
+.br
+.B "mount --make-rshared mountpoint"
+.br
+.B "mount --make-rslave mountpoint"
+.br
+.B "mount --make-rprivate mountpoint"
+.br
+.B
+"mount --make-runbindable mountpoint"
+.br
+.RE
+
 The
 .I proc
 file system is not associated with a special device, and when
 mounting it, an arbitrary keyword, such as
 .I proc

--------------080608090203050108020406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
