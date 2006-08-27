Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7RIVMY4020580
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 14:31:22 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7RIUk8S020959
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 18:30:46 GMT
Message-ID: <20060827183105.61046.qmail@web36612.mail.mud.yahoo.com>
Date: Sun, 27 Aug 2006 11:31:05 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: poly-instantiated directories and call-gate
To: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200608272141.29051.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:

> ...  
> Thus the consequences of a single user breaking out
> of their instance of /tmp 
> is mitigated.

Contrary to popular belief, the motivation behind
polyinstatiated directories was allowing programs
that used /tmp to continue to work, not to
assist in keeping programs with different
attributes (MLS values in particular) seperate.
In the early days of Unix MLS design we seriously
considered tossing /tmp into the bitbucket and
encouraging everyone to set a rational value
to $TMPDIR and being done with it. In the end
we figured that the install base really did
require access to /tmp, and polyinstatiation
emerged as the most popular scheme for providing
that access.

All of the Unix schemes provide a way to get
at the "real" file system name space. Solaris
uses "adorned" path components. Trix uses a
process attribute (the Moldy bit), and UNICOS
used a symlink scheme that avoided the whole
issue. With the usual file system protections
in place there is no compelling reason to
worry about "breaking out". There are good
reasons to allow it, including sharing (upward)
and monitoring.

> In terms of having a call-gate, apparently this has
> been done before (Casey - 
> would you care to comment?).

Yes, it has been done. It's a Bad Idea.

> But even so I have
> great doubts about anything 
> that involves changing a simple system call to an
> execution of a program 
> (thus giving some potential for dead-locks among
> other things).  I believe 
> that this was one of the issues with devfs that
> caused it to be deprecated.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
