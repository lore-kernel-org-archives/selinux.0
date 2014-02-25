Message-ID: <1393359634.8716.40.camel@joe-AO722>
Subject: Re: [PATCH 5/8] security: selinux: Use a more current logging style
From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Feb 2014 12:20:34 -0800
In-Reply-To: <2895078.vC4M4VjvUd@sifl>
References: <cover.1393279025.git.joe@perches.com>
 <637b2f31e31f2b0d7a67131f1db125cc0b2bb829.1393279025.git.joe@perches.com>
 <2895078.vC4M4VjvUd@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-02-25 at 15:05 -0500, Paul Moore wrote:
> On Monday, February 24, 2014 01:59:58 PM Joe Perches wrote:
> > Convert printk to pr_<level>.
> > Add pr_fmt.
> > Coalesce formats, add missing space where appropriate.
> > Standardize on one space after "SELinux: " prefix.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> A few minor comments inline ...
> 
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
[]
> > @@ -13,6 +13,9 @@
> >   *	it under the terms of the GNU General Public License version 2,
> >   *	as published by the Free Software Foundation.
> >   */
> > +
> > +#define pr_fmt(fmt) "SELinux: " KBUILD_MODNAME ": " fmt
> > +
> 
> Wouldn't this result in "SELinux: selinux: ..."?  If not great, if so, let's 
> just specify "avc" the old fashioned way.

Yup, you're right.  Thanks.  I stuffed that one up.

$ strings security/selinux/avc.o | grep "^[0-6]"
4SELinux: selinux: seqno %d < latest_notif %d

I'll send a v2.

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
[]
> > @@ -5976,9 +5958,9 @@ static __init int selinux_init(void)
> >  		panic("SELinux: Unable to register with kernel.\n");
> > 
> >  	if (selinux_enforcing)
> > -		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
> > +		printk(KERN_DEBUG "SELinux: Starting in enforcing mode\n");
> >  	else
> > -		printk(KERN_DEBUG "SELinux:  Starting in permissive mode\n");
> > +		printk(KERN_DEBUG "SELinux: Starting in permissive mode\n");

These printks should/will be converted to pr_debug in a
separate patch.  I didn't want to mix these conversions
with the other pr_<level> ones.
