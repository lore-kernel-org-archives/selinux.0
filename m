Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KEFAI4009801
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 10:15:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4KEF9tV025406
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 14:15:09 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4KEF5al025393 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 14:15:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Torsten Knodt <tk-selinux@datas-world.de>, selinux@tycho.nsa.gov
Subject: Re: matrix
Date: Wed, 21 May 2003 00:13:14 +1000
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com> <200305201437.24228.russell@coker.com.au> <200305201505.25398.tk-selinux@datas-world.de>
In-Reply-To: <200305201505.25398.tk-selinux@datas-world.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305210013.14976.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 May 2003 23:01, Torsten Knodt wrote:
> Much better.
> When I have free time, I'll think about a way to get a cleaner policy. I
> already have some ideas generating most via scripts. But first, there a
> other things to do.

The problem with scripts is that they can't recognise which accesses should be 
granted, which should have dontaudit rules, and which indicate that you need 
to create new domains or types.

If you can solve this problem then I think you could make a good Ph.D thesis 
out of it...

> >  One attack that is impossible to prevent is taking over and
> > subverting an active sshd.
>
> I think this can be reduced. Stack smash protection and pax are already
> there, they only have to be used by the distributions. Then there is

Has anyone got PaX working with LSM?

Propolice would be good to have.

> privilege separation. When the last is combined with an own domain, this

Doing a separate domain requires an exec() type system call.  Currently the 
sshd just forks off a privsep process which keeps a copy of all the state it 
needs.  If it does an exec then it needs to serialise the data and pass it in 
via a pipe.  It's doable, but it'll take some serious coding.

Also working on the sshd code is not fun at all, the current SE Linux patches 
do easy things.  If you want to change the data structures in sshd then 
you'll have a lot more work.

I'm not trying to discourage you, just explaining why there's about a million 
things before it in my to-do list.  ;)

> makes accessing /etc/shadow by encryption bugs much harder. Also pam bugs
> wouldn't have access to the keys. OK, the encryption code still has key
> access, but this can be reduced to.

The encryption code needs to have the key in memory if nothing else.  Although 
I guess you could have one process for doing the public-key part and another 
process for doing encryption with a session key after the public key stuff is 
done.

> >  sshd needs to be able to launch user sessions
> > (in some context) and a subverted sshd could do the same using all the
> > same security keys etc.
>
> Right. At least the ssh executable cannot be replaced with SE Linux. sshd_t
> has no write access to sshd_exec_t. On smaller machines, admins can restart
> such processes, when they are currently unused. Or much better would be,
> e.g. with sshd, to separate the key generation in an own process, and start
> ssh via inetd. Then, when a user logs in, cracks it's own ssh process, he
> hasn't easy access to other processes in the same domain. But this is more
> the job of the server coders, than SE linux.

Good point about inetd.  If sshd is started by inetd and denied ptrace access 
to itself then a cracked sshd can't interfere with another ssh session.  I 
will have to look into changing my servers to do this.  Of course this raises 
another problem, the unreliability of inetd's.  But if inetd is cracked it 
doesn't allow much of an attack on the ssh protocol as long as the clients 
already have a copy of the server public key.

> > When someone runs newrole from a session launched by a
> > subverted sshd then their password can be captured and it's game-over.
>
> At least in default setup, newrole is checked with securetty. But most want
> to have a way to be sysadm. So, there has to be another solution. And I
> think there is. The user_t tasks are secured by those attacks. Only sending
> password's over the ssh channel is a problem. So what can be done, is a
> callback. You use a program which opens a tcp socket back to the client.
> This program runs under user_t and can be trusted by the user. The user

If a trojan sshd subverts the session then nothing that is launched from it 
can be trusted by the user.

Of course if the user launches a program that needs a secret key, and if that 
secret key is only available to a program that runs in a different domain, 
and if the user_t domain is denied access to do the network-callback 
functionality then it might be OK.  But that just means that they have the 
same issue of cracking this callback program as with cracking ssh, with the 
additional risk that when using a program that is used by few people it won't 
get the testing and analysis that sshd gets.

> > However this requires that the sshd be subverted without anyone noticing,
> > and the example of the movie was very noticable.  ;)
>
> In the movie, OK. But I thought more about the problem in reality, or that
> what we think is our reality, than the movie. And there it's a somewhat
> complex problem of trust, which could be solved, or at least be reduced.

It's a very complex problem which can't be totally solved.  This is why 
organizations that want really serious security don't allow people to login 
from outside to do important work.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
