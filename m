Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15586
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 11:28:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA15237
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 15:26:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA15225 for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 15:26:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new macro in users.te
Date: Thu, 20 Jun 2002 17:28:01 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206201026150.16259-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206201026150.16259-100000@raven>
MIME-Version: 1.0
Message-Id: <20020620152801.81DDB5B8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Jun 2002 16:31, Stephen Smalley wrote:
> On Thu, 20 Jun 2002, Russell Coker wrote:
> > In my policy tree I have the following in users.te:
> >
> > define(`in_user_role', `
> > role user_r types $1;
> > #role second_user_r types $1;
> > ')
> >
> > Then I replace this:
> > role user_r types foo_t;
> > with this:
> > in_user_role(foo_t)
> >
> > I want to have multiple user roles that each have their own primary
> > domain, but can change to other domains within their role, but can't
> > access the primary domain for other roles.
>
> You might want to put the macro definition in user_macros.te instead of
> users.te.  My preference would be to keep all macros (or at least any
> macros that are not completely private to a single .te file) in the
> separate macros hierarchy.  In this case, ordering shouldn't be a problem,
> since users.te is read before any of the program domains, but I'd rather
> not rely on such ordering among the domain .te files.

I've already done that as the next step of the same work, now user.te has 
hardly any code in it.

> If you permit the different user domains to share program domains (rather
> than instantiating separate program domains for each user domain using a
> macro), then be careful that you don't end up with unexpected interactions
> among the user domains through these shared program domains.

Yes.  The idea is to do this for things that don't have such problems.  For 
example pppd, once the user starts it they have no control over it other than 
(possibly) stopping it anyway.

> Is the diff for this change available?  I've merged up through your
> 2002053110-3.diff.

It's not coherent enough to be worth releasing.  I won't release something 
(even to you) until it's in a better state than my -4 version is currently.

Also the following was sent to me in a private message in response to this 
discussion on the list, I feel that I am not able to comment on it, Stephen, 
could you respond?

> You've probably already considered this.  Would this situation be a
> candidate for role dominance?  Tie the primary domain to the dominate
> role and the "sharable" domains to dominated roles.  I don't have the
> practical experience to recognize the impact of this setup.

NB  I have intentionally not mentioned the person's name, as I presume that 
they would have posted to the list if they wanted it known.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
