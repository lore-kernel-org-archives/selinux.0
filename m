Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB23V8Rb012063
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 22:31:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB23USp5000757
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 03:30:28 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB23URt0000754
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 03:30:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Date: Tue, 2 Dec 2003 14:30:51 +1100
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil> <20031201202813.I16359@lemuria.org>
In-Reply-To: <20031201202813.I16359@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312021430.51186.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Dec 2003 06:28, Tom <tom@lemuria.org> wrote:
> It seems that in the long run we won't be able to do with a single
> default policy. We'll need a couple, or a modular approach. Something
> very much like Debian's tasksel or other tools for other distributions
> where you have 5-10 fields you can check what your machine is going to
> be, and the relevant policy is then assembled automatically.

I also see a need for multiple policy distributions, but I don't think that 
they will be close enough to each other to enable them to productively be in 
the same tree.

Some policy files such as core_macros.te can be in all policies, but most of 
the .te files won't.

I think that policies will either be close enough that macros can be used to 
merge them, or different enough that they can't be kept to gether in any way.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
