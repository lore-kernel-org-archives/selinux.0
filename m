Subject: Re: SELinux and access(2), we want to know.
From: Eric Paris <eparis@redhat.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@ZenIV.linux.org.uk,
        sds@tycho.nsa.gov
In-Reply-To: <20090507195729.GA21104@us.ibm.com>
References: <1241723924.2791.107.camel@localhost.localdomain>
	 <20090507195729.GA21104@us.ibm.com>
Content-Type: text/plain
Date: Thu, 07 May 2009 16:57:18 -0400
Message-Id: <1241729838.2791.127.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-05-07 at 14:57 -0500, Serge E. Hallyn wrote:
> Quoting Eric Paris (eparis@redhat.com):
> > 3) I've also heard it hinted that we could do this with audit by just
> > having audit drop the denials that include the access(2) syscall and the
> > scontext and tcontext for the slew of things the SELinux policy writers
> > know we are not interested in.  And while it seems good, now we have
> 
> What is the difference whether an attacker does access(2) to check for
> /etc/shadow rights, or does a failed open()?
> 
> Either you care that someone is poking around, or you don't.  Right?

No, sadly not true.  Sometimes people have a reason to poke....

> > SELinux 'policy' in places other than the policy, harder to distribute,
> > and it requires that everyone who turns on SELinux also turns on syscall
> > auditing with its associated overhead.
> > 
> > Obviously I think the right thing to decide if an LSM wants to send a
> > denial message or not is the LSM.  The only problem I have is that the
> > LSM doesn't know today when it is getting different types or requests
> > and so can't make that decision.
> 
> I think the problem is that you want to guess the intent, and you
> can't do that.  Knowing that a process did access instead of open
> really isn't sufficient.

That's absolutely true.  But, there are cases where we know that
applications are going to go things which selinux is going to deny and
we don't want to tell or warn the user, like for a long time pam would
try to directly open passwd/shadow if it could and would fall back to a
helper if it couldn't.  We wanted to force it to use the helper but we
didn't want tons of denials telling us it did something stupid.  It also
means that we wouldn't get the notification if it tried to do something
wrong, so it's a tradeoff.  Everyone in the SELinux community realizes
this.

In the case I'm describing our only choice is to stop auditing of ALL
attempts by the application to look at the file.  We know that the
application is going to be calling access() but we have to stop auditing
of both access and open, clearly you're not going to say this is a
better situation.

Your suggestion is the equivalent of knowing that your friend John might
look in your window to see if you are home but shouldn't ever try to
kick down the door.  In the current situation you can't tell the
difference between the window and the door so you won't call the police
even if John tries to kick down the door.  When in reality it would be a
lot better to not call the police if John looks in the window even
though you don't know his intent.  He might be looking in the window to
see if you are home and if not he'll try to kick down the door.  But
that situation of not knowing his intent and still not always calling
the policy is a heck of a lot better than NEVER calling the police.  And
I'm glad you see my side of the SELinux argument that this dontaudit
needs to be per domain, not global for all access calls, since knowing
John might look in the window has nothing to do with Jake and we
probably want to call the policy if he does either!

Often the right thing to do here is to fix the application to not
request things it doesn't need, but at least in the case of Nautilus it
needs to learn everything just so it can draw it's icons, not much we
can do about that example.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
