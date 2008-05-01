Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <183965.2243.qm@web36606.mail.mud.yahoo.com>
References: <183965.2243.qm@web36606.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 01 May 2008 06:37:42 -0400
Message-Id: <1209638262.25678.393.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-30 at 14:51 -0700, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > As discussed in:
> > http://marc.info/?t=120837952900003&r=1&w=2
> > the ability to permit package managers and similar programs to set down
> > unknown file contexts is still desired/required, not only for putting
> > policy modules in packages but also for enabling build systems to create
> > images of different distro releases with different policies w/o
> > requiring all of the types to be defined in the build host policy.
> > 
> > This is an updated form of the patch originally posted in:
> > http://marc.info/?l=selinux&m=114771094617968&w=2
> > 
> > The only significant change to the patch aside from re-basing is that
> > rather than introducing a labelpriv permission in the security class to
> > control the new operation, I chose to use a class/permission that is not
> > already allowed for unconfined domains so that unconfined user shells
> > won't get this permission by default.  I was going to add a new class
> > and permission but then realized that the mac_override capability check
> > seemed to fit well conceptually and since it falls in the new
> > capability2 class, it is not allowed to any existing domains in policy.
> > Further, by making this a capable() check rather than only a SELinux
> > permission check, the ability to set unknown file contexts is still
> > limited to superuser (or at least CAP_MAC_OVERRIDE)
> 
> I think you should be using CAP_MAC_ADMIN as you are explictly
> setting the attribute. CAP_MAC_OVERRIDE is for violations of
> normal policy, whereas this appears more like an administrative
> action.

Ok, I'll include that change in the next version of the patch (if there
is one).  Thanks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
