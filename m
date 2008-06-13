Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5DHUB7k016922
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 13:30:11 -0400
Received: from goalkeeper.city-fan.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5DHU9jk027391
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 17:30:10 GMT
Date: Fri, 13 Jun 2008 18:30:04 +0100
From: Paul Howarth <paul@city-fan.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Milter Mail Filters
Message-ID: <20080613183004.09bfdb97@metropolis.intra.city-fan.org>
In-Reply-To: <1213367005.11146.45.camel@gorn>
References: <484D4B53.5020006@city-fan.org>
	<48526D68.1040807@city-fan.org>
	<1213367005.11146.45.camel@gorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Jun 2008 10:23:25 -0400
"Christopher J. PeBenito" <cpebenito@tresys.com> wrote:

> On Fri, 2008-06-13 at 13:51 +0100, Paul Howarth wrote:
> > Paul Howarth wrote:
> > > attached is a patch based on local policy I'm using on Fedora 9
> > > to support two "milter" mail filter daemons in conjunction with
> > > sendmail, namely spamass-milter and milter-regex (I maintain the
> > > packages for both of these in Fedora).
> > > 
> > > I've taken the view that most milter applications will have
> > > similar requirements and so I've created a milter_template
> > > interface that contains most of what's needed, and then added the
> > > specifics that are needed on top of the generic stuff for each
> > > application.
> > > 
> > > However, as I'm by no means an selinux expert, there are a number
> > > of things I'm unsure about:
> > > 
> > > 1. In a situation where sendmail is the running MTA on a system,
> > > what is the difference between sendmail_t and system_mail_t?
> 
> The former is the server process, the latter is the client.  In the
> past sendmail_t was also used in the client sense in too, but we've
> since stuck with *_mail_t for clients with few exeptions (which I'd
> prefer to fix).

OK, understood.

> > > 2. MTAs other than sendmail (postfix comes to mind) can also use 
> > > milters, but as I don't have any boxes running postfix, I don't
> > > know what I'd need to add to postfix policy to support milters.
> 
> My guess would be postfix_local_t, since that is where the procmail
> transition is.  Someone more familiar with postfix should confirm.

Not sure about that; that would be local delivery and the milter
communications happen during the SMTP transaction, which would be
earlier in the process.

> > > 3. Fedora 9 has an interface spamassassin_domtrans_spamc that I
> > > used in my local policy. It doesn't appear to be present in
> > > refpolicy; what would be the right thing to use for a daemon
> > > calling spamc?
> 
> There isn't currently a system_spamc_t domain, and adding that
> along with appropriate interfaces would likely be the
> best choice. Current policies just execute spamc w/o transition, for
> example procmail, which would likely be ok for now.

I was happy to find the spamassassin_domtrans_spamc interface in the
Fedora policy as without the domain transition to spamc_t, I'd have had
a lot more rules to add to the milter_spamass policy. Is adding the
system_spamc_t domain likely to be a big job?

> > > 4. I cribbed the milter_port_t stuff from the only example I
> > > could find, and it's probably wrong. What would be the correct
> > > way of defining this?
> 
> Adding it to corenetwork.

Thanks.

> > > 5. Does the use of a template for these applications a sane way
> > > to do it?
> 
> Depends.  Based on what I see in your patch, I'd say no.  There are
> only a couple rules, and there are a bunch of types declared that
> don't have rules.

I could probably combine most of the types into a single type.
Different milters put their sockets in different places and I was
trying to anticipate future requirements whilst sticking with the type
naming conventions for the various subdirectories within /var; I expect
I'd get away with just using something like milter_$1_socket_t and
using that wherever each milter wanted to put its socket, be
it /var/lib/, /var/run/, /var/spool/ etc.

> > Should I have raised this somewhere else, or in a different way?
> > I've had no responses either here or on fedora-selinux-list. The 
> > spamass-milter is currently broken with SELinux enforcing on Fedora
> > 9 and I'd like to be able to make at least a little progress
> > towards fixing that.
> 
> Here is fine.  I can only speak for myself about not responding
> earlier of course, but since there was a policy patch I added it to
> my queue to review.  There are still items in the queue before this :)

Thanks for looking at it. I'll now wait patiently in line, as we Brits
tend to do ;-)

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
