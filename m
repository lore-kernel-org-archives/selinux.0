Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLGVv55031669
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 11:31:57 -0500
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLGVuF8020419
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 16:31:56 GMT
Received: by fg-out-1718.google.com with SMTP id 16so167777fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 08:31:44 -0800 (PST)
Message-ID: <cadfc0e40712210831p29ed2ab1mf3765448cc7ab1c4@mail.gmail.com>
Date: Fri, 21 Dec 2007 10:31:44 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: newrole in the background
Cc: "Reed, Tim (US SSA)" <tim.reed@baesystems.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1198252853.2944.40.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
	 <1197555910.20226.8.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40712130641r301dd959x895f33ff1e72f581@mail.gmail.com>
	 <1197558486.20226.40.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F597703@blums0008.bluelnk.net>
	 <1197567614.20226.141.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F597E63@blums0008.bluelnk.net>
	 <1197907810.17307.38.camel@moss-spartans.epoch.ncsc.mil>
	 <436A69503F99214D9EBC27415F66C40C0F59812B@blums0008.bluelnk.net>
	 <1198252853.2944.40.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Works for me, thanks.

On Dec 21, 2007 10:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Mon, 2007-12-17 at 12:40 -0800, Reed, Tim (US SSA) wrote:
> > Lets try this again....Patch Try #3
>
> This looks ok to me, although it doesn't apply cleanly on the trunk, and
> the coding style still needs fixing (but I suppose make indent will fix
> it up).
>
> Does anyone else have any comments on this?  Does it meet Ted's need
> too?
>
> I tried running a program that detached the tty and then invoked the
> patched newrole with a command, and as expected, if configured to use
> pam modules that required authentication, it just failed at that point
> with an authentication failed error, and otherwise, it proceeded without
> problem.
>
>
> > -----Original Message-----
> > From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> > On Behalf Of Stephen Smalley
> > Sent: Monday, December 17, 2007 11:10 AM
> > To: Reed, Tim (US SSA)
> > Cc: Xavier Toth; SE Linux
> > Subject: RE: newrole in the background
> >
> > On Mon, 2007-12-17 at 08:01 -0800, Reed, Tim (US SSA) wrote:
> > > When newrole goes and grabs the ttyname, if it cannot get one should
> > it
> > > still log something to the screen or not?
> > >
> > > Currently it says "Error! Could not retrieve tty information".  I was
> > > thinking of changing Error to Warning.
> >
> > Yes, that's fine.
> > >
> > > What is the recommendation here?
> > > Also do you have the coding standards posted somewhere?
> >
> > We just loosely follow kernel coding style,
> > http://lxr.linux.no/linux/Documentation/CodingStyle
> > and make indent can be used as a hammer (but not a very good one).
> >
> > >
> > > -----Original Message-----
> > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > > Sent: Thursday, December 13, 2007 12:40 PM
> > > To: Reed, Tim (US SSA)
> > > Cc: Xavier Toth; SE Linux
> > > Subject: RE: newrole in the background
> > >
> > > On Thu, 2007-12-13 at 09:06 -0800, Reed, Tim (US SSA) wrote:
> > > > New patch...I have added checks around the calls that deal with the
> > > tty.
> > > > So if ttyn is an empty string (something had a heartache with it
> > being
> > > > NULL) then it skips the processing.  It does appear to work but more
> > > > testing is needed.  Please review and comment.
> > >
> > > Patch is reversed, and doesn't seem to be complete (test for a NULL
> > > ttyname still remains and is fatal in main).
> > >
> > > ttyn should really be NULL if not defined - just fix the code.
> > Cleaner
> > > and faster to test for NULL than for empty string.  Looks like
> > > authenticate_via_pam() needs a check.
> > >
> > > You can simplify the logic a fair amount, e.g. on entry to
> > relabel_tty()
> > > and restore_tty_label(), just do a if (!ttyn) return 0;
> > >
> > > Coding style doesn't match.
> > >
> > > > Now say if someone ran `newrole -l SystemHigh -- -c "su - foo"` in
> > the
> > > > background of a script, you would not be able to give su input as it
> > > is
> > > > in the background and has no tty.  su in this case exits gracefully
> > I
> > > > guess you could say.
> > > >
> > > > My point is that if you have an application that needs to run from
> > > > newrole, in the background AND requires user input, you will not be
> > > able
> > > > to give the application input while it is in the background and have
> > > it
> > > > work successfully.
> > >
> > > You can't do that anyway, by definition.
> > >
> > > > Example:
> > > > foo.sh
> > > > ---------------
> > > > #!/bin/bash
> > > >
> > > > ./bar.sh &
> > > > ---------------
> > > > bar.sh
> > > > ---------------
> > > > #!/bin/bash
> > > >
> > > > su - root -c /bin/date
> > > > ---------------
> > > >
> > > > su exits because there is no tty for input.  So is chasing down
> > having
> > > > newrole run in a pseudo tty in the background and accept input worth
> > > the
> > > > time?
> > >
> > > It doesn't help - there is no input to accept.
> > >
> > > We just need to make sure that the pam modules and chkpwd don't block
> > > forever or seg fault when handed a NULL PAM_TTY.
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
