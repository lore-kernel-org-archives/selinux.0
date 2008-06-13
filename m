Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5DENpOO005041
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 10:23:51 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5DENohG026651
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 14:23:50 GMT
Subject: Re: [refpolicy] Milter Mail Filters
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Howarth <paul@city-fan.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48526D68.1040807@city-fan.org>
References: <484D4B53.5020006@city-fan.org>  <48526D68.1040807@city-fan.org>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 10:23:25 -0400
Message-Id: <1213367005.11146.45.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-06-13 at 13:51 +0100, Paul Howarth wrote:
> Paul Howarth wrote:
> > attached is a patch based on local policy I'm using on Fedora 9 to 
> > support two "milter" mail filter daemons in conjunction with sendmail, 
> > namely spamass-milter and milter-regex (I maintain the packages for both 
> > of these in Fedora).
> > 
> > I've taken the view that most milter applications will have similar 
> > requirements and so I've created a milter_template interface that 
> > contains most of what's needed, and then added the specifics that are 
> > needed on top of the generic stuff for each application.
> > 
> > However, as I'm by no means an selinux expert, there are a number of 
> > things I'm unsure about:
> > 
> > 1. In a situation where sendmail is the running MTA on a system, what is 
> > the difference between sendmail_t and system_mail_t?

The former is the server process, the latter is the client.  In the past
sendmail_t was also used in the client sense in too, but we've since
stuck with *_mail_t for clients with few exeptions (which I'd prefer to
fix).

> > 2. MTAs other than sendmail (postfix comes to mind) can also use 
> > milters, but as I don't have any boxes running postfix, I don't know 
> > what I'd need to add to postfix policy to support milters.

My guess would be postfix_local_t, since that is where the procmail
transition is.  Someone more familiar with postfix should confirm.

> > 3. Fedora 9 has an interface spamassassin_domtrans_spamc that I used in 
> > my local policy. It doesn't appear to be present in refpolicy; what 
> > would be the right thing to use for a daemon calling spamc?

There isn't currently a system_spamc_t domain, and adding that along
with appropriate interfaces would likely be the best choice.  Current
policies just execute spamc w/o transition, for example procmail, which
would likely be ok for now.

> > 4. I cribbed the milter_port_t stuff from the only example I could find, 
> > and it's probably wrong. What would be the correct way of defining this?

Adding it to corenetwork.

> > 5. Does the use of a template for these applications a sane way to do it?

Depends.  Based on what I see in your patch, I'd say no.  There are only
a couple rules, and there are a bunch of types declared that don't have
rules.

> Should I have raised this somewhere else, or in a different way? I've 
> had no responses either here or on fedora-selinux-list. The 
> spamass-milter is currently broken with SELinux enforcing on Fedora 9 
> and I'd like to be able to make at least a little progress towards 
> fixing that.

Here is fine.  I can only speak for myself about not responding earlier
of course, but since there was a policy patch I added it to my queue to
review.  There are still items in the queue before this :)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
