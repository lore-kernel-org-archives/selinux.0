Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CFbG70031310
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 11:37:16 -0400
Received: from web36603.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9CFaaPm018945
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 15:36:36 GMT
Message-ID: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
Date: Thu, 12 Oct 2006 08:37:01 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: MLS enforcing PTYs, sshd, and newrole
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <200610122025.15043.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:

> On Thursday 12 October 2006 17:33, Klaus Weidner
> <klaus@atsec.com> wrote:
> > If you need local console (or serial) login at
> different MLS levels for
> > the same user, you can create multiple Linux users
> for each human user
> > that share the same uid and home directory, and
> use "semanage login" to
> > map them to appropriate levels. So you'd have
> smith_secret_cat1,
> > smith_unclassified and so on.

The Unix MLS systems provide mechanism
in login to specify MAC the user label.

In Trix 6 I would use:

    login: casey MAC=appropriatevalue
    passwd: ....

In Trix 4 it was:

    login: casey
    label: appropriatevalue
    passwd: ...

In Solaris I *think* it would be:

    login: casey -l appropriatevalue
    passwd: ...

but rust could well have filled that part
of my memory.

Creating a seperate login name for each MLS
value would be fine if you have a small number
of users with a small number of labels, but
will not be competitive in a production
environment.

> That doesn't work well with password expiry
> policies.  Having 
> smith_secret_cat1 password expire at different times
> to smith_unclassified 
> would be a pain for users and sys-admins.

That too.

> Then if you want to use RSA SecurID or similar
> tokens you have an extra level 
> of pain in mapping them to the right Unix account
> names.
> 
> I think that the right solution is to re-enable the
> code for selecting the 
> role etc at login time and adding some code for
> selecting the level.  It 
> should not be difficult to do this if there are no
> plans to ever support it 
> for ssh or X logins.
> 
> > It should still work to put a multilevel X desktop
> on top of this, since
> > that presumably uses a mechanism other than
> "newrole" to launch terminals
> > or windows at different levels. But that's only
> guesswork due to not
> > having seen any code for this...
> 
> Can someone who has worked on one of these things
> before please comment on how 
> it's done?

Hee Hee Hee. On Trix you get a new window at
a different label using su -M:

    trix% su -M moresecret -c xterm &
    trix% su -M evenmoresecret -c xclock &

This works because "su -M" closes all open
fds, reopening std{in,out,err} on /dev/null,
and the X server is MLS aware, accepting
connections with any label the user is cleared
for and enforcing policy on the objects it
controls. The X server uses TSIG interfaces
to obtain MLS information about the far end
of the connections ...

> It seems to me that the current way of managing
> desktops isn't going to work 
> (IE Gnome and KDE won't work).

... and the window manager is also MLS aware.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
