Subject: Re: dumb newbie questions
From: Christopher Warner <chris@servertogo.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Valdis.Kletnieks@vt.edu, SELinux@tycho.nsa.gov
In-Reply-To: <20050620213628.46862.qmail@web31601.mail.mud.yahoo.com>
References: <20050620213628.46862.qmail@web31601.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 05:48:25 -0400
Message-Id: <1119433705.23452.36.camel@sabrina>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Pardon my tardiness to this thread. None the less i'm going to have to
agree with Casey on this issue. Monday, while this thread was in
commencement. I was having a 2 hour meeting discussing Selinux and it's
use/implementation for this company I work for. Specifically how it will
work/interact with one of the applications we sell.

It seemed to me that I could not write a proper policy for the program
in question without knowing how the program was designed and worked.
Needless to say that me seeing the "source" is an issue and avenue that
can't be explored. This led me to, subsequently, reverting to stracing
the program. Which led to me finding that basically, the program in
question does many things incorrectly or at least what one would deem as
being grossly incorrect. IE: Using system calls instead of /proc etc etc
(etc etc being more irregularity). Even if I wrote a decent policy for
the program it would mean allowing it to do things it should not do.
Breaking policy across the board for everything else all together. The
last statement made was "Then I don't understand why we are using
Selinux".

We eventually agreed that I would need the design spec of the program
and that I would write policy based off of that. I've not received the
design spec yet and I've spent the last 6 months learning and working
with Selinux, whilst fulfilling my day duties. Implementing it into the
in-house distribution and then trying to write policy. I'm at a lost
currently as to why I would even attempt at writing the policy for this
program. It disheartens me as I feel the last 6 months were completely
wasted in terms of anything involving the goal of security.

The problem I see here is two fold in my case, First, the assumption
that Selinux is a security cure all if it's just implemented or
activated (a poor assumption made by the person in charge). This, only
education and understanding of the product in question can fix.
Secondly, and more importantly is that there is very little in the terms
of updated and concise documentation where one can just point others
(developers/sysadmins/etc) to. So that they can receive a decent
overview and make an educated decision. Security is a philospohy and
Selinux enforces this philosophy. Thats what it boils down to.

The only useful reference is the O'Reilly book on Selinux. It covers
creating policy but it doesn't address how policy interacts or how you'd
go about writing a decent policy. This also has to be taken into
account. We need more documentation and it should reiterate the fact
that Selinux is pointless if proper policy is not or can not be written.

On Mon, 2005-06-20 at 14:36 -0700, Casey Schaufler wrote:
> 
> --- Valdis.Kletnieks@vt.edu wrote:
> 
> > This presupposes two very unlikely events:
> > 
> > 1) That *all* the problems are found
> 
> Nope, just that all the problems that the
> "policy" would find are found. Since the
> policy will not find things it does not
> find ...
> 
> > 2) That no further software upgrades happen,
> > introducing more problems.
> 
> Or changes that are made to get around the
> SELinux policy that has arbitrarily been
> imposed on an application.
> 
> > Other than that, yes, you could turn it off once
> > your system is
> > 100% secured and infallible.
> 
> You could turn it off well before then and
> still gain complete benefit.  Let's face it,
> SELinux, even with the strict policy, is not
> going to identify all flaws any more than a
> Biba integrity policy would.
> 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
> 
> 
> 		
> ____________________________________________________ 
> Yahoo! Sports 
> Rekindle the Rivalries. Sign up for Fantasy Football 
> http://football.fantasysports.yahoo.com
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
.-Christopher Warner---------------------------------------------.
| my email is recycled to be sure; bcc my personal email address |
`----------------------------------------------------------------'


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
