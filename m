Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KD6UI4009255
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 09:06:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4KD6UtV021726
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 13:06:30 GMT
Received: from datas-world.dyndns.org (dsl-213-023-224-072.arcor-ip.net [213.23.224.72])
        by jazzband.ncsc.mil  with ESMTP id h4KD6Sal021717 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 13:06:29 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
To: selinux@tycho.nsa.gov
Subject: Re: matrix
Date: Tue, 20 May 2003 15:01:48 +0200
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com> <200305192115.33548.tk-selinux@datas-world.de> <200305201437.24228.russell@coker.com.au>
In-Reply-To: <200305201437.24228.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200305201505.25398.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > > Fortunately for Trinity the power company wasn't using SE Linux.  When
> > > using
> > > SE Linux the loophole would not grant the highest level of access and
> > > the movie would have a very different ending.  ;)
> > I wouldn't bet, that SE Linux would make this impossible, at least not
> > with
> Not impossible given unrestricted time and other security weaknesses in the
> network.  But impossible to do as it was done in the movie.
I think, she would use another way, in another situation. She's not a silly 
bot. ;)

> > Russell's policy and some minor insecurities in the rest of the network.
> > The ssh process doesn't need to have all rights. It was reported, that
> > rootkits where installed. Yes, this is not possible. But when I
> > understand the policy right, at least rw access to the key file is
> > possible (why?).
> Good point.  I've changed that in my tree to { getattr read }.
Much better.
When I have free time, I'll think about a way to get a cleaner policy. I 
already have some ideas generating most via scripts. But first, there a other 
things to do.

> Also I removed access to files of var_t, removed access to pidfile, and
> removed some commented policy and merged some rules for easier readability.
> I have attached a modified policy file.
> > This combined with dns- or arp-spoofing should
> > allow to spoof the ssh server.
> Yes, if you crack the server process then you can always spoof/proxy the
> server.
It can be made harder, by separating the server processes in small interacting 
processes, having their own domain.

>  One attack that is impossible to prevent is taking over and
> subverting an active sshd.
I think this can be reduced. Stack smash protection and pax are already there, 
they only have to be used by the distributions. Then there is privilege 
separation. When the last is combined with an own domain, this makes 
accessing /etc/shadow by encryption bugs much harder. Also pam bugs wouldn't 
have access to the keys. OK, the encryption code still has key access, but 
this can be reduced to.

>  sshd needs to be able to launch user sessions
> (in some context) and a subverted sshd could do the same using all the same
> security keys etc.
Right. At least the ssh executable cannot be replaced with SE Linux. sshd_t 
has no write access to sshd_exec_t. On smaller machines, admins can restart 
such processes, when they are currently unused. Or much better would be, e.g. 
with sshd, to separate the key generation in an own process, and start ssh 
via inetd. Then, when a user logs in, cracks it's own ssh process, he hasn't 
easy access to other processes in the same domain. But this is more the job 
of the server coders, than SE linux.

> When someone runs newrole from a session launched by a
> subverted sshd then their password can be captured and it's game-over.
At least in default setup, newrole is checked with securetty. But most want to 
have a way to be sysadm. So, there has to be another solution. And I think 
there is. The user_t tasks are secured by those attacks. Only sending 
password's over the ssh channel is a problem. So what can be done, is a 
callback. You use a program which opens a tcp socket back to the client. This 
program runs under user_t and can be trusted by the user. The user also 
trusts his client pc, as he uses it's ssh client. This program on the server 
works in its own domain, reading a stored keypair in the users home. With 
this keypair, it can setup a secured link to the client. Only bad is, that 
this could be a problem with firewalls, especially when doing nat.

> However this requires that the sshd be subverted without anyone noticing,
> and the example of the movie was very noticable.  ;)
In the movie, OK. But I thought more about the problem in reality, or that 
what we think is our reality, than the movie. And there it's a somewhat 
complex problem of trust, which could be solved, or at least be reduced.

Uh, long mail.

Regards
	Torsten
- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yigJvxZktkzSmiwRAmQFAJ9OEFw8QVxzIkvzHv01LUu+BqTnggCeKR71
gHD/QfZCh9RvJZvUHPzkDWU=
=l2YN
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
