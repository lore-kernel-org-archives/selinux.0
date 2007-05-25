Message-ID: <465750DF.1050509@tycho.nsa.gov>
Date: Fri, 25 May 2007 17:10:55 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: object class discovery userland
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil> <1179929852.10995.51.camel@sgc.columbia.tresys.com> <46548D4E.50000@tycho.nsa.gov> <465623DD.6090304@tycho.nsa.gov> <6FE441CD9F0C0C479F2D88F959B01588BEFF31@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BEFF31@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a first go at an interface.  It's an init function that is a
replacement for avc_init().  It takes flags, the class/permission
mapping to use, and callback functions.

This is trying to solve a few other problems at the same time, namely:

- selinux prefix on the function name
- drops support for memory, threading, and locking callbacks (would just
always use malloc and pthread)
- adds type code to logging callback

---

 selinux.h |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)


Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2445)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -132,6 +132,43 @@
 		unsigned int seqno;
 	};
 
+	struct av_mapping {
+		const char *name;
+		const access_vector_t value;
+	};
+
+	struct security_class_mapping {
+		const char *name;
+		const security_class_t value;
+		const struct av_mapping *perms;
+	};
+
+/* Initialization routine for caching functions offered by the library */
+
+	struct selinux_callbacks {
+		/* log the printf-style format and arguments,
+		   with the type code indicating the type of message */
+		int (*func_log) (int type, const char *fmt, ...);
+		/* store a string representation of auditdata (corresponding
+		   to the given security class) into msgbuf. */
+		void (*func_audit) (void *auditdata, security_class_t cls,
+				    char *msgbuf, size_t msgbufsize);
+	};
+
+	extern int selinux_init(int flags,
+				const struct security_class_mapping *map,
+				const struct selinux_callbacks *callbacks);
+
+        /* Available flags */
+#define SELINUX_THREAD          1
+#define SELINUX_AVC             2
+
+        /* Logging type codes, passed to the logging callback */
+#define SELINUX_ERROR	        0
+#define SELINUX_WARNING		1
+#define SELINUX_INFO		2
+#define SELINUX_AVC_DENIAL	3
+
 /* Compute an access decision. */
 	extern int security_compute_av(security_context_t scon,
 				       security_context_t tcon,


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
