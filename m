Subject: RE: Denials from newest kernel
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
	 <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:44:23 -0400
Message-Id: <1160149463.2905.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 11:21 -0400, Stephen Smalley wrote:
> On Fri, 2006-10-06 at 11:11 -0400, Venkat Yekkirala wrote:
> > Joshua Brindle wrote:
> > > On Fri, 2006-10-06 at 10:23 -0400, Venkat Yekkirala wrote:
> > > > > -----Original Message-----
> > > > > From: Joshua Brindle [mailto:jbrindle@tresys.com]
> > > > > Sent: Friday, October 06, 2006 8:56 AM
> > > > I would have to refer you to the following discussion we had on how
> > > > secpoint err secmark is intended to be used thru to deciding not to
> > > > mess with the naming.
> > > > http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2
> > > 
> > > That peer conversation was bin/null'd though,
> > 
> > Stephen and others can correct me if I am wrong, but while
> > the naming was bin/null'd AFTER the con call, the policy was
> > going to be done substantially as related in the peer conversation.
> 
> Correct.  BTW, that's /dev/null to most people ;)
> 

err, yea, I'm a rebel, take that FHS

> > > 
> > > IMO we need to get the permissions and object classes cleared 
> > > up before
> > > merging this stuff, its very confusing and inappropriate right now.
> 
> More importantly:
> - We need to fix real bug (e.g. incorrect source or target context for a
> given check, incorrect set of checks applied on some operation/code
> path).

Correct.

> - We need to document what the checks mean and how they are applied so
> that policy writers can understand them.
> 

Yes, I'm trying to document it (thus my previous emails about the
complex case, once that is solved the steps preceding it are the ones
interesting to most people)

> Renaming them doesn't really help.  Classes have always been a fairly
> artificial construct, and you can see that already in the existing
> checks prior to this work.
> 

Renaming does help, classes may be artificial but the target context
*should* be an object that is represented by the target object class. It
was very confusing writing rules (and seeing denials) where there is no
such object of the tclass type that was labeled with tcon.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
