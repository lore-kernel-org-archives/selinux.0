Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DMxpRb025320
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 18:59:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3DMvmUZ015234
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 22:57:48 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i3DMvkmT015201
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 22:57:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Policy backward compatibility
Date: Wed, 14 Apr 2004 08:58:24 +1000
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil> <1081862565.21530.56.camel@moss-spartans.epoch.ncsc.mil> <1081863227.21530.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1081863227.21530.69.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404140858.24574.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Apr 2004 23:33, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2004-04-13 at 09:22, Stephen Smalley wrote:
> > And, yes, this will require separate policy.conf files for the different
> > versions, but that is going to be necessary anyway for significant
> > changes to the policy.  Even for the netlink class partitioning, you
> > don't want to compile a newer policy.conf that has the fine-grained
> > netlink classes with an older checkpolicy, as the best it could do would
> > be to map them all to the old netlink class, possibly opening up
> > unintended access.
>
> And likewise for any significant use of booleans, since the
> compatibility code just discards the conditional statements entirely
> rather than generating statements based on the initial boolean value...

Yes, this is why I haven't written any policy to make significant use of 
booleans.  I haven't yet upgraded all machines I use to the latest policy 
(and still have some machines that can't run 2.6).

Maybe we need a policy.conf.15 and policy.conf.16 etc?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
