Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OH15x6003906
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 12:01:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OGvXlY001408
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:57:33 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2OGvUKX001400
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:57:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Vance <cvance@tislabs.com>
Subject: Re: essential patches
Date: Mon, 24 Mar 2003 18:00:48 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0303241009180.31241-100000@zorg.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0303241009180.31241-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303241800.48962.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Mar 2003 16:33, Chris Vance wrote:
> It seems that the errors you are seeing is a conflict with the concept of
> "Core" policy and attempting to create a policy that provides least
> privilege.  It's very difficult to have a policy that provides only "core"
> services yet is usable as a general-purpose machine.

No, the errors I am seeing are a result of the policy being so complex that 
it's beyond the ability of any small group of people to fully test it, so any 
removal of allow rules is likely to result in some breakage before it has 
gone through some public testing.

> For example, the dhcpd domain was removed from the core policy, so
> natually, it will fail to run correctly under a least privilege policy.
> By removing domains from the core policy, programs may fail to transition
> as you would like them to. In the case of ifconfig/dhclient, the
> transition no longer occurs -- but this does not imply that all
> permissions required by dhcpc_t should now be rolled into the policy for
> ifconfig.

I am aware of this.  I intentionally installed the dhcpc.te file in my policy 
as mentioned twice in my email.

The issue is not something inherantly specific to dhcpc_t, the issue is that 
ifconfig lost some functionality and that dhclient was one (of potentially 
many) programs that rely on such functionality.

Of course you could add ifconfig_t allow rules to dhcpc.te, pump.te, etc.  But 
it would probably be best to just add it to ifconfig.te.

> > user_t needs search access to /boot and read access to the system.map
> > files for the wchan.
>
> It's a matter of opinion, I would think that the system.map files contains
> privileged information that should be protected.  Again, what programs (in
> core) require access?  If there is a special program that requires access,
> why is it not in a special domain that has access rather than allowing all
> of user_t?

Why are the system.map files in a different type then?  If we aren't going to 
allow ps to access them then the only use for them is for ksymoops, in which 
case we may as well leave them in boot_t.

Also in that case we don't need the Red Hat symlink to be created on boot 
(ksymoops knows how to find the right system.map file) and therefore we can 
stop giving initrc_t write access to /boot (I don't particularly like 
granting startup scripts access to change my boot configuration).

> > Many programs in user_t request read access to sysctl_kernel_t dir and
> > file, and for var_lib_t.  We could probably survive without
> > sysctl_kernel_t, but var_lib_t access is essential to many programs
> > (particularly some perl scripts used for Debian package building).  If we
> > deny this then we need to add some new types for the things that should
> > be allowed.
>
> Sorry, I'm not familiar with the Debian package manager, but if it needs
> special access, then yes, it should run in another new domain.  The core
> policy cannot be all things to all people and all systems.

I have just done further testing (my initial testing was a rushed effort to 
try and get things going again).  It seems that access to the directory is 
needed to gain access to a Debian specific sub-directory and I can't 
duplicate the situation that required file access.  So I agree with you on 
this.

> > For random_device_t writing by a hostile user apparently does no harm
> > according to all the best sources of information available to me.  There
> > are probably some people on this list who know more about cryptology than
> > the people who wrote the /dev/random code for Linux.  If an expert
> > decrees that we should not allow write access then I'll accept that.  As
> > for read access, too many programs break when user_t can't access it, EG
> > all SSL clients...
>
> What programs require write access to the random device?  I'm certainly no
> expert, but I tend not to add unjustified permissions simply because it
> _seems_ to do no harm.

Fair comment regarding write access.  OK, I'll change it to read-only in my 
tree.

> Perhaps ssl clients should be running in a more
> restrictive domain - don't they also require access to privileged
> information, such as private keys?  Why run them directly in the user
> domain?

SSL clients don't require any special access to files or other local 
resources.  Consider an SSL web browser, it does not require any special 
access to files on disk (netscape runs in a separate domain to intentionally 
give it LESS access to files because of it's history).  But for a web browser 
to actually provide a benefit from SSL then it needs a source of good random 
numbers.  I recall an attack against an early version of Netscape which 
didn't generate pseudo-random numbers well enough.

SSL is used for POP, IMAP, FTP, HTTP, and probably other protocols.  Currently 
apart from Netscape/Mozilla we don't have special domains for any of the 
clients for those protocols.

> > I've tried the current CVS policy on a few machines with different
> > configurations and they all failed to work correctly on several counts.
>
> I've tried the current CVS policy on a few machines and all boot in
> enforcing mode and allow limited operation (limited, since this is a
> core-only policy).

My understanding is that the idea of a core policy is that it will contain the 
base that you add other policy modules on to.  If it can't do that (IE if you 
have to change the core policy every time you add a new policy module) then 
the core is broken.

There are more useful limitations that could be put in the core which would 
probably be less painful:
Prevent sysadm_t from reading symlinks from untrusted users (along with a 
special policy for ls to allow sysadm_t to see what the links are).

Support for multiple run_init type programs to allow delegating daemon 
start/stop permissions for some daemons (IE the database administrator can 
re-start the database).  I've already done more than half the work for 
this...

We have to keep a balance between security and usability though if we want SE 
Linux to become popular.  My tree will continue to be usable by most people 
without too much pain, regardless of what is done with the NSA tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
