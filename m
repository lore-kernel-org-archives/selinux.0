Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m02EmAOB026482
	for <selinux@tycho.nsa.gov>; Wed, 2 Jan 2008 09:48:10 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m02Em8Zq007515
	for <selinux@tycho.nsa.gov>; Wed, 2 Jan 2008 14:48:09 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2649172fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 02 Jan 2008 06:48:08 -0800 (PST)
Message-ID: <cadfc0e40801020648o4bb523dn6b9c4ea6fdbd2f07@mail.gmail.com>
Date: Wed, 2 Jan 2008 08:48:08 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Reed, Tim (US SSA)" <tim.reed@baesystems.com>
Subject: Re: newrole in the background
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <436A69503F99214D9EBC27415F66C40C0F6AA4EA@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
	 <436A69503F99214D9EBC27415F66C40C0F597703@blums0008.bluelnk.net>
	 <1197567614.20226.141.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F597E63@blums0008.bluelnk.net>
	 <1197907810.17307.38.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F59812B@blums0008.bluelnk.net>
	 <1198252853.2944.40.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40712210831p29ed2ab1mf3765448cc7ab1c4@mail.gmail.com>
	 <1198257133.2944.71.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F6AA4EA@blums0008.bluelnk.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The arg thing is curious because I use newrole extensively and have
had no issue passing args.

On Dec 31, 2007 9:49 AM, Reed, Tim (US SSA) <tim.reed@baesystems.com> wrote:
> I know you already applied this to the trunk, but here is another patch.
>
>
> I cleaned up the handling of the -c argument.  Instead of messing with
> the argv that is passed in, I have it use a temp variable.  Plus if the
> command that the user wants to run has command line args of its own (ls
> -lrt /tmp), I push those into one value in the command line array.  I
> was having issues with the new shell that gets spawned off dropping the
> command's arguments that I was trying to pass it.  So I would get an
> "ls" instead of "ls -lrt /tmp".  No quoting it did not work, as our
> application passes a string as an argument to the command.
>
> BTW which is the correct version to be working on 1.34.11 or 2.0.27?
>
> Thanks!
> Tim
>
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, December 21, 2007 12:12 PM
> To: Xavier Toth
> Cc: Reed, Tim (US SSA); SE Linux
>
> Subject: Re: newrole in the background
>
>
> On Fri, 2007-12-21 at 10:31 -0600, Xavier Toth wrote:
> > Works for me, thanks.
>
> Ok, merged to trunk version of newrole.
>
> As usual, if you want something like this in an existing distro release
> (e.g. RHEL5), you'll have to bugzilla it there and get it queued for an
> update.
>
> >
> > On Dec 21, 2007 10:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >
> > > On Mon, 2007-12-17 at 12:40 -0800, Reed, Tim (US SSA) wrote:
> > > > Lets try this again....Patch Try #3
> > >
> > > This looks ok to me, although it doesn't apply cleanly on the trunk,
> and
> > > the coding style still needs fixing (but I suppose make indent will
> fix
> > > it up).
> > >
> > > Does anyone else have any comments on this?  Does it meet Ted's need
> > > too?
> > >
> > > I tried running a program that detached the tty and then invoked the
> > > patched newrole with a command, and as expected, if configured to
> use
> > > pam modules that required authentication, it just failed at that
> point
> > > with an authentication failed error, and otherwise, it proceeded
> without
> > > problem.
> > >
> > >
> > > > -----Original Message-----
> > > > From: owner-selinux@tycho.nsa.gov
> [mailto:owner-selinux@tycho.nsa.gov]
> > > > On Behalf Of Stephen Smalley
> > > > Sent: Monday, December 17, 2007 11:10 AM
> > > > To: Reed, Tim (US SSA)
> > > > Cc: Xavier Toth; SE Linux
> > > > Subject: RE: newrole in the background
> > > >
> > > > On Mon, 2007-12-17 at 08:01 -0800, Reed, Tim (US SSA) wrote:
> > > > > When newrole goes and grabs the ttyname, if it cannot get one
> should
> > > > it
> > > > > still log something to the screen or not?
> > > > >
> > > > > Currently it says "Error! Could not retrieve tty information".
> I was
> > > > > thinking of changing Error to Warning.
> > > >
> > > > Yes, that's fine.
> > > > >
> > > > > What is the recommendation here?
> > > > > Also do you have the coding standards posted somewhere?
> > > >
> > > > We just loosely follow kernel coding style,
> > > > http://lxr.linux.no/linux/Documentation/CodingStyle
> > > > and make indent can be used as a hammer (but not a very good one).
> > > >
> > > > >
> > > > > -----Original Message-----
> > > > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > > > > Sent: Thursday, December 13, 2007 12:40 PM
> > > > > To: Reed, Tim (US SSA)
> > > > > Cc: Xavier Toth; SE Linux
> > > > > Subject: RE: newrole in the background
> > > > >
> > > > > On Thu, 2007-12-13 at 09:06 -0800, Reed, Tim (US SSA) wrote:
> > > > > > New patch...I have added checks around the calls that deal
> with the
> > > > > tty.
> > > > > > So if ttyn is an empty string (something had a heartache with
> it
> > > > being
> > > > > > NULL) then it skips the processing.  It does appear to work
> but more
> > > > > > testing is needed.  Please review and comment.
> > > > >
> > > > > Patch is reversed, and doesn't seem to be complete (test for a
> NULL
> > > > > ttyname still remains and is fatal in main).
> > > > >
> > > > > ttyn should really be NULL if not defined - just fix the code.
> > > > Cleaner
> > > > > and faster to test for NULL than for empty string.  Looks like
> > > > > authenticate_via_pam() needs a check.
> > > > >
> > > > > You can simplify the logic a fair amount, e.g. on entry to
> > > > relabel_tty()
> > > > > and restore_tty_label(), just do a if (!ttyn) return 0;
> > > > >
> > > > > Coding style doesn't match.
> > > > >
> > > > > > Now say if someone ran `newrole -l SystemHigh -- -c "su -
> foo"` in
> > > > the
> > > > > > background of a script, you would not be able to give su input
> as it
> > > > > is
> > > > > > in the background and has no tty.  su in this case exits
> gracefully
> > > > I
> > > > > > guess you could say.
> > > > > >
> > > > > > My point is that if you have an application that needs to run
> from
> > > > > > newrole, in the background AND requires user input, you will
> not be
> > > > > able
> > > > > > to give the application input while it is in the background
> and have
> > > > > it
> > > > > > work successfully.
> > > > >
> > > > > You can't do that anyway, by definition.
> > > > >
> > > > > > Example:
> > > > > > foo.sh
> > > > > > ---------------
> > > > > > #!/bin/bash
> > > > > >
> > > > > > ./bar.sh &
> > > > > > ---------------
> > > > > > bar.sh
> > > > > > ---------------
> > > > > > #!/bin/bash
> > > > > >
> > > > > > su - root -c /bin/date
> > > > > > ---------------
> > > > > >
> > > > > > su exits because there is no tty for input.  So is chasing
> down
> > > > having
> > > > > > newrole run in a pseudo tty in the background and accept input
> worth
> > > > > the
> > > > > > time?
> > > > >
> > > > > It doesn't help - there is no input to accept.
> > > > >
> > > > > We just need to make sure that the pam modules and chkpwd don't
> block
> > > > > forever or seg fault when handed a NULL PAM_TTY.
> > > > >
> > > --
> > > Stephen Smalley
> > > National Security Agency
> > >
> > >
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
