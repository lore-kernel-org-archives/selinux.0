Message-ID: <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>,
 John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric
 Paris <eparis@parisplace.org>, Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Serge E. Hallyn"
 <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@tycho.nsa.gov
Date: Wed, 13 Jun 2018 09:04:19 -0700
In-Reply-To: <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
 <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Subject: Re: [-next PATCH] security: use octal not symbolic
 permissions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
> On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
> > > Joe, in general I really appreciate the fixes you send, but these
> > > patches that cross a lot of subsystem boundaries (this isn't the first
> > > one that does this) causes unnecessary conflicts in -next and during
> > > the merge window.  Could you split your patches up from now on please?
> > 
> > Sorry. No.  Merge conflicts are inherent in this system.
> 
> Yes, merge conflicts are inherent in this system when one makes a
> single change which impacts multiple subsystems, e.g. changing a core
> kernel function which is called by multiple subsystems.  However, that
> isn't what this patch does, it makes a number of self-contained
> changes across multiple subsystems; there are no cross-subsystem
> dependencies in this patch.  You are increasing the likelihood of
> conflicts for no good reason; that is why I'm asking you to split this
> patch and others like it.

No.  History shows with high certainty that splitting
patches like this across multiple subsystems of a primary
subsystem means that the entire patchset is not completely
applied.

It's _much_ simpler and provides a generic mechanism to
get the entire patch applied to send a single patch to the
top level subsystem maintainer.
