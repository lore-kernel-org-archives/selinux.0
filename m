Subject: Re: new LSM ver
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0207081029490.19100-100000@raven>
References: <Pine.GSO.4.33.0207081029490.19100-100000@raven>
Content-Type: text/plain; charset=koi8-r
Date: 08 Jul 2002 11:19:55 -0400
Message-Id: <1026141595.1724.71.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Пнд, 08.07.2002, в 10:39, Stephen Smalley написал:
> 
> On 8 Jul 2002, Timothy Wood wrote:
> 
> > So what is going ot be done about root permissions and such since you
> > are restricting them now?  I mean there are just some things you have to
> > be root and have root permissions to run.  Are you rewriting everything
> > to run based on security context instead of user?  That would be ideal,
> > no I take that back, that would be awesome if things would run based on
> > security context of the user running them.  Then you could get rid of
> > root altogether.
> >
> > Anywho (sorry for the rant) a really good/simple example of the new
> > default context is this.  Lets say you want to add a new user... oh
> > wait, you can't!  Why?  No one but root can do this and now, not even
> > root can't do it.  Did a primary service, such as named, bail out for
> > some reason?  Too bad!  You do not have any way to restart it except by
> > rebooting the server.  Same reason, root only.
> >
> > But don't get me wrong.  Getting rid of root is a good idea but it's too
> > early in the game to make changes like this.  It pretty much breaks the
> > system in enforcing mode.
> 
> I think you've misunderstood what we've done.  We have merely changed the
> default login context for root to the user_r role, and prohibited direct
> ssh logins in the sysadm_r role.  For administration, you can still login
> as yourself, run newrole to change to sysadm_r, and run su to obtain the
> Linux root user identity.  Or, you can login as root if you permit direct
> root logins and then run newrole to change to sysadm_r.
> 
> The change simply ensures that a vulnerability in sshd does not open a
> direct path to sysadm_r.  The attacker will not be able to reach sysadm_r
> without authenticating to newrole.

This is true.  You can also merely change the context when you login (if
you log in as root).  I suppose I jumpped the gun a little there,
however I do like the idea of severely restricting root or removing root
altogether.  Would I be correct in that pretty much everything would
have to be rewritten if this were to be accomplished (the removal of
root, that is)?

Timothy,



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
