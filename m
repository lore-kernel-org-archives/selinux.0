Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163023021.29854.15.camel@code.and.org>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
	 <1163017959.29854.12.camel@code.and.org>
	 <1163019227.12241.178.camel@moss-spartans.epoch.ncsc.mil>
	 <1163023021.29854.15.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 17:13:10 -0500
Message-Id: <1163023990.12241.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-08 at 16:57 -0500, James Antill wrote:
> On Wed, 2006-11-08 at 15:53 -0500, Stephen Smalley wrote:
> 
> > The scontext is supposed to be a process context in which to run the
> > cron job, not a file context.  You are presently replacing the default
> > scontext (extracted from u->scontext that was previously computed) with
> > a strange mixture of the crontab file context and the user-specified
> > range.  What you want to do is to take the default scontext value,
> > create a new context that is identical except for its range (from the
> > environment), and apply a check between those two contexts (and the
> > check is only needed when using a user-supplied range).
> 
>  Ok, I've used u->scontext instead of the file context now. I've also
> renamed the variables. And the check should only happen if they specify
> a different level.
> 
> >   BTW, you cannot
> > continue to refer to the string returned by context_str() after
> > performing a context_free() on the structure; you'd have to dup it
> > first.
> 
>  Right, stupid mistake. Fixed that too.

Looks better.  A few nits:

+static int 
+cron_authorize_range
+( 
+	security_context_t scontext,
+	security_context_t file_context

s/file_context/ucontext/

+)	
+{
+#ifdef WITH_SELINUX
+	struct av_decision avd;
+	int retval;
+        unsigned int bit = CONTEXT__CONTAINS;
+	/*
+	 * Since crontab files are not directly executed,
+	 * crond must ensure that the crontab range has
+	 * a context that is appropriate for the context of
+	 * the user cron job.  It performs an entrypoint
+	 * permission check for this purpose.

cut-and-paste

+	 */
+	retval = security_compute_av(scontext, file_context,

s/file_context/ucontext/

+static int cron_get_job_range( user *u, security_context_t *ucontextp,
+                               char **jobenv )
+{
+	char *sroletype;

s/sroletype/range/

+	if ( (sroletype = env_get("MLS_LEVEL",jobenv)) != 0L )
+	{
+		char crontab[MAX_FNAME];
+                context_t ccon;
+
+		if ( strcmp(u->name,"*system*") == 0 )
+			strncpy(crontab, u->tabname, MAX_FNAME);
+		else
+			snprintf(crontab, MAX_FNAME, "%s/%s", CRONDIR, u->tabname);
+                
+                if (!(ccon = context_new(u->scontext)))
+                {
+			if ( security_getenforce() > 0 ) 
+			{
+				log_it(u->name, 
+				       getpid(), "context_new FAILED for SELINUX_ROLE_TYPE",

s/SELINUX_ROLE_TYPE/MLS_LEVEL/
 
+				       sroletype
+				      );
+				return -1;
+			} else
+                        {
+				log_it(u->name,
+				       getpid(), 
+				       "context_new FAILED but SELinux in permissive mode, continuing "
+				       "- SELINUX_ROLE_TYPE=", sroletype
+				       );
+				return 0;
+                        }

I wouldn't put tests of security_getenforce() on anything other than
permission denials (which avc_has_perm would do internally for you if
you were to use it instead of security_compute_av).  If context_new()
fails, it means you are out of memory, so permissive mode or not, you
are going to die.

+
+	        *ucontextp = strdup(context_str(ccon));

Needs checking of both the intermediate result (context_str return
value) and strdup to avoid seg faulting on NULL.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
