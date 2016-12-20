Message-ID: <1482230211.2203.1.camel@nonadev.net>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Cc: john.johansen@canonical.com, James Morris <james.l.morris@oracle.com>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Tue, 20 Dec 2016 11:36:51 +0100
In-Reply-To: <CAHC9VhRcHxEMjTwjq6ZiAjHcAyveWOnRdRayoq86tdUsD_OdMw@mail.gmail.com>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQOjXUYxRaHcgxwiTFwwNsUuf646O-gDq7Bm_0aToMtgQ@mail.gmail.com>
 <28224bb8-425e-5dec-472f-105c5cd7e098@schaufler-ca.com>
 <CAHC9VhRcHxEMjTwjq6ZiAjHcAyveWOnRdRayoq86tdUsD_OdMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le lundi 19 décembre 2016 à 20:30 -0500, Paul Moore a écrit :
> On Fri, Dec 16, 2016 at 5:13 PM, Casey Schaufler <casey@schaufler-ca.
> com> wrote:
> > On 12/16/2016 2:06 PM, Paul Moore wrote:
> > > On Fri, Dec 16, 2016 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.
> > > gov> wrote:
> > > > Processes can only alter their own security attributes via
> > > > /proc/pid/attr nodes.  This is presently enforced by each
> > > > individual
> > > > security module and is also imposed by the Linux credentials
> > > > implementation, which only allows a task to alter its own
> > > > credentials.
> > > > Move the check enforcing this restriction from the individual
> > > > security modules to proc_pid_attr_write() before calling the
> > > > security hook,
> > > > and drop the unnecessary task argument to the security hook
> > > > since it can
> > > > only ever be the current task.
> > > > 
> > > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > > ---
> > > >  fs/proc/base.c             | 13 +++++++++----
> > > >  include/linux/lsm_hooks.h  |  3 +--
> > > >  include/linux/security.h   |  4 ++--
> > > >  security/apparmor/lsm.c    |  7 ++-----
> > > >  security/security.c        |  4 ++--
> > > >  security/selinux/hooks.c   | 13 +------------
> > > >  security/smack/smack_lsm.c | 11 +----------
> > > >  7 files changed, 18 insertions(+), 37 deletions(-)
> > > 
> > > Looks good to me.  I'm happy to pull this in via the SELinux tree
> > > unless anyone else would rather take it?
> > 
> > That works for me. It does need to go in atomically.
> 
> Even with all the discussion today, I still think this patch has
> value
> and I don't believe it should impact the PTAGS work as there are
> clearly larger issues that need to be resolved (e.g. reintroduce a
> task based security blob?).  Unless I hear any objections that this
> will wreck everything for years to come (very doubtful), I'll go
> ahead
> and merge this into the SELinux tree tomorrow.

Please explain first the relationship that you are supposing true:

    writing /proc/pid/attr/.. == writing creds


I'm feeling that there is here a weird logic.

I can agree that the use of creds that I made is wrong and must be
changed. But how can I agree that writing to /proc/pid/attr/... is not
good when for my purpose it is a valuable and working solution?

Best regards
José Bollo
