Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KGwOI4010914
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 12:58:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4KGw0Qj019973
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 16:58:00 GMT
Received: from datas-world.dyndns.org (dsl-213-023-224-072.arcor-ip.net [213.23.224.72])
	by jazzswing.ncsc.mil  with ESMTP id h4KGvuxS019958
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 16:57:57 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
To: selinux@tycho.nsa.gov
Subject: Re: matrix
Date: Tue, 20 May 2003 18:57:51 +0200
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com> <200305201505.25398.tk-selinux@datas-world.de> <200305210013.14976.russell@coker.com.au>
In-Reply-To: <200305210013.14976.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200305201857.54041.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > When I have free time, I'll think about a way to get a cleaner policy. I
> > already have some ideas generating most via scripts. But first, there a
> > other things to do.
> The problem with scripts is that they can't recognise which accesses should
> be granted, which should have dontaudit rules, and which indicate that you
> need to create new domains or types.
I said generating most. Here an example, based on debian. We create a policy 
per package. You can get the files of the package with "dpkg -L". Assinging 
package_var_log_t and friends automaticly is not the problem. Because of LFS 
and the debian policy, there is much which can be automated. OK, now you have 
filecontexts and automaticly generated type definitions. Next are the 
transitions. I think creating a package_t transists var_log_t to 
package_var_log_t and the like, is also not the problem. This way, you can do 
most for the packages. Next is using dependencies. You can use the provides, 
to generate some network rules. A package providing mail-reader, needs access 
to pop3, smtp, var_spool_mail, ... Dependencies call macros. When A depends 
on B, it calls B_depend(A) or something like this. Packages providing e.g. 
imap-server, must be allowed to name_bind ... for this port. The portcon 
definitions can be taken out of /etc/services, including the type definitions 
for them. This all should reduce the size of the hand written policy parts 
very much. And I think a policy which fits on a 80x25 terminal, is much 
better checked, as a much bigger.

> If you can solve this problem then I think you could make a good Ph.D
> thesis out of it...
As I said, it's only a kind of support, not the solution. It takes away the 
mechanical work.

> > >  One attack that is impossible to prevent is taking over and
> > > subverting an active sshd.
> > I think this can be reduced. Stack smash protection and pax are already
> > there, they only have to be used by the distributions. Then there is
> Has anyone got PaX working with LSM?
Not tried so far.

> Propolice would be good to have.

> > privilege separation. When the last is combined with an own domain, this
> Doing a separate domain requires an exec() type system call.  Currently the
> sshd just forks off a privsep process which keeps a copy of all the state
> it needs.  If it does an exec then it needs to serialise the data and pass
> it in via a pipe.  It's doable, but it'll take some serious coding.
I know. But I think, that SE Linux is a real help, such things are necessary. 
The ssl services increase and replacing a certificate with all the work 
around, is a nightmare.

> I'm not trying to discourage you, just explaining why there's about a
> million things before it in my to-do list.  ;)
In my too. I only thought a little ahead. I think when someone reads this list 
by interest, he should know where the problems are, and that SE Linux is not 
final security. This fault is made to often by people who hear about 
something and think that's all.

> > makes accessing /etc/shadow by encryption bugs much harder. Also pam bugs
> > wouldn't have access to the keys. OK, the encryption code still has key
> > access, but this can be reduced to.
> The encryption code needs to have the key in memory if nothing else. 
> Although I guess you could have one process for doing the public-key part
> and another process for doing encryption with a session key after the
> public key stuff is done.
Right.

> > >  sshd needs to be able to launch user sessions
> > > (in some context) and a subverted sshd could do the same using all the
> > > same security keys etc.
> > Right. At least the ssh executable cannot be replaced with SE Linux.
> > sshd_t has no write access to sshd_exec_t. On smaller machines, admins
> > can restart such processes, when they are currently unused. Or much
> > better would be, e.g. with sshd, to separate the key generation in an own
> > process, and start ssh via inetd. Then, when a user logs in, cracks it's
> > own ssh process, he hasn't easy access to other processes in the same
> > domain. But this is more the job of the server coders, than SE linux.
> Good point about inetd.  If sshd is started by inetd and denied ptrace
> access to itself then a cracked sshd can't interfere with another ssh
> session.  I will have to look into changing my servers to do this.  Of
> course this raises another problem, the unreliability of inetd's.
xinetd is much more secure. And moving all sockets in a different process and 
domain shouldn't be the problem.

>  But if
> inetd is cracked it doesn't allow much of an attack on the ssh protocol as
> long as the clients already have a copy of the server public key.
Not having a pre-shared public key and then working with self-signed 
certificates is a problem which isn't solveable.

> > > When someone runs newrole from a session launched by a
> > > subverted sshd then their password can be captured and it's game-over.
> > At least in default setup, newrole is checked with securetty. But most
> > want to have a way to be sysadm. So, there has to be another solution.
> > And I think there is. The user_t tasks are secured by those attacks. Only
> > sending password's over the ssh channel is a problem. So what can be
> > done, is a callback. You use a program which opens a tcp socket back to
> > the client. This program runs under user_t and can be trusted by the
> > user. The user
> If a trojan sshd subverts the session then nothing that is launched from it
> can be trusted by the user.
You got the answer yourself in the next paragraph.

> Of course if the user launches a program that needs a secret key, and if
> that secret key is only available to a program that runs in a different
> domain, and if the user_t domain is denied access to do the
> network-callback functionality then it might be OK.  But that just means
> that they have the same issue of cracking this callback program as with
> cracking ssh, with the additional risk that when using a program that is
> used by few people it won't get the testing and analysis that sshd gets.
This program could be official distributed. Yes, it could be vulnerable on 
it's own, but it would be much harder. It is only called on request. It 
always uses a different port. The port would only take packets from the right 
source ip. The chance to have the right port pair, on the right host, with 
the right spoofed source ip is minimal.

> > > However this requires that the sshd be subverted without anyone
> > > noticing, and the example of the movie was very noticable.  ;)
> > In the movie, OK. But I thought more about the problem in reality, or
> > that what we think is our reality, than the movie. And there it's a
> > somewhat complex problem of trust, which could be solved, or at least be
> > reduced.
> It's a very complex problem which can't be totally solved.
OK, solved is a little to much. Let's say it can be reduced. I think it's 
important to give administrators enough time to react. It should be enough 
time to find the source of the attack and hopefully send them the men in 
green with personal transport to jail.

>  This is why
> organizations that want really serious security don't allow people to login
> from outside to do important work.  ;)
The question is always what's important for whom? Some weeks ago I used telnet 
(no ssh avalaible) to access my domain account at my provider. The asked all 
customers to backup the mysql database. Some database backups where 644 in 
/tmp. I haven't looked into them, but when I see 120MB compressed, I'm sure 
there is data, which their customers like to be kept secure.
As far as I see, most companies protect their own data, but not the data of 
their customers. They let their employers do teleworking without being able 
to protect the data. I'm trying to find a way to change this. I'd like to 
connect many peers, fairly secure, in the internet. I can't make this 
impossible. But it's also not impossible to go in most companies, claim to 
have an appointment or to repair something, and get the data directly. I 
think a good secured peer network can be much more secure, with the security 
functions already there. We have type enforcement, we have firewalls, we have 
encryption and signing and all those things. It's mostly not used or used 
wrong. It's to hard to use it, because it's not really integrated into 
standard distributions.

Regards
	Torsten
- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yl6QvxZktkzSmiwRAhucAJ4yYgX8eDS3rlb+k0pLK/3GXeOLMACbBRTO
4pIg6vjmy0HSNDxNjbkt7WU=
=FwuA
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
