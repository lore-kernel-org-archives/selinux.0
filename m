Message-ID: <454A9594.70407@us.ibm.com>
Date: Thu, 02 Nov 2006 19:04:20 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 3/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010405040509060602060502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010405040509060602060502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael C Thompson wrote:
> The 8 patches are as follows:
> 1) Modifications to Makefile to support future patch needs
>    Add newrole-lspp.pamd
> 2) New extract_pw_data function and use in main()
> 3) Add signal handler function

This is the 3rd of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This patch moves the signal handler setup from main() into a new
function.

Changes:
  * Adds set_signal_handles() and uses it in main()

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------010405040509060602060502
Content-Type: text/x-diff;
 name="03-signal_func.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-signal_func.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-11-02 12:20:18.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 12:22:27.000000000 -0600
@@ -498,6 +498,30 @@
 }
 #endif
 
+/**
+ * Take care of any signal setup
+ */
+static int set_signal_handles()
+{
+	sigset_t empty;
+
+	/* Empty the signal mask in case someone is blocking a signal */
+	if (sigemptyset(&empty)) {
+		fprintf(stderr, _("Unable to obtain empty signal set\n"));
+		return -1;
+	}
+
+	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
+
+	/* Terminate on SIGHUP. */
+	if (signal(SIGHUP, SIG_DFL) == SIG_ERR) {
+		fprintf(stderr, _("Unable to set SIGHUP handler\n"));
+		return -1;
+	}
+
+	return 0;
+}
+
 /************************************************************************
  *
  * All code used for both PAM and shadow passwd goes in this section.
@@ -534,18 +558,13 @@
 	uid_t uid;
 	int fd;
 	int enforcing;
-	sigset_t empty;
 
 #ifdef LOG_AUDIT_PRIV
 	drop_capabilities();
 #endif
 
-	/* Empty the signal mask in case someone is blocking a signal */
-	sigemptyset(&empty);
-	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
-
-	/* Terminate on SIGHUP. */
-	signal(SIGHUP, SIG_DFL);
+	if (set_signal_handles())
+		return -1;
 
 #ifdef USE_NLS
 	setlocale(LC_ALL, "");

--------------010405040509060602060502--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
