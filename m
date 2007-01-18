Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0IIC0aH012853
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 13:12:00 -0500
Received: from web36611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0IICtL4014315
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 18:12:55 GMT
Date: Thu, 18 Jan 2007 10:12:54 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
To: Karl MacMillan <kmacmill@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <45AFA5F5.2080908@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <681036.75164.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Karl MacMillan <kmacmill@redhat.com> wrote:

> > There are others who would argue that SELinux
> > has abandoned the Linux privilege model and
> > thus disrupted the unity of the existing
> > security model.
> > 
> 
> No clue what this means.

Pre-SE Linux has a rational and well
established security model that includes
DAC and Privilege. The capability scheme
is designed to fit that model, adding the
logical extention from the POSIX statements
of "appropruate privilege" to defining what
those privileges would be.

SELinux does not use capabilities to identify
where "policy" is excepted, rather it defines
policy in such a way as to make the notion of
exception unnecessary. Many people think this
is good. I personally like the traditional
scheme, and would be happier with SELinux if
it held to it.

> > I don't understand why the SELinux crew seems
> > so intent on making it difficult to implement
> > alternatives. Last year it was "let's ditch LSM".
> > Now it's "Everyone hates stacking". Give it a
> > rest already.
> > 
> 
> 1) Stacking is possible now, just not arbitrary
> stacking by an admin.

True enough, although I have to say that it
isn't a pleasant exercise.

> 2) Not having arbitrary stacking in no way limits
> alternatives. It just 
> forces the use of a single alternative at a time or
> explicit development 
> to make alternatives work together.

Funny thing is that I would agree with you 100%
if LSM implemented authoritative hooks. Since
LSM implements a scheme that is supposed to
provide strictly for additional restrictions
it should be simple to stack modules safely.
 
> 3) The objections, if you read them, are about
> whether the correctness 
> of arbitrarily stacked modules can be reasonably
> expected or verified. 
> It is not an effort to limit alternatives.

Restictive LSM modules ought to be completely
stackable if they are in fact strictly
restrictive. That there are issues says that
the scheme may not be being used correctly.
I honestly don't know if that's worth the
trouble of fixing.

> There are real disagreements here, but please stop
> overstating the 
> differences and misconstruing (willfully?) peoples
> positions.

SELinux is a Good Thing for any number of
reasons. There are also other schemes that
have merit. Just as I encouraged the NSA to
adopt Linux and do their own security work
back in the late 20th century I hope to
encourage newcomers to LSM to follow through
with their ideas and come up with the next
great thing. Assimilation into SELinux can
come later if it's of value. Maybe you can
do a bunch of this stuff using SELinux as
a framework instead of LSM, but I think
that if someone wants to use LSM as a base
that is their call, and I personally would
like to see what they do because I don't
believe for a minute that the "problem"
of system security is solved.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
