Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UJFLgA025590
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 15:15:21 -0400 (EDT)
Received: from web31611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5UJDdBs022877
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 19:13:39 GMT
Message-ID: <20050630191417.26186.qmail@web31611.mail.mud.yahoo.com>
Date: Thu, 30 Jun 2005 12:14:17 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Groups in the alternative user solution
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1120147588.1519.15.camel@celtics.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Ivan Gyurdiev <gyurdiev@redhat.com> wrote:

> 
> > > I didn't understand the reasoning there either,
> > > particularly as we
> > > aren't dealing with the effective GID but the
> entire
> > > authorized group
> > > list for the user since we are only doing this
> once
> > > at login/su time.
> > 
> > I hope this has clarified the group vs.
> > group list confusion.
> 
> Yes, I understand how it would work.
> What's not clear is why you want to match on group
> list as opposed to matching on group membership
> alone.

The question with multiple concurrent
groups has always been "which group?".
In the example of Fred you have to
ask if, from a security perspective,
Fred,wheel is the same as Fred,lever
or Fred,wheel,lever. Strictly speaking
the answer is no. Now, is the difference
significant in the SELinux context?
In Unix MLS systems (except for
SystemV/MLS) clearances are
associated only with users and the
group is completely ignored. 
But the Unix MLS systems make
no attempt at the wholistic
user/application/data/transform
worldview of domain enforcement.

> How is that helpful to the sysadmin - seems awfully 
> fragile. What happens to this file if I add the user
> to another group?

That's one good reason for the wildcards.

I don't know that the scheme I
suggests solves all or even any
of the problems. Use it or not.



Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
