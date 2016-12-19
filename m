Message-ID: <1482171140.2178.8.camel@nonadev.net>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, Casey Schaufler
 <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, john.johansen@canonical.com
Date: Mon, 19 Dec 2016 19:12:20 +0100
In-Reply-To: <1482167344.28570.38.camel@tycho.nsa.gov>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <1482167344.28570.38.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le lundi 19 décembre 2016 à 12:09 -0500, Stephen Smalley a écrit :
> On Mon, 2016-12-19 at 08:32 -0800, Casey Schaufler wrote:

(snip)

> > I just reviewed the referenced documentation (thanks David)
> > and it does clearly identify why, from the viewpoint of the
> > credential implementation, modifying another task's credentials
> > is unsafe. Both Smack and SELinux view modification of task
> > credentials as unsafe from a security viewpoint, so neither of
> > these modules would force the credential implementation to
> > allow the behavior.
> > 
> > This, unfortunately, leaves Jose in a bit of a bind. It looks
> > to me like there are options, so let's not just tell him to
> > go away. The options I see include:
> > 
> >  - Fix the credential code so modifying another task is safe
> > 	I don't advocate this approach because the existing
> > 	implementation is only reasonable because of the
> > 	restriction.
> >  - Revert shared credentials
> > 	I confess to not being a fan of shared credentials,
> > 	for reason of complexity. I would not expect a
> > 	proposal to go back to embedding credentials in
> > 	their containing structures to be considered seriously.
> > 	Nonetheless, it would solve the problem.

Hi Casey,

Thank you for this review of the possibilities because it opens my eyes
on the fact that I probably missed this "sharing credentials". Now I
understand better the issue (but probably only in surface): avoiding 
duplication not needed. I understand that it complicates things. For
example, the current implementation of PTAGS copies every thing even
for threads. It is more direct but it implies many unneeded
duplications.

When were shared credentials introduced?

> >  - Add a security blob for the task
> > 	It is unfortunate that when shared credentials were
> > 	introduced the task blob was not renamed a cred blob.
> > 	It would be simple and consistent to add a security
> > 	blob to the task in addition to the blob in the cred.
> > 	I would add a t_security field to the task structure
> > 	that associates security data with the task. This
> > 	blob would be used for data that does not meet intent
> > 	of a credential, which I believe may be the case for
> > 	Jose's PTAGS.
> > 
> > I know which I would prefer, but as I expect someone to shout
> > that none can possibly be acceptable I think I'll stop here and
> > let the discussion go a while.
> > 
> > ("Light fuse. Stand back. :))
> 
> Why not:
> 
> - Reconsider the approach used in PTAGS in light of the security
> implications of allowing one task to change another task's security
> attributes, and rework PTAGS to use a more secure approach.

PTAGS has not much things to do with kernel internals. It is only
intended to be available outside of the kernel (*).

Enforcing a task to only modify its attributes, not the one of other
tasks, has strong implication on the architecture of the system that
you build on top of PTAGS. It would make launchers mandatory, would
prohibit revocations, would forbid dynamic permissions and security
cookies. It could be possible but it would limit the possibilities.

The main idea of PTAGS is to attach data to tasks. How can it be done?
To follow life of tasks, LSM hooks is great and stacking is formidable.
To interface task's attributes, taking care of namespaces PID and user,
/proc/pid/attr is a very good place.

Best regards
José

(*) I asked me whether it were valuable provide kernel API for using
PTAGS internally but frankly it is a bad idea. Kernel has capabilities
and that's all. PTAGS isn't here to duplicate this behaviour.
