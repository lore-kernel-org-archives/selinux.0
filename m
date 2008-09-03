Subject: Re: [PATCH -v2] SELinux: memory leak in
	security_context_to_sid_core
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <1220450903.6034.64.camel@moss-spartans.epoch.ncsc.mil>
References: <1220390111.2962.19.camel@localhost.localdomain>
	 <1220444041.6034.1.camel@moss-spartans.epoch.ncsc.mil>
	 <alpine.LRH.1.10.0809032245380.21379@tundra.namei.org>
	 <1220447095.6034.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1220450296.2962.43.camel@localhost.localdomain>
	 <1220450903.6034.64.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 10:26:26 -0400
Message-Id: <1220451986.2962.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-09-03 at 10:08 -0400, Stephen Smalley wrote:
> On Wed, 2008-09-03 at 09:58 -0400, Eric Paris wrote:
> > Fix a bug and a philosophical decision about who handles errors.
> > 
> > security_context_to_sid_core() was leaking a context in the common case.
> > This was causing problems on fedora systems which recently have started
> > making extensive use of this function.
> > 
> > In discussion it was decided that if string_to_context_struct() had an
> > error it was its own responsibility to clean up any mess it created
> > along the way.  Remember that it is perfectly safe to call
> > context_destroy() on the same context twice and so this will not
> > introduce any double frees or cause issues with the other change.
> 
> Well, there are two possibilities.  Either:
> 1) we are fine with multiple calls to context_destroy(), in which case
> the original patch stands as is, or

I'm fine with it standing, but I rewrote it really because I didn't want
yet another needless goto that I added.

> 2) we want to avoid multiple calls to context_destroy(), in which case
> this patch is still wrong - the latter context_destroy() call should
> only occur _before_ the out label (i.e. same place it was, only without
> the conditional).

Lets go this route just to have some consistency.  I put it where I did
so it was done without the policy_rwlock.  Since we are now seeing
hundreds to thousands of calls to this code path I think its worth it to
be a slight bit more picky with the locking.  So how about a version 3
like this?  If you ack I'll send it cleanly for jmorris....

---

 security/selinux/ss/services.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b52f923..a0a73e7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -811,11 +811,12 @@ static int string_to_context_struct(struct policydb *pol,
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(pol, ctx)) {
 		rc = -EINVAL;
-		context_destroy(ctx);
 		goto out;
 	}
 	rc = 0;
 out:
+	if (rc)
+		context_destroy(ctx);
 	return rc;
 }
 
@@ -865,13 +866,14 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		context.str = str;
 		context.len = scontext_len;
 		str = NULL;
-	} else if (rc)
+	} else if (rc) {
+		read_unlock(&policy_rwlock);
 		goto out;
+	}
 	rc = sidtab_context_to_sid(&sidtab, &context, sid);
-	if (rc)
-		context_destroy(&context);
-out:
 	read_unlock(&policy_rwlock);
+	context_destroy(&context);
+out:
 	kfree(scontext2);
 	kfree(str);
 	return rc;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
