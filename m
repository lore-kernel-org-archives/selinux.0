Subject: Re: new LSM ver
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0207080720350.19100-100000@raven>
References: <Pine.GSO.4.33.0207080720350.19100-100000@raven>
Content-Type: text/plain; charset=koi8-r
Date: 08 Jul 2002 10:31:52 -0400
Message-Id: <1026138712.1724.23.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Пнд, 08.07.2002, в 07:24, Stephen Smalley написал: 
> 
> On 5 Jul 2002, Timothy Wood wrote:
> 
> > Anyone notice that the default context for root in the new lsm package
> > is a user_r and not sysadm_r?  Any specific reason for this change or is
> > it a mistake?
> 
> This is mentioned in the selinux/ChangeLog, so it is a safe bet that it

Whoops.  I guess I should read those things more often. 

> wasn't a mistake.  As mentioned earlier on the list in discussing the
> recent sshd bugs, I removed direct transitions from sshd_t to sysadm_t
> from the sshd.te file, thus requiring an explicit newrole.  Hence, it was
> only logical to also change the default login context for root to user_r.
> This is also simply safer as a default behavior.

So what is going ot be done about root permissions and such since you
are restricting them now?  I mean there are just some things you have to
be root and have root permissions to run.  Are you rewriting everything
to run based on security context instead of user?  That would be ideal,
no I take that back, that would be awesome if things would run based on
security context of the user running them.  Then you could get rid of
root altogether.  

Anywho (sorry for the rant) a really good/simple example of the new
default context is this.  Lets say you want to add a new user... oh
wait, you can't!  Why?  No one but root can do this and now, not even
root can't do it.  Did a primary service, such as named, bail out for
some reason?  Too bad!  You do not have any way to restart it except by
rebooting the server.  Same reason, root only.

But don't get me wrong.  Getting rid of root is a good idea but it's too
early in the game to make changes like this.  It pretty much breaks the
system in enforcing mode.

Timothy,


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
