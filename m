From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "gndeva@ispwest.com" <gndeva@ispwest.com>
Subject: Re: GNU Coding Standards
Date: Sat, 15 Nov 2003 08:48:11 +1100
Cc: SELinux List <SELinux@tycho.nsa.gov>
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com> <ogtn0az2dqq.fsf@divan.mitre.org> <3FB51DBB.7070308@ispwest.com>
In-Reply-To: <3FB51DBB.7070308@ispwest.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311150848.11816.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 15 Nov 2003 05:23, "gndeva@ispwest.com" <gndeva@ispwest.com> wrote:
> Note that GNU automake requires perl, which does
> not seem to be in the base selinux tool chest
> (at least in the 2.4 flavor).

When building a distribution from scratch (EG a port to a new CPU) there are 
problems with circular dependencies involving Perl.  But this is not a 
problem for us as we are working on adding SE Linux to existing distributions 
that have Perl, getting Perl to compile is someone else's problem.

newrules.pl has been in the SE Linux distribution for a long time and there 
are no plans to re-write it in another language.

Some people believe that they can make setfiles run faster by re-writing it in 
Perl.  I doubt that, but if they can succeed then I'm sure that the code will 
be accepted.

I'm not trying to push automake, just noting that Perl is something that's OK 
to use for SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
