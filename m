Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163029645.29854.20.camel@code.and.org>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
	 <1163017959.29854.12.camel@code.and.org>
	 <1163019227.12241.178.camel@moss-spartans.epoch.ncsc.mil>
	 <1163023021.29854.15.camel@code.and.org>
	 <1163023990.12241.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1163029645.29854.20.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:07:14 -0500
Message-Id: <1163084834.12241.293.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-08 at 18:47 -0500, James Antill wrote:
>  Attached is the latest cron patch.

diff -rup vixie-cron-4.1-orig/security.c vixie-cron-4.1/security.c
--- vixie-cron-4.1-orig/security.c	2006-11-02 22:28:04.000000000 -0500
+++ vixie-cron-4.1/security.c	2006-11-08 17:35:27.000000000 -0500
+static int 
+cron_authorize_range
+( 
+	security_context_t scontext,
+	security_context_t ucontext
+)	
+{
+#ifdef WITH_SELINUX
+	struct av_decision avd;
+	int retval;
+        unsigned int bit = CONTEXT__CONTAINS;
+	/*
+	 * Since crontab files are not directly executed,
+	 * so crond must ensure that any user specified range
+	 * is allowed by the default users range.  It performs
+         * an entrypoint permission check for this purpose.
+	 */

Still not accurate.  This check is quite different in purpose and
rationale than the entrypoint check; it has nothing to do with the fact
that crontab files are not directly executed.  It is just a check of
whether the user-specified level falls within the seusers-specified
range for that Linux user.

+static int cron_change_selinux_range( user *u,
+                                      security_context_t ucontext )
+{
+	if ( is_selinux_enabled() <= 0 )
+		return 0;
+
+	if ( u->scontext == 0L )
+	{
+		if (security_getenforce() > 0) 
+		{
+			log_it( u->name, getpid(), 
+				"NULL security context for user", 
+				""
+			      );
+			return -1;
+		}else
+		{
+			log_it( u->name, getpid(), 
+				"NULL security context for user, "
+				"but SELinux in permissive mode, continuing",
+				""
+				);
+			return 0;
+		}

Another case where I don't understand why enforcing/permissive makes any
difference.

+	}
+	
+	if ( ucontext && strcmp(u->scontext, ucontext) )
+	{		
+                if ( ! cron_authorize_range( u->scontext, ucontext ))
+		{
+			if ( security_getenforce() > 0 ) 
+			{
+				syslog(LOG_ERR,
+				       "CRON (%s) ERROR:"
+				       "Unauthorized exec context to SELINUX_ROLE_TYPE %s for user", 
+				       u->name, (char*)ucontext
+				      );

Still refers to SELINUX_ROLE_TYPE in the log message.

+				return -1;
+			} else
+			{
+				syslog(LOG_INFO,
+				       "CRON (%s) WARNING:"
+				       "Unauthorized exec context to SELINUX_ROLE_TYPE %s for user,"
+				       " but SELinux in permissive mode, continuing", 
+				       u->name, (char*)ucontext
+				      );

Ditto.

+			}
+		}
+	} 
+
+	if ( setexeccon(ucontext) < 0 ) 
+	{
+		if (security_getenforce() > 0) 
+		{
+			syslog(LOG_ERR,
+			       "CRON (%s) ERROR:"
+			       "Could not set exec context to %s for user", 
+			       u->name, (char*)ucontext
+			      );
+
+			return -1;
+		}

Likely want to log something in the else case too so you don't just
silently proceed under crond's own context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
