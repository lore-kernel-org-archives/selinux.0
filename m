Message-ID: <1482184239.28570.68.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>, John Johansen
 <john.johansen@canonical.com>, =?ISO-8859-1?Q?Jos=E9?= Bollo
 <jobol@nonadev.net>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org
Date: Mon, 19 Dec 2016 16:50:39 -0500
In-Reply-To: <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <8e8baad3-f39e-8d3a-661d-3302a96d43f1@canonical.com>
 <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 13:25 -0800, Casey Schaufler wrote:
> On 12/19/2016 12:36 PM, John Johansen wrote:
> > 
> > On 12/19/2016 08:32 AM, Casey Schaufler wrote:
> > > 
> > > On 12/19/2016 7:52 AM, Stephen Smalley wrote:
> > > > 
> > > > On Mon, 2016-12-19 at 16:41 +0100, José Bollo wrote:
> > > > > 
> > > > > Le lundi 19 décembre 2016 à 09:33 -0500, Stephen Smalley a
> > > > > écrit :
> > > > > > 
> > > > > > On Mon, 2016-12-19 at 10:44 +0100, José Bollo wrote:
> > > > > > > 
> > > > > > > Le vendredi 16 décembre 2016 à 12:41 -0500, Stephen
> > > > > > > Smalley a
> > > > > > > écrit :
> > > > > > > > 
> > > > > > > > Processes can only alter their own security attributes
> > > > > > > > via
> > > > > > > > /proc/pid/attr nodes.  This is presently enforced by
> > > > > > > > each
> > > > > > > > individual
> > > > > > > > security module and is also imposed by the Linux
> > > > > > > > credentials
> > > > > > > > implementation, which only allows a task to alter its
> > > > > > > > own
> > > > > > > > credentials.
> > > > > > > > Move the check enforcing this restriction from the
> > > > > > > > individual
> > > > > > > > security modules to proc_pid_attr_write() before
> > > > > > > > calling the
> > > > > > > > security
> > > > > > > > hook,
> > > > > > > > and drop the unnecessary task argument to the security
> > > > > > > > hook
> > > > > > > > since
> > > > > > > > it
> > > > > > > > can
> > > > > > > > only ever be the current task.
> > > > > > > Hi Stephen,
> > > > > > > 
> > > > > > > The module PTAGS that I made relies on the ability to
> > > > > > > write files
> > > > > > > in
> > > > > > > /proc/pid/attr/...
> > > > > > > 
> > > > > > > Why did I used this files? Thaere are serious reasons:
> > > > > > >  - follows the life cycle of the process
> > > > > > >  - implements pid namespace
> > > > > > > 
> > > > > > > There is absolutely no way to get these features easyly
> > > > > > > outside
> > > > > > > that
> > > > > > > implementation context of /proc/pid/attr/xxx.
> > > > > > > 
> > > > > > > For these reasons I vote against that change.
> > > > > > It is already prohibited by the credentials framework;
> > > > > If it were REALLY prohibited, your patch shouldn't exist ;)
> > > > You can't do it safely (and your current implementation is
> > > > unsafe).
> > > >  Please, read Documentation/security/credentials.txt in full,
> > > > and look
> > > > at the setprocattr implementations in the upstream security
> > > > modules for
> > > > reference.
> > > I just reviewed the referenced documentation (thanks David)
> > > and it does clearly identify why, from the viewpoint of the
> > > credential implementation, modifying another task's credentials
> > > is unsafe. Both Smack and SELinux view modification of task
> > > credentials as unsafe from a security viewpoint, so neither of
> > > these modules would force the credential implementation to
> > > allow the behavior.
> > > 
> > > This, unfortunately, leaves Jose in a bit of a bind. It looks
> > > to me like there are options, so let's not just tell him to
> > > go away. The options I see include:
> > > 
> > >  - Fix the credential code so modifying another task is safe
> > > 	I don't advocate this approach because the existing
> > > 	implementation is only reasonable because of the
> > > 	restriction.
> > >  - Revert shared credentials
> > > 	I confess to not being a fan of shared credentials,
> > > 	for reason of complexity. I would not expect a
> > > 	proposal to go back to embedding credentials in
> > > 	their containing structures to be considered seriously.
> > > 	Nonetheless, it would solve the problem.
> > >  - Add a security blob for the task
> > > 	It is unfortunate that when shared credentials were
> > > 	introduced the task blob was not renamed a cred blob.
> > > 	It would be simple and consistent to add a security
> > > 	blob to the task in addition to the blob in the cred.
> > > 	I would add a t_security field to the task structure
> > > 	that associates security data with the task. This
> > > 	blob would be used for data that does not meet intent
> > > 	of a credential, which I believe may be the case for
> > > 	Jose's PTAGS.
> > > 
> > > I know which I would prefer, but as I expect someone to shout
> > > that none can possibly be acceptable I think I'll stop here and
> > > let the discussion go a while.
> > > 
> > > ("Light fuse. Stand back. :))
> > > 
> > Tetsuo has been asking for the return of the task security blob
> > for years. It does makes sense as not everything fits the cred
> > model, eg. seccomp rules aren't part of the cred, and I don't think
> > it makes sense for PTAGS either.
> > 
> > AppArmor could make use of it as well, as currently we abuse
> > the cred a little bit to store the change_hat, and setexeccon info.
> 
> A brief look at the existing modules leads me to believe that
> everyone ought to be happier if we moved the LSM task blob out
> of the cred structure. SELinux keeps a small (6xu32) task blob
> that has no reason to share and refcount. Smack has a couple of
> lists in the task blob that really shouldn't be in the cred.
> There would have to be some rework of the task_alloc and task_free
> hooks to get the life of the blobs correct, but I think on the
> whole it would be lots cleaner.

Moving everything back to per-task security blob is inadvisable; the
kernel now passes around cred structures, including to some of the
security hooks, and you don't always want to check the credentials/sid
of the current task (that's one of the reasons creds were introduced).

You could perhaps move the SIDs other than the current one (e.g.
exec_sid, create_sid, ...) to the per-task security blob without
harm/confusion, but it is unclear what you gain from doing so; then we
would need to look in two places to find all the information we need
for certain hooks rather than one.  And certainly we'd end up consuming
more memory that way.

No, I don't think we want SELinux changed in this regard.
