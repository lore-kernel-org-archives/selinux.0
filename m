Message-Id: <200411261923.iAQJNVPF010564@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions 
In-Reply-To: Your message of "Fri, 26 Nov 2004 14:28:28 +1100."
             <200411261428.31379.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <4182959B.4080503@trustedcs.com> <200411260649.01922.russell@coker.com.au> <20041125213519.GD26737@lkcl.net>
            <200411261428.31379.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1425849447P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 26 Nov 2004 14:23:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1425849447P
Content-Type: text/plain; charset=us-ascii

On Fri, 26 Nov 2004 14:28:28 +1100, Russell Coker said:

> A current problem we have is that init.d scripts often don't check that they 
> are killing the process that they think they are killing.  We can make them 
> check for the executable in some cases, but that isn't always possible and 
> has some complications (EG if the executable gets replaced while the daemon 
> is running).

Been there, done that (though not an init script).  Once had a sporadic problem
where I'd log in and my window manager would evaporate.  Finally traced it down
to launching 'fetchmail' - which would launch itself into the background if
one wasn't running, and tell the running one to start a new pass if it was.

It basically did a 'if !(kill -HUP `cat ~/.fetchmail.pid`) fork_into_bg();'
which would get ugly if *this* login's window manager had the same pid as
the *previous* boot's fetchmail (and since 'fetchmail' was started about the
same time each time, the two processes usually got PID's within 10 or 20 of
each other....)

> One possibility is to have a daemon killing process that 
> checks /proc/`cat /var/run/daemon.pid`/attr/current and then queries the 
> kernel as to whether the domain specified can create a file of the type of 
> the file /var/run/daemon.pid.  However this has a race condition in that the 
> daemon could potentially die and be replaced by another process in a 
> different domain.

I take it you're worried that we could start the check, the process exit, and
then the next fork() wins the russian roulette by re-using that PID?

Probably this would be best addressed by a general overhaul of the entire
PID-allocation scheme (in particular, there's some bogosity in the /proc code
that restricts us to some 64K PIDs on 32-bit machines). If the effective space
was 24 or 32 bits rather than 16, there'd be a lot less worry about a race
condition there.  However, we can probably cheat and as the first step of our
check, peek at the current value of last_pid in kernel/pid.c, and see if it's
"close" to our target.

Of course, if you're on a fork()-bound system where last_pid can increment by
more than 10 or 20 during our check, or if you have a kernel patch that randomizes
the next_pid, that cheat won't work... 

> Another thing I was considering regarding such issues is to have booleans 
> around the fork permission for every domain that's a likely candidate for a 
> DOS attack (eg user_t).  Then if a user tries to DOS the machine we can flip 
> the boolean before killing the processes and disabling the account.  Sure it 
> would be a bummer for the innocent users who were also in user_r, but that's 
> DOS attacks for you...

It *does* have its appeal, for stopping those fork bombs that cripple the box
while remaining under the 'ulimit -u' value.  Fortunately, the collateral
damage for other user_r processes is probably fairly low, because we can
flip the boolean, kill the offending list while they're not able to fork() and
generate new PIDs, and unset the boolean again.  So the only victims are those
user_r that tried to fork() during the several seconds the boolean was set - so
unless they were doing a 'make' or other fork-happy program, they probably won't
even HIT that window.  And if they *did*, their fork() would probably have
died *anyhow* due to the fork bomb chewing up resources.


--==_Exmh_-1425849447P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBp4KzcC3lWbTT17ARAqzKAJ9cCzEfJCzcFdnO2uV217nSFP9MKQCgp0IT
ha+s5j/EmsQ60z551ysdbNw=
=iL5Q
-----END PGP SIGNATURE-----

--==_Exmh_-1425849447P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
