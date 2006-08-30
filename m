Subject: Re: [PATCH] newrole: use pam session management services -v3
From: Stephen Smalley <sds@tycho.nsa.gov>
To: janak@us.ibm.com
Cc: sgrubb@redhat.com, klaus@atsec.com, chanson@TrustedCS.com,
        kmacmillan@redhat.com, dwalsh@redhat.com, ltcgcw@us.ibm.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1156959489.20813.33.camel@localhost.localdomain>
References: <1156731269.25806.3.camel@localhost.localdomain>
	 <1156885700.22210.238.camel@moss-spartans.epoch.ncsc.mil>
	 <1156937933.22210.252.camel@moss-spartans.epoch.ncsc.mil>
	 <1156959489.20813.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 14:57:59 -0400
Message-Id: <1156964279.22210.368.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-30 at 13:38 -0400, Janak Desai wrote:
> On Wed, 2006-08-30 at 07:38 -0400, Stephen Smalley wrote:
> > On Tue, 2006-08-29 at 17:08 -0400, Stephen Smalley wrote:
> > > On Sun, 2006-08-27 at 22:14 -0400, Janak Desai wrote:
> > > > This patch updates newrole to allow it to use pam session mangement
> > > > services. Currently newrole only uses the authenticaion services of
> > > > pam. Session management services are needed to allow pam_namespace
> > > > to appropriately reconfigure polyinstantiated namespace for the
> > > > new session being established with nerole.
> > > > 
> > > > Changes since v2 of this patch, posted on 8/16/06:
> > > >     1. Restructured to use pam_start and pam_end only once
> > > >     2. Updated to use pam_open_session and pam_close_session appropriately
> > > >     3. Removed system-auth and pam_xauth session services from newrole.pamd.
> > > >        These were not used since newrole did not have session management
> > > >        support, and could result in unintended behavior now that session
> > > >        management support is enabled with this patch.
> > > >     4. Forward ported to the latest selinux subversion tree (version 2000)
> > > >        on sourceforge. 
> > > > 
> > > > Signed-off-by: Janak Desai <janak@us.ibm.com>
> > > > 
> > > > ---
> > > > 
> > > >  newrole.c    |   95 +++++++++++++++++++++++++++++++++++------------------------
> > > >  newrole.pamd |    2 -
> > > >  2 files changed, 57 insertions(+), 40 deletions(-)
> > > 
> > > You didn't introduce this, but it appears that newrole no longer builds
> > > properly with make LOG_AUDIT_PRIV=y (duplicate _GNU_SOURCE definitions)
> > > when building on rawhide.  Aren't you encountering this?
> > 
> > Actually, on further thought, I don't understand how newrole can work
> > with pam_namespace without further changes.  If you build newrole
> > without LOG_AUDIT_PRIV=y, then it is non-suid and will lack the
> > necessary capability to mount (which sadly is CAP_SYS_ADMIN, the gateway
> > to all power).  If you build newrole with LOG_AUDIT_PRIV=y, then it is
> > suid but drops all capabilities except for CAP_AUDIT_WRITE upon startup.
> > So if you are running newrole as any non-root user, pam_namespace
> > shouldn't be able to mount.  To do so, it would need to retain
> > CAP_SYS_ADMIN all the way up until the point it calls pam_open_session,
> > at which point the entire code needs much tighter review.  Am I missing
> > something?
> > 
> 
> No you are not. I just checked my build environment. I was using fedora
> policycoreutils-1.30.26 which was built without LOG_AUDIT_PRIV. I think
> I had just used rpmbuild --recompile, but I am not 100% sure. The 
> makefile turns off LOG_AUDIT_PRIV. For my unit tests I am copying the
> binary manually and making it suid because I wanted to keep my 
> /etc/pam.d/newrole file.

Hmmm...AFAICS, that rpm does build with LOG_AUDIT_PRIV (=y), and
installing it does yield a suid newrole binary that drops all caps
except CAP_AUDIT_WRITE when executed unless the caller is root already.
So you must have disabled LOG_AUDIT_PRIV yourself, or only tested it as
a root user (make sure you test as both root and non-root, as there is a
difference there).

> What is best way to proceed from here? I haven't played with
> capability manipulation but is it possible to drop syadmin from
> effective but not from permitted and raise it again just before
> pam_open_session?

That appears to be possible.  It isn't a very strong guarantee though.

There is also the question of when newrole should retain that
capability, since the newrole code itself doesn't directly use it ever.
Ideally, newrole would only retain it if pam_namespace is actually
present in the pam config.  Possibly we should have two separate
newrole.pamd files, one installed by default w/o pam_namespace and one
installed if LOG_AUDIT_PRIV=y that includes pam_namespace, and then you
make your code changes conditional on LOG_AUDIT_PRIV as well.  Likely
should rename LOG_AUDIT_PRIV at that point to something more general,
like LSPP_PRIV, to connote the fact that it is needed for LSPP
functionality (both audit and namespace) and that it requires extra
privileges for newrole.

You'd also need a policy change for newrole, or handle that via a
loadable policy module.

> > > > diff -Naurp policycoreutils/newrole/newrole.pamd policycoreutils+newrolepatch/newrole/newrole.pamd
> > > > --- policycoreutils/newrole/newrole.pamd	2006-08-27 21:22:13.000000000 +0000
> > > > +++ policycoreutils+newrolepatch/newrole/newrole.pamd	2006-08-27 21:22:56.000000000 +0000
> > > > @@ -2,5 +2,3 @@
> > > >  auth       include	system-auth
> > > >  account    include	system-auth
> > > >  password   include	system-auth
> > > > -session    include	system-auth
> > > > -session    optional	pam_xauth.so
> > > 
> > > Unfortunately, this seems to yield a non-working newrole, as
> > > pam_open_session() then always fails due to the absence of any session
> > > modules.  What is the graceful way of handling this?
> > > 
> 
> hmm. Not sure. Would it work to keep pam_namespace in here?
> The /etc/security/namespace.conf file is installed by default
> with no polyinstantiation so those that do not care to 
> polyinstantiate any directories will still see the expected
> behavior from their system. 

The problem is that not everyone has pam_namespace (at least outside of
Fedora), and I assume that newrole would likewise fail fatally upon
pam_open_session if we put pam_namespace as the only session module and
it isn't present on the system.  But if we have two separate pam configs
as above, then that would likely work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
