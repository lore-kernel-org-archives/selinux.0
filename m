From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: dynamic context transitions
Date: Fri, 26 Nov 2004 14:28:28 +1100
Cc: SELinux List <SELinux@tycho.nsa.gov>
References: <4182959B.4080503@trustedcs.com> <200411260649.01922.russell@coker.com.au> <20041125213519.GD26737@lkcl.net>
In-Reply-To: <20041125213519.GD26737@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411261428.31379.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 November 2004 08:35, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> On Fri, Nov 26, 2004 at 06:48:57AM +1100, Russell Coker wrote:
> > If a running process has been cracked and does not have the same PID as
> > the original copy then the stop script will not stop it.
>
>  i don't know if it's worthwhile but has anyone given serious
>  consideration to adding the pid into the selinux mix as a
>  permission to check operations against? (requiring that a pid
>  somehow be stored at runtime in the selinux policy of course).

I don't think that would be a good idea.

However it would be useful to be able to specify the domain that a signal can 
be sent to.

A current problem we have is that init.d scripts often don't check that they 
are killing the process that they think they are killing.  We can make them 
check for the executable in some cases, but that isn't always possible and 
has some complications (EG if the executable gets replaced while the daemon 
is running).

One possibility is to have a daemon killing process that 
checks /proc/`cat /var/run/daemon.pid`/attr/current and then queries the 
kernel as to whether the domain specified can create a file of the type of 
the file /var/run/daemon.pid.  However this has a race condition in that the 
daemon could potentially die and be replaced by another process in a 
different domain.

Another thing I was considering regarding such issues is to have booleans 
around the fork permission for every domain that's a likely candidate for a 
DOS attack (eg user_t).  Then if a user tries to DOS the machine we can flip 
the boolean before killing the processes and disabling the account.  Sure it 
would be a bummer for the innocent users who were also in user_r, but that's 
DOS attacks for you...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
