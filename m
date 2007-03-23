Subject: Re: Expunging userspace classes and permissions from kernel headers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1174675265.10788.72.camel@localhost.localdomain>
References: <1174569868.31436.22.camel@moss-spartans.epoch.ncsc.mil>
	 <1174571162.19924.36.camel@sgc.columbia.tresys.com>
	 <1174571459.31436.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1174584303.19924.43.camel@sgc.columbia.tresys.com>
	 <1174585916.31436.94.camel@moss-spartans.epoch.ncsc.mil>
	 <1174666169.19924.47.camel@sgc.columbia.tresys.com>
	 <1174667120.31436.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1174675265.10788.72.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 14:50:07 -0400
Message-Id: <1174675807.31436.296.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 14:41 -0400, Eric Paris wrote:
> On Fri, 2007-03-23 at 12:25 -0400, Stephen Smalley wrote:
> > On Fri, 2007-03-23 at 16:09 +0000, Christopher J. PeBenito wrote: 
> > > I reverted the comment change and changed "null" to NULL.  Is this what
> > > you had in mind (it doesn't have the PAX change yet)?
> > 
> > Yes, looks sane.  We would then apply that diff (re-based to the kernel
> > tree) along with a patch like the following untested one (added a guard
> > to both avc_dump_query and validate_classes despite my earlier comment).
> > Look reasonable to others?
> > 
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index da8caf1..b25cf18 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -217,7 +217,9 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
> >  		audit_log_format(ab, " tcontext=%s", scontext);
> >  		kfree(scontext);
> >  	}
> > -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> > +
> > +	if (tclass && tclass < ARRAY_SIZE(class_to_string))
> > +		audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> >  }
> 
> I don't see how this causes any harm.  Can we count on audit_log_format
> handleing a null pointer for the %s correctly?  If we are going to work
> under the assumption that bad tclass values might get in here we don't
> know if we are going to hit a hole in the class table.  Maybe we'd
> rather have
> 
> if (tclass)  && tclass < ARRAY_SIZE && class_to_string[tclass]
>    audit_log_format......
> else
>    printk(KERN_ERR "attempting to log a non-kernel class definition %d\n", tclass);
> 
> so we at least know when something is getting through....

Testing class_to_string[tclass] will also catch the tclass == 0 case, so
we could drop the first test then, and further, as avc_dump_query should
only ever be passed a kernel class, we can make it a BUG_ON, as below.
Inserting a printk there would be a bit confusing when auditd is
disabled - it would interleave with the avc message.

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index da8caf1..e4396a8 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -217,6 +217,8 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 		audit_log_format(ab, " tcontext=%s", scontext);
 		kfree(scontext);
 	}
+
+	BUG_ON(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass]);
 	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1e52356..3668f18 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1050,6 +1050,8 @@ static int validate_classes(struct policydb *p)
 
 	for (i = 1; i < kdefs->cts_len; i++) {
 		def_class = kdefs->class_to_string[i];
+		if (!def_class)
+			continue;
 		if (i > p->p_classes.nprim) {
 			printk(KERN_INFO
 			       "security:  class %s not defined in policy\n",

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
