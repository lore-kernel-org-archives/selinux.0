Message-Id: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <russell@coker.com.au>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 14 Apr 2004 10:53:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200404142338.51788.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> > Why is a reboot required?
> 
> If we have a tunable option to determine which domain processes run in
> (such
> as single_userdomain) or a tunable that determines the identity that
> daemons
> get (such as direct_sysadm_daemon) then restarting processes is necessary.
> Some people find it difficult to do this successfully and find it easier
> to
> do a reboot.
> 

Sure.

> 
> The advantages of booleans are clear IMHO.  But they don't seem applicable
> to
> something that will be set at install time on a system that is capable of
> building a policy.  Maybe for an iPaQ booleans for tunable options would
> be
> good.  For a desktop or server they seem to offer less benefits.
> 

If it is only set at install time, then maybe tunables.te makes sense.

> Finally, for booleans both options have to be in the policydb and in the
> kernel at run-time.  For tunable.te they aren't, and can significantly
> reduce
> the policy size.
> 

Again, if this is truly only set at install time this might be true. I'm not
convinced that these things will only be set at install time, though, and in
that case I think it might make sense to use the booleans. Also, the size
overhead may be preferable to requiring administrators to build policy from
source.

Karl

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
