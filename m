Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5FG5fmS024391
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 12:05:41 -0400
Received: from web36610.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5FG5doK012649
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 16:05:39 GMT
Date: Fri, 15 Jun 2007 09:05:39 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1181921232.17547.775.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <472431.76522.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2007-06-15 at 08:14 -0700, Casey Schaufler wrote:
> > --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > > Second RFC on this patch, collects up discussion and changes so far.  If
> > > no objections, then this will be re-posted as just a [PATCH] on selinux
> > > and lkml.
> > > 
> > > ---
> > > 
> > > Extend SELinux to allow capabilities to be granted authoritatively
> > > based solely on SELinux policy, enabling users of SELinux to
> > > selectively reduce or fully eliminate the need for a "root" user and
> > > setuid executables.  This provides an alternative approach to file
> > > capabilities without conflicting with it.
> > 
> > Why don't you just work with the people who are getting the
> > file capabilities working and integrate that into SELinux?
> > Why do you have to take this tangent and confuse everything?
> > 
> > There. An objection. I do not believe you've demonstrated that
> > using the proposed file capabilities can't get you what you
> > want, and that we don't need two implementations of the same
> > thing.
> 
> I don't think you've taken the time to read and understand the
> description or the code, or you might realize that your characterization
> above is false.

I have read and understand the description and have examined the
code, although I confess that it is the intent that I object to,
not the implementation of that intent. It's a fine implementation
of the description.

> I did provide feedback to Serge on the file capabilities support as it
> was being developed.  It will work with SELinux, with or without this
> change.  But it doesn't solve the same problem.  Read it again.  Please.
> And Serge, who authored the file capability support, understands that,
> and appears to like our patch from his comments on list.  So there is no
> conflict between us and the "file capabilities" people, only between us
> and people who don't bother to take the time to understand what they are
> commenting on...

Yeah, and the horse you rode in on.

Look, you're always badgering people to explain why their LSM
facilities can't be done using SELinux, or a tweek to SELinux.
When you take this to LKML expect to get exactly the same question
(as I posed here) about why SELinux "can't just use" the file
capabilities. In all your whinging about me above you never answered
the question. I understand your design goals, and given your
design goals I completely understand why you would want to do it
the way you've outlined.

My concern is with the future of file capabilities, which I like.
I would like to see them move forward for my own nefarious purposes.
Those purposes do not require the sophistication of SELinux, so
I do not want to see the advance of file capabilities run up
against the "SELinux does that, ''just'' use SELinux" argument
every time someone wants to improve it. It gets tiresome and
consumes way to much of the limited time I have to work on projects.

So please explain, so that even an MLS junkie like me can understand,
why you can't "just" use the file capability machanism as it's
designed. I read what you wrote. I read the code. Humor me and
answer the question if you'd be so kind. I'm sure that you have
a good reason and sufficient understanding of all the surrounding
issues to make it clear.

Thank you.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
