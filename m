To: casey@schaufler-ca.com, john.johansen@canonical.com, sds@tycho.nsa.gov,
 jobol@nonadev.net, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] proc,
 security: move restriction on writing/proc/pid/attr nodes to proc
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <8e8baad3-f39e-8d3a-661d-3302a96d43f1@canonical.com>
 <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
In-Reply-To: <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
Message-Id: <201612200646.CGJ95321.QVMHOOtFOJSFFL@I-love.SAKURA.ne.jp>
Date: Tue, 20 Dec 2016 06:46:18 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Casey Schaufler wrote:
> On 12/19/2016 12:36 PM, John Johansen wrote:
> > On 12/19/2016 08:32 AM, Casey Schaufler wrote:
> >> This, unfortunately, leaves Jose in a bit of a bind. It looks
> >> to me like there are options, so let's not just tell him to
> >> go away. The options I see include:
> >>
> >>  - Fix the credential code so modifying another task is safe
> >> 	I don't advocate this approach because the existing
> >> 	implementation is only reasonable because of the
> >> 	restriction.
> >>  - Revert shared credentials
> >> 	I confess to not being a fan of shared credentials,
> >> 	for reason of complexity. I would not expect a
> >> 	proposal to go back to embedding credentials in
> >> 	their containing structures to be considered seriously.
> >> 	Nonetheless, it would solve the problem.
> >>  - Add a security blob for the task
> >> 	It is unfortunate that when shared credentials were
> >> 	introduced the task blob was not renamed a cred blob.
> >> 	It would be simple and consistent to add a security
> >> 	blob to the task in addition to the blob in the cred.
> >> 	I would add a t_security field to the task structure
> >> 	that associates security data with the task. This
> >> 	blob would be used for data that does not meet intent
> >> 	of a credential, which I believe may be the case for
> >> 	Jose's PTAGS.
> >>
> >> I know which I would prefer, but as I expect someone to shout
> >> that none can possibly be acceptable I think I'll stop here and
> >> let the discussion go a while.
> >>
> >> ("Light fuse. Stand back. :))
> >>
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

Yes, I appreciate if the task security blob is revived.
According to TOMOYO's security context definition, use of per
task_struct attribute management (i.e. no cred override mechanism)
is correct. Currently I'm using very tricky implementation in AKARI
in order to emulate per task_struct attribute management.
