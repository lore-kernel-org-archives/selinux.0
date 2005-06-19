Message-ID: <20050619213151.53651.qmail@web31601.mail.mud.yahoo.com>
Date: Sun, 19 Jun 2005 14:31:51 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: dumb newbie questions
To: ivg2@cornell.edu
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119214637.17213.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Ivan Gyurdiev <ivg2@cornell.edu> wrote:

> 
> > I think it is. The developer, who understands
> > the intent of the application and it behavior,
> > ought to be in charge of the SELinux policy.
> 
> On the other hand you might argue that the developer
> of the application is biased toward the
> application..
> and likely to allow things that shouldn't be
> allowed.

Yes, the developer will do that. It's the
old useability VS security argument all over.
I doubt that you're arguing for removing
the chmod() syscall, although that's a logical
step from your position. SELinux provides
a mechanism by which the system can constrain
an application. Great. What I don't condone
is the uneducated application of this mechanism
to applications on a production system. I agree
that the rote use of audit2allow is a bad idea.
I also take the position that the developer
and/or maintainer of an application is the
person responsible for the behavior of the
application, and that includes the behavior
under SELinux.

If you can't get developers to buy into
supporting SELinux properly SELinux will
die on the vine. You will not get developers
into the SELinux camp without sufficient
and readily available tools and documentation.
Oh, and respect, too.

I hope that when I bring the project I
have underway out I can include a rational
SELinux policy as part of the package.
I do not have faith that the "SELinux People"
will understand it sufficiently to provide
a policy for it.

> Anyway, I think Steven (Smalley) has mentioned that
> more efforts to decentralize policy will occur
> after Tresys' binary modules work is merged.

Yes, he has. I hope that effort is successful.
I strongly dislike the direction of RedHat
shipping a binary only policy, and one that
so few people understand, and that the
applications it impacts can't even be repaired
by their maintainers. Harumph.



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
