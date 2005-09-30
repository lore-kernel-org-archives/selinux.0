Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UCMZNs027453
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 08:22:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UCGcmd019835
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 12:16:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7260D61B01
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 22:16:49 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15145-09 for <selinux@tycho.nsa.gov>;
	Fri, 30 Sep 2005 22:16:49 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id F37D761AFB
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 22:16:48 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: postfix.te
Date: Fri, 30 Sep 2005 22:16:41 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200509301520.42488.russell@coker.com.au> <433D2520.90500@redhat.com>
In-Reply-To: <433D2520.90500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509302216.47786.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 September 2005 21:44, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >The above was added within the distro_redhat section.  Do we have a plan
> > to change the way the aliases file is managed in FC5 or RHEL5?
> >Currently /etc/aliases is read the /etc/postfix/aliases.db is produced as
> > a result.  So the above line is not needed (and grants postfix_master_t
> > write access to etc_t:dir which is not desired).
>
> Not on the machine I was looking at (rawhide), /etc/aliases.db was being
> created.

OK, it looks like the default configuration of the Postfix package has been 
made more similar to other distributions such as Debian in this regard.

> >dontaudit postfix_smtpd_t { home_root_t boot_t }:dir getattr;
> >
> >The above line is added in the section with a comment referring to
> > prng_exch. Why is that access needed and what does it have to do with
> > prng_exch?
>
> Because postfix_smtpd_t is trying to getattr on everying thing in / is
> my guess.

Why would it be doing that?  For so long it's been not doing so on so many 
machines with so many distributions.

> >As for the reference to bin_t, I can only guess that it's to execute
> >spamassasin when spamassasin.te is not installed (spamassasin has some
> > files in /etc/mail).
> >
> >Is it possible to have the postfix "local" execute spamassasin directly or
> >would that be from someone who has spamassasin running from procmail
> > (which seems to be the most common way of running spamassasin on a
> > server) and not having procmail.te installed?
> >
> >I suggest the attached patch to fix these issues.
>
> Huh?  So we just allow spamassassin to fail if policy is not installed,
> which it is not in targeted policy.

We remove the bad policy until we can determine how to write good policy.

Allowing everything is easy, but that diminishes the value of SE Linux.  
Determining what we really need is the hard work.

Who submitted the policy patch in regard to etc_mail_t and bin_t?  We need to 
ask that person why they did it and find out what they were trying to do.  
There is a better way of achieving the same result, but until we know what 
they are trying to do it's not possible.  The questions we need to ask that 
person are:
1)  Are you using procmail for delivery?
2)  If not how are you running spamassasin?

The last thing I want to do is imagine how Postfix might be working, get it 
wrong, and end up writing policy to permit Postfix to do things it can never 
be configured to do!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
