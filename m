Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2Q6BO3M031908
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 02:11:24 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2Q67QNv022376
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 06:07:27 GMT
Message-ID: <49CB1C7A.2050206@ak.jp.nec.com>
Date: Thu, 26 Mar 2009 15:11:06 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: linux-audit@redhat.com
CC: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH] database audit integration (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
In-Reply-To: <49C9D524.9050208@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------070700080802050905040909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070700080802050905040909
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

I'm a developer of SE-PostgreSQL which is an enhancement of
database security using SELinux. It enables to apply the
security policy of the operating system on accesses to
database objects also.
It makes an access control decision and audit messages, but
these are not written out to system audit mechanism.

I believe our preferable behavior is the system audit collects
all the audit messages come from SELinux, not a logfile of
PostgreSQL.

Currently, the audit-libs has an interface to write a message
come from userspace avc, but some of parameter is not suitable
for the reference monitor in database management system.

This patch adds a new interface as follows:
    int audit_log_database_message(int audit_fd, int type,
                                   const char *message,
                                   const char *hostname,
                                   const char *addr,
                                   const char *dbuser);

It is differ from audit_log_user_avc_message() in the point of
a new parameter of dbuser, instead of tty and uid.
I don't think these are meaningful information for DBMS, but
we would like to record what database user invokes this audit
record.

Please any comments.

Thanks,

KaiGai Kohei wrote:
> 2. System audit integration
> 
> Now, SE-PostgreSQL writes out its access denied message into
> the logfile of PostgreSQL (/var/log/sepostgresql.log).
> But it is more desirable approach to write out them into system
> audit mechanism, because any other SELinux related messages
> are collected here and utilities like audit2allow is available.
> 
> TODO:
> - changes in the security policy:
>   We need to allow postgresql_t to write audit messages.
>   In addition, the backend process need to run with cap_audit_write.
> 
> - a new interface in audit-libs:
>   The current audit-libs has the following interface.
> 
>     extern int audit_log_user_avc_message(int audit_fd, int type,
>             const char *message, const char *hostname, const char *addr,
>             const char *tty, uid_t uid);
> 
>   But some arguments are not meaningful in SE-PostgreSQL.
>   I would like to write out database role here, instead of tty and uid.

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070700080802050905040909
Content-Type: text/x-patch;
 name="audit-libs-database-message.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit-libs-database-message.patch"

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 audit_logging.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 libaudit.h      |    3 ++
 2 files changed, 60 insertions(+)

Index: audit/lib/libaudit.h
===================================================================
--- audit/lib/libaudit.h	(revision 267)
+++ audit/lib/libaudit.h	(working copy)
@@ -562,6 +562,9 @@
 	const char *old_seuser, const char *old_role, const char *old_range,
 	const char *host, const char *addr,
         const char *tty, int result);
+extern int audit_log_database_message(int audit_fd, int type,
+	const char *message, const char *hostname, const char *addr,
+	const char *dbuser);
 extern int audit_log_user_command(int audit_fd, int type, const char *command,
         const char *tty, int result);
 
Index: audit/lib/audit_logging.c
===================================================================
--- audit/lib/audit_logging.c	(revision 267)
+++ audit/lib/audit_logging.c	(working copy)
@@ -623,6 +623,63 @@
 
 /*
  * This function will log a message to the audit system using a predefined
+ * message format. This function should be used by database management system
+ * as a SELinux object managers.
+ *
+ * audit_fd - The fd returned by audit_open
+ * type - type of message, ex: AUDIT_USER_AVC
+ * message - the message being sent
+ * hostname - the hostname if known
+ * addr - The network address of the client
+ * dbuser - The name of database user
+ *
+ * It returns the sequence number which is > 0 on success or <= 0 on error.
+ */
+int audit_log_database_message(int audit_fd, int type, const char *message,
+			const char *hostname, const char *addr, const char *dbuser)
+{
+	char buf[MAX_AUDIT_MESSAGE_LENGTH];
+	char addrbuf[INET6_ADDRSTRLEN];
+	int retval;
+
+	if (audit_fd < 0)
+		return 0;
+
+	if (hostname && *hostname == '\0')
+		hostname = NULL;
+	addrbuf[0] = '\0';
+
+	if (addr == NULL || strlen(addr) == 0)
+		_resolve_addr(addrbuf, hostname);
+	else
+		strncat(addrbuf, addr, sizeof(addrbuf)-1);
+
+	if (dbuser && *dbuser == '\0')
+		dbuser = NULL;
+
+	snprintf(buf, sizeof(buf),
+		 "%s: (dbuser=%s, hostname=%s, addr=%s)",
+		 message,
+		 dbuser ? dbuser : "?",
+		 hostname ? hostname : "?",
+		 addr ? addr : "?");
+
+	errno = 0;
+	retval = audit_send_user_message(audit_fd, type, REAL_ERR, buf);
+	if (retval == -EPERM && getuid != 0) {
+		syslog(LOG_ERR, "Can't send to audit system: %s %s",
+		       audit_msg_type_to_name(type), buf);
+		return 0;
+	}
+
+	if ((retval < 1) && errno == 0)
+		errno = retval;
+
+	return retval;
+}
+
+/*
+ * This function will log a message to the audit system using a predefined
  * message format. This function should be used by all console apps that do
  * not manipulate accounts or groups.
  *

--------------070700080802050905040909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
