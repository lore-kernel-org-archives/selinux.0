Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJ808Rb010953
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 03:00:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBJ7xIjx023040
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 07:59:18 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBJ7xGSR023032
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 07:59:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Shane Wegner <shane-dated-1074409746.778e04@cm.nu>, selinux@tycho.nsa.gov
Subject: Re: Domain Transitions (or the Exim4 policy)
Date: Fri, 19 Dec 2003 18:59:56 +1100
References: <20031219024548.GA24510@cm.nu> <200312191647.45107.russell@coker.com.au> <20031219070905.GA32075@cm.nu>
In-Reply-To: <20031219070905.GA32075@cm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312191859.56996.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Dec 2003 18:09, Shane Wegner <shane-dated-1074409746.778e04@cm.nu> 
wrote:
> On Fri, Dec 19, 2003 at 04:47:45PM +1100, Russell Coker wrote:
> > Why did you change it to exim4_t?  It seems to me that as exim and
> > sendmail operate in the same manner it would be better to have a single
> > policy to use for them both.  This will make it easier to maintain the
> > policy.
>
> Point taken.  Exim does seem to use a slightly different
> capability set and needs some modified permissions but
> they're trivial changes.

Send me a list.

I think that possibly the solution to this is to have sendmail.te and exim.te 
both instantiate a common macro for 99% of the policy.

> > > permissions it needs.  Further, when a user sends mail, say
> > > echo Hello world |mail
> > > exim4 gets spawned but this time in the user_t domain,
> > > again without the necessary permissions to write to its
> > > spool.
> >
> > In the sendmail policy it would transition to user_mail_t domain.
>
> After adapting sendmail.te and putting that in per your
> suggestion, it does indeed transition to user_mail_t though
> I can't figure out how.  The problem I'm seeing now though

sendmail_macros.te

> is from user_mail_t, exim doesn't have permission to wread
> its config files.  Do I need to give user_mail_t or

Which files?

> user_mail_domain all the privileges given to sendmail_t in
> the sendmail policy?

Many of those privs, hopefully as few as possible.

> Also, is user_mail_t an alias for
> some other domain.  I'm seeing user_mail_domain in policies
> but don't see user_mail_t anywhere save a minor mention
> in attrib.te.

It's in mta_macros.te.  user_mail_domain is for all of user_mail_t, 
staff_mail_t, etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
