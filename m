Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k483GcWt008862
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 23:16:38 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k483GaiA007331
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 03:16:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: pam_namespace
Date: Mon, 8 May 2006 11:37:38 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200605051623.25533.russell@coker.com.au> <200605051006.k45A6vNK024699@turing-police.cc.vt.edu> <200605071928.22799.russell@coker.com.au>
In-Reply-To: <200605071928.22799.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605081137.42066.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 07 May 2006 19:28, Russell Coker <russell@coker.com.au> wrote:
> Of course there's nothing stopping us from modifying a program such as
> runuser or run_init to set up a namespace for a daemon.  In fact we should
> probably make the default behavior of run_init and runuser be the creation
> of a namespace.  It would be easy to create a config file for runuser that
> allows excluding daemons on the basis of executable name, UID, or other
> factors.

One problem we have with separate name spaces is that when the administrator 
mounts a file system the users won't see it.  When the mount point has 
the "user" option in /etc/fstab that won't be such a problem, but for the 
more common cases of autofs and the automatic mounting we have in Fedora 
that's not going to work.

As we want to provide as much protection as possible for as many users as 
possible it seems to me that for a typical targeted-policy system we would 
want to run daemons in their own name-space while leaving users in the system 
name-space.  It would not be difficult to modify runuser such that it could 
check for a domain_auto_trans() operation on launching a daemon (assuming 
that the runuser command in question runs the daemon directly instead of 
running a startup script) and then by default create a separate name space 
for every daemon that is confined in the targeted policy (which is probably a 
good list of daemons that may potentially become compromised and be used to 
attack users).

Having such separate name-spaces for daemons that run as non-root allows 
protecting users from attack while avoiding the usability issues of 
namespaces for each user.  This is a good match the design philosophy of the 
targeted policy.

For daemons such as xfs, we could have runuser set up a bind mount of the 
sub-directory of the /tmp directory that is used.  So /tmp/.font-unix could 
be bind mounted into the name-space of the xfs daemon.  Incidentally at the 
moment xfs is not started by runuser, so with my rough design outlined above 
it would not get a separate name-space.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
