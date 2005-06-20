Date: Mon, 20 Jun 2005 20:21:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
Message-ID: <20050620192124.GG8451@lkcl.net>
References: <20050619221357.GH8415@lkcl.net> <20050620001655.12758.qmail@web31610.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050620001655.12758.qmail@web31610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 19, 2005 at 05:16:55PM -0700, Casey Schaufler wrote:
> 
> 
> --- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
> wrote:
> 
> 
> > > I think it is. The developer, who understands
> > > the intent of the application and it behavior,
> > > ought to be in charge of the SELinux policy.
> >  
> >  no, no, and definitely no.
> > 
> >  i made the mistake, 8 months ago, of making that
> > recommendation.
> > 
> >  russell kindly put me right about it: you could
> > likely, with enough
> >  searching, find his response.
> > 
> >  the person doing the application is EXTREMELY
> > unlikely to have the
> >  expertise and knowledge sufficient to get selinux
> > and to get selinux
> >  policy right.
> 
> My point, and I hope that someday I'll
> come up with the right set of words to
> make it clear, is that if it is indeed
> the case that application developers
> cannot be trained to get the SELinux policy
> correct that that is a fatal deficiency
> in the facility. 

 i _would_ agree with you... if it wasn't for this:

 * that security in unix is glaringly deficient;

 * that application developers are notoriously ignorant of security issues;

 * that languages like c and c++ and processors like the x86 _invite_ 
 security issues.

 and that this is true _irrespective_ of whether selinux exists or not.

 yes?

 i think this can be said (i invite people to disagree).

 based on the above three statements (*) being true, it can be concluded
 that when you introduce selinux, the expectation for ordinary
 applications developers to "get it right" simply becomes an absolute
 nonsense.

 the mere _introduction_ of security-aware selinux developers and the
 use of a formally structured policy makes it possible to draw
 application developers' attention to security deficiencies in their
 programs, and they can then be invited to fix them.


 a [possibly too] simple example is that of the debian
 initscripts, one of which attempted to do a touch on /etc
 in order to detect whether /etc/mtab could potentially be
 written to [instead of doing touch on /etc/mtab itself!]

 because selinux "strict" policy quite rightly bans all but
 appropriate programs to have write permission to /etc (and
 this particular initscript most certainly ain't one of those
 programs!), the entire behaviour of the debian initscripts
 (in this case, mounting and managing the initial filesystem
 partitions!) went off down a different path, causing some
 quite serious recovery problems.

 the solution was NOT to "fix selinux" but instead the solution
 was to fix the initscript.

 ... but would that have been detected if it wasn't for the strictness
 of selinux being Mandatory Access Control, such that an avc message
 comes up?

 of course it wouldn't have been.

 there are plenty other (better) examples.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
