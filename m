Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91E5fsJ025271
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 10:05:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91E3qZt001865
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 14:03:52 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h91E3pM3001855
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 14:03:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: assertions in kernel
Date: Thu, 2 Oct 2003 00:05:27 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310012233.24193.russell@coker.com.au> <1065016709.350.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065016709.350.54.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310020005.27385.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003 23:58, Stephen Smalley wrote:
> On Wed, 2003-10-01 at 08:33, Russell Coker wrote:
> > I think that this approach does not work.  I think that to maintain sane
> > state of the file system labeling we need to have some rules in the
> > kernel, if those rules are violated (either on first access after boot or
> > when a new policy load changes the rules) then the filesystem object gets
> > relabeled to unlabeled_t.  Then setfiles only needs relabelfrom access to
> > unlabeled_t to be able to fix all manner of file system stuff-ups.
>
> The existing assertion checking support is likely to migrate into the
> kernel in the future to allow a base set of assertions to be applied to
> subsequent attempts to load policy modules.

But will it be enhanced to implement more functionality than is possible in 
checkpolicy?

Assertions such as "neverexist root_t:file;" are not possible in 
checkpolicy...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
