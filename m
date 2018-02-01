Message-ID: <1517504530.1750.55.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Salyzyn <salyzyn@android.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Paul Moore <paul@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, stable
 <stable@vger.kernel.org>, James Morris <jmorris@namei.org>
Date: Thu, 01 Feb 2018 12:02:10 -0500
In-Reply-To: <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
References: <20180201153708.63506-1-salyzyn@android.com>
 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
 <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-02-01 at 08:20 -0800, Mark Salyzyn wrote:
> On 02/01/2018 08:00 AM, Paul Moore wrote:
> > On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com>
> > wrote:
> > > In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE
> > > socket
> > > flag") and all the associated infrastructure changes to take
> > > advantage
> > > of a RCU grace period before freeing, there is a heightened
> > > possibility that a security check is performed while an ill-timed
> > > setsockopt call races in from user space.  It then is prudent to
> > > null
> > > check sk_security, and if the case, reject the permissions.
> > > 
> > > . . .
> > > ---[ end trace 7b5aaf788fef6174 ]---
> > > 
> > > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > > Signed-off-by: Paul Moore <paul@linuxfoundation.org>
> > 
> > No, in the previous thread I gave my ack, not my sign-off; please
> > be
> > more careful in the future.  It may seem silly, especially in this
> > particular case, but it is an important distinction when things
> > like
> > the DCO are concerned.
> > 
> > Anyway, here is my ack again.
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > 
> 
> Ok, both Greg KH and yours should be considered Acked-By. Been 
> overstepping this boundary for _years_. AFAIK Signed-off-by is still 
> pending from Stephen Smalley <sds@tycho.nsa.gov> before this can roll
> in.
> 
> Lesson lurned

No, Paul's Acked-by is sufficient, and at most, I would only add
another Acked-by or Reviewed-by, not a Signed-off-by.  Signed-off-by is
only needed when one had something to do with the writing of the patch
or was in the path by which it was merged.

I don't object to this patch but I have a hard time adding another ack
because I don't truly understand the root cause or how this fixes it. 
Let's say sk_prot_free() calls security_sk_free() calls
selinux_sk_free_security() which sets sk->sk_security to NULL, and then
we proceed to free the sksec and then sk_prot_free() frees the sk
itself.  Now another sock is allocated (or perhaps a different object
altogether), reuses that memory, and whatever sk->sk_security happens
to contain is set to non-NULL.  We'll just blithely proceed past your
check and who knows what will happen from that point onward.
