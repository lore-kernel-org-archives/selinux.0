Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h579FFI4007973
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 05:15:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h579FEtV008272
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 09:15:15 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h579FCal008269 for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 09:15:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: jack@rapturesecurity.com, selinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux
Date: Sat, 7 Jun 2003 19:14:10 +1000
References: <1054916729.1057.213.camel@moss-huskers.epoch.ncsc.mil> <1054974401.13760.29.camel@bubbles.eatflamingdeath.org>
In-Reply-To: <1054974401.13760.29.camel@bubbles.eatflamingdeath.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306071914.10635.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 7 Jun 2003 18:26, Jack wrote:
> From the limited research Ive been able to put into this
> Ive found that changing glibc/sysdeps/generic/enbl-secure.c
> to
>
>  __libc_enable_secure = (__geteuid () != __getuid ()
>
>                           || __getegid () != __getgid ()
>                           || getsecsid() != getosecsid());

That looks like the right code.  The question is what is the right way of 
integrating it into a distribution.

I don't want to maintain my own version of libc6 for SE Linux support if I can 
avoid it.

I can't in good conscience ask the Debian libc6 maintainers to include the 
above code at this time as the 2.6.0 transition will change the getsecsid() 
system call and cause problems.

I could potentially write some library code to perform the 2.6.x getsecsid() 
and then use the 2.4.x version on x86 and ARM platforms if the 2.6.x version 
fails.  But that seems ugly.

On the debian-devel mailing list I have raised the suggestion of having an 
option for libc6 to load a shared object for such checks (which could be used 
for many things other than SE Linux).  However nothing productive has 
resulted.

Jack, which distribution do you use?  I think that getting appropriate changes 
in distributions is up to you, me, Carsten, Method, and David.  I think that 
perhaps the Gentoo people will be in the position to take a lead on this one.

> works to fix my boxes btw. Of couse this brings up more problems than
> it solves, such as where to put all the code, and if this is really the
> fix that I want. I would like to hear flames or feedback about this code
> being here, as I am no glibc hacker. Luckily for me all the utilities
> I'm using are already flaging __libc_enable_secure from setuid or
> setgid via shadow or the Owl tcb pam stuff, that pertain to this
> thread anyhow.

Could you please publish the relevant policy changes for the Owl TCB stuff?

> On a Side Note:
> This might be a dumb question, but why would root have DAC override in a
> shell? I certainly dont allow this in my _messy_ policy, am I missing
> something?

If you allow the setuid and dac_override capabilities in user_t then more 
things can operate in the same way as a non-SE system, so many SUID programs 
can run in their normal fashion with no extra policy.

If you don't allow setuid and dac_override (my decision) then you need to 
write policy for every SUID program that you permit users to run.

The original NSA policy permitted setuid and dac_override capabilities as it 
still allowed full separation of user roles.  After a series of experiments 
on "play machines" I determined that there was no great need for those 
capabilities and submitted a policy patch to remove them.  This is not to 
imply that there was anything wrong with the original example policy, it was 
just designed to be used in a slightly different manner.

I think that this thread has demonstrated why providing root access to 
untrusted users is not a good idea except in the limited case of special play 
machines which are strongly firewalled off from all important machines (as 
recommended strongly by Stephen Smalley on many occasions).

However it's good to know that even if something goes wrong and an untrusted 
user gets root then they will still have a battle ahead of them to get 
administrative access to the machine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
