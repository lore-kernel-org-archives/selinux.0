Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PGYIgA014373
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 12:34:18 -0400 (EDT)
Received: from web31604.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5PGY5N4026426
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 16:34:05 GMT
Message-ID: <20050625163406.10898.qmail@web31604.mail.mud.yahoo.com>
Date: Sat, 25 Jun 2005 09:34:06 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
To: selinux@tycho.nsa.gov
In-Reply-To: <42BD7A43.909@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Joshua Brindle <jbrindle@tresys.com> wrote:


> The biggest challenge after this is labeling,
> how to label home directories (Probably should
> only be done at useradd time, or when you 
> log into a computer the first time with LDAP, the
> utilities will have to 
> be a bit smarter about labeling)

Unix MLS systems require that the home directory
be labeled upon creation, usually by the useradd
utility or the local equivalent, but sometimes
by hand. Spontainious creation of home directories
on first login was never on anyone's high priority
todo list, so it remains an unsolved problem.
There are systems that will automount your
home directory, but that requires MLS aware NFS.

Unix MLS systems keep a default label as well as
a clearance, using the default label for the user
as label for the home directory. It is of course
possible to muck things up by have a default label
that is not dominated by all labels in your
clearance, but most sysadmins figure that out
very quickly.

Of course, on Unix MLS systems all files have
labels attached, per the TCSEC requirements,
unless an entire file system in unlabeled in
which case all files are treated at the same
sensitivity. I don't know if y'all plan to
label all files for SELinux MLS or what you
might do instead.



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
