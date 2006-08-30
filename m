Subject: Re: [PATCH] newrole: use pam session management services -v3
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: sgrubb@redhat.com, klaus@atsec.com, chanson@TrustedCS.com,
        kmacmillan@redhat.com, dwalsh@redhat.com, ltcgcw@us.ibm.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1156937933.22210.252.camel@moss-spartans.epoch.ncsc.mil>
References: <1156731269.25806.3.camel@localhost.localdomain>
	 <1156885700.22210.238.camel@moss-spartans.epoch.ncsc.mil>
	 <1156937933.22210.252.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 13:38:08 -0400
Message-Id: <1156959489.20813.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-30 at 07:38 -0400, Stephen Smalley wrote:
> On Tue, 2006-08-29 at 17:08 -0400, Stephen Smalley wrote:
> > On Sun, 2006-08-27 at 22:14 -0400, Janak Desai wrote:
> > > This patch updates newrole to allow it to use pam session mangement
> > > services. Currently newrole only uses the authenticaion services of
> > > pam. Session management services are needed to allow pam_namespace
> > > to appropriately reconfigure polyinstantiated namespace for the
> > > new session being established with nerole.
> > > 
> > > Changes since v2 of this patch, posted on 8/16/06:
> > >     1. Restructured to use pam_start and pam_end only once
> > >     2. Updated to use pam_open_session and pam_close_session appropriately
> > >     3. Removed system-auth and pam_xauth session services from newrole.pamd.
> > >        These were not used since newrole did not have session management
> > >        support, and could result in unintended behavior now that session
> > >        management support is enabled with this patch.
> > >     4. Forward ported to the latest selinux subversion tree (version 2000)
> > >        on sourceforge. 
> > > 
> > > Signed-off-by: Janak Desai <janak@us.ibm.com>
> > > 
> > > ---
> > > 
> > >  newrole.c    |   95 +++++++++++++++++++++++++++++++++++------------------------
> > >  newrole.pamd |    2 -
> > >  2 files changed, 57 insertions(+), 40 deletions(-)
> > 
> > You didn't introduce this, but it appears that newrole no longer builds
> > properly with make LOG_AUDIT_PRIV=y (duplicate _GNU_SOURCE definitions)
> > when building on rawhide.  Aren't you encountering this?
> 
> Actually, on further thought, I don't understand how newrole can work
> with pam_namespace without further changes.  If you build newrole
> without LOG_AUDIT_PRIV=y, then it is non-suid and will lack the
> necessary capability to mount (which sadly is CAP_SYS_ADMIN, the gateway
> to all power).  If you build newrole with LOG_AUDIT_PRIV=y, then it is
> suid but drops all capabilities except for CAP_AUDIT_WRITE upon startup.
> So if you are running newrole as any non-root user, pam_namespace
> shouldn't be able to mount.  To do so, it would need to retain
> CAP_SYS_ADMIN all the way up until the point it calls pam_open_session,
> at which point the entire code needs much tighter review.  Am I missing
> something?
> 

No you are not. I just checked my build environment. I was using fedora
policycoreutils-1.30.26 which was built without LOG_AUDIT_PRIV. I think
I had just used rpmbuild --recompile, but I am not 100% sure. The 
makefile turns off LOG_AUDIT_PRIV. For my unit tests I am copying the
binary manually and making it suid because I wanted to keep my 
/etc/pam.d/newrole file. 

What is best way to proceed from here? I haven't played with
capability manipulation but is it possible to drop syadmin from
effective but not from permitted and raise it again just before
pam_open_session? 



> > > @@ -797,6 +794,18 @@ int main(int argc, char *argv[])
> > >  			rc = wait(NULL);
> > >  		} while (rc < 0 && errno == EINTR);
> > >  
> > > +#ifdef USE_PAM
> > > +		rc = pam_close_session(pam_handle,0);
> > > +		if(rc != PAM_SUCCESS) {
> > > +			fprintf(stderr, "pam_close_session failed\n");
> > > +			pam_end(pam_handle, rc);
> > > +			exit(-1);
> > > +		}
> > 
> > Hmm...so a pam_close_session failure bails before we restore the tty
> > label?  Possibly the error message should include the pam_strerror()
> > string as well?
> > 

ok. I will move the pam_close_session() call after the tty
context is restored and just before the parent exits.

> > > +
> > > +		/* We're done with PAM.  Free `pam_handle'. */
> > > +		pam_end(pam_handle, rc);
> > > +#endif
> > > +
> > >  		if (!new_tty_context || !tty_context)
> > >  			exit(0);
> > >  
> > > @@ -900,6 +909,16 @@ int main(int argc, char *argv[])
> > >  	}
> > >  #endif
> > >  	freecon(old_context);
> > > +
> > > +#ifdef USE_PAM
> > > +	/* Ask PAM to setup session for user running this program */
> > > +	rc = pam_open_session(pam_handle,0);
> > > +	if(rc != PAM_SUCCESS) {
> > > +		fprintf(stderr, _("Namespace setup failed.\n"));
> > > +		exit(-1);
> > > +	}
> > > +#endif
> > 
> > I understand that you need this to happen after the setexeccon, but do
> > you really want it to happen after the audit message has already been
> > generated?  The error message also should likely be both more general
> > (since you only know that pam_open_session failed, not that it was
> > specifically namespace related) and more specific (including
> > pam_strerror result).
> > 

ok. I will move pam_open_session to just after setexeccon() and update
the message appropriately. 

> > > +
> > >  	execv(pw->pw_shell, argv + optind - 1);
> > >  
> > >  	/* If we reach here, then we failed to exec the new shell. */
> > > diff -Naurp policycoreutils/newrole/newrole.pamd policycoreutils+newrolepatch/newrole/newrole.pamd
> > > --- policycoreutils/newrole/newrole.pamd	2006-08-27 21:22:13.000000000 +0000
> > > +++ policycoreutils+newrolepatch/newrole/newrole.pamd	2006-08-27 21:22:56.000000000 +0000
> > > @@ -2,5 +2,3 @@
> > >  auth       include	system-auth
> > >  account    include	system-auth
> > >  password   include	system-auth
> > > -session    include	system-auth
> > > -session    optional	pam_xauth.so
> > 
> > Unfortunately, this seems to yield a non-working newrole, as
> > pam_open_session() then always fails due to the absence of any session
> > modules.  What is the graceful way of handling this?
> > 

hmm. Not sure. Would it work to keep pam_namespace in here?
The /etc/security/namespace.conf file is installed by default
with no polyinstantiation so those that do not care to 
polyinstantiate any directories will still see the expected
behavior from their system. 

-Janak


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
