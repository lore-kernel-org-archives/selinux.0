Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QHkngA019043
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 13:46:49 -0400 (EDT)
Received: from web31608.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5QHkPFZ013960
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 17:46:25 GMT
Message-ID: <20050626174616.48163.qmail@web31608.mail.mud.yahoo.com>
Date: Sun, 26 Jun 2005 10:46:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
To: selinux@tycho.nsa.gov
In-Reply-To: <200506270236.18235.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:


> The group-name thing could become fun if we have
> multiple names for the same 
> GID (it's not recommended but it works at the
> moment) and the GID is the 
> primary group for some users.  The Unix user-name is
> unambiguous as we start 
> with the name for every operation AFAIK.
> 
> > How does all this work with MLS ranges?
> 
> How does it cause problems with MLS?

Maybe it doesn't. On the other hand, can you
explain how it might work if you have a user
(I'll call him Barney today) who is cleared
to Secret in compartment A17 and B43? Do we
have to have a seperate role for Secret,A17
and Secret,B32 or do we need SELinux users

   Barney,Unclassified
   Barney,Secret
   Barney,Secret,A17
   Barnet,Secret,B43
   Barney,Secret,A17,B43

I could see arguments put forth for either
of these schemes as well as a number of others.
Just as multiple groups can muddy the waters
so to can clearance ranges result in issues of
attribute permutation.

> > Do we have a new file which associates uids to
> user roles?
> 
> Unix account names not UIDs. I think a mapping file
> is the only way.

Names not numbers, definitly.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
