Subject: Re: [redhat-lspp] Re: [patch] Full relabel audit event
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, linux-audit@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1148665647.8828.36.camel@code.and.org>
References: <1148590901.8828.22.camel@code.and.org>
	 <1148663120.20976.235.camel@moss-spartans.epoch.ncsc.mil>
	 <1148665647.8828.36.camel@code.and.org>
Content-Type: text/plain
Date: Fri, 26 May 2006 14:03:34 -0400
Message-Id: <1148666614.20976.258.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-26 at 13:47 -0400, James Antill wrote:
> On Fri, 2006-05-26 at 13:05 -0400, Stephen Smalley wrote:
> > Hmmm...what is it that you actually want to do here?  If you only care
> > about auditing autorelabel events, then I'd suggest generating the audit
> > message from the autorelabel portion of rc.sysinit (via a helper, I
> > suppose), not from setfiles itself.
> 
>  This is all that we care about, but the solution of creating a helper
> to just be called before setfiles was considered suboptimal against just
> putting the code inside setfiles (I know Steve is very much against
> anything which acts like logger for the audit subsystem).

I don't see the point when a) you only want it in that one case, b) it
doesn't prevent trivial bypass in any way (e.g. by using restorecon, by
rolling your own program to do it, by running setfiles on /* rather than
just /, ...), and c) you aren't capturing any information that cannot be
determined by the caller of setfiles in the first place (just the fact
of a mass relabel and the final exit status).

Note btw that setfiles already provides three different ways to log
actual changes in file contexts, the original -v verbose mode, and the
-l (log via syslog) and -o <file> (log to file) modes introduced later
by Red Hat.  That at least provides detailed information that the caller
couldn't determine otherwise.

>  The thread is for the kernel problem that makes the above patch not
> actually work, see the thread "Re: audit 1.2.2 released".

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
